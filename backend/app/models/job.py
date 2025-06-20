from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime
from sqlalchemy import Column, Integer, String, Text
from sqlalchemy.orm import declarative_base

# SQLAlchemy ORM
Base = declarative_base()


class JobORM(Base):
    __tablename__ = "jumpit_jobs"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String)
    company = Column(String)
    location = Column(String)
    tech_stack = Column(Text)
    url = Column(String)
    due_date_text = Column(String)
    job_type = Column(String)


# ✅ 공통 속성 스키마
class JobBase(BaseModel):
    title: str
    company: str
    location: str
    tech_stack: List[str]
    url: str
    due_date_text: Optional[str] = None
    job_type: Optional[str] = None


# ✅ 생성용
class JobCreate(JobBase):
    pass


# ✅ 수정용
class JobUpdate(BaseModel):
    title: Optional[str] = None
    company: Optional[str] = None
    location: Optional[str] = None
    tech_stack: Optional[List[str]] = None
    url: Optional[str] = None
    due_date_text: Optional[str] = None
    job_type: Optional[str] = None


# ✅ 출력용
class JobOut(JobBase):
    id: int

    class Config:
        from_attributes = True  # ✅ Pydantic v2 기준 ORM 매핑
        # orm_mode = True  # 🔁 v1에서는 사용했지만 v2에서는 위로 대체됨


# ✅ 리스트 + 개수 반환 스키마
class JobListResponse(BaseModel):
    items: List[JobOut]
    total_count: int
