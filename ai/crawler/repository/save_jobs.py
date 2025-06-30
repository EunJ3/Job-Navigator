# 💾 파일 경로: ai/crawler/repository/save_job.py
# 🔄 크롤링된 공고를 jobs 테이블에 insert/update + 마감 공고 is_active=False 처리

from sqlalchemy import text
from typing import List
import json
from .database import engine  # ✅ 공통 DB 연결 모듈 import


def save_jobs_to_db(jobs: List[dict]):
    """
    크롤링된 채용 공고 리스트를 DB에 저장합니다.

    - URL 기준으로 기존 공고 존재 여부 판단
    - 기존 공고면 UPDATE, 신규 공고면 INSERT
    - 공통적으로 'is_active=True'로 저장 (모집 중 상태)
    - 기존 공고 중 이번에 발견되지 않은 URL은 is_active=False + due_date_text='모집마감' 처리
    """

    # ✅ 이번에 크롤링된 URL 리스트 추출
    crawled_urls = [job["url"] for job in jobs]

    with engine.connect() as conn:
        # ✅ 1. 기존 DB에서 사라진 공고 → 마감 처리 + 마감 텍스트 변경
        inactive_stmt = text("""
            UPDATE jobs
            SET is_active = FALSE,
                due_date_text = '모집마감'
            WHERE is_active = TRUE
              AND url NOT IN :crawled_urls
        """)
        conn.execute(inactive_stmt, {"crawled_urls": tuple(crawled_urls)})

        # ✅ 2. 현재 공고 목록 insert 또는 update
        for job in jobs:
            job["tech_stack"] = json.dumps(job["tech_stack"])  # list → JSON 문자열

            existing = conn.execute(
                text("SELECT COUNT(*) FROM jobs WHERE url = :url"),
                {"url": job["url"]}
            ).scalar()

            if existing == 0:
                stmt = text("""
                    INSERT INTO jobs (
                        title, company, location, experience,
                        tech_stack, due_date_text, url, job_type, is_active
                    ) VALUES (
                        :title, :company, :location, :experience,
                        :tech_stack, :due_date_text, :url, :job_type, :is_active
                    )
                """)
            else:
                stmt = text("""
                    UPDATE jobs
                    SET title = :title,
                        company = :company,
                        location = :location,
                        experience = :experience,
                        tech_stack = :tech_stack,
                        due_date_text = :due_date_text,
                        job_type = :job_type,
                        is_active = :is_active
                    WHERE url = :url
                """)

            conn.execute(stmt, job)

        conn.commit()

    print("✅ 크롤링 데이터 저장 + 마감 처리 완료")
