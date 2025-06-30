import os
import pytest
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from app.models.job import Base  # JobORM 포함
from app.core.database import get_db
from app.main import app

from fastapi.testclient import TestClient

# ✅ 테스트용 SQLite DB 경로 지정
TEST_DB_PATH = "tests/test.db"
TEST_DATABASE_URL = f"sqlite:///./{TEST_DB_PATH}"
engine = create_engine(TEST_DATABASE_URL, connect_args={"check_same_thread": False})
TestingSessionLocal = sessionmaker(bind=engine, autocommit=False, autoflush=False)


# ✅ DB 세션 오버라이드
def override_get_db():
    db = TestingSessionLocal()
    try:
        yield db
    finally:
        db.close()


app.dependency_overrides[get_db] = override_get_db


# ✅ 테이블 및 샘플 데이터 준비
@pytest.fixture(scope="session", autouse=True)
def setup_database():
    # 1. 테이블 생성
    Base.metadata.drop_all(bind=engine)
    Base.metadata.create_all(bind=engine)

    # 2. 샘플 데이터 삽입
    from app.models.job import JobORM

    db = TestingSessionLocal()
    db.add_all(
        [
            JobORM(
                title="백엔드 개발자",
                company="테스트회사",
                location="서울",
                tech_stack='["Python", "FastAPI"]',
                url="https://example.com/job1",
                due_date_text="상시채용",
                job_type="backend",
            ),
            JobORM(
                title="프론트엔드 개발자",
                company="테스트회사",
                location="부산",
                tech_stack='["React", "JavaScript"]',
                url="https://example.com/job2",
                due_date_text="채용시 마감",
                job_type="frontend",
            ),
        ]
    )
    db.commit()
    db.close()
    yield

    # 3. 테스트 후 정리: 테이블 제거 및 DB 파일 삭제
    Base.metadata.drop_all(bind=engine)
    if os.path.exists(TEST_DB_PATH):
        os.remove(TEST_DB_PATH)


# ✅ 공통 client fixture
@pytest.fixture
def client():
    return TestClient(app)
