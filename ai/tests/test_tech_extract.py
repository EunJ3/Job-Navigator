import sys
from pathlib import Path


def setup_paths_and_imports():
    current_file = Path(__file__).resolve()
    current_dir = current_file.parent
    ai_dir = current_dir.parent
    project_root = ai_dir.parent
    paths_to_add = [str(project_root), str(ai_dir)]
    for path in paths_to_add:
        if path not in sys.path:
            sys.path.insert(0, path)
    from tech_dict import TECH_STACK, JOB_TECH_MAP
    from pdf_extractor import extract_text_from_pdf
    from tech_extract import (
        extract_tech_keywords_union,
        recommend_best_job,
        get_top_used_skills,
        filter_by_job,
        normalize,
        normalize_tech_name,
        filter_appeared_in_text,
    )

    return {
        "TECH_STACK": TECH_STACK,
        "JOB_TECH_MAP": JOB_TECH_MAP,
        "extract_text_from_pdf": extract_text_from_pdf,
        "extract_tech_keywords_union": extract_tech_keywords_union,
        "recommend_best_job": recommend_best_job,
        "get_top_used_skills": get_top_used_skills,
        "filter_by_job": filter_by_job,
        "normalize": normalize,
        "normalize_tech_name": normalize_tech_name,
        "filter_appeared_in_text": filter_appeared_in_text,
        "current_dir": current_dir,
    }


def print_resume_job_result_for_files(pdf_files):
    modules = setup_paths_and_imports()
    for pdf_path in pdf_files:
        print(f"\n===== 📄 [{pdf_path.name}] 이력서 분석 결과 =====")
        try:
            resume_text = modules["extract_text_from_pdf"](str(pdf_path))
            if not resume_text.strip():
                print("⚠️ PDF에서 텍스트를 추출하지 못했습니다.")
                continue

            all_techs = modules["extract_tech_keywords_union"](
                resume_text, modules["TECH_STACK"]
            )
            print(f"\n🔍 전체 추출 기술 (raw): {all_techs}")

            norm_text = modules["normalize"](resume_text)
            appeared_techs = []
            for tech in all_techs:
                norm_tech = modules["normalize"](tech)
                if norm_tech in norm_text:
                    appeared_techs.append(tech)

            print(f"✅ 실제 등장 기술 (정규화 기준): {appeared_techs}")

            best_job = modules["recommend_best_job"](resume_text, all_techs)
            job_techs = modules["filter_by_job"](appeared_techs, best_job)
            top_skills = modules["get_top_used_skills"](resume_text, job_techs, top_n=7)

            print(f"🏷️ 대표 직무: {best_job if best_job else '❌ 매칭 없음'}")
            print(
                f"⭐ 사용자 기술스택 Top 7 (직무 기준): {top_skills if top_skills else '❌ 없음'}"
            )
        except Exception as e:
            print(f"❌ 오류 발생: {e}")
def test_resume_extraction_runs_without_error():
    from pathlib import Path

    modules = setup_paths_and_imports()
    sample_pdf = Path(modules["current_dir"]) / "sample_resume.pdf"
    result = None

    try:
        text = modules["extract_text_from_pdf"](str(sample_pdf))
        assert text.strip() != "", "PDF 텍스트 추출 실패"

        all_techs = modules["extract_tech_keywords_union"](text)
        best_job = modules["recommend_best_job"](text, all_techs)
        job_techs = modules["filter_by_job"](all_techs, best_job)
        top_skills = modules["get_top_used_skills"](text, job_techs)

        result = {
            "raw_techs": all_techs,
            "job": best_job,
            "job_techs": job_techs,
            "top_skills": top_skills,
        }

    except Exception as e:
        assert False, f"예외 발생: {e}"

    assert result is not None and len(result["top_skills"]) > 0



if __name__ == "__main__":
    current_dir = Path(__file__).resolve().parent
    pdf_files = sorted(current_dir.glob("sample_resume*.pdf"))
    if not pdf_files:
        print("❗ 테스트할 PDF 파일이 없습니다.")
    else:
        print_resume_job_result_for_files(pdf_files)
