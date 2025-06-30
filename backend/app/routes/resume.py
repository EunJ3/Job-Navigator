# backend/app/routes/resume.py

from fastapi import APIRouter, UploadFile, File, Depends, HTTPException
from sqlalchemy.orm import Session
from app.routes.auth_utils.jwt_utils import get_current_user
from app.services.keyword_service import extract_and_save_keywords
from app.core.database import SessionLocal
from app.models.resume import ResumeORM
from app.models.user import UserORM
from app.schemas.resume import ResumeOut
from typing import List
import logging

router = APIRouter()
logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO)

# ✅ 1. PDF 업로드 + 키워드 추출 + 저장
@router.post("/", response_model=ResumeOut)
async def upload_resume_and_extract_keywords(
    pdf_file: UploadFile = File(...),
    current_user: UserORM = Depends(get_current_user)
):
    """
    PDF 파일을 업로드하고 키워드를 추출하여 이력서로 저장합니다.
    """
    logger.info(f"📥 파일 업로드 요청 - 사용자 ID: {current_user.user_id}, 파일명: {pdf_file.filename}")

    if pdf_file.content_type != "application/pdf":
        logger.warning("❌ 잘못된 파일 형식 업로드 시도")
        raise HTTPException(status_code=400, detail="PDF 파일만 업로드 가능합니다.")

    result = await extract_and_save_keywords(current_user, pdf_file)
    return ResumeOut.model_validate(result)  # ✅ Pydantic v2 변환


# ✅ 2. 내 이력서 목록 조회
@router.get("/", response_model=List[ResumeOut])
async def get_my_resumes(current_user: UserORM = Depends(get_current_user)):
    """
    로그인한 사용자의 이력서 목록을 조회합니다.
    """
    db: Session = SessionLocal()
    resumes = db.query(ResumeORM).filter(ResumeORM.user_id == current_user.user_id).all()
    db.close()
    return [ResumeOut.model_validate(r) for r in resumes]  # ✅ 리스트 반환 시 각 항목 변환


# ✅ 3. 특정 이력서 상세 조회
@router.get("/{resume_id}", response_model=ResumeOut)
async def get_resume_detail(resume_id: int, current_user: UserORM = Depends(get_current_user)):
    """
    특정 이력서(resume_id)의 키워드 및 직무 분류 정보를 조회합니다.
    """
    db: Session = SessionLocal()
    resume = db.query(ResumeORM).filter(
        ResumeORM.resume_id == resume_id,
        ResumeORM.user_id == current_user.user_id
    ).first()
    db.close()

    if not resume:
        raise HTTPException(status_code=404, detail="해당 이력서를 찾을 수 없습니다.")
    return ResumeOut.model_validate(resume)  # ✅ 단건 변환
