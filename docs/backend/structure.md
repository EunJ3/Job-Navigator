# 📘 Job Navigator 백엔드 구조 문서 (FastAPI 기반)

이 문서는 FastAPI에 익숙하지 않은 초기 개발자를 위해 작성된 백엔드 구조 안내서입니다. 프로젝트의 주요 구성 요소, 역할, 요청 흐름, 확장 포인트 등을 설명합니다.

---

## 📁 전체 디렉터리 구조

```
backend/
├── app/
│   ├── main.py              # 앱 진입점 (FastAPI 객체 생성 및 라우터 등록)
│   ├── core/
│   │   └── config.py        # 환경 설정 및 CORS 등 글로벌 설정
│   ├── models/
│   │   └── job.py           # SQLAlchemy ORM 모델 정의 (JobORM)
│   ├── schemas/
│   │   └── job.py           # Pydantic 모델 정의 (JobCreate, JobUpdate, JobOut)
│   ├── routes/
│   │   └── job.py           # 채용공고 관련 API 라우터 정의
│   └── services/
│       └── job_service.py   # 비즈니스 로직 및 DB 처리
├── tests/
│   └── test_job.py          # job API 테스트 코드
├── requirements.txt         # Python 의존성 정의
├── .env                     # 환경 변수 파일 (Git 제외)
└── .venv/                   # 가상환경 디렉토리 (Git 제외)
```

---

## ⚙️ FastAPI 요청 흐름

```
[Client]
  ↓
[main.py]
  ↓
[routes/job.py (라우팅)]
  ↓
[services/job_service.py (비즈니스 로직)]
  ↓
[models/job.py + schemas/job.py (DB 모델 + 직렬화)]
  ↓
응답 반환
```

---

## 🧰 주요 구성 요소 설명

### `main.py`
* FastAPI 인스턴스를 생성하고 라우터를 등록합니다.
* CORS 설정을 적용합니다 (`config.py`에서 설정값을 가져옴).

### `routes/job.py`
* `/api/v1/jobs` 경로에 대한 HTTP 라우팅 처리
* GET, POST, PUT 등 API 엔드포인트를 정의하고 서비스 로직 호출

### `services/job_service.py`
* SQLAlchemy를 이용해 DB CRUD 처리
* 샘플 데이터 삽입 또는 필터링 로직 구현

### `models/job.py`
* SQLAlchemy 기반 ORM 모델 정의 (`JobORM` 등)
* 실제 DB 테이블 구조와 매핑됨

### `schemas/job.py`
* `JobCreate`: POST 요청에서 사용
* `JobUpdate`: PUT 요청에서 사용
* `JobOut`: 응답 데이터 직렬화에 사용
* `JobListResponse`: 공고 리스트 (items)와 총 개수 (total_count)를 포함한 응답 스키마 (GET /jobs 응답 구조)

### `core/config.py`
* `.env` 파일을 로드하고, `CORS_ALLOWED_ORIGINS`를 처리하는 함수 포함

---

## 🧪 테스트 및 실행 예시

### FastAPI 서버 실행

```bash
uvicorn app.main:app --reload
```

### Swagger 문서 접속

* [http://localhost:8000/docs](http://localhost:8000/docs)

### 예시 요청: POST /api/v1/jobs

```json
{
  "title": "백엔드 개발자",
  "company": "AI Company",
  "location": "서울",
  "posted_date": "2025-06-10",
  "description": "FastAPI 경력자 우대"
}
```

---

## 💡 구조 설계의 장점

* 모든 컴포넌트를 분리하여 유지보수 용이
* 경량 구조이나 확장성 확보 (DB, 인증, 배포 등 대응 가능)
* 초보자도 요청 흐름을 따라가며 자연스럽게 FastAPI 구조 익힘

---

## 🚀 추천 확장 포인트

* ✅ PostgreSQL + SQLAlchemy 연동
* ✅ 검색/정렬 기능 및 query param 지원
* ✅ 페이지네이션 기능 추가
* ✅ 사용자 인증 (OAuth2, JWT 등)
* ✅ 유닛 테스트/통합 테스트 확대

---

## 📚 참고 링크

* [FastAPI 공식문서](https://fastapi.tiangolo.com/ko/)
* [Pydantic 공식문서](https://docs.pydantic.dev/)
* [Uvicorn](https://www.uvicorn.org/)
* [Swagger UI](https://swagger.io/tools/swagger-ui/)
