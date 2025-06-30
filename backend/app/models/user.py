# 파일명: user.py

from sqlalchemy import Column, Integer, String, Boolean, DateTime, func, UniqueConstraint
from app.core.database import Base


# 사용자(User) 정보를 저장하는 SQLAlchemy ORM 모델입니다.
class UserORM(Base):
    __tablename__ = "users"

    # 사용자 고유 ID (Primary Key)
    user_id = Column(Integer, primary_key=True, index=True)

    # 소셜 로그인 제공자
    social_provider = Column(String(20), nullable=False)

    # 소셜 로그인 ID
    social_id = Column(String(100), nullable=False)

    # 사용자 이메일
    email = Column(String(100), nullable=False)

    # 사용자 이름
    name = Column(String(100))

    # 프로필 이미지 URL
    profile_image = Column(String(300))

    # 계정 활성화 여부 (default: True)
    is_active = Column(Boolean, default=True)

    # 생성일시
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    # 복합 유니크 인덱스
    __table_args__ = (
        UniqueConstraint("social_provider", "social_id", name="uq_users_social"),
    )
