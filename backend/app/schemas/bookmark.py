# 파일명: schemas/bookmark.py

from pydantic import BaseModel
from datetime import datetime


# ✅ 북마크 생성 요청용 (POST용)
class BookmarkCreate(BaseModel):
    job_post_id: int


# ✅ 북마크 조회 응답용 (GET용)
class BookmarkOut(BaseModel):
    bookmark_job_id: int
    job_post_id: int
    created_at: datetime

    class Config:
        orm_mode = True
