# 파일명: tech_trend.py

from sqlalchemy import Column, Integer, String, Date, DateTime
from sqlalchemy.sql import func
from app.core.database import Base


# 직무별 키워드 기술 트렌드 통계를 저장하는 ORM 모델입니다.
class TechTrendORM(Base):
    __tablename__ = "tech_trends"

    # 트렌드 ID (Primary Key)
    trend_id = Column(Integer, primary_key=True)

    # 기술 키워드 (예: "Python", "React")
    keyword = Column(String(100), nullable=False)

    # 관련된 직무 카테고리 (예: "백엔드", "프론트엔드")
    job_category = Column(String(100))

    # 해당 키워드 출현 빈도
    count = Column(Integer, nullable=False)

    # 트렌드 통계 기준 날짜
    trend_date = Column(Date, nullable=False)

    # 기록 생성 일시
    created_at = Column(DateTime(timezone=True), server_default=func.now())
