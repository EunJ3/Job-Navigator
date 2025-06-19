from collections import defaultdict, Counter
from typing import List, Dict
import matplotlib.pyplot as plt
import pandas as pd
from ai.tech_dict import TECH_STACK, JOB_TECH_MAP, normalize_tech_name
from ai.tech_extract import filter_by_job

# 이상한 기술어/불용어 필터링 리스트
FORBIDDEN_TECHS = {"SW", "HTML5", "AI/인공지능", "기초", "자격증", "응용", "BigData", "기술", "언어"}


# 기술 점수화 핵심 함수 정의

def count_tech_frequency(all_tech_lists : List[List[str]]) -> Dict[str, int]:
    """
    기술 리스트의 빈도를 계산하여 딕셔너리로 반환
    → {'Python': 12, 'Java': 9, ...}
    """
    counter = Counter()
    for techs in all_tech_lists:
        normed = [normalize_tech_name(t) for t in techs]
        counter.update(normed)
    return dict(counter)

def filter_scores_by_job(score_dict: Dict[str, float], job: str) -> Dict[str, float]:

    """
    직무에 해당하는 기술만 필터링
    → ex) 프론트엔드 직무일 경우 React, Vue 등만 남김
    """
    job_techs = JOB_TECH_MAP.get(job, [])
    job_tech_normed = set(normalize_tech_name(t) for t in job_techs)
    return {k: v for k, v in score_dict.items() if normalize_tech_name(k) in job_tech_normed}

def normalize_scores(freq_dict: Dict[str, int]) -> Dict[str, float]:
    """
    기술 등장 횟수를 최대값 기준으로 0~100 점수로 정규화
    → { 'Python': 100.0, 'Java': 83.5, ... }
    """
    if not freq_dict:
        return {}
    
    max_freq = max(freq_dict.values())
    return {k:round(v / max_freq * 100, 2) for k, v in freq_dict.items()}

def get_top_n_skills(score_dict: Dict[str, float], top_n: int = 10) -> Dict[str, float]:
    """
    점수화된 기술 목록에서 상위 N개 기술 추출
    → ['Python', 'JavaScript', ...]
    """
    return dict(sorted(score_dict.items(), key=lambda item: item[1], reverse=True)[:top_n])

def plot_scores(scre_dict: Dict[str, float], title = "Top Skills by Score") :
    """
    기술 점수화 결과를 막대 그래프로 시각화
    """
    if not scre_dict:
        print("점수 데이터가 없습니다.")
        return
    plt.figure(figsize=(12, 6))
    plt.bar(score_dict.keys(), score_dict.values(), color='skyblue')
    plt.xticks(rotation=45, ha='right')
    plt.title(title)
    plt.xlabel('Trend Skills')
    plt.ylabel('Score')
    plt.tight_layout()
    plt.show()