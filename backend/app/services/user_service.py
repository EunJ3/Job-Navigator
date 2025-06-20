from sqlalchemy.orm import Session
from app.models.user import User, UserUpdate

# 사용자 조회 함수
def get_user_by_id(db: Session, user_id: int):
    return db.query(User).filter(User.user_id == user_id).first()

# 사용자 수정 함수
def update_user(db: Session, user_id: int, user_update: UserUpdate):
    user = db.query(User).filter(User.user_id == user_id).first()
    if not user:
        return None
    
    # 이메일 중복 체크
    if user_update.email and user_update.email != user.email:
        email_exists = db.query(User).filter(User.email == user_update.email).first()
        if email_exists:
            raise ValueError("이미 사용 중인 이메일입니다.")
        
    # 변경할 필드 적용
    for key, value in user_update.dict(exclude_unset=True).items():
        if hasattr(value, "__str__"):
            value = str(value)
        setattr(user, key, value)

    db.commit()
    db.refresh(user)
    return user