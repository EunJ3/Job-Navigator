from fastapi import APIRouter, Depends, HTTPException, UploadFile, File
from sqlalchemy.orm import Session
from app.core.database import get_db
from app.models.user import UserORM
from app.schemas.user import UserOut, UserUpdate
from app.services import user_service
from app.routes.auth_utils.jwt_utils import get_current_user
import os

router = APIRouter()


# 현재 사용자 정보 조회
@router.get("/me", response_model=UserOut)
def read_my_user_info(
    current_user: UserORM = Depends(get_current_user),
):
    return current_user


# 현재 사용자 정보 수정
@router.put("/me", response_model=UserOut)
def update_my_user_info(
    user_update: UserUpdate,
    current_user: UserORM = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    try:
        updated_user = user_service.update_user(db, current_user.user_id, user_update)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))

    if updated_user is None:
        raise HTTPException(status_code=404, detail="User Not Found")

    return updated_user

# 이미지 업데이트 
@router.post("/update-image")
def update_profile_image(
    profile_image: UploadFile = File(...),
    db: Session = Depends(get_db),
    current_user: UserORM = Depends(get_current_user),
):
    save_dir = "static/profile_images"
    os.makedirs(save_dir, exist_ok=True)

    filename = f"user_{current_user.user_id}_{profile_image.filename}"
    file_path = os.path.join(save_dir, filename)

    with open(file_path, "wb") as f:
        f.write(profile_image.file.read())

    current_user.profile_image = f"/{file_path.replace(os.sep, '/')}"
    db.commit()
    db.refresh(current_user)

    return current_user