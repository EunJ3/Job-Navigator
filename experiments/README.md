# 🔍 키워드 추출 실험

이 실험은 다양한 키워드 추출 알고리즘을 비교하고, **MLflow**를 활용해 성능 및 예측 결과를 시각적으로 추적합니다.

## 📌 목적

* 자유형 텍스트에서 키워드를 추출하는 다양한 방법을 실험
* 각 알고리즘의 키워드 결과, 실행 시간 등을 MLflow에 로깅
* 향후 백엔드 추천 시스템 통합을 위한 기초 실험 수행

## 🛠 비교 대상 알고리즘

| 알고리즘         | 설명                              |
| ------------ | ------------------------------- |
| **TF-IDF**   | 전통적인 통계 기반 키워드 추출 방식            |
| **KeyBERT**  | BERT 임베딩을 활용한 문장-단어 유사도 기반 추출   |
| **YAKE**     | 비지도 학습 기반 키워드 추출 (언어 독립적)       |
| **TextRank** | 그래프 기반 순위 알고리즘 (PageRank 유사 구조) |

> ✅ 현재 실험에서는 정답 키워드 수(`len(true_keywords)`)에 따라 `top_n`을 조정하여 평가의 공정성을 높였습니다.

## 📂 디렉토리 구조

```
experiments/keyword_extraction/
├── keyword_extraction_experiment.py  # 실험 메인 스크립트
├── predicted_keywords_*.txt/jsonl    # 각 알고리즘 예측 결과 (자동 생성)
├── requirements.txt                  # 필요한 패키지 목록
└── README.md                         # 실험 개요 (본 문서)
```

## ▶️ 실행 방법

1. 가상환경 생성 및 활성화:

```bash
python -m venv .venv
source .venv/bin/activate  # macOS/Linux
.venv\Scripts\activate     # Windows
```

2. 의존성 설치:

```bash
pip install -r requirements.txt
```

3. `.env` 파일 생성 후 Hugging Face 토큰 추가 (KeyBERT 사용 시 필요):

```bash
echo HF_TOKEN=your_huggingface_token > .env
```

4. 실험 실행:

```bash
python keyword_extraction_experiment.py
```

5. MLflow UI 실행:

```bash
mlflow ui
```

브라우저에서 [http://localhost:5000](http://localhost:5000) 접속하여 실험 결과 비교 가능

## 📈 출력 정보

각 실험 run에서는 다음 항목이 기록됩니다:

* 알고리즘 이름, 키워드 개수 등 주요 파라미터 (parameter)
* 실행 시간 (duration\_sec, metric)
* 정량 평가 메트릭:

  * `avg_precision`: 예측된 키워드 중 실제 정답과 일치한 비율
  * `avg_recall`: 실제 정답 키워드 중 예측에 포함된 비율
  * `avg_f1`: precision과 recall의 조화 평균 (종합 성능)
* 예측 결과 아티팩트:

  * `predicted_keywords_<algorithm>.jsonl`: 전체 문장별 결과 (정답, 예측 키워드, 점수 포함)
  * `predicted_keywords_<algorithm>.txt`: 사람이 읽기 좋은 요약 형태의 출력 파일

## 🔍 코드 설명 (keyword\_extraction\_experiment.py)

* `load_dataset()`: JSONL 데이터셋을 불러옵니다. 각 줄은 하나의 문장과 정답 키워드 리스트로 구성됩니다.
* `extract_keywords()`: 지정된 알고리즘(`TF-IDF`, `KeyBERT`, `YAKE`, `TextRank`)에 따라 텍스트로부터 키워드를 추출합니다.
* `evaluate_keywords()`: 추출된 키워드와 정답 키워드를 비교하여 precision, recall, f1을 계산합니다.
* `run_experiment()`: 전체 데이터셋에 대해 모델을 반복 실행하고, 결과를 MLflow에 로깅하고 아티팩트로 저장합니다.

## 🧪 향후 확장 계획

* 사람 정답 키워드와 비교한 정량 평가 방식 개선 (순위 고려)
* 실제 이력서, 뉴스 기사 등 현실 문서 적용 확대
* Job-Navigator 백엔드 추천 기능과 통합 실험
* 한국어 지원 강화 (mecab, KR-WordRank 등 고려)

---

본 실험은 Job-Navigator 프로젝트의 일환으로, 자유롭게 확장 및 개선해보세요.
