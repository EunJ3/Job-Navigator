# 📁 파일 경로: ai/crawler/services/jumpit_crawler.py

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.webdriver import Options
from time import sleep
from .job_classifier import classify_job  # 🔍 직무 분류 함수 import


def get_jumpit_jobs() -> list[dict]:
    """
    Jumpit 웹사이트에서 채용 공고를 크롤링하여 dict 리스트로 반환합니다.
    - title, company, location, experience, tech_stack(list), deadline, url 등 포함
    - classify_job() 함수를 통해 job_type 자동 분류
    - 기본적으로 모든 공고는 is_active=True로 저장
    """

    options = Options()
    # options.add_argument("--headless")  # GUI 없애려면 주석 해제
    driver = webdriver.Chrome(options=options)

    # ✅ Jumpit 채용 페이지 열기
    driver.get("https://jumpit.saramin.co.kr/positions?sort=rsp_rate")
    sleep(3)

    # ✅ 팝업 닫기 (존재하면)
    try:
        close_btn = driver.find_element(By.CSS_SELECTOR, "body > main > div > div.sc-a0301295-0.btHfXC > div > div > button")
        close_btn.click()
        sleep(1)
    except Exception:
        pass

    # ✅ 페이지 끝까지 스크롤 다운
    last_height = driver.execute_script("return document.body.scrollHeight")
    while True:
        driver.find_element(By.TAG_NAME, "body").send_keys(Keys.END)
        sleep(1.5)
        new_height = driver.execute_script("return document.body.scrollHeight")
        if new_height == last_height:
            break
        last_height = new_height

    # ✅ 공고 수집
    jobs = []
    cards = driver.find_elements(By.CSS_SELECTOR, "a[href^='/position/']")
    print(f"📦 수집된 공고 수: {len(cards)}개")

    for card in cards:
        try:
            full_url = "https://jumpit.saramin.co.kr" + card.get_attribute("href")

            title = card.find_element(By.CSS_SELECTOR, "h2").text.strip()

            # ✅ 정확한 회사명 추출 (wrapper 내 첫 번째 div > span)
            wrapper = card.find_element(By.CSS_SELECTOR, "div.sc-15ba67b8-0.kkQQfR")
            company = wrapper.find_element(By.CSS_SELECTOR, "div:nth-of-type(1) > span").text.strip()

            tech_list = card.find_elements(By.CSS_SELECTOR, "ul.sc-15ba67b8-1.iFMgIl > li")
            tech_stack = [li.text.strip() for li in tech_list if li.text.strip()]

            info_list = card.find_elements(By.CSS_SELECTOR, "ul.sc-15ba67b8-1.cdeuol > li")
            location = info_list[0].text.strip() if len(info_list) > 0 else "미상"
            experience = info_list[1].text.strip() if len(info_list) > 1 else "경력 무관"

            try:
                deadline = card.find_element(
                    By.CSS_SELECTOR,
                    "div.img_box > div.sc-d609d44f-3.hwTKyC > span"
                ).text.strip()
            except Exception:
                deadline = "마감일 미정"

            job_type = classify_job(title, ", ".join(tech_stack))

            jobs.append({
                "title": title,
                "company": company,
                "location": location,
                "experience": experience,
                "tech_stack": tech_stack,
                "due_date_text": deadline,
                "url": full_url,
                "job_type": job_type,
                "is_active": True,
            })

        except Exception as e:
            print(f"❌ 크롤링 오류: {e}")
            continue

    driver.quit()
    return jobs
