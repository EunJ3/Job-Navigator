# 📄 파일명: tests/test_job.py

from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)


# ✅ 응답 구조 공통 검증 함수
def assert_job_response_structure(json_data):
    assert "items" in json_data
    assert "total_count" in json_data
    assert isinstance(json_data["items"], list)
    assert isinstance(json_data["total_count"], int)


# ✅ 기본 조회 테스트
def test_read_jobs_default():
    response = client.get("/api/v1/jobs")
    assert response.status_code == 200
    assert_job_response_structure(response.json())


# ✅ 지역 필터 테스트
def test_read_jobs_with_location():
    response = client.get("/api/v1/jobs", params={"location": "서울"})
    assert response.status_code == 200
    assert_job_response_structure(response.json())


# ✅ 직무유형 필터 테스트
def test_read_jobs_with_job_type():
    response = client.get("/api/v1/jobs", params={"job_type": "backend"})
    assert response.status_code == 200
    assert_job_response_structure(response.json())


# ✅ 기술스택 필터 테스트
def test_read_jobs_with_tech_stack():
    response = client.get("/api/v1/jobs", params={"tech_stack": "Python"})
    assert response.status_code == 200
    assert_job_response_structure(response.json())


# ✅ 복합 필터 테스트
def test_read_jobs_with_all_filters():
    response = client.get(
        "/api/v1/jobs",
        params={
            "location": "서울",
            "job_type": "backend",
            "tech_stack": "Python",
            "page": 1,
            "size": 5,
        },
    )
    assert response.status_code == 200
    assert_job_response_structure(response.json())
