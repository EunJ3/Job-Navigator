# tests/test_score_model.py

import pandas as pd
from collections import defaultdict
from ai.score_model import (
    count_tech_frequency,
    normalize_scores,
    get_top_n_skills, FORBIDDEN_TECHS
)
from ai.tech_dict import normalize_tech_name, get_job_mapping

# 1. CSV 파일 로딩 (테스트용 경로)
df = pd.read_csv("ai/tests/job_crawling.csv")
tech_col = df.iloc[:, 5]  # 기술스택
job_col = df.iloc[:, 8]   # 직무명

# 2. 직무명 매핑
job_mapping = get_job_mapping()

# 3. 직무별 기술 리스트 그룹화
job_grouped_mapped = defaultdict(list)
for techs, raw_job in zip(tech_col, job_col):
    job = raw_job.lower() if isinstance(raw_job, str) else None
    mapped_job = job_mapping.get(job)
    if not mapped_job:
        continue
    tech_list = [
        normalize_tech_name(t.strip())
        for t in str(techs).split(",")
        if t.strip() and t.strip() not in FORBIDDEN_TECHS
    ]
    if tech_list:
        job_grouped_mapped[mapped_job].append(tech_list)

# 4. 점수 계산 및 상위 기술 추출
summary_rows = []
for job, tech_lists in job_grouped_mapped.items():
    freq = count_tech_frequency(tech_lists)
    scores = normalize_scores(freq)
    top_skills = get_top_n_skills(scores, top_n=10)
    if len(top_skills) < 10:
        print(f"[경고] {job} 직무는 기술이 {len(top_skills)}개 밖에 없습니다.")
    for tech, score in top_skills.items():
        summary_rows.append((job, tech, score))

# 5. 출력
summary_df = pd.DataFrame(summary_rows, columns=["직무", "기술명", "점수"])
print(summary_df)
