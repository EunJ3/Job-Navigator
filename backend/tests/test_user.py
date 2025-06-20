from fastapi.testclient import TestClient
from datetime import timedelta
from app.main import app
from app.routes.auth import create_access_token

client = TestClient(app)

# ✅ 테스트용 JWT 토큰 동적 생성
def get_token():
    return create_access_token(data={"user_id": 3}, expires_delta=timedelta(minutes=60))

def test_get_my_user_info_real_token():
    token = get_token()
    response = client.get(
        "/api/v1/users/me",
        headers={"Authorization": f"Bearer {token}"},
    )
    assert response.status_code == 200
    data = response.json()
    assert data["email"] in ["googleuser1@example.com", "googleuser2@example.com"]

def test_update_my_user_info_real_token():
    token = get_token()

    # 현재 정보 확인
    get_response = client.get(
        "/api/v1/users/me",
        headers={"Authorization": f"Bearer {token}"},
    )
    current = get_response.json()

    # 토글 방식: (1) → (2), (2) → (1)
    if current["email"] == "googleuser1@example.com":
        payload = {
            "name": "구글 사용자 수정됨(2)",
            "profile_image": "http://google.image.url/updated.png(2)",
            "email": "googleuser2@example.com",
        }
    else:
        payload = {
            "name": "구글 사용자 수정됨(1)",
            "profile_image": "http://google.image.url/updated.png(1)",
            "email": "googleuser1@example.com",
        }

    response = client.put(
        "/api/v1/users/me",
        headers={"Authorization": f"Bearer {token}"},
        json=payload,
    )
    print("\n🔄 업데이트된 사용자 정보:", response.json())

    assert response.status_code == 200
    assert response.json()["name"] == payload["name"]
    assert response.json()["profile_image"] == payload["profile_image"]
    assert response.json()["email"] == payload["email"]
