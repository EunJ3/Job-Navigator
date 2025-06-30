# 파일명: resume.py

from sqlalchemy import Column, Integer, String, ForeignKey, DateTime
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship
from sqlalchemy.dialects.postgresql import JSONB
from app.core.database import Base


# 사용자의 이력서 파일 정보를 저장하는 ORM 모델입니다.
class ResumeORM(Base):
    __tablename__ = "resumes"

    # 이력서 ID (Primary Key)
    resume_id = Column(Integer, primary_key=True)

    # 사용자 ID (외래키)
    user_id = Column(Integer, ForeignKey("users.user_id", ondelete="CASCADE"))

    # 이력서 파일 경로
    file_path = Column(String(500))

    # 추출된 키워드 (JSON 배열)
    extracted_keywords = Column(JSONB)

    # 이력서를 통해 분류된 직무 카테고리
    job_category = Column(String(100))

    # 업로드 일시
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    # 관계 설정
    user = relationship("UserORM", backref="resumes")
