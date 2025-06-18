# 🧑‍💻 협업자(fork) 기준 Git 동기화 및 브랜치 병합 가이드

## 📘 용어 정리

| 용어              | 설명                                               |
| --------------- | ------------------------------------------------ |
| **origin**      | 내 GitHub 계정에 있는 fork 저장소 (개인 저장소)                |
| **upstream**    | 원본 저장소(PM 또는 팀 저장소) — 내가 fork한 대상                |
| **main**        | 기준이 되는 주 브랜치 (master의 최신 대체 명칭)                  |
| **feature/xxx** | 기능 개발용 브랜치 (예: feature/login, feature/job-api 등) |

---

## ✅ 1. 내 origin/main을 upstream/main으로 동기화하기

### 📌 상황

* 본인의 GitHub 저장소는 원본 저장소(`upstream`)를 fork한 상태
* 원본 저장소(`upstream`)의 최신 `main` 내용을 가져와서 내 저장소(`origin`)의 `main`을 최신 상태로 유지하고 싶을 때

### 📂 동기화 흐름

```
upstream/main → local main → origin/main
```

### 💻 명령어 순서

```bash
# 1. upstream 원격 저장소 등록 (최초 1회만)
git remote add upstream https://github.com/ChoiJaeWoon/Job-Navigator.git

# 2. upstream 저장소에서 최신 main 가져오기
git fetch upstream

# 3. 내 로컬 main 브랜치로 이동
git checkout main

# 4. upstream/main을 로컬 main에 병합
git merge upstream/main

# 5. 병합된 내용을 origin(main)에 push
git push origin main
```

---

## ✅ 2. 동기화된 main 내용을 작업 브랜치에 반영하기 (merge 방식)

### 📌 상황

* 이미 `feature/xxx` 브랜치에서 작업 중
* `main` 브랜치를 upstream 기준으로 최신화 완료했음
* 이 최신화된 내용을 내 작업 브랜치에 반영하고 싶을 때

### 📂 동기화 흐름

```
main → feature/xxx
```

### 💻 명령어 순서

```bash
# 1. 작업 브랜치로 이동
git checkout feature/xxx

# 2. 최신 main 브랜치의 변경사항 병합
git merge main
```

> ⚠️ 충돌 발생 시 충돌 해결 후 아래와 같이 커밋합니다.

```bash
git add .
git commit
```

---

## ✅ 참고

* `main`은 항상 **upstream 기준으로 최신화**해야 함
* PR 전에는 반드시 최신 main을 병합해서 충돌을 최소화해야 함
* **merge 방식만 사용하도록 통일** — rebase는 생략함 (초보 협업자 기준)

---

## 🧠 요약

| 목적                       | 명령어 흐름               |
| ------------------------ | -------------------- |
| 내 origin을 upstream과 동기화  | fetch → merge → push |
| 최신 main을 feature 브랜치에 반영 | checkout → merge     |

> 문서 작성자: 협업자 기준 Git 브랜치 관리 가이드 (PM 제공)
