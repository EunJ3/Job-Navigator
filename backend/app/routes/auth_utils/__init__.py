# backend/app/routes/auth_utils/__init__.py

"""
✅ auth 서브모듈 초기화

Google, Kakao, Naver 라우터를 외부에서 간편하게 import할 수 있도록 export 합니다.
예시:
    from app.routes.auth import google_router, kakao_router, naver_router
"""

from .google_auth import router as google_router
from .kakao_auth import router as kakao_router
from .naver_auth import router as naver_router
from .verify_token import router as verify_token_router

__all__ = ["google_router", "kakao_router", "naver_router", "verify_token_router"]
