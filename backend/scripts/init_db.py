# scripts/init_db.py

from app.core.database import engine
from app.models.user import Base as UserBase
from app.models.job import Base as JobBase


def create_tables():
    UserBase.metadata.create_all(bind=engine)
    JobBase.metadata.create_all(bind=engine)
    print("✅ All tables created.")


if __name__ == "__main__":
    create_tables()
