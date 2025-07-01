import os
import json
import time
import re
import nltk
from tqdm import tqdm
import mlflow
from nltk.tokenize import sent_tokenize
from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity
from dotenv import load_dotenv
import sys
from pathlib import Path

# ✅ NLTK 다운로드
try:
    nltk.download('punkt', quiet=True)
    nltk.download('punkt_tab', quiet=True)
except:
    pass

load_dotenv()

sys.path.append(str(Path(__file__).resolve().parent.parent.parent))
from ai.tech_dict import TECH_STACK

model = SentenceTransformer("all-MiniLM-L6-v2")

def load_dataset(path):
    with open(path, "r", encoding="utf-8") as f:
        return [json.loads(line) for line in f]

# ✅ 수정된 사전 기반 매칭 (한국어 조사 고려)
def dictionary_based_matching(text, tech_stack):
    found = set()
    for tech in tech_stack:
        # ✅ 한국어 조사를 고려한 패턴들
        patterns = [
            rf'\b{re.escape(tech)}\b',  # 기본 단어 경계
            rf'{re.escape(tech)}(?=[을를이가는은에서와과])',  # 한국어 조사 앞
            rf'{re.escape(tech)}(?=\s)',  # 공백 앞
            rf'{re.escape(tech)}(?=[.,!?])',  # 구두점 앞
        ]
        
        for pattern in patterns:
            if re.search(pattern, text, re.IGNORECASE):
                found.add(tech)
                break  # 하나라도 매칭되면 추가하고 다음 기술로
    
    return found

# ✅ 수정된 임베딩 기반 매칭 (threshold 변경 가능)
def embedding_based_matching(text, tech_stack, threshold=0.6): 
    try:
        sentences = sent_tokenize(text)
        if not sentences:
            sentences = [text]
        
        s_emb = model.encode(sentences)
        k_emb = model.encode(tech_stack)
        found = set()
        
        for vec in s_emb:
            sims = cosine_similarity([vec], k_emb)[0]
            for tech, score in zip(tech_stack, sims):
                if score >= threshold:
                    found.add(tech)
        return found
    except Exception as e:
        print(f"❌ 임베딩 매칭 오류: {e}")
        return set()

# ✅ 하이브리드 추출
def extract_keywords_from_text(text, tech_stack):
    dict_result = dictionary_based_matching(text, tech_stack)
    embed_result = embedding_based_matching(text, tech_stack)
    combined = dict_result | embed_result
    return list(combined)

# ✅ 평가 함수
def evaluate_keywords(predicted, actual, top_k=5):
    pred_set = set(predicted)
    true_set = set(actual)
    tp = len(pred_set & true_set)
    fp = len(pred_set - true_set)
    fn = len(true_set - pred_set)
    precision = tp / (tp + fp + 1e-10)
    recall = tp / (tp + fn + 1e-10)
    f1 = 2 * precision * recall / (precision + recall + 1e-10)
    top_k_accuracy = int(len(set(predicted[:top_k]) & true_set) > 0)
    return precision, recall, f1, top_k_accuracy

# ✅ 키워드 추출 함수
def extract_keywords(model_name, text, top_n=5):
    if model_name == "DictionaryOnly":
        return list(dictionary_based_matching(text, TECH_STACK))
    elif model_name == "EmbeddingOnly":
        return list(embedding_based_matching(text, TECH_STACK, threshold=0.6))
    elif model_name == "HybridDict+Embedding":
        return extract_keywords_from_text(text, TECH_STACK)
    else:
        raise ValueError(f"Unknown model: {model_name}")

# ✅ 디버깅 함수 강화
def debug_first_sample(data):
    print("\n🔍 첫 번째 샘플 상세 디버깅:")
    first_item = data[0]
    text = first_item['sentence']
    true_keywords = first_item['keywords']
    
    print(f"📝 전체 문장: {text}")
    print(f"🎯 정답: {true_keywords}")
    
    # 개별 키워드별 매칭 테스트
    print(f"\n🔍 개별 키워드 매칭 테스트:")
    for keyword in true_keywords:
        # 기본 패턴
        basic_match = bool(re.search(rf'\b{re.escape(keyword)}\b', text, re.IGNORECASE))
        # 한국어 조사 패턴
        korean_match = bool(re.search(rf'{re.escape(keyword)}(?=[을를이가는은에서와과])', text, re.IGNORECASE))
        # 공백 패턴
        space_match = bool(re.search(rf'{re.escape(keyword)}(?=\s)', text, re.IGNORECASE))
        
        print(f"   {keyword}: 기본={basic_match}, 조사={korean_match}, 공백={space_match}")
        
        # 텍스트에서 해당 키워드 주변 확인
        if keyword in text:
            idx = text.find(keyword)
            context = text[max(0, idx-10):idx+len(keyword)+10]
            print(f"     → 문맥: ...{context}...")

    # 실제 추출 테스트
    dict_result = list(dictionary_based_matching(text, TECH_STACK))
    embed_result = list(embedding_based_matching(text, TECH_STACK, threshold=0.6))
    hybrid_result = extract_keywords_from_text(text, TECH_STACK)
    
    print(f"\n📊 추출 결과:")
    print(f"   📚 사전 매칭: {dict_result}")
    print(f"   🧠 임베딩 매칭 (0.6): {embed_result}")
    print(f"   🔄 하이브리드: {hybrid_result}")

