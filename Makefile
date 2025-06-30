# ======================
# 🐳 Docker or Podman 자동 감지
# ======================
# 시스템에 'docker'가 설치되어 있으면 사용, 그렇지 않으면 'podman' 사용
DOCKER := $(shell command -v docker 2>/dev/null || command -v podman)

# ======================
# 🔄 Git 동기화 관련 기본 변수
# ======================
UPSTREAM ?= upstream    # 원본 리포 이름 (기본: upstream)
BRANCH ?= main          # 기준 브랜치 이름 (기본: main)

# ======================
# 🔖 주요 명령 정의
# ======================
.PHONY: help sync-main create-feature check-upstream \
        up down build logs restart \
        backend frontend db

# ======================
# 🆘 명령어 목록 출력
# ======================
help:
	@echo "🛠️ 사용 가능한 명령어 목록:"
	@echo ""
	@echo "🌀 Git 관련:"
	@echo "  make sync-main                - upstream/main → local main → origin/main 동기화"
	@echo "  make create-feature NAME=foo - 최신 main 기반 feature 브랜치 생성"
	@echo "  make check-upstream           - upstream 리모트 설정 확인"
	@echo ""
	@echo "🐳 Docker/PODMAN 관련:"
	@echo "  make up       - docker-compose 전체 실행 ($(DOCKER) 사용)"
	@echo "  make down     - 전체 중지 및 네트워크/볼륨 정리"
	@echo "  make build    - 전체 이미지 재빌드"
	@echo "  make logs     - 전체 로그 출력 (tail)"
	@echo "  make restart  - 중지 후 다시 시작"
	@echo ""
	@echo "🔧 컨테이너 내부 접속:"
	@echo "  make backend  - backend 컨테이너 bash 접속"
	@echo "  make frontend - frontend 컨테이너 bash 접속"
	@echo "  make db       - PostgreSQL psql 접속"

# ======================
# ✅ Git 관련 명령어
# ======================

# upstream이 등록되어 있는지 확인
check-upstream:
	@if ! git remote get-url $(UPSTREAM) >/dev/null 2>&1; then \
		echo "❌ [ERROR] '$(UPSTREAM)' 리모트가 존재하지 않습니다."; \
		echo "👉 다음 명령어로 추가하세요:"; \
		echo "   git remote add $(UPSTREAM) https://github.com/원본-유저명/원본-레포명.git"; \
		exit 1; \
	fi

# upstream/main → local main → origin/main 전체 동기화
sync-main: check-upstream
	git fetch $(UPSTREAM)
	git checkout $(BRANCH)
	git merge $(UPSTREAM)/$(BRANCH)
	git push origin $(BRANCH)

# 최신 main에서 새 feature 브랜치 생성
create-feature:
	@if [ -z "$(NAME)" ]; then \
		echo "❌ NAME이 필요합니다. 예: make create-feature NAME=feature/login"; \
		exit 1; \
	fi
	$(MAKE) sync-main
	git checkout -b $(NAME)

# ======================
# 🐳 Docker / Podman 명령어
# ======================

# 전체 서비스 실행 (빌드 포함)
up:
	$(DOCKER) compose up --build

# 전체 서비스 중지 및 정리
down:
	$(DOCKER) compose down

# 전체 서비스 재빌드 (캐시 활용)
build:
	$(DOCKER) compose build

# 실시간 로그 출력 (tail 100줄)
logs:
	$(DOCKER) compose logs -f --tail=100

# 전체 재시작
restart: down up

# ======================
# 🔧 컨테이너 내부 접속
# ======================

# backend 컨테이너 접속 (bash)
backend:
	$(DOCKER) exec -it job-navigator-backend /bin/bash

# frontend 컨테이너 접속 (bash)
frontend:
	$(DOCKER) exec -it job-navigator-frontend /bin/bash

# PostgreSQL 접속 (psql CLI)
db:
	$(DOCKER) exec -it job-navigator-db psql -U your_username -d your_database
