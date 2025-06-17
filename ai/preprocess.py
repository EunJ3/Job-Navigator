import re
from typing import List, Dict

TECH_KEYWORDS = [
    "보유 기술", "보 유 기 술", "기술 스택", "Tech Stack", "사용 기술",
    "활용 언어", "개발 환경", "기술 역량", "능숙한 기술", "사용한 언어",
    "사용 가능한 기술", "활용 가능한 기술", "사용 언어", "프로그래밍 기술",
    "언어 및 도구", "Language / Framework", "기술 경험", "주요 기술"
]

CAREER_KEYWORDS = [
    "경력", "경 력", "경험", "직무 경험", "프로젝트 경험", "실무 경험",
    "경력 사항", "경력 기술서", "경력 요약"
]

ESSAY_KEYWORDS = [
    "자기소개서", "자 기 소 개 서", "자소서", "입사 후 포부", "성장 과정",
    "성격의 장단점", "지원 동기", "포부"
]

def normalize_vertical_text(text: str) -> str:
    lines = text.split("\n")
    merged_lines = []
    buffer = []
    for line in lines:
        stripped = line.strip()
        if len(stripped) == 1:
            buffer.append(stripped)
        else:
            if len(buffer) >= 2:
                merged_lines.append("".join(buffer))
                buffer = []
            merged_lines.append(stripped)
    if len(buffer) >= 2:
        merged_lines.append("".join(buffer))
    return "\n".join(merged_lines)

def extract_sections_by_block(text: str, keywords: List[str]) -> List[Dict]:
    """
    키워드로 섹션 시작을 감지하여 섹션 블록(제목~다음 제목 전까지)으로 추출
    """
    lines = text.splitlines()
    result = []
    current_lines = []
    current_keyword = None

    # 키워드 패턴 미리 정규식으로 준비
    keyword_patterns = [
        (keyword, re.compile(re.escape(keyword).replace(r'\ ', r'\s*'), re.IGNORECASE))
        for keyword in keywords
    ]

    for line in lines:
        matched = None
        for keyword, pattern in keyword_patterns:
            if pattern.search(line):
                matched = keyword
                break

        if matched:
            # 기존 블록 저장
            if current_keyword and current_lines:
                result.append({
                    'matched_keyword': current_keyword,
                    'block': "\n".join(current_lines).strip()
                })
            # 새 블록 시작
            current_keyword = matched
            current_lines = [line]
        else:
            if current_keyword:
                current_lines.append(line)

    # 마지막 블록 저장
    if current_keyword and current_lines:
        result.append({
            'matched_keyword': current_keyword,
            'block': "\n".join(current_lines).strip()
        })
    return result

def classify_resume_sections_block(text: str) -> Dict[str, List[Dict]]:
    cleaned = normalize_vertical_text(text)
    return {
        'tech_sections': extract_sections_by_block(cleaned, TECH_KEYWORDS),
        'career_sections': extract_sections_by_block(cleaned, CAREER_KEYWORDS),
        'essay_sections': extract_sections_by_block(cleaned, ESSAY_KEYWORDS)
    }
