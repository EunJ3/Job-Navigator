import pytest
from fastapi.testclient import TestClient
from app.main import app
from unittest.mock import patch
from app.routes import auth

client = TestClient(app)


# ✅ 실패 케이스: 잘못된 토큰일 때
def test_google_login_invalid_token():
    response = client.post(
        "/api/v1/auth/google-login", json={"id_token_str": "invalid_token"}
    )
    assert response.status_code == 400
    assert response.json()["detail"] == "Invalid Google token"


# ✅ 성공 케이스: mocking을 이용해서 구글 토큰 검증 우회
@patch("app.routes.auth.id_token.verify_oauth2_token")
def test_google_login_success(mock_verify_token):
    # ✅ mocking된 구글 토큰 응답 값 정의
    mock_verify_token.return_value = {
        "sub": "mocked_social_id_12345",
        "email": "testuser@example.com",
        "name": "테스트 사용자",
        "picture": "http://test.image.url",
    }

    response = client.post(
        "/api/v1/auth/google-login", json={"id_token_str": "any_valid_token_string"}
    )

    assert response.status_code == 200
    data = response.json()

    # ✅ 응답 필드 검증
    assert data["user_id"] > 0
    assert data["email"] == "testuser@example.com"
    assert "access_token" in data

    # ✅ JWT 토큰 유효성은 별도 테스트 가능 (간단 예시로 존재 확인)
