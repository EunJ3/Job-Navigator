import pytest
from fastapi.testclient import TestClient
from app.main import app
from unittest.mock import patch
from app.routes import auth

client = TestClient(app)

# ✅ Google 로그인 테스트 ------------------------

def test_google_login_invalid_token():
    response = client.post(
        "/api/v1/auth/google-login", json={"id_token_str": "invalid_token"}
    )
    assert response.status_code == 400
    assert response.json()["detail"] == "Invalid Google token"


@patch("app.routes.auth.id_token.verify_oauth2_token")
def test_google_login_success(mock_verify_token):
    mock_verify_token.return_value = {
        "sub": "mocked_google_id_12345",
        "email": "googleuser@example.com",
        "name": "구글 사용자",
        "picture": "http://google.image.url",
    }

    response = client.post(
        "/api/v1/auth/google-login", json={"id_token_str": "mocked_token"}
    )
    assert response.status_code == 200
    data = response.json()
    assert data["email"] == "googleuser@example.com"
    assert "access_token" in data

# ✅ Kakao 로그인 테스트 ------------------------

@patch("app.routes.auth.requests.post")
@patch("app.routes.auth.requests.get")
def test_kakao_login_success(mock_get, mock_post):
    mock_post.return_value.status_code = 200
    mock_post.return_value.json.return_value = {
        "access_token": "mock_kakao_access_token"
    }

    mock_get.return_value.status_code = 200
    mock_get.return_value.json.return_value = {
        "id": "kakao_mock_id_123",
        "kakao_account": {"email": "kakaouser@example.com"},
        "properties": {
            "nickname": "카카오유저",
            "profile_image": "http://kakao.img"
        }
    }

    response = client.request(
        method="GET",
        url="/api/v1/auth/kakao/callback?code=mock_code",
        follow_redirects=False
    )

    assert response.status_code == 307
    assert response.headers["location"].startswith("http://localhost:5173/login?token=")

# ✅ Naver 로그인 테스트 ------------------------

@patch("app.routes.auth.requests.post")
@patch("app.routes.auth.requests.get")
def test_naver_login_success(mock_get, mock_post):
    mock_post.return_value.status_code = 200
    mock_post.return_value.json.return_value = {
        "access_token": "mock_naver_access_token"
    }

    mock_get.return_value.status_code = 200
    mock_get.return_value.json.return_value = {
        "response": {
            "id": "naver_mock_id_456",
            "email": "naveruser@example.com",
            "name": "네이버유저",
            "profile_image": "http://naver.img"
        }
    }

    response = client.request(
        method="GET",
        url="/api/v1/auth/naver/callback?code=mock_code&state=xyz",
        follow_redirects=False
    )
    assert response.status_code == 307
    assert response.headers["location"].startswith("http://localhost:5173/login?token=")
