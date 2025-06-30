#backend/routes/auth_utils/jwt_utils.py

"""
📌 JWT 토큰 발급 및 인증 흐름 시퀀스 다이어그램

sequenceDiagram
  participant Front as 🖥️ Frontend (React)
  participant Back as ⚙️ Backend (FastAPI)
  participant DB as 🗄️ Database

  1: Front(POST)->>Back: 로그인 성공 후 → create_access_token(data)
  2: Back->>Back: JWT 생성 및 만료시간(exp) 설정 → encode()
  3: Back->>Front: access_token 응답

  4: Front(GET)->>Back: 인증이 필요한 API 호출 (Authorization: Bearer access_token)
  5: Back->>Back: jwt.decode(access_token) → user_id 추출
  6: Back->>DB: DB에서 user_id로 사용자 조회
  7: Back->>Front: 사용자 정보 반환 (or 401 Unauthorized)
"""

from datetime import datetime, timedelta
from jose import jwt, JWTError
from fastapi import HTTPException, Depends
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.orm import Session
import os
import logging

from app.core.database import get_db
from app.models.user import UserORM
from app.core.config import (
    get_jwt_secret_key,
    get_jwt_algorithm,
    get_access_token_expiry_minutes,
)

# ✅ 로깅 설정
logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO)

# ✅ 환경변수 설정
JWT_SECRET_KEY = get_jwt_secret_key()
JWT_ALGORITHM = get_jwt_algorithm()
ACCESS_TOKEN_EXPIRE_MINUTES = get_access_token_expiry_minutes()

# ✅ OAuth2 스키마 설정
# ⚠️ 실제 사용 안함. FastAPI docs에서 Authorize 버튼 생성을 위한 용도임
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/api/v1/auth/google-login")


def create_access_token(data: dict, expires_delta: timedelta = None) -> str:
    """
    JWT 액세스 토큰을 생성합니다.

    Parameters:
        data (dict): 토큰에 인코딩할 사용자 정보 (ex. {"user_id": 1})
        expires_delta (timedelta): 만료 시간 설정 (기본: 환경변수 또는 10분)

    Returns:
        str: JWT 토큰 문자열
    """
    to_encode = data.copy()
    expire = datetime.utcnow() + (expires_delta or timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES))
    to_encode.update({"exp": expire})

    token = jwt.encode(to_encode, JWT_SECRET_KEY, algorithm=JWT_ALGORITHM)
    logger.info(f"🎫 JWT 토큰 생성 완료 - user_id: {data.get('user_id')}, 만료시각: {expire.isoformat()}")
    return token


def get_current_user(token: str = Depends(oauth2_scheme), db: Session = Depends(get_db)) -> UserORM:
    """
    요청 헤더의 JWT 토큰을 기반으로 현재 로그인한 사용자 정보를 반환합니다.

    Parameters:
        token (str): Authorization 헤더에 포함된 JWT
        db (Session): DB 세션

    Returns:
        User: 로그인된 사용자 객체

    Raises:
        HTTPException: 토큰이 유효하지 않거나 사용자가 존재하지 않는 경우
    """
    try:
        logger.info(f"🪪 수신된 토큰: {token}")
        logger.info("🔍 JWT 디코딩 시도")
        payload = jwt.decode(token, JWT_SECRET_KEY, algorithms=[JWT_ALGORITHM])
        user_id = payload.get("user_id")
        logger.info(f"✅ JWT 디코딩 성공 - user_id: {user_id}")

        if user_id is None:
            logger.warning("⚠️ 토큰에 user_id가 없음")
            raise HTTPException(status_code=401, detail="유효하지 않은 토큰입니다.")

        user = db.query(UserORM).filter(UserORM.user_id == user_id).first()
        if user is None:
            logger.warning(f"⚠️ 사용자(user_id={user_id})를 DB에서 찾을 수 없음")
            raise HTTPException(status_code=401, detail="사용자를 찾을 수 없습니다.")

        logger.info(f"👤 인증된 사용자 반환 - user_id: {user.user_id}, email: {user.email}")
        return user

    except JWTError as e:
        logger.error(f"❌ JWT 디코딩 실패: {str(e)}")
        raise HTTPException(status_code=401, detail="토큰이 유효하지 않습니다.")
