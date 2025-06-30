# scripts/seed_db.py

from sqlalchemy.orm import Session
from app.core.database import SessionLocal
from app.models.job import JobORM

# from app.models.user import UserORM


def insert_sample_data():
    db: Session = SessionLocal()

    # 기존 데이터 삭제 (개발/테스트 환경용)
    db.query(JobORM).delete()
    # db.query(UserORM).delete()

    # 유저 예시
    # user = UserORM(
    #    email="admin@example.com",
    #    name="관리자",
    #    provider="local",
    #    profile_image="https://via.placeholder.com/150",
    # )

    # 잡 예시
    jobs = [
        JobORM(
            title="백엔드 개발자",
            company="테스트회사",
            location="서울",
            tech_stack="Python, FastAPI, PostgreSQL",
            url="https://example.com/job/backend",
            due_date_text="상시채용",
            job_type="정규직",
        ),
        JobORM(
            title="프론트엔드 개발자",
            company="테스트회사",
            location="서울",
            tech_stack="React, TypeScript",
            url="https://example.com/job/frontend",
            due_date_text="2025-12-31",
            job_type="계약직",
        ),
    ]

    # db.add(user)
    db.add_all(jobs)
    db.commit()
    db.close()

    print("✅ Sample data inserted.")


if __name__ == "__main__":
    insert_sample_data()
