# 파일 경로: ai/crawler/repository/db.py

from sqlalchemy import create_engine
import os
import dotenv

# 🔐 ai/crawler/.env 파일 경로를 명시적으로 지정
dotenv_path = os.path.abspath(os.path.join(os.path.dirname(__file__), "../.env"))
dotenv.load_dotenv(dotenv_path=dotenv_path)

# 📦 환경변수로부터 PostgreSQL 연결 정보 구성
DB_URL = (
    f"postgresql+psycopg2://{os.getenv('POSTGRES_USER')}:{os.getenv('POSTGRES_PASSWORD')}"
    f"@{os.getenv('POSTGRES_HOST')}:{os.getenv('POSTGRES_PORT')}/{os.getenv('POSTGRES_DB')}"
)

# 🔗 SQLAlchemy 엔진 생성
engine = create_engine(DB_URL)
