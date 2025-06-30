# 📄 tests/test_main.py

from fastapi.testclient import TestClient
from sqlalchemy.orm import Session

from app.main import app
from app.models.job import JobORM

# ✅ 테스트 전용 DB 세션 (conftest에서 정의된 engine 기반)
from tests.conftest import TestingSessionLocal  # 직접 정의한 경우만 필요

client = TestClient(app)


def test_read_root():
    """
    루트 경로에서 정상 응답이 오는지 확인
    """
    response = client.get("/")
    assert response.status_code == 200
    assert "message" in response.json()
    assert "API" in response.json()["message"]


def test_startup_loads_sample_jobs():
    """
    DB에 샘플 채용공고 데이터가 정상 삽입되었는지 확인
    """
    db: Session = TestingSessionLocal()
    jobs = db.query(JobORM).all()
    db.close()

    assert len(jobs) >= 2
    titles = [job.title for job in jobs]
    assert "백엔드 개발자" in titles
    assert "프론트엔드 개발자" in titles


def test_jobs_endpoint_loads_sample_jobs():
    """
    /api/v1/jobs 호출 시 올바른 데이터 구조 및 샘플 데이터가 포함되어 있는지 확인
    """
    response = client.get("/api/v1/jobs")
    assert response.status_code == 200

    data = response.json()
    assert "items" in data
    assert "total_count" in data
    assert isinstance(data["items"], list)

    titles = [job["title"] for job in data["items"]]
    assert "백엔드 개발자" in titles
    assert "프론트엔드 개발자" in titles
