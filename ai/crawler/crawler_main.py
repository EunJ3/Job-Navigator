"""
sequenceDiagram
  participant Main as 🧠 crawler_main.py
  participant Crawler as 📡 jumpit_crawler.py
  participant DBSave as 💾 save_jobs.py
  participant Mark as 🚫 mark_closed.py

  Main->>Crawler: get_jumpit_jobs()
  Crawler-->>Main: 채용 공고 리스트 반환 (List[Dict])

  Main->>DBSave: save_jobs_to_db(jobs)
  DBSave-->>Main: 저장 완료

  Main->>Mark: mark_closed_jobs(url_list)
  Mark-->>Main: 마감 처리 완료
"""

# 🚀 크롤링 전체 프로세스 실행 스크립트

# 📡 Jumpit 사이트에서 채용공고 크롤링 함수
from services.jumpit_crawler import get_jumpit_jobs

# 💾 수집한 공고를 DB에 저장 (신규/업데이트 구분)
from repository.save_jobs import save_jobs_to_db

# 🚫 DB에 저장된 공고 중, 현재 페이지에서 사라진 공고를 마감처리
from repository.mark_closed import mark_closed_jobs


def main():
    print("📡 Jumpit 채용 공고 수집 시작")
    jobs = get_jumpit_jobs()  # ⬅️ 채용공고 리스트 크롤링
    print(f"📦 수집된 공고 수: {len(jobs)}개")

    print("💾 DB 저장 시작")
    save_jobs_to_db(jobs)  # ⬅️ DB에 insert/update 처리

    print("📛 마감된 공고 처리 시작")
    latest_urls = [job["url"] for job in jobs]
    mark_closed_jobs(latest_urls)  # ⬅️ DB 내 기존 공고 중 사라진 공고 마감 처리

    print("✅ 모든 작업 완료")


if __name__ == "__main__":
    main()
