import os
import json
import time
from tqdm import tqdm

import mlflow
from sklearn.metrics import precision_score, recall_score, f1_score
from dotenv import load_dotenv

import sys
from pathlib import Path
sys.path.append(str(Path(__file__).resolve().parent.parent.parent))
from ai.tech_extract import extract_tech_keywords_union, TECH_STACK


# ✅ 데이터 로딩
def load_dataset(path):
    with open(path, "r", encoding="utf-8") as f:
        return [json.loads(line) for line in f]


# ✅ 평가 지표 함수 (Precision, Recall, F1, Top-K, Jaccard, Exact Match)
def evaluate_keywords(predicted, actual, top_k_values=[1, 3, 5]):
    pred_set, gold_set = set(predicted), set(actual)
    labels = pred_set | gold_set

    y_true = [1 if label in gold_set else 0 for label in labels]
    y_pred = [1 if label in pred_set else 0 for label in labels]

    precision = precision_score(y_true, y_pred, zero_division=0)
    recall = recall_score(y_true, y_pred, zero_division=0)
    f1 = f1_score(y_true, y_pred, zero_division=0)

    top_k_hits = {f"top{k}_hit": int(len(set(predicted[:k]) & gold_set) > 0) for k in top_k_values}
    jaccard = len(pred_set & gold_set) / len(pred_set | gold_set) if pred_set | gold_set else 0
    exact_match = int(pred_set == gold_set)

    return precision, recall, f1, top_k_hits, jaccard, exact_match


# ✅ threshold 실험 함수
def run_threshold_experiment(dataset_path, thresholds):
    data = load_dataset(dataset_path)
    mlflow.set_experiment("TechPipeline Threshold Evaluation")

    for threshold in thresholds:
        precisions, recalls, f1s = [], [], []
        jaccards, exact_matches = [], []
        top1_hits, top3_hits, top5_hits = [], [], []

        start_time = time.time()

        with mlflow.start_run(run_name=f"TechPipeline@th={threshold}"):
            mlflow.log_param("threshold", threshold)
            mlflow.log_param("model", "TechPipeline")
            mlflow.log_param("dataset", "v2")

            for idx, item in enumerate(tqdm(data)):
                text = item["sentence"]
                gold = item["keywords"]

                pred = extract_tech_keywords_union(text, tech_stack=TECH_STACK, threshold=threshold)
                p, r, f1, top_hits, jac, em = evaluate_keywords(pred, gold)

                precisions.append(p)
                recalls.append(r)
                f1s.append(f1)
                jaccards.append(jac)
                exact_matches.append(em)
                top1_hits.append(top_hits["top1_hit"])
                top3_hits.append(top_hits["top3_hit"])
                top5_hits.append(top_hits["top5_hit"])

                if idx < 3:
                    print(f"\n[{idx+1}] 문장: {text}")
                    print(f"  ✅ 정답: {gold}")
                    print(f"  🔍 예측: {pred}")
                    print(f"  📊 P={p:.2f}, R={r:.2f}, F1={f1:.2f}, Top-5 Hit={top_hits['top5_hit']}")

            avg = lambda x: round(sum(x) / len(x), 4)
            duration = time.time() - start_time

            # 🔁 MLflow 메트릭 로그
            mlflow.log_metric("avg_precision", avg(precisions))
            mlflow.log_metric("avg_recall", avg(recalls))
            mlflow.log_metric("avg_f1", avg(f1s))
            mlflow.log_metric("avg_jaccard", avg(jaccards))
            mlflow.log_metric("exact_match_rate", avg(exact_matches))
            mlflow.log_metric("top1_accuracy", avg(top1_hits))
            mlflow.log_metric("top3_accuracy", avg(top3_hits))
            mlflow.log_metric("top5_accuracy", avg(top5_hits))
            mlflow.log_metric("duration_sec", duration)

            print(f"\n📌 [Threshold={threshold}] F1={avg(f1s)}, Jaccard={avg(jaccards)}, EMR={avg(exact_matches)}")


# ✅ 실행
if __name__ == "__main__":
    threshold_values = [0.65, 0.7, 0.75, 0.8, 0.85]
    dataset_path = "data/keywords_dataset.v2.jsonl"
    run_threshold_experiment(dataset_path, thresholds=threshold_values)
