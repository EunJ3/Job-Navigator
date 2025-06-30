import os
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.routes import job, user, auth, bookmark
from app.services import job_service
from app.core.config import load_env, get_settings
# from app.models.user import Base as UserBase
# from app.models.job import Base as JobBase
from app.core.database import engine
from app.routes import user
from fastapi.staticfiles import StaticFiles
from app.routes import resume
from app.core.swagger import custom_openapi

# ✅ 환경 변수 로드 및 설정 초기화
load_env()
settings = get_settings()

os.makedirs("static", exist_ok=True)

# ✅ FastAPI 애플리케이션 인스턴스 생성
app = FastAPI(
    title=settings["APP_NAME"],
    description="채용공고 대시보드를 위한 백엔드 API",
    version="1.0.0",
)

# ✅ CORS 미들웨어 설정
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings["CORS_ALLOWED_ORIGINS"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ✅ 개발 환경에서는 테이블 자동 생성 허용
#if settings.get("ENV") != "production":
#    UserBase.metadata.create_all(bind=engine)
#    JobBase.metadata.create_all(bind=engine)

# ✅ 루트 경로 응답
@app.get("/")
def read_root():
    return {"message": f"Welcome to the {settings['APP_NAME']} API!"}
  
app.mount("/static", StaticFiles(directory="static"), name="static")

# ✅ 라우터 등록
app.include_router(job.router, prefix="/api/v1/jobs", tags=["Jobs"])
app.include_router(auth.router, prefix="/api/v1/auth", tags=["Auth"])
app.include_router(user.router, prefix="/api/v1/users", tags=["User"])
app.include_router(resume.router, prefix="/api/v1/resume", tags=["Resume"])
app.include_router(bookmark.router, prefix="/api/v1/bookmarks", tags=["Bookmark"])

# ✅ Swagger JWT 인증 커스터마이징 적용
app.openapi = lambda: custom_openapi(app)
