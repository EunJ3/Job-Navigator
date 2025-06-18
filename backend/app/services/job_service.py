from sqlalchemy.orm import Session
from typing import Optional
import json

from app.models import job as job_schema
from app.models.job import JobORM  # 실제 ORM 테이블


# 🔥 DB 연동 채용공고 조회 서비스 (필터링 + 페이징 + 개수 반환 지원)
def get_jobs(
    db: Session,
    page: int = 1,
    size: int = 20,
    location: Optional[str] = None,
    job_type: Optional[str] = None,
    tech_stack: Optional[str] = None,
) -> dict:

    query = db.query(JobORM)

    # ✅ 부분 포함 필터
    if location:
        query = query.filter(JobORM.location.ilike(f"%{location}%"))

    if job_type:
        query = query.filter(JobORM.job_type == job_type)

    if tech_stack:
        query = query.filter(JobORM.tech_stack.ilike(f"%{tech_stack}%"))

    total_count = query.count()  # ✅ 전체 개수 먼저 계산

    # 페이징 처리
    jobs = query.offset((page - 1) * size).limit(size).all()

    # 결과 직렬화
    result = []
    for job in jobs:
        try:
            parsed_stack = json.loads(job.tech_stack)
            if not isinstance(parsed_stack, list):
                parsed_stack = []
        except Exception:
            parsed_stack = []

        result.append(
            job_schema.JobOut(
                id=job.id,
                title=job.title,
                company=job.company,
                location=job.location,
                tech_stack=parsed_stack,
                url=job.url,
                due_date_text=job.due_date_text,
                job_type=job.job_type,
            )
        )

    return {"items": result, "total_count": total_count}
