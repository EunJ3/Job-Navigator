# 파일명: routes/bookmark.py

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.core.database import get_db  # 기존 SessionLocal → get_db로 대체
from app.schemas.bookmark import BookmarkCreate, BookmarkOut
from app.services.bookmark_service import (
    add_bookmark,
    remove_bookmark,
    get_user_bookmarks,
)
from app.routes.auth_utils.jwt_utils import get_current_user
from app.models.user import UserORM

router = APIRouter()  # ✅ prefix, tags는 main.py에서 명시한다고 하셨으므로 비워둠


# ✅ 북마크 추가 (POST)
@router.post("/", response_model=BookmarkOut)
def create_bookmark(
    bookmark_data: BookmarkCreate,
    db: Session = Depends(get_db),
    current_user: UserORM = Depends(get_current_user),
):
    return add_bookmark(db, current_user.user_id, bookmark_data.job_post_id)


# ✅ 북마크 삭제 (DELETE)
@router.delete("/{job_post_id}")
def delete_bookmark(
    job_post_id: int,
    db: Session = Depends(get_db),
    current_user: UserORM = Depends(get_current_user),
):
    remove_bookmark(db, current_user.user_id, job_post_id)
    return {"detail": "북마크 삭제 완료"}


# ✅ 북마크 목록 조회 (GET)
@router.get("/", response_model=list[BookmarkOut])
def read_bookmarks(
    db: Session = Depends(get_db),
    current_user: UserORM = Depends(get_current_user),
):
    return get_user_bookmarks(db, current_user.user_id)
