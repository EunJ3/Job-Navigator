from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.routes import job
from app.services import job_service
from app.core.config import load_env, get_settings
from app.routes import auth
from app.models.user import Base
from app.core.database import engine

# ✅ .env 파일 로드
load_env()
settings = get_settings()

app = FastAPI(
    title=settings["APP_NAME"],
    description="채용공고 대시보드를 위한 백엔드 API",
    version="1.0.0",
)

# ✅ CORS 설정
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings["CORS_ALLOWED_ORIGINS"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# DB 테이블 생성
# PgAdmin에서 쿼리문으로 이미 테이블 생성했음 -> 주석처리해도 무관
Base.metadata.create_all(bind=engine)


@app.get("/")
def read_root():
    return {"message": f"Welcome to the {settings['APP_NAME']} API!"}


app.include_router(job.router, prefix="/api/v1/jobs", tags=["Jobs"])

app.include_router(auth.router, prefix="/api/v1/auth", tags=["auth"])
