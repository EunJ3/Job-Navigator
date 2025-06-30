# 파일명: roadmap.py

from sqlalchemy import Column, Integer, ForeignKey, String, Float, DateTime
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship
from sqlalchemy.dialects.postgresql import JSONB
from app.core.database import Base


# 사용자의 진로 로드맵 정보를 저장하는 ORM 모델입니다.
class RoadmapORM(Base):
    __tablename__ = "roadmaps"

    # 로드맵 ID
    roadmap_id = Column(Integer, primary_key=True)

    # 사용자 ID
    user_id = Column(Integer, ForeignKey("users.user_id", ondelete="CASCADE"))

    # 참조한 이력서 ID
    resume_id = Column(Integer, ForeignKey("resumes.resume_id", ondelete="CASCADE"))

    # 생성된 로드맵 내용
    generated_roadmap = Column(JSONB)

    # 유사도 점수
    similarity_score = Column(Float)

    # 목표 직무 카테고리
    target_job_category = Column(String(100))

    # 생성 일시
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    # 관계 설정
    user = relationship("UserORM", backref="roadmaps")
    resume = relationship("ResumeORM", backref="roadmaps")
