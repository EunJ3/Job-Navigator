# 📄 직무 분류 로직 (텍스트 기반 키워드 매칭 방식)

# ✅ 4가지 직무 카테고리별 키워드 정의
# - 추후 확장을 고려하여 범위를 넓게 설정
# - 대소문자 구분 없이 처리됨
JOB_CATEGORIES = {
    "backend": [
        "백엔드", "Back-End", "Backend", "서버 개발", "Server",
        "Node.js", "Node", "Django", "Spring", "Spring Boot", "Flask",
        "Express", "NestJS", "Nest", "Koa", "Rails", "Laravel",
        "Golang", "Go", "Java", "Python", "FastAPI", "ASP.NET", "API 서버"
    ],
    "frontend": [
        "프론트엔드", "Front-End", "Frontend", "React", "React.js", "Vue", "Vue.js",
        "Angular", "Svelte", "Next.js", "Nuxt.js",
        "TypeScript", "Javascript", "JS", "HTML", "CSS", "웹 퍼블리셔", "웹 UI", "UI 개발"
    ],
    "mobile": [
        "모바일", "iOS", "iPhone", "안드로이드", "Android", "모바일 앱", "앱 개발",
        "Swift", "Kotlin", "Objective-C", "Flutter", "React Native", "RN"
    ],
    "data": [
        "데이터", "Data", "데이터 분석", "데이터 사이언스", "AI", "인공지능",
        "머신러닝", "Machine Learning", "ML", "딥러닝", "Deep Learning", "DL",
        "TensorFlow", "PyTorch", "Pandas", "Scikit-learn", "Spark", "BigQuery",
        "데이터 엔지니어", "데이터 과학자"
    ]
}


def classify_job(title: str, tech_stack: str) -> str:
    """
    주어진 채용 공고 제목과 기술 스택 문자열을 기반으로 직무를 분류합니다.
    - 사전에 정의된 키워드가 포함되면 해당 직무 카테고리로 분류
    - 일치하는 키워드가 없다면 'other'로 처리

    Parameters:
        title (str): 공고 제목
        tech_stack (str): 기술 스택 문자열

    Returns:
        str: backend | frontend | mobile | data | other 중 하나
    """
    text = f"{title} {tech_stack}".lower()

    for job_type, keywords in JOB_CATEGORIES.items():
        for keyword in keywords:
            if keyword.lower() in text:
                return job_type

    return "other"