# ✅ 실험 실행 함수 (실험명 변경)
def run_experiment(dataset_path, models):
    print(f"\n📊 데이터셋 로딩: {dataset_path}")
    data = load_dataset(dataset_path)
    print(f"✅ 데이터 크기: {len(data)}")
    print(f"📚 TECH_STACK 크기: {len(TECH_STACK)}")
    
    # 첫 번째 샘플 디버깅
    debug_first_sample(data)
    
    # ✅ MLflow 실험명 변경 (삭제된 실험 문제 해결)
    experiment_name = f"Korean-Dictionary-Keyword-Extraction-{int(time.time())}"
    mlflow.set_experiment(experiment_name)
    print(f"🔧 MLflow 실험: {experiment_name}")

    for model_name in models:
        print(f"\n🚀 Testing Model: {model_name}")
        
        precisions, recalls, f1s, top_ns, top_k_hits = [], [], [], [], []
        start_time = time.time()
        results = []

        with mlflow.start_run(run_name=f"{model_name}_korean_optimized"):
            mlflow.log_param("dataset_version", "v2")
            mlflow.log_param("algorithm", model_name)
            mlflow.log_param("tech_stack_size", len(TECH_STACK))
            mlflow.log_param("sentence_tokenizer", "nltk_sent_tokenize")
            mlflow.log_param("korean_optimized", True)  # ✅ 한국어 최적화 표시
            if "Embedding" in model_name:
                mlflow.log_param("embedding_model", "all-MiniLM-L6-v2")
                mlflow.log_param("threshold", 0.6)  # ✅ threshold 낮춤

            for idx, item in enumerate(tqdm(data, desc=f"Processing {model_name}")):
                sentence = item["sentence"]
                true_keywords = item["keywords"]

                top_n = len(true_keywords) if len(true_keywords) > 0 else 1
                top_ns.append(top_n)

                try:
                    predicted_keywords = extract_keywords(model_name, sentence, top_n=top_n)
                    p, r, f1, top_k_hit = evaluate_keywords(predicted_keywords, true_keywords)
                except Exception as e:
                    print(f"❌ Error processing item {idx}: {e}")
                    predicted_keywords = []
                    p, r, f1, top_k_hit = 0, 0, 0, 0

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

                # 처음 3개 샘플 출력
                if idx < 3:
                    print(f"\n[Sample {idx+1}]")
                    print(f"Sentence: {sentence}")
                    print(f"True: {true_keywords}")
                    print(f"Pred: {predicted_keywords}")
                    print(f"P={p:.3f}, R={r:.3f}, F1={f1:.3f}, Top-5 Hit={top_k_hit}")

            # 평균 계산
            avg_p = sum(precisions) / len(precisions)
            avg_r = sum(recalls) / len(recalls)
            avg_f1 = sum(f1s) / len(f1s)
            avg_top_n = sum(top_ns) / len(top_ns)
            avg_top_k_acc = sum(top_k_hits) / len(top_k_hits)
            duration = time.time() - start_time

            # MLflow 로깅
            mlflow.log_metric("avg_precision", avg_p)
            mlflow.log_metric("avg_recall", avg_r)
            mlflow.log_metric("avg_f1", avg_f1)
            mlflow.log_metric("avg_top_n", avg_top_n)
            mlflow.log_metric("duration_sec", duration)
            mlflow.log_metric("top5_accuracy", avg_top_k_acc)

            print(f"\n📊 [{model_name}] Results:")
            print(f"   Precision: {avg_p:.4f}")
            print(f"   Recall: {avg_r:.4f}")
            print(f"   F1 Score: {avg_f1:.4f}")
            print(f"   Top-5 Accuracy: {avg_top_k_acc:.4f}")
            print(f"   Duration: {duration:.2f}s")

    print(f"\n✅ All experiments completed!")
    print(f"📊 MLflow UI: http://localhost:5000")
    
if __name__ == "__main__":
    # ✅ 모든 모델 테스트
    models_to_run = [
        "DictionaryOnly",           # 사전 매칭만
        "EmbeddingOnly",           # 임베딩 매칭만 (threshold=0.6)
        "HybridDict+Embedding"     # 사전 + 임베딩 하이브리드
    ]
    
    print("🚀 Starting Korean-Optimized Dictionary Keyword Extraction...")
    print(f"🎯 Testing models: {models_to_run}")
    run_experiment("data/keywords_dataset.v2.jsonl", models=models_to_run)
