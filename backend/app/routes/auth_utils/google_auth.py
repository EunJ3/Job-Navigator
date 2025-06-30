"""
sequenceDiagram
  participant User as 👤 사용자
  participant Front as 🖥️ Frontend (React)
  participant Google as 🔐 Google 인증 서버
  participant Back as ⚙️ Backend (FastAPI)

  1: User->>Front: "Google로 로그인" 버튼 클릭
  2: Front(GET)->>Google: Google SDK로 OAuth2 로그인 요청
  3: Google(GET)->>Front: id_token 반환 → `const id_token = response.credential`
  4: Front(POST)->>Back: /api/v1/auth/google-login\n{id_token_str: id_token}
  5: Back->>Google: id_token.verify_oauth2_token(id_token_str, ..., GOOGLE_CLIENT_ID)
  6: Google-->>Back: 사용자 정보 반환 → `id_info`
  7: Back->>Back: 
      user_info = {
        social_id: id_info.sub,
        email: id_info.email,
        ...
      }
  7: Back->>Back: 
      user = db.query(User).filter(...).first()
      (or 신규 생성 후 commit)
  8: Back->>Back: 
      token = create_access_token(data={"user_id": user.user_id}, ...)
  9: Back->>Front: 사용자 정보 + access_token 반환 (JSON 응답)
"""

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from datetime import timedelta
import logging

from pydantic import BaseModel
from google.oauth2 import id_token
from google.auth.transport import requests as google_requests

from app.core.database import get_db
from app.schemas.user import UserResponse
from app.routes.auth_utils.jwt_utils import create_access_token
from app.services.user_service import get_or_create_user
from app.core.config import get_google_client_id, get_access_token_expiry_minutes

# 라우터 생성
router = APIRouter()

# 환경 변수 설정 (config.py에서 불러옴)
GOOGLE_CLIENT_ID = get_google_client_id()
ACCESS_TOKEN_EXPIRE_MINUTES = get_access_token_expiry_minutes()

# 로깅 설정
logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO)

# ✅ 프론트에서 전달받는 요청 스키마
class GoogleLoginRequest(BaseModel):
    id_token_str: str


def get_google_user_info(id_token_str: str) -> dict:
    """
    5~6단계: Google에서 발급한 ID 토큰을 검증하고 사용자 정보를 추출합니다.

    Parameters:
        id_token_str (str): 프론트엔드에서 전달받은 Google ID 토큰 문자열

    Returns:
        dict: 사용자 정보 (Google 고유 ID, 이메일, 이름, 프로필 이미지 포함)
    """
    try:
        logger.info("🔍 [5] Google ID 토큰 검증 시작")
        id_info = id_token.verify_oauth2_token(
            id_token_str,
            google_requests.Request(),
            GOOGLE_CLIENT_ID,
        )
        logger.info("✅ [6] Google ID 토큰 검증 성공")

        return {
            "social_id": id_info["sub"],             # Google 고유 사용자 ID
            "email": id_info["email"],               # 사용자 이메일
            "name": id_info.get("name"),             # 사용자 이름
            "profile_image": id_info.get("picture"), # 프로필 이미지 URL
        }

    except ValueError as e:
        logger.error(f"❌ Google 토큰 검증 실패: {e}")
        raise HTTPException(status_code=400, detail="Invalid Google token")


@router.post("/google-login", response_model=UserResponse)
def google_login(request: GoogleLoginRequest, db: Session = Depends(get_db)):
    """
    4~8단계: Google ID 토큰을 검증하여 로그인 처리를 수행합니다.
    신규 사용자인 경우 DB에 회원가입 처리 후 JWT 토큰을 발급합니다.

    Parameters:
        request (UserCreate): 프론트에서 전달받은 id_token_str 포함 객체
        db (Session): FastAPI 종속성 주입된 DB 세션

    Returns:
        UserResponse: 사용자 정보 + JWT access_token 포함한 응답
    """
    logger.info("🚀 [4] Google 로그인 요청 수신")

    # [5~6] Google에서 전달받은 토큰으로 사용자 정보 추출
    user_info = get_google_user_info(request.id_token_str)

    # [7] get_or_create_user 호출
    user = get_or_create_user(db, user_info = user_info, social_provider="google")

    # [8] JWT access_token 발급 (auth_utils.py)
    token = create_access_token(
        data={"user_id": user.user_id},
        expires_delta=timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES),
    )
    logger.info(f"🎫 JWT 발급 완료 - user_id: {user.user_id}")

    # [9] 사용자 정보 + 토큰 반환
    return {
        "user_id": user.user_id,
        "social_provider": user.social_provider,
        "social_id": user.social_id,
        "email": user.email,
        "name": user.name,
        "profile_image": user.profile_image,
        "is_active": user.is_active,
        "created_at": user.created_at,
        "access_token": token,
    }
