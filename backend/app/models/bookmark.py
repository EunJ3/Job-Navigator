# 파일명: bookmark.py

from sqlalchemy import Column, Integer, ForeignKey, DateTime, UniqueConstraint
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship
from app.core.database import Base


# 사용자의 즐겨찾기한 채용공고 정보를 저장하는 ORM 모델입니다.
class BookmarkJobORM(Base):
    __tablename__ = "user_bookmarked_posts"

    # 즐겨찾기 고유 ID
    bookmark_job_id = Column(Integer, primary_key=True)

    # 사용자 ID (외래키)
    user_id = Column(Integer, ForeignKey("users.user_id", ondelete="CASCADE"))

    # 즐겨찾기한 채용공고 ID (외래키)
    job_post_id = Column(Integer, ForeignKey("jobs.job_post_id", ondelete="CASCADE"))

    # 즐겨찾기한 일시
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    # 유니크 제약조건 (user_id + job_post_id)
    __table_args__ = (
        UniqueConstraint("user_id", "job_post_id", name="uq_bookmark"),
    )

    user = relationship("UserORM", backref="bookmarked_jobs")
