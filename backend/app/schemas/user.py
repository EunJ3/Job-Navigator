# backend/app/schemas/user.py

from pydantic import BaseModel, EmailStr, HttpUrl
from typing import Optional
from datetime import datetime

# DB에 저장된 사용자 데이터를 클라이언트로 반환할 때 사용되는 스키마
class UserResponse(BaseModel):
    user_id: int
    social_provider: str
    social_id: str
    email: EmailStr
    name: Optional[str] = None
    profile_image: Optional[str] = None
    is_active: bool
    created_at: datetime
    access_token: str

    class Config:
        from_attributes = True


# 내 정보 조회 시 반환할 스키마
class UserOut(BaseModel):
    user_id: int
    email: EmailStr
    name: Optional[str] = None
    profile_image: Optional[HttpUrl] = None
    is_active: bool
    created_at: datetime

    class Config:
        from_attributes = True


# 사용자 정보 수정 시 사용되는 요청용 스키마
class UserUpdate(BaseModel):
    name: Optional[str] = None
    profile_image: Optional[HttpUrl] = None
    email: Optional[EmailStr] = None