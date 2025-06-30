# 파일명: services/bookmark_service.py

from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError
from fastapi import HTTPException
from app.models.bookmark import BookmarkJobORM


# ✅ 북마크 추가
def add_bookmark(db: Session, user_id: int, job_post_id: int) -> BookmarkJobORM:
    bookmark = BookmarkJobORM(user_id=user_id, job_post_id=job_post_id)
    db.add(bookmark)
    try:
        db.commit()
        db.refresh(bookmark)
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="이미 북마크된 공고입니다.")
    return bookmark


# ✅ 북마크 삭제
def remove_bookmark(db: Session, user_id: int, job_post_id: int):
    bookmark = db.query(BookmarkJobORM).filter_by(user_id=user_id, job_post_id=job_post_id).first()
    if not bookmark:
        raise HTTPException(status_code=404, detail="해당 북마크를 찾을 수 없습니다.")
    db.delete(bookmark)
    db.commit()


# ✅ 특정 사용자의 북마크 목록 조회
def get_user_bookmarks(db: Session, user_id: int):
    return db.query(BookmarkJobORM).filter_by(user_id=user_id).all()
