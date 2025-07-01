import os
import json
import time
from tqdm import tqdm
import mlflow
from sklearn.metrics import precision_score, recall_score, f1_score
from dotenv import load_dotenv
from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity
import re
import sys
from pathlib import Path
sys.path.append(str(Path(__file__).resolve().parent.parent.parent))  # 🔁 루트 경로 등록

from ai.tech_dict import TECH_STACK

load_dotenv()
model = SentenceTransformer("all-MiniLM-L6-v2")

def load_dataset(path):
    with open(path, "r", encoding="utf-8") as f:
        return [json.loads(line) for line in f]

# ✅ 문장 분리 대체 함수
def split_sentences(text: str) -> list:
    return re.split(r"(?<=[.!?])\s+", text.strip())

# ✅ 정확 매칭 기반
def dictionary_based_matching(text, tech_stack):
    found = []
    for tech in tech_stack:
        if re.search(rf'\\b{re.escape(tech)}\\b', text, re.IGNORECASE):
            found.append(tech)
    return list(set(found))

# ✅ 문장 단위 임베딩 기반 (sent_tokenize 제거)
def embedding_based_matching(text, tech_stack, threshold=0.8):
    sentences = split_sentences(text)
    sentence_embeddings = model.encode(sentences)
    keyword_embeddings = model.encode(tech_stack)
    extracted = set()

    for sentence_embedding in sentence_embeddings:
        sims = cosine_similarity([sentence_embedding], keyword_embeddings)[0]
        for tech, score in zip(tech_stack, sims):
            if score >= threshold:
                extracted.add(tech)
    return list(extracted)

# ✅ 하이브리드 방식
def extract_keywords_from_text(text, tech_stack):
    dict_match = dictionary_based_matching(text, tech_stack)
    embed_match = embedding_based_matching(text, tech_stack)
    return list(set(dict_match + embed_match))

# 평가
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

# 메인 평가 루프
def run_hybrid_eval(dataset_path, threshold=0.6):
    data = load_dataset(dataset_path)
    model_name = f"HybridDict+Embedding(thresh={threshold})"
    mlflow.set_experiment("Keyword Extraction Evaluation")

    precisions, recalls, f1s, top_ns, top_k_hits = [], [], [], [], []
    start_time = time.time()
    results = []

    with mlflow.start_run(run_name=f"{model_name}"):
        mlflow.log_param("dataset_version", "v2")
        mlflow.log_param("algorithm", "HybridDict+Embedding")
        mlflow.log_param("threshold", threshold)

        for idx, item in enumerate(tqdm(data)):
            sentence = item["sentence"]
            true_keywords = item["keywords"]

            predicted_keywords = extract_keywords_from_text(sentence, TECH_STACK)
            p, r, f1, top_k_hit = evaluate_keywords(predicted_keywords, true_keywords)

            precisions.append(p)
            recalls.append(r)
            f1s.append(f1)
            top_k_hits.append(top_k_hit)
            top_ns.append(len(true_keywords))

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

        result_path_txt = f"predicted_keywords_{model_name}.txt"
        result_path_jsonl = f"predicted_keywords_{model_name}.jsonl"

        with open(result_path_txt, "w", encoding="utf-8") as f_txt, open(result_path_jsonl, "w", encoding="utf-8") as f_jsonl:
            for idx, item in enumerate(results):
                f_txt.write(f"[{idx+1}] {item['sentence']}\\n")
                f_txt.write(f"True     : {item['true_keywords']}\\n")
                f_txt.write(f"Pred     : {item['predicted_keywords']}\\n")
                f_txt.write(f"P={item['precision']:.2f}, R={item['recall']:.2f}, F1={item['f1']:.2f}, Top-5 Hit={item['top_5_hit']}\\n\\n")
                f_jsonl.write(json.dumps(item, ensure_ascii=False) + "\\n")

        mlflow.log_artifact(result_path_txt)
        mlflow.log_artifact(result_path_jsonl)
        print(f"\\n[{model_name}] Precision: {avg(precisions)}, Recall: {avg(recalls)}, F1: {avg(f1s)}, Time: {duration:.2f}s")

# ✅ 실행
if __name__ == "__main__":
    run_hybrid_eval("data/keywords_dataset.v2.jsonl", threshold=0.8)