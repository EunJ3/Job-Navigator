# 📄 backend/app/routes/auth/naver_auth.py
"""
sequenceDiagram
  participant User as 👤 사용자
  participant Front as 🖥️ Frontend (React)
  participant Naver as 🔐 Naver 인증 서버
  participant Back as ⚙️ Backend (FastAPI)

  1: User->>Front: "네이버로 로그인" 버튼 클릭
  2: Front(GET)->>Naver: 인가코드 요청 (OAuth2)
  3: Naver(GET)->>Front: 인가코드 반환 → request.code, request.state
  4: Front(POST)->>Back: /api/v1/auth/naver-login\n{code, state}
  5: Back->>Naver: access_token 요청 (client_id, client_secret, code, state 포함)
  6: Naver-->>Back: access_token 반환
  7: Back->>Naver: access_token으로 사용자 정보 요청
  8: Naver-->>Back: 사용자 정보 반환 → user_info
  9: Back->>Back: DB에서 사용자 조회 또는 신규 생성
 10: Back->>Back: create_access_token(data={"user_id": user.user_id})
 11: Back-->>Front: 사용자 정보 + access_token 반환
"""
from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel
from sqlalchemy.orm import Session
from datetime import timedelta
import httpx
import logging

# 📦 DB 세션 및 JWT 유틸리티, 설정값, 유저 서비스 함수 임포트
from app.core.database import get_db
from app.routes.auth_utils.jwt_utils import create_access_token
from app.core.config import (
    get_naver_client_id,
    get_naver_client_secret,
    get_naver_redirect_uri,
    get_access_token_expiry_minutes,
)
from app.services.user_service import get_or_create_user

# 🔀 네이버 인증 전용 라우터 생성
naver_router = APIRouter()

# 🔐 네이버 OAuth 설정값 불러오기
NAVER_CLIENT_ID = get_naver_client_id()
NAVER_CLIENT_SECRET = get_naver_client_secret()
NAVER_REDIRECT_URI = get_naver_redirect_uri()
ACCESS_TOKEN_EXPIRE_MINUTES = get_access_token_expiry_minutes()

# 📝 로깅 설정
logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO)

# 📨 네이버 로그인 요청 바디 형식 정의
class NaverLoginRequest(BaseModel):
    code: str   # 인가 코드
    state: str  # 상태 토큰(CSRF 방지용)

# 🔍 네이버 API에서 사용자 정보 조회
async def get_naver_user_info(code: str, state: str) -> dict:
    """
    네이버 인가 코드를 바탕으로 access_token을 요청하고,
    해당 access_token으로 사용자 정보를 반환받아 가공합니다.
    """
    token_url = "https://nid.naver.com/oauth2.0/token"
    token_params = {
        "grant_type": "authorization_code",
        "client_id": NAVER_CLIENT_ID,
        "client_secret": NAVER_CLIENT_SECRET,
        "code": code,
        "state": state,
        "redirect_uri": NAVER_REDIRECT_URI,
    }

    async with httpx.AsyncClient() as client:
        # 🔐 access_token 요청
        token_res = await client.post(
            token_url,
            data=token_params,
            headers={"Content-Type": "application/x-www-form-urlencoded"}
        )
        if token_res.status_code != 200:
            raise HTTPException(status_code=400, detail="Failed to get Naver token")

        token_json = token_res.json()
        access_token = token_json.get("access_token")
        if not access_token:
            raise HTTPException(status_code=400, detail="access_token 없음")

        # 👤 사용자 프로필 요청
        profile_res = await client.get(
            "https://openapi.naver.com/v1/nid/me",
            headers={"Authorization": f"Bearer {access_token}"}
        )
        if profile_res.status_code != 200:
            raise HTTPException(status_code=400, detail="Failed to get Naver user info")

        profile = profile_res.json().get("response", {})

        # 🧩 사용자 정보 파싱 (필수 필드가 없는 경우 기본값 지정)
        naver_id = str(profile.get("id"))
        email = profile.get("email", f"{naver_id}@naver.com")
        name = profile.get("name", "Naver User")
        profile_image = profile.get("profile_image", "")

        return {
            "social_id": naver_id,
            "email": email,
            "name": name,
            "profile_image": profile_image,
        }

# ✅ 네이버 로그인 API 엔드포인트
@naver_router.post("/naver-login")
async def naver_login(request: NaverLoginRequest, db: Session = Depends(get_db)):
    """
    프론트엔드에서 전달받은 인가코드(code)와 상태값(state)을 통해
    - 사용자 정보를 조회하고
    - DB에 유저를 생성 또는 조회한 후
    - JWT 액세스 토큰을 발급하여 반환합니다.
    """
    # 🔍 네이버에서 사용자 정보 가져오기
    user_info = await get_naver_user_info(request.code, request.state)

    # 🗂️ 유저 생성 또는 조회 (social_id 기준)
    user = get_or_create_user(db, user_info=user_info, social_provider="naver")

    # 🔐 JWT 액세스 토큰 생성
    token = create_access_token(
        data={"user_id": user.user_id},
        expires_delta=timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES),
    )

    # 📤 사용자 정보 + JWT 토큰 반환
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

# 📡 라우터 등록 (외부에서 import 시 사용)
router = naver_router
