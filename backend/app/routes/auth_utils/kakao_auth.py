"""
sequenceDiagram
  participant User as 👤 사용자
  participant Front as 🖥️ Frontend (React)
  participant Kakao as 🔐 Kakao 인증 서버
  participant Back as ⚙️ Backend (FastAPI)

  1: User->>Front: "카카오로 로그인" 버튼 클릭
  2: Front(GET)->>Kakao: 인가코드 요청 (OAuth2)
  3: Kakao(GET)->>Front: 인가코드 반환 → request.code
  4: Front(POST)->>Back: /api/v1/auth/kakao-login\n{code: request.code}
  5: Back->>Kakao: access_token 요청 (client_id, redirect_uri, code 포함)
  6: Kakao-->>Back: access_token 반환 → access_token
  7: Back->>Kakao: access_token으로 사용자 정보 요청
  8: Kakao-->>Back: 사용자 정보 반환 → user_info
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

from app.core.database import get_db
from app.routes.auth_utils.jwt_utils import create_access_token
from app.core.config import (
    get_kakao_client_id,
    get_kakao_redirect_uri,
    get_access_token_expiry_minutes,
)
from app.services.user_service import get_or_create_user 

router = APIRouter()

# 환경 변수 로딩
KAKAO_CLIENT_ID = get_kakao_client_id()
KAKAO_REDIRECT_URI = get_kakao_redirect_uri()
ACCESS_TOKEN_EXPIRE_MINUTES = get_access_token_expiry_minutes()

# 로깅 설정
logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO)


class KakaoLoginRequest(BaseModel):
    code: str


async def get_kakao_user_info(code: str) -> dict:
    """
    5~8단계: 카카오 인가코드를 통해 사용자 정보를 조회하여 딕셔너리로 반환
    """
    token_url = "https://kauth.kakao.com/oauth/token"
    token_data = {
        "grant_type": "authorization_code",
        "client_id": KAKAO_CLIENT_ID,
        "redirect_uri": KAKAO_REDIRECT_URI,
        "code": code,
    }

    async with httpx.AsyncClient() as client:
        # [5] access_token 요청
        token_res = await client.post(token_url, data=token_data)
        if token_res.status_code != 200:
            logger.error("❌ [5] access_token 요청 실패")
            raise HTTPException(status_code=400, detail="Failed to get Kakao token")

        token_json = token_res.json()  # ✅ await 제거
        access_token = token_json.get("access_token")
        logger.info("✅ [6] access_token 발급 성공")

        # [7] 사용자 정보 요청
        profile_res = await client.get(
            "https://kapi.kakao.com/v2/user/me",
            headers={"Authorization": f"Bearer {access_token}"}
        )
        if profile_res.status_code != 200:
            logger.error("❌ [7] 사용자 정보 요청 실패")
            raise HTTPException(status_code=400, detail="Failed to get Kakao user info")

        profile = profile_res.json()  # ✅ await 제거
        kakao_id = str(profile["id"])
        kakao_account = profile.get("kakao_account", {})
        email = kakao_account.get("email", f"{kakao_id}@kakao.com")
        name = kakao_account.get("profile", {}).get("nickname", "Kakao User")
        profile_image = kakao_account.get("profile", {}).get("profile_image_url", "")

        logger.info(f"✅ [8] 사용자 정보 조회 완료: {email}")

        return {
            "social_id": kakao_id,
            "email": email,
            "name": name,
            "profile_image": profile_image,
        }


@router.post("/kakao-login")
async def kakao_login(request: KakaoLoginRequest, db: Session = Depends(get_db)):
    """
    4~11단계: 카카오 인가코드를 받아 로그인/회원가입 처리 후 JWT 토큰 반환
    """
    logger.info("🚀 [4] 카카오 로그인 요청 수신")

    # [5~8] 사용자 정보 추출
    user_info = await get_kakao_user_info(request.code)

    # [9] 사용자 조회 or 생성
    user = get_or_create_user(db, user_info=user_info, social_provider="kakao")

    # [10] JWT 발급
    token = create_access_token(
        data={"user_id": user.user_id},
        expires_delta=timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES),
    )
    logger.info(f"🎫 JWT 발급 완료 - user_id: {user.user_id}")

    # [11] 사용자 정보 + 토큰 반환
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
