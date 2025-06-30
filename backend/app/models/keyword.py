# backend/app/models/keyword.py

from sqlalchemy import Column, Integer, String, ForeignKey, JSON
from app.core.database import Base

class Keyword(Base):
    __tablename__ = "keywords"

    id = Column(Integer, primary_key=True, index=True)
    file_id = Column(String, unique=True, nullable=False)       # UUID
    filename = Column(String, nullable=False)                   # 원본 파일명
    keywords = Column(JSON, nullable=False)                     # ["Python", "NLP", ...]
    user_id = Column(Integer, ForeignKey("users.user_id"), nullable=False)
