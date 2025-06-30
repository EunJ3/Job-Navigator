from pydantic import BaseModel
from typing import List, Optional


# ✅ 공통 필드 정의용 Base 스키마
class JobBase(BaseModel):
    title: str  # 공고 제목
    company: str  # 회사명
    location: str  # 근무 지역
    tech_stack: List[str]  # 기술 스택 리스트
    url: str  # 상세 URL
    due_date_text: Optional[str] = None  # 마감일 텍스트 (선택)
    job_type: Optional[str] = None  # 고용 형태 (선택)


# ✅ 새 공고 등록 시 사용
class JobCreate(JobBase):
    pass  # 별도 필드 없음 (JobBase 그대로 사용)


# ✅ 공고 수정 시 사용 (모든 필드 선택적)
class JobUpdate(BaseModel):
    title: Optional[str] = None
    company: Optional[str] = None
    location: Optional[str] = None
    tech_stack: Optional[List[str]] = None
    url: Optional[str] = None
    due_date_text: Optional[str] = None
    job_type: Optional[str] = None


# ✅ 공고 응답용 스키마 (id 포함)
class JobOut(JobBase):
    id: int  # 데이터베이스에 저장된 ID

    class Config:
        from_attributes = True  # SQLAlchemy ORM 객체와 호환 설정 (v2 기준)


# ✅ 공고 리스트 + 총 개수 응답용
class JobListResponse(BaseModel):
    items: List[JobOut]  # 공고 리스트
    total_count: int  # 전체 개수 (페이지네이션용)
