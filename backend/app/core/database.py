import os
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base
from dotenv import load_dotenv

Base = declarative_base()

# ✅ .env 파일 로드 (.env 환경변수 사용 가능하게 설정)
load_dotenv()

# ✅ 실행 환경 구분: 기본값은 "development"
ENV = os.getenv("ENVIRONMENT", "development")

# ✅ 데이터베이스 URL 설정
if ENV == "production":
    # 👉 PostgreSQL 설정 (프로덕션 환경)
    DB_USER = os.getenv("POSTGRES_USER")
    DB_PASSWORD = os.getenv("POSTGRES_PASSWORD")
    DB_HOST = os.getenv("POSTGRES_HOST", "localhost")
    DB_PORT = os.getenv("POSTGRES_PORT", "5432")
    DB_NAME = os.getenv("POSTGRES_DB")

    # ✅ PostgreSQL 접속 URL 생성
    SQLALCHEMY_DATABASE_URL = (
        f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
    )
else:
    # 👉 SQLite 설정 (개발/로컬 테스트 환경)
    SQLITE_PATH = os.getenv("SQLITE_DB_PATH", "./app/sqlite.db")

    # ✅ SQLite 접속 URL 생성
    SQLALCHEMY_DATABASE_URL = f"sqlite:///{SQLITE_PATH}"

# ✅ SQLite는 멀티스레드 접근을 허용하지 않기 때문에 옵션 설정 필요
connect_args = (
    {"check_same_thread": False} if SQLALCHEMY_DATABASE_URL.startswith("sqlite") else {}
)

# ✅ SQLAlchemy 엔진 생성
engine = create_engine(SQLALCHEMY_DATABASE_URL, connect_args=connect_args)

# ✅ 세션 팩토리: 요청마다 개별 세션을 생성하도록 설정
SessionLocal = sessionmaker(
    autocommit=False,
    autoflush=False,
    bind=engine,
)

# 공통 Base 클래스 정의
Base = declarative_base()


# ✅ FastAPI Dependency로 사용할 수 있는 DB 세션 생성 함수
# - 요청마다 호출되어 DB 연결을 생성하고, 작업 후 종료
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
