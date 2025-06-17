from pdf_extractor import extract_text_from_pdf
from preprocess import (
    normalize_vertical_text,
    extract_sections_by_block,
    classify_resume_sections_block
)

SAMPLE_PDF_PATH = "tests/sample_resume.pdf"

def test_pdf_extraction():
    text = extract_text_from_pdf(SAMPLE_PDF_PATH)
    assert isinstance(text, str) and len(text) > 0
    print("[✓] PDF 텍스트 추출 성공")

def test_vertical_to_horizontal():
    vertical = "보\n유\n기\n술\n\nPython\nDjango"
    result = normalize_vertical_text(vertical)
    assert "보유기술" in result
    print("[✓] 세로쓰기 변환 통과")

def test_section_block_classify():
    text = extract_text_from_pdf(SAMPLE_PDF_PATH)
    sections = classify_resume_sections_block(text)
    assert any(sections.values()), "최소 1개 섹션 추출 필요"
    print("[✓] 섹션 블록 분류 통과")

    for sec_name, sec_list in sections.items():
        print(f"=== {sec_name} ===")
        for idx, s in enumerate(sec_list):
            print(f"--- {idx+1} ---")
            print(f"키워드: {s['matched_keyword']}")
            print(s['block'][:300])  # 블록 내용 앞부분만, 너무 길면 잘라서
            print("---------------")

if __name__ == "__main__":
    test_pdf_extraction()
    test_vertical_to_horizontal()
    test_section_block_classify()
