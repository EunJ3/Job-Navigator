# 파일명: job.py

from sqlalchemy import Column, Integer, String, Text
from sqlalchemy.dialects.postgresql import JSONB
from app.core.database import Base


# 채용 공고 정보를 저장하는 SQLAlchemy ORM 모델입니다.
class JobORM(Base):
    __tablename__ = "jobs"

    # 공고 고유 ID (Primary Key, Auto Increment)
    job_post_id = Column(Integer, primary_key=True, index=True)

    # 공고 제목
    title = Column(String, nullable=False)

    # 회사명
    company = Column(String, nullable=False)

    # 근무 지역
    location = Column(String, nullable=True)

    # 경력 요건 (예: "신입", "1~3년")
    experience = Column(String, nullable=True)

    # 기술 스택 (예: ["Python", "Django", "AWS"])
    tech_stack = Column(JSONB, nullable=True)

    # 마감일 텍스트 (예: "채용 시 마감")
    due_date_text = Column(Text, nullable=True)

    # 공고 URL
    url = Column(String, unique=True, nullable=False)

    # 고용 형태 (예: "정규직", "계약직")
    job_type = Column(String, nullable=True)
