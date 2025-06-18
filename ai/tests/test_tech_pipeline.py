from pathlib import Path
from ai.tech_pipeline import run_tech_pipeline


def test_single_resume():
    pdf_path = Path("ai/tests/sample_resume.pdf")
    result = run_tech_pipeline(pdf_path)

    print("\n===== 📄 분석 결과 =====")
    print(f"📁 파일명: {result['file_name']}")
    print(f"🔍 전체 추출 기술 (raw): {result['raw_techs']}")
    print(f"✅ 실제 등장 기술: {result['appeared_techs']}")
    print(f"🏷️ 대표 직무: {result['job']}")
    print(f"📌 직무 관련 기술: {result['job_techs']}")
    print(f"⭐ Top 7 기술스택: {result['top_skills']}")


if __name__ == "__main__":
    test_single_resume()
