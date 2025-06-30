# backend/app/schemas/resume.py

from pydantic import BaseModel
from typing import List
from datetime import datetime

# ✅ 이력서 조회 응답 스키마 (Pydantic v2 기준 + user_id 포함)
class ResumeOut(BaseModel):
    resume_id: int             # 이력서 ID
    user_id: int               # 사용자 ID
    file_path: str             # 저장된 파일 경로
    extracted_keywords: List[str]  # 추출된 키워드 목록
    job_category: str          # 기술 분류 결과 (예: 백엔드, 프론트엔드)
    created_at: datetime       # 업로드 시간

    model_config = {
        "from_attributes": True  # ✅ Pydantic v2 방식: ORM 객체 → 스키마 변환 허용
    }
