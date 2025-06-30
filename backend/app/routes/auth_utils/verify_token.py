#backend/app/routes/auth_utils/verify_token.py

from fastapi import APIRouter, Depends
from app.models.user import UserORM
from app.schemas.user import UserResponse
from app.routes.auth_utils.jwt_utils import get_current_user

router = APIRouter()

@router.get("/verify-token", response_model=UserResponse)
def verify_token(current_user: UserORM = Depends(get_current_user)):
    """
    JWT 토큰을 검증하고 사용자 정보를 반환합니다.
    """
    return current_user
