import os
import json
import time
from tqdm import tqdm

import mlflow
from sklearn.metrics import precision_score, recall_score, f1_score
from transformers import pipeline
from dotenv import load_dotenv

import sys
from pathlib import Path
sys.path.append(str(Path(__file__).resolve().parent.parent.parent))  # 프로젝트 루트 경로
from ai.tech_extract import TECH_STACK  # 정답 비교용만 사용

# ✅ 환경 변수 로드 (.env에 HF_TOKEN 필요하면 사용 가능)
load_dotenv()

# ✅ 데이터 로딩 함수
def load_dataset(path):
    with open(path, "r", encoding="utf-8") as f:
        return [json.loads(line) for line in f]

# ✅ 평가 함수
def evaluate_keywords(predicted, actual, top_k=5):
    pred_set = set(predicted)
    true_set = set(actual)
    labels = true_set | pred_set

    y_true = [1 if label in true_set else 0 for label in labels]
    y_pred = [1 if label in pred_set else 0 for label in labels]

    precision = precision_score(y_true, y_pred, zero_division=0)
    recall = recall_score(y_true, y_pred, zero_division=0)
    f1 = f1_score(y_true, y_pred, zero_division=0)
    top_k_hit = int(len(set(list(pred_set)[:top_k]) & true_set) > 0)
    return precision, recall, f1, top_k_hit

# ✅ GLiNER 추론 함수
gliner_model = None
def extract_keywords_gliner(text):
    global gliner_model
    if gliner_model is None:
        gliner_model = pipeline(
            "token-classification",
            model="dslim/bert-base-NER",  # ✅ 공개 모델
            aggregation_strategy="simple"
        )
    try:
        results = gliner_model(text)
        return [item["word"] for item in results if item["entity_group"] == "TECH"]
    except Exception as e:
        print(f"[GLiNER ERROR] {e}")
        return []

# ✅ 실험 실행 함수
def run_gliner_experiment(dataset_path):
    data = load_dataset(dataset_path)
    model_name = "GLiNER"
    mlflow.set_experiment("Keyword Extraction Evaluation")

    precisions, recalls, f1s, top_ns, top_k_hits = [], [], [], [], []
    start_time = time.time()
    results = []

    with mlflow.start_run(run_name=f"{model_name}_eval_v2with_topk"):
        mlflow.log_param("dataset_version", "v2")
        mlflow.log_param("algorithm", model_name)

        for idx, item in enumerate(tqdm(data)):
            sentence = item["sentence"]
            true_keywords = item["keywords"]

            top_n = len(true_keywords) if len(true_keywords) > 0 else 1
            top_ns.append(top_n)

            predicted_keywords = extract_keywords_gliner(sentence)
            p, r, f1, top_k_hit = evaluate_keywords(predicted_keywords, true_keywords)

            precisions.append(p)
            recalls.append(r)
            f1s.append(f1)
            top_k_hits.append(top_k_hit)

            result = {
                "sentence": sentence,
                "true_keywords": true_keywords,
                "predicted_keywords": predicted_keywords,
                "precision": round(p, 4),
                "recall": round(r, 4),
                "f1": round(f1, 4),
                "top_5_hit": top_k_hit,
            }
            results.append(result)

            if idx < 5:
                print(f"\n[Sample {idx+1}]")
                print(f"Sentence       : {sentence}")
                print(f"True Keywords  : {true_keywords}")
                print(f"Predicted      : {predicted_keywords}")
                print(f"P={p:.2f}, R={r:.2f}, F1={f1:.2f}, Top-5 Hit={top_k_hit}")

        avg = lambda x: round(sum(x) / len(x), 4)
        duration = time.time() - start_time

        mlflow.log_metric("avg_precision", avg(precisions))
        mlflow.log_metric("avg_recall", avg(recalls))
        mlflow.log_metric("avg_f1", avg(f1s))
        mlflow.log_metric("avg_top_n", sum(top_ns) / len(top_ns))
        mlflow.log_metric("top5_accuracy", avg(top_k_hits))
        mlflow.log_metric("duration_sec", duration)

        # 결과 파일 저장
        result_path_txt = f"predicted_keywords_{model_name}.txt"
        result_path_jsonl = f"predicted_keywords_{model_name}.jsonl"

        with open(result_path_txt, "w", encoding="utf-8") as f_txt, \
             open(result_path_jsonl, "w", encoding="utf-8") as f_jsonl:
            for idx, item in enumerate(results):
                f_txt.write(f"[{idx+1}] {item['sentence']}\n")
                f_txt.write(f"True     : {item['true_keywords']}\n")
                f_txt.write(f"Pred     : {item['predicted_keywords']}\n")
                f_txt.write(f"P={item['precision']:.2f}, R={item['recall']:.2f}, F1={item['f1']:.2f}, Top-5 Hit={item['top_5_hit']}\n\n")
                f_jsonl.write(json.dumps(item, ensure_ascii=False) + "\n")

        mlflow.log_artifact(result_path_txt)
        mlflow.log_artifact(result_path_jsonl)
        print(f"\n[{model_name}] Precision: {avg(precisions)}, Recall: {avg(recalls)}, F1: {avg(f1s)}, Time: {duration:.2f}s")

# ✅ 실행
if __name__ == "__main__":
    run_gliner_experiment("data/keywords_dataset.v2.jsonl")
