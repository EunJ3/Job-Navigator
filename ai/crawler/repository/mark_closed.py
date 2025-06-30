# 📛 모집 마감된 공고를 is_active = False로 처리하는 스크립트

from sqlalchemy import text
from .database import engine  # 🔗 공통 DB 연결 모듈 불러오기


def mark_closed_jobs(latest_urls: list[str]):
    """
    현재 DB에 저장된 공고들 중, 이번 크롤링 결과에 포함되지 않은 것들을
    모집 마감 상태 (is_active=False) 로 변경하는 함수

    Parameters:
        latest_urls (list[str]): 이번 크롤링에서 가져온 모든 공고 URL 리스트
    """
    with engine.connect() as conn:
        # ✅ 현재 DB에 저장된 '활성화 상태' 공고들의 URL 조회
        db_urls = conn.execute(
            text("SELECT url FROM jobs WHERE is_active = TRUE")
        ).fetchall()
        db_urls = [row[0] for row in db_urls]

        # ✅ 이번에 크롤링되지 않은 → 사라진 공고들
        closed_urls = list(set(db_urls) - set(latest_urls))

        if not closed_urls:
            print("📢 마감된 공고 없음")
            return

        # ✅ 해당 URL들의 is_active 값을 False로 업데이트
        stmt = text("UPDATE jobs SET is_active = FALSE WHERE url = ANY(:urls)")
        conn.execute(stmt, {"urls": closed_urls})
        conn.commit()

        print(f"📛 모집 마감 처리 완료: {len(closed_urls)}건")
