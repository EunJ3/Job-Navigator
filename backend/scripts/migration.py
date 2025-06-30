# backend/scripts/migration.py

import sys
import os

# ✅ app 모듈 경로 인식
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from app.models.user import UserORM
from app.models.job import JobORM
from app.models.resume import ResumeORM
from app.models.roadmap import RoadmapORM
from backend.app.models.bookmark import FavoriteJobORM
from app.models.tech_trend import TechTrendORM

# ✅ .env 로드 (.env 경로를 절대경로로 처리)
env_path = os.path.join(os.path.dirname(__file__), "..", ".env")
load_dotenv(dotenv_path=os.path.abspath(env_path))

# ✅ 환경변수 로딩
POSTGRES_USER = os.getenv("POSTGRES_USER")
POSTGRES_PASSWORD = os.getenv("POSTGRES_PASSWORD")
POSTGRES_DB = os.getenv("POSTGRES_DB")
POSTGRES_PORT = os.getenv("POSTGRES_PORT", "5432")

# ✅ DB URL
LOCAL_DB_URL = f"postgresql://{POSTGRES_USER}:{POSTGRES_PASSWORD}@localhost:{POSTGRES_PORT}/{POSTGRES_DB}"
DOCKER_DB_URL = f"postgresql://{POSTGRES_USER}:{POSTGRES_PASSWORD}@localhost:{POSTGRES_PORT}/{POSTGRES_DB}"

# ✅ SQLAlchemy 세션 생성
local_engine = create_engine(LOCAL_DB_URL)
docker_engine = create_engine(DOCKER_DB_URL)
LocalSession = sessionmaker(bind=local_engine)
DockerSession = sessionmaker(bind=docker_engine)

def migrate():
    local_db = LocalSession()
    docker_db = DockerSession()

    try:
        for model, name in [
            (UserORM, "users"),
            (JobORM, "jobs"),
            (ResumeORM, "resumes"),
            (RoadmapORM, "roadmaps"),
            (FavoriteJobORM, "user_favorite_posts"),
            (TechTrendORM, "tech_trends"),
        ]:
            rows = local_db.query(model).all()
            for row in rows:
                docker_db.merge(row)
            print(f"✅ {name} 테이블 마이그레이션 완료 ({len(rows)}건)")

        docker_db.commit()
        print("🎉 전체 마이그레이션 성공!")

    except Exception as e:
        docker_db.rollback()
        print(f"❌ 오류 발생: {e}")

    finally:
        local_db.close()
        docker_db.close()

if __name__ == "__main__":
    migrate()
