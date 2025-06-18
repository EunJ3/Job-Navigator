# 소셜 로그인 API 및 JWT 발급 처리
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from google.oauth2 import id_token
from google.auth.transport import requests as google_requests
from datetime import datetime, timedelta
from jose import jwt
import os

from app.core.database import SessionLocal
from app.models.user import User, UserCreate, UserResponse

GOOGLE_CLIENT_ID = os.getenv("GOOGLE_CLIENT_ID")
JWT_SECRET_KEY = os.getenv("JWT_SECRET_KEY")
JWT_ALGORITHM = os.getenv("JWT_ALGORITHM")
ACCESS_TOKEN_EXPIRE_MINUTES = int(os.getenv("ACCESS_TOKEN_EXPIRE_MINUTES"))

router = APIRouter()


# DB 세션 생성
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


# JWT 토큰 생성 함수
def create_access_token(data: dict, expires_delta: timedelta = None):
    to_encode = data.copy()
    expire = datetime.utcnow() + (expires_delta or timedelta(minutes=15))
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, JWT_SECRET_KEY, algorithm=JWT_ALGORITHM)
    return encoded_jwt


# Google 로그인 엔드포인트
@router.post("/google-login", response_model=UserResponse)
def google_login(request: UserCreate, db: Session = Depends(get_db)):
    try:
        id_token_str = request.id_token_str

        # 구글 ID 토큰 검증
        id_info = id_token.verify_oauth2_token(
            id_token_str, google_requests.Request(), GOOGLE_CLIENT_ID
        )

        # 구글 유저 정보 추출
        social_provider = "google"
        social_id = id_info["sub"]
        email = id_info["email"]
        name = id_info.get("name")
        profile_image = id_info.get("picture")

        # DB에서 기존 유저 확인
        user = (
            db.query(User)
            .filter(
                User.social_id == social_id, User.social_provider == social_provider
            )
            .first()
        )

        # 신규 유저 회원가입 처리
        if not user:
            new_user = User(
                social_provider=social_provider,
                social_id=social_id,
                email=email,
                name=name,
                profile_image=profile_image,
                is_active=True,
            )
            db.add(new_user)
            db.commit()
            db.refresh(new_user)
            user = new_user

        # JWT 발급
        token = create_access_token(
            data={"user_id": user.user_id},
            expires_delta=timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES),
        )

        # 응답 반환
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

    except ValueError:
        raise HTTPException(status_code=400, detail="Invalid Google token")
