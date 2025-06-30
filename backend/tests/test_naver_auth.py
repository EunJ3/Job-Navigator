# 📄 파일: tests/test_naver_auth.py

import pytest
from fastapi.testclient import TestClient
from unittest.mock import AsyncMock, patch
from app.main import app
from app.core.database import get_db
from app.models.user import User
from sqlalchemy.orm import Session

client = TestClient(app)

# ✅ 기존 테스트 사용자 제거
@pytest.fixture(autouse=True)
def cleanup_test_naver_user():
    db: Session = next(get_db())
    db.query(User).filter(
        (User.email == "naveruser@example.com") |
        (User.social_id == "naver_mock_id_456")
    ).delete(synchronize_session=False)
    db.commit()


# ✅ 테스트 1: 잘못된 code 전달 시 400 응답
@patch("app.routes.auth_utils.naver_auth.httpx.AsyncClient.post", new_callable=AsyncMock)
def test_naver_login_invalid_code(mock_post):
    # ➤ [5] access_token 요청 실패
    mock_post.return_value.status_code = 400
    mock_post.return_value.json = AsyncMock(return_value={})

    response = client.post("/api/v1/auth/naver-login", json={"code": "invalid_code", "state":"dummy_state"})

    assert response.status_code == 400
    assert response.json()["detail"] == "Failed to get Naver token"


# ✅ 테스트 2: 정상 코드 전달 시 사용자 생성 + 토큰 반환
@patch("app.routes.auth_utils.naver_auth.httpx.AsyncClient.post", new_callable=AsyncMock)
@patch("app.routes.auth_utils.naver_auth.httpx.AsyncClient.get", new_callable=AsyncMock)
def test_naver_login_valid_code(mock_get, mock_post):
    # ➤ [5] access_token 발급 mock
    mock_post.return_value.status_code = 200
    mock_post.return_value.json = AsyncMock(return_value={
        "access_token": "mocked_access_token"
    })

    # ➤ [7] 사용자 정보 mock
    mock_get.return_value.status_code = 200
    mock_get.return_value.json = AsyncMock(return_value={
        "response": {
            "id": "naver_mock_id_123",
            "email": "naveruser@example.com",
            "name": "네이버 유저",
            "profile_image": "http://naver.image"
        }
    })

    response = client.post("/api/v1/auth/naver-login", json={"code": "valid_code", "state": "valid_state"})
    data = response.json()

    assert response.status_code == 200
    assert data["email"] == "naveruser@example.com"
    assert data["social_provider"] == "naver"
    assert "access_token" in data
