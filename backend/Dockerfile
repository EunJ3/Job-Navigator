# Python 3.10을 기반으로 한 슬림 이미지 사용 (용량 최적화)
FROM python:3.10-slim

# 컨테이너 내부에서 작업할 디렉토리 설정
WORKDIR /app

# OS 패키지 업데이트 및 필수 패키지 설치
# - netcat: DB 연결 체크용 (docker-compose wait-for-db)
# - gcc, libpq-dev: psycopg2 등 C 기반 의존성 빌드용
RUN apt-get update && apt-get install -y \
    netcat-openbsd \
    gcc \
    libpq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Python 패키지 설치를 위한 requirements.txt 복사 및 설치
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# FastAPI 애플리케이션 코드 복사
COPY ./app ./app

# FastAPI 앱 실행 명령
# --reload는 코드 변경 시 자동 리로드 기능 (개발 환경 전용)
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
