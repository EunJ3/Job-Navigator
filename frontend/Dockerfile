# Node.js 기반 프론트엔드 빌드용 이미지
FROM node:20

# 컨테이너 내 작업 디렉토리 설정
WORKDIR /app

# 의존성 설치 (캐시 활용을 위해 먼저 복사)
COPY package*.json ./
RUN npm install

# 앱 전체 코드 복사
COPY . .

# Vite로 정적 빌드 수행
RUN npm run build

# 빌드된 결과를 serve 패키지로 서비스 (개발환경용, production은 nginx 추천)
RUN npm install -g serve
CMD ["serve", "-s", "dist", "-l", "3000"]
