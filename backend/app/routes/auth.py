# backend/app/routes/auth.py

"""
✅ Auth 라우터 통합 모듈

Google, Kakao, Naver 각각의 소셜 로그인 라우터를 통합하여
main.py에서는 단 하나의 auth.router만 등록해도 전체 라우트가 활성화되도록 구성합니다.

최종 라우팅 예:
  - POST /api/v1/auth/google-login
  - POST /api/v1/auth/kakao-login
  - POST /api/v1/auth/naver-login

각 소셜 로그인 라우터는 app/routes/auth_utils/__init__.py에서 export됩니다.
"""

from fastapi import APIRouter
from app.routes.auth_utils import google_router, kakao_router, naver_router, verify_token_router

# 🔗 메인 auth 라우터 생성
router = APIRouter()

# 🧩 서브 라우터 등록
router.include_router(google_router)
router.include_router(kakao_router)
router.include_router(naver_router)
router.include_router(verify_token_router)
