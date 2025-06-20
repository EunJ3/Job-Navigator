from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.core.database import get_db
from app.models.user import UserOut, UserUpdate, User
from app.services import user_service
from app.routes.auth import get_current_user

router = APIRouter()

# 현재 사용자 정보 조회
@router.get("/me", response_model=UserOut)
def read_my_user_info(
    current_user: User = Depends(get_current_user),
):
    return current_user

# 현재 사용자 정보 수정
@router.put("/me", response_model=UserOut)
def update_my_user_info(
    user_update: UserUpdate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    try:
        updated_user = user_service.update_user(db, current_user.user_id, user_update)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))

    if updated_user is None:
        raise HTTPException(status_code=404, detail="User Not Found")

    return updated_user