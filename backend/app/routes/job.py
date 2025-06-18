# 📄 파일명: app/routers/job.py

from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session
from typing import Optional
from app.models import job as job_schema
from app.services import job_service
from app.core.database import get_db

router = APIRouter()


# 🔥 채용공고 조회 API (페이징 + 필터 + 총 개수 반환)
@router.get("/", response_model=job_schema.JobListResponse)
def read_jobs(
    page: int = Query(1, ge=1),
    size: int = Query(20, ge=1, le=100),
    location: Optional[str] = None,
    job_type: Optional[str] = None,
    tech_stack: Optional[str] = None,
    db: Session = Depends(get_db),
):
    """
    채용공고 조회 API
    - 페이징: page, size
    - 필터: location, job_type, tech_stack
    - 반환: items (채용공고 목록), total_count (전체 개수)
    """
    return job_service.get_jobs(
        db=db,
        page=page,
        size=size,
        location=location,
        job_type=job_type,
        tech_stack=tech_stack,
    )


# -------------------- 기존 하드코딩용 테스트 코드 (참고용으로 남김) --------------------

"""
from fastapi import HTTPException
from uuid import uuid4
from app.models.job import JobCreate, JobUpdate, JobOut

# 기존 메모리 기반 조회 API
@router.get("/", response_model=list[JobOut])
def get_jobs():
    return job_service.JOBS_DB

# 기존 메모리 기반 등록 API
@router.post("/", response_model=JobOut)
def create_job(job: JobCreate):
    new_job = job.dict()
    new_job["id"] = str(uuid4())
    job_service.JOBS_DB.append(new_job)
    return new_job

# 기존 메모리 기반 수정 API
@router.put("/{job_id}", response_model=JobOut)
def update_job(job_id: str, job: JobUpdate):
    for j in job_service.JOBS_DB:
        if j["id"] == job_id:
            j.update(job.dict(exclude_unset=True))
            return j
    raise HTTPException(status_code=404, detail="Job not found")
"""
