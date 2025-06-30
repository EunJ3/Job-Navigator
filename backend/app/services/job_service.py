from sqlalchemy.orm import Session
from typing import Optional

# ✅ ORM: DB 테이블 매핑
from app.models.job import JobORM

# ✅ 스키마: Pydantic 데이터 모델
from app.schemas.job import JobOut, JobListResponse


# ✅ 채용공고 목록 조회 서비스 (필터 + 페이징 + 총 개수 포함)
def get_jobs(
    db: Session,
    page: int = 1,
    size: int = 20,
    location: Optional[str] = None,
    job_type: Optional[str] = None,
    tech_stack: Optional[str] = None,
) -> JobListResponse:
    """
    채용공고를 조회합니다.
    - 필터링: location, job_type, tech_stack
    - 페이징: page, size
    - 반환: JobOut 목록 + 전체 개수
    """

    query = db.query(JobORM)

    # ✅ 필터 조건 처리 (부분 일치)
    if location:
        query = query.filter(JobORM.location.ilike(f"%{location}%"))
    if job_type:
        query = query.filter(JobORM.job_type == job_type)
    if tech_stack:
        query = query.filter(JobORM.tech_stack.cast(String).ilike(f"%{tech_stack}%"))

    total_count = query.count()  # 전체 개수 계산

    # ✅ 페이징 처리
    jobs = query.offset((page - 1) * size).limit(size).all()

    # ✅ 결과 변환: ORM → Pydantic 스키마
    job_items = [
        JobOut(
            id=job.job_post_id,  # <- 수정됨
            title=job.title,
            company=job.company,
            location=job.location,
            tech_stack=job.tech_stack or [],  # PostgreSQL JSONB는 이미 list
            url=job.url,
            due_date_text=job.due_date_text,
            job_type=job.job_type,
        )
        for job in jobs
    ]

    # ✅ Pydantic 응답 스키마에 맞게 반환
    return JobListResponse(items=job_items, total_count=total_count)
