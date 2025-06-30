# 📄 파일명: tests/test_kakao_auth.py

import pytest
from fastapi.testclient import TestClient
from unittest.mock import AsyncMock, patch
from app.main import app
from app.core.database import get_db
from app.models.user import User
from sqlalchemy.orm import Session

client = TestClient(app)

# ✅ 테스트 실행 전 기존 사용자 제거
@pytest.fixture(autouse=True)
def cleanup_test_kakao_user():
    db: Session = next(get_db())
    db.query(User).filter(
        (User.email == "kakao_user@example.com") |
        (User.social_id == "98765")
    ).delete(synchronize_session=False)
    db.commit()


# ✅ 테스트 1: 잘못된 code 전달 시 400 에러 반환
@patch("app.routes.auth_utils.kakao_auth.httpx.AsyncClient.post", new_callable=AsyncMock)
def test_kakao_login_invalid_code(mock_post):
    mock_post.return_value.status_code = 400
    mock_post.return_value.json = AsyncMock(return_value={})

    response = client.post("/api/v1/auth/kakao-login", json={"code": "invalid_code"})
    assert response.status_code == 400
    assert response.json()["detail"] == "Failed to get Kakao token"


# ✅ 테스트 2: 정상적인 인가코드 전달 시 사용자 생성 + 토큰 반환
@patch("app.routes.auth_utils.kakao_auth.httpx.AsyncClient.post", new_callable=AsyncMock)
@patch("app.routes.auth_utils.kakao_auth.httpx.AsyncClient.get", new_callable=AsyncMock)
def test_kakao_login_valid_code(mock_get, mock_post):
    # ➤ [5] access_token 응답 mock
    mock_post.return_value.status_code = 200
    mock_post.return_value.json = AsyncMock(return_value={
        "access_token": "mocked_access_token"
    })

    # ➤ [7] 사용자 정보 응답 mock
    mock_get.return_value.status_code = 200
    mock_get.return_value.json = AsyncMock(return_value={
        "id": 98765,
        "kakao_account": {
            "email": "kakao_user@example.com",
            "profile": {
                "nickname": "카카오유저",
                "profile_image_url": "http://kakao.image"
            }
        }
    })

    response = client.post("/api/v1/auth/kakao-login", json={"code": "valid_code"})
    data = response.json()

    assert response.status_code == 200
    assert data["email"] == "kakao_user@example.com"
    assert data["social_provider"] == "kakao"
    assert "access_token" in data
