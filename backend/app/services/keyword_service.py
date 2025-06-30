# backend/app/services/keyword_service.py

import os
import uuid
import shutil
import logging
from fastapi import UploadFile
from sqlalchemy.orm import Session
from ai.extractor import extract_keywords_from_pdf  # AI 키워드 추출 함수
from app.core.database import SessionLocal
from app.models.resume import ResumeORM
from app.models.user import UserORM

logger = logging.getLogger(__name__)

async def extract_and_save_keywords(current_user: UserORM, pdf_file: UploadFile) -> ResumeORM:
    """
    PDF 파일을 저장한 후 키워드를 추출하고, 관련 정보를 Resume 테이블에 저장합니다.

    Parameters:
        current_user (UserORM): 인증된 사용자 객체
        pdf_file (UploadFile): 업로드된 PDF 파일 객체

    Returns:
        ResumeORM: 저장된 이력서 ORM 객체
    """
    # 1. 임시 파일로 저장
    file_id = str(uuid.uuid4())
    filename = pdf_file.filename
    temp_dir = "./temp"
    os.makedirs(temp_dir, exist_ok=True)
    file_path = os.path.join(temp_dir, f"{file_id}_{filename}")

    with open(file_path, "wb") as buffer:
        shutil.copyfileobj(pdf_file.file, buffer)

    logger.info(f"📄 PDF 저장 완료: {file_path}")

    # 2. AI 키워드 추출
    with open(file_path, "rb") as f:
        file_bytes = f.read()
    keywords = extract_keywords_from_pdf(file_bytes)

    logger.info(f"🧠 키워드 추출 결과: {keywords}")

    # 3. DB 저장
    db: Session = SessionLocal()
    try:
        resume_entry = ResumeORM(
            user_id=current_user.user_id,
            file_path=file_path,
            extracted_keywords=keywords,
            job_category="",  # 분류 결과는 아직 없음
        )
        db.add(resume_entry)
        db.commit()
        db.refresh(resume_entry)  # 저장된 ORM 객체 정보 최신화
        return resume_entry       # ✅ 스키마와 일치하는 ORM 객체 반환
    except Exception as e:
        db.rollback()
        logger.error("❌ Resume 저장 실패", exc_info=True)
        raise e
    finally:
        db.close()

