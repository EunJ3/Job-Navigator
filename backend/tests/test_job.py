# 📄 파일명: tests/test_job.py

import pytest


# ✅ client fixture 사용
def test_read_jobs_default(client):
    response = client.get("/api/v1/jobs")
    assert response.status_code == 200
    assert_job_response_structure(response.json())


def test_read_jobs_with_location(client):
    response = client.get("/api/v1/jobs", params={"location": "서울"})
    assert response.status_code == 200
    assert_job_response_structure(response.json())


def test_read_jobs_with_job_type(client):
    response = client.get("/api/v1/jobs", params={"job_type": "backend"})
    assert response.status_code == 200
    assert_job_response_structure(response.json())


def test_read_jobs_with_tech_stack(client):
    response = client.get("/api/v1/jobs", params={"tech_stack": "Python"})
    assert response.status_code == 200
    assert_job_response_structure(response.json())


def test_read_jobs_with_all_filters(client):
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


# ✅ 공통 응답 구조 검증 함수
def assert_job_response_structure(json_data):
    assert "items" in json_data
    assert "total_count" in json_data
    assert isinstance(json_data["items"], list)
    assert isinstance(json_data["total_count"], int)
