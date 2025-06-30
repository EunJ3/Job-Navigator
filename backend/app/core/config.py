import os
from dotenv import load_dotenv

# ✅ main.py 등에서 명시적으로 호출
def load_env():
    load_dotenv()


def get_allowed_origins() -> list[str]:
    """
    CORS 허용 도메인 목록을 불러옵니다.
    환경변수 'CORS_ALLOWED_ORIGINS'는 쉼표로 구분된 문자열입니다.
    """
    origins = os.getenv("CORS_ALLOWED_ORIGINS", "")
    return [origin.strip() for origin in origins.split(",") if origin.strip()]


def get_settings() -> dict:
    """
    프로젝트 전역에서 사용될 설정 값을 딕셔너리로 반환합니다.
    """
    return {
        # 기본 설정
        "APP_NAME": os.getenv("APP_NAME", "Job Navigator"),
        "ENVIRONMENT": os.getenv("ENVIRONMENT", "development"),
        "CORS_ALLOWED_ORIGINS": get_allowed_origins(),

        # PostgreSQL 설정
        "POSTGRES_USER": os.getenv("POSTGRES_USER", "postgres"),
        "POSTGRES_PASSWORD": os.getenv("POSTGRES_PASSWORD", ""),
        "POSTGRES_DB": os.getenv("POSTGRES_DB", ""),
        "POSTGRES_HOST": os.getenv("POSTGRES_HOST", "localhost"),
        "POSTGRES_PORT": os.getenv("POSTGRES_PORT", "5432"),

        # Google OAuth
        "GOOGLE_CLIENT_ID": os.getenv("GOOGLE_CLIENT_ID", ""),

        # Kakao OAuth
        "KAKAO_CLIENT_ID": os.getenv("KAKAO_CLIENT_ID", ""),
        "KAKAO_REDIRECT_URI": os.getenv("KAKAO_REDIRECT_URI", ""),

        # Naver OAuth
        "NAVER_CLIENT_ID": os.getenv("NAVER_CLIENT_ID", ""),
        "NAVER_CLIENT_SECRET": os.getenv("NAVER_CLIENT_SECRET", ""),
        "NAVER_REDIRECT_URI": os.getenv("NAVER_REDIRECT_URI", ""),

        # JWT 설정
        "JWT_SECRET_KEY": os.getenv("JWT_SECRET_KEY", ""),
        "JWT_ALGORITHM": os.getenv("JWT_ALGORITHM", "HS256"),
        "ACCESS_TOKEN_EXPIRE_MINUTES": int(os.getenv("ACCESS_TOKEN_EXPIRE_MINUTES", 10)),
    }


# ✅ 개별 getter (필요 시 import 하여 사용)
def get_google_client_id() -> str:
    return os.getenv("GOOGLE_CLIENT_ID", "")

def get_kakao_client_id() -> str:
    return os.getenv("KAKAO_CLIENT_ID", "")

def get_kakao_redirect_uri() -> str:
    return os.getenv("KAKAO_REDIRECT_URI", "")

def get_naver_client_id() -> str:
    return os.getenv("NAVER_CLIENT_ID", "")

def get_naver_client_secret() -> str:
    return os.getenv("NAVER_CLIENT_SECRET", "")

def get_naver_redirect_uri() -> str:
    return os.getenv("NAVER_REDIRECT_URI", "")

def get_jwt_secret_key() -> str:
    return os.getenv("JWT_SECRET_KEY", "")

def get_jwt_algorithm() -> str:
    return os.getenv("JWT_ALGORITHM", "HS256")

def get_access_token_expiry_minutes() -> int:
    return int(os.getenv("ACCESS_TOKEN_EXPIRE_MINUTES", 10))
