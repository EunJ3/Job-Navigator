
# 협업자(fork) 기준 Git 동기화 및 브랜치 병합 가이드

> **fork 저장소**에서 협업하는 사용자가 `upstream(main)` 기준으로 최신 상태를 유지하고, `feature` 브랜치에 병합한 뒤 Pull Request(PR)를 생성하는 전체 과정을 정리했습니다.  
> 모든 작업은 `merge` 방식으로 통일하며, 초심자도 따라하기 쉽게 작성되어 있습니다.

---

## 용어 정리

| 용어           | 설명                                                | 예시                                     |
|----------------|-----------------------------------------------------|------------------------------------------|
| `origin`       | 내 GitHub 계정의 fork 저장소                        | `https://github.com/yeongseon/Job-Navigator` |
| `upstream`     | 팀 또는 PM의 원본 저장소                            | `https://github.com/ChoiJaeWoon/Job-Navigator` |
| `main`         | 기준 브랜치                                         | `main` (또는 일부 저장소는 `master`)     |
| `feature/xxx`  | 기능 개발용 브랜치                                  | `feature/login`, `feature/job-api` 등    |
| `PR (Pull Request)` | 변경 사항을 원본 저장소로 제안하는 요청           | `feature/login` → `upstream/main` 으로 PR 생성 |

---

## 1. 내 `origin/main`을 `upstream/main`으로 동기화하기

### 상황 (언제 필요한가요?)
> 팀 저장소(`upstream`)의 `main`이 업데이트됨  
> PR을 보내기 전에 내 fork의 `main`도 최신으로 유지해야 합니다.

### 흐름도
```
+-------------------+         git fetch/merge         +------------------+
| upstream/main     |  ----------------------------→  | local main       |
+-------------------+                                  +------------------+
                                                             |
                                                             | git push
                                                             ↓
                                                    +------------------+
                                                    | origin/main      |
                                                    +------------------+
```

### 명령어 순서
```bash
git checkout main                         # 내 main 브랜치로 이동
git remote -v                             # origin / upstream 확인하기
git remote add upstream https://github.com/ChoiJaeWoon/Job-Navigator.git  # 최초 1회만 실행
git fetch upstream                        # upstream의 최신 내용 가져오기
git merge upstream/main                   # local main과 병합
git push origin main                      # 내 origin 저장소에 push
```

---

## 2. 최신화된 main을 feature 브랜치에 반영

### 상황
> main이 최신 상태이며, 여기서 작업 중인 feature 브랜치에 반영해야 할 때

### 흐름도
```
+------------------+          git merge           +----------------------+
|   local main     |  ------------------------→  |  feature/xxx 브랜치   |
+------------------+                              +----------------------+
```

### 명령어
```bash
git checkout feature/xxx   # 작업 브랜치로 이동
git merge main             # 최신 main 반영
```

> 충돌 발생 시:
```bash
git add .
git commit -m "feat: 로그인 기능 추가"  # 커밋 메시지는 작업 내용을 명확히 작성
```

---

## 3. Pull Request(PR) 생성하기

### 상황
> 기능 개발을 마무리하고 팀 저장소에 변경 내용을 반영하고자 할 때

### 예시 명령어 (PR 생성 전 준비)
```bash
# 최신 main 반영 여부 확인 (권장)
git checkout main
git pull origin main

# 작업 브랜치로 이동하여 커밋 후 push
git checkout feature/xxx
git add .
git commit -m "feat: 로그인 기능 추가"
git push origin feature/xxx
```
> 그런 다음 GitHub 웹사이트에 접속하여 PR(Pull Request)을 생성하세요.

### PR의 목적
- 내 `feature/xxx` 브랜치에서 만든 변경 사항을  
  팀 저장소의 `main`에 병합 요청하는 것

### PR 생성 흐름
```
내 저장소: origin/feature/xxx
      ↓
GitHub 웹에서 PR 생성
      ↓
팀 저장소: upstream/main으로 병합 요청
```

### PR 작성 체크리스트

| 항목 | 설명 |
|------|------|
| 제목 | 간결하고 명확하게 (예: "[feat] 로그인 기능 추가") |
| 설명 | 변경 내용, 목적, 테스트 방법 등 포함 |
| 대상 브랜치 | `upstream:main` ← `origin:feature/xxx` |
| 병합 전 확인 | 충돌 없음, main과 동기화 완료 여부 확인 |

---

## 4. 병합 완료된 feature 브랜치 삭제하기

### 흐름도
```
PR 병합 완료
      ↓
feature/xxx 브랜치 삭제 (local + remote)
```

### 명령어
```bash
# 로컬 브랜치 삭제
git branch -d feature/xxx

# 원격 브랜치 삭제
git push origin --delete feature/xxx
```

---

## 전체 흐름 요약
```
1. upstream/main → local main 동기화
2. local main → feature 브랜치 반영
3. 기능 개발 → PR 생성 (origin → upstream)
4. PR 병합 완료 → 브랜치 삭제
```

---

## 체크리스트

- `git remote -v`로 origin/upstream 설정 확인
- 항상 `main` 기준으로 반영 및 PR 생성
- 충돌 발생 시 직접 해결 후 커밋
- 브랜치는 PR 병합 후 삭제

---

## 요약

| 목적                            | 명령어 흐름                                 |
|---------------------------------|----------------------------------------------|
| `origin/main` 최신화             | `checkout → fetch → merge → push`           |
| 최신 main을 feature에 반영       | `checkout → merge`                          |
| PR 생성                          | GitHub에서 `origin/feature → upstream/main` |
| 병합된 브랜치 정리               | `branch -d` / `push --delete`               |

---
