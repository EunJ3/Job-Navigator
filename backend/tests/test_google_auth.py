# 📄 파일명: tests/test_google_auth.py

import pytest
from fastapi.testclient import TestClient
from unittest.mock import patch
from app.main import app
from app.routes.auth_utils.google_auth import GOOGLE_CLIENT_ID  # ✅ 경로 수정
from sqlalchemy.orm import Session
from app.core.database import get_db
from app.models.user import User

client = TestClient(app)

# ✅ 테스트 1: 유효하지 않은 Google ID 토큰 전달 시 400 에러 반환
def test_google_login_invalid_token():
    response = client.post("/api/v1/auth/google-login", json={"id_token_str": "invalid_token"})
    assert response.status_code == 400
    assert response.json()["detail"] == "Invalid Google token"

# ✅ 테스트 실행 전후로 기존 테스트 계정 정리 (email or social_id 중복 방지)
@pytest.fixture(autouse=True)
def cleanup_test_user():
    db: Session = next(get_db())
    db.query(User).filter(
        (User.email == "testuser@example.com") |
        (User.social_id == "google_user_12345")
    ).delete(synchronize_session=False)
    db.commit()

# ✅ 테스트 2: 유효한 Google ID 토큰 전달 시 사용자 정보 + JWT access_token 반환
@patch("app.routes.auth_utils.google_auth.id_token.verify_oauth2_token")
def test_google_login_valid_token(mock_verify_token):
    # ➤ ❶ Mocked id_token payload (Google에서 반환할 정보)
    mock_verify_token.return_value = {
        "sub": "google_user_12345",
        "email": "testuser@example.com",
        "name": "테스트 사용자",
        "picture": "http://example.com/profile.jpg",
        "aud": GOOGLE_CLIENT_ID
    }

    # ➤ ❷ 로그인 요청
    response = client.post("/api/v1/auth/google-login", json={"id_token_str": "mocked_token"})
    data = response.json()

    # ➤ ❸ 결과 검증
    assert response.status_code == 200
    assert data["email"] == "testuser@example.com"
    assert data["social_provider"] == "google"
    assert "access_token" in data
