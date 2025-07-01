import os
import json
import time
from tqdm import tqdm

import mlflow
import yake
from keybert import KeyBERT
from summa.keywords import keywords as textrank_keywords
from sklearn.feature_extraction.text import TfidfVectorizer

from sentence_transformers import SentenceTransformer
from dotenv import load_dotenv

import sys
from pathlib import Path
sys.path.append(str(Path(__file__).resolve().parent.parent.parent))  # 프로젝트 루트 경로
from ai.tech_extract import extract_tech_keywords_union, TECH_STACK

# 환경 변수 로드 (.env에서 HF_TOKEN 불러오기)
load_dotenv()

# 데이터 로딩 함수
def load_dataset(path):
    with open(path, "r", encoding="utf-8") as f:
        return [json.loads(line) for line in f]

# 키워드 추출 함수
def extract_keywords(model_name, text, top_n=5, keybert_model=None):
    if model_name == "TF-IDF":
        vec = TfidfVectorizer(stop_words="english")
        X = vec.fit_transform([text])
        indices = X[0].toarray().argsort()[0][::-1][:top_n]
        return [vec.get_feature_names_out()[i] for i in indices]

    elif model_name == "KeyBERT":
        if keybert_model is None:
            raise ValueError("KeyBERT model is not initialized")
        kw_model = KeyBERT(keybert_model)
        return [kw[0] for kw in kw_model.extract_keywords(text, top_n=top_n)]

    elif model_name == "YAKE":
        kw_extractor = yake.KeywordExtractor(top=top_n)
        return [kw[0] for kw in kw_extractor.extract_keywords(text)]

    elif model_name == "TextRank":
        try:
            result = textrank_keywords(text, words=top_n)
            return result.split('\n') if result else []
        except Exception as e:
            print(f"[TextRank ERROR] {e} -> 문장: {text}")
            return []
        
    elif model_name == "TechPipeline":
        return extract_tech_keywords_union(text, tech_stack=TECH_STACK)    

    else:
        raise ValueError(f"Unknown model: {model_name}")

# 평가 함수
def evaluate_keywords(predicted, actual, top_k=5): # ✅ [TopK 추가]
    pred_set = set(predicted)
    true_set = set(actual)
    tp = len(pred_set & true_set)
    fp = len(pred_set - true_set)
    fn = len(true_set - pred_set)
    precision = tp / (tp + fp + 1e-10)
    recall = tp / (tp + fn + 1e-10)
    f1 = 2 * precision * recall / (precision + recall + 1e-10)
    top_k_accuracy = int(len(set(predicted[:top_k]) & true_set) > 0) # ✅ [TopK 추가]
    return precision, recall, f1, top_k_accuracy # ✅ [TopK 추가]

# 실험 실행 함수
def run_experiment(dataset_path, models):
    data = load_dataset(dataset_path)
    mlflow.set_experiment("Keyword Extraction Evaluation")

    # KeyBERT 모델 미리 로딩 (한 번만 다운로드)
    hf_token = os.getenv("HF_TOKEN")
    keybert_model = None
    if "KeyBERT" in models:
        keybert_model = SentenceTransformer("sentence-transformers/all-MiniLM-L6-v2", use_auth_token=hf_token)

    for model_name in models:
        precisions, recalls, f1s, top_ns, top_k_hits = [], [], [], [], [] # ✅ [TopK 추가]
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

                predicted_keywords = extract_keywords(
                    model_name,
                    sentence,
                    top_n=top_n,
                    keybert_model=keybert_model
                )
                p, r, f1, top_k_hit = evaluate_keywords(predicted_keywords, true_keywords) # ✅ [TopK 추가]

                precisions.append(p)
                recalls.append(r)
                f1s.append(f1)
                top_k_hits.append(top_k_hit)  # ✅ [TopK 추가]

                result = {
                    "sentence": sentence,
                    "true_keywords": true_keywords,
                    "predicted_keywords": predicted_keywords,
                    "precision": round(p, 4),
                    "recall": round(r, 4),
                    "f1": round(f1, 4),
                    "top_5_hit": top_k_hit,  # ✅ [TopK 추가]
                }
                results.append(result)

                if idx < 5:
                    print(f"\n[Sample {idx+1}]")
                    print(f"Sentence       : {sentence}")
                    print(f"True Keywords  : {true_keywords}")
                    print(f"Predicted      : {predicted_keywords}")
                    print(f"P={p:.2f}, R={r:.2f}, F1={f1:.2f}, Top-5 Hit={top_k_hit}")  # ✅ [TopK 추가]

            avg_p = sum(precisions) / len(precisions)
            avg_r = sum(recalls) / len(recalls)
            avg_f1 = sum(f1s) / len(f1s)
            avg_top_n = sum(top_ns) / len(top_ns)
            avg_top_k_acc = sum(top_k_hits) / len(top_k_hits)  # ✅ [TopK 추가]

            duration = time.time() - start_time

            mlflow.log_metric("avg_precision", avg_p)
            mlflow.log_metric("avg_recall", avg_r)
            mlflow.log_metric("avg_f1", avg_f1)
            mlflow.log_metric("avg_top_n", avg_top_n)
            mlflow.log_metric("duration_sec", duration)
            mlflow.log_metric("top5_accuracy", avg_top_k_acc)  # ✅ [TopK 추가]
            # 결과 저장
            result_path_txt = f"predicted_keywords_{model_name}.txt"
            result_path_jsonl = f"predicted_keywords_{model_name}.jsonl"

            with open(result_path_txt, "w", encoding="utf-8") as f_txt, \
                 open(result_path_jsonl, "w", encoding="utf-8") as f_jsonl:
                for idx, item in enumerate(results):
                    f_txt.write(f"[{idx+1}] {item['sentence']}\n")
                    f_txt.write(f"True     : {item['true_keywords']}\n")
                    f_txt.write(f"Pred     : {item['predicted_keywords']}\n")
                    f_txt.write(f"P={item['precision']:.2f}, R={item['recall']:.2f}, F1={item['f1']:.2f}, Top-5 Hit={item['top_5_hit']}\n\n")  # ✅ [TopK 추가]
                    f_jsonl.write(json.dumps(item, ensure_ascii=False) + "\n")

            mlflow.log_artifact(result_path_txt)
            mlflow.log_artifact(result_path_jsonl)

            print(f"\n[{model_name}] Precision: {avg_p:.4f}, Recall: {avg_r:.4f}, F1: {avg_f1:.4f}, Time: {duration:.2f}s")


if __name__ == "__main__":
    models_to_run = ["TF-IDF", "KeyBERT", "TextRank", "TechPipeline"]  # 필요 시 YAKE도 추가 가능
    run_experiment("data/keywords_dataset.v2.jsonl", models=models_to_run)
