# 🛠️ Job Navigator - Docker 기본 개발 환경 가이드

## 📆 구성 요약

* **backend/**: FastAPI (SQLite or PostgreSQL)
* **frontend/**: React (Vite)
* **PostgreSQL**: Docker container
* **Makefile**: Docker/Podman 자동 감지 + 버전 형태 규칙화

---

## 📅 사전 요구사항

* Docker 또는 Podman 설치
* Make (GNU Make) 설치
* `.env` 파일: `backend/.env`, `frontend/.env` 유지

---

## ⚡️ 실행 방법

```bash
make up         # 전체 서비스 실행 (build 포함)
make down       # 중지 및 컨테이너 삭제
make logs       # 일괄적 로그 통합 확인
make build      # 이미지 재빌드
make restart    # 중지 후 재시작
```

### 👉 Make를 사용하지 않는 경우

```bash
# 1. 이미지 빌드
cd backend && docker build -t job-navigator-backend .
cd ../frontend && docker build -t job-navigator-frontend .

# 2. docker-compose 직접 실행
cd ..  # 루트 디렉토리로 이동

docker-compose up -d      # 백그라운드 실행
docker-compose logs -f    # 로그 보기
docker-compose down       # 종료 및 정리
```

> Podman 사용자도 동일하게 `podman-compose` 또는 `alias docker=podman`으로 사용 가능

---

## 🔧 경로 변수 파일

### 📁 `backend/.env`

```
ENVIRONMENT=production
POSTGRES_USER=your_username
POSTGRES_PASSWORD=your_password
POSTGRES_DB=your_database
POSTGRES_HOST=db
POSTGRES_PORT=5432
CORS_ALLOWED_ORIGINS=http://localhost:3000
JWT_SECRET_KEY=your_secret
```

### 📁 `frontend/.env`

```
VITE_API_URL=http://localhost:8000/api
```

> 공용 API 주소는 Vite의 기본값에 맞춰 설정

---

## 📌 예상 접속 주소

* FastAPI: [http://localhost:8000/docs](http://localhost:8000/docs)
* React: [http://localhost:3000](http://localhost:3000)

---

## 🚀 Make 명령으로 포함된 기능

```bash
make backend    # 백엔드 컨테이너 bash 접속
make frontend   # 프론트 컨테이너 bash 접속
make db         # PostgreSQL 접속 (psql CLI)
```

---

## 🔄 개발 환경 전환

* `.env`에서 `ENVIRONMENT=development`로 설정하면 SQLite 사용 (로컬 개발용)
* `.env`에서 `ENVIRONMENT=production`으로 설정하면 PostgreSQL 사용 (Docker 환경 기준)
* 코드 변경 없이 환경값으로 DB 전환 가능

---

## 💭 참고 사항

* `.gitignore`에 `sqlite.db`, `.env`, `node_modules/` 등을 포함할 것
* 디렉토리 구조가 표준과 다를 경우 `Makefile`, `.env.example`, `README.md`를 통해 명시적으로 안내
