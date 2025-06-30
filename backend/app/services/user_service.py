from sqlalchemy.orm import Session
from app.models.user import UserORM
from app.schemas.user import UserUpdate
from typing import Optional

# 사용자 조회
def get_user_by_id(db: Session, user_id: int):
    return db.query(UserORM).filter(UserORM.user_id == user_id).first()

# 사용자 정보 수정
def update_user(db: Session, user_id: int, user_update: UserUpdate):
    user = db.query(UserORM).filter(UserORM.user_id == user_id).first()
    if not user:
        return None

    if user_update.email and user_update.email != user.email:
        email_exists = db.query(UserORM).filter(UserORM.email == user_update.email).first()
        if email_exists:
            raise ValueError("이미 사용 중인 이메일입니다.")

    for key, value in user_update.dict(exclude_unset=True).items():
        if hasattr(value, "__str__"):
            value = str(value)
        setattr(user, key, value)

    db.commit()
    db.refresh(user)
    return user

# ✅ 소셜 로그인 전용: 유저 없으면 생성, 있으면 업데이트
def get_or_create_user(
    db: Session,
    user_info: dict,
    social_provider: str,
) -> UserORM:
    user = db.query(UserORM).filter(
        UserORM.social_id == user_info["social_id"],
        UserORM.social_provider == social_provider,
    ).first()

    # 1차 조회 실패 시 이메일로 유저 조회
    if not user:
        user = db.query(UserORM).filter(UserORM.email == user_info["email"]).first()
        if user:
            user.social_provider = social_provider
            user.social_id = user_info["social_id"]

    if not user:
        user = UserORM(
            social_provider=social_provider,
            social_id=user_info["social_id"],
            email=user_info["email"],
            name=user_info.get("name"),
            profile_image=user_info.get("profile_image"),
            is_active=True,
        )
        db.add(user)

    db.commit()
    db.refresh(user)
    return user
