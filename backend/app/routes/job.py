from fastapi import APIRouter, Depends, Query, HTTPException, Path
from sqlalchemy.orm import Session
from typing import Optional

from app.schemas import job as job_schema
from app.services import job_service
from app.core.database import get_db

router = APIRouter(tags=["Jobs"])


# ✅ 1. 채용공고 목록 조회 (페이징 + 필터)
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
    채용공고 목록을 조회합니다.
    - 페이징: page, size
    - 필터: location, job_type, tech_stack
    """
    return job_service.get_jobs(
        db=db,
        page=page,
        size=size,
        location=location,
        job_type=job_type,
        tech_stack=tech_stack,
    )


# ✅ 2. 채용공고 단건 조회
@router.get("/{job_id}", response_model=job_schema.JobOut)
def read_job(
    job_id: int = Path(..., ge=1),
    db: Session = Depends(get_db),
):
    """
    특정 ID의 채용공고를 조회합니다.
    """
    job = job_service.get_job_by_id(db, job_id)
    if not job:
        raise HTTPException(status_code=404, detail="Job not found")
    return job


# ✅ 3. 채용공고 생성
@router.post("/", response_model=job_schema.JobOut, status_code=201)
def create_job(
    job_create: job_schema.JobCreate,
    db: Session = Depends(get_db),
):
    """
    새 채용공고를 생성합니다.
    """
    return job_service.create_job(db, job_create)


# ✅ 4. 채용공고 수정
@router.put("/{job_id}", response_model=job_schema.JobOut)
def update_job(
    job_id: int,
    job_update: job_schema.JobUpdate,
    db: Session = Depends(get_db),
):
    """
    채용공고 정보를 수정합니다.
    """
    job = job_service.update_job(db, job_id, job_update)
    if not job:
        raise HTTPException(status_code=404, detail="Job not found")
    return job
