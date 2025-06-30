--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    job_post_id integer NOT NULL,
    title character varying,
    company character varying,
    location character varying,
    experience character varying,
    tech_stack jsonb,
    due_date_text text,
    url character varying,
    job_type character varying,
    is_active boolean DEFAULT true
);


ALTER TABLE public.jobs OWNER TO postgres;

--
-- Name: jumpit_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jumpit_jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jumpit_jobs_id_seq OWNER TO postgres;

--
-- Name: jumpit_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jumpit_jobs_id_seq OWNED BY public.jobs.job_post_id;


--
-- Name: resumes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resumes (
    resume_id integer NOT NULL,
    user_id integer,
    file_path character varying(500),
    extracted_keywords jsonb,
    job_category character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.resumes OWNER TO postgres;

--
-- Name: resumes_resume_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.resumes_resume_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.resumes_resume_id_seq OWNER TO postgres;

--
-- Name: resumes_resume_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.resumes_resume_id_seq OWNED BY public.resumes.resume_id;


--
-- Name: roadmaps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roadmaps (
    roadmap_id integer NOT NULL,
    user_id integer,
    resume_id integer,
    generated_roadmap jsonb,
    similarity_score double precision,
    target_job_category character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.roadmaps OWNER TO postgres;

--
-- Name: roadmaps_roadmap_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roadmaps_roadmap_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roadmaps_roadmap_id_seq OWNER TO postgres;

--
-- Name: roadmaps_roadmap_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roadmaps_roadmap_id_seq OWNED BY public.roadmaps.roadmap_id;


--
-- Name: tech_trends; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tech_trends (
    trend_id integer NOT NULL,
    keyword character varying(100) NOT NULL,
    job_category character varying(100),
    count integer NOT NULL,
    trend_date date NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.tech_trends OWNER TO postgres;

--
-- Name: tech_trends_trend_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tech_trends_trend_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tech_trends_trend_id_seq OWNER TO postgres;

--
-- Name: tech_trends_trend_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tech_trends_trend_id_seq OWNED BY public.tech_trends.trend_id;


--
-- Name: user_favorite_posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_favorite_posts (
    favorite_job_id integer NOT NULL,
    user_id integer,
    job_post_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_favorite_posts OWNER TO postgres;

--
-- Name: user_favorite_posts_favorite_job_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_favorite_posts_favorite_job_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_favorite_posts_favorite_job_id_seq OWNER TO postgres;

--
-- Name: user_favorite_posts_favorite_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_favorite_posts_favorite_job_id_seq OWNED BY public.user_favorite_posts.favorite_job_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    social_provider character varying(20) NOT NULL,
    social_id character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    name character varying(100),
    profile_image character varying(300),
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: jobs job_post_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN job_post_id SET DEFAULT nextval('public.jumpit_jobs_id_seq'::regclass);


--
-- Name: resumes resume_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resumes ALTER COLUMN resume_id SET DEFAULT nextval('public.resumes_resume_id_seq'::regclass);


--
-- Name: roadmaps roadmap_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roadmaps ALTER COLUMN roadmap_id SET DEFAULT nextval('public.roadmaps_roadmap_id_seq'::regclass);


--
-- Name: tech_trends trend_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tech_trends ALTER COLUMN trend_id SET DEFAULT nextval('public.tech_trends_trend_id_seq'::regclass);


--
-- Name: user_favorite_posts favorite_job_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_favorite_posts ALTER COLUMN favorite_job_id SET DEFAULT nextval('public.user_favorite_posts_favorite_job_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (job_post_id, title, company, location, experience, tech_stack, due_date_text, url, job_type, is_active) FROM stdin;
732	React-Native 스태프 엔지니어 채용	알로카도스	서울 강남구	경력 5~15년	["JavaScript", "Kotlin", "TypeScript", "iOS"]	모집마감	https://jumpit.saramin.co.kr/position/49893	frontend	f
802	Backend Engineer (Backend 엔지니어)	메이아이	서울 강남구	경력 1~3년	["FastAPI", "Django", "PostgreSQL", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/49943	backend	f
825	AI 엔지니어	바로팜	서울 강남구	경력 3~10년	["DeepLearning", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50873	data	f
946	AI Engineer	코넥티브	서울 강남구	신입~5년	["Python", "PyTorch", "OpenCV"]	모집마감	https://jumpit.saramin.co.kr/position/51086	data	f
943	SI 개발 PM	미디어로그	서울 마포구	경력 8~10년	["Java", "Node.js", "Vue.js", "Oracle", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/50146	backend	f
945	Backend Engineer (Java/Kotlin)	센트비	서울 영등포구	경력 4~13년	["Kotlin", "Java", "Spring Boot"]	모집마감	https://jumpit.saramin.co.kr/position/50707	backend	f
1976	중급 백엔드 개발자 (5~7년)	티투엘	경기 고양시	경력 5~7년	["Java"]	모집마감	https://jumpit.saramin.co.kr/position/50168	backend	f
1267	백엔드 개발자	버추얼랩	서울 성동구	경력 5~10년	["Django", "Backendless"]	모집마감	https://jumpit.saramin.co.kr/position/50010	backend	f
1300	Flutter 프론트엔드 개발자 채용	서울거래	서울 영등포구	경력 3~99년	["Flutter", "REST API", "Git", "MVVM", "Dart"]	모집마감	https://jumpit.saramin.co.kr/position/51535	frontend	f
1335	카카오/네이버 연계시스템 서버 개발자	비즈톡	서울 강남구	경력 5~10년	["Git", "Spring Boot", "REST API", "Linux"]	모집마감	https://jumpit.saramin.co.kr/position/51056	backend	f
1336	백앤드 개발(11-15년)	더블유닷에이아이	서울 서초구	경력 11~15년	["MySQL", "Spring Boot", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/51420	backend	f
1551	개발 팀장 모집(경력5~7년)	데이터누리	서울 강서구	경력 5~7년	["Java", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/51242	frontend	f
1802	AI 테스트 도구 UI 개발	슈어소프트테크	경기 성남시	경력 2~8년	["AI/인공지능", "React", "FastAPI", "Flask"]	모집마감	https://jumpit.saramin.co.kr/position/51363	backend	f
1803	실내 내비게이션 연구/개발(전문연구요원가능)	베스텔라랩	대구 동구, 경기 안양시	신입~10년	["Python", "Spring Framework", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/51256	backend	f
1306	[계약직] Flutter & node.js 경력 개발자 채용	인졀미	서울 서초구	경력 5~20년	["Flutter", "iOS", "Android"]	모집마감	https://jumpit.saramin.co.kr/position/51474	backend	f
1322	http/proxy 개발자	프라이빗테크놀로지	서울 마포구	경력 7~15년	["Android", "Java", "Kotlin", "MVVM", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/49925	mobile	f
1345	[경력직] Flutter 앱 & Node.js 개발자	인졀미	서울 서초구	경력 5~20년	["Flutter", "iOS", "Android"]	모집마감	https://jumpit.saramin.co.kr/position/51473	backend	f
1368	모바일/웹 클라이언트 개발자 채용	스쿨버스	서울 강서구	경력 1~9년	["Flutter", "iOS", "Android", "Dart"]	모집마감	https://jumpit.saramin.co.kr/position/50032	mobile	f
1510	앱 개발자 경력 채용 (10년이상)	텐빌리언	서울 구로구	경력 10~15년	["Android", "REST API", "React", "iOS"]	모집마감	https://jumpit.saramin.co.kr/position/50253	frontend	f
1518	앱 개발자 경력 채용 (2~5년)	텐빌리언	서울 구로구	경력 2~5년	["Android", "REST API", "React", "iOS"]	모집마감	https://jumpit.saramin.co.kr/position/50251	frontend	f
1844	Frontend developer	유비퍼스트대원	경기 성남시	경력 4~10년	["Java", "Kotlin", "Spring Boot", "CSS 3"]	모집마감	https://jumpit.saramin.co.kr/position/51198	backend	f
2136	[경력] 백엔드 개발자 (울산, 11년↑)	엔엑스	울산 울주군	경력 11~15년	["Node.js", "MongoDB", "AWS", "Docker"]	모집마감	https://jumpit.saramin.co.kr/position/51619	backend	f
2138	SW 개발 PM(Project Manager) 대리급	팜클	강원 횡성군	경력 5~8년	["Python", "AWS", "Git", "iOS", "Linux"]	모집마감	https://jumpit.saramin.co.kr/position/51414	mobile	f
1278	플러터 프론트 APP 개발[신입]	패션앤스타일컴퍼니	서울 종로구	신입~2년	["Flutter", "iOS", "Android", "GitHub", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/50281	mobile	f
1020	SM/SI 개발 채용	미디어로그	서울 마포구	경력 5~10년	["Java 8", "Spring Boot", "Vue.js"]	모집마감	https://jumpit.saramin.co.kr/position/49906	backend	f
1023	Back-End 개발자(3년 이상 필수)	오로라파이브	서울 영등포구	경력 3~5년	["MongoDB", "TypeScript", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/50514	backend	f
1024	Vision AI(Vision Model/VLM) 연구개발	씨이랩	서울 강남구	경력 3~10년	["AI/인공지능", "PyTorch", "MachineLearning"]	모집마감	https://jumpit.saramin.co.kr/position/50918	data	f
1025	자사앱/웹 관리자 채용[6~8년]	제너시스비비큐	서울 송파구	경력 6~8년	["Java", "Spring Boot", "MSSQL", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/50887	backend	f
1027	자사앱/웹 관리자 채용[2~5년]	제너시스비비큐	서울 송파구	경력 2~5년	["Java", "Spring Boot", "MSSQL", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/50886	backend	f
1028	웹 프로그래머/경력직/JAVA JSP	비욘드테크	서울 금천구	경력 3~7년	["JSP", "Java", "SW", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/49793	frontend	f
1098	[ECS사업부문] SI 프로젝트 PM	플래티어	서울 송파구	경력 15~20년	["JavaScript", "Spring Boot", "React", "Next.js"]	모집마감	https://jumpit.saramin.co.kr/position/49914	backend	f
1100	[백엔드,서버] 개발자 채용	아타드	서울 송파구, 부산 남구, 경기 성남시	경력 1~5년	["VPN", "Go", "Linux", "REST API", "C", "TCP/IP"]	모집마감	https://jumpit.saramin.co.kr/position/50264	backend	f
1442	MLOps 엔지니어	룰루랩	서울 강남구	경력 1~10년	["Python", "PyTorch"]	모집마감	https://jumpit.saramin.co.kr/position/51177	data	f
1126	[PJ_Youkai] 클라이언트 프로그래머	보이저	서울 구로구	신입~20년	["C++", "DirectX", "Redis"]	모집마감	https://jumpit.saramin.co.kr/position/50656	data	f
1127	프론트엔드 주니어 개발자(HD)	알스퀘어	서울 강남구	경력 5~7년	["JavaScript", "TypeScript", "React", "vuex"]	모집마감	https://jumpit.saramin.co.kr/position/51366	frontend	f
1129	[격주 4.5일 근무] 린컴퍼니 전산실 ERP, 쇼핑몰 개발 및 운영	린컴퍼니	서울 강남구	경력 5~15년	["Java", "Spring", "Miplatform", "ERP", "Oracle"]	모집마감	https://jumpit.saramin.co.kr/position/10287	backend	f
1130	프론트엔드 개발자	와탭랩스	서울 서초구	경력 3~6년	["React"]	모집마감	https://jumpit.saramin.co.kr/position/49821	frontend	f
1131	서버 엔지니어	와탭랩스	서울 서초구	경력 10~20년	["Linux", "Windows", "Python", "Shell"]	모집마감	https://jumpit.saramin.co.kr/position/49822	backend	f
2190	Software QA Engineer	이마고웍스	서울 강남구	경력 3~5년	["QA"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52467	other	t
1132	의료IT 클라우드 인프라 경력 채용	이지케어텍(edge&next)	서울 중구	경력 1~18년	["C#", "WPF", ".NET", "Oracle", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/50124	frontend	f
1134	[개발] Backend Developer/2~4년	빌드코퍼레이션	서울 강남구	경력 2~4년	["Node.js", "Next.js", "GitHub Actions"]	모집마감	https://jumpit.saramin.co.kr/position/50305	backend	f
1135	모바일파트- Android Native 개발	비바이노베이션	서울 강남구	경력 5~15년	["Kotlin", "Jetpack", "XML", "Coroutine", "Flow"]	모집마감	https://jumpit.saramin.co.kr/position/50083	mobile	f
1137	AI (LLM RAG) 개발자 / 3~5년	셀키	서울 서초구	경력 3~5년	["Python", "PyTorch", "Amazon SageMaker"]	모집마감	https://jumpit.saramin.co.kr/position/50432	data	f
1179	포탈 웹사이트 Front-End 개발자 경력	아이디에스앤트러스트	서울 강남구	경력 3~8년	["Java", "Spring Framework", "React"]	모집마감	https://jumpit.saramin.co.kr/position/50236	backend	f
1643	안드로이드 개발 (3년 이상)	마카롱팩토리	경기 성남시	경력 3~10년	["Android", "Java", "Kotlin", "Realm"]	모집마감	https://jumpit.saramin.co.kr/position/51099	mobile	f
1657	QA 엔지니어 (2년 이상)	마카롱팩토리	경기 성남시	경력 2~5년	["Android", "iOS", "QA", "Postman"]	모집마감	https://jumpit.saramin.co.kr/position/51096	mobile	f
1797	임베디드 SW 개발자(리눅스/안드로이드) 개발자	슈프리마	경기 성남시	경력 5~10년	["C", "C++", "Android", "iOS", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/50345	mobile	f
1836	앱 개발자 (신입)	알비에치	경기 안양시	신입	["Flutter", "Android", "iOS", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/51000	mobile	f
1837	Mobile App 개발자	더블티	경기 수원시	신입	["Flutter", "REST API", "iOS", "Android"]	모집마감	https://jumpit.saramin.co.kr/position/51440	mobile	f
1839	앱 개발자 (고급)	알비에치	경기 안양시	경력 7~10년	["Flutter", "Android", "iOS", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/50998	mobile	f
1842	Android OS 개발 병역특례	엔티엘헬스케어	경기 성남시	신입	["Android", "iOS"]	모집마감	https://jumpit.saramin.co.kr/position/51422	mobile	f
734	백엔드 엔지니어	스패로우	서울 마포구	경력 5~10년	["Redis", "Java", "SQL", "AWS", "RDB"]	모집마감	https://jumpit.saramin.co.kr/position/50818	backend	f
736	서버/백엔드 개발자	언더라이터	서울 마포구	경력 5~15년	["Kotlin", "Spring Boot", "AWS", "GitHub"]	모집마감	https://jumpit.saramin.co.kr/position/49889	backend	f
737	프라이빗 클라우드 제품 개발	파이오링크	서울 금천구	신입~20년	["Linux", "Python", "C", "Golang", "Ansible"]	모집마감	https://jumpit.saramin.co.kr/position/50418	backend	f
738	백엔드 개발자 채용 (5년 이상)	싸이터	서울 금천구	경력 5~12년	["Spring Boot", "Kubernetes", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/51275	backend	f
739	[코스닥상장사] iOS 앱 개발자 채용	디어유	서울 강남구	경력 5~10년	["iOS", "Swift", "Objective-C", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/50635	mobile	f
740	브랜다즈 백엔드개발자(자바/코틀린)	헤렌	서울 성동구	경력 3~15년	["Java", "Kotlin", "Spring Boot", "Mybatis"]	모집마감	https://jumpit.saramin.co.kr/position/49842	backend	f
741	헬스케어 소프트웨어 백엔드 개발자 (경력직)	탈로스	서울 강남구	경력 1~5년	["Python", "FastAPI", "MySQL", "Docker"]	모집마감	https://jumpit.saramin.co.kr/position/51421	backend	f
742	블록체인 엔지니어 채용	알로카도스	서울 강남구	경력 3~10년	["Blockchain", "Solidity", "Rust", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/49890	data	f
1180	의료IT 모바일 인공지능 경력 채용	이지케어텍(edge&next)	서울 중구	경력 1~18년	["C#", "WPF", ".NET", "Oracle", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/50126	frontend	f
1182	의료IT S/W 개발직 경력 채용	이지케어텍(edge&next)	서울 중구	경력 2~18년	["C#", "WPF", ".NET", "Oracle", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/50122	frontend	f
1183	클라우드 서버 네트워크	이지케어텍(edge&next)	서울 중구	경력 1~18년	["AWS", "AZURE", "GCP", "Linux", "Windows"]	모집마감	https://jumpit.saramin.co.kr/position/50215	backend	f
1184	[개발] Backend Developer/8~10년	빌드코퍼레이션	서울 강남구	경력 8~10년	["Node.js", "Next.js", "GitHub Actions"]	모집마감	https://jumpit.saramin.co.kr/position/50309	backend	f
743	소프트웨어 엔지니어 (Backend)	사각	서울 마포구	경력 1~8년	["Django", "FastAPI", "NestJS", "PostgreSQL"]	모집마감	https://jumpit.saramin.co.kr/position/50843	backend	f
744	프론트엔드 개발 (3년 이상)	하이테커	서울 성동구	경력 3~5년	["Git", "TypeScript", "React", "Next.js"]	모집마감	https://jumpit.saramin.co.kr/position/50832	frontend	f
745	AI솔루션 개발자(경력 5~10년)	엠로	서울 영등포구	경력 3~10년	["Java", "JavaScript", "Spring Framework"]	모집마감	https://jumpit.saramin.co.kr/position/51083	backend	f
746	백엔드 개발자	가우디오랩	서울 강남구	경력 3~8년	["Spring Boot", "RDB", "SQL"]	모집마감	https://jumpit.saramin.co.kr/position/51152	backend	f
747	AI 국제 물류 스타트업 ITOps 개발자	아로아랩스	서울 마포구	신입~4년	["C#", "AZURE", "Go", "GORM"]	모집마감	https://jumpit.saramin.co.kr/position/51349	backend	f
750	빅데이터 엔진 개발	에스티씨랩	서울 강남구	경력 3~5년	["Go", "Python", "Java", "JavaScript", "TCP/IP"]	모집마감	https://jumpit.saramin.co.kr/position/49865	backend	f
1185	Linux App 개발 경력 모집	유니온바이오메트릭스	서울 송파구	경력 3~15년	["Linux", "Qt", "Java", "Kotlin"]	모집마감	https://jumpit.saramin.co.kr/position/50751	mobile	f
1191	백엔드 개발 (경력 11~년)	에이치비엠피	서울 구로구	경력 11~15년	["GitHub", "MySQL", "Node.js", "Amazon EC2"]	모집마감	https://jumpit.saramin.co.kr/position/50214	backend	f
1193	Linux/Android BSP 개발 경력 모집	유니온바이오메트릭스	서울 송파구	경력 3~15년	["Linux", "FW", "C", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/50752	mobile	f
1541	프론트엔드 개발 경력 (10년 이상)	텐빌리언	서울 구로구	경력 10~13년	["JavaScript", "HTML5"]	모집마감	https://jumpit.saramin.co.kr/position/50930	frontend	f
1228	웹퍼블리셔 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["Zeplin", "Vue.js", "JavaScript", "jQuery"]	모집마감	https://jumpit.saramin.co.kr/position/49876	frontend	f
1229	Node.js 서버/백엔드 개발자	더스포츠커뮤니케이션	서울 강서구	신입~3년	["Node.js"]	모집마감	https://jumpit.saramin.co.kr/position/51329	backend	f
1230	에이전시 PHP 백엔드 채용[대리]	코워커넷	서울 은평구	경력 1~5년	["PHP", "MySQL", "Laravel", "Linux", "MariaDB"]	모집마감	https://jumpit.saramin.co.kr/position/50461	backend	f
1231	프론트엔드 개발자(전환형/체험형 인턴)	링글잉글리시에듀케이션서비스	서울 강남구	신입	["React", "Redux", "SCSS"]	모집마감	https://jumpit.saramin.co.kr/position/50506	frontend	f
1232	포탈 웹사이트 Back-end 개발자 경력직	아이디에스앤트러스트	서울 강남구	경력 3~12년	["Spring Framework", "Java", "Kotlin", "React"]	모집마감	https://jumpit.saramin.co.kr/position/50237	backend	f
1233	기술융합사업부 IT 프로젝트 PM/서브PM	엠더블유네트웍스	서울 강남구	신입~5년	["react-testing-library", "QA", "Flow"]	모집마감	https://jumpit.saramin.co.kr/position/50636	frontend	f
1235	NPU 컴파일러 개발 엔지니어	아티크론	서울 동대문구	신입	["C", "C++", "Python", "Linux", "TensorFlow"]	모집마감	https://jumpit.saramin.co.kr/position/50667	data	f
1237	데이터베이스 개발자 Oracle DW Mart ETL	잇솔루션	서울 강남구	경력 3~20년	["Oracle PL/SQL", "Dw", "Etl", "RDB"]	모집마감	https://jumpit.saramin.co.kr/position/51406	data	f
1238	프론트엔드 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["Node.js", "Java", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/50446	backend	f
1239	웹 풀스택 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~6년	["Java", "JavaScript", "Python", "HTML5"]	모집마감	https://jumpit.saramin.co.kr/position/50447	frontend	f
1241	웹서버 개발자 경력 채용	에프엘이에스	서울 강서구	경력 2~5년	["C++", "Java", "React", "Spring"]	모집마감	https://jumpit.saramin.co.kr/position/50722	backend	f
1242	인프라 엔지니어 신입 채용	에프엘이에스	서울 강서구	신입	["Docker", "TypeScript", "AWS", "AZURE"]	모집마감	https://jumpit.saramin.co.kr/position/50723	frontend	f
1247	에이전시 PHP 백엔드 채용[과장]	코워커넷	서울 은평구	경력 6~10년	["PHP", "MySQL", "Laravel", "Linux", "MariaDB"]	모집마감	https://jumpit.saramin.co.kr/position/50462	backend	f
1253	택스아이 개발팀리더	뉴아이	서울 서초구	경력 4~15년	["HTML5", "CSS 3", "Java", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/51294	frontend	f
1255	node.js 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~6년	["Node.js", "AWS", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/50444	backend	f
1344	RAG Researcher / Engineer	올거나이즈코리아	서울 강남구	경력 2~10년	["AI/인공지능", "NLP", "DeepLearning"]	모집마감	https://jumpit.saramin.co.kr/position/51373	data	f
1349	내부시스템 개발(파워빌더) 경력	호전실업	서울 마포구	경력 5~15년	["Power builder", "Backendless", "MSSQL"]	모집마감	https://jumpit.saramin.co.kr/position/51281	backend	f
1352	백엔드 개발자 경력 채용	인공지능팩토리	서울 중구	경력 1~5년	["AWS", "GCP", "AZURE", "Cloud CMS", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/51612	backend	f
752	리눅스 C / C++ 서버 개발자	코닉글로리	서울 강남구	경력 2~15년	["C", "C++", "Linux", "TCP/IP", "Shell"]	모집마감	https://jumpit.saramin.co.kr/position/51088	backend	f
753	AI 백엔드 시스템 엔지니어 채용	쉬모스랩	서울 강남구	경력 2~7년	["SQL", "PostgreSQL", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50693	backend	f
755	IT/AI부문(전문연구요원 포함)경력(1~3)	연합인포맥스	서울 종로구	경력 1~3년	["AI/인공지능", "TypeScript", "Next.js"]	모집마감	https://jumpit.saramin.co.kr/position/51368	frontend	f
757	APLUS AI_검색&추천_백엔드 엔지니어	버즈니	서울 관악구	경력 1~10년	["Python", "AWS", "Amazon EKS"]	모집마감	https://jumpit.saramin.co.kr/position/51175	backend	f
758	AI 국제 물류 스타트업 프론트엔드 개발자	아로아랩스	서울 마포구	경력 1~10년	["GitHub", "Visual Studio Code", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/51348	frontend	f
759	프론트엔드 개발자	넥써쓰	서울 강남구	경력 3~11년	["Blockchain", "React Native", "Next.js"]	모집마감	https://jumpit.saramin.co.kr/position/50004	frontend	f
761	프라이빗 클라우드 제품 개발- 전문연구요원	파이오링크	서울 금천구	신입~20년	["Linux", "Python", "C", "Golang", "Ansible"]	모집마감	https://jumpit.saramin.co.kr/position/50419	backend	f
763	소프트웨어 엔지니어(AI)	사각	서울 마포구	경력 1~8년	["Svelte", "FastAPI", "Python", "AI/인공지능"]	모집마감	https://jumpit.saramin.co.kr/position/50844	backend	f
764	이기종 방화벽 정책관리 솔루션 개발자	위드네트웍스	서울 강서구	경력 5~10년	["Git", "MongoDB", "Docker", "Linux"]	모집마감	https://jumpit.saramin.co.kr/position/50244	backend	f
767	솔루션 프론트엔드 개발자 계약직 (정규직 전환) 경력자 채용	하이케어넷	서울 송파구	경력 4~8년	["React", "NestJS", "TypeORM", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/50925	backend	f
769	애플리케이션 및 클라우드 개발 (전문연구요원)	파이오링크	서울 금천구	신입~7년	["AngularJS", "Linux", "Java", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/51125	frontend	f
1355	Python 개발자 모집	애드크림	서울 강남구	경력 3~5년	["Python", "DB", "AngularJS", "Vue.js"]	모집마감	https://jumpit.saramin.co.kr/position/50644	frontend	f
1356	비전 AI 연구개발 채용	인피닉	서울 금천구	경력 3~10년	["AI/인공지능", "Python", "PyTorch", "Pandas"]	모집마감	https://jumpit.saramin.co.kr/position/50468	data	f
1703	AI Application Engineer	업스테이지	경기 용인시	경력 3~20년	["AI/인공지능", "PyTorch", "NLP"]	모집마감	https://jumpit.saramin.co.kr/position/50534	data	f
1401	[CC CTO] AI Engineer	커넥트웨이브	서울 금천구	경력 3~15년	["Python", "Django", "FastAPI", "Java", "Kotlin"]	모집마감	https://jumpit.saramin.co.kr/position/50858	backend	f
1402	Java 백엔드 개발자(5~7년)	아파트아이	서울 금천구	경력 5~7년	["Spring", "JavaScript", "jQuery", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/51581	backend	f
1406	플러터 개발자 (Flutter, 3~6년)	클레온	서울 중구	경력 3~6년	["Flutter", "Kotlin", "JavaScript", "Dart"]	모집마감	https://jumpit.saramin.co.kr/position/51314	frontend	f
1408	프론트엔드 웹개발자 채용(경력5~7년)	케이웨더	서울 구로구	경력 5~7년	["Java", "Linux", "React", "Next.js"]	모집마감	https://jumpit.saramin.co.kr/position/50313	frontend	f
1409	프론트엔드 개발자 (경력 1년 이상)	아이쿠카	서울 영등포구	경력 1~15년	["JavaScript", "React", "React Native", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/51552	frontend	f
1412	Computer Vision / Machine Learning 소프트웨어 개발자 채용	쓰리아이	서울 강남구	경력 1~20년	["C++", "Python", "TensorFlow", "PyTorch"]	모집마감	https://jumpit.saramin.co.kr/position/51138	data	f
1413	프론트엔드 웹개발자 채용(경력8~10년)	케이웨더	서울 구로구	경력 8~10년	["Java", "Linux", "React", "Next.js"]	모집마감	https://jumpit.saramin.co.kr/position/50314	frontend	f
770	서버개발팀 모바일 개발자(경력)	사이버다임	서울 송파구	경력 5~15년	["Android Studio", "Node.js", "Webpack"]	모집마감	https://jumpit.saramin.co.kr/position/51567	backend	f
772	[DEV] 앱개발자 채용	루티너리	서울 서초구	경력 3~15년	["React Native", "JavaScript", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/50965	frontend	f
773	머신러닝 엔지니어 - 시니어	심플랫폼	서울 금천구	경력 6~15년	["Python", "PyTorch", "TensorFlow", "DVC"]	모집마감	https://jumpit.saramin.co.kr/position/51390	data	f
775	BE Engineer	이마고웍스	서울 강남구	경력 5~8년	["TypeScript", "NestJS", "MongoDB", "NoSql"]	모집마감	https://jumpit.saramin.co.kr/position/50677	backend	f
778	프론트엔드 개발자(5년 이상)	에이아이파크	서울 마포구	경력 5~10년	["JavaScript", "TypeScript", "HTML5"]	모집마감	https://jumpit.saramin.co.kr/position/51035	frontend	f
781	AI Engineer - 전문연구요원 가능	이마고웍스	서울 강남구	신입	["TypeScript", "Python", "C++", "CMake"]	모집마감	https://jumpit.saramin.co.kr/position/50675	frontend	f
782	[플레이오] iOS 개발자 (3년 이상)	지엔에이컴퍼니	서울 서초구	경력 3~5년	["Slack", "Notion", "Google Workspace", "Jira"]	모집마감	https://jumpit.saramin.co.kr/position/51209	backend	f
783	시니어 파이썬 백엔드 엔지니어 채용	알로카도스	서울 강남구	경력 5~15년	["AWS", "Django", "Python", "MongoDB"]	모집마감	https://jumpit.saramin.co.kr/position/49892	backend	f
784	시니어 클라우드 인프라 엔지니어 채용	알로카도스	서울 강남구	경력 5~15년	["Terraform", "MongoDB"]	모집마감	https://jumpit.saramin.co.kr/position/49891	backend	f
785	Front-End Engineer/6~10년	불마켓랩스(BullMarketLabsCo.Ltd.)	서울 강남구	경력 6~10년	["JavaScript", "TypeScript", "Vue.js", "React"]	모집마감	https://jumpit.saramin.co.kr/position/50302	frontend	f
1414	[분당] 병원정보시스템 진료파트개발자	이지케어텍(edge&next)	서울 중구	경력 1~8년	["WPF", ".NET", "JavaScript", "Oracle"]	모집마감	https://jumpit.saramin.co.kr/position/50472	frontend	f
1415	백엔드 개발자 (1~4년) [강남구]	모멘티	서울 강남구	경력 1~4년	["Python", "Django", "PHP", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/51109	backend	f
1417	[원주] 병원정보시스템 S/W 개발자(SI)	이지케어텍(edge&next)	서울 중구	경력 2~20년	["JavaScript", "Oracle", "WPF", ".NET"]	모집마감	https://jumpit.saramin.co.kr/position/50473	frontend	f
1418	FrontEnd 개발자(Pivo Engineering)	쓰리아이	서울 강남구	경력 4~10년	["TypeScript", "Vue.js", "WebRTC", "three.js"]	모집마감	https://jumpit.saramin.co.kr/position/51132	frontend	f
1420	Sr. Researcher (LLM)	에이아이트릭스	서울 강남구	경력 5~12년	["MachineLearning", "AI/인공지능", "NLP"]	모집마감	https://jumpit.saramin.co.kr/position/50128	data	f
1421	쇼핑몰서비스 PHP 개발자 6년 ↑ 모집	유디아이디	서울 구로구	경력 6~9년	["PHP", "MySQL", "MongoDB", "Laravel"]	모집마감	https://jumpit.saramin.co.kr/position/51119	backend	f
1453	3차원 머신비전 알고리즘 개발자(2~4)	클레	서울 성동구	경력 2~4년	["Python", "C", "C++", "PyTorch", "CUDA"]	모집마감	https://jumpit.saramin.co.kr/position/51066	data	f
1455	Frontend Engineer	아이브	서울 서초구	경력 3~10년	["React", "Next.js", "TypeScript", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/50624	frontend	f
1456	항공 및 로보틱스 엔지니어	니어스랩	서울 송파구	경력 3~10년	["C", "C++", "Kotlin", "MATLAB", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50687	mobile	f
1460	데이터 엔지니어 경력직 모집	웅진	서울 중구	경력 3~16년	["PowerBI", "Microsoft PowerApps"]	모집마감	https://jumpit.saramin.co.kr/position/49987	data	f
1465	NPU Field Application Engineer	모빌린트	서울 강남구	경력 5~10년	["C++", "TensorFlow", "Python", "PyTorch"]	모집마감	https://jumpit.saramin.co.kr/position/50325	data	f
1466	프론트엔드 개발자 (과장급)	아파트아이	서울 금천구	경력 8~10년	["Next.js", "HTML5", "JavaScript", "React"]	모집마감	https://jumpit.saramin.co.kr/position/51580	frontend	f
1468	프론트엔드 개발자 채용	딜리버리랩	서울 성동구	경력 5~15년	["Vue.js", "Java", "JavaScript", "HTML5"]	모집마감	https://jumpit.saramin.co.kr/position/51169	frontend	f
787	어플리케이션 및 클라우드 개발	파이오링크	서울 금천구	경력 3~13년	["Java", "Spring", "Linux", "Django", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/51121	backend	f
790	백엔드 개발자 (Python)	바로팜	서울 강남구	경력 5~15년	["Git", "Python", "AWS", "TypeScript", "Svelte"]	모집마감	https://jumpit.saramin.co.kr/position/51387	backend	f
792	[NPU] System SW Engineer	오픈엣지테크놀로지	서울 강남구	신입~15년	["Linux", "C", "C++", "TensorFlow", "PyTorch"]	모집마감	https://jumpit.saramin.co.kr/position/50490	data	f
793	데이터 사이언티스트	바로팜	서울 강남구	경력 5~10년	["MachineLearning", "SQL", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50874	data	f
794	IT/AI부문(전문연구요원 포함)경력(4↑)	연합인포맥스	서울 종로구	경력 4~5년	["AI/인공지능", "TypeScript", "Next.js"]	모집마감	https://jumpit.saramin.co.kr/position/51369	frontend	f
795	서버개발팀 웹클라이언트 개발자(경력)	사이버다임	서울 송파구	경력 5~15년	["JavaScript", "CSS 3", "HTML5"]	모집마감	https://jumpit.saramin.co.kr/position/51565	backend	f
796	프론트엔드 개발자	패스트레인	서울 강남구	경력 7~13년	["React", "GitHub", "Jira", "Confluence"]	모집마감	https://jumpit.saramin.co.kr/position/50865	frontend	f
797	AI Agent Developer	휴먼컨설팅그룹	서울 서초구	경력 3~7년	["Python", "MySQL", "FastAPI", "PostgreSQL"]	모집마감	https://jumpit.saramin.co.kr/position/50643	backend	f
798	Full-Stack Engineer	커버링	서울 종로구	경력 2~5년	["JavaScript", "TypeScript", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/50705	frontend	f
888	안드로이드 개발자	티피씨인터넷	서울 강남구	신입~3년	["Kotlin", "Coroutine", "Flow"]	모집마감	https://jumpit.saramin.co.kr/position/50433	mobile	f
1478	프론트엔드 개발자 (대리급)	아파트아이	서울 금천구	경력 5~7년	["Next.js", "HTML5", "JavaScript", "React"]	모집마감	https://jumpit.saramin.co.kr/position/51579	frontend	f
1482	엔진기술연구팀 AI/ML엔지니어 채용	인피닉	서울 금천구	경력 1~3년	["Python", "PyTorch", "AI/인공지능"]	모집마감	https://jumpit.saramin.co.kr/position/51616	data	f
1483	M365 개발 리더(PL)채용	웅진	서울 중구	경력 10~15년	["Spring Boot", "AZURE", "MSSQL"]	모집마감	https://jumpit.saramin.co.kr/position/49897	backend	f
1459	웹 시스템 설계	웅진	서울 중구	경력 10~20년	["Java", "MSA"]	모집마감	https://jumpit.saramin.co.kr/position/49901	other	f
1484	3차원 머신비전 알고리즘 개발자8~10	클레	서울 성동구	경력 8~10년	["Python", "C", "C++", "PyTorch", "CUDA"]	모집마감	https://jumpit.saramin.co.kr/position/51068	data	f
1487	3D 컴퓨터 비전 연구개발	마이공사	서울 서초구	경력 2~9년	["DeepLearning", "AI/인공지능", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50995	data	f
1555	개발 팀장 모집(경력2~4년)	데이터누리	서울 강서구	경력 2~4년	["Java", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/51240	frontend	f
1523	iPaaS 엔지니어	메이븐클라우드서비스	서울 강남구	경력 3~10년	["Microsoft PowerApps"]	모집마감	https://jumpit.saramin.co.kr/position/51023	other	f
1557	풀 스택 개발자(Python, React)[7~10년]	세라크래프트	서울 동대문구	경력 7~10년	["Redux", "React", "Python", "Django"]	모집마감	https://jumpit.saramin.co.kr/position/51439	backend	f
1558	웹 퍼블리셔 경력채용 (6~9년)	텐빌리언	서울 구로구	경력 6~9년	["JavaScript", "HTML5", "CSS 3", "jQuery"]	모집마감	https://jumpit.saramin.co.kr/position/50255	frontend	f
1559	프론트엔드개발자 모집(6년~10년)	위버스브레인	서울 구로구	경력 6~10년	["Flutter", "React", "REST API", "Git", "Redux"]	모집마감	https://jumpit.saramin.co.kr/position/50731	frontend	f
1561	개발 팀장 모집(경력8~10년)	데이터누리	서울 강서구	경력 8~10년	["Java", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/51241	frontend	f
1566	웹 퍼블리셔 경력채용 (10년이상)	텐빌리언	서울 구로구	경력 10~15년	["JavaScript", "HTML5", "CSS 3", "jQuery"]	모집마감	https://jumpit.saramin.co.kr/position/50258	frontend	f
1567	백엔드개발자 모집(6년~10년)	위버스브레인	서울 구로구	경력 6~10년	["PHP", "Git", "Python", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/50726	backend	f
799	AI기반 프로젝트 개발 PL	미디어로그	서울 마포구	경력 7~12년	["Java", "Spring Boot", "Python", "PyTorch"]	모집마감	https://jumpit.saramin.co.kr/position/50355	backend	f
801	AI기반 바이오마커 예측 (병역특례)	아론티어	서울 서초구	경력 2~10년	["AI/인공지능", "Linux", "Python", "GitHub"]	모집마감	https://jumpit.saramin.co.kr/position/50499	data	f
803	Backend Engineer(5년 이상)	콜로세움코퍼레이션	서울 강남구	경력 5~12년	["Java", "Gradle", "Kotlin", "Spring Boot"]	모집마감	https://jumpit.saramin.co.kr/position/50357	backend	f
804	AI기반 단백질 디자인 (병역특례)	아론티어	서울 서초구	경력 2~10년	["AI/인공지능", "Linux", "Python", "GitHub"]	모집마감	https://jumpit.saramin.co.kr/position/50500	data	f
805	Frontend Engineer	스펙터	서울 강남구	경력 5~10년	["TypeScript", "Next.js", "Zustand"]	모집마감	https://jumpit.saramin.co.kr/position/50688	frontend	f
806	의료기기 백엔드 개발자 모집	에이엠시지	서울 서초구	경력 3~10년	["Python", "FastAPI", "Node.js", "Fastify"]	모집마감	https://jumpit.saramin.co.kr/position/51150	backend	f
807	웹 프론트 개발자 (Vue.js)	티피씨인터넷	서울 강남구	경력 3~6년	["TypeScript", "REST API", "HTML5", "CSS 3"]	모집마감	https://jumpit.saramin.co.kr/position/50562	frontend	f
808	React/React Native 프론트엔드 개발자	페이워크	서울 강남구	경력 3~8년	["HTML5", "CSS 3", "JavaScript", "React"]	모집마감	https://jumpit.saramin.co.kr/position/50429	frontend	f
1569	E-Commerce 개발 담당자 채용	영원아웃도어	서울 중구, 경기 성남시	경력 7~15년	["Microsoft Excel", "Google Analytics"]	모집마감	https://jumpit.saramin.co.kr/position/51380	backend	f
1610	Lua C++ 응용프로그램 운용	엠코프	서울 강동구	신입	["BigData", "Lua", "C#", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/51247	data	f
1613	프론트엔드 개발 경력 (6~9년)	텐빌리언	서울 구로구	경력 6~9년	["JavaScript", "HTML5"]	모집마감	https://jumpit.saramin.co.kr/position/50931	frontend	f
1615	클라우드 엔지니어 경력직 채용	엠포스	서울 서초구	경력 3~10년	["AWS", "Docker", "GCP", "Django", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/51562	backend	f
1618	Java(Back-End)개발자 [리더급 9~20년]	제네시스네스트	경기 용인시	경력 9~20년	["Spring", "Java", "Linux", "Blockchain"]	모집마감	https://jumpit.saramin.co.kr/position/50822	backend	f
1621	Front-End 개발자	제네시스네스트	경기 용인시	경력 1~10년	["React", "AngularJS", "Vue.js", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/51365	frontend	f
1622	Java(Back-End)개발자 [경력 1~8년]	제네시스네스트	경기 용인시	경력 1~8년	["Spring", "Java", "Linux", "Blockchain"]	모집마감	https://jumpit.saramin.co.kr/position/50821	backend	f
1731	ADAS NPU AI SW Engineer	보스반도체	경기 성남시	신입	["PyTorch", "TensorFlow", "DeepLearning"]	모집마감	https://jumpit.saramin.co.kr/position/50109	data	f
1734	인공지능(AI) 엔지니어 신입 채용	알비에치	경기 안양시	신입	["MachineLearning", "DeepLearning"]	모집마감	https://jumpit.saramin.co.kr/position/50551	data	f
1736	강화학습 기반 AI 엔지니어 (3~5년)	아이리브	경기 성남시	경력 3~5년	["PyTorch", "DeepLearning", "Unity"]	모집마감	https://jumpit.saramin.co.kr/position/50176	data	f
1741	강화학습 기반 AI 엔지니어 (6~10년)	아이리브	경기 성남시	경력 6~10년	["PyTorch", "DeepLearning", "Unity"]	모집마감	https://jumpit.saramin.co.kr/position/50177	data	f
1743	웹개발 풀스텍 개발자(신입 )	오마이어스	경기 성남시	신입	["PHP", "Laravel"]	모집마감	https://jumpit.saramin.co.kr/position/50955	backend	f
1744	Java 백엔드 개발자(11~15년)모집	WATA Inc.	경기 성남시	경력 11~15년	["Java", "Spring Framework", "JSP", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/50395	backend	f
1746	사내그룹웨어,파트너 B2B 서비스 개발	지니언스	경기 안양시	경력 1~15년	["Laravel", "Travis CI", "PHP", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/50596	backend	f
1747	인공지능(AI) 엔지니어 초급 채용	알비에치	경기 안양시	경력 1~3년	["MachineLearning", "DeepLearning"]	모집마감	https://jumpit.saramin.co.kr/position/50548	data	f
1784	풀스택(Java) 개발자(전문연구요원가능)	베스텔라랩	대구 동구, 경기 안양시	경력 2~10년	["Spring Framework", "Spring Boot"]	모집마감	https://jumpit.saramin.co.kr/position/51257	backend	f
1785	프론트엔드/풀스택 개발자 채용	크레스콤	경기 성남시	경력 2~20년	["CSS 3", "JavaScript", "React", "Vue.js"]	모집마감	https://jumpit.saramin.co.kr/position/50689	frontend	f
810	MES 솔루션 개발 R&D 리더	한솔피엔에스	서울 강서구	경력 12~20년	["MES", "Spring Boot", "Vue.js", "Java", "ERP"]	모집마감	https://jumpit.saramin.co.kr/position/49847	backend	f
811	보안/인프라/서버 담당자	아이파킹	서울 금천구	경력 4~6년	["HW", "Linux", "Windows", "vmware", "NGINX"]	모집마감	https://jumpit.saramin.co.kr/position/49995	backend	f
812	메세징 서비스 개발자 채용	디어유	서울 강남구	경력 3~7년	["Java", "REST API", "AWS", "Spring Boot"]	모집마감	https://jumpit.saramin.co.kr/position/50347	backend	f
813	솔루션 프론트엔드(Frontend) 개발자	노아시스템즈	서울 성동구	경력 3~7년	["GUI", "REST API", "JavaScript", "React"]	모집마감	https://jumpit.saramin.co.kr/position/50681	frontend	f
814	Web Frontend Developer	바비톡	서울 강남구	경력 7~9년	["aws", "react", "TypeScript", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/50129	frontend	f
816	AI 모델 개발자(2년 이상)	엑셈	서울 강서구	경력 2~10년	["Python", "SQL", "TensorFlow", "AI/인공지능"]	모집마감	https://jumpit.saramin.co.kr/position/50479	data	f
817	솔루션 백엔드(Backend) 개발자	노아시스템즈	서울 성동구	경력 3~7년	["Java", "Shell", "Spring", "Spring Boot"]	모집마감	https://jumpit.saramin.co.kr/position/50680	backend	f
818	[공비서] 자바/코틀린 백엔드 개발자	헤렌	서울 성동구	경력 4~25년	["Java", "Kotlin", "Spring Boot", "Mybatis"]	모집마감	https://jumpit.saramin.co.kr/position/49841	backend	f
820	Runtime 소프트웨어 엔지니어 채용	에너자이	서울 강남구	신입	["AI/인공지능", "C++", "MachineLearning"]	모집마감	https://jumpit.saramin.co.kr/position/50029	data	f
821	데이터 분석 플랫폼 개발자(경력 6~10년)	엠로	서울 영등포구	경력 6~10년	["Java", "Spring Framework", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/51081	backend	f
822	백엔드 디벨로퍼 채용	퀸버	서울 용산구	경력 4~9년	["GitHub", "Node.js", "Python", "AWS", "NoSql"]	모집마감	https://jumpit.saramin.co.kr/position/51182	backend	f
823	IT/AI부문(전문연구요원 포함)신입	연합인포맥스	서울 종로구	신입	["AI/인공지능", "TypeScript", "Next.js"]	모집마감	https://jumpit.saramin.co.kr/position/51367	frontend	f
1788	AI 테스트 도구 백엔드 개발	슈어소프트테크	경기 성남시	경력 2~8년	["Python", "AI/인공지능", "FastAPI", "Flask"]	모집마감	https://jumpit.saramin.co.kr/position/50234	backend	f
1789	인공지능/데이터 분석 개발자 채용	크레스콤	경기 성남시	경력 2~20년	["DeepLearning", "AI/인공지능", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50690	data	f
1791	차량 데이터 검증 솔루션 개발	슈어소프트테크	경기 성남시	경력 2~7년	["Java", "Python", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/50908	data	f
1793	자율주행 로봇 개발자	베스텔라랩	대구 동구, 경기 안양시	경력 2~15년	["Python", "Spring Framework", "AWS", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/51260	backend	f
1794	빅데이터 개발자(전문연구요원가능)	베스텔라랩	대구 동구, 경기 안양시	신입~8년	["Python", "Spring Framework", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/51254	backend	f
1796	자율주행 연구원(전문연구요원가능)	베스텔라랩	대구 동구, 경기 안양시	경력 2~15년	["Python", "Spring Framework", "AWS", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/51262	backend	f
1881	데이터베이스(DB) 개발	모빌리티네트웍스	경기 안양시	경력 10~20년	["SQL", "NoSql", "MySQL", "Oracle"]	모집마감	https://jumpit.saramin.co.kr/position/51287	data	f
1882	백엔드 개발자 채용(경력 10년이상)	하이파킹	경기 성남시	경력 10~20년	["Java", "Spring Boot", "K8S", "Docker", "ELK"]	모집마감	https://jumpit.saramin.co.kr/position/51355	backend	f
1883	컴퓨터 비전 딥러닝/머신러닝(3년이상)	에프에스솔루션	경기 성남시	경력 3~9년	["OpenCV", "C++", "MachineLearning"]	모집마감	https://jumpit.saramin.co.kr/position/50268	data	f
824	프론트엔드 엔지니어 (5년이상)	빅웨이브로보틱스	서울 강남구	경력 5~10년	["React", "Next.js", "TypeScript", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/50668	frontend	f
826	딥러닝 / 이미지 프로세싱 연구 개발	스키아	서울 구로구	신입~3년	["OpenCV", "PyTorch"]	모집마감	https://jumpit.saramin.co.kr/position/51017	data	f
827	데이터 엔지니어 채용	쉬모스랩	서울 강남구	경력 2~7년	["SQL", "PostgreSQL", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50692	data	f
828	[신제품개발] 금융 관련 솔루션 개발자	이노룰스	서울 송파구	경력 7~12년	["Java", "Spring Boot", "JavaScript", "Node.js"]	모집마감	https://jumpit.saramin.co.kr/position/50849	backend	f
834	웹 퍼블리싱 경력 채용	NE능률	서울 마포구	경력 2~8년	["HTML5", "CSS 3", "SCSS", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/51332	frontend	f
835	APLUS AI_숏폼_백엔드 엔지니어	버즈니	서울 관악구	경력 2~10년	["Python", "AWS", "Amazon EKS"]	모집마감	https://jumpit.saramin.co.kr/position/51176	backend	f
836	APLUS AI_Knoi_백엔드 엔지니어	버즈니	서울 관악구	경력 1~10년	["Python", "FastAPI", "Kafka", "pytest"]	모집마감	https://jumpit.saramin.co.kr/position/51174	backend	f
839	프론트엔드 개발자 경력사원 모집	에이피알	서울 송파구	경력 5~10년	["React", "Next.js", "pnpm", "Yarn", "Zustand"]	모집마감	https://jumpit.saramin.co.kr/position/51205	frontend	f
842	모바일 앱 프론트엔드 (React Native)	라라잡	서울 강서구	경력 2~15년	["React Native", "JavaScript", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/50612	frontend	f
843	FMS 설계,개발 S/W 엔지니어 [전문연구요원가능]	토르드라이브	서울 영등포구	경력 3~10년	["C", "C++", "CUDA", "React", "Kubernetes"]	모집마감	https://jumpit.saramin.co.kr/position/50074	frontend	f
846	프론트엔드 개발자(시니어_7년 이상)	에이피티플레이	서울 강남구	경력 7~20년	["TypeScript", "Next.js", "React", "Recoil"]	모집마감	https://jumpit.saramin.co.kr/position/51207	frontend	f
847	Frontend Engineer(Lead)	콜로세움코퍼레이션	서울 강남구	경력 5~10년	["React", "Next.js", "TypeScript", "Storybook"]	모집마감	https://jumpit.saramin.co.kr/position/50356	frontend	f
849	Product Manager	스펙터	서울 강남구	경력 3~10년	["JavaScript", "Python", "Confluence", "Jira"]	모집마감	https://jumpit.saramin.co.kr/position/51027	frontend	f
851	안드로이드 개발자 경력사원(3~7년) 모집	와그	서울 종로구	경력 3~7년	["Kotlin", "Moshi", "Retrofit"]	모집마감	https://jumpit.saramin.co.kr/position/50755	mobile	f
1886	백엔드 개발자 채용(경력 5년~10년)	하이파킹	경기 성남시	경력 5~10년	["Java", "Spring Boot", "ELK", "Kafka"]	모집마감	https://jumpit.saramin.co.kr/position/51356	backend	f
1887	컴퓨터 비전 딥러닝/머신러닝(신입)	에프에스솔루션	경기 성남시	신입	["OpenCV", "C++", "MachineLearning"]	모집마감	https://jumpit.saramin.co.kr/position/50269	data	f
1891	Java 백엔드 개발(광고 서비스)	와디즈	경기 성남시	경력 5~10년	["Java", "Spring", "Spring Boot", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/51337	backend	f
1892	웹개발 풀스텍 개발자(경력2~4년)	오마이어스	경기 성남시	경력 2~4년	["PHP", "Laravel"]	모집마감	https://jumpit.saramin.co.kr/position/50952	backend	f
1895	AI Model Production - LLM	업스테이지	경기 용인시	경력 2~20년	["AI/인공지능"]	모집마감	https://jumpit.saramin.co.kr/position/50528	data	f
853	안드로이드 개발자 경력사원(8~10년) 모집	와그	서울 종로구	경력 8~10년	["Kotlin", "Moshi", "Retrofit"]	모집마감	https://jumpit.saramin.co.kr/position/50757	mobile	f
856	ML Engineer (Embedded, 5~7년)	웨어러블에이아이	서울 영등포구	경력 5~7년	["CUDA", "C", "C++", "Embedded Linux"]	모집마감	https://jumpit.saramin.co.kr/position/50377	data	f
857	ML Engineer (Embedded,8~10년)	웨어러블에이아이	서울 영등포구	경력 8~10년	["CUDA", "C", "C++", "Embedded Linux"]	모집마감	https://jumpit.saramin.co.kr/position/50376	data	f
858	데이터 사이언티스트(5년 이상)	엑셈	서울 강서구	경력 5~15년	["MachineLearning", "DeepLearning"]	모집마감	https://jumpit.saramin.co.kr/position/50480	data	f
861	Back-End Engineer	불마켓랩스(BullMarketLabsCo.Ltd.)	서울 강남구	경력 7~10년	["Kotlin", "Spring Boot", "Go", "Python", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/50303	backend	f
862	쇼핑몰서비스 PHP 개발자 10년↑ 모집	유디아이디	서울 구로구	경력 10~20년	["PHP", "MySQL", "MongoDB", "Laravel"]	모집마감	https://jumpit.saramin.co.kr/position/51120	backend	f
863	Backend Engineer 채용	한국디지털에셋	서울 강남구	경력 5~15년	["Java", "Kotlin", "Gradle", "Go", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/51172	backend	f
864	Tech Innovation 워킹그룹 풀스택 개발	프리윌린	서울 관악구	경력 8~15년	["TypeScript", "AWS", "Spring", "RDB", "Kotlin"]	모집마감	https://jumpit.saramin.co.kr/position/50978	backend	f
1031	Backend Engineer (경력 5~7년)	위펀	서울 강남구	경력 5~7년	["MySQL", "Spring Boot", "Java", "QueryDSL"]	모집마감	https://jumpit.saramin.co.kr/position/50202	backend	f
1897	컴퓨터 비전 딥러닝/머신러닝(팀장급)	에프에스솔루션	경기 성남시	경력 10~15년	["OpenCV", "C++", "MachineLearning"]	모집마감	https://jumpit.saramin.co.kr/position/50267	data	f
1898	AI/ML Senior 연구자	서플러스글로벌	경기 성남시	경력 5~20년	["AI/인공지능", "Python", "R", "NLP", "PyTorch"]	모집마감	https://jumpit.saramin.co.kr/position/50737	data	f
1905	AI 연구개발자 (박사)	더블티	경기 수원시	신입	["AI/인공지능", "PyTorch", "TestNG"]	모집마감	https://jumpit.saramin.co.kr/position/51442	data	f
1911	3D 모션 생성 AI 엔지니어(6~10년)	아이리브	경기 성남시	경력 6~10년	["PyTorch", "DeepLearning", "Unity"]	모집마감	https://jumpit.saramin.co.kr/position/50179	data	f
1917	SOC/IP Verificiation 엔지니어	잇다반도체	경기 화성시	경력 5~8년	["Python", "XML", "Verilog"]	모집마감	https://jumpit.saramin.co.kr/position/51523	data	f
1918	3D 모션 생성 AI 엔지니어(3~5년)	아이리브	경기 성남시	경력 3~5년	["PyTorch", "DeepLearning", "Unity"]	모집마감	https://jumpit.saramin.co.kr/position/50178	data	f
1919	Senior Threat Analyst	에스투더블유	경기 성남시	경력 3~15년	["Git", "MongoDB", "Python", "Docker"]	모집마감	https://jumpit.saramin.co.kr/position/50639	backend	f
1924	인공지능(AI) 엔지니어 중급 채용	알비에치	경기 안양시	경력 4~7년	["MachineLearning", "DeepLearning"]	모집마감	https://jumpit.saramin.co.kr/position/50549	data	f
1931	시스템 개발 Manager	서플러스글로벌	경기 용인시	경력 5~20년	["Java", "REST API", "Spring", "Spring Boot"]	모집마감	https://jumpit.saramin.co.kr/position/50738	backend	f
1932	솔루션개발 및 구축 경력 채용 공고	아이브릭스	경기 성남시	경력 4~8년	["Elasticsearch", "Node.js", "React", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/49806	backend	f
1933	AI Enterprise Manager	업스테이지	경기 용인시	경력 5~20년	["AI/인공지능"]	모집마감	https://jumpit.saramin.co.kr/position/50531	data	f
1935	GUI S/W 설계,개발 채용(10년↑)	에이디티	경기 안산시	경력 10~14년	["Visual C++", "C#", "JavaScript", "Linux"]	모집마감	https://jumpit.saramin.co.kr/position/51402	frontend	f
1936	GUI S/W 설계,개발 채용(15년↑)	에이디티	경기 안산시	경력 15~20년	["Visual C++", "C#", "JavaScript", "Linux"]	모집마감	https://jumpit.saramin.co.kr/position/51403	frontend	f
1938	Senior Data Engineer - LLM	업스테이지	경기 용인시	경력 7~15년	["DeepLearning", "AI/인공지능"]	모집마감	https://jumpit.saramin.co.kr/position/50526	data	f
1939	GUI S/W 설계,개발 채용(5년↑)	에이디티	경기 안산시	경력 5~9년	["Visual C++", "C#", "JavaScript", "Linux"]	모집마감	https://jumpit.saramin.co.kr/position/51401	frontend	f
1940	백엔드 개발자 (5년 이상)	씨앤유글로벌	경기 성남시	경력 5~10년	["Java", "Spring", "Oracle", "MariaDB"]	모집마감	https://jumpit.saramin.co.kr/position/51461	backend	f
867	CAD Engineer - 전문연구요원 가능	이마고웍스	서울 강남구	신입	["TypeScript", "C++", "CMake", "OpenGL"]	모집마감	https://jumpit.saramin.co.kr/position/50674	frontend	f
868	AI 백엔드 시스템 엔지니어	로민	서울 서초구	경력 3~15년	["Python", "FastAPI", "PostgreSQL", "Redis"]	모집마감	https://jumpit.saramin.co.kr/position/51270	backend	f
869	플랫폼 및 운영 엔지니어(DevOps/SRE)	위펀	서울 강남구	경력 5~10년	["MySQL", "Spring Boot", "Java", "QueryDSL"]	모집마감	https://jumpit.saramin.co.kr/position/51524	backend	f
870	백엔드 개발자(PHP) 팀원	테크랩스	서울 강남구	경력 5~10년	["PHP", "JavaScript", "HTML5", "CSS 3"]	모집마감	https://jumpit.saramin.co.kr/position/51151	backend	f
871	서버개발팀 백엔드 개발자(경력)	사이버다임	서울 송파구	경력 5~15년	["Java", "JSP", "Spring Framework", "RDB"]	모집마감	https://jumpit.saramin.co.kr/position/51566	backend	f
873	[인공지능솔루션] Backend Engineer	제논	서울 강남구	경력 3~20년	["Docker", "Python", "FastAPI", "GitHub"]	모집마감	https://jumpit.saramin.co.kr/position/50939	backend	f
874	[인공지능솔루션] AI Engineer	제논	서울 강남구	경력 3~20년	["PyTorch", "TensorFlow", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50941	data	f
875	B2B소프트웨어 DevOps 운영팀(3~7년)	법틀	서울 성동구	경력 3~7년	["Python", "Django", "Java", "Spring Boot"]	모집마감	https://jumpit.saramin.co.kr/position/51213	backend	f
877	[8년 이상] Web Full Stack개발 경력	알스퀘어	서울 강남구	경력 8~15년	["Spring Boot", "Java", "AWS", "Spring", "SQL"]	모집마감	https://jumpit.saramin.co.kr/position/51191	backend	f
878	[Dev] RN Developer 채용	루티너리	서울 서초구	경력 3~15년	["React Native", "JavaScript", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/50966	frontend	f
879	프론트엔드 개발자 (8년 이상)	알스퀘어	서울 강남구	경력 8~15년	["JavaScript", "TypeScript", "React", "vuex"]	모집마감	https://jumpit.saramin.co.kr/position/51189	frontend	f
882	Sr. 백엔드개발자(경력 5-10년)	리코	서울 강남구	경력 5~10년	["Vue.js", "TypeScript", "Kotlin", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/50647	backend	f
883	풀스택 개발자 (5~10년) [강남구]	모멘티	서울 강남구	경력 5~10년	["Vue.js", "React", "Flutter", "React Native"]	모집마감	https://jumpit.saramin.co.kr/position/51130	frontend	f
884	풀스택 개발자 (1~4년) [강남구]	모멘티	서울 강남구	경력 1~4년	["Vue.js", "React", "Flutter", "React Native"]	모집마감	https://jumpit.saramin.co.kr/position/51108	frontend	f
832	모바일앱 플러터 Flutter 개발자	아몬드컴퍼니	서울 강남구	경력 2~5년	["Flutter", "Android", "iOS", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/51061	mobile	f
1947	솔루션개발 및 구축 PL 채용	아이브릭스	경기 성남시	경력 8~15년	["Node.js", "JavaScript", "ELK", "React"]	모집마감	https://jumpit.saramin.co.kr/position/50996	backend	f
1951	프론트엔드 개발자	오투플러스	경기 용인시	경력 3~10년	["Git", "REST API", "React", "vuex", "Vue.js"]	모집마감	https://jumpit.saramin.co.kr/position/51224	frontend	f
1953	빅데이터,서버 백엔드 엔지니어	미리비트	경기 성남시	경력 7~15년	["Kubernetes", "BigData", "Spark"]	모집마감	https://jumpit.saramin.co.kr/position/51555	backend	f
1957	비전기반 AI 엔지니어(4~6년)	에이딘로보틱스	경기 안양시	경력 4~6년	["Python", "PyTorch", "OpenCV", "Linux"]	모집마감	https://jumpit.saramin.co.kr/position/51622	data	f
885	프론트엔드 개발자 (1~4년) [강남구]	모멘티	서울 강남구	경력 1~4년	["HTML5", "CSS 3", "JavaScript", "Bootstrap"]	모집마감	https://jumpit.saramin.co.kr/position/51107	frontend	f
886	백엔드 개발자 (Java & Spring, AWS 클라우드)	주식회사 도브러너	서울 강남구	경력 7~20년	["AWS", "Kafka", "Java", "Spring Framework"]	모집마감	https://jumpit.saramin.co.kr/position/50774	backend	f
887	ML Engineer (ML 엔지니어)	메이아이	서울 강남구	경력 5~10년	["FastAPI", "Django", "PostgreSQL", "Airflow"]	모집마감	https://jumpit.saramin.co.kr/position/49941	backend	f
889	Deep Learning Optimization Engineer	모빌린트	서울 강남구	신입~10년	["Python", "PyTorch", "TensorFlow"]	모집마감	https://jumpit.saramin.co.kr/position/50328	data	f
890	DRM team Tech Lead (Cloud SaaS)	주식회사 도브러너	서울 강남구	경력 10~25년	["AWS", "Elasticsearch", "Java", "Spring Boot"]	모집마감	https://jumpit.saramin.co.kr/position/50298	backend	f
891	Tech Lead (Backend, Frontend, Cloud SaaS)	주식회사 도브러너	서울 강남구	경력 10~25년	["AWS", "Elasticsearch", "Java", "Spring Boot"]	모집마감	https://jumpit.saramin.co.kr/position/50299	backend	f
892	AI 국제 물류 스타트업 백엔드 개발자	아로아랩스	서울 마포구	경력 2~5년	["Go", "GitHub", "SQL", "AZURE", "vscode.dev"]	모집마감	https://jumpit.saramin.co.kr/position/50430	backend	f
893	Backend Engineer (경력 8~12년)	위펀	서울 강남구	경력 8~12년	["MySQL", "Spring Boot", "Java", "QueryDSL"]	모집마감	https://jumpit.saramin.co.kr/position/50203	backend	f
896	백엔드 개발자 경력 정규직 채용	엠투클라우드	서울 송파구	경력 6~10년	["JavaScript", "Spring MVC", "MySQL", "RDB"]	모집마감	https://jumpit.saramin.co.kr/position/50602	backend	f
898	의류제조시스템 AI 모델 적용 개발자 경력	호전실업	서울 마포구	경력 3~10년	["TensorFlow", "PyTorch"]	모집마감	https://jumpit.saramin.co.kr/position/51280	data	f
899	프론트엔드 개발	엔에이치엔링크	서울 강남구	경력 5~15년	["JavaScript", "TypeScript", "HTML5", "CSS 3"]	모집마감	https://jumpit.saramin.co.kr/position/51208	frontend	f
900	프론트엔드 개발 경력 정규직 채용	엠투클라우드	서울 송파구	경력 6~10년	["JavaScript", "HTML5", "CSS 3", "AngularJS"]	모집마감	https://jumpit.saramin.co.kr/position/50600	frontend	f
1958	비전기반 AI 엔지니어(1~3년)	에이딘로보틱스	경기 안양시	경력 1~3년	["Python", "PyTorch", "OpenCV", "Linux"]	모집마감	https://jumpit.saramin.co.kr/position/51621	data	f
1960	고급 백엔드 설계 개발자(10~12년)	티투엘	경기 고양시	경력 10~12년	["Java"]	모집마감	https://jumpit.saramin.co.kr/position/50170	backend	f
1961	인프라(시스템엔지니어) 개발자_11년↑	바텍	경기 화성시	경력 11~20년	["Kubernetes", "GitHub", "Jira", "MongoDB"]	모집마감	https://jumpit.saramin.co.kr/position/51106	backend	f
1963	프론트엔드 개발(7~9년)	블링크큐벡스핀	경기 군포시	경력 7~9년	["JavaScript", "PHP", "Figma", "HTML5"]	모집마감	https://jumpit.saramin.co.kr/position/50565	frontend	f
1964	Back-end 개발자 추가 모집	오투플러스	경기 용인시	경력 3~10년	["RDB", "MySQL", "RabbitMQ", "PHP"]	모집마감	https://jumpit.saramin.co.kr/position/51223	backend	f
1965	데이터허브 개발 리더(13~15년)	디토닉	경기 성남시	경력 13~15년	["Java", "Kotlin", "Linux", "Spring Boot"]	모집마감	https://jumpit.saramin.co.kr/position/51482	backend	f
1967	프론트엔드 개발(13~15년)	블링크큐벡스핀	경기 군포시	경력 13~15년	["JavaScript", "PHP", "Figma", "HTML5"]	모집마감	https://jumpit.saramin.co.kr/position/50567	frontend	f
1968	중급 백엔드 개발자 (8~10년)	티투엘	경기 고양시	경력 8~10년	["Java"]	모집마감	https://jumpit.saramin.co.kr/position/50169	backend	f
1972	영상 AI개발자	호각	경기 성남시	경력 2~10년	["Kafka", "MQTT", "DeepLearning", "PyTorch"]	모집마감	https://jumpit.saramin.co.kr/position/51530	data	f
901	[일레븐플러스]프론트엔드 개발자(React)	캔랩코리아	서울 서초구	경력 2~10년	["React", "Vue.js", "Mocha", "Jasmine", "Jest"]	모집마감	https://jumpit.saramin.co.kr/position/50184	frontend	f
902	클라우드 Java 백엔드 개발자 채용	아이파킹	서울 금천구	경력 4~6년	["Java", "Spring Boot", "NoSql", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/49996	backend	f
903	AI 최적화 Researcher 채용	에너자이	서울 강남구	신입	["AI/인공지능", "TensorFlow", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50027	data	f
904	안드로이드 개발자 (Android Developer)	바로팜	서울 강남구	경력 5~7년	["Kotlin", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/50875	mobile	f
906	티켓링크 연동 서비스 개발	엔에이치엔링크	서울 강남구	경력 3~4년	["Java", "Spring", "REST API", "NoSql", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/50980	backend	f
908	Backend Junior Engineer(PHP/Python)	코비그룹	서울 강남구	신입~3년	["Linux", "Python", "AWS", "SQL", "Laravel"]	모집마감	https://jumpit.saramin.co.kr/position/51347	backend	f
910	웹어플리케이션 백엔드 경력 (2년↑)	이글루코퍼레이션	서울 송파구	경력 2~7년	["Spring Framework", "MySQL", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/51188	backend	f
911	[삼성계열사]백엔드 서버/보안 솔루션	씨브이네트	서울 송파구	경력 5~20년	["Java", "Spring", "Spring Boot", "C", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/50863	backend	f
914	Back-End 개발자(9년 이상 필수)	오로라파이브	서울 영등포구	경력 9~10년	["MongoDB", "TypeScript", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/50516	backend	f
918	WEBFRONT-K GUI 개발	파이오링크	서울 금천구	경력 3~13년	["Java", "C", "C++", "Linux", "Django"]	모집마감	https://jumpit.saramin.co.kr/position/51123	backend	f
1973	인프라(시스템엔지니어) 개발자_3~5년	바텍	경기 화성시	경력 3~5년	["Kubernetes", "GitHub", "Jira", "MongoDB"]	모집마감	https://jumpit.saramin.co.kr/position/51104	backend	f
1975	고급 백엔드 설계 개발자(16~18년)	티투엘	경기 고양시	경력 16~18년	["Java"]	모집마감	https://jumpit.saramin.co.kr/position/50175	backend	f
1977	임베디드 소프트웨어 개발자 (Junior)	디엑스솔루션	경기 성남시	신입	["Spring Framework", "AI/인공지능", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/51147	backend	f
1978	프론트엔드 개발자 경력(11~13년) 채용	세계입찰	경기 부천시	경력 11~13년	["HTML5", "C", "C#", "JavaScript", "Node.js"]	모집마감	https://jumpit.saramin.co.kr/position/51520	backend	f
1979	App(React Native) 개발자(전문연구요원가능)	베스텔라랩	대구 동구, 경기 안양시	경력 2~10년	["Python", "Spring Framework", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/51258	backend	f
1980	개발자	베스텔라랩	경기 안양시	경력 5~14년	["Python", "Spring Boot", "AWS", "Git", "ROS"]	모집마감	https://jumpit.saramin.co.kr/position/51259	backend	f
1981	데이터분석가 경력(8~10년) 채용	세계입찰	경기 부천시	경력 8~10년	["Python", "SQL", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/51503	data	f
1982	프론트엔드 개발자 경력(5~7년) 채용	세계입찰	경기 부천시	경력 5~7년	["HTML5", "C", "C#", "JavaScript", "Node.js"]	모집마감	https://jumpit.saramin.co.kr/position/51518	backend	f
1985	인프라(시스템엔지니어) 개발자_6~10년	바텍	경기 화성시	경력 6~10년	["Kubernetes", "GitHub", "Jira", "MongoDB"]	모집마감	https://jumpit.saramin.co.kr/position/51105	backend	f
1987	데이터허브 개발 리더(7~9년)	디토닉	경기 성남시	경력 7~9년	["Java", "Kotlin", "Linux", "Spring Boot"]	모집마감	https://jumpit.saramin.co.kr/position/51480	backend	f
1988	데이터분석가 경력(11~13년) 채용	세계입찰	경기 부천시	경력 11~13년	["Python", "SQL", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/51507	data	f
1989	개발PM	오투플러스	경기 용인시	경력 10~15년	["React", "Java", "PHP", "Docker"]	모집마감	https://jumpit.saramin.co.kr/position/51222	frontend	f
1990	프론트엔드 개발(10~12년)	블링크큐벡스핀	경기 군포시	경력 10~12년	["JavaScript", "PHP", "Figma", "HTML5"]	모집마감	https://jumpit.saramin.co.kr/position/50566	frontend	f
919	Frontend Engineer(React)(경력 8~12년)	위펀	서울 강남구	경력 8~12년	["JavaScript", "Git", "TypeScript", "React"]	모집마감	https://jumpit.saramin.co.kr/position/50201	frontend	f
922	백엔드 개발자(6~10년)	더블미디어	서울 강남구	경력 6~10년	["Golang", "Redis", "SQL", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/50181	backend	f
923	백엔드 개발자(7년 이상)	에이아이파크	서울 마포구	경력 7~10년	["jQuery", "Ajax", "Java", "Python", "NGINX"]	모집마감	https://jumpit.saramin.co.kr/position/51034	backend	f
924	백엔드 개발자(3~5년)	더블미디어	서울 강남구	경력 3~5년	["Golang", "Redis", "SQL", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/50180	backend	f
925	ADC(L4-L7 스위치) 애플리케이션 개발	파이오링크	서울 금천구	경력 2~10년	["Linux", "C", "L4", "L7", "Git", "React", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/51022	frontend	f
927	매쓰플랫 백엔드 개발	프리윌린	서울 관악구	경력 5~10년	["TypeScript", "AWS", "Spring", "RDB", "Kotlin"]	모집마감	https://jumpit.saramin.co.kr/position/50976	backend	f
928	Golang 개발자(3년 이상)	엑셈	서울 강서구	경력 3~8년	["Go", "Docker", "Kubernetes", "gRPC"]	모집마감	https://jumpit.saramin.co.kr/position/50846	backend	f
929	[인공지능솔루션] Data Scientist	제논	서울 강남구	경력 3~20년	["PyTorch", "TensorFlow", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50940	data	f
932	쇼핑몰서비스 PHP 개발자 3년↑ 모집	유디아이디	서울 구로구	경력 3~5년	["PHP", "MySQL", "MongoDB", "Laravel"]	모집마감	https://jumpit.saramin.co.kr/position/51118	backend	f
934	시니어 풀스택 개발자	아보엠디코리아	서울 강남구	경력 5~15년	["React", "NoCodeAPI", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/51333	frontend	f
935	프론트엔드 개발자 (5~10년) [강남구]	모멘티	서울 강남구	경력 5~10년	["HTML5", "CSS 3", "JavaScript", "Bootstrap"]	모집마감	https://jumpit.saramin.co.kr/position/51110	frontend	f
936	Business Data Analyst(데이터 분석가)	엔카닷컴	서울 중구	경력 3~10년	["Insight", "DB", "DataTables", "Dw", "SQL"]	모집마감	https://jumpit.saramin.co.kr/position/50498	data	f
937	[DOF] Algorithm SW Engineer	디오에프	서울 성동구	경력 7~15년	["CUDA", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/51143	backend	f
940	SI 개발	미디어로그	서울 마포구	경력 8~10년	["Java", "Spring Boot", "Vue.js", "Oracle"]	모집마감	https://jumpit.saramin.co.kr/position/50145	backend	f
941	Computer Vision Engineer(CV엔지니어)	메이아이	서울 강남구	신입~10년	["MachineLearning", "AI/인공지능"]	모집마감	https://jumpit.saramin.co.kr/position/49942	data	f
1992	데이터분석가 경력(5~7년) 채용	세계입찰	경기 부천시	경력 5~7년	["Python", "SQL", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/51502	data	f
1993	프론트엔드 개발자 경력(8~10년) 채용	세계입찰	경기 부천시	경력 8~10년	["HTML5", "C", "C#", "JavaScript", "Node.js"]	모집마감	https://jumpit.saramin.co.kr/position/51519	backend	f
1994	데이터허브 개발 리더(10~12년)	디토닉	경기 성남시	경력 10~12년	["Java", "Kotlin", "Linux", "Spring Boot"]	모집마감	https://jumpit.saramin.co.kr/position/51481	backend	f
1995	시니어 백엔드 SW Engineer	제이앤피메디	인천 연수구	경력 8~20년	["TypeScript", "MSA", "MySQL", "Node.js"]	모집마감	https://jumpit.saramin.co.kr/position/50036	backend	f
942	오프라인 결제 개발자(4~6년)	엑심베이	서울 구로구	경력 4~6년	["Java", "JavaScript", "Spring Framework"]	모집마감	https://jumpit.saramin.co.kr/position/50310	backend	f
947	[Python] AI 플랫폼 개발자	딥노이드	서울 구로구	경력 2~7년	["Python", "Spark", "Elasticsearch", "Airflow"]	모집마감	https://jumpit.saramin.co.kr/position/31070	data	f
948	빅데이터 기반 교육 플랫폼 Node/NestJS 백엔드 개발자	퍼플아카데미	서울 양천구	경력 3~8년	["JavaScript", "SQL", "BigData", "Node.js"]	모집마감	https://jumpit.saramin.co.kr/position/49866	backend	f
949	Frontend Engineer(React)(경력 5~7년)	위펀	서울 강남구	경력 5~7년	["JavaScript", "Git", "TypeScript", "React"]	모집마감	https://jumpit.saramin.co.kr/position/50200	frontend	f
950	프론트엔드 개발자 (경력 6년~9년)	퍼퓸그라피	서울 종로구	경력 6~9년	["React", "Node.js", "HTML5", "CSS 3"]	모집마감	https://jumpit.saramin.co.kr/position/49849	backend	f
1996	시니어 프론트엔드 SW Engineer	제이앤피메디	인천 연수구	경력 8~20년	["JavaScript", "MSA", "TypeScript", "React"]	모집마감	https://jumpit.saramin.co.kr/position/50037	frontend	f
1999	백엔드(Back-end)개발자(경력 7년이상)	유진로봇	인천 연수구	경력 7~15년	["JavaScript", "Network", "RDB", "NoSql"]	모집마감	https://jumpit.saramin.co.kr/position/50276	backend	f
2000	SAS사업부 글로벌프로젝트 PM채용	유진로봇	인천 연수구	경력 10~15년	["Google Analytics", "SQL", "Microsoft Excel"]	모집마감	https://jumpit.saramin.co.kr/position/50270	backend	f
2002	시니어 풀스택 SW Engineer	제이앤피메디	인천 연수구	경력 8~20년	["MSA", "TypeScript", "JSX", "Sass"]	모집마감	https://jumpit.saramin.co.kr/position/50038	frontend	f
2006	스마트팩토리 자율주행로봇 S/W 개발자	인아텍앤코포	인천 남동구	경력 1~5년	["ROS", "C++", "Python", "AI/인공지능", "Linux"]	모집마감	https://jumpit.saramin.co.kr/position/50484	data	f
2009	홈페이지 유지보수 경력(1~3년)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 1~3년	["Java", "JavaScript", "JSP"]	모집마감	https://jumpit.saramin.co.kr/position/50039	frontend	f
2010	전산팀 앱개발 경력 채용(8년 이상)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 8~10년	["Java", "Spring Boot", "Linux", "Oracle", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/49825	backend	f
2011	웹개발자 경력(8년이상)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 8~10년	["JavaScript", "Node.js", "React", "Vue.js"]	모집마감	https://jumpit.saramin.co.kr/position/49826	backend	f
2013	알고리즘 개발자 신입 채용	엘리펀트키즈에듀테인먼트	인천 계양구	신입	["TensorFlow", "Keras", "Slim"]	모집마감	https://jumpit.saramin.co.kr/position/50878	data	f
2014	홈페이지 유지보수 경력채용	엘리펀트키즈에듀테인먼트	인천 계양구	경력 4~6년	["Java", "JavaScript", "JSP"]	모집마감	https://jumpit.saramin.co.kr/position/51592	frontend	f
2018	프론트엔드 개발자 경력채용(2~4년)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 2~4년	["JavaScript", "Next.js", "TypeScript", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/51589	frontend	f
2019	알고리즘 개발자 경력 채용(3~5년)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 3~5년	["TensorFlow", "Keras", "Slim"]	모집마감	https://jumpit.saramin.co.kr/position/50879	data	f
2021	알고리즘 개발자 경력 채용(6~8년)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 6~8년	["TensorFlow", "Keras", "Slim"]	모집마감	https://jumpit.saramin.co.kr/position/50880	data	f
2022	프론트엔드 개발자 경력채용(8~10년)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 8~10년	["JavaScript", "Next.js", "TypeScript", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/51591	frontend	f
2023	프론트엔드 개발 경력(5~7년)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 5~7년	["JavaScript", "Next.js", "TypeScript", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/51590	frontend	f
2024	AMS사업부 ACS 개발자 채용	유진로봇	인천 연수구	경력 5~12년	["C#", "Java", "JavaScript", "PLC", "Git", "MES"]	모집마감	https://jumpit.saramin.co.kr/position/50273	frontend	f
2034	인공지능 SW개발 (5~7)	바이트사이즈	부산 부산진구	경력 5~10년	["Python", "NLP", "Git", "Airflow", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/49896	data	f
2035	Fullstack 개발 (5년이상)	바이트사이즈	부산 부산진구	경력 5~9년	["Python", "JavaScript", "MySQL", "PyTorch"]	모집마감	https://jumpit.saramin.co.kr/position/49895	frontend	f
2036	AI(인공지능) 개발 및 데이터 분석 연구자	마린웍스	부산 동구	경력 1~3년	["Python", "C#", "DeepLearning", "BigData"]	모집마감	https://jumpit.saramin.co.kr/position/51216	data	f
2037	택스아이 개발팀리더 (부산)	뉴아이	부산 남구	경력 4~15년	["HTML5", "CSS 3", "Java", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/51293	frontend	f
2038	프론트엔드 개발자 (Next JS)_부산	뉴아이	부산 남구	경력 3~15년	["HTML5", "CSS 3", "Java", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/51296	frontend	f
2039	Tech - Software Engineer	벙커키즈	부산 금정구	경력 1~10년	["Python", "Redis", "PyTorch", "TensorFlow"]	모집마감	https://jumpit.saramin.co.kr/position/51129	data	f
951	AI 컴파일러 엔지니어 채용	에너자이	서울 강남구	신입~10년	["C++", "Haskell", "DeepLearning", "F#"]	모집마감	https://jumpit.saramin.co.kr/position/50028	data	f
952	ERP시스템 운영 담당자(4년 이상)	이지스엔터프라이즈	서울 금천구	경력 4~10년	["Java", "JavaScript", "Oracle", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/51015	frontend	f
954	백엔드 주니어 개발자(.NET Core/GCP)	엠엑스엔커머스코리아	서울 성동구	경력 1~2년	[".NET", "GitHub", "RDB", "PostgreSQL"]	모집마감	https://jumpit.saramin.co.kr/position/51179	backend	f
955	Frontend Engineer 채용	한국디지털에셋	서울 강남구	신입~3년	["React", "Next.js", "Zustand", "CSS 3"]	모집마감	https://jumpit.saramin.co.kr/position/51173	frontend	f
956	백엔드 개발자(경력)	아인잡	서울 강남구	경력 4~10년	["AWS", "Java", "MongoDB", "MySQL", "Redis"]	모집마감	https://jumpit.saramin.co.kr/position/50080	backend	f
957	프론트엔드/풀스택 개발자 모집	엠엑스엔커머스코리아	서울 성동구	경력 2~4년	["React", "JavaScript", "Node.js", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/51181	backend	f
959	Python Back-end Enginner	올거나이즈코리아	서울 강남구	경력 2~5년	["Python", "Backendless"]	모집마감	https://jumpit.saramin.co.kr/position/51372	backend	f
960	자바(JAVA) 웹 개발자 모집	뉴버드	서울 서대문구	경력 3~5년	["MySQL", "Vue.js", "Java", "Spring"]	모집마감	https://jumpit.saramin.co.kr/position/50961	backend	f
963	네트워크 정보보호 개발자 (경력)	위드네트웍스	서울 강서구	경력 5~10년	["Java", "Spring Boot", "React", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/50245	backend	f
964	서버 백엔드 개발[경력]	패션앤스타일컴퍼니	서울 종로구	경력 6~15년	["Java", "Spring", "Spring Framework"]	모집마감	https://jumpit.saramin.co.kr/position/50900	backend	f
966	프론트엔드 개발자 경력 채용	위볼린	서울 성동구	경력 2~5년	["GitLab", "React", "Next.js", "Git", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/51350	frontend	f
967	프론트엔드 개발자	아인잡	서울 강남구	경력 3~10년	["CSS 3", "Jira", "React", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/50081	frontend	f
968	웹 프론트엔드 개발자 추가 모집	마스터웨이	서울 강서구	신입~3년	["React", "TypeScript", "Recoil", "React Query"]	모집마감	https://jumpit.saramin.co.kr/position/49781	frontend	f
969	MES개발/운영 경력 채용	한솔피엔에스	서울 강서구	경력 5~10년	["MES", "Spring Boot", "Vue.js", "Java", "ERP"]	모집마감	https://jumpit.saramin.co.kr/position/50666	backend	f
970	Senior S/W Engineer-Embedded AI [전문연구요원가능]	토르드라이브	서울 영등포구	경력 3~10년	["C", "C++", "CUDA"]	모집마감	https://jumpit.saramin.co.kr/position/50072	data	f
971	프론트엔드 개발자	에피소든	서울 강남구	경력 5~15년	["React", "Next.js", "TypeScript", "WebRTC"]	모집마감	https://jumpit.saramin.co.kr/position/50628	frontend	f
2040	Tech - Frontend Engineer	벙커키즈	부산 금정구	경력 3~10년	["JavaScript", "TypeScript", "Emotion"]	모집마감	https://jumpit.saramin.co.kr/position/51128	frontend	f
972	백엔드 개발 팀장 (3~5년)	앱티마이저	서울 관악구	경력 3~5년	["Django", "Celery", "Redis", "Amazon S3"]	모집마감	https://jumpit.saramin.co.kr/position/50790	backend	f
974	Back-end Developer (5년 이상)	미소	서울 종로구	경력 5~20년	["MSA", "Node.js", "AWS", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/50807	backend	f
977	웹 프론트엔드 개발자(React 4년 이상)	라라잡	서울 강서구	경력 4~15년	["React Native", "JavaScript", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/50611	frontend	f
981	[스윗트래커]프론트엔드개발(5년 이상)	커넥트웨이브	서울 금천구	경력 5~10년	["JavaScript", "jQuery", "Vue.js", "React"]	모집마감	https://jumpit.saramin.co.kr/position/50851	frontend	f
987	프론트엔드/풀스택 시니어 개발자 모집	엠엑스엔커머스코리아	서울 성동구	경력 5~7년	["React", "JavaScript", "Node.js", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/51180	backend	f
988	생성형 AI 개발자 채용	시어스랩	서울 서초구	경력 3~10년	["AI/인공지능"]	모집마감	https://jumpit.saramin.co.kr/position/50358	data	f
989	웹 개발자(경력) 채용	씨알에스큐브	서울 마포구	경력 3~8년	["Java", "jQuery", "JavaScript", "HTML5"]	모집마감	https://jumpit.saramin.co.kr/position/49922	frontend	f
990	자연어처리/ Python 엔진 개발	아일리스프런티어	서울 종로구	경력 1~3년	["NoSql", "Python", "Django", "Flask", "FastAPI"]	모집마감	https://jumpit.saramin.co.kr/position/49815	backend	f
991	ML 엔지니어 (2년 이상)	피카부랩스	서울 강남구	경력 2~20년	["Python", "PyTorch", "TensorFlow"]	모집마감	https://jumpit.saramin.co.kr/position/50959	data	f
992	[플랫폼개발팀] Java Senior 개발자	델레오코리아	서울 강남구	경력 8~20년	["REST API", "Java", "Spring Boot", "Spring"]	모집마감	https://jumpit.saramin.co.kr/position/49911	backend	f
2041	[제로아이즈]개발팀 Lead_경력10~12년	오래	부산 해운대구	경력 10~12년	["Vue.js", "TypeScript", "Node.js", "ExpressJS"]	모집마감	https://jumpit.saramin.co.kr/position/50043	backend	f
2042	[제로아이즈] PM/기획 매니저	오래	부산 해운대구	경력 7~10년	["AWS", "Swagger UI", "MySQL", "Node.js"]	모집마감	https://jumpit.saramin.co.kr/position/50045	backend	f
2074	[AI Agent 구축] AI 개발자	아파트너스	광주 동구	경력 1~5년	["Python", "AI/인공지능", "Embedded"]	모집마감	https://jumpit.saramin.co.kr/position/51084	data	f
2043	[제로아이즈]개발팀 Lead_경력13~15년	오래	부산 해운대구	경력 13~15년	["Vue.js", "TypeScript", "Node.js", "ExpressJS"]	모집마감	https://jumpit.saramin.co.kr/position/50044	backend	f
2044	[제로아이즈]개발팀 Lead_경력3~9년	오래	부산 해운대구	경력 3~7년	["Vue.js", "TypeScript", "Node.js", "ExpressJS"]	모집마감	https://jumpit.saramin.co.kr/position/50042	backend	f
2045	AI 개발 및 데이터 분석 연구자(1-3년)	마린웍스	부산 동구	경력 1~3년	["Python", "C#", "DeepLearning", "BigData"]	모집마감	https://jumpit.saramin.co.kr/position/51526	data	f
2046	백앤드 개발 리더 [5~7년]	론픽	부산 해운대구	경력 5~7년	["Python", "Django", "PostgreSQL", "Docker"]	모집마감	https://jumpit.saramin.co.kr/position/51513	backend	f
2047	AI 개발 및 데이터 분석 연구자(3년이상)	마린웍스	부산 동구	경력 3~5년	["Python", "C#", "DeepLearning", "BigData"]	모집마감	https://jumpit.saramin.co.kr/position/51527	data	f
2048	백앤드 개발 리더 [11년 이상]	론픽	부산 해운대구	경력 11~20년	["Python", "Django", "PostgreSQL", "Docker"]	모집마감	https://jumpit.saramin.co.kr/position/51515	backend	f
2050	백앤드 개발 리더 [8~10년]	론픽	부산 해운대구	경력 8~10년	["Python", "Django", "PostgreSQL", "Docker"]	모집마감	https://jumpit.saramin.co.kr/position/51514	backend	f
2055	인프라서비스팀_백엔드개발(주임)	리만코리아	대구 수성구	경력 3~6년	["Java", "Spring Framework", "Spring Boot"]	모집마감	https://jumpit.saramin.co.kr/position/51184	backend	f
2057	인프라서비스팀_백엔드개발(과장)	리만코리아	대구 수성구	경력 10~12년	["Java", "Spring Framework", "Spring Boot"]	모집마감	https://jumpit.saramin.co.kr/position/51186	backend	f
2058	인프라서비스팀_백엔드개발(대리)	리만코리아	대구 수성구	경력 7~9년	["Java", "Spring Framework", "Spring Boot"]	모집마감	https://jumpit.saramin.co.kr/position/51185	backend	f
993	Deep Learning Research Engineer	모빌린트	서울 강남구	신입~10년	["Python", "PyTorch", "TensorFlow"]	모집마감	https://jumpit.saramin.co.kr/position/50327	data	f
996	자사앱/웹 관리자 채용[9~12년]	제너시스비비큐	서울 송파구	경력 9~12년	["Java", "Spring Boot", "MSSQL", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/50888	backend	f
997	iOS 개발자	티피씨인터넷	서울 강남구	경력 2~4년	["iOS", "Swift", "Rxswift"]	모집마감	https://jumpit.saramin.co.kr/position/51153	mobile	f
999	서버 개발자	코보시스	서울 송파구	경력 3~15년	["Java", "Spring Boot", "JSP", "Linux"]	모집마감	https://jumpit.saramin.co.kr/position/49934	backend	f
1002	향수 커머스 웹개발자(미들급) 채용	퍼퓸그라피	서울 종로구	경력 4~6년	["React", "Node.js", "HTML5", "CSS 3"]	모집마감	https://jumpit.saramin.co.kr/position/49850	backend	f
1003	Vision AI/Graphics 기술연구 총괄	시어스랩	서울 서초구	경력 15~20년	["AI/인공지능"]	모집마감	https://jumpit.saramin.co.kr/position/50360	data	f
1004	UI/UX 개발자 경력 정규직 채용	엠투클라우드	서울 송파구	경력 2~6년	["JavaScript", "HTML5", "CSS 3", "jQuery"]	모집마감	https://jumpit.saramin.co.kr/position/50601	frontend	f
1005	iOS Engineer (Intermediate) 채용	이지식스(엠블)	서울 강남구	경력 3~7년	["Rxswift", "Swift", "iOS", "MVVM"]	모집마감	https://jumpit.saramin.co.kr/position/50339	mobile	f
1006	프론트엔드 개발자 (경력 3년~5년)	퍼퓸그라피	서울 종로구	경력 3~5년	["React", "Node.js", "HTML5", "CSS 3"]	모집마감	https://jumpit.saramin.co.kr/position/49848	backend	f
1007	서버 백엔드 개발[신입]	패션앤스타일컴퍼니	서울 종로구	신입	["Java", "Spring", "Spring Framework"]	모집마감	https://jumpit.saramin.co.kr/position/50901	backend	f
1010	Back-End 개발자(6년 이상 필수)	오로라파이브	서울 영등포구	경력 6~8년	["MongoDB", "TypeScript", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/50515	backend	f
1012	Backend Engineer (Go)	센트비	서울 영등포구	경력 4~10년	["Golang", "gRPC", "PostgreSQL", "Redis", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/50708	backend	f
1014	AI개발자 (3D 피부분석)	룰루랩	서울 강남구	경력 1~10년	["Python", "PyTorch"]	모집마감	https://jumpit.saramin.co.kr/position/50199	data	f
1015	Flutter 앱개발자 (3~5년)	시어스랩	서울 서초구	경력 3~5년	["Flutter", "Dart", "REST API", "WebSocket"]	모집마감	https://jumpit.saramin.co.kr/position/50361	mobile	f
1030	병원정보시스템 클라우드(EMR) 개발자	이지케어텍(edge&next)	서울 중구	경력 3~18년	["C#", "WPF", ".NET", "Oracle", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/50471	frontend	f
1032	풀스텍 개발자 경력 채용	위볼린	서울 성동구	경력 2~5년	["Next.js", "Node.js", "NestJS", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/51351	backend	f
1033	프론트엔드 개발자	버추얼랩	서울 성동구	경력 3~10년	["Vue.js", "Bootstrap", "Nuxt.js", "Vuetify"]	모집마감	https://jumpit.saramin.co.kr/position/50009	frontend	f
1034	오프라인 결제 개발자(7년↑)	엑심베이	서울 구로구	경력 7~10년	["Java", "JavaScript", "Spring Framework"]	모집마감	https://jumpit.saramin.co.kr/position/50311	backend	f
1035	백엔드 개발자(웹,인프라)	에피소든	서울 강남구	경력 5~20년	["TypeScript", "NestJS", "PostgreSQL"]	모집마감	https://jumpit.saramin.co.kr/position/50627	backend	f
1037	[누구(nugu)] BE엔지니어(시니어)	메디쿼터스	서울 강남구	경력 10~20년	["Go", "gRPC", "Kafka", "RDB", "NoSql", "MSA"]	모집마감	https://jumpit.saramin.co.kr/position/50943	backend	f
1038	AI개발자 채용	웅진	서울 중구	경력 3~20년	["Java", "AI/인공지능", "SQL", "Python", "R"]	모집마감	https://jumpit.saramin.co.kr/position/49992	data	f
1039	백엔드 개발자 (5년 이상)	아이헤이트플라잉버그스	서울 영등포구	경력 5~7년	["NestJS", "TypeScript", "Node.js", "Kotlin"]	모집마감	https://jumpit.saramin.co.kr/position/50304	backend	f
1040	프론트엔드 (3년 이상)	시어스랩	서울 서초구	경력 3~10년	["WebSocket", "GraphQL", "React", "Vue.js"]	모집마감	https://jumpit.saramin.co.kr/position/50359	frontend	f
1041	수요예측/데이터 분석 전문가(중/고급)	디에스이트레이드	서울 서초구	경력 3~10년	["Python", "SQL", "TensorFlow", "Keras"]	모집마감	https://jumpit.saramin.co.kr/position/49882	data	f
1042	오프라인 결제 개발자(1~3년)	엑심베이	서울 구로구	경력 1~3년	["Java", "JavaScript", "Spring Framework"]	모집마감	https://jumpit.saramin.co.kr/position/51398	backend	f
1043	향수 커머스 웹개발자(시니어급) 채용	퍼퓸그라피	서울 종로구	경력 6~9년	["React", "Node.js", "HTML5", "CSS 3"]	모집마감	https://jumpit.saramin.co.kr/position/49851	backend	f
1044	React 프론트엔드 개발자 (5년 이상)	아이헤이트플라잉버그스	서울 영등포구	경력 5~10년	["TypeScript", "GraphQL", "React", "Apollo"]	모집마감	https://jumpit.saramin.co.kr/position/50306	frontend	f
2075	DevOps 엔지니어 (11년 ~ 15년)	데이터메이커	대전 유성구	경력 11~15년	["Terraform", "Pulumi", "GoLand", "Argo"]	모집마감	https://jumpit.saramin.co.kr/position/49958	backend	f
2076	ML Engineer (8년 ~ 12년)	데이터메이커	대전 유성구	경력 8~12년	["Git", "Ubuntu", "NLP", "Kubeflow"]	모집마감	https://jumpit.saramin.co.kr/position/49955	data	f
2078	서버 및 인프라 개발자 (16년 ~ 20년)	데이터메이커	대전 유성구	경력 16~20년	["Terraform", "Pulumi", "Golang", "Argo"]	모집마감	https://jumpit.saramin.co.kr/position/49965	backend	f
2079	백엔드 개발자 (16년 ~ 20년)	데이터메이커	대전 유성구	경력 16~20년	["Django", "Django REST framework"]	모집마감	https://jumpit.saramin.co.kr/position/49962	backend	f
2080	프론트엔드 개발자 (11년 ~ 15년)	데이터메이커	대전 유성구	경력 11~15년	["JavaScript", "ES6", "Rust", "three.js"]	모집마감	https://jumpit.saramin.co.kr/position/49970	frontend	f
2081	프론트엔드 개발자 (16년 ~ 20년)	데이터메이커	대전 유성구	경력 16~20년	["JavaScript", "ES6", "Rust", "three.js"]	모집마감	https://jumpit.saramin.co.kr/position/49971	frontend	f
2082	ML Engineer (13년 이상)	데이터메이커	대전 유성구	경력 13~15년	["Git", "Ubuntu", "NLP", "Kubeflow"]	모집마감	https://jumpit.saramin.co.kr/position/49956	data	f
1045	프로젝트 매니저 (3년 이상)	아이헤이트플라잉버그스	서울 영등포구	경력 3~10년	["Jira", "Notion", "Slack", "Figma", "DataGrip"]	모집마감	https://jumpit.saramin.co.kr/position/50307	data	f
1050	Data Scientist in Financial (1~3년)	페니로이스	서울 종로구	경력 1~3년	["Python", "R", "BigData", "MachineLearning"]	모집마감	https://jumpit.saramin.co.kr/position/51111	data	f
1055	인프라 개발 경력직 채용	쥬비스다이어트	서울 강남구	경력 3~5년	["Java", "Spring Framework", "Spring Boot"]	모집마감	https://jumpit.saramin.co.kr/position/50783	backend	f
1056	서버/백엔드 개발자	룰루랩	서울 강남구	경력 5~15년	["Java", "Kotlin"]	모집마감	https://jumpit.saramin.co.kr/position/50198	backend	f
1058	프론트앤드 웹 개발자 채용	이폴리움	서울 서초구	경력 1~5년	["HTML5", "CSS 3", "Ajax", "MySQL", "SQL"]	모집마감	https://jumpit.saramin.co.kr/position/51069	data	f
1059	백엔드개발자(Node.js)	리비바이오	서울 강남구	경력 2~5년	["Git", "Node.js", "REST API", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/50607	backend	f
1060	프런트 개발 경력직 채용	인공지능팩토리	서울 중구	경력 1~5년	["HTML5", "CSS 3", "JavaScript", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/50979	frontend	f
1061	[삼보컴퓨터 계열사] 서버 운영 담당자	삼보컴퓨터	서울 강남구	경력 2~7년	["Windows", "Linux", "MSSQL", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/50458	backend	f
1062	[누구(nugu)] BE엔지니어	메디쿼터스	서울 강남구	경력 3~7년	["Go", "gRPC", "Kafka", "RDB", "NoSql", "MSA"]	모집마감	https://jumpit.saramin.co.kr/position/50944	backend	f
1063	[백엔드] 웹 백엔드 개발자	오앤	서울 강서구	경력 3~5년	["Spring Boot", "AWS", "Amazon EC2", "Redis"]	모집마감	https://jumpit.saramin.co.kr/position/50354	backend	f
1064	프론트엔드 개발자	리비바이오	서울 강남구	경력 2~7년	["NestJS", "React", "Zustand", "Recoil"]	모집마감	https://jumpit.saramin.co.kr/position/50608	backend	f
1065	백엔드 개발자 경력 채용	위볼린	서울 성동구	경력 3~7년	["TypeScript", "NestJS", "PostgreSQL"]	모집마감	https://jumpit.saramin.co.kr/position/51052	backend	f
1067	[RE : IW] AI 엔지니어	보이저	서울 구로구	신입~20년	["AI/인공지능", "C", "C++", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50658	data	f
1069	JAVA개발(8년~10년)	위즈코리아	서울 강서구	경력 8~10년	["Java", "NoSql", "Apache Tomcat", "BigData"]	모집마감	https://jumpit.saramin.co.kr/position/50831	data	f
2083	웹 그래픽(F/E) 개발자 (16년 ~ 20년)	데이터메이커	대전 유성구	경력 16~20년	["JavaScript", "Babel", "React", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/49968	frontend	f
2084	백엔드 개발자 (11년 ~ 15년)	데이터메이커	대전 유성구	경력 11~15년	["Django", "Django REST framework"]	모집마감	https://jumpit.saramin.co.kr/position/49961	backend	f
2545	ABAP 개발	웅진	서울 중구	경력 3~20년	["SAP", "· ABAP", "· SQL"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51890	other	t
2085	ML Engineer (3년 ~ 7년)	데이터메이커	대전 유성구	경력 3~7년	["Git", "Ubuntu", "NLP", "Kubeflow"]	모집마감	https://jumpit.saramin.co.kr/position/49954	data	f
2086	웹 그래픽(F/E) 개발자 (5년 ~ 10년)	데이터메이커	대전 유성구	경력 5~10년	["JavaScript", "Babel", "React", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/49966	frontend	f
2087	웹 그래픽(F/E) 개발자 (11년 ~ 15년)	데이터메이커	대전 유성구	경력 11~15년	["JavaScript", "Babel", "React", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/49967	frontend	f
1070	쇼핑몰/헬스케어 서비스 개발자	보미오라한의원	서울 강남구	경력 3~10년	["CSS 3", "HTML5", "JavaScript", "Node.js"]	모집마감	https://jumpit.saramin.co.kr/position/50847	backend	f
1071	[병역특례]백엔드 산업기능요원 모집	리비바이오	서울 강남구	신입~2년	["Git", "REST API", "Node.js", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/50609	backend	f
1074	Sr. Backend Engineer	에이아이트릭스	서울 강남구	경력 5~10년	["MongoDB", "Golang", "MySQL", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50127	backend	f
1078	파이썬 백엔드 리드	샐러드랩	서울 강남구	경력 5~12년	["Python", "Django", "FastAPI", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/50777	backend	f
1079	시니어 백엔드 개발자(8년 이상)	씨드앤	서울 송파구	경력 8~10년	["Java", "JavaScript", "Kafka", "AWS", "AZURE"]	모집마감	https://jumpit.saramin.co.kr/position/51273	backend	f
1081	백엔드 개발자 (5년 이상)	씨드앤	서울 송파구	경력 5~8년	["Java", "JavaScript", "Kafka", "AWS", "AZURE"]	모집마감	https://jumpit.saramin.co.kr/position/51272	backend	f
1082	[병역특례]프론트엔드 산업기능요원	리비바이오	서울 강남구	신입~2년	["JavaScript", "React", "Node.js", "jQuery"]	모집마감	https://jumpit.saramin.co.kr/position/50610	backend	f
1084	AI 기반 영상처리 개발자 (전문연구요원 가능)	이노뎁	서울 금천구	신입~10년	["Kafka", "MQTT", "PyTorch", "TensorFlow"]	모집마감	https://jumpit.saramin.co.kr/position/50157	data	f
1088	[의료R&D본부] 뇌영상연구팀 AI연구원	딥노이드	서울 구로구	경력 3~5년	["Python", "PyTorch", "TensorFlow"]	모집마감	https://jumpit.saramin.co.kr/position/50134	data	f
1089	서버 개발자	마이베네핏	서울 서초구	경력 2~8년	["REST API", "MySQL", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/49855	backend	f
1090	웹 기반 영상분석 시스템 개발자 (전문연구요원 가능)	이노뎁	서울 금천구	신입~10년	["React", "Golang", "WebRTC", "Kafka"]	모집마감	https://jumpit.saramin.co.kr/position/50150	backend	f
1091	데이터분석가 신입/경력 채용	퍼플아카데미	서울 양천구	신입~3년	["Python", "MachineLearning"]	모집마감	https://jumpit.saramin.co.kr/position/51006	data	f
1092	Frontend 개발자	스마트푸드네트웍스	서울 강남구	경력 4~15년	["Next.js", "React Query", "Jotai"]	모집마감	https://jumpit.saramin.co.kr/position/51030	frontend	f
1094	프론트엔드 및 앱 개발자 채용 (iOS)	아타드	서울 송파구, 부산 남구, 경기 성남시	경력 1~3년	["Objective-C", "Swift", "Java", "React"]	모집마감	https://jumpit.saramin.co.kr/position/42829	frontend	f
1097	딥러닝 추론 최적화 개발자	뷰런테크놀로지	서울 서초구	신입~10년	["C", "C++", "Python", "PyTorch", "TensorFlow"]	모집마감	https://jumpit.saramin.co.kr/position/51451	data	f
1102	IOS 개발 엔지니어 구인	고스트패스	서울 영등포구	경력 3~5년	["iOS", "SwiftUI", "Swift", "Git", "MVVM"]	모집마감	https://jumpit.saramin.co.kr/position/49778	mobile	f
1103	이커머스 플랫폼 개발자 (경력직)	플래티어	서울 송파구	경력 2~10년	["Java", "JavaScript", "JSP", "Oracle", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/49915	frontend	f
1104	블록체인 인프라 개발자	아타드	서울 송파구, 부산 남구, 경기 성남시	경력 1~5년	["Golang", "Solidity", "Hyperledger Indy"]	모집마감	https://jumpit.saramin.co.kr/position/50263	backend	f
1105	AI Agent 개발자	포지큐브	서울 강남구	경력 1~8년	["Python", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/50544	frontend	f
1111	Frontend Developer(프론트엔드 개발자)	뷰런테크놀로지	서울 서초구	경력 5~10년	["JavaScript", "TypeScript", "Vue.js"]	모집마감	https://jumpit.saramin.co.kr/position/51456	frontend	f
1113	생성형 AI B2B 서비스 프론트엔드 개발자 충원	필라넷	서울 강남구	경력 3~5년	["TypeScript", "React"]	모집마감	https://jumpit.saramin.co.kr/position/51517	frontend	f
1116	5G/LTE/IoT 단말검증 및 기술지원 신입	스톤위즈	서울 영등포구	신입	["AI/인공지능", "BigData", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/51144	data	f
1118	Mobile App Engineer_React Native	브레이브모바일	서울 강남구	경력 1~3년	["React", "React Native", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/51448	frontend	f
1119	5G/LTE/IoT 단말검증 및 기술지원 경력	스톤위즈	서울 영등포구	경력 3~10년	["AI/인공지능", "BigData", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/51145	data	f
1120	[DX사업본부] DevOps Engineer	딥노이드	서울 구로구	경력 3~10년	["Java", "Kotlin", "Spring Boot", "Kafka"]	모집마감	https://jumpit.saramin.co.kr/position/50131	backend	f
1124	백엔드 개발자 총괄 채용	아이스크림아트	서울 강남구	경력 10~15년	["Node.js", "React", "TypeScript", "NestJS"]	모집마감	https://jumpit.saramin.co.kr/position/51060	backend	f
1125	Backend Developer(백엔드 개발자)	뷰런테크놀로지	서울 서초구	경력 5~10년	["Golang", "Linux"]	모집마감	https://jumpit.saramin.co.kr/position/51457	backend	f
1139	웹디자이너 / 퍼블리셔 / React 개발자 모집	한국비즈넷	서울 구로구	경력 1~5년	["Adobe Photoshop", "HTML5", "CSS 3"]	모집마감	https://jumpit.saramin.co.kr/position/50770	frontend	f
1140	백엔드(Node.js) 개발자	클라썸	서울 강남구	경력 2~8년	["AWS", "GCP", "Node.js", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/51212	backend	f
1142	클라우드 인프라 엔지니어	아타드	서울 송파구, 부산 남구, 경기 성남시	경력 1~5년	["IBM Containers", "Node.js", "Network"]	모집마감	https://jumpit.saramin.co.kr/position/32125	backend	f
1143	[그루비 SaaS 솔루션] AI 엔지니어	플래티어	서울 송파구	경력 3~7년	["Python", "R", "TensorFlow", "PyTorch", "NLP"]	모집마감	https://jumpit.saramin.co.kr/position/50183	data	f
1144	프론트엔드 개발자 (*CGM의료기기)	아이센스(caresens)	서울 서초구	경력 10~15년	["React", "Vue.js", "HTML5", "CSS 3"]	모집마감	https://jumpit.saramin.co.kr/position/50911	frontend	f
1146	프론트엔드 엔지니어(경력 6~8년)	클래스101	서울 강남구	경력 6~8년	["React", "TypeScript", "GraphQL", "Apollo"]	모집마감	https://jumpit.saramin.co.kr/position/50399	frontend	f
1147	AI (LLM RAG) 개발자 / 9년↑	셀키	서울 서초구	경력 9~20년	["Python", "PyTorch", "Amazon SageMaker"]	모집마감	https://jumpit.saramin.co.kr/position/50435	data	f
1148	LLM 어플리케이션 엔지니어	넥스큐브코퍼레이션	서울 금천구	경력 3~5년	["Rest.li", "JavaScript", "Node.js"]	모집마감	https://jumpit.saramin.co.kr/position/50706	backend	f
1149	AI (LLM RAG) 개발자 / 6~8년	셀키	서울 서초구	경력 6~8년	["Python", "PyTorch", "Amazon SageMaker"]	모집마감	https://jumpit.saramin.co.kr/position/50434	data	f
1151	모바일파트- IOS 개발	비바이노베이션	서울 강남구	경력 5~15년	["Swift"]	모집마감	https://jumpit.saramin.co.kr/position/50974	mobile	f
1153	[개발] Backend Developer/5~7년	빌드코퍼레이션	서울 강남구	경력 5~7년	["Node.js", "Next.js", "GitHub Actions"]	모집마감	https://jumpit.saramin.co.kr/position/50308	backend	f
1154	서버 파트 부문(경력)	비바이노베이션	서울 강남구	경력 5~15년	["Python", "FastAPI", "Django", "Celery"]	모집마감	https://jumpit.saramin.co.kr/position/50973	backend	f
1155	Back-End 개발자 채용	브이씨	서울 강남구	경력 5~10년	["SQL", "Spring Data JPA"]	모집마감	https://jumpit.saramin.co.kr/position/51159	backend	f
1158	백엔드 개발자 (*CGM의료기기)	아이센스(caresens)	서울 서초구	경력 10~15년	["JavaScript", "Golang", "Linux", "Docker"]	모집마감	https://jumpit.saramin.co.kr/position/50913	backend	f
1494	iOS Developer	쏘카	서울 성동구	경력 3~8년	["Swift", "Objective-C", "iOS"]	모집마감	https://jumpit.saramin.co.kr/position/51139	mobile	f
2088	백엔드 개발자 (5년 ~ 10년)	데이터메이커	대전 유성구	경력 5~10년	["Django", "Django REST framework"]	모집마감	https://jumpit.saramin.co.kr/position/49960	backend	f
2089	Data 엔지니어 - Junior (대전 근무)	시스트란	대전 서구	신입	["Python", "TensorFlow", "PyTorch", "NLP"]	모집마감	https://jumpit.saramin.co.kr/position/50006	data	f
2092	이미지 생성AI 전문 AI/DL 엔지니어	커넥트브릭	대전 유성구	경력 2~15년	["Python", "DeepLearning", "AI/인공지능"]	모집마감	https://jumpit.saramin.co.kr/position/50926	data	f
2093	프론트엔드 개발자 (5년 ~ 10년)	데이터메이커	대전 유성구	경력 5~10년	["JavaScript", "ES6", "Rust", "three.js"]	모집마감	https://jumpit.saramin.co.kr/position/49969	frontend	f
1163	반도체 회로 설계 개발자 (신입)	블루닷	서울 강남구	신입~2년	["Git", "GitHub", "iOS", "Python", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/51054	mobile	f
1164	백엔드 개발 (경력 1~5년)	에이치비엠피	서울 구로구	경력 1~5년	["GitHub", "MySQL", "Node.js", "Amazon EC2"]	모집마감	https://jumpit.saramin.co.kr/position/50212	backend	f
1165	Backend Developer	쏘카	서울 성동구	경력 5~7년	["Java", "Kotlin", "Spring Boot", "OAuth2"]	모집마감	https://jumpit.saramin.co.kr/position/50621	backend	f
1166	생성형 AI 데이터사이언티스트	애자일소다	서울 강남구	신입~10년	["Python", "TensorFlow", "DeepLearning"]	모집마감	https://jumpit.saramin.co.kr/position/50560	data	f
1167	인공지능 AI 개발자	피피에스	서울 광진구	경력 1~20년	["REST API", "API Tracker", "Unity"]	모집마감	https://jumpit.saramin.co.kr/position/51196	data	f
1168	풀스택 소프트웨어 엔지니어(AI)	애자일소다	서울 강남구	경력 2~10년	["Python", "React", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/50571	frontend	f
1170	자율주행로봇 백엔드 엔지니어 (서울)	폴라리스쓰리디	서울 용산구	경력 5~8년	["Java", "Spring Boot", "REST API", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/50619	backend	f
1171	3D Vision Algorithm Engineer	아이브	서울 서초구	경력 2~7년	["Milanote", "OpenCV", "C++", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/49775	backend	f
1173	프론트엔드 개발자 시니어 채용 [본사]	잇올	서울 서초구	경력 7~10년	["Yarn", "React", "Next.js", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/50195	frontend	f
1174	Vision System SW Junior 개발자	아이브	서울 서초구	경력 1~5년	["SW", "C++", "C", "JavaScript", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50622	frontend	f
1177	전산팀 (서버/ERP/개발) 경력직 채용	신보	서울 마포구	경력 3~6년	["Java", "JavaScript", "Spring", "Mybatis"]	모집마감	https://jumpit.saramin.co.kr/position/51399	backend	f
1178	프론트엔드 개발자 주니어 채용 [본사]	잇올	서울 서초구	경력 3~6년	["Yarn", "React", "Next.js", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/50194	frontend	f
1195	풀스택 앱 개발 (경력 5~8년)	에이치비엠피	서울 구로구	경력 5~8년	["Angular 2", "Node.js", "React", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/50210	backend	f
1197	Vision AI 제품 코어 개발 엔지니어	씨이랩	서울 강남구	경력 3~10년	["AI/인공지능", "PyTorch", "MachineLearning"]	모집마감	https://jumpit.saramin.co.kr/position/51005	data	f
1200	On-Device AI Engineer (C++)	옵트에이아이	서울 강서구	신입~10년	["MachineLearning", "DeepLearning", "FPGA"]	모집마감	https://jumpit.saramin.co.kr/position/50139	data	f
1201	반도체 회로 설계 개발자 (경력)	블루닷	서울 강남구	경력 3~12년	["Git", "GitHub", "iOS", "Python", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/51053	mobile	f
1202	병원정보시스템 S/W 경력 개발자	이지케어텍(edge&next)	서울 중구	경력 2~18년	["C#", "WPF", ".NET", "Oracle", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/50470	frontend	f
1203	데이터 엔지니어	메이븐클라우드서비스	서울 강남구	경력 5~20년	["AZURE", "Django", "Flask", "React", "CSS 3"]	모집마감	https://jumpit.saramin.co.kr/position/51020	backend	f
1204	하이브리드 앱 개발자	케이웨더	서울 구로구	경력 3~10년	["React Native"]	모집마감	https://jumpit.saramin.co.kr/position/50316	frontend	f
1205	[펀픽] 플러터(Flutter) 개발자 채용	아이디자인랩	서울 마포구	경력 3~10년	["Flutter", "MariaDB", "MySQL", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50035	mobile	f
1206	백엔드 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~6년	["PostgreSQL", "Kafka", "Spring Boot", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/50445	backend	f
1209	웹서버 개발자 신입 채용	에프엘이에스	서울 강서구	신입	["C++", "Java", "React", "Spring"]	모집마감	https://jumpit.saramin.co.kr/position/50721	backend	f
1210	프론트엔드 개발자 (Next JS)_서울	뉴아이	서울 서초구	경력 3~15년	["HTML5", "CSS 3", "Java", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/51295	frontend	f
1211	JAVA 풀스택 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["Java", "JavaScript", "Spring", "Mybatis", "DB"]	모집마감	https://jumpit.saramin.co.kr/position/49432	backend	f
1212	리엑트네이티브 채용	미스고	서울 강남구	신입~10년	["Java", "React Native", "React D3 Library"]	모집마감	https://jumpit.saramin.co.kr/position/50337	frontend	f
1214	백엔드 개발자 신입 채용	에프엘이에스	서울 강서구	신입	["PostgreSQL", "Kafka", "Spring Boot", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/49880	backend	f
2617	전자제어 H/W [경력15~20년]	태하	경기 남양주시	경력 15~20년	["HW", "· MCU", "· PCB"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52349	other	t
1215	Vue.js 프론트엔드 개발자	더스포츠커뮤니케이션	서울 강서구	경력 3~5년	["Vue.js"]	모집마감	https://jumpit.saramin.co.kr/position/51331	frontend	f
1216	서버/백엔드 (3년이상)	매쓰마스터	서울 강서구	경력 3~5년	["Java", "Spring Boot", "Git", "MySQL", "Redis"]	모집마감	https://jumpit.saramin.co.kr/position/51155	backend	f
1217	flutter 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["Flutter", "Linux", "Git", "Node.js"]	모집마감	https://jumpit.saramin.co.kr/position/49877	backend	f
1219	서비스 운영 (*CGM의료기기)	아이센스(caresens)	서울 서초구	경력 10~15년	["Infra", "Golang", "Python", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/50914	backend	f
1220	Python 응용 소프트웨어 운용	엠코프	서울 강동구	신입~10년	["C++", "Lua", "BigData", "C#"]	모집마감	https://jumpit.saramin.co.kr/position/51252	data	f
1221	풀스택 개발자 채용	부동산플래닛	서울 강남구	경력 7~9년	["Java", "Spring Boot", "PostgreSQL", "Redis"]	모집마감	https://jumpit.saramin.co.kr/position/49948	backend	f
1222	IOS 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["iOS", "Swift", "Objective-C"]	모집마감	https://jumpit.saramin.co.kr/position/49872	mobile	f
1224	flutter 개발자 신입 채용	에프엘이에스	서울 강서구	신입	["Flutter", "Linux", "Git", "Node.js"]	모집마감	https://jumpit.saramin.co.kr/position/50584	backend	f
1225	웹퍼블리셔 신입 채용	에프엘이에스	서울 강서구	신입	["Zeplin", "Vue.js", "JavaScript", "jQuery"]	모집마감	https://jumpit.saramin.co.kr/position/49875	frontend	f
1226	[펀픽] AI 기반 백엔드 개발자 채용	아이디자인랩	서울 마포구	경력 3~10년	["Python", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/50034	backend	f
1227	웹 개발자 신입 채용	에프엘이에스	서울 강서구	신입	["MySQL", "PHP", "React", "Node.js", "Laravel"]	모집마감	https://jumpit.saramin.co.kr/position/49874	backend	f
1256	시니어 백엔드 경력직 (6년 이상)	이노소니언	서울 서초구	경력 6~20년	["Python", "Django", "MySQL", "PostgreSQL"]	모집마감	https://jumpit.saramin.co.kr/position/51334	backend	f
1257	웹 개발자	에프엘이에스	서울 강서구	경력 2~6년	["MySQL", "PHP", "React", "Node.js", "Laravel"]	모집마감	https://jumpit.saramin.co.kr/position/50047	backend	f
1258	PHP 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~6년	["PHP", "JavaScript", "Node.js"]	모집마감	https://jumpit.saramin.co.kr/position/50443	backend	f
1261	인프라 엔지니어 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["Docker", "TypeScript", "AWS", "AZURE"]	모집마감	https://jumpit.saramin.co.kr/position/50724	frontend	f
1262	LLM Researcher (병역특례)	애자일소다	서울 강남구	신입~5년	["Python", "TensorFlow", "PyTorch"]	모집마감	https://jumpit.saramin.co.kr/position/49817	data	f
1266	Data Scientist in Financial (4~6년)	페니로이스	서울 종로구	경력 4~6년	["Python", "R", "BigData", "MachineLearning"]	모집마감	https://jumpit.saramin.co.kr/position/51112	data	f
1268	프론트엔드 개발자_5년 이상	펫박스	서울 마포구	경력 5~7년	["React", "REST API", "HTML5"]	모집마감	https://jumpit.saramin.co.kr/position/50539	frontend	f
1269	Product Engineer	코드스테이츠	서울 성동구	경력 2~5년	["React", "Next.js", "TypeScript", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/50538	frontend	f
1271	Java Backend 서비스 개발자 모집	트럼피아	서울 강남구	경력 7~15년	["Elasticsearch", "MariaDB", "Docker"]	모집마감	https://jumpit.saramin.co.kr/position/50782	backend	f
1272	웹 백엔드 개발자 (3년 이상)	뉴스젤리	서울 성동구	경력 3~6년	["Python", "Java", "Django", "FastAPI", "Flask"]	모집마감	https://jumpit.saramin.co.kr/position/50841	backend	f
1273	프론트엔드 주니어 개발자 (2~4년차)	팬딩	서울 강남구	경력 2~4년	["Vue.js"]	모집마감	https://jumpit.saramin.co.kr/position/51234	frontend	f
1274	프론트엔드 개발자 (경력 5~10년)	브레인즈컴퍼니	서울 성동구	경력 5~10년	["Java", "Spring Framework", "React", "SQL"]	모집마감	https://jumpit.saramin.co.kr/position/50334	backend	f
1276	Software Engineer (Front-End)	부스터스	서울 강남구	경력 2~5년	["Vue.js", "jQuery", "TailwindCSS", "Bootstrap"]	모집마감	https://jumpit.saramin.co.kr/position/51192	frontend	f
1279	웹 프론트엔드 개발자 (3년 이상)	뉴스젤리	서울 성동구	경력 3~6년	["React", "Next.js", "Vue.js", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/50836	frontend	f
1280	MVL [TADA] Backend Engineer 채용	이지식스(엠블)	서울 강남구	경력 3~10년	["TypeScript", "NestJS", "Node.js", "SQL"]	모집마감	https://jumpit.saramin.co.kr/position/51302	backend	f
2098	AI/ML 엔지니어 경력 채용	액스비스	대전 유성구	경력 3~15년	["Python", "JavaScript", "Django"]	모집마감	https://jumpit.saramin.co.kr/position/50808	backend	f
2120	DevOps 엔지니어 (16년 ~ 20년)	데이터메이커	대전 유성구	경력 16~20년	["Terraform", "Pulumi", "GoLand", "Argo"]	모집마감	https://jumpit.saramin.co.kr/position/49959	backend	f
2122	C/C++ 이동통신 코어 백엔드 개발자	두두원	대전 유성구	경력 3~8년	["C", "C++", "Network", "Linux", "Ubuntu"]	모집마감	https://jumpit.saramin.co.kr/position/50509	backend	f
2124	서버 및 인프라 개발자 (11년 ~ 15년)	데이터메이커	대전 유성구	경력 11~15년	["Terraform", "Pulumi", "Golang", "Argo"]	모집마감	https://jumpit.saramin.co.kr/position/49964	backend	f
1281	iOS APP 개발자 채용	아이파킹	서울 금천구	경력 2~5년	["iOS", "Swift", "Flutter", "Objective-C", "Kotlin"]	모집마감	https://jumpit.saramin.co.kr/position/49997	mobile	f
1282	연구소 풀스텍 개발(java)	프라이빗테크놀로지	서울 마포구	경력 4~10년	["Java", "MySQL", "Spring", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/50632	backend	f
1283	백엔드 개발자	아이트럭	서울 서초구	경력 3~10년	["Node.js", "TypeScript", "MySQL", "Ubuntu"]	모집마감	https://jumpit.saramin.co.kr/position/50987	backend	f
1287	Software Engineer (Back-End)	부스터스	서울 강남구	경력 2~5년	["SW", "ScrapingBot", "Linux", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/51193	backend	f
1288	React Native 주니어 개발자 (2~4년차)	팬딩	서울 강남구	경력 2~4년	["React"]	모집마감	https://jumpit.saramin.co.kr/position/51232	frontend	f
1289	백앤드 개발(2-10년)	더블유닷에이아이	서울 서초구	경력 2~10년	["MySQL", "Spring Boot", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/51419	backend	f
1290	Python 백엔드 개발자	펫박스	서울 마포구	경력 3~5년	["MySQL", "PHP", "Python", "Selenium"]	모집마감	https://jumpit.saramin.co.kr/position/50541	backend	f
1291	웹 개발자 책임급	뉴스젤리	서울 성동구	경력 6~10년	["React", "Next.js", "Vue.js", "Python", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/50838	frontend	f
1293	[이즈파크] PLM 개발자	이즈파크	서울 금천구	경력 3~15년	["Java", "JavaScript", "JSP"]	모집마감	https://jumpit.saramin.co.kr/position/20878	frontend	f
1294	SW개발_Platform파트 선임~책임급 채용	알피니언메디칼시스템	서울 강서구	경력 2~15년	["Visual C++", "C", "C++", "WPF", "JavaScript"]	모집마감	https://jumpit.saramin.co.kr/position/50053	frontend	f
1295	프론트엔드 리드 개발자 (5~10년차)	팬딩	서울 강남구	경력 5~10년	["Vue.js"]	모집마감	https://jumpit.saramin.co.kr/position/51233	frontend	f
1302	백엔드개발자 시니어채용(8~10년)	비큐에이아이	서울 중구	경력 8~10년	["Spring Boot", "Flask", "FastAPI"]	모집마감	https://jumpit.saramin.co.kr/position/51418	backend	f
1303	Java 개발자 책임급	아주큐엠에스	서울 서초구	경력 8~12년	["Java", "JavaScript", "jQuery", "Oracle"]	모집마감	https://jumpit.saramin.co.kr/position/48618	frontend	f
1304	JAVA개발(5년~7년)	위즈코리아	서울 강서구	경력 5~7년	["Java", "NoSql", "Apache Tomcat", "BigData"]	모집마감	https://jumpit.saramin.co.kr/position/50830	data	f
1305	백엔드개발자 시니어채용(11~13년)	비큐에이아이	서울 중구	경력 11~13년	["Spring Boot", "Flask", "FastAPI"]	모집마감	https://jumpit.saramin.co.kr/position/51417	backend	f
1307	백엔드 개발자 채용	서울거래	서울 영등포구	경력 3~99년	["Python", "Django", "Git", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/51536	backend	f
2132	[경력] 백엔드 개발자 (울산, 3년↑)	엔엑스	울산 울주군	경력 3~6년	["Node.js", "MongoDB", "AWS", "Docker"]	모집마감	https://jumpit.saramin.co.kr/position/51391	backend	f
2135	[경력] 백엔드 개발자 (울산, 7년↑)	엔엑스	울산 울주군	경력 7~10년	["Node.js", "MongoDB", "AWS", "Docker"]	모집마감	https://jumpit.saramin.co.kr/position/51620	backend	f
1308	서비스개발 총괄매니저 채용	서울거래	서울 영등포구	경력 7~99년	["Python", "Flutter"]	모집마감	https://jumpit.saramin.co.kr/position/51533	mobile	f
1310	서버 프로그래머 팀장급 채용	보이저	서울 구로구	경력 8~20년	["MySQL", "AZURE", "SQL", "C#", "C++", "Unity"]	모집마감	https://jumpit.saramin.co.kr/position/50659	backend	f
1315	프론트엔드 개발자 경력 (5년 이상)	디윅스	서울 강남구	경력 5~20년	["JavaScript", "TypeScript", "React", "HTML5"]	모집마감	https://jumpit.saramin.co.kr/position/51327	frontend	f
1317	플랫폼 서비스 개발자 채용	유니버스에이아이	서울 영등포구	경력 2~10년	["Node.js", "Python", "PostgreSQL", "Infra"]	모집마감	https://jumpit.saramin.co.kr/position/51538	backend	f
1319	백엔드 리드 개발자 (5~10년차)	팬딩	서울 강남구	경력 5~10년	["REST API"]	모집마감	https://jumpit.saramin.co.kr/position/51236	backend	f
1321	[신입] Flutter 앱 & Node.js 개발자	인졀미	서울 서초구	신입~4년	["TypeScript", "Node.js", "PostgreSQL"]	모집마감	https://jumpit.saramin.co.kr/position/51472	backend	f
1323	프론트엔드 개발자_8년 이상	펫박스	서울 마포구	경력 8~10년	["React", "REST API", "HTML5"]	모집마감	https://jumpit.saramin.co.kr/position/50540	frontend	f
1325	개발팀장	아이트럭	서울 서초구	경력 7~25년	["MachineLearning", "AI/인공지능"]	모집마감	https://jumpit.saramin.co.kr/position/50986	data	f
1327	이커머스 풀스템 팀장 앱웹	펫박스	서울 마포구	경력 8~15년	["React Native", "Next.js", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/50543	frontend	f
1328	시니어 프론트엔드 개발자	아이트럭	서울 서초구	경력 5~10년	["JavaScript", "Kotlin", "Node.js", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/50984	backend	f
1332	AI 엔지니어	럭스로보	서울 서초구	경력 5~15년	["MachineLearning", "DeepLearning"]	모집마감	https://jumpit.saramin.co.kr/position/51525	data	f
1333	JavaScript 프론드엔드 개발자 채용	서울거래	서울 영등포구	경력 3~99년	["Java", "HTML5", "CSS 3", "jQuery", "Django"]	모집마감	https://jumpit.saramin.co.kr/position/51532	backend	f
1339	Python 백엔드 개발자_6년~8년	펫박스	서울 마포구	경력 6~8년	["MySQL", "PHP", "Python", "Selenium"]	모집마감	https://jumpit.saramin.co.kr/position/50542	backend	f
1343	백엔드 개발자 경력 (5년이상)	디윅스	서울 강남구	경력 5~20년	["Spring Framework", "AI/인공지능"]	모집마감	https://jumpit.saramin.co.kr/position/51328	backend	f
1358	Data Scientist in Financial (7~10년)	페니로이스	서울 종로구	경력 7~10년	["Python", "R", "BigData", "MachineLearning"]	모집마감	https://jumpit.saramin.co.kr/position/51113	data	f
1359	백엔드 및 서버 개발자 채용	스쿨버스	서울 강서구	경력 1~9년	["java", "Node.js", "JavaScript", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/50033	backend	f
1360	Backend팀 개발자 채용	인피닉	서울 금천구	경력 3~10년	["Java", "Docker", "SW", "DB"]	모집마감	https://jumpit.saramin.co.kr/position/50467	backend	f
1361	[다나와개발본부] Backend Engineer	커넥트웨이브	서울 금천구	신입~10년	["Python", "Django", "Flask", "FastAPI", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/50854	backend	f
1362	백엔드 시니어 개발자	딜리버리랩	서울 성동구	경력 5~15년	["MySQL", "AWS", "Spring Boot"]	모집마감	https://jumpit.saramin.co.kr/position/51168	backend	f
1363	서버개발자 채용	로지소프트	서울 강남구	경력 7~15년	["AZURE", "C#", "C++", "NoSql", "Node.js"]	모집마감	https://jumpit.saramin.co.kr/position/49677	backend	f
1364	알약 xLLM 제품 개발 (경력)	이스트시큐리티	서울 서초구	경력 3~6년	["Go", "Java", "Python", "REST API", "SQL"]	모집마감	https://jumpit.saramin.co.kr/position/50011	backend	f
1366	FrontEnd팀 개발자 채용	인피닉	서울 금천구	신입	["Java", "JavaScript", "Docker", "SW", "React"]	모집마감	https://jumpit.saramin.co.kr/position/50466	frontend	f
1367	데이터 분석가(Data Analyst)	더스윙	서울 용산구	경력 1~3년	["REST API", "Python", "SQL", "Hadoop"]	모집마감	https://jumpit.saramin.co.kr/position/51187	data	f
1369	보안솔루션(MDM) 개발자(선임급 이상)	비욘드테크	서울 금천구	경력 4~10년	["JSP", "Java", "C#", "SW", "Spring Boot"]	모집마감	https://jumpit.saramin.co.kr/position/49790	backend	f
1370	[의료R&D본부] 프론트엔드 개발 PL	딥노이드	서울 구로구	경력 5~10년	["React", "REST API", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/50136	frontend	f
1372	금융/NL2SQL 데이터 사이언티스트	다큐브	서울 영등포구	신입~10년	["PyTorch", "Transformers", "TensorFlow"]	모집마감	https://jumpit.saramin.co.kr/position/51114	data	f
1374	풀스택 개발자	에브리심	서울 성북구, 대전 유성구	경력 3~10년	["React", "TypeScript", "Node.js", "Git", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/51469	backend	f
1375	[AI] Data Scientist(AI Engineer, 8년이상, 리더급)	혜움	서울 강남구	경력 8~20년	["Python", "Django", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/50227	backend	f
1377	python 에이전트 개발자	다큐브	서울 영등포구	경력 1~10년	["Python", "FastAPI"]	모집마감	https://jumpit.saramin.co.kr/position/51115	backend	f
1348	C/C++개발(7년~10년)	위즈코리아	서울 강서구	경력 7~10년	["Linux", "C", "C++", "C#", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/51117	other	f
1382	[다나와개발본부] Search Engineer	커넥트웨이브	서울 금천구	경력 5~10년	["Python", "Django", "Flask", "FastAPI", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/50855	backend	f
1384	[보안AI사업본부] 백엔드 개발자_경력	딥노이드	서울 구로구	경력 8~10년	["Python", "Kotlin", "RDB", "NoSql", "Docker"]	모집마감	https://jumpit.saramin.co.kr/position/50133	backend	f
1385	CTO	딜리버리랩	서울 성동구	경력 10~30년	["AWS", "NestJS", "Node.js", "React"]	모집마감	https://jumpit.saramin.co.kr/position/51170	backend	f
1387	[Infra Div.] Publishing Tech PM	크래프톤	서울 강남구	경력 3~10년	["Python", "PowerShell", "Go", "C#"]	모집마감	https://jumpit.saramin.co.kr/position/49888	backend	f
1388	front End 개발자(threejs)	씨메스	서울 강남구	경력 3~10년	["TypeScript", "three.js", "Next.js", "React"]	모집마감	https://jumpit.saramin.co.kr/position/51492	frontend	f
1391	Agent AI 연구 개발자 채용	인피닉	서울 금천구	경력 3~10년	["Python", "SQL", "TensorFlow", "PyTorch"]	모집마감	https://jumpit.saramin.co.kr/position/50464	data	f
1392	알약 PC/Mobile 제품기획자	이스트시큐리티	서울 서초구	경력 5~15년	["GitLab", "Figma", "Google Analytics"]	모집마감	https://jumpit.saramin.co.kr/position/50850	backend	f
1393	다국어번역/UI (Product Owner)	아이센스(caresens)	서울 서초구	경력 2~7년	["GUI", "Lokalise", "Crowdin", "iOS"]	모집마감	https://jumpit.saramin.co.kr/position/50916	mobile	f
1394	AI 로보틱스 SW 품질 QA 담당자	씨메스	서울 강남구	경력 4~20년	["Qt", "QA", "SW", "GitHub", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/51491	data	f
1398	backend (python) 개발자	씨메스	서울 강남구	경력 3~5년	["Python", "JavaScript", "MariaDB", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/51490	backend	f
1399	Java 백엔드 개발자(8~10년)	아파트아이	서울 금천구	경력 8~10년	["Spring", "JavaScript", "jQuery", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/51582	backend	f
1422	Registration 연구 개발	스키아	서울 구로구	경력 3~10년	["C++", "Python", "Swift"]	모집마감	https://jumpit.saramin.co.kr/position/51019	mobile	f
1424	[Network-on-Chip] Software Engineer	오픈엣지테크놀로지	서울 강남구	경력 10~15년	["C", "C++", "Python", "JavaScript", "ES6"]	모집마감	https://jumpit.saramin.co.kr/position/50495	frontend	f
1426	React Native 리드 개발자 (5~10년차)	팬딩	서울 강남구	경력 5~10년	["React"]	모집마감	https://jumpit.saramin.co.kr/position/51235	frontend	f
1432	머신러닝 개발자	아이트럭	서울 서초구	경력 5~10년	["scikit-learn", "BigData", "MachineLearning"]	모집마감	https://jumpit.saramin.co.kr/position/50985	data	f
1436	백엔드 개발자 (5~10년) [강남구]	모멘티	서울 강남구	경력 5~10년	["Python", "Django", "PHP", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/51131	backend	f
1437	플러터 개발자 (Flutter, 7~10년)	클레온	서울 중구	경력 7~10년	["Flutter", "Kotlin", "JavaScript", "Dart"]	모집마감	https://jumpit.saramin.co.kr/position/51316	frontend	f
1440	백엔드 개발자(6-10년)	와탭랩스	서울 서초구	경력 6~10년	["Netty", "Spring Framework"]	모집마감	https://jumpit.saramin.co.kr/position/51595	backend	f
1443	백엔드 개발자(2-5년)	와탭랩스	서울 서초구	경력 2~5년	["Netty", "Spring Framework"]	모집마감	https://jumpit.saramin.co.kr/position/51594	backend	f
1444	AI 기술 개발자	비바이노베이션	서울 강남구	경력 6~15년	["Python", "TensorFlow", "PyTorch"]	모집마감	https://jumpit.saramin.co.kr/position/51477	data	f
1435	DevOps / Infra Engineer	법틀	서울 성동구	경력 2~5년	["Docker"]	모집마감	https://jumpit.saramin.co.kr/position/51615	other	f
1452	[AI 기술팀] 언어 AI 최적화 경력사원 채용	롯데이노베이트	서울 금천구	경력 3~5년	["AI/인공지능", "PyTorch", "Keras"]	모집마감	https://jumpit.saramin.co.kr/position/51470	data	f
1488	3차원 머신비전 알고리즘 개발자(5~7)	클레	서울 성동구	경력 5~7년	["Python", "C", "C++", "PyTorch", "CUDA"]	모집마감	https://jumpit.saramin.co.kr/position/51067	data	f
1490	풀스택 앱 개발 (경력 13~15년)	에이치비엠피	서울 구로구	경력 13~15년	["Angular 2", "Node.js", "React", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/50209	backend	f
1493	실시간 영상 분석 엔지니어	씨이랩	서울 강남구	경력 3~10년	["CUDA", "Python", "Flask", "Docker"]	모집마감	https://jumpit.saramin.co.kr/position/50763	backend	f
1496	백엔드 개발 (경력 6~10년)	에이치비엠피	서울 구로구	경력 6~10년	["GitHub", "MySQL", "Node.js", "Amazon EC2"]	모집마감	https://jumpit.saramin.co.kr/position/50213	backend	f
1499	[5년 이상] 백엔드 개발자	오아시스비즈니스	서울 성동구	경력 5~10년	["Spring Boot", "NoSql", "Java", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/50936	backend	f
1501	C# 기반 통신 플랫폼 ,서버 어플리케이션	마린웍스	서울 종로구	경력 10~13년	["C#", "AI/인공지능", "RDB", "BigData", "TCP/IP"]	모집마감	https://jumpit.saramin.co.kr/position/51426	backend	f
1502	[AI 기술팀] NLP AI 경력사원 채용	롯데이노베이트	서울 금천구	경력 3~12년	["AI/인공지능", "PyTorch", "Keras"]	모집마감	https://jumpit.saramin.co.kr/position/51471	data	f
1506	Node.js 서버/백엔드 개발자(시니어)	더스포츠커뮤니케이션	서울 강서구	경력 5~8년	["Node.js"]	모집마감	https://jumpit.saramin.co.kr/position/51330	backend	f
1508	프론트엔드 개발자	아이피샵	서울 강남구	경력 2~4년	["JavaScript", "PHP"]	모집마감	https://jumpit.saramin.co.kr/position/50646	frontend	f
1511	웹 퍼블리셔 경력채용 (2~5년)	텐빌리언	서울 구로구	경력 2~5년	["JavaScript", "HTML5", "CSS 3", "jQuery"]	모집마감	https://jumpit.saramin.co.kr/position/50254	frontend	f
1512	백엔드 서버 개발자 [경력 7년 이상]	아이피샵	서울 강남구	경력 7~10년	["Java", "JSP", "SQL", "MySQL", "MariaDB"]	모집마감	https://jumpit.saramin.co.kr/position/50649	backend	f
1513	백엔드 개발자(전환형 인턴)	링글잉글리시에듀케이션서비스	서울 강남구	신입	["Ruby", "Python", "Java", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/51313	backend	f
1514	백엔드 경력 채용 (2~5년)	텐빌리언	서울 구로구	경력 2~5년	["Git", "Spring Boot", "DB"]	모집마감	https://jumpit.saramin.co.kr/position/50935	backend	f
2139	SW 개발 PM(Project Manager) 주임급	팜클	강원 횡성군	경력 2~4년	["Python", "AWS", "Git", "iOS", "Linux"]	모집마감	https://jumpit.saramin.co.kr/position/51413	mobile	f
2140	CTO 신규채용	비지트	강원 원주시	경력 4~10년	["OpenCV", "TensorFlow", "TensorFlow.js"]	모집마감	https://jumpit.saramin.co.kr/position/49814	data	f
2146	웹(Back-End) 개발자 채용 (근무지/전주)	아이엠아이	전북 전주시	경력 2~5년	["PHP", "MySQL", "REST API", "Git", "Jira"]	모집마감	https://jumpit.saramin.co.kr/position/49909	backend	f
2147	자율주행로봇 백엔드 엔지니어 (포항)	폴라리스쓰리디	경북 포항시	경력 5~8년	["Java", "Spring Boot", "REST API", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/51291	backend	f
2148	이리온 비전 기반 인지 모델 개발자	폴라리스쓰리디	경북 포항시	경력 2~3년	["DeepLearning", "PyTorch", "TensorFlow"]	모집마감	https://jumpit.saramin.co.kr/position/50662	data	f
2149	제조 자동화 로봇 DevOps 엔지니어	폴라리스쓰리디	경북 포항시	경력 3~8년	["Flutter"]	모집마감	https://jumpit.saramin.co.kr/position/50232	mobile	f
2151	풀스택 고급 개발자	미조리장갑	경북 칠곡군	경력 8~10년	["Linux", "React Router", "SW", "Embedded"]	모집마감	https://jumpit.saramin.co.kr/position/51003	frontend	f
1516	하루콩 Flutter 개발팀원	블루시그넘	서울 관악구	경력 2~8년	["Flutter"]	모집마감	https://jumpit.saramin.co.kr/position/51303	mobile	f
1519	백엔드 서버 개발자 [경력 3년 이상]	아이피샵	서울 강남구	경력 3~6년	["Java", "JSP", "SQL", "MySQL", "MariaDB"]	모집마감	https://jumpit.saramin.co.kr/position/50648	backend	f
1520	서버 개발팀원	블루시그넘	서울 관악구	경력 2~8년	["Django"]	모집마감	https://jumpit.saramin.co.kr/position/51304	backend	f
1522	프론트엔드개발자 모집(3년~5년)	위버스브레인	서울 구로구	경력 3~5년	["Flutter", "React", "REST API", "Git", "Redux"]	모집마감	https://jumpit.saramin.co.kr/position/50732	frontend	f
1531	서버 개발자 (공동 및 사설 CA/RA)	한국전자인증	서울 서초구	경력 4~7년	["Linux", "C++", "C", "Java", "AWS", "Oracle"]	모집마감	https://jumpit.saramin.co.kr/position/51578	backend	f
1533	프론트엔드 엔지니어(경력 9~11년)	클래스101	서울 강남구	경력 9~11년	["React", "TypeScript", "GraphQL", "Apollo"]	모집마감	https://jumpit.saramin.co.kr/position/50401	frontend	f
1536	프론트엔드 엔지니어(경력12년 이상)	클래스101	서울 강남구	경력 12~14년	["React", "TypeScript", "GraphQL", "Apollo"]	모집마감	https://jumpit.saramin.co.kr/position/50402	frontend	f
1542	서버/백엔드 (6년이상)	매쓰마스터	서울 강서구	경력 6~8년	["Java", "Spring Boot", "Git", "MySQL", "Redis"]	모집마감	https://jumpit.saramin.co.kr/position/51409	backend	f
1546	프론트엔드 개발 경력 (2~5년)	텐빌리언	서울 구로구	경력 2~5년	["JavaScript", "HTML5"]	모집마감	https://jumpit.saramin.co.kr/position/50932	frontend	f
1548	백엔드개발자 모집(11년~15년)	위버스브레인	서울 구로구	경력 11~15년	["PHP", "Git", "Python", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/50725	backend	f
1552	백엔드 Python 경력직 개발자 모집	아이디벨롭	서울 송파구	경력 3~10년	["Python", "Azure DevOps", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/51501	backend	f
1554	프론트엔드개발자 모집(11년~15년)	위버스브레인	서울 구로구	경력 11~15년	["Flutter", "React", "REST API", "Git", "Redux"]	모집마감	https://jumpit.saramin.co.kr/position/50730	frontend	f
1572	백엔드 경력 채용 (10년 이상)	텐빌리언	서울 구로구	경력 10~15년	["Git", "Spring Boot", "DB"]	모집마감	https://jumpit.saramin.co.kr/position/50933	backend	f
1576	백엔드개발자 모집(3년~5년)	위버스브레인	서울 구로구	경력 3~5년	["PHP", "Git", "Python", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/50727	backend	f
1579	데이터 사이언티스트 (Data Scientist) 채용	영원아웃도어	서울 중구, 경기 성남시	경력 5~10년	["Python", "MachineLearning", "SQL"]	모집마감	https://jumpit.saramin.co.kr/position/51385	data	f
1580	백엔드 경력 채용 (6~9년)	텐빌리언	서울 구로구	경력 6~9년	["Git", "Spring Boot", "DB"]	모집마감	https://jumpit.saramin.co.kr/position/50934	backend	f
1581	CRM/AI 고객 분석 담당 채용	영원아웃도어	서울 중구, 경기 성남시	경력 5~10년	["SQL", "Microsoft Excel", "Salesforce"]	모집마감	https://jumpit.saramin.co.kr/position/51381	data	f
1582	풀 스택 개발자(Python, React)[3~6년]	세라크래프트	서울 동대문구	경력 3~6년	["Redux", "React", "Python", "Django"]	모집마감	https://jumpit.saramin.co.kr/position/51437	backend	f
1584	풀스택 앱 개발 (경력 9~12년)	에이치비엠피	서울 구로구	경력 9~12년	["Angular 2", "Node.js", "React", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/50208	backend	f
1553	앱 개발자 경력 채용 (6~9년)	텐빌리언	서울 구로구	경력 6~9년	["Android", "REST API", "React", "iOS"]	모집마감	https://jumpit.saramin.co.kr/position/50252	frontend	f
1586	C# 기반 통신 플랫폼 ,서버 어플리케이션(15년이상)	마린웍스	서울 종로구	경력 15~20년	["C#", "AI/인공지능", "RDB", "BigData", "TCP/IP"]	모집마감	https://jumpit.saramin.co.kr/position/51427	backend	f
1589	풀스택 앱 개발 (경력 5~8년)	에이치비엠피	서울 구로구	경력 5~8년	["Angular 2", "Node.js", "React", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/50204	backend	f
1597	서버 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["GitHub", "GraphQL", "Docker", "AZURE"]	모집마감	https://jumpit.saramin.co.kr/position/51353	backend	f
2745	자율주행 하드웨어 전장 엔지니어	토르드라이브	서울 영등포구	경력 3~10년	["HW"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51980	other	t
1603	알고리즘 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["Slim", "Keras", "TensorFlow", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/51352	data	f
1604	Embedded Vision System	엠코프	서울 강동구	신입~22년	["C++", "Lua", "BigData", "C#"]	모집마감	https://jumpit.saramin.co.kr/position/51246	data	f
1624	Frontend Engineer	에스투더블유	경기 성남시	경력 2~6년	["React", "Zustand", "TypeScript", "SQL"]	모집마감	https://jumpit.saramin.co.kr/position/50981	frontend	f
1625	백엔드 개발자	포트로직스	경기 성남시	경력 5~10년	["GitHub", "Java", "AWS", "NGINX", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/49974	backend	f
1626	Frontend Software Engineer	뉴로퓨전	경기 용인시	경력 3~10년	["React", "Next.js", "HTML5", "CSS 3"]	모집마감	https://jumpit.saramin.co.kr/position/50190	frontend	f
1627	Backend Software Engineer	뉴로퓨전	경기 용인시	경력 3~10년	["TypeScript", "Python", "Java", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/50192	backend	f
1628	Data Engineer (포트 스캐너 개발)	에스투더블유	경기 성남시	경력 4~15년	["Git", "MongoDB", "Python", "Docker"]	모집마감	https://jumpit.saramin.co.kr/position/50638	backend	f
1631	Frontend Engineer 시니어(Product 3)	에스투더블유	경기 성남시	경력 3~7년	["TypeScript", "SCSS", "Angular 2", "RxJS"]	모집마감	https://jumpit.saramin.co.kr/position/50642	frontend	f
1639	Cloud 백엔드 개발자 (5년 이상)	이우소프트	경기 화성시	경력 5~10년	["TypeScript", "JavaScript", "Node.js"]	모집마감	https://jumpit.saramin.co.kr/position/50340	backend	f
1640	Front-end Platform Engineer (경력)	엔닷라이트	경기 성남시	경력 5~10년	["TypeScript", "JavaScript", "CSS 3", "Next.js"]	모집마감	https://jumpit.saramin.co.kr/position/51261	frontend	f
1641	Offensive Researcher (오펜시브 리서쳐)	에스투더블유	경기 성남시	신입	["Python", "Go", "Git", "Slack"]	모집마감	https://jumpit.saramin.co.kr/position/50561	backend	f
1642	환경 에너지 플랫폼 개발 PL	에이알티플러스	경기 이천시	경력 10~15년	["Java", "JavaScript", "DB", "SQL"]	모집마감	https://jumpit.saramin.co.kr/position/50682	frontend	f
1644	에듀테크(EduTech) 웹 서비스 풀스택 개발자	블루가	경기 성남시	경력 7~10년	["JavaScript", "TypeScript", "Node.js"]	모집마감	https://jumpit.saramin.co.kr/position/49820	backend	f
1645	[전문연구요원]AI연구엔지니어-LLM	업스테이지	경기 용인시	신입~20년	["AI/인공지능", "TensorFlow", "PyTorch", "NLP"]	모집마감	https://jumpit.saramin.co.kr/position/50522	data	f
1959	고급 백엔드 설계 개발자(13~15년)	티투엘	경기 고양시	경력 13~15년	["Java"]	모집마감	https://jumpit.saramin.co.kr/position/50172	backend	f
2152	풀스택 신입 개발자	미조리장갑	경북 칠곡군	신입	["Linux", "React Router", "SW", "Embedded"]	모집마감	https://jumpit.saramin.co.kr/position/51004	frontend	f
2153	S/W 신입 개발자	미조리장갑	경북 칠곡군	신입	["Linux", "React Router", "SW", "Embedded"]	모집마감	https://jumpit.saramin.co.kr/position/51231	frontend	f
2154	풀스택 중급 개발자	미조리장갑	경북 칠곡군	경력 5~7년	["Linux", "React Router", "SW", "Embedded"]	모집마감	https://jumpit.saramin.co.kr/position/51002	frontend	f
2155	S/W 중급 개발자	미조리장갑	경북 칠곡군	경력 5~7년	["Linux", "React Router", "SW", "Embedded"]	모집마감	https://jumpit.saramin.co.kr/position/51227	frontend	f
2156	S/W 고급 개발자	미조리장갑	경북 칠곡군	경력 8~10년	["Linux", "React Router", "SW", "Embedded"]	모집마감	https://jumpit.saramin.co.kr/position/51230	frontend	f
2157	풀스택 초급 개발자	미조리장갑	경북 칠곡군	경력 2~4년	["Linux", "React Router", "SW", "Embedded"]	모집마감	https://jumpit.saramin.co.kr/position/51001	frontend	f
2158	S/W 초급 개발자	미조리장갑	경북 칠곡군	경력 2~4년	["Linux", "React Router", "SW", "Embedded"]	모집마감	https://jumpit.saramin.co.kr/position/51226	frontend	f
2159	시스템운영/테스트및관리(신입)	씨맥스	경남 창원시	신입	["Oracle", "Python", "AI/인공지능"]	모집마감	https://jumpit.saramin.co.kr/position/51443	data	f
1646	Back-end 개발자 (시니어)	엔닷라이트	경기 성남시	경력 8~15년	["REST API", "AWS", "Node.js", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/50906	backend	f
1647	[긴급] 웹개발자 모집 (jsp,java)	상록아이엔씨	경기 부천시	신입~5년	["JSP", "Java", "JavaScript", "React"]	모집마감	https://jumpit.saramin.co.kr/position/12030	frontend	f
1648	사내 시스템 담당자, ERP팀(대리-과장급)	리브스메드	경기 성남시	경력 4~12년	["ERP", "MES", "React Query", "Kubernetes"]	모집마감	https://jumpit.saramin.co.kr/position/50766	frontend	f
1650	[전문연구요원]AI엔지니어-DocumentAI	업스테이지	경기 용인시	신입~20년	["Python", "Java", "AI/인공지능", "Ubuntu"]	모집마감	https://jumpit.saramin.co.kr/position/50521	data	f
1652	Software Engineer - Backend	업스테이지	경기 용인시	경력 5~20년	["SW", "Backendless", "Python", "Golang"]	모집마감	https://jumpit.saramin.co.kr/position/50533	backend	f
751	소프트웨어 엔지니어(Frontend)	사각	서울 마포구	경력 1~8년	["React", "Next.js", "Android", "iOS"]	모집마감	https://jumpit.saramin.co.kr/position/50842	frontend	f
1656	웹 서비스 Back-end 개발자 (경력)	엔닷라이트	경기 성남시	경력 5~10년	["TypeScript", "JavaScript", "GitHub Actions"]	모집마감	https://jumpit.saramin.co.kr/position/50905	backend	f
1660	AI 개발자 채용	티에스엔랩	경기 용인시	경력 2~5년	["Python", "AI/인공지능", "DeepLearning"]	모집마감	https://jumpit.saramin.co.kr/position/50787	data	f
1662	[4년 이상] Backend Engineer	큐픽스	경기 성남시	경력 4~12년	["Ruby", "TypeScript", "Java", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50673	backend	f
1663	AI Research Engineer - LLM	업스테이지	경기 용인시	신입~20년	["AI/인공지능", "TensorFlow", "PyTorch", "NLP"]	모집마감	https://jumpit.saramin.co.kr/position/50525	data	f
1664	IoT시스템 개발 기획(PM) 경력자 모집	메타이노텍	경기 수원시	경력 5~10년	["Azure IoT Hub", "Google Cloud IoT Core"]	모집마감	https://jumpit.saramin.co.kr/position/50603	backend	f
1666	모바일 APP(IOS) 개발자 모집	에스디바이오센서	경기 수원시	경력 1~20년	["iOS", "REST API", "C++", "Objective-C"]	모집마감	https://jumpit.saramin.co.kr/position/49868	mobile	f
1667	Flutter 앱 개발자	제네시스네스트	경기 용인시	경력 1~7년	["Flutter", "Swift", "Kotlin", "Git", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/50823	mobile	f
2160	Web Java Oracle개발(1~3년)	씨맥스	경남 창원시	경력 1~3년	["REST API", "WebGL", "WebRTC", "Spring"]	모집마감	https://jumpit.saramin.co.kr/position/50412	backend	f
838	Android 개발자	넥써쓰	서울 강남구	경력 2~10년	["Android", "React Native", "Blockchain"]	모집마감	https://jumpit.saramin.co.kr/position/50005	frontend	f
933	[TADA]Android Engineer(Intermediate)	이지식스(엠블)	서울 강남구	경력 5~15년	["Kotlin", "Android", "RxJava", "Gradle"]	모집마감	https://jumpit.saramin.co.kr/position/50338	mobile	f
953	[삼성계열사]임베디드(리눅스) S/W개발	씨브이네트	서울 송파구	경력 5~20년	["Qt", "ARM", "Linux", "Android"]	모집마감	https://jumpit.saramin.co.kr/position/50864	mobile	f
2566	Software Engineer - Backend	업스테이지	경기 용인시	경력 5~20년	["SW", "· Backendless", "· Python", "· Golang"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52249	backend	t
962	[플레이오] 안드로이드 개발자 (2년 이상)	지엔에이컴퍼니	서울 서초구	경력 2~5년	["Android", "Kotlin", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/51210	mobile	f
965	플러터 프론트 APP 개발[경력]	패션앤스타일컴퍼니	서울 종로구	경력 2~10년	["Flutter", "iOS", "Android", "GitHub", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/50282	mobile	f
1669	웹 서비스 Front-end 개발자 (경력)	엔닷라이트	경기 성남시	경력 5~10년	["TypeScript", "JavaScript", "CSS 3", "Next.js"]	모집마감	https://jumpit.saramin.co.kr/position/50904	frontend	f
1670	Global 서비스 Back-end개발	숲	경기 성남시	경력 3~10년	["Node.js", "JavaScript", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/50568	backend	f
1671	[신입] Python 개발자	에피넷	경기 안양시	신입	["AI/인공지능", "Python", "Django"]	모집마감	https://jumpit.saramin.co.kr/position/51587	backend	f
1673	AI Research Engineer - Document AI	업스테이지	경기 용인시	신입~20년	["AI/인공지능", "TensorFlow", "PyTorch", "NLP"]	모집마감	https://jumpit.saramin.co.kr/position/50523	data	f
1676	프론트엔드 개발자 채용(팀장급)	이파피루스	경기 성남시	경력 7~15년	["AngularJS", "TypeScript", "RxJS", "Sass"]	모집마감	https://jumpit.saramin.co.kr/position/50620	frontend	f
1677	AI모델 개발 전략매니저	업스테이지	경기 용인시	경력 3~20년	["AI/인공지능"]	모집마감	https://jumpit.saramin.co.kr/position/50529	data	f
1678	Human Pose Estimation (딥러닝,경력)	스포츠투아이	경기 성남시	경력 3~20년	["3D Rendering", "AI/인공지능", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/51101	data	f
1683	서버 개발 (5년 이상)	마카롱팩토리	경기 성남시	경력 3~10년	["Spring", "Kotlin", "Java", "AWS", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/51097	backend	f
1686	전기차 충전 백엔드 개발자 채용	EVAR	경기 성남시	경력 3~10년	["AWS", "Docker", "MSA", "Node.js"]	모집마감	https://jumpit.saramin.co.kr/position/50663	backend	f
1688	AI/LLM Curriculum Developer	업스테이지	경기 용인시	신입~20년	["AI/인공지능", "PyTorch"]	모집마감	https://jumpit.saramin.co.kr/position/50535	data	f
1693	AI 개발자(3년 이상)	네비웍스	경기 안양시	경력 3~10년	["Python", "Linux", "TensorFlow", "PyTorch"]	모집마감	https://jumpit.saramin.co.kr/position/50153	data	f
1114	앱 기획/UX (Product Owner)	아이센스(caresens)	서울 서초구	경력 8~16년	["iOS", "Android", "Figma", "Zeplin"]	모집마감	https://jumpit.saramin.co.kr/position/50915	mobile	f
1213	안드로이드 앱개발 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["Android", "Java", "Kotlin"]	모집마감	https://jumpit.saramin.co.kr/position/49433	mobile	f
1850	Mobile(Flutter) developer	유비퍼스트대원	경기 성남시	경력 3~10년	["React Native", "Android", "iOS", "Flutter"]	모집마감	https://jumpit.saramin.co.kr/position/51199	frontend	f
1855	앱 개발자 (중급)	알비에치	경기 안양시	경력 5~7년	["Flutter", "Android", "iOS", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/50997	mobile	f
1863	디지털헬스케어 플랫폼 SW개발자	엑소시스템즈	경기 성남시	경력 3~7년	["Kotlin", "Android", "SW", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/51467	mobile	f
1872	앱 개발자 (초급)	알비에치	경기 안양시	경력 2~4년	["Flutter", "Android", "iOS", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/50999	mobile	f
1884	모바일(안드로이드/iOS) 애플리케이션 개발	모빌리티네트웍스	경기 안양시	경력 10~20년	["Android", "iOS", "Kotlin", "PHP-MVC"]	모집마감	https://jumpit.saramin.co.kr/position/51286	mobile	f
1896	Android Frameworks/Application 개발	엠핀스	경기 안양시	경력 7~20년	["Android", "Java", "Kotlin", "C++", "C"]	모집마감	https://jumpit.saramin.co.kr/position/50387	mobile	f
2141	Touch Key/Sensor MCU 응용엔지니어	어보브반도체	충북 청주시	경력 3~6년	["C", "C++", "R", "Android", "MCU"]	모집마감	https://jumpit.saramin.co.kr/position/51318	mobile	f
2143	MCU 응용개발 및 FAE	어보브반도체	충북 청주시	경력 3~6년	["C", "C++", "R", "Android", "MCU"]	모집마감	https://jumpit.saramin.co.kr/position/51319	mobile	f
2112	Full stack(풀스택) 개발자 모집[9년 이상]	알지티	대전 중구	경력 9~15년	["JavaScript", "Python", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/51585	frontend	f
2118	서버 및 인프라 개발자 (5년 ~ 10년)	데이터메이커	대전 유성구	경력 5~10년	["Terraform", "Pulumi", "Golang", "Argo"]	모집마감	https://jumpit.saramin.co.kr/position/49963	backend	f
1701	Java 백엔드 개발자(5~10년) 모집	WATA Inc.	경기 성남시	경력 5~10년	["Java", "Spring Framework", "JSP", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/50396	backend	f
1702	AI Model Production - Document AI	업스테이지	경기 용인시	경력 2~20년	["Python", "Java", "AI/인공지능", "Ubuntu"]	모집마감	https://jumpit.saramin.co.kr/position/50530	data	f
1704	웹 개발자 경력직 채용(3년 이상)	네비웍스	경기 안양시	경력 3~7년	["React", "NestJS", "SQL", "REST API", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/50147	backend	f
1708	Node.js 백엔드 개발자 (4년 이상)	티엔에이치	경기 성남시	경력 4~6년	["Node.js", "JavaScript", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/51278	backend	f
1712	3D AI 엔지니어 (경력)	엔닷라이트	경기 성남시	경력 2~10년	["AI/인공지능"]	모집마감	https://jumpit.saramin.co.kr/position/50910	data	f
1716	DEVOPS 엔지니어	보스반도체	경기 성남시	경력 1~8년	["JavaScript", "Python", "Jenkins", "GitHub"]	모집마감	https://jumpit.saramin.co.kr/position/50113	frontend	f
1717	백엔드 개발자 (5년 ~ 7년)	프롬프트팩토리	경기 성남시	경력 5~7년	["AWS", "Node.js", "ExpressJS", "Django"]	모집마감	https://jumpit.saramin.co.kr/position/51062	backend	f
1718	[전기차충전기]안드로이드 개발자	피앤이시스템즈	경기 수원시	경력 5~10년	["Kotlin", "Jetpack", "Composer", "SQLite"]	모집마감	https://jumpit.saramin.co.kr/position/50174	mobile	f
1719	[IT] 백엔드 SW개발 (전자차트)	덴티움	경기 수원시	경력 3~9년	["Node.js", "GraphQL", "AWS", "RDB", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/50734	backend	f
1720	Robot Control Engineer (전문연 가능)	플라잎	경기 성남시	경력 3~10년	["AI/인공지능", "C", "C++", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50055	data	f
1722	웹서버 개발자 모집	슈프리마	경기 성남시	경력 5~10년	["C++", "Java", "Spring", "React"]	모집마감	https://jumpit.saramin.co.kr/position/49794	backend	f
1723	얼굴인식 서버 풀스택 소프트웨어 개발자	슈프리마	경기 성남시	경력 3~7년	["C++", "Go"]	모집마감	https://jumpit.saramin.co.kr/position/50616	backend	f
1727	FPGA 개발자 채용	티에스엔랩	경기 용인시	신입~5년	["FPGA", "Verilog", "Git", "AI/인공지능"]	모집마감	https://jumpit.saramin.co.kr/position/50165	data	f
1748	AI 기반 업무 자동화 엔지니어 (4~6년)	큐픽스	경기 성남시	경력 4~6년	["RPA", "Zapier"]	모집마감	https://jumpit.saramin.co.kr/position/51506	data	f
1750	웹 프론트엔드 개발자 채용(4년 이상)	비글즈	경기 성남시	경력 4~15년	["Next.js", "React", "JavaScript", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/51051	frontend	f
1751	[CTO레벨] NLP AI 엔지니어	에이블제이	경기 성남시	경력 5~15년	["PyTorch", "TensorFlow", "Transformers"]	모집마감	https://jumpit.saramin.co.kr/position/51127	data	f
1752	자사 쇼핑몰 전산팀원 모집	파츠몰	경기 고양시	경력 3~10년	["JavaScript", "MSSQL", "Spring Boot", "JSP"]	모집마감	https://jumpit.saramin.co.kr/position/51554	backend	f
1753	S/W개발	원익피앤이	경기 수원시	경력 6~20년	["Python", "TensorFlow", "Keras"]	모집마감	https://jumpit.saramin.co.kr/position/51012	data	f
1755	NLP AI 엔지니어	에이블제이	경기 성남시	경력 3~15년	["PyTorch", "TensorFlow", "Transformers"]	모집마감	https://jumpit.saramin.co.kr/position/50903	data	f
1756	AI 기반 업무 자동화 엔지니어 (1~3년)	큐픽스	경기 성남시	경력 1~3년	["RPA", "Zapier"]	모집마감	https://jumpit.saramin.co.kr/position/51505	data	f
1724	SDK개발 (C++, C#, QT, DB)	레이언스	경기 화성시	경력 5~15년	["C++", "C#", "Qt", "DB", "TCP/IP"]	모집마감	https://jumpit.saramin.co.kr/position/50478	other	f
1761	AI Product Owner	업스테이지	경기 용인시	경력 5~20년	["AI/인공지능", "Python", "C++", "Linux", "Shell"]	모집마감	https://jumpit.saramin.co.kr/position/50536	data	f
1763	공급망보안관리솔루션설계/개발(16~20)	쿤텍	경기 성남시	경력 16~20년	["Linux", "Windows Server", "Golang"]	모집마감	https://jumpit.saramin.co.kr/position/50261	backend	f
1765	EV charger server 개발자	피앤이시스템즈	경기 수원시	경력 3~5년	["Node.js", "TypeScript", "NestJS", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/50171	backend	f
1776	웹개발 풀스텍 개발자(경력8년이상 ~ )	오마이어스	경기 성남시	경력 8~15년	["PHP", "Laravel"]	모집마감	https://jumpit.saramin.co.kr/position/50954	backend	f
1779	웹개발 풀스텍 개발자(경력5~7년)	오마이어스	경기 성남시	경력 5~7년	["PHP", "Laravel"]	모집마감	https://jumpit.saramin.co.kr/position/50953	backend	f
1798	AI 카메라 임베디드 소프트웨어 엔지니어	슈프리마	경기 성남시	경력 1~10년	["C", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/50897	data	f
1801	영상 처리 연구/개발(전문연구요원가능)	베스텔라랩	대구 동구, 경기 안양시	경력 2~10년	["Python", "OpenCV", "Java", "Spring Boot"]	모집마감	https://jumpit.saramin.co.kr/position/51263	backend	f
1811	앱개발 프로그래머 신입 채용	파이	경기 수원시	신입	["OpenCV", "Flutter", "React", "Swift"]	모집마감	https://jumpit.saramin.co.kr/position/50012	frontend	f
1814	앱개발 프로그래머 경력(8~10년)채용	파이	경기 수원시	경력 8~10년	["OpenCV", "Flutter", "React", "Swift"]	모집마감	https://jumpit.saramin.co.kr/position/50019	frontend	f
1818	앱개발 프로그래머 경력 (5~7년)채용	파이	경기 수원시	경력 5~7년	["OpenCV", "Flutter", "React", "Swift"]	모집마감	https://jumpit.saramin.co.kr/position/50016	frontend	f
1827	NPU Design Engineer	아이에이치더블유	경기 용인시	경력 3~20년	["EDA", "Verilog", "AI/인공지능"]	모집마감	https://jumpit.saramin.co.kr/position/51010	data	f
1828	앱개발 프로그래머 경력 (2~4년)채용	파이	경기 수원시	경력 2~4년	["OpenCV", "Flutter", "React", "Swift"]	모집마감	https://jumpit.saramin.co.kr/position/50013	frontend	f
1835	(키퍼)Back End Engineer(5~9년)	한화비전	경기 성남시	경력 5~9년	["Node.js", "REST API", "PostgreSQL"]	모집마감	https://jumpit.saramin.co.kr/position/50239	backend	f
1838	AI 연구원 (3~9년)	한화비전	경기 성남시	경력 3~9년	["Git", "BigData", "C++", "MachineLearning"]	모집마감	https://jumpit.saramin.co.kr/position/50241	data	f
1846	인공지능(AI) 엔지니어 고급 채용	알비에치	경기 안양시	경력 8~10년	["MachineLearning", "DeepLearning"]	모집마감	https://jumpit.saramin.co.kr/position/50550	data	f
1847	Backend developer	유비퍼스트대원	경기 성남시	경력 4~10년	["Java", "Kotlin", "Spring Boot", "CSS 3"]	모집마감	https://jumpit.saramin.co.kr/position/51197	backend	f
1851	전산팀 서버 구축 기획 경력 채용[8~11년]	오비오	경기 화성시	경력 8~11년	["MSSQL", "ERP"]	모집마감	https://jumpit.saramin.co.kr/position/51511	backend	f
1852	공급망보안관리솔루션 설계/개발(7~10)	쿤텍	경기 성남시	경력 7~10년	["Linux", "Windows Server", "Golang"]	모집마감	https://jumpit.saramin.co.kr/position/50257	backend	f
1854	SRE팀 SRE엔지니어(팀장)	지니언스	경기 안양시	경력 15~20년	["Jira", "Testrail", "QA"]	모집마감	https://jumpit.saramin.co.kr/position/50594	data	f
1856	디지털헬스케어 플랫폼 AI 엔지니어	엑소시스템즈	경기 성남시	신입~10년	["AI/인공지능", "C++", "MATLAB"]	모집마감	https://jumpit.saramin.co.kr/position/51468	data	f
2119	DevOps 엔지니어 (5년 ~ 10년)	데이터메이커	대전 유성구	경력 5~10년	["Terraform", "Pulumi", "GoLand", "Argo"]	모집마감	https://jumpit.saramin.co.kr/position/49957	backend	f
1053	AI 시니어 개발자	룰루랩	서울 강남구	경력 10~20년	["Python", "PyTorch"]	모집마감	https://jumpit.saramin.co.kr/position/50197	data	f
2165	Web Java Oracle개발(4~6년)	씨맥스	경남 창원시	경력 4~6년	["REST API", "WebGL", "WebRTC", "Spring"]	모집마감	https://jumpit.saramin.co.kr/position/50410	backend	f
2166	시스템운영/테스트및관리(경력6년)	씨맥스	경남 창원시	경력 4~6년	["Oracle", "Python", "AI/인공지능"]	모집마감	https://jumpit.saramin.co.kr/position/51445	data	f
1857	PNS팀 서버 개발자	지니언스	경기 안양시	경력 5~15년	["C", "C++", "Linux", "VPN"]	모집마감	https://jumpit.saramin.co.kr/position/50589	backend	f
1858	Flutter 앱개발자	테일크루	경기 성남시	경력 3~10년	["Flutter", "CSS 3", "JavaScript", "TypeScript"]	모집마감	https://jumpit.saramin.co.kr/position/51537	frontend	f
1864	AI 연구원 (10~12년)	한화비전	경기 성남시	경력 10~12년	["Git", "BigData", "C++", "MachineLearning"]	모집마감	https://jumpit.saramin.co.kr/position/50240	data	f
1865	iOS 개발 (5년 이상)	마카롱팩토리	경기 성남시	경력 5~10년	["iOS", "Xcode", "Flutter", "Swift", "Rxswift"]	모집마감	https://jumpit.saramin.co.kr/position/51098	mobile	f
1866	AI 개발자 연구원 경력	엔티엘헬스케어	경기 성남시	경력 3~10년	["AI/인공지능"]	모집마감	https://jumpit.saramin.co.kr/position/51423	data	f
1868	전산팀 서버 구축 기획 경력 채용[5~7년]	오비오	경기 화성시	경력 5~7년	["MSSQL", "ERP"]	모집마감	https://jumpit.saramin.co.kr/position/51510	backend	f
1869	(키퍼) Back End Engineer (10년~)	한화비전	경기 성남시	경력 10~12년	["Node.js", "REST API", "PostgreSQL"]	모집마감	https://jumpit.saramin.co.kr/position/50238	backend	f
1870	공급망보안관리솔루션설계/개발(11~15)	쿤텍	경기 성남시	경력 11~15년	["Linux", "Windows Server", "Golang"]	모집마감	https://jumpit.saramin.co.kr/position/50259	backend	f
1871	MultiOS팀 Linux보안 소프트웨어 개발	지니언스	경기 안양시	경력 7~15년	["C", "C++", "Linux", "OpenSSL", "Kafka"]	모집마감	https://jumpit.saramin.co.kr/position/50592	mobile	f
1873	전산팀 서버 구축 기획 경력 채용[12~15년]	오비오	경기 화성시	경력 12~15년	["MSSQL", "ERP"]	모집마감	https://jumpit.saramin.co.kr/position/51512	backend	f
998	Flutter 개발자	코보시스	서울 송파구	경력 3~10년	["Flutter", "Android", "iOS", "Dart", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/49933	mobile	f
2167	시스템운영/테스트및관리(경력3년)	씨맥스	경남 창원시	경력 1~3년	["Oracle", "Python", "AI/인공지능"]	모집마감	https://jumpit.saramin.co.kr/position/51444	data	f
2049	로봇 시스템 개발 엔지니어	론픽	부산 해운대구	경력 3~5년	["MCU"]	모집마감	https://jumpit.saramin.co.kr/position/51516	other	f
2168	Spring기반 유지보수/개발(경력4~6)	씨맥스	경남 창원시	경력 4~6년	["Python", "Java", "REST API", "Spring", "JSP"]	모집마감	https://jumpit.saramin.co.kr/position/51609	backend	f
2169	Spring기반 유지보수/개발	씨맥스	경남 창원시	경력 1~3년	["Python", "Java", "REST API", "Spring", "JSP"]	모집마감	https://jumpit.saramin.co.kr/position/51608	backend	f
837	자율주행 임베디드 SW 엔지니어(전문연 지원 가능)	에이스웍스코리아	서울 강남구	신입~7년	["C", "Python", "Embedded", "FW", "ethernet"]	모집마감	https://jumpit.saramin.co.kr/position/50700	other	f
907	네트워크 엔지니어 정규직 채용	링네트	서울 구로구	경력 2~8년	["Network", "L2", "L3", "L4", "L7", "Router"]	모집마감	https://jumpit.saramin.co.kr/position/50485	other	f
944	헬스케어 시스템 개발자(DB개발자)	엘리오앤컴퍼니	서울 강남구	경력 5~12년	["Oracle", "SQL", "MSSQL", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/50120	other	f
2849	웹서버 개발자 신입 채용	에프엘이에스	서울 강서구	신입	["C++", "· Java", "· React", "· Spring"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52642	backend	t
979	SAP Project Manager 모집	지에스아이티엠	서울 종로구	경력 7~20년	["SAP", "ERP"]	모집마감	https://jumpit.saramin.co.kr/position/50775	other	f
1087	통합보안관리 엔지니어(신입)	이너버스	서울 영등포구	신입~2년	["SW", "Linux", "Docker", "Elasticsearch"]	모집마감	https://jumpit.saramin.co.kr/position/50496	other	f
1122	안드로이드 개발자(경력)	레트리카	서울 서초구	경력 2~5년	["Java", "Gradle", "MVVM", "RxJava", "Realm"]	모집마감	https://jumpit.saramin.co.kr/position/51411	other	f
1123	Sr. AI & Data Analysis Specialist(5~10y)	피엠인터내셔널코리아	서울 영등포구	경력 5~10년	["SQL", "NoSql", "Tableau", "AWS", "AZURE"]	모집마감	https://jumpit.saramin.co.kr/position/50982	other	f
1874	Server팀 Frontend 개발 및 유지보수	지니언스	경기 안양시	경력 10~20년	["HTML5", "CSS 3", "JavaScript", "React"]	모집마감	https://jumpit.saramin.co.kr/position/50593	frontend	f
1875	SRE팀 SRE엔지니어	지니언스	경기 안양시	경력 5~15년	["QA", "Jira", "Testrail"]	모집마감	https://jumpit.saramin.co.kr/position/50595	data	f
1876	AI 연구개발자 (석사)	더블티	경기 수원시	신입	["AI/인공지능", "scikit-learn", "PyTorch"]	모집마감	https://jumpit.saramin.co.kr/position/51441	data	f
912	HRIS 풀스택	메디쿼터스	서울 강남구	경력 1~3년	["Python", "PostgreSQL", "Git", "GitHub"]	모집마감	https://jumpit.saramin.co.kr/position/51529	other	f
1252	FPGA개발 신입 채용	에프엘이에스	서울 강서구	신입	["FPGA", "C", "C++", "Cisco ISE"]	모집마감	https://jumpit.saramin.co.kr/position/50585	other	f
1208	기술연구소 연구개발직 채용	금영제너럴	서울 광진구	신입~10년	["HW", "SW", "C"]	모집마감	https://jumpit.saramin.co.kr/position/50388	other	f
1458	ERP 개발(.NET, C#, VB.NET)	웅진	서울 중구	경력 3~20년	["ERP", "SAP", ".NET", "Vb.net", "C#"]	모집마감	https://jumpit.saramin.co.kr/position/49989	other	f
1770	EV charger embedded 개발	피앤이시스템즈	경기 수원시	경력 3~6년	["Rust", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/50173	other	f
1263	[박사]영상처리/rPPG 연구개발	바이오커넥트	서울 서초구	신입~10년	["OpenCV", "DeepLearning", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50385	other	f
1299	DevOps 엔지니어 채용 (4년 이상)	싸이터	서울 금천구	경력 4~12년	["Kubernetes", "Kafka", "Redis"]	모집마감	https://jumpit.saramin.co.kr/position/51276	other	f
1480	Quality Engineer(신입 ~ 4년 경력)	뷰런테크놀로지	서울 서초구	신입~4년	["QA", "Linux", "C", "C++", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/51613	other	f
1489	ABAP 개발	웅진	서울 중구	경력 3~20년	["SAP", "ABAP", "SQL"]	모집마감	https://jumpit.saramin.co.kr/position/49902	other	f
1515	전산실 SAP SD 운영 신입 채용	벨아이앤에스	서울 서대문구	신입	["ABAP", "SQL", "SAP"]	모집마감	https://jumpit.saramin.co.kr/position/50422	other	f
731	Software QA Engineer	이마고웍스	서울 강남구	경력 3~5년	["QA"]	모집마감	https://jumpit.saramin.co.kr/position/50676	other	f
1658	[WBCT] 정형외과용 3D뷰어 SW 개발	덴티움	경기 수원시	경력 3~7년	["c", "c++", "c#", "OpenGL", "WPF"]	모집마감	https://jumpit.saramin.co.kr/position/50735	other	f
1766	Physical Design Engineer	보스반도체	경기 성남시	경력 3~15년	["ASIC"]	모집마감	https://jumpit.saramin.co.kr/position/50105	other	f
1804	영상처리(Vision) S/W 개발 (2~4년)	쎄크	경기 수원시	경력 2~4년	["C++", "C#", "OpenCV", "SW", "HALCON"]	모집마감	https://jumpit.saramin.co.kr/position/49843	other	f
1840	윈도우 클라이언트 개발 및 유지보수	지니언스	경기 안양시	경력 1~5년	["C", "C++", "Windows"]	모집마감	https://jumpit.saramin.co.kr/position/50597	other	f
1841	IT운영	유비퍼스트대원	경기 성남시	경력 3~10년	["AWS", "Kafka", "Amazon EKS", "DB", "Oracle"]	모집마감	https://jumpit.saramin.co.kr/position/51201	other	f
1843	반도체설비제어 SoftwarePlatform 개발(분당)	한국알박	경기 성남시	경력 10~20년	["SW", "C#"]	모집마감	https://jumpit.saramin.co.kr/position/50617	other	f
1877	Cloud Security Engineer(10년~)	한화비전	경기 성남시	경력 10~12년	["ISMS", "AWS", "AZURE", "Firewall", "IPS"]	모집마감	https://jumpit.saramin.co.kr/position/50243	other	f
1878	GSC EDR IoC 및 악성코드 분석	지니언스	경기 안양시	신입~5년	["PowerShell", "ScriptRock"]	모집마감	https://jumpit.saramin.co.kr/position/50591	other	f
1950	주차장 개발자(Mobility Hub Platform)	하이파킹	경기 성남시	신입~20년	["Azure DevOps"]	모집마감	https://jumpit.saramin.co.kr/position/51354	other	f
733	PHP 웹개발자 채용 (경력 6~8년)	엠투피아이	서울 성동구	경력 6~8년	["PHP", "MySQL", "Apache Tomcat", "Linux"]	모집마감	https://jumpit.saramin.co.kr/position/49789	other	f
735	PHP 웹개발자 채용 (경력 3~5년)	엠투피아이	서울 성동구	경력 3~5년	["PHP", "MySQL", "Apache Tomcat", "Linux"]	모집마감	https://jumpit.saramin.co.kr/position/49788	other	f
748	솔루션운영 엔지니어	로민	서울 서초구	경력 1~15년	["Python", "Java", "PostgreSQL", "NGINX"]	모집마감	https://jumpit.saramin.co.kr/position/51268	other	f
749	컴퓨터비전 엔지니어 채용	쉬모스랩	서울 강남구	경력 2~7년	["Docker", "Linux", "Git", "gRPC", "SQL"]	모집마감	https://jumpit.saramin.co.kr/position/50691	other	f
754	Windows 개발자	펜타시큐리티	서울 영등포구	경력 2~5년	["C#", "C++", "C", "Visual Studio"]	모집마감	https://jumpit.saramin.co.kr/position/51277	other	f
756	[IT Infra]IT Administrative Engineer	오픈엣지테크놀로지	서울 강남구	경력 1~14년	["Shell", "Docker", "Kubernetes", "Jenkins"]	모집마감	https://jumpit.saramin.co.kr/position/50491	other	f
760	네트워크 기획, 운영 담당	팬택씨앤아이	서울 영등포구	경력 3~10년	["Cisco", "Firewall", "IPS", "VPN", "L2", "L3", "L4"]	모집마감	https://jumpit.saramin.co.kr/position/51214	other	f
762	[DRAM PHY]SiliconValidation Engineer	오픈엣지테크놀로지	서울 강남구	경력 2~15년	["C", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50487	other	f
765	네트워크장비 Web Management 솔루션개발	파이오링크	서울 금천구	경력 3~12년	["Python", "C", "C++", "Linux", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/51021	other	f
766	데이터 엔지니어 (데이터레이크 개발)	스패로우	서울 마포구	경력 5~10년	["PostgreSQL", "Kubernetes", "Docker"]	모집마감	https://jumpit.saramin.co.kr/position/50816	other	f
768	IP Verification Engineer	오픈엣지테크놀로지	서울 강남구	경력 4~14년	["Verilog", "C", "C++", "Python", "Perl"]	모집마감	https://jumpit.saramin.co.kr/position/50494	other	f
771	[DRAM PHY] Digital Engineer	오픈엣지테크놀로지	서울 강남구	경력 2~15년	["Verilog", "C", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50488	other	f
774	[Network-on-Chip]RTL Design Engineer	오픈엣지테크놀로지	서울 강남구	경력 2~15년	["Verilog", "C", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50486	other	f
776	SQA실 테스트 담당자 (0~3년이하)	파이오링크	서울 금천구	신입~3년	["QA", "AWS", "SW", "vmware", "Ccna"]	모집마감	https://jumpit.saramin.co.kr/position/51124	other	f
777	[DRAM PHY] Analog Engineer	오픈엣지테크놀로지	서울 강남구	경력 2~15년	["Verilog", "C", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50492	other	f
779	[MemoryController]RTLDesign Engineer	오픈엣지테크놀로지	서울 강남구	경력 2~15년	["Verilog", "C", "Python", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/50489	other	f
780	전력변환 시뮬레이션 엔지니어 (전문연 지원 가능)	에이스웍스코리아	서울 강남구	신입	["MATLAB"]	모집마감	https://jumpit.saramin.co.kr/position/50701	other	f
786	[코스닥 상장사] SRE 포지션 채용	디어유	서울 강남구	경력 3~10년	["AWS", "Linux", "Docker", "Kubernetes"]	모집마감	https://jumpit.saramin.co.kr/position/50795	other	f
788	보안 네트워크 개발자 (경력)	펜타시큐리티	서울 영등포구	경력 7~20년	["Firewall", "C++", "Linux", "TCP/IP", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50121	other	f
789	솔루션 QA담당(경력 6~10년)	엠로	서울 영등포구	경력 6~10년	["QA"]	모집마감	https://jumpit.saramin.co.kr/position/51082	other	f
800	Java 개발자	벳플럭스	서울 강남구	경력 3~5년	["Java", "WebRTC", "MQTT", "Firebase", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/50684	other	f
809	Microsoft M365 보안/규정 준수 엔지니어	콘센트릭스서비스코리아	서울 구로구	경력 3~20년	["microsoft office 365", "microsoft teams"]	모집마감	https://jumpit.saramin.co.kr/position/49979	other	f
815	빅데이터 시스템 구축 및 운영 담당자	엑셈	서울 강서구	경력 3~7년	["Java", "Docker", "Kubernetes", "Etl"]	모집마감	https://jumpit.saramin.co.kr/position/50481	other	f
819	IT 시스템 연동·구축 담당자	팬택씨앤아이	서울 영등포구	경력 10~20년	["MSSQL", "SQL", "ERP", "REST API", "JSON"]	모집마감	https://jumpit.saramin.co.kr/position/50848	other	f
829	[챌린저스] QA Manager	화이트큐브	서울 강남구	신입~10년	["Jira", "QA", "Notion", "Slack", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/51079	other	f
830	[커머스프로덕션] Jr. QA 엔지니어 채용	미리디	서울 구로구	경력 1~4년	["Slack", "Redmine", "QA", "Confluence", "Jira"]	모집마감	https://jumpit.saramin.co.kr/position/50618	other	f
831	자연어처리 엔지니어 채용	쉬모스랩	서울 강남구	경력 2~7년	["SQL", "PostgreSQL", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50694	other	f
833	Windows 개발자 경력사원 모집	에이피알	서울 송파구	경력 2~4년	["Windows", "Windows Server", "C#", "WPF"]	모집마감	https://jumpit.saramin.co.kr/position/51204	other	f
840	자율주행 차량제어 엔지니어 (전문연 지원 가능)	에이스웍스코리아	서울 강남구	신입~10년	["C++", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50695	other	f
841	전장설계 엔지니어 (신입)	에이스웍스코리아	서울 강남구	신입	["Autocad", "Solidworks"]	모집마감	https://jumpit.saramin.co.kr/position/50697	other	f
844	Multi Agent Path Finding S/W Engineer (전문연 가능)	토르드라이브	서울 영등포구	경력 3~10년	["C++", "ROS"]	모집마감	https://jumpit.saramin.co.kr/position/51342	other	f
845	NPU Verification Engineer	모빌린트	서울 강남구	경력 5~10년	["C", "C++", "Linux", "DeepLearning"]	모집마감	https://jumpit.saramin.co.kr/position/50332	other	f
848	의료SW그룹 알고리즘 개발자 모집	에이엠시지	서울 서초구	경력 10~20년	["Python", "MachineLearning"]	모집마감	https://jumpit.saramin.co.kr/position/51038	other	f
850	DBA 담당(7년↑)	엑심베이	서울 구로구	경력 7~10년	["MySQL", "Java", "Slack", "Linux", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/50678	other	f
852	의료기기 소프트웨어(SW) 개발자 모집	에이엠시지	서울 서초구	경력 3~10년	["DICOM", "Qt", "C++", "SQL", "GUI"]	모집마감	https://jumpit.saramin.co.kr/position/51039	other	f
854	Devops (5년 이상)	퓨쳐위즈	서울 강남구	경력 5~10년	["AWS", "Kubernetes", "Terraform", "Datadog"]	모집마감	https://jumpit.saramin.co.kr/position/50144	other	f
855	RTL 설계 엔지니어 (경력)	칩스앤미디어	서울 강남구	경력 8~15년	["ASIC", "FPGA", "Verilog", "C", "C++", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50077	other	f
859	Site Reliability Engineer/5~8년	불마켓랩스(BullMarketLabsCo.Ltd.)	서울 강남구	경력 5~8년	["AWS", "Amazon EC2 Container Service"]	모집마감	https://jumpit.saramin.co.kr/position/50296	other	f
860	펌웨어 개발자 경력 정규직 채용	엠투클라우드	서울 송파구	경력 10~15년	["FW", "MCU", "C", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/50599	other	f
865	멀티모달 AI 엔지니어	로민	서울 서초구	경력 2~15년	["Python", "Docker", "PyTorch", "TensorFlow"]	모집마감	https://jumpit.saramin.co.kr/position/51269	other	f
866	품질보증관리자(QC/QA)	디카르고	서울 강남구	경력 3~5년	["Jira", "Notion", "Slack", "Selenium", "Appium"]	모집마감	https://jumpit.saramin.co.kr/position/51360	other	f
872	FW 엔지니어 (경력)	칩스앤미디어	서울 강남구	경력 5~12년	["C++", "C", "HW", "FW"]	모집마감	https://jumpit.saramin.co.kr/position/50078	other	f
876	전장설계 엔지니어 (경력)	에이스웍스코리아	서울 강남구	경력 3~10년	["Autocad", "Solidworks"]	모집마감	https://jumpit.saramin.co.kr/position/50698	other	f
1296	FinOps Junior 컨설턴트	메타넷글로벌	서울 강남구	경력 1~4년	["Azure DevOps"]	모집마감	https://jumpit.saramin.co.kr/position/50552	other	f
880	[외국계 게임사] 인큐베이션 개발자(계약직)	가레나코리아	서울 강남구	경력 2~5년	["Unity", "Unreal Engine"]	모집마감	https://jumpit.saramin.co.kr/position/51410	other	f
881	[인공지능솔루션] Search Engineer	제논	서울 강남구	경력 3~20년	["Elasticsearch", "Docker", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50937	other	f
894	보안 솔루션 엔지니어 (신입)	위드네트웍스	서울 강서구	신입	["Python"]	모집마감	https://jumpit.saramin.co.kr/position/50247	other	f
895	소프트웨어 QA(신입/~2년이하)	엑셈	서울 강서구	신입~2년	["Kubernetes", "K8S", "Oracle", "QA", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/50902	other	f
897	Motion Planning/Control Engineer	웨어러블에이아이	서울 영등포구	신입~10년	["C", "C++", "Python", "MATLAB", "Docker"]	모집마감	https://jumpit.saramin.co.kr/position/50378	other	f
905	정보보안 담당자 (6년 이상)	이지스엔터프라이즈	서울 금천구	경력 6~15년	["ISMS", "CPPG", "CISA", "CISSP", "IPS", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/51014	other	f
909	Windows개발자 (경력 11년↑)	페이타랩	서울 강남구	경력 11~20년	["WPF", "C#", "Visual Studio", "C++", ".NET"]	모집마감	https://jumpit.saramin.co.kr/position/50427	other	f
913	자사 HR Platform 서비스 개발팀장	아인잡	서울 강남구	경력 5~15년	["MySQL", "Java", "AWS", "NoSql", "Docker"]	모집마감	https://jumpit.saramin.co.kr/position/50079	other	f
915	기술지원 Field Engineer	이노뎁	서울 금천구	경력 5~20년	["Windows", "Windows Server", "Network"]	모집마감	https://jumpit.saramin.co.kr/position/50167	other	f
916	SAP 운영, 개발자 채용(7~8년)	제너시스비비큐	서울 송파구	경력 7~8년	["SAP", "ABAP"]	모집마감	https://jumpit.saramin.co.kr/position/50964	other	f
920	머신러닝 연구원/엔지니어	에이아이파크	서울 마포구	경력 3~10년	["Python", "PyTorch", "TensorFlow", "AZURE"]	모집마감	https://jumpit.saramin.co.kr/position/51036	other	f
921	DevOps/MLOps Engineer (3~6년)	웨어러블에이아이	서울 영등포구	경력 3~6년	["AWS", "Linux", "Docker", "Kubernetes"]	모집마감	https://jumpit.saramin.co.kr/position/50375	other	f
926	C 개발자(3년 이상)	엑셈	서울 강서구	경력 3~7년	["C++", "C", "Linux", "Network"]	모집마감	https://jumpit.saramin.co.kr/position/50845	other	f
930	CI/CD 엔지니어	오픈소스컨설팅	서울 강남구	경력 3~14년	["GitHub", "GitLab", "Bitbucket", "Jenkins"]	모집마감	https://jumpit.saramin.co.kr/position/49980	other	f
931	클라우드 기술지원 엔지니어	오픈소스컨설팅	서울 강남구	경력 5~13년	["Linux", "Kubernetes", "L3", "Network", "L2"]	모집마감	https://jumpit.saramin.co.kr/position/49976	other	f
938	의료기기 인공지능 엔지니어	오션스바이오	서울 용산구	경력 3~20년	["DeepLearning", "MachineLearning"]	모집마감	https://jumpit.saramin.co.kr/position/50519	other	f
939	3차원 카메라 하드웨어 개발자(2~4)	클레	서울 성동구	경력 2~4년	["PCB", "Orcad"]	모집마감	https://jumpit.saramin.co.kr/position/51071	other	f
958	Windows개발자 (신입~5년↓)	페이타랩	서울 강남구	신입~5년	["WPF", "C#", "Visual Studio", "C++", ".NET"]	모집마감	https://jumpit.saramin.co.kr/position/50425	other	f
961	소프트웨어 QA	윌로그	서울 강남구	경력 3~12년	["QA", "Jira", "Slack", "Confluence", "Redmine"]	모집마감	https://jumpit.saramin.co.kr/position/50870	other	f
973	DBA 담당(4~6년)	엑심베이	서울 구로구	경력 4~6년	["MySQL", "Java", "Slack", "Linux", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/50679	other	f
975	System Software Engineer	모빌린트	서울 강남구	경력 5~10년	["Linux", "C++", "Embedded", "sw", "C"]	모집마감	https://jumpit.saramin.co.kr/position/50326	other	f
976	임베디드(펌웨어) 개발자	크래블	서울 성동구	경력 1~20년	["HW", "Linux", "SW", "MCU"]	모집마감	https://jumpit.saramin.co.kr/position/50502	other	f
978	리눅스 App. 개발자	코넥티브	서울 강남구	경력 3~10년	["Git", "C", "C++", "GUI", "Linux", "Qt", "Ubuntu"]	모집마감	https://jumpit.saramin.co.kr/position/51087	other	f
980	Sr. AI & Data Analysis Specialist(11~15y)	피엠인터내셔널코리아	서울 영등포구	경력 11~15년	["SQL", "NoSql", "Tableau", "AWS", "AZURE"]	모집마감	https://jumpit.saramin.co.kr/position/50990	other	f
982	Software Developer	씨메스	서울 강남구	신입~3년	["C", "C++", "Python", "Blender", "Solidworks"]	모집마감	https://jumpit.saramin.co.kr/position/51157	other	f
983	Windows개발자 (경력 6~10년↓)	페이타랩	서울 강남구	경력 6~10년	["WPF", "C#", "Visual Studio", "C++", ".NET"]	모집마감	https://jumpit.saramin.co.kr/position/50426	other	f
984	Playce Cloud Pre-Sales	오픈소스컨설팅	서울 강남구	경력 7~20년	["OpenStack", "Kubernetes", "Jenkins"]	모집마감	https://jumpit.saramin.co.kr/position/49981	other	f
985	FW 펌웨어 개발(3년 이상)	윌로그	서울 강남구	경력 3~6년	["FW", "MCU", "RTOS", "C", "C++", "Git", "HW"]	모집마감	https://jumpit.saramin.co.kr/position/50871	other	f
986	FW 펌웨어 개발(7년 이상)	윌로그	서울 강남구	경력 7~12년	["FW", "MCU", "RTOS", "C", "C++", "Git", "HW"]	모집마감	https://jumpit.saramin.co.kr/position/50872	other	f
994	정보보안 담당자 (5년 이상)	퓨쳐위즈	서울 강남구	경력 5~10년	["AWS", "Amazon EKS"]	모집마감	https://jumpit.saramin.co.kr/position/50143	other	f
995	IoT Embedded FW Engineer	럭키박스솔루션	서울 서초구	경력 5~10년	["C++", "FW", "ARM", "MCU", "Embedded"]	모집마감	https://jumpit.saramin.co.kr/position/50660	other	f
1000	C# 개발자	코보시스	서울 송파구	경력 3~10년	["C#", "WPF", "Git", ".NET", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/49935	other	f
1001	3D 엔진개발 [메타개발팀] 과장급	상화	서울 강남구	경력 6~8년	["Unity", "Unreal Engine", "3D Rendering"]	모집마감	https://jumpit.saramin.co.kr/position/50189	other	f
1008	Robotics Engineer	씨메스	서울 강남구	신입	["C++", "Python", "C"]	모집마감	https://jumpit.saramin.co.kr/position/50330	other	f
1009	인사시스템 분석/설계 담당자 모집	지에스비즈플	서울 종로구	경력 10~15년	["Java", "Oracle", "MariaDB"]	모집마감	https://jumpit.saramin.co.kr/position/50776	other	f
1011	SAP 운영, 개발자 채용(4~6년)	제너시스비비큐	서울 송파구	경력 4~6년	["SAP", "ABAP"]	모집마감	https://jumpit.saramin.co.kr/position/50963	other	f
1013	NPU Core Engineer (RTL)	모빌린트	서울 강남구	신입~10년	["C", "C++", "Linux", "DeepLearning"]	모집마감	https://jumpit.saramin.co.kr/position/50333	other	f
1016	3D 엔진개발 [메타개발팀]	상화	서울 강남구	경력 3~5년	["Unity", "Unreal Engine", "3D Rendering"]	모집마감	https://jumpit.saramin.co.kr/position/50188	other	f
1017	3D Scan Engineer 경력 채용	디오에프	서울 성동구	경력 3~15년	["SW", "C++", "MachineLearning", "OpenCV"]	모집마감	https://jumpit.saramin.co.kr/position/51140	other	f
1018	[DOF] 회로설계 엔지니어 채용	디오에프	서울 성동구	경력 5~15년	["FPGA", "MCU", "SMPS", "RF"]	모집마감	https://jumpit.saramin.co.kr/position/50431	other	f
1019	IT Infra Manager	모빌린트	서울 강남구	경력 7~15년	["Linux", "Windows", "Network", "ERP", "Jira"]	모집마감	https://jumpit.saramin.co.kr/position/50283	other	f
1021	SoC Design Engineer	모빌린트	서울 강남구	신입~10년	["Verilog", "EDA", "ASIC", "FPGA", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50324	other	f
1022	[플랫폼개발팀] Java 주니어 개발자	델레오코리아	서울 강남구	경력 4~8년	["REST API", "Git", "Redis", "RabbitMQ", "RDB"]	모집마감	https://jumpit.saramin.co.kr/position/49910	other	f
1026	SAP 운영, 개발자 채용(0~3년)	제너시스비비큐	서울 송파구	신입~3년	["SAP", "ABAP"]	모집마감	https://jumpit.saramin.co.kr/position/50962	other	f
917	Software Engineer (NPU SDK)	모빌린트	서울 강남구	신입~10년	["C", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/51298	other	f
1029	언리얼 게임개발 과정 교강사(경력)	경일게임아이티아카데미	서울 강동구	신입~30년	["C++", "Unreal Engine"]	모집마감	https://jumpit.saramin.co.kr/position/50613	other	f
1036	정보보안(관리)	미디어로그	서울 마포구	경력 10~15년	["ISMS", "CPPG"]	모집마감	https://jumpit.saramin.co.kr/position/51397	other	f
1046	유니티 게임개발 과정 교강사(신입)	경일게임아이티아카데미	서울 강동구	신입~30년	["Unity"]	모집마감	https://jumpit.saramin.co.kr/position/49908	other	f
1047	QA/테스트 엔지니어(경력 3년 이상)	와이즈스톤티	서울 서초구	경력 3~9년	["QA", "Jira", "Mantis", "Redmine"]	모집마감	https://jumpit.saramin.co.kr/position/16538	other	f
1048	NPU Compiler Engineer	모빌린트	서울 강남구	신입~10년	["Python", "C++", "Linux", "DeepLearning", "c"]	모집마감	https://jumpit.saramin.co.kr/position/50329	other	f
1049	Robotics S/W Engineer [전문연구요원가능]	토르드라이브	서울 영등포구	경력 3~10년	["C", "C++", "CUDA"]	모집마감	https://jumpit.saramin.co.kr/position/50071	other	f
1051	[주4.5일] 네트워크 엔지니어 경력	에어키	서울 서초구	경력 5~15년	["Network", "Cisco", "TCP/IP", "VPN", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/48850	other	f
1052	M365 보안 및 인증 관리 담당자 (Team Leader/Manager)	콘센트릭스서비스코리아	서울 구로구	경력 2~10년	["Active Directory", "Microsoft Azure"]	모집마감	https://jumpit.saramin.co.kr/position/44166	other	f
1054	SAP SCM Manager	쏘카	서울 성동구	경력 2~5년	["ABAP", "SAP"]	모집마감	https://jumpit.saramin.co.kr/position/50474	other	f
1057	AWS 인프라 관련 설계/구축 경력직	클래스메소드코리아	서울 중구	경력 1~5년	["AWS", "Network"]	모집마감	https://jumpit.saramin.co.kr/position/3877	other	f
1066	[RE : IW] Server 신입 및 경력 채용	보이저	서울 구로구	신입~20년	["AZURE", "Unity", "ASP.NET", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/50653	other	f
1068	품질관리 보안솔루션 QA 담당자 모집	프라이빗테크놀로지	서울 마포구	경력 3~15년	["QA", "Windows", "Linux", "Network"]	모집마감	https://jumpit.saramin.co.kr/position/51324	other	f
1072	정보보호 인증 담당 모집	코닉글로리	서울 강남구	경력 3~10년	["Linux", "Network"]	모집마감	https://jumpit.saramin.co.kr/position/51089	other	f
1073	보안 솔루션 엔지니어 (경력)	위드네트웍스	서울 강서구	경력 1~5년	["Python"]	모집마감	https://jumpit.saramin.co.kr/position/50248	other	f
1075	[PJ_Youkai] Server 신입 및 경력 채용	보이저	서울 구로구	신입~20년	["SQL", "Redis", "C++", "NoSql", "AZURE"]	모집마감	https://jumpit.saramin.co.kr/position/50654	other	f
1076	데브옵스(DevOps) 엔지니어 (5년 이상)	씨드앤	서울 송파구	경력 5~10년	["Linux", "Kafka", "AWS", "AZURE", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/51274	other	f
1077	[RE : IW] 클라이언트 프로그래머	보이저	서울 구로구	신입~20년	["C++", "DirectX", "Redis", "Unity", "C#", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/50657	other	f
1080	시니어 클라이언트 프로그래머 채용	보이저	서울 구로구	경력 6~20년	["C++", "DirectX", "Redis", "Unity", "C#"]	모집마감	https://jumpit.saramin.co.kr/position/50655	other	f
1083	[PJ_Youkai] 네트워크 엔지니어 채용	보이저	서울 구로구	신입~20년	["SQL", "Redis", "C++", "NoSql", "AZURE"]	모집마감	https://jumpit.saramin.co.kr/position/50652	other	f
1085	[AI연구소] AI연구-Computer Vision AI	딥노이드	서울 구로구	신입	["PyTorch", "TensorFlow", "Docker", "Linux"]	모집마감	https://jumpit.saramin.co.kr/position/50130	other	f
1086	[DX사업본부] 서비스 기획자	딥노이드	서울 구로구	경력 3~10년	["Figma", "Microsoft Office 365", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/50132	other	f
1093	DBA 담당(1~3년)	엑심베이	서울 구로구	경력 1~3년	["MySQL", "Java", "Slack", "Linux", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/51400	other	f
1095	[ECS사업부문] 어플리케이션 아키텍트	플래티어	서울 송파구	경력 7~20년	["AWS", "AZURE", "Azure DevOps", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/49912	other	f
1096	[인공지능] 개발자 채용	아타드	서울 송파구, 부산 남구, 경기 성남시	경력 1~3년	["DeepLearning", "MachineLearning", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/50262	other	f
1099	기업부설연구소 HW 5년↓ 연구원 모집	오버컴테크	서울 금천구	신입~5년	["FPGA", "HW"]	모집마감	https://jumpit.saramin.co.kr/position/50508	other	f
1106	기업부설연구소 HW 10년↓ 연구원 모집	오버컴테크	서울 금천구	경력 5~10년	["FPGA", "HW"]	모집마감	https://jumpit.saramin.co.kr/position/50507	other	f
1107	GitLab 솔루션 엔지니어	플래티어	서울 송파구	경력 3~20년	["Jira", "Confluence", "Kubernetes"]	모집마감	https://jumpit.saramin.co.kr/position/49917	other	f
1108	Embedded SW 10년↑ 경력 연구원 모집	오버컴테크	서울 금천구	경력 10~20년	["FW", "RTOS", "Embedded"]	모집마감	https://jumpit.saramin.co.kr/position/50135	other	f
1109	Perception Engineer(자율주행 인지)	뷰런테크놀로지	서울 서초구	신입~10년	["C", "C++", "Python", "DeepLearning"]	모집마감	https://jumpit.saramin.co.kr/position/51450	other	f
1110	센서 칼리브레이션 엔지니어 채용	토르드라이브	서울 영등포구	경력 3~10년	["C++", "ROS", "Python", "OpenCV"]	모집마감	https://jumpit.saramin.co.kr/position/50068	other	f
1112	통합보안관리 엔지니어(경력)	이너버스	서울 영등포구	경력 3~7년	["SW", "Linux", "Docker", "Elasticsearch"]	모집마감	https://jumpit.saramin.co.kr/position/50497	other	f
1115	Quality Engineer(4~10년)	뷰런테크놀로지	서울 서초구	경력 4~10년	["Selenium", "Python", "QA", "Appium"]	모집마감	https://jumpit.saramin.co.kr/position/51453	other	f
1117	안드로이드 개발자(신입)	레트리카	서울 서초구	신입~2년	["Java", "RxJava", "OpenGL", "OpenCV"]	모집마감	https://jumpit.saramin.co.kr/position/51412	other	f
1121	System Engineer	뷰런테크놀로지	서울 서초구	신입~5년	["C", "C++", "Python", "GUI"]	모집마감	https://jumpit.saramin.co.kr/position/51449	other	f
1101	Deep Learning Engineer	뷰런테크놀로지	서울 서초구	신입~10년	["C", "C++", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/51454	other	f
1128	회로설계 (하드웨어 및 펌웨어) 개발자	누코드	서울 강남구	경력 2~5년	["Autocad", "Orcad", "Embedded"]	모집마감	https://jumpit.saramin.co.kr/position/50606	other	f
1133	LIS System 개발 및 운영	오픈헬스케어	서울 성동구	경력 5~15년	[".NET", "C#", "Java", "Nexacro", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/49998	other	f
1141	ITSM 구축 PM&PL 엔지니어	플래티어	서울 송파구	경력 5~20년	["Azure DevOps", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/49919	other	f
1145	언리얼 게임개발 과정 교강사(신입)	경일게임아이티아카데미	서울 강동구	신입~30년	["C++", "Unreal Engine"]	모집마감	https://jumpit.saramin.co.kr/position/49907	other	f
1150	유니티 게임개발 과정 교강사(경력)	경일게임아이티아카데미	서울 강동구	신입~30년	["Unity"]	모집마감	https://jumpit.saramin.co.kr/position/50614	other	f
1152	데브옵스 엔지니어	아이헤이트플라잉버그스	서울 영등포구	경력 3~10년	["AWS", "Kubernetes", "Terraform", "Kafka"]	모집마감	https://jumpit.saramin.co.kr/position/51245	other	f
1156	아틀라시안&데브옵스 솔루션 엔지니어	플래티어	서울 송파구	경력 3~10년	["Linux", "Windows", "MySQL", "Oracle", "Jira"]	모집마감	https://jumpit.saramin.co.kr/position/49916	other	f
1157	UI/UX 테스트 자동화 솔루션 엔지니어	플래티어	서울 송파구	경력 3~20년	["SAP", "Azure DevOps"]	모집마감	https://jumpit.saramin.co.kr/position/49920	other	f
1159	자율주행 하드웨어 전장 엔지니어	토르드라이브	서울 영등포구	경력 3~10년	["HW"]	모집마감	https://jumpit.saramin.co.kr/position/50791	other	f
1160	Field Application Engineer (HIL) 신입	디스페이스코리아	서울 서초구	신입	["MATLAB", "Python", "SW", "HW", "ethernet"]	모집마감	https://jumpit.saramin.co.kr/position/49929	other	f
1161	선행 연구 개발 (SW), 비전 장비 개발	엔클로니	서울 구로구	신입~5년	["C++", "C#", "SW", "CUDA"]	모집마감	https://jumpit.saramin.co.kr/position/50371	other	f
1162	QA/QC manager	아이브	서울 서초구	경력 10~15년	["QA", "HW", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/50625	other	f
1169	R&D 기술전략실 PM 채용	채비	서울 서초구	경력 7~20년	["SW"]	모집마감	https://jumpit.saramin.co.kr/position/50460	other	f
1172	LLM Research Engineer	옵트에이아이	서울 강서구	신입~10년	["MachineLearning", "DeepLearning", "FPGA"]	모집마감	https://jumpit.saramin.co.kr/position/50140	other	f
1175	RTOS F/W 개발 경력 모집	유니온바이오메트릭스	서울 송파구	경력 3~15년	["RTOS", "FW", "MCU", "Network", "C", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/50750	other	f
1176	Embedded Hardware Engineer (Senior)	웨어러블에이아이	서울 영등포구	경력 3~10년	["MCU", "PCB"]	모집마감	https://jumpit.saramin.co.kr/position/50373	other	f
1181	데브옵스 엔지니어	케이웨더	서울 구로구	신입~3년	["Docker", "Kubernetes", "CDNetworks"]	모집마감	https://jumpit.saramin.co.kr/position/50315	other	f
1186	기술개발 경력(SolutionEngineer)	엔클로니	서울 구로구	경력 4~10년	["C++", "C", "Embedded", "SW", "Solidworks"]	모집마감	https://jumpit.saramin.co.kr/position/51300	other	f
1187	의료기기 S/W 개발자(서울, 경력 3~6년)	프리시젼바이오	서울 서초구	경력 3~6년	["C"]	모집마감	https://jumpit.saramin.co.kr/position/51508	other	f
1188	Model Compression Research Engineer	옵트에이아이	서울 강서구	신입~10년	["MachineLearning", "DeepLearning", "FPGA"]	모집마감	https://jumpit.saramin.co.kr/position/50138	other	f
1189	[보안운영팀] 플랫폼 운영/개발 경력사원 채용	롯데이노베이트	서울 금천구	경력 5~7년	["Splunk", "ELK", "Linux", "Log4j"]	모집마감	https://jumpit.saramin.co.kr/position/51344	other	f
1190	SAP MM 운영(ABAP개발)경력	아이디에스앤트러스트	서울 강남구	경력 7~14년	["SAP", "ABAP", "ERP", "Oracle", "SQL", "DB2"]	모집마감	https://jumpit.saramin.co.kr/position/50235	other	f
1192	제어SW 엔지니어	아이브	서울 서초구	경력 1~5년	["Git", "C++", "C", "PLC", "MES", "TCP/IP"]	모집마감	https://jumpit.saramin.co.kr/position/50623	other	f
1194	인프라 경력사원 채용 (9년↑)	테크핀레이팅스	서울 중구	경력 9~20년	["Infra", "Linux", "HW", "SW", "DB"]	모집마감	https://jumpit.saramin.co.kr/position/51415	other	f
1196	선행연구 S/W 개발자(C언어) / 팀장	엔클로니	서울 구로구	경력 10~20년	["C++", "C", "Embedded Linux", "C#", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/50372	other	f
1198	기술개발 신입/경력(SolutionEngineer)	엔클로니	서울 구로구	신입~3년	["C++", "C", "Embedded", "SW", "Solidworks"]	모집마감	https://jumpit.saramin.co.kr/position/51299	other	f
1199	[SCK 및 관계사] Microsoft 프로젝트 및 기술지원	에쓰씨케이	서울 강남구	경력 5~15년	["Microsoft Teams", "Microsoft Office 365"]	모집마감	https://jumpit.saramin.co.kr/position/50702	other	f
1207	SW개발_Measurement파트 채용	알피니언메디칼시스템	서울 강서구	경력 2~15년	["Windows", "C++", "C", "Visual C++", "C#"]	모집마감	https://jumpit.saramin.co.kr/position/50052	other	f
1218	시스템 사업부 신입 엔지니어	이비즈테크	서울 마포구	신입	["Azure DevOps", "Azure DevOps Server"]	모집마감	https://jumpit.saramin.co.kr/position/50106	other	f
1223	클라우드 사업부 엔지니어	이비즈테크	서울 마포구	신입~3년	["Azure DevOps", "Azure DevOps Server"]	모집마감	https://jumpit.saramin.co.kr/position/50104	other	f
1234	정보보안 담당자 경력 채용	에프엘이에스	서울 강서구	경력 2~5년	["SecureCRT"]	모집마감	https://jumpit.saramin.co.kr/position/50720	other	f
1236	보안 솔루션 엔지니어 신입 채용	에프엘이에스	서울 강서구	신입	["Java", "Oracle", "SQL", "MariaDB", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/50579	other	f
1240	보안 솔루션 엔지니어 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["Java", "Oracle", "SQL", "MariaDB", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/50580	other	f
1243	의료영상 3차원 개발자 채용(1~3)	제이피아이헬스케어	서울 구로구	경력 1~3년	["C", "C#", "C++", "DeepLearning"]	모집마감	https://jumpit.saramin.co.kr/position/51063	other	f
1244	임베디드 개발자 신입 채용	에프엘이에스	서울 강서구	신입	["RTOS", "Python", "C++", "C", "HW", "FW"]	모집마감	https://jumpit.saramin.co.kr/position/50049	other	f
1245	임베디드 소프트웨어 개발자(7년↑)	엔엑스	서울 서초구	경력 7~10년	["C", "C#", "Embedded", "Linux", "FW", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/51395	other	f
1246	클라우드 엔지니어 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["AZURE", "GCP", "AWS", "DB", "BigData"]	모집마감	https://jumpit.saramin.co.kr/position/50582	other	f
1248	웹 풀스택 개발자 경력직 채용	세무법인프라이어	서울 강남구	경력 5~10년	["MySQL", "PostgreSQL", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50524	other	f
1249	펌웨어 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["C++", "VHDL", "Python", "MATLAB", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/49873	other	f
1250	웹 진단 모의해킹 (3~6년)	대진정보통신	서울 관악구	경력 3~6년	["Hack", "Azure Security Center", "ISMS"]	모집마감	https://jumpit.saramin.co.kr/position/49951	other	f
1251	하드웨어 개발자 신입 채용	에프엘이에스	서울 강서구	신입	["HW", "Embedded", "PCB", "ARM"]	모집마감	https://jumpit.saramin.co.kr/position/49878	other	f
1254	정보보안 담당자 신입 채용	에프엘이에스	서울 강서구	신입	["SecureCRT"]	모집마감	https://jumpit.saramin.co.kr/position/50719	other	f
1259	데이터 엔지니어 경력직 채용	에프엘이에스	서울 강서구	경력 2~6년	["MSSQL", "DB", "AWS", "PHP", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/50448	other	f
1260	클라우드 엔지니어 신입 채용	에프엘이에스	서울 강서구	신입	["AZURE", "GCP", "AWS", "DB", "BigData"]	모집마감	https://jumpit.saramin.co.kr/position/50581	other	f
1264	Document AI Researcher (병역특례)	애자일소다	서울 강남구	신입~5년	["Python", "TensorFlow", "PyTorch", "Docker"]	모집마감	https://jumpit.saramin.co.kr/position/49816	other	f
1265	[석사/경력]영상처리/rPPG 연구개발	바이오커넥트	서울 서초구	경력 1~10년	["OpenCV", "DeepLearning", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50384	other	f
1270	QA Engineer (경력 11년↑)	페이타랩	서울 강남구	경력 11~20년	["QA", "Jenkins"]	모집마감	https://jumpit.saramin.co.kr/position/50840	other	f
1275	AI 엔지니어(이미지 생성 AI 서비스)	바이스벌사	서울 서초구	경력 3~5년	["PyTorch", "TensorFlow", "AWS", "GCP"]	모집마감	https://jumpit.saramin.co.kr/position/50769	other	f
1277	QA Engineer (경력 1~5년↓)	페이타랩	서울 강남구	경력 1~5년	["QA", "Jenkins"]	모집마감	https://jumpit.saramin.co.kr/position/50837	other	f
1284	플랫폼 서비스 개발자 경력 채용	인공지능팩토리	서울 중구	경력 1~5년	["AWS", "GCP", "AZURE", "Cloud CMS", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/51206	other	f
1285	QA Engineer (경력 6~10년↓)	페이타랩	서울 강남구	경력 6~10년	["QA", "Jenkins"]	모집마감	https://jumpit.saramin.co.kr/position/50839	other	f
1286	웹 서비스 자바 개발자	비즈톡	서울 강남구	경력 5~10년	["REST API", "C++", "Linux", "Java", "C"]	모집마감	https://jumpit.saramin.co.kr/position/51057	other	f
1292	[이즈파크] PLM 프로젝트 PM	이즈파크	서울 금천구	경력 8~20년	["Java", "MSSQL", "Oracle"]	모집마감	https://jumpit.saramin.co.kr/position/20547	other	f
1297	Infra/시스템 아키텍처 (11~13년)	메타넷글로벌	서울 강남구	경력 11~13년	["Python", "MSA", "Kafka", "MariaDB"]	모집마감	https://jumpit.saramin.co.kr/position/50556	other	f
1298	시스템 엔지니어 채용	소프트넷	서울 강남구	경력 3~15년	["Windows Server", "Azure Synapse"]	모집마감	https://jumpit.saramin.co.kr/position/50761	other	f
1301	Infra/시스템 아키텍처 (4~7년)	메타넷글로벌	서울 강남구	경력 4~7년	["Python", "MSA", "Kafka", "MariaDB"]	모집마감	https://jumpit.saramin.co.kr/position/50554	other	f
1309	Infra/시스템 아키텍처 (8~10년)	메타넷글로벌	서울 강남구	경력 8~10년	["Python", "MSA", "Kafka", "MariaDB"]	모집마감	https://jumpit.saramin.co.kr/position/50555	other	f
1311	자율주행 경로생성 SW 엔지니어(전문연 지원 가능)	에이스웍스코리아	서울 강남구	경력 3~15년	["C++", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50696	other	f
1312	리눅스 개발	프라이빗테크놀로지	서울 마포구	경력 3~15년	["C++", "Linux", "Qt", "VPN", "C", "MVVM", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/50629	other	f
1313	프로덕트관리 및 개발PM 담당자	프라이빗테크놀로지	서울 마포구	경력 10~20년	["Jira", "Network", "Infra", "Insight", "ISMS"]	모집마감	https://jumpit.saramin.co.kr/position/50633	other	f
1314	[인공지능솔루션] ML Engineer	제논	서울 강남구	경력 3~20년	["Docker", "PyTorch", "Kubernetes"]	모집마감	https://jumpit.saramin.co.kr/position/50938	other	f
1316	Software QA Manager	에이아이트릭스	서울 강남구	경력 3~8년	["Apache JMeter", "Postman", "Playwright"]	모집마감	https://jumpit.saramin.co.kr/position/51317	other	f
1318	TA(Technical Architect)/DBA	메타넷글로벌	서울 강남구	경력 10~16년	["Oracle", "ERP", "Tibero"]	모집마감	https://jumpit.saramin.co.kr/position/50553	other	f
1320	QA Engineer (3년 이상)	올거나이즈코리아	서울 강남구	경력 3~10년	["QA", "Python", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/51371	other	f
1324	Infra 엔지니어 (3~5년)	메타넷글로벌	서울 강남구	경력 3~5년	["Python", "MSA", "Kafka", "MariaDB"]	모집마감	https://jumpit.saramin.co.kr/position/50557	other	f
1326	보안 소프트웨어 설치 및 기술지원	프라이빗테크놀로지	서울 마포구	경력 5~10년	["SW", "CISSP", "CISA", "VPN", "Infra"]	모집마감	https://jumpit.saramin.co.kr/position/50346	other	f
1329	C/C++개발(3년~6년)	위즈코리아	서울 강서구	경력 3~6년	["Linux", "C", "C++", "C#", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/51116	other	f
1330	[TADA] Infra/DevOps engineer 채용	이지식스(엠블)	서울 강남구	경력 3~8년	["AWS", "Kubernetes", "Infra"]	모집마감	https://jumpit.saramin.co.kr/position/51301	other	f
1331	기술지원 담당자 모집	프라이빗테크놀로지	서울 마포구	경력 5~15년	["QA", "SW", "Infra", "VPN", "Network", "CISSP"]	모집마감	https://jumpit.saramin.co.kr/position/51345	other	f
1334	생성형 AI/LLM 엔지니어	바이스벌사	서울 서초구	경력 3~5년	["PyTorch", "TensorFlow", "AWS", "GCP"]	모집마감	https://jumpit.saramin.co.kr/position/50767	other	f
1337	리눅스 네트워크 프로그래머	노아시스템즈	서울 성동구	경력 5~10년	["Linux", "Utm", "C", "TCP/IP", "Git", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/49638	other	f
1338	Windows 커널 드라이버 개발	프라이빗테크놀로지	서울 마포구	경력 7~20년	["Windows", "C", "C++", "Network", "Mfc"]	모집마감	https://jumpit.saramin.co.kr/position/49926	other	f
1340	Infra 엔지니어 (9~15년)	메타넷글로벌	서울 강남구	경력 9~15년	["Python", "MSA", "Kafka", "MariaDB"]	모집마감	https://jumpit.saramin.co.kr/position/50559	other	f
1341	아틀라시안 개발	오픈소스컨설팅	서울 강남구	경력 3~12년	["Java", "Confluence", "Jira", "Trello"]	모집마감	https://jumpit.saramin.co.kr/position/49975	other	f
1342	보안관제 개발	프라이빗테크놀로지	서울 마포구	경력 3~20년	["Network", "Infra", "Python", "DB", "ELK"]	모집마감	https://jumpit.saramin.co.kr/position/50634	other	f
1346	Infra 엔지니어 (6~8년)	메타넷글로벌	서울 강남구	경력 6~8년	["Python", "MSA", "Kafka", "MariaDB"]	모집마감	https://jumpit.saramin.co.kr/position/50558	other	f
1347	HW개발자(3년 이상)	럭스로보	서울 서초구	경력 3~12년	["PCB"]	모집마감	https://jumpit.saramin.co.kr/position/51149	other	f
1350	기술지원부장(기술지원팀 및 QA/QC팀 총괄 관리)	프라이빗테크놀로지	서울 마포구	경력 10~20년	["QA", "SW", "CISSP"]	모집마감	https://jumpit.saramin.co.kr/position/51476	other	f
1351	QA 엔지니어	바로팜	서울 강남구	경력 5~12년	["QA", "Notion", "Jira", "Slack", "Confluence"]	모집마감	https://jumpit.saramin.co.kr/position/51568	other	f
1353	Zadara 솔루션 아키텍트	이비즈테크	서울 마포구	경력 5~10년	["vmware", "Linux", "AWS", "Amazon MQ"]	모집마감	https://jumpit.saramin.co.kr/position/51253	other	f
1354	AOP 엔지니어링_UE파트 연구원 채용	알피니언메디칼시스템	서울 강서구	신입~10년	["MATLAB", "Python", "labview", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/50054	other	f
1357	써머스플랫폼 서비스기획자 (신입)	커넥트웨이브	서울 금천구	신입	["Microsoft Excel"]	모집마감	https://jumpit.saramin.co.kr/position/50853	other	f
1365	[석사/신입]영상처리/rPPG 연구개발	바이오커넥트	서울 서초구	신입	["OpenCV", "DeepLearning", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50383	other	f
1371	언리얼 엔지니어 채용	인피닉	서울 금천구	경력 1~5년	["C++", "VR", "AR", "AWS", "AZURE"]	모집마감	https://jumpit.saramin.co.kr/position/50465	other	f
1373	수원) SW 테스트 엔지니어(QA) (4~8년)	인피닉	서울 금천구	경력 4~8년	["QA", "Python", "C", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/50463	other	f
1376	[CC CTO] Dev&AI Ops	커넥트웨이브	서울 금천구	경력 3~15년	["Kubernetes", "Docker", "Kafka", "Hadoop"]	모집마감	https://jumpit.saramin.co.kr/position/50859	other	f
1378	[강남/선릉] 소프트웨어 개발 경력	에스디티	서울 강남구	경력 5~10년	["C", "C++", "C#", "Linux", "Windows", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/51195	other	f
1379	정보보안(운영)	미디어로그	서울 마포구	경력 2~10년	["ISMS", "CPPG"]	모집마감	https://jumpit.saramin.co.kr/position/51563	other	f
1380	풀스택 개발자 중급 0명 채용	퓨처플랫폼	서울 강서구	경력 5~10년	["Java", "JSP", "REST API", "Apache Tomcat"]	모집마감	https://jumpit.saramin.co.kr/position/49807	other	f
1381	S/W Engineer-SLAM [전문연구요원가능]	토르드라이브	서울 영등포구	경력 3~10년	["C++", "ROS", "Linux", "Docker", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/50069	other	f
1383	써머스플랫폼 서비스기획자 (경력3~10)	커넥트웨이브	서울 금천구	경력 3~10년	["Microsoft Excel"]	모집마감	https://jumpit.saramin.co.kr/position/50852	other	f
1386	데이터 사이언티스트	진스토리코리아	서울 금천구	신입~3년	["TensorFlow", "Python", "AWS", "PyTorch"]	모집마감	https://jumpit.saramin.co.kr/position/23549	other	f
1389	Field Engineer	뷰런테크놀로지	서울 서초구	경력 1~10년	["Python", "MATLAB"]	모집마감	https://jumpit.saramin.co.kr/position/51452	other	f
1390	AI 인프라, AI Ops 환경 구성	디에스앤지	서울 영등포구	경력 6~20년	["AI/인공지능", "CUDA", "DeepLearning"]	모집마감	https://jumpit.saramin.co.kr/position/51408	other	f
1395	철도 시뮬레이터 SW 엔진 개발자	이노시뮬레이션	서울 강서구	경력 2~7년	["C++", "C#"]	모집마감	https://jumpit.saramin.co.kr/position/51095	other	f
1396	[강남/선릉] DX 하드웨어 개발 경력	에스디티	서울 강남구	경력 2~10년	["MCU"]	모집마감	https://jumpit.saramin.co.kr/position/51194	other	f
1397	풀스택 개발자 PM급 채용	퓨처플랫폼	서울 강서구	경력 5~10년	["Java", "JSP", "REST API", "Apache Tomcat"]	모집마감	https://jumpit.saramin.co.kr/position/49803	other	f
1400	S/W Engineer [전문연구요원가능]	토르드라이브	서울 영등포구	경력 3~10년	["C", "C++", "CUDA"]	모집마감	https://jumpit.saramin.co.kr/position/50082	other	f
1403	Field Application Engineer (HIL) 경력	디스페이스코리아	서울 서초구	경력 3~10년	["MATLAB", "Python", "SW", "HW", "ethernet"]	모집마감	https://jumpit.saramin.co.kr/position/49930	other	f
1404	수원) SW 테스트 엔지니어(QA) (1~3년)	인피닉	서울 금천구	경력 1~3년	["QA", "Python", "C", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/50459	other	f
1405	윈도우기반 응용프로그래머 개발자 모집	시와소프트	서울 금천구	경력 2~10년	["c#", "wpf", ".net", "rpa"]	모집마감	https://jumpit.saramin.co.kr/position/15072	other	f
1407	DBA 경력 직원 채용 (20년 이상)	엘아이지시스템	서울 용산구	경력 20~21년	["SQL", "Azure SQL Database", "DB"]	모집마감	https://jumpit.saramin.co.kr/position/50294	other	f
1410	LG에너지솔루션 개발프로젝트[1~7년]	에이핀테크놀러지	서울 구로구	경력 1~7년	["C#", "MSSQL", "Oracle", "DB", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/50185	other	f
1411	DBA 경력 직원 채용 (13~15년)	엘아이지시스템	서울 용산구	경력 13~15년	["SQL", "Azure SQL Database", "DB"]	모집마감	https://jumpit.saramin.co.kr/position/50292	other	f
1416	QA Engineer	쓰리아이	서울 강남구	경력 3~20년	["Jira", "Redmine", "HW", "SW", "QA"]	모집마감	https://jumpit.saramin.co.kr/position/51133	other	f
1419	Technical Artist 채용	보이저	서울 구로구	경력 3~15년	["Unreal Engine", "Python", "Unity"]	모집마감	https://jumpit.saramin.co.kr/position/50651	other	f
1423	개발 및 플랫폼 기획	프라이빗테크놀로지	서울 마포구	경력 7~20년	["Network", "Infra", "Flow", "QA", "TCP/IP"]	모집마감	https://jumpit.saramin.co.kr/position/51475	other	f
1425	WEBFRONT-K 웹보안기능 / 시그니처개발	파이오링크	서울 금천구	경력 3~13년	["C", "C++", "Python", "Linux", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/51122	other	f
1427	카카오톡 상담톡/챗봇 서비스 개발자	비즈톡	서울 강남구	경력 5~10년	["C++", "C"]	모집마감	https://jumpit.saramin.co.kr/position/51055	other	f
1428	Solution Engineer	에이아이트릭스	서울 강남구	신입~7년	["Git", "Linux", "Python", "Docker Compose"]	모집마감	https://jumpit.saramin.co.kr/position/51315	other	f
1429	DevOps/MLOps Engineer (7~10년)	웨어러블에이아이	서울 영등포구	경력 7~10년	["AWS", "Linux", "Docker", "Kubernetes"]	모집마감	https://jumpit.saramin.co.kr/position/50374	other	f
1430	클라이언트 프로그래머 채용	보이저	서울 구로구	경력 7~20년	["C++", "DirectX", "Redis", "Unreal Engine"]	모집마감	https://jumpit.saramin.co.kr/position/50650	other	f
1431	네트워크 개발	프라이빗테크놀로지	서울 마포구	경력 3~10년	["C", "C++", "TCP/IP", "Linux", "VPN", "FW"]	모집마감	https://jumpit.saramin.co.kr/position/50631	other	f
1433	[하나금융그룹 자회사] DBA (7년이상)	핀크	서울 중구	경력 7~10년	["MariaDB", "MySQL", "MaxScale"]	모집마감	https://jumpit.saramin.co.kr/position/51606	other	f
1434	[하나금융그룹 자회사] DBA (3년이상)	핀크	서울 중구	경력 3~6년	["MariaDB", "MaxScale", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/51605	other	f
1438	3D 엔진개발 [메타개발팀] 신입	상화	서울 강남구	신입~2년	["Unity", "Unreal Engine", "3D Rendering"]	모집마감	https://jumpit.saramin.co.kr/position/51570	other	f
1439	3D 엔진개발 [메타개발팀] 리드급	상화	서울 강남구	경력 9~10년	["Unity", "Unreal Engine", "3D Rendering"]	모집마감	https://jumpit.saramin.co.kr/position/51559	other	f
1441	필드 엔지니어	오리온디스플레이	서울 금천구	신입~3년	["Autocad", "Fusion 360", "HW"]	모집마감	https://jumpit.saramin.co.kr/position/50125	other	f
1445	CA/RA 개발자 신입 모집	한국전자인증	서울 서초구	신입	["Linux", "C++", "C", "Java", "AWS", "Eclipse"]	모집마감	https://jumpit.saramin.co.kr/position/51577	other	f
1446	LG에너지솔루션 개발프로젝트[15~20년]	에이핀테크놀러지	서울 구로구	경력 15~20년	["C#", "MSSQL", "Oracle", "DB", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/50187	other	f
1447	DB 엔지니어(16-20년)	와탭랩스	서울 서초구	경력 16~20년	["SQL", "Oracle", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/51600	other	f
1448	LG에너지솔루션 개발프로젝트[8~14년]	에이핀테크놀러지	서울 구로구	경력 8~14년	["C#", "MSSQL", "Oracle", "DB", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/50186	other	f
1449	iPaaS 프로젝트 매니저 PM	메이븐클라우드서비스	서울 강남구	경력 5~30년	["Microsoft PowerApps"]	모집마감	https://jumpit.saramin.co.kr/position/51024	other	f
1450	데브옵스 엔지니어(5-8년)	와탭랩스	서울 서초구	경력 5~8년	["AWS", "AZURE", "GCP", "Java", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/51596	other	f
1451	클라우드 모니터링 솔루션운영 및 유지보수	웅진	서울 중구	경력 5~13년	["Java", "Kubernetes", "JSP"]	모집마감	https://jumpit.saramin.co.kr/position/49905	other	f
1454	로우코드 웹 기반 시스템 개발/설계	웅진	서울 중구	경력 10~18년	["Java", "NoCodeAPI", "LowCodeEngine"]	모집마감	https://jumpit.saramin.co.kr/position/49900	other	f
1457	데스크탑 앱 개발자	클레	서울 성동구	신입	["Python", "C++", ".NET", "OpenGL", "C#", "Qt"]	모집마감	https://jumpit.saramin.co.kr/position/51070	other	f
1461	RPA(업무자동화) Developer	웅진	서울 중구	경력 3~13년	["RPA", "Microsoft Power Automate"]	모집마감	https://jumpit.saramin.co.kr/position/49991	other	f
1462	자율주행차량 제어 시스템 엔지니어	토르드라이브	서울 영등포구	경력 3~10년	["C++", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/51343	other	f
1463	Camera Sensor Engineer	모빌린트	서울 강남구	경력 3~5년	["Linux"]	모집마감	https://jumpit.saramin.co.kr/position/50196	other	f
1464	네트워크 엔지니어 채용	필라넷	서울 강남구	경력 3~15년	["Network", "Cisco"]	모집마감	https://jumpit.saramin.co.kr/position/51323	other	f
1467	Perception Engineer(Tech Lead)	뷰런테크놀로지	서울 서초구	경력 5~10년	["C", "C++", "Python", "DeepLearning"]	모집마감	https://jumpit.saramin.co.kr/position/51455	other	f
1469	SAP MM 운영 및 개발자	브이엔티지	서울 마포구	경력 5~15년	["ABAP", "ERP", "SAP"]	모집마감	https://jumpit.saramin.co.kr/position/51549	other	f
1470	S/W Engineer-Perception [전문연구요원가능]	토르드라이브	서울 영등포구	경력 3~10년	["C", "C++", "CUDA"]	모집마감	https://jumpit.saramin.co.kr/position/50073	other	f
1471	H/W System Design Engineer(Senior)	모빌린트	서울 강남구	경력 8~12년	["PCB"]	모집마감	https://jumpit.saramin.co.kr/position/50335	other	f
1472	의료 AI 제품 패키징 파이썬 개발자	딥노이드	서울 구로구	경력 5~10년	["Python", "Docker", "Linux", "Shell", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/50137	other	f
1473	시스템 엔지니어 경력 채용	디에스앤지	서울 영등포구	경력 7~15년	["Ubuntu", "Linux", "Kubernetes", "Docker"]	모집마감	https://jumpit.saramin.co.kr/position/51407	other	f
1474	SAP BC 운영 및 개발자 (4년 이상)	브이엔티지	서울 마포구	경력 4~10년	["ABAP", "ERP", "SAP"]	모집마감	https://jumpit.saramin.co.kr/position/51548	other	f
1475	H/W System Design Engineer(Junior)	모빌린트	서울 강남구	경력 3~5년	["PCB", "HW", "Orcad"]	모집마감	https://jumpit.saramin.co.kr/position/50451	other	f
1476	Simulation S/W Engineer [전문연구요원가능]	토르드라이브	서울 영등포구	경력 3~10년	["C", "C++", "CUDA"]	모집마감	https://jumpit.saramin.co.kr/position/50070	other	f
1477	DevOps 엔지니어 [전문연구요원가능]	토르드라이브	서울 영등포구	경력 3~10년	["C", "C++", "CUDA", "Kubernetes"]	모집마감	https://jumpit.saramin.co.kr/position/50075	other	f
1479	[급구] AD/ADFS 운영 가능한 Windows 엔지니어 모집	필라넷	서울 중구	경력 3~10년	["Active Directory", "Windows Server"]	모집마감	https://jumpit.saramin.co.kr/position/51603	other	f
1481	.NET 웹 개발 경력 채용	필라넷	서울 강남구	경력 3~7년	["Windows", "ASP.NET", "Classic ASP"]	모집마감	https://jumpit.saramin.co.kr/position/51614	other	f
1485	Microsoft Power Platform Developer	웅진	서울 중구	경력 3~20년	["Microsoft Azure", "Microsoft PowerApps"]	모집마감	https://jumpit.saramin.co.kr/position/49899	other	f
1486	MS Power Platform Project Leader	웅진	서울 중구	경력 10~20년	["Microsoft Azure", "Microsoft PowerApps"]	모집마감	https://jumpit.saramin.co.kr/position/49990	other	f
1491	임베디드 소프트웨어 (센서 통합)	니어스랩	서울 송파구	경력 3~10년	["C", "C++", "Embedded", "Embedded Linux"]	모집마감	https://jumpit.saramin.co.kr/position/50686	other	f
1492	SAP FCM/SCM/EWM 모듈개발자	웅진	서울 중구	경력 3~13년	["SAP", "ABAP"]	모집마감	https://jumpit.saramin.co.kr/position/49986	other	f
1495	대외 SAP ERP 모듈 유지보수	웅진	서울 중구	경력 3~13년	["ABAP", "SAP"]	모집마감	https://jumpit.saramin.co.kr/position/49903	other	f
1497	임베디드 소프트웨어_카메라&통신 모듈	니어스랩	서울 송파구	경력 3~10년	["C", "C++", "Embedded", "Embedded Linux"]	모집마감	https://jumpit.saramin.co.kr/position/50685	other	f
1498	[SCK 및 관계사] Microsoft 제품교육 및 기술지원	에쓰씨케이	서울 강남구	경력 4~10년	["Microsoft Office 365", "SW", "AWS Copilot"]	모집마감	https://jumpit.saramin.co.kr/position/50583	other	f
2073	비행선 제어 SW/HW 개발	이카루스	광주 북구	신입	["C++"]	모집마감	https://jumpit.saramin.co.kr/position/51322	other	f
1500	3차원 카메라 하드웨어 개발자(5~7)	클레	서울 성동구	경력 5~7년	["PCB", "Orcad"]	모집마감	https://jumpit.saramin.co.kr/position/51072	other	f
1503	SAP Public Cloud 컨설턴트	웅진	서울 중구	경력 12~25년	["SAP", "ERP"]	모집마감	https://jumpit.saramin.co.kr/position/49984	other	f
1504	이리온 로봇 자율주행 SW 개발(서울)	폴라리스쓰리디	서울 용산구	경력 2~7년	["SW", "C++", "Linux", "Git", "Notion"]	모집마감	https://jumpit.saramin.co.kr/position/50893	other	f
1505	3차원 카메라 하드웨어 개발자(8~10)	클레	서울 성동구	경력 8~10년	["PCB", "Orcad"]	모집마감	https://jumpit.saramin.co.kr/position/51073	other	f
1507	플랫폼 개발자 채용공고	프로덕션고금	서울 영등포구	신입	["Python", "Solidity", "AWS", "AZURE"]	모집마감	https://jumpit.saramin.co.kr/position/49830	other	f
1509	인프라 담당자 채용	영원아웃도어	서울 중구, 경기 성남시	경력 5~10년	["Infra", "Network", "Linux", "Windows", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/51379	other	f
1517	임베디드 소프트웨어 개발자(IoT SaaS)	카르노플릿	서울 서초구, 경기 안양시	경력 5~10년	["MCU", "AWS", "MQTT", "C", "C++", "FW"]	모집마감	https://jumpit.saramin.co.kr/position/50123	other	f
1521	IT Team Leader 채용	영원아웃도어	서울 중구, 경기 성남시	경력 10~20년	["Oracle", "Linux", "Windows", "Network"]	모집마감	https://jumpit.saramin.co.kr/position/51386	other	f
1524	데브옵스 엔지니어(9-12년)	와탭랩스	서울 서초구	경력 9~12년	["AWS", "AZURE", "GCP", "Java", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/51597	other	f
1525	클라우드 네이티브 플랫폼 엔지니어(K8S)	미리비트	서울 서초구	경력 5~15년	["Kubernetes", "BigData", "Spark", "Minio"]	모집마감	https://jumpit.saramin.co.kr/position/51569	other	f
1526	임베디드 소프트웨어 개발(10~13년)	비알랩	서울 강남구	경력 10~13년	["Embedded", "Embedded Linux", "ARM", "C"]	모집마감	https://jumpit.saramin.co.kr/position/51425	other	f
1527	빅데이터 엔지니어링	미리비트	서울 서초구, 경기 성남시, 경기 이천시	경력 5~15년	["Kubernetes", "Spark", "Apache Flink"]	모집마감	https://jumpit.saramin.co.kr/position/51564	other	f
1528	CA/RA 개발자 경력 모집	한국전자인증	서울 서초구	경력 7~10년	["Linux", "C++", "C", "Java", "AWS", "Eclipse"]	모집마감	https://jumpit.saramin.co.kr/position/51576	other	f
1529	Hardware Product Manager	쓰리아이	서울 강남구	경력 5~20년	["HW", "PCB"]	모집마감	https://jumpit.saramin.co.kr/position/51134	other	f
1530	임베디드 소프트웨어 개발(7~9년)	비알랩	서울 강남구	경력 7~9년	["Embedded", "Embedded Linux", "ARM", "C"]	모집마감	https://jumpit.saramin.co.kr/position/51424	other	f
1532	DB 엔지니어(5-10년)	와탭랩스	서울 서초구	경력 5~10년	["SQL", "Oracle", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/51598	other	f
1534	데이터서비스 운영SM	티사이언티픽	서울 동작구	경력 7~15년	["AWS", "Linux", "Kubernetes"]	모집마감	https://jumpit.saramin.co.kr/position/51292	other	f
1535	DB 엔지니어(11-15년)	와탭랩스	서울 서초구	경력 11~15년	["SQL", "Oracle", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/51599	other	f
1537	QA 테스터 모집(3년~5년/계약직)	위버스브레인	서울 구로구	경력 3~5년	["QA"]	모집마감	https://jumpit.saramin.co.kr/position/50728	other	f
1538	정보보호 담당자 채용	영원아웃도어	서울 중구, 경기 성남시	경력 5~10년	["ISMS", "Linux", "Windows", "Firewall", "VPN"]	모집마감	https://jumpit.saramin.co.kr/position/51378	other	f
1539	HW개발_아날로그/파워 책임급 채용	알피니언메디칼시스템	서울 강서구	경력 8~13년	["HW", "PCB"]	모집마감	https://jumpit.saramin.co.kr/position/50051	other	f
1540	DBA 경력 직원 채용 (16~19년)	엘아이지시스템	서울 용산구	경력 16~19년	["SQL", "Azure SQL Database", "DB"]	모집마감	https://jumpit.saramin.co.kr/position/50293	other	f
1543	웹 진단 모의해킹 (7~10년)	대진정보통신	서울 관악구	경력 7~10년	["Hack", "Azure Security Center", "ISMS"]	모집마감	https://jumpit.saramin.co.kr/position/49953	other	f
1544	전산실 SAP SD 운영 채용(경력 7~10년)	벨아이앤에스	서울 서대문구	경력 7~10년	["ABAP", "SQL", "SAP"]	모집마감	https://jumpit.saramin.co.kr/position/50424	other	f
1545	QA 테스터 모집(6년~10년/계약직)	위버스브레인	서울 구로구	경력 6~10년	["QA"]	모집마감	https://jumpit.saramin.co.kr/position/50729	other	f
1547	서비스 기획자 (PM, PO)	이노소니언	서울 서초구	경력 5~20년	["Jira", "Notion", "AWS", "Git", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/51335	other	f
1549	쇼핑몰어드민PHP개발자 경력(10년이상)	텐빌리언	서울 구로구	경력 10~15년	["Git", "AWS", "PHP"]	모집마감	https://jumpit.saramin.co.kr/position/50927	other	f
1550	TA 모집(경력1~3년)	데이터누리	서울 강서구	경력 1~3년	["Linux", "MSA", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/51238	other	f
1556	PRM(Web POS)/BI Web개발자 채용	영원아웃도어	서울 중구, 경기 성남시	경력 5~10년	["Linux", "Oracle", "Java", "JSP", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/51383	other	f
1560	의료영상 3차원 개발자 채용(7~9)	제이피아이헬스케어	서울 구로구	경력 7~9년	["C", "C#", "C++", "DeepLearning"]	모집마감	https://jumpit.saramin.co.kr/position/51065	other	f
1562	클라우드 엔지니어 경력 채용(6년~8년)	디지털포토	서울 서초구	경력 6~8년	["CentOS", "Linux", "Apache HTTP Server"]	모집마감	https://jumpit.saramin.co.kr/position/51008	other	f
1563	TA 모집(경력4~6년)	데이터누리	서울 강서구	경력 4~6년	["Linux", "MSA", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/51239	other	f
1564	TA 모집(경력7~10년)	데이터누리	서울 강서구	경력 7~10년	["Linux", "MSA", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/51237	other	f
1565	WMS Web 개발자 채용	영원아웃도어	서울 중구, 경기 성남시	경력 5~10년	["Linux", "Oracle", "Java", "JSP", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/51382	other	f
1568	쇼핑몰 어드민 PHP개발자 경력(2~5년)	텐빌리언	서울 구로구	경력 2~5년	["Git", "AWS", "PHP"]	모집마감	https://jumpit.saramin.co.kr/position/50929	other	f
1570	전산실 SAP SD 운영 채용 (경력 3~6년)	벨아이앤에스	서울 서대문구	경력 3~6년	["ABAP", "SQL", "SAP"]	모집마감	https://jumpit.saramin.co.kr/position/50423	other	f
1571	쇼핑몰 어드민 PHP개발자 경력(6~9년)	텐빌리언	서울 구로구	경력 6~9년	["Git", "AWS", "PHP"]	모집마감	https://jumpit.saramin.co.kr/position/50928	other	f
1573	Python/Java 개발(경력5~7)	데이터누리	서울 강서구	경력 5~7년	["Linux", "MSA", "Python", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/51244	other	f
1574	네트워크 엔지니어 경력(2~5년)	텐빌리언	서울 구로구	경력 2~5년	["Network"]	모집마감	https://jumpit.saramin.co.kr/position/50246	other	f
1575	Python/Java 개발(경력8~10)	데이터누리	서울 강서구	경력 8~10년	["Linux", "MSA", "Python", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/51243	other	f
1577	네트워크 엔지니어 경력(10년이상)	텐빌리언	서울 구로구	경력 10~15년	["Network"]	모집마감	https://jumpit.saramin.co.kr/position/50250	other	f
1578	클라우드 엔지니어 경력 채용(3년~5년)	디지털포토	서울 서초구	경력 3~5년	["CentOS", "Linux", "Apache HTTP Server"]	모집마감	https://jumpit.saramin.co.kr/position/51007	other	f
1583	SAP LE/MM/PP모듈 유지보수 경력	웅진	서울 중구	경력 5~13년	["SAP", "ABAP"]	모집마감	https://jumpit.saramin.co.kr/position/49985	other	f
1585	3D Geometry SW Engineer 경력 채용	디오에프	서울 성동구	경력 1~15년	["SW", "C++", "3D Rendering"]	모집마감	https://jumpit.saramin.co.kr/position/51141	other	f
1587	Application SW Engineer 경력 채용	디오에프	서울 성동구	경력 3~15년	["SW", "C++", "Qt", "Mfc", "OpenGL"]	모집마감	https://jumpit.saramin.co.kr/position/51142	other	f
1588	[DOF] HW Linux App 엔지니어 채용	디오에프	서울 성동구	경력 3~7년	["Linux"]	모집마감	https://jumpit.saramin.co.kr/position/51146	other	f
1590	의료기기 S/W 개발자(서울, 경력 7~10년)	프리시젼바이오	서울 서초구	경력 7~10년	["C"]	모집마감	https://jumpit.saramin.co.kr/position/51509	other	f
1591	DE (5년↑)	테크핀레이팅스	서울 중구	경력 5~15년	["DB", "SQL", "Python", "PostgreSQL", "Oracle"]	모집마감	https://jumpit.saramin.co.kr/position/51416	other	f
1592	SAP ERP(S/4HANA컨설턴트)	웅진	서울 중구	경력 7~20년	["SAP", "ERP", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/49904	other	f
1593	ERP컨설턴트(SAP B1/MS D365) 채용	웅진	서울 중구	경력 3~25년	["SAP", "ERP", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/50020	other	f
1594	데이터 엔지니어(5년 이상)	이노케어플러스	서울 서초구	경력 5~10년	["Python", "SQL", "Scala", "AWS Glue"]	모집마감	https://jumpit.saramin.co.kr/position/51607	other	f
1595	네트워크 엔지니어 경력(6~9년)	텐빌리언	서울 구로구	경력 6~9년	["Network"]	모집마감	https://jumpit.saramin.co.kr/position/50249	other	f
1596	SAP SD 모듈 담당자 채용	영원아웃도어	서울 중구, 경기 성남시	경력 5~10년	["SAP", "Microsoft Excel"]	모집마감	https://jumpit.saramin.co.kr/position/51375	other	f
1598	PIA자격 필수/개인정보보호컨설팅(1~5)	대진정보통신	서울 관악구	경력 1~5년	["ISMS", "CPPG"]	모집마감	https://jumpit.saramin.co.kr/position/49950	other	f
1599	FPGA개발 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["FPGA", "C", "C++", "Cisco ISE"]	모집마감	https://jumpit.saramin.co.kr/position/50586	other	f
1600	하드웨어 개발자 경력 채용	에프엘이에스	서울 강서구	경력 2~5년	["HW", "Embedded", "PCB", "ARM"]	모집마감	https://jumpit.saramin.co.kr/position/49879	other	f
1601	Linux OS 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~6년	["Linux", "Embedded", "SW", "Docker", "Yocto"]	모집마감	https://jumpit.saramin.co.kr/position/50718	other	f
1602	SAP CO 모듈 담당자 채용	영원아웃도어	서울 중구, 경기 성남시	경력 5~10년	["SAP", "Microsoft Excel"]	모집마감	https://jumpit.saramin.co.kr/position/51377	other	f
1605	의료영상 3차원 개발자 채용(4~6)	제이피아이헬스케어	서울 구로구	경력 4~6년	["C", "C#", "C++", "DeepLearning"]	모집마감	https://jumpit.saramin.co.kr/position/51064	other	f
1606	SAP MM 모듈 담당자 채용	영원아웃도어	서울 중구, 경기 성남시	경력 5~10년	["SAP", "Microsoft Excel"]	모집마감	https://jumpit.saramin.co.kr/position/51374	other	f
1607	DX/AX 채용	영원아웃도어	서울 중구, 경기 성남시	경력 5~10년	["Oracle", "MySQL", "MariaDB"]	모집마감	https://jumpit.saramin.co.kr/position/51384	other	f
1608	연구소 소프트웨어 개발자 채용(5~7년)	이노카	서울 구로구	경력 5~7년	["C", "C++", "Linux", "MCU", "Libraries.io"]	모집마감	https://jumpit.saramin.co.kr/position/51550	other	f
1609	임베디드 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["RTOS", "Python", "C++", "C", "HW", "FW"]	모집마감	https://jumpit.saramin.co.kr/position/50050	other	f
1611	PIA자격 필수/개인정보보호컨설팅(6~10)	대진정보통신	서울 관악구	경력 6~10년	["ISMS", "CPPG"]	모집마감	https://jumpit.saramin.co.kr/position/49952	other	f
1612	연구소 소프트웨어 개발자 채용(8년~)	이노카	서울 구로구	경력 8~10년	["C", "C++", "Linux", "MCU", "Libraries.io"]	모집마감	https://jumpit.saramin.co.kr/position/51553	other	f
1614	SAP FI 모듈 담당자 채용	영원아웃도어	서울 중구, 경기 성남시	경력 5~10년	["SAP", "Microsoft Excel"]	모집마감	https://jumpit.saramin.co.kr/position/51376	other	f
1616	임베디드 소프트웨어 개발자(4년↑)	엔엑스	서울 서초구	경력 4~6년	["C", "C#", "Embedded", "Linux", "FW", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/51618	other	f
1617	임베디드 소프트웨어 개발자(11년↑)	엔엑스	서울 서초구	경력 11~15년	["C", "C#", "Embedded", "Linux", "FW", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/51617	other	f
1619	Data Engineer(Knowledge Engineering)	에스투더블유	경기 성남시	경력 1~5년	["Docker", "Hadoop", "Kubeflow", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/50641	other	f
1620	Data Engineer (상주 인턴)	에스투더블유	경기 성남시	신입	["Docker", "Hadoop", "Kubeflow", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/50640	other	f
1623	.Net, C# Application Developer (Junior 가능)	우리엔	경기 화성시	경력 4~10년	["C++", "Windows", "Delphi", "SQL", "C#"]	모집마감	https://jumpit.saramin.co.kr/position/49858	other	f
1629	환경 에너지 플랫폼 AI 엔지니어	에이알티플러스	경기 이천시	경력 5~10년	["BigData", "AI/인공지능", "Docker", "Hadoop"]	모집마감	https://jumpit.saramin.co.kr/position/50683	other	f
1630	Digital Logic 개발/분당R&D	아이디어스투실리콘	경기 성남시	경력 3~15년	["Verilog", "C", "C++", "C#", "Python", "VHDL"]	모집마감	https://jumpit.saramin.co.kr/position/49885	other	f
1632	판교연구소 SW개발 (경력 7~9년)	인텔리안테크놀로지스	경기 평택시	경력 7~9년	["C", "C++", "Embedded Linux", "JsonAPI"]	모집마감	https://jumpit.saramin.co.kr/position/50971	other	f
1633	R/F개발 5~7년 채용	테스	경기 용인시	경력 5~7년	["MATLAB", "Network", "RF"]	모집마감	https://jumpit.saramin.co.kr/position/50753	other	f
1634	SW Engineer-정보보안(암호화알고리즘)	리브스메드	경기 성남시	경력 5~12년	["Linux", "C++", "Network"]	모집마감	https://jumpit.saramin.co.kr/position/50322	other	f
1635	Project Manager (3년 이상)	이우소프트	경기 화성시	경력 3~10년	["Jira", "Azure DevOps", "Confluence"]	모집마감	https://jumpit.saramin.co.kr/position/50341	other	f
1636	클라이언트 프로그래머	에이버튼	경기 성남시	경력 2~20년	["C++", "Unreal Engine"]	모집마감	https://jumpit.saramin.co.kr/position/50476	other	f
1637	R/F개발 8~10년 채용	테스	경기 용인시	경력 8~10년	["MATLAB", "Network", "RF"]	모집마감	https://jumpit.saramin.co.kr/position/50754	other	f
1638	로봇제어Engineer:Senior(과장-부장)	리브스메드	경기 성남시	경력 7~18년	["C++", "Python", "Git", "Notion", "Jira", "C"]	모집마감	https://jumpit.saramin.co.kr/position/50321	other	f
1649	임베디드 소프트웨어 개발자(신입~4년차)	긴트	경기 성남시	신입~4년	["C", "C++", "SW", "Embedded"]	모집마감	https://jumpit.saramin.co.kr/position/50353	other	f
1651	반도체 테스트 자동화 장비 SW 개발자	네오셈	경기 안양시	경력 2~8년	["SW", "Linux", "C", "C#"]	모집마감	https://jumpit.saramin.co.kr/position/51059	other	f
1653	F/W개발(MCU) (경력 8~10년)	원익피앤이	경기 수원시	경력 8~10년	["C", "FW", "MCU"]	모집마감	https://jumpit.saramin.co.kr/position/50993	other	f
1654	C++ 개발자 (수습평가 따라 재택 가능)	이파피루스	경기 성남시	경력 5~10년	["C", "C++", "Jenkins", "Git", "Linux", "C#", "Qt"]	모집마감	https://jumpit.saramin.co.kr/position/50256	other	f
1655	회로개발 (경력 3~7년)	원익피앤이	경기 수원시	경력 3~7년	["HW", "SW", "Embedded", "FW"]	모집마감	https://jumpit.saramin.co.kr/position/50988	other	f
1659	Verification Engineer/분당R&D	아이디어스투실리콘	경기 성남시	경력 3~15년	["Verilog", "ASIC", "Perl", "TCP/IP", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/49886	other	f
1661	산업용 모니터 개발	엠투아이코퍼레이션	경기 안양시	신입~3년	["HW", "Embedded", "MCU", "Circuit design"]	모집마감	https://jumpit.saramin.co.kr/position/50007	other	f
1665	HW/임베디드 개발자 모집	메타이노텍	경기 수원시	경력 3~10년	["HW", "FW", "Embedded", "SW", "C", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/50604	other	f
1668	Software Quality Assurance	네비웍스	경기 안양시	경력 6~10년	["SW", "QA", "Jira", "Confluence", "HW"]	모집마감	https://jumpit.saramin.co.kr/position/50570	other	f
1672	회로개발 (경력 11~15년)	원익피앤이	경기 수원시	경력 11~15년	["HW", "SW", "Embedded", "FW"]	모집마감	https://jumpit.saramin.co.kr/position/50991	other	f
1674	솔루션 엔지니어(시스템 엔지니어/SE)	이파피루스	경기 성남시	경력 2~10년	["Docker", "Python", "Network", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/50894	other	f
1675	완성차 검차라인 SW 개발(10년↑)	에이디티	경기 안산시	경력 10~15년	["C#", "C", "C++", "Mfc", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/50220	other	f
1679	반도체 자동화시스템개발(RMS/FDC)경력	엘비세미콘	경기 평택시	경력 3~5년	["C", "Vb.net", "Oracle", "MSSQL", "C#"]	모집마감	https://jumpit.saramin.co.kr/position/49978	other	f
1680	반도체 TEST 프로그램 개발 (경력)	엘비세미콘	경기 평택시	경력 5~20년	["QA", "IPS", "FLEX", "EDA", "Python", "C#"]	모집마감	https://jumpit.saramin.co.kr/position/51325	other	f
1681	임베디드 소프트웨어 개발자(9~12년차)	긴트	경기 성남시	경력 9~12년	["C", "C++", "SW", "Embedded"]	모집마감	https://jumpit.saramin.co.kr/position/50349	other	f
1682	언리얼 엔진 프로그래머	에이버튼	경기 성남시	경력 2~20년	["C++", "Unreal Engine"]	모집마감	https://jumpit.saramin.co.kr/position/50475	other	f
1684	Unreal 클라이언트 개발자 채용(경력)	네비웍스	경기 안양시	경력 3~10년	["C++", "Unreal Engine"]	모집마감	https://jumpit.saramin.co.kr/position/50151	other	f
1685	판교연구소 SW개발 (경력 13~15년)	인텔리안테크놀로지스	경기 평택시	경력 13~15년	["C", "C++", "Embedded Linux", "JsonAPI"]	모집마감	https://jumpit.saramin.co.kr/position/50969	other	f
1687	이미지 프로세싱 알고리즘 개발 신입	포스로직	경기 안양시	신입	["C", "C++", "CUDA", "DeepLearning"]	모집마감	https://jumpit.saramin.co.kr/position/50626	other	f
1689	임베디드 S/W 엔지니어 모집 [경력]	인터콘시스템스	경기 안양시	경력 3~10년	["MCU", "RTOS", "Embedded Linux", "C"]	모집마감	https://jumpit.saramin.co.kr/position/50415	other	f
1690	기구설계 엔지니어 모집	앤씨앤	경기 성남시	경력 5~15년	["Embedded Linux", "C", "C++", "SW", "TCP/IP"]	모집마감	https://jumpit.saramin.co.kr/position/49994	other	f
1691	클라우드 솔루션 아키텍트 - GenAI(글로벌)	업스테이지	경기 용인시	신입~20년	["AI/인공지능", "AWS", "GCP", "AZURE"]	모집마감	https://jumpit.saramin.co.kr/position/50537	other	f
1692	F/W 펌웨어 개발	오토엘	경기 성남시	경력 5~12년	["ARM", "C", "C++", "Embedded Linux", "FW"]	모집마감	https://jumpit.saramin.co.kr/position/50824	other	f
1694	[경력] Java 풀스택 개발자	에피넷	경기 안양시	경력 2~7년	["Java", "Linux", "Docker"]	모집마감	https://jumpit.saramin.co.kr/position/46044	other	f
1695	QA 엔지니어 (경력)	엔닷라이트	경기 성남시	경력 3~6년	["QA", "3D Rendering", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/50912	other	f
1696	IMS & ECS 개발 (경력 6~9년)	원익피앤이	경기 수원시	경력 6~9년	["C#", "WPF"]	모집마감	https://jumpit.saramin.co.kr/position/49798	other	f
1697	IMS & ECS 개발 (경력 13~15년)	원익피앤이	경기 수원시	경력 13~15년	["C#", "WPF"]	모집마감	https://jumpit.saramin.co.kr/position/49799	other	f
1698	[로봇] 강화학습 엔지니어 채용	플라잎	경기 성남시	경력 3~5년	["C", "C++", "Python", "MachineLearning"]	모집마감	https://jumpit.saramin.co.kr/position/50056	other	f
1699	F/W개발(MCU) (경력 3~7년)	원익피앤이	경기 수원시	경력 3~7년	["C", "FW", "MCU"]	모집마감	https://jumpit.saramin.co.kr/position/50992	other	f
1700	H/W 엔지니어 모집(경력 1~5년)	인터콘시스템스	경기 안양시	경력 1~5년	["HW", "Orcad", "Pads", "Autocad", "MCU"]	모집마감	https://jumpit.saramin.co.kr/position/50417	other	f
1705	전기전자 설계 개발(경력)	네비웍스	경기 안양시	경력 3~5년	["Orcad", "PCB", "2D Rendering"]	모집마감	https://jumpit.saramin.co.kr/position/50148	other	f
1706	HW 기구 설계(경력)	네비웍스	경기 안양시	경력 5~15년	["Solidworks", "Autocad"]	모집마감	https://jumpit.saramin.co.kr/position/50149	other	f
1707	SW Engineer:어플리케이션	리브스메드	경기 성남시	경력 3~12년	["SW", "C", "C++", "Qt", "GUI"]	모집마감	https://jumpit.saramin.co.kr/position/50317	other	f
1709	[CT] 의료영상처리 알고리즘 SW	덴티움	경기 수원시	경력 2~10년	["C++", "OpenCV", "CUDA", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/50736	other	f
1710	의료기기 GUI S/W 경력 채용	아프로코리아	경기 군포시	경력 5~10년	["SW", "C#", "Visual Studio", "Embedded"]	모집마감	https://jumpit.saramin.co.kr/position/49947	other	f
1711	자율주행 개발자(신입~3년차)	긴트	경기 성남시	신입~3년	["MATLAB", "C", "C++", "SW", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/51485	other	f
1713	반도체 자동화시스템개발(RMS/FDC)신입	엘비세미콘	경기 평택시	신입	["C", "Vb.net", "Oracle", "MSSQL", "C#"]	모집마감	https://jumpit.saramin.co.kr/position/49977	other	f
1714	ERP/MES 개발자 및 PM 채용	이맥스하이텍	경기 남양주시	경력 5~15년	["Java", "ERP", "MES", "C#", ".NET", "SW", "JSP"]	모집마감	https://jumpit.saramin.co.kr/position/50513	other	f
1715	임베디드 S/W 엔지니어 모집 [신입]	인터콘시스템스	경기 안양시	신입~2년	["MCU", "RTOS", "Embedded Linux", "C"]	모집마감	https://jumpit.saramin.co.kr/position/50416	other	f
1721	자율주행 개발자(7~10년차)	긴트	경기 성남시	경력 7~10년	["MATLAB", "C", "C++", "SW", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50351	other	f
1725	QA 담당자(3~5년차)	와디즈	경기 성남시	경력 3~5년	["QA"]	모집마감	https://jumpit.saramin.co.kr/position/49946	other	f
1726	ERP/MES 개발자 및 PL 채용	이맥스하이텍	경기 남양주시	경력 4~15년	["Java", "ERP", "MES", "C#", ".NET", "SW", "JSP"]	모집마감	https://jumpit.saramin.co.kr/position/50512	other	f
2626	하드웨어 엔지니어 주니어급	혜연전자	인천 서구	경력 1~3년	["PCB", "· RF", "· Pads", "· HW"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52422	other	t
1728	응용 소프트웨어 개발	오토엘	경기 성남시	경력 5~10년	["C", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/50825	other	f
1729	임베디드 소프트웨어 개발자(5~8년차)	긴트	경기 성남시	경력 5~8년	["C", "C++", "SW", "Embedded"]	모집마감	https://jumpit.saramin.co.kr/position/50350	other	f
1730	ERP/MES 개발자 채용	이맥스하이텍	경기 남양주시	경력 1~15년	["Java", "ERP", "MES", "C#", ".NET", "SW", "JSP"]	모집마감	https://jumpit.saramin.co.kr/position/50511	other	f
1732	Embedded Middleware 개발자	앤씨앤	경기 성남시	경력 5~10년	["Embedded Linux", "C", "C++", "SW", "TCP/IP"]	모집마감	https://jumpit.saramin.co.kr/position/49993	other	f
1733	SOC TOP Design Enginer	보스반도체	경기 성남시	경력 2~15년	["ARM", "Verilog", "Python", "C++", "OpenCV"]	모집마감	https://jumpit.saramin.co.kr/position/50111	other	f
1735	통신장비 시스템 h/w 개발자	에프알텍	경기 의왕시	신입	["PCB"]	모집마감	https://jumpit.saramin.co.kr/position/51446	other	f
1737	응용 SW 개발 모집	비솔	경기 광명시	경력 7~20년	["Python", "C++", "C#", "SW", "OpenCV"]	모집마감	https://jumpit.saramin.co.kr/position/50768	other	f
1738	윈도우 어플리케이션 개발자	체크멀	경기 용인시	경력 2~10년	["Visual Studio", "Mfc", "C", "C++", "Windows"]	모집마감	https://jumpit.saramin.co.kr/position/50637	other	f
1739	전자제어 H/W [경력15~20년]	태하	경기 남양주시	경력 15~20년	["HW", "MCU", "PCB"]	모집마감	https://jumpit.saramin.co.kr/position/50413	other	f
1740	전자제어 S/W [신입~4년]	태하	경기 남양주시	신입~4년	["SW", "C", "C++", "FW"]	모집마감	https://jumpit.saramin.co.kr/position/50406	other	f
1742	제어설계(PC) 분야 [경력10~15년]	태하	경기 남양주시	경력 10~15년	["SW", "C", "C#", "C++", "Mfc", "MES", "SQL"]	모집마감	https://jumpit.saramin.co.kr/position/50409	other	f
1745	어플리케이션 개발 및 유지보수	엠투아이코퍼레이션	경기 안양시	신입~5년	["C++", "Qt"]	모집마감	https://jumpit.saramin.co.kr/position/50008	other	f
1749	배구 3D 챌린지 시스템 개발	스포츠투아이	경기 성남시	경력 2~15년	["OpenGL", "C++", "Unreal Engine", "C", "AR"]	모집마감	https://jumpit.saramin.co.kr/position/51100	other	f
1754	영상관제 응용프로그램 개발(10년↑)	엘케이삼양	경기 과천시	경력 10~20년	["C#", "WPF", "SW", "OpenCV", "FFMPEG", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/50740	other	f
1757	개발 계획 및 개발 진행 PM(15~20년)	WATA Inc.	경기 성남시	경력 15~20년	["GitHub", "Jira", "Java", "AWS", "RDB"]	모집마감	https://jumpit.saramin.co.kr/position/50951	other	f
1758	2차전지 검사장비 개발/유지보수 채용	피닉슨컨트롤스	경기 화성시	경력 1~5년	["C#", "MSSQL", "SW", "MySQL", "C++", "WPF"]	모집마감	https://jumpit.saramin.co.kr/position/49944	other	f
1759	회로개발 (경력 8~10년)	원익피앤이	경기 수원시	경력 8~10년	["HW", "SW", "Embedded", "FW"]	모집마감	https://jumpit.saramin.co.kr/position/50989	other	f
1760	영상관제 응용프로그램 개발(6년↑)	엘케이삼양	경기 과천시	경력 6~9년	["C#", "WPF", "SW", "OpenCV", "FFMPEG", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/50760	other	f
1819	H/W 개발 경력직원 채용	인텍에프에이	경기 용인시	경력 1~10년	["Orcad", "HW", "Pads"]	모집마감	https://jumpit.saramin.co.kr/position/51290	other	f
1762	영상관제 응용프로그램 개발(3년↑)	엘케이삼양	경기 과천시	경력 3~5년	["C#", "WPF", "SW", "OpenCV", "FFMPEG", "Git"]	모집마감	https://jumpit.saramin.co.kr/position/50759	other	f
1764	Embeded System SW 엔지니어	보스반도체	경기 성남시	신입~15년	["ARM", "Verilog", "Python", "C++", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/50110	other	f
1767	PC 제어(시스템제어팀) (5~7년)	쎄크	경기 수원시	경력 5~7년	["C++", "Mfc", "SW", "Embedded", "C"]	모집마감	https://jumpit.saramin.co.kr/position/49839	other	f
1768	SoC Design Verification	보스반도체	경기 성남시	경력 2~15년	["C", "C++", "Java", "PM2", "Verilog"]	모집마감	https://jumpit.saramin.co.kr/position/50112	other	f
1769	SoC RTL DFT Design Engineer	보스반도체	경기 성남시	경력 5~15년	["PCB", "HW", "Embedded"]	모집마감	https://jumpit.saramin.co.kr/position/50107	other	f
1771	소프트웨어 엔지니어(3~5년)	에이딘로보틱스	경기 안양시	경력 3~5년	["Python", "C++", "Linux", "ethernet", "TCP/IP"]	모집마감	https://jumpit.saramin.co.kr/position/50381	other	f
1772	SoC RTL Design Engineer	보스반도체	경기 성남시	경력 2~15년	["C", "C++", "Python", "Verilog"]	모집마감	https://jumpit.saramin.co.kr/position/50108	other	f
1773	미디어아트 XR 임베디드 시스템 개발자	프롬프트팩토리	경기 성남시	신입	["Python", "C", "C++", "Java", "MCU"]	모집마감	https://jumpit.saramin.co.kr/position/50898	other	f
1774	검사장비 HW/FW 개발 경력 채용	피닉슨컨트롤스	경기 화성시	경력 5~15년	["HW", "FW", "ARM", "PCB"]	모집마감	https://jumpit.saramin.co.kr/position/50453	other	f
1775	개발 계획 및 개발 진행PM(10~14)	WATA Inc.	경기 성남시	경력 10~14년	["GitHub", "Jira", "Java", "AWS", "RDB"]	모집마감	https://jumpit.saramin.co.kr/position/50949	other	f
1777	기술개발 총괄 및 리딩(16~20년)	WATA Inc.	경기 성남시	경력 16~20년	["RDB", "REST API", "C++", "Java", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/50946	other	f
1778	기술개발 총괄 및 리딩(12~15년)	WATA Inc.	경기 성남시	경력 12~15년	["RDB", "REST API", "C++", "Java", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/50947	other	f
1780	QA 담당자(6~8년차)	와디즈	경기 성남시	경력 6~8년	["QA"]	모집마감	https://jumpit.saramin.co.kr/position/49945	other	f
1781	H/W 엔지니어 모집(경력 6~10년)	인터콘시스템스	경기 안양시	경력 6~10년	["HW", "Orcad", "Pads", "Autocad", "MCU"]	모집마감	https://jumpit.saramin.co.kr/position/50414	other	f
2729	Apps Sowtware PM	메디트	서울 영등포구	경력 5~15년	["QA", "· Productboard", "· SW"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51671	other	t
1782	SDV 솔루션 2,3팀	슈어소프트테크	경기 성남시	신입~5년	["C", "SW", "MATLAB"]	모집마감	https://jumpit.saramin.co.kr/position/50221	other	f
1783	시스템 엔지니어 (경력)	아주큐엠에스	경기 용인시	경력 2~5년	["Linux", "Windows", "AWS", "AZURE", "GCP"]	모집마감	https://jumpit.saramin.co.kr/position/50569	other	f
1786	3D 그래픽스 엔지니어 (신입/경력)	엔닷라이트	경기 성남시	신입~10년	["WebGL", "three.js", "BabylonJS", "OpenGL"]	모집마감	https://jumpit.saramin.co.kr/position/50907	other	f
1787	제어로직개발팀	슈어소프트테크	경기 성남시	경력 2~8년	["C", "SW", "MATLAB", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/50222	other	f
1790	시스템 운영 및 웹 개발자 모집	코스메카코리아	경기 성남시	경력 3~7년	["Java", "JSP", "DB", "MSSQL", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/51336	other	f
1792	PLC (Mitsubishi) 제어 (2년이상)	쎄크	경기 수원시	경력 2~5년	["PLC", "HW"]	모집마감	https://jumpit.saramin.co.kr/position/49837	other	f
1795	시스템 운용/유지보수	베스텔라랩	경기 안양시	신입~8년	["Ccna", "Ccnp", "VPN", "Router", "Linux"]	모집마감	https://jumpit.saramin.co.kr/position/51255	other	f
1799	C#개발자(네트워크 기술팀)	슈어소프트테크	경기 성남시	경력 3~7년	["C", "C++", "Visual Studio", "Embedded"]	모집마감	https://jumpit.saramin.co.kr/position/50223	other	f
1800	UI테스팅 자동화 솔루션 개발	슈어소프트테크	경기 성남시	경력 2~7년	["Java", "Python", "SW", "Eclipse"]	모집마감	https://jumpit.saramin.co.kr/position/50909	other	f
1805	영상처리(Vision) S/W 개발 (7~10년)	쎄크	경기 수원시	경력 7~10년	["C++", "C#", "OpenCV", "SW", "HALCON"]	모집마감	https://jumpit.saramin.co.kr/position/49845	other	f
1806	영상처리(Vision) S/W 개발 (5~7년)	쎄크	경기 수원시	경력 5~7년	["C++", "C#", "OpenCV", "SW", "HALCON"]	모집마감	https://jumpit.saramin.co.kr/position/49844	other	f
1807	PLC (SIEMENS) 제어 (2~4년)	쎄크	경기 수원시	경력 2~4년	["C++", "Mfc", "SW", "C"]	모집마감	https://jumpit.saramin.co.kr/position/49852	other	f
1808	PLC (SIEMENS) 제어 (5~7년)	쎄크	경기 수원시	경력 5~7년	["C++", "Mfc", "SW", "C"]	모집마감	https://jumpit.saramin.co.kr/position/49853	other	f
1809	PC 제어(시스템제어팀) (2~4년)	쎄크	경기 수원시	경력 2~4년	["C++", "Mfc", "SW", "Embedded", "C"]	모집마감	https://jumpit.saramin.co.kr/position/49838	other	f
1810	PC 제어(시스템제어팀) (8~10년)	쎄크	경기 수원시	경력 8~10년	["C++", "Mfc", "SW", "Embedded", "C"]	모집마감	https://jumpit.saramin.co.kr/position/49840	other	f
1812	전산 담당자 계약직 채용(4~6년)	얼라인드제네틱스	경기 안양시	경력 4~6년	["ERP", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/50773	other	f
1813	제어 컨트롤러 펌웨어 개발자 (7~10년)	유앤아이솔루션	경기 광주시	경력 7~10년	["C", "C++", "ARM", "FPGA", "Embedded"]	모집마감	https://jumpit.saramin.co.kr/position/51203	other	f
1815	하드웨어 및 펌웨어 개발자	한솔리드텍	경기 의왕시	경력 9~11년	["C", "C++", "Linux", "Orcad"]	모집마감	https://jumpit.saramin.co.kr/position/50671	other	f
1816	주차장 서비스기획자 경력 채용	하이파킹	경기 성남시	경력 10~20년	["Figma", "ProtoPie", "Adobe XD", "Firebase"]	모집마감	https://jumpit.saramin.co.kr/position/51357	other	f
1817	[SW 개발] C++/C# 개발자 신입	파이	경기 수원시	신입	["C++", "C#"]	모집마감	https://jumpit.saramin.co.kr/position/50021	other	f
1820	Soc Design Engineer	아이에이치더블유	경기 용인시	경력 3~20년	["Git", "EDA", "TCP/IP", "ARM", "Verilog"]	모집마감	https://jumpit.saramin.co.kr/position/51009	other	f
1821	자동차 전기·전자 분야 개발/엔지니어링 3년↑	모빌리티네트웍스	경기 안양시	경력 3~5년	["HW", "SW", "Embedded", "Jira", "Confluence"]	모집마감	https://jumpit.saramin.co.kr/position/51282	other	f
1822	[SW 개발] C++/C# 개발자 경력(8~10년)	파이	경기 수원시	경력 8~10년	["C++", "C#"]	모집마감	https://jumpit.saramin.co.kr/position/50024	other	f
1823	회로설계 경력 엔지니어 채용	유버	경기 안산시	경력 2~20년	["Orcad", "Pads", "PCB"]	모집마감	https://jumpit.saramin.co.kr/position/50291	other	f
1824	하드웨어 및 펌웨어 개발자	한솔리드텍	경기 의왕시	경력 3~5년	["C", "C++", "Linux", "Orcad"]	모집마감	https://jumpit.saramin.co.kr/position/50669	other	f
1825	[SW 개발] C++/C# 개발자 경력(2~4년)	파이	경기 수원시	경력 2~4년	["C++", "C#"]	모집마감	https://jumpit.saramin.co.kr/position/50022	other	f
1826	전산 담당자 계약직 채용(1~3년)	얼라인드제네틱스	경기 안양시	경력 1~3년	["ERP", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/50772	other	f
1829	하드웨어 개발자(10년~)	캐스트프로	경기 성남시	경력 10~20년	["HW"]	모집마감	https://jumpit.saramin.co.kr/position/50368	other	f
1830	펌웨어 개발자(10년~)	캐스트프로	경기 성남시	경력 10~20년	["MCU", "C", "FW"]	모집마감	https://jumpit.saramin.co.kr/position/50421	other	f
1832	펌웨어 개발자(1~10년)	캐스트프로	경기 성남시	경력 1~10년	["MCU", "C", "FW"]	모집마감	https://jumpit.saramin.co.kr/position/50420	other	f
1833	장비제어 프로그램 개발자	제이엔에스	경기 화성시	경력 3~15년	["C#"]	모집마감	https://jumpit.saramin.co.kr/position/49924	other	f
1834	하드웨어 개발자(1~9년)	캐스트프로	경기 성남시	경력 1~9년	["HW"]	모집마감	https://jumpit.saramin.co.kr/position/50369	other	f
1845	윈도우 응용 프로그래머(C++)	네비웍스	경기 안양시	경력 3~15년	["C", "C++", "C#", "TCP/IP", "GUI", "Mfc", "Linux"]	모집마감	https://jumpit.saramin.co.kr/position/50152	other	f
1848	로봇제어Engineer:Senior(과장-부장)[박사급]	리브스메드	경기 성남시	경력 7~18년	["C++", "Python", "Git", "Notion", "Jira", "C"]	모집마감	https://jumpit.saramin.co.kr/position/50320	other	f
1849	영상처리,비전(Vision) S/W채용(3~5년)	포우	경기 용인시	경력 3~5년	["SW", "OpenCV", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/50397	other	f
1853	악성코드 분석가(전문연구요원) 신입	시큐레터	경기 성남시	신입	["Network", "Linux", "Ddos", "IPS", "Firewall"]	모집마감	https://jumpit.saramin.co.kr/position/50449	other	f
1859	Cloud Security Engineer(5년~)	한화비전	경기 성남시	경력 5~9년	["ISMS", "AWS", "AZURE", "Firewall", "IPS"]	모집마감	https://jumpit.saramin.co.kr/position/50242	other	f
1860	Citrix 가상화 엔지니어 모집	누리인포스	경기 성남시	신입	["Citrix Gateway", "Linux", "Windows Server"]	모집마감	https://jumpit.saramin.co.kr/position/50100	other	f
1861	영상처리,비전(Vision) S/W채용(9년↑)	포우	경기 용인시	경력 9~11년	["SW", "OpenCV", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/50400	other	f
1862	PNS팀 윈도 개발자	지니언스	경기 안양시	경력 5~15년	["C", "C#", "C++", "VPN"]	모집마감	https://jumpit.saramin.co.kr/position/50590	other	f
1867	바이오인식 / OCR 알고리즘 개발	엑스페릭스	경기 성남시	경력 2~7년	["C", "C++", "C#", "Java", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/51404	other	f
1879	ERP운영/유지보수 개발자_2년 이상	블루닉스	경기 안산시	경력 2~4년	["Delphi", "C#", "Oracle", "MSSQL", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/51165	other	f
1880	ERP운영/유지보수 개발자_5년 이상	블루닉스	경기 안산시	경력 5~7년	["Delphi", "C#", "Oracle", "MSSQL", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/51166	other	f
1885	ERP운영/유지보수 개발자_8년 이상	블루닉스	경기 안산시	경력 8~10년	["Delphi", "C#", "Oracle", "MSSQL", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/51167	other	f
1888	개발 계획 및 개발 진행 PM(5~9년)	WATA Inc.	경기 성남시	경력 5~9년	["GitHub", "Jira", "Java", "AWS", "RDB"]	모집마감	https://jumpit.saramin.co.kr/position/50950	other	f
1889	HW개발자(5년이상) 채용	씨앤유글로벌	경기 성남시	경력 5~10년	["Orcad", "Pads", "MCU", "HW"]	모집마감	https://jumpit.saramin.co.kr/position/49936	other	f
1890	WiFi Router개발 경력 1~5년	가온브로드밴드	경기 성남시	경력 1~5년	["C", "Linux", "C++", "Embedded", "Router"]	모집마감	https://jumpit.saramin.co.kr/position/51572	other	f
1893	완성차 검차라인 SW 개발(5년↑)	에이디티	경기 안산시	경력 5~9년	["C#", "C", "C++", "Mfc", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/50219	other	f
1894	WiFi Router 개발 신입 채용	가온브로드밴드	경기 성남시	신입	["C", "Linux", "C++", "Embedded", "Router"]	모집마감	https://jumpit.saramin.co.kr/position/51571	other	f
1899	모터제어 엔지니어(6~10년차)	긴트	경기 성남시	경력 6~10년	["C", "C++", "SW", "Embedded"]	모집마감	https://jumpit.saramin.co.kr/position/50348	other	f
1900	전자제어 S/W [경력5~10년]	태하	경기 남양주시	경력 5~10년	["SW", "C", "C++", "FW"]	모집마감	https://jumpit.saramin.co.kr/position/50407	other	f
1901	Service architect(VDMS)	유비퍼스트대원	경기 성남시	경력 3~10년	["Figma", "Microsoft Excel"]	모집마감	https://jumpit.saramin.co.kr/position/51200	other	f
1902	제어설계(PC) 분야 [경력5~9년]	태하	경기 남양주시	경력 5~9년	["SW", "C", "C#", "C++", "Mfc", "MES", "SQL"]	모집마감	https://jumpit.saramin.co.kr/position/50408	other	f
1903	자율주행 개발자(3~6년차)	긴트	경기 성남시	경력 3~6년	["MATLAB", "C", "C++", "SW", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50352	other	f
1904	전자제어 H/W [경력10~14년]	태하	경기 남양주시	경력 10~14년	["HW", "MCU", "PCB"]	모집마감	https://jumpit.saramin.co.kr/position/50411	other	f
1906	FPGA - HW Engineer (대리~과장급)	리브스메드	경기 성남시	경력 5~12년	["FPGA", "MCU", "VHDL"]	모집마감	https://jumpit.saramin.co.kr/position/50318	other	f
1907	악성코드 분석가(대리/과장급) 경력	시큐레터	경기 성남시	경력 2~10년	["Network", "Linux", "Ddos", "IPS", "Firewall"]	모집마감	https://jumpit.saramin.co.kr/position/50450	other	f
1908	SAP 운영/개발(MM 및 SD모듈)	한국네트웍스	경기 성남시	경력 10~15년	["SAP", "ABAP"]	모집마감	https://jumpit.saramin.co.kr/position/50366	other	f
791	DBA	디어유	서울 강남구	경력 5~10년	["AWS", "NoSql", "MySQL"]	모집마감	https://jumpit.saramin.co.kr/position/51346	other	f
1913	평택연구소 SW개발 (경력 7~15년)	인텔리안테크놀로지스	경기 평택시	경력 7~15년	["C", "C++", "Embedded Linux", "JsonAPI"]	모집마감	https://jumpit.saramin.co.kr/position/50968	other	f
1914	판교연구소 SW개발 (경력 10~12년)	인텔리안테크놀로지스	경기 평택시	경력 10~12년	["C", "C++", "Embedded Linux", "JsonAPI"]	모집마감	https://jumpit.saramin.co.kr/position/50970	other	f
1915	가상화 솔루션 개발자(경력9~11)	쿤텍	경기 성남시	경력 9~11년	["C", "Rust", "Python", "Shell", "NoSql"]	모집마감	https://jumpit.saramin.co.kr/position/50922	other	f
1916	USB Device SDK 개발_3년이상	엑스페릭스	경기 성남시	경력 3~6년	["Windows", "Linux", "C++", "SW", "C#", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/49791	other	f
1920	소프트웨어개발 (PL급/13~15년)	쿤텍	경기 성남시	경력 13~15년	["C", "Rust", "Python", "Shell", "NoSql"]	모집마감	https://jumpit.saramin.co.kr/position/50924	other	f
1921	영상처리,비전(Vision) S/W채용(6~8년)	포우	경기 용인시	경력 6~8년	["SW", "OpenCV", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/50398	other	f
1922	디지털헬스케어 플랫폼임베디드 개발자	엑소시스템즈	경기 성남시	경력 3~10년	["HW", "FW", "Analog", "Embedded", "RTOS"]	모집마감	https://jumpit.saramin.co.kr/position/51466	other	f
1923	소프트웨어개발 (PL급/10~12년)	쿤텍	경기 성남시	경력 10~12년	["C", "Rust", "Python", "Shell", "NoSql"]	모집마감	https://jumpit.saramin.co.kr/position/50923	other	f
1925	SAP 운영/개발(CO모듈)	한국네트웍스	경기 성남시	경력 10~20년	["SAP", "ABAP"]	모집마감	https://jumpit.saramin.co.kr/position/50365	other	f
1926	가상화 솔루션 개발자(경력3~5)	쿤텍	경기 성남시	경력 3~5년	["C", "Rust", "Python", "Shell", "NoSql"]	모집마감	https://jumpit.saramin.co.kr/position/50920	other	f
1927	USB Device SDK 개발_7년이상	엑스페릭스	경기 성남시	경력 7~10년	["Windows", "Linux", "C++", "SW", "C#", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/49792	other	f
1928	소프트웨어 개발(경력8~10년)	인포그램	경기 화성시	경력 8~10년	["C#", "Java", "MachineLearning"]	모집마감	https://jumpit.saramin.co.kr/position/50588	other	f
1929	시스템 설계 Manager	서플러스글로벌	경기 용인시	경력 7~20년	["ERP", "Jira", "Java", "MSSQL"]	모집마감	https://jumpit.saramin.co.kr/position/50739	other	f
1930	소프트웨어 엔지니어(6~8년)	에이딘로보틱스	경기 안양시	경력 6~8년	["Python", "C++", "Linux", "ethernet", "TCP/IP"]	모집마감	https://jumpit.saramin.co.kr/position/50382	other	f
1934	모터센스 솔루션 구축 엔지니어	이파피루스	경기 성남시	경력 7~10년	["Windows", "Linux", "Docker", "VPN"]	모집마감	https://jumpit.saramin.co.kr/position/50895	other	f
1937	GPON 개발자 경력 채용(11~20년)	가온브로드밴드	경기 성남시	경력 11~20년	["C", "Linux", "C++", "Embedded Linux", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/51575	other	f
1941	GPON 개발자 경력 채용(3~10년)	가온브로드밴드	경기 성남시	경력 3~10년	["C", "Linux", "C++", "Embedded Linux", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/51574	other	f
1942	F/W개발(MCU) (경력 11~15년)	원익피앤이	경기 수원시	경력 11~15년	["C", "FW", "MCU"]	모집마감	https://jumpit.saramin.co.kr/position/50994	other	f
1943	WiFi Router개발 경력 6~10년	가온브로드밴드	경기 성남시	경력 6~10년	["C", "Linux", "C++", "Embedded", "Router"]	모집마감	https://jumpit.saramin.co.kr/position/51573	other	f
1944	IMS & ECS 개발 (경력 10~12년)	원익피앤이	경기 수원시	경력 10~12년	["C#", "WPF"]	모집마감	https://jumpit.saramin.co.kr/position/49800	other	f
1945	기술개발 총괄 및 리딩(8~11년)	WATA Inc.	경기 성남시	경력 8~11년	["RDB", "REST API", "C++", "Java", "AWS"]	모집마감	https://jumpit.saramin.co.kr/position/50948	other	f
1946	[제어기개발팀] 임베디드 SW 개발	슈어소프트테크	경기 성남시	경력 5~10년	["C", "MCU", "SW", "Embedded"]	모집마감	https://jumpit.saramin.co.kr/position/51362	other	f
1948	모빌리티 Embedded SW 경력 개발자	아이비스	경기 수원시	경력 3~15년	["Linux", "SW", "C++", "Python", "Embedded"]	모집마감	https://jumpit.saramin.co.kr/position/50803	other	f
1949	[SDx플랫폼팀] 임베디드 SW 개발	슈어소프트테크	경기 성남시	경력 5~10년	["C", "MCU", "RTOS", "Embedded", "Linux"]	모집마감	https://jumpit.saramin.co.kr/position/51361	other	f
1952	소프트웨어 개발(경력5~7년)	인포그램	경기 화성시	경력 5~7년	["C#", "Java", "MachineLearning"]	모집마감	https://jumpit.saramin.co.kr/position/50587	other	f
1954	전장설계엔지니어 채용	EVAR	경기 성남시	경력 5~15년	["HW", "PCB", "FW"]	모집마감	https://jumpit.saramin.co.kr/position/50665	other	f
1955	[하이닉스] k8s 기반 FDS 과제	미리비트	경기 성남시	경력 5~10년	["Python", "Minio", "Kafka", "Apache Flink"]	모집마감	https://jumpit.saramin.co.kr/position/51556	other	f
1956	FDS k8s devops	미리비트	경기 성남시	경력 5~15년	["Kubernetes", "BigData"]	모집마감	https://jumpit.saramin.co.kr/position/51557	other	f
1962	[SW 개발] C++/C# 개발자 경력(5~7년)	파이	경기 수원시	경력 5~7년	["C++", "C#"]	모집마감	https://jumpit.saramin.co.kr/position/50023	other	f
1966	연구개발 신입/경력직원 채용	인텍에프에이	경기 용인시	신입~10년	["Orcad", "HW", "Pads"]	모집마감	https://jumpit.saramin.co.kr/position/51588	other	f
1969	Digital HW 개발자	삼지전자	경기 화성시	신입~2년	["HW", "FPGA"]	모집마감	https://jumpit.saramin.co.kr/position/50605	other	f
1970	의료기기 SW 개발자 채용(11년이상)	디노바	경기 군포시	경력 11~15년	["C", "C#", "C++", "SW", "Embedded", "GUI"]	모집마감	https://jumpit.saramin.co.kr/position/50820	other	f
1971	의료기기 SW 개발자 채용(5년이상)	디노바	경기 군포시	경력 5~10년	["C", "C#", "C++", "SW", "Embedded", "GUI"]	모집마감	https://jumpit.saramin.co.kr/position/50819	other	f
1974	SW/임베디드 정규직 채용[신입]	네오티스	경기 안성시	신입	["C", "C++", "HW", "Embedded", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/51458	other	f
1983	SW/임베디드 정규직 채용[경력]	네오티스	경기 안성시	경력 1~10년	["C", "C++", "HW", "Embedded", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/51459	other	f
1984	자동차 전기·전자 분야 개발/엔지니어링 6년↑	모빌리티네트웍스	경기 안양시	경력 6~15년	["HW", "SW", "Embedded", "Jira", "Confluence"]	모집마감	https://jumpit.saramin.co.kr/position/51283	other	f
1986	제어 컨트롤러 펌웨어 개발자 (3~6년)	유앤아이솔루션	경기 광주시	경력 3~6년	["C", "C++", "ARM", "FPGA", "Embedded"]	모집마감	https://jumpit.saramin.co.kr/position/51202	other	f
1991	하드웨어 및 펌웨어 개발자	한솔리드텍	경기 의왕시	경력 6~8년	["C", "C++", "Linux", "Orcad"]	모집마감	https://jumpit.saramin.co.kr/position/50670	other	f
1997	AMS사업부 PM 채용	유진로봇	인천 연수구	경력 10~15년	["Analog", "Embedded"]	모집마감	https://jumpit.saramin.co.kr/position/50271	other	f
1998	개발본부C/C++ 엔지니어(Middleware)	유진로봇	인천 연수구	경력 4~15년	["C++", "ROS", "C", "GUI"]	모집마감	https://jumpit.saramin.co.kr/position/50277	other	f
2001	SAS사업부 SW(PLC) 채용	유진로봇	인천 연수구	경력 3~18년	["PLC", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/50275	other	f
2003	비젼개발팀 Vision SW Part 경력 채용	크레셈	인천 연수구	경력 2~10년	["SW", "C#", "WPF", "PCB"]	모집마감	https://jumpit.saramin.co.kr/position/50504	other	f
2004	비젼개발팀 알고리즘 파트 경력 채용	크레셈	인천 연수구	경력 3~10년	["SW", "C#", "WPF", "PCB", "OpenCV"]	모집마감	https://jumpit.saramin.co.kr/position/50505	other	f
2005	스마트팩토리 로봇관제 S/W 개발자	인아텍앤코포	인천 남동구	경력 1~5년	["MES", "C#", "Java", "MQTT", "REST API"]	모집마감	https://jumpit.saramin.co.kr/position/50483	other	f
2007	RADAR 알고리즘 SW	엠씨넥스	인천 연수구	경력 8~20년	["SW", "C++", "C", "Embedded", "Linux", "MCU"]	모집마감	https://jumpit.saramin.co.kr/position/51305	other	f
2008	HW 연구소 시스템개발2팀	엠씨넥스	인천 연수구	경력 13~20년	["HW", "PCB", "Verilog", "C", "C++", "FPGA"]	모집마감	https://jumpit.saramin.co.kr/position/51308	other	f
2012	시스템 개발/유지보수 신입 채용	엘리펀트키즈에듀테인먼트	인천 계양구	신입	["C#", "MSSQL"]	모집마감	https://jumpit.saramin.co.kr/position/51040	other	f
2015	HW/ 전장 설계 경력	세기알앤디	인천 부평구	경력 7~15년	["HW", "RF", "Pads"]	모집마감	https://jumpit.saramin.co.kr/position/50826	other	f
2016	Beckhoff(백호프) PLC	유진로봇	인천 연수구	경력 3~18년	["PLC", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/50272	other	f
2017	시스템개발/유지보수(1~3년)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 1~3년	["C#", "MSSQL"]	모집마감	https://jumpit.saramin.co.kr/position/50958	other	f
2020	SAS사업부 글로벌프로젝트 SW(PLC)채용	유진로봇	인천 연수구	경력 3~18년	["PLC", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/50274	other	f
2025	시스템개발/유지보수(4~6년)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 4~6년	["C#", "MSSQL"]	모집마감	https://jumpit.saramin.co.kr/position/51041	other	f
2026	HW/RF 설계 경력 (7년~15년)	세기알앤디	인천 부평구	경력 7~15년	["HW", "RF"]	모집마감	https://jumpit.saramin.co.kr/position/50827	other	f
2027	RADAR 시험장비 SW	엠씨넥스	인천 연수구	경력 3~10년	["SW", "C++", "C", "Embedded", "Linux", "MCU"]	모집마감	https://jumpit.saramin.co.kr/position/51307	other	f
2028	차량용 RADAR HW	엠씨넥스	인천 연수구	경력 3~12년	["HW", "PCB", "Verilog", "C", "C++", "FPGA"]	모집마감	https://jumpit.saramin.co.kr/position/51311	other	f
2029	임베디드 개발자 채용 (신입)	넥스트테크	인천 연수구	신입~2년	["Arduino", "Embedded", "GNU Bash", "C"]	모집마감	https://jumpit.saramin.co.kr/position/50869	other	f
2030	RADAR 신호처리 SW	엠씨넥스	인천 연수구	경력 5~20년	["SW", "C++", "C", "Embedded", "Linux", "MCU"]	모집마감	https://jumpit.saramin.co.kr/position/51306	other	f
2031	RF HW	엠씨넥스	인천 연수구	경력 5~12년	["HW", "PCB", "Verilog", "C", "C++", "FPGA"]	모집마감	https://jumpit.saramin.co.kr/position/51309	other	f
2032	RADAR RF HW	엠씨넥스	인천 연수구	경력 5~12년	["HW", "PCB", "Verilog", "C", "C++", "FPGA"]	모집마감	https://jumpit.saramin.co.kr/position/51310	other	f
2033	임베디드 개발자 채용 (경력)	넥스트테크	인천 연수구	경력 3~10년	["Arduino", "Embedded", "GNU Bash", "C"]	모집마감	https://jumpit.saramin.co.kr/position/50868	other	f
2051	소프트웨어 엔지니어 (경력 / 대구 근무)	에이스웍스코리아	대구 수성구	경력 3~12년	["labview", "C++", "C#", "Python", "C"]	모집마감	https://jumpit.saramin.co.kr/position/50699	other	f
2052	Verification Engineer/대구	아이디어스투실리콘	대구 북구	경력 3~15년	["Verilog", "ASIC", "Perl", "TCP/IP", "FPGA"]	모집마감	https://jumpit.saramin.co.kr/position/49887	other	f
2053	Digital Logic 개발/대구	아이디어스투실리콘	대구 북구	경력 3~15년	["Verilog", "C", "C++", "C#", "Python", "VHDL"]	모집마감	https://jumpit.saramin.co.kr/position/49884	other	f
2054	응용 프로그래머	제이브이엠	대구 달서구	경력 3~8년	["C#", "Microsoft SQL Server", "WPF", "WCF"]	모집마감	https://jumpit.saramin.co.kr/position/50860	other	f
2056	응용 프로그래머(인공지능)	제이브이엠	대구 달서구	경력 3~8년	["C#", "Microsoft SQL Server", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50862	other	f
2059	[대구] RTL 설계엔지니어(경력 4~16년)	칩스앤미디어	대구 동구	경력 4~16년	["Verilog", "C", "C++", "Python", "Linux", "HW"]	모집마감	https://jumpit.saramin.co.kr/position/50076	other	f
2060	응용 프로그래머(로봇제어)	제이브이엠	대구 달서구	경력 3~8년	["C#", "Microsoft SQL Server", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/50861	other	f
2061	펌웨어/플랫폼 개발(경력16~20년)	아세아텍	대구 달성군	경력 16~20년	["FW", "C", "HW"]	모집마감	https://jumpit.saramin.co.kr/position/50405	other	f
2062	전기,전자 소프트웨어 설계(1년~4년)	설텍	대구 달서구	경력 1~4년	["C", "C++", "SW", "MCU", "RTOS", "FPGA"]	모집마감	https://jumpit.saramin.co.kr/position/50093	other	f
2063	전기,전자 하드웨어 설계(10년~14년)	설텍	대구 달서구	경력 10~12년	["HW", "Embedded Linux", "MCU", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/50092	other	f
2064	펌웨어/플랫폼 개발(경력10~15년)	아세아텍	대구 달성군	경력 10~15년	["FW", "C", "HW"]	모집마감	https://jumpit.saramin.co.kr/position/50404	other	f
2065	전력전자 H/W 개발(1년~4년)	설텍	대구 달서구	경력 1~4년	["HW", "Orcad"]	모집마감	https://jumpit.saramin.co.kr/position/50086	other	f
2066	전기,전자 소프트웨어 설계(5년~9년)	설텍	대구 달서구	경력 5~9년	["C", "C++", "SW", "MCU", "RTOS", "FPGA"]	모집마감	https://jumpit.saramin.co.kr/position/50094	other	f
2067	펌웨어/플랫폼 개발(경력3~9년)	아세아텍	대구 달성군	경력 3~9년	["FW", "C", "HW"]	모집마감	https://jumpit.saramin.co.kr/position/50403	other	f
2068	전기,전자 하드웨어 설계(5년~9년)	설텍	대구 달서구	경력 5~9년	["HW", "Embedded Linux", "MCU", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/50091	other	f
2069	전기,전자 하드웨어 설계(1년~4년)	설텍	대구 달서구	경력 1~4년	["HW", "Embedded Linux", "MCU", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/50090	other	f
2070	전기,전자 소프트웨어 설계(10~14)	설텍	대구 달서구	경력 10~14년	["C", "C++", "SW", "FPGA"]	모집마감	https://jumpit.saramin.co.kr/position/50097	other	f
2071	전력전자 H/W 개발(5년~9년)	설텍	대구 달서구	경력 3~9년	["HW", "Orcad"]	모집마감	https://jumpit.saramin.co.kr/position/50087	other	f
2072	전력전자 H/W 개발(10년~14년)	설텍	대구 달서구	경력 10~14년	["HW", "Orcad"]	모집마감	https://jumpit.saramin.co.kr/position/50089	other	f
2077	기업부설연구소 전문연구요원(병역특례)	알지티	대전 중구	신입	["Python", "AWS WAF", "Git", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/50882	other	f
2111	FW개발 경력 채용	인엘씨테크놀러지	대전 유성구	경력 3~15년	["HW", "FW", "C", "MCU", "MATLAB", "FPGA"]	모집마감	https://jumpit.saramin.co.kr/position/50343	other	f
2090	Optical Engineer / Senior 채용	토모큐브	대전 유성구	경력 2~5년	["MATLAB", "CUDA", "3D Rendering"]	모집마감	https://jumpit.saramin.co.kr/position/50781	other	f
2091	2차전지 검사기 개발자 (신입 또는 경력1~4년)	아이비젼웍스	대전 유성구	신입~4년	["OpenCV", "C++", "Mfc"]	모집마감	https://jumpit.saramin.co.kr/position/50224	other	f
2094	S/W 개발(1~5년)	블루텍	대전 유성구	경력 1~5년	["SW", "C", "C++", "C#", "Linux"]	모집마감	https://jumpit.saramin.co.kr/position/50205	other	f
2095	하드웨어(H/W) 개발자 채용	블루텍	대전 유성구	신입~15년	["SW", "HW", "C", "Embedded Linux", "Linux"]	모집마감	https://jumpit.saramin.co.kr/position/50207	other	f
2096	S/W 개발(6~10년)	블루텍	대전 유성구	경력 6~10년	["SW", "C", "C++", "C#", "Linux"]	모집마감	https://jumpit.saramin.co.kr/position/50206	other	f
2097	[대전서구] 공공 SI 제안서 PM 모집 (경력 13년~16년)	에스넷아이씨티	대전 서구	경력 13~16년	["Cisco", "Network", "Ccna", "Ccnp"]	모집마감	https://jumpit.saramin.co.kr/position/51478	other	f
2099	장비 제어 소프트웨어 엔지니어	액스비스	대전 유성구	경력 2~15년	["C#", "C", "C++", "GUI", "SW", "Mfc", "Java"]	모집마감	https://jumpit.saramin.co.kr/position/50800	other	f
2100	SW 기반 머신 비전 개발자 채용	액스비스	대전 유성구	경력 3~15년	["C", "C++", "SW", "Mfc", "OpenCV", "HALCON"]	모집마감	https://jumpit.saramin.co.kr/position/50806	other	f
2101	레이저 공정 제어 소프트웨어 개발자	액스비스	대전 유성구	경력 3~15년	["C", "C++", "SW", "InSpec", ".NET", "C#"]	모집마감	https://jumpit.saramin.co.kr/position/50804	other	f
2102	소프트웨어 개발 엔지니어 채용	이서	대전 유성구	경력 2~5년	["C", "C++", "Python", "MachineLearning"]	모집마감	https://jumpit.saramin.co.kr/position/50945	other	f
2103	자동화 소프트웨어 엔지니어 채용	액스비스	대전 유성구	경력 4~15년	["Qt", "C#", "C", "C++", "Mfc", "Git", ".NET"]	모집마감	https://jumpit.saramin.co.kr/position/50799	other	f
2104	FPGA & DSP 펌웨어 개발 엔지니어	액스비스	대전 유성구	경력 2~15년	["VHDL", "FPGA", "Verilog"]	모집마감	https://jumpit.saramin.co.kr/position/50801	other	f
2105	SW/솔루션 정규직 채용(신입)	와이파워원	대전 유성구	신입	["C", "C++", "Embedded", "MCU", "FW"]	모집마감	https://jumpit.saramin.co.kr/position/50564	other	f
2106	Technical Support 엔지니어 주니어 채용(대전)	시스트란	대전 서구	경력 1~2년	["AI/인공지능", "Python", "Linux", "Docker"]	모집마감	https://jumpit.saramin.co.kr/position/51464	other	f
2107	SW/솔루션 정규직 채용(경력)	와이파워원	대전 유성구	경력 1~10년	["C", "C++", "Embedded", "MCU", "FW"]	모집마감	https://jumpit.saramin.co.kr/position/50563	other	f
2108	하드웨어 엔지니어 경력(7~10)	토모큐브	대전 유성구	경력 7~10년	["Git", "MATLAB", "Python", "C++", "VHDL"]	모집마감	https://jumpit.saramin.co.kr/position/50780	other	f
2109	DevOps 엔지니어	시스트란	대전 서구	경력 3~10년	["Python", "TensorFlow", "PyTorch", "NLP"]	모집마감	https://jumpit.saramin.co.kr/position/51465	other	f
2110	FPGA 시니어급 채용	인엘씨테크놀러지	대전 유성구	경력 10~20년	["FPGA", "Verilog"]	모집마감	https://jumpit.saramin.co.kr/position/50344	other	f
2121	2차전지 검사기 개발자 (경력5~7년)	아이비젼웍스	대전 유성구	경력 5~7년	["OpenCV", "C++", "Mfc"]	모집마감	https://jumpit.saramin.co.kr/position/50225	other	f
2123	5G/6G 코어망 소프트웨어 개발자	두두원	대전 유성구	경력 3~8년	["C", "C++", "Linux", "TCP/IP", "Socket.IO"]	모집마감	https://jumpit.saramin.co.kr/position/50510	other	f
2125	2차전지 검사기 개발자 (경력8~10년)	아이비젼웍스	대전 유성구	경력 8~10년	["OpenCV", "C++", "Mfc"]	모집마감	https://jumpit.saramin.co.kr/position/50226	other	f
2133	자율 점검드론/로봇 개발자 모집(4~6)	시에라베이스	울산 남구	경력 4~6년	["C++", "Visual C++", "C++ Builder", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/51250	other	f
2134	자율 점검드론/로봇 개발자 모집(7~10)	시에라베이스	울산 남구	경력 7~10년	["C++", "Visual C++", "C++ Builder", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/51251	other	f
2142	소프트웨어개발자 경력자 채용	라온솔루션	충북 청주시	경력 2~5년	["C", "C++", "C#", "Windows", "SW"]	모집마감	https://jumpit.saramin.co.kr/position/50342	other	f
2144	선행개발 경력 (3~5년)	제이티	충남 천안시	경력 3~5년	["HW", "FW", "MCU", "FPGA", "Linux", "C", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/50163	other	f
2145	선행개발 경력 (6~10년)	제이티	충남 천안시	경력 6~10년	["HW", "FW", "MCU", "FPGA", "Linux", "C", "C++"]	모집마감	https://jumpit.saramin.co.kr/position/50164	other	f
2150	이리온 로봇 자율주행 SW 개발(포항)	폴라리스쓰리디	경북 포항시	경력 2~7년	["SW", "C++", "Linux", "Git", "Notion"]	모집마감	https://jumpit.saramin.co.kr/position/50233	other	f
2161	PLM 시스템 운영/유지보수	이즈파크	경남 사천시	경력 5~15년	["Java", "Oracle", "MSSQL"]	모집마감	https://jumpit.saramin.co.kr/position/21804	other	f
2162	시스템 엔지니어 채용_신입	가야데이터	경남 진주시	신입	["Windows Server", "VMware vSphere"]	모집마감	https://jumpit.saramin.co.kr/position/51164	other	f
1136	풀스택 고급 개발자	지피에이코리아	서울 강남구	경력 7~10년	["Android", "iOS", "Java", "Kotlin", "Swift"]	모집마감	https://jumpit.saramin.co.kr/position/50857	other	f
1138	풀스택 중급 개발자	지피에이코리아	서울 강남구	경력 3~6년	["Android", "iOS", "Java", "Kotlin", "Swift"]	모집마감	https://jumpit.saramin.co.kr/position/50856	other	f
2113	하드웨어 엔지니어 경력(4~6)	토모큐브	대전 유성구	경력 4~6년	["Git", "MATLAB", "Python", "C++", "VHDL"]	모집마감	https://jumpit.saramin.co.kr/position/50779	other	f
2114	자율주행 H/W엔지니어[8~10년]	알지티	대전 중구	경력 8~10년	["C", "C++", "Python", "Orcad", "FW"]	모집마감	https://jumpit.saramin.co.kr/position/51584	other	f
2115	하드웨어 엔지니어 경력(1~3)	토모큐브	대전 유성구	경력 1~3년	["Git", "MATLAB", "Python", "C++", "VHDL"]	모집마감	https://jumpit.saramin.co.kr/position/50778	other	f
2116	자율주행 F/W엔지니어	알지티	대전 중구	경력 4~7년	["C", "C++", "Python", "Orcad", "FW"]	모집마감	https://jumpit.saramin.co.kr/position/51586	other	f
2117	자율주행 H/W엔지니어[5~7년]	알지티	대전 중구	경력 5~7년	["C", "C++", "Python", "Orcad", "FW"]	모집마감	https://jumpit.saramin.co.kr/position/51583	other	f
2137	전자제어 S/W 경력 개발자 모집	코아비스	세종	경력 1~10년	["FW", "Embedded", "C"]	모집마감	https://jumpit.saramin.co.kr/position/50182	other	f
2163	시스템 엔지니어 채용_1~3년	가야데이터	경남 진주시	경력 1~3년	["Windows Server", "VMware vSphere"]	모집마감	https://jumpit.saramin.co.kr/position/51162	other	f
2164	시스템 엔지니어 채용_4년이상	가야데이터	경남 진주시	경력 4~7년	["Windows Server", "VMware vSphere"]	모집마감	https://jumpit.saramin.co.kr/position/51163	other	f
2170	모바일앱 플러터 Flutter 개발자	아몬드컴퍼니	서울 강남구	경력 2~5년	["Flutter", "Android OS", "iOS", "REST API", "WebRTC", "Git", "Jira", "Zeplin"]	모집마감	https://jumpit.saramin.co.kr/position/52797	mobile	f
1909	임베디드 무선 펌웨어 개발자 모집	미라텍	경기 성남시	경력 5~10년	["Embedded", "C", "C++", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/51326	other	f
1910	PEP팀 ZTNA개발자	지니언스	경기 안양시	경력 10~15년	["C", "C++", "Linux", "VPN", "Linux Mint"]	모집마감	https://jumpit.saramin.co.kr/position/50598	other	f
1912	FPGA - HW Engineer (과장~차장급)	리브스메드	경기 성남시	경력 8~17년	["FPGA", "MCU", "VHDL"]	모집마감	https://jumpit.saramin.co.kr/position/50319	other	f
1831	하드웨어 개발자(신입)	캐스트프로	경기 성남시	신입	["HW"]	모집마감	https://jumpit.saramin.co.kr/position/50367	other	f
2997	Infra 엔지니어 (6~8년)	메타넷글로벌	서울 강남구	경력 6~8년	["Python", "· MSA", "· Kafka", "· MariaDB"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52900	backend	t
2126	네트워크 장비 구축 엔지니어 채용	유씨아이	대전 서구	신입~15년	["Ccna", "Cisco", "Network", "Ccie", "TCP/IP"]	모집마감	https://jumpit.saramin.co.kr/position/49883	other	f
2127	의료기기 S/W 개발자(대전, 경력 7~10년)	프리시젼바이오	대전 유성구	경력 7~10년	["C", "C++", "Mfc", "Qt", "Embedded Linux"]	모집마감	https://jumpit.saramin.co.kr/position/51497	other	f
2128	[대전 서구] 네트워크/보안 엔지니어 채용	에스넷아이씨티	대전 서구	경력 5~12년	["Cisco", "Network", "Ccna", "Ccnp"]	모집마감	https://jumpit.saramin.co.kr/position/50067	other	f
2129	의료기기 S/W 개발자(대전, 경력 3~6년)	프리시젼바이오	대전 유성구	경력 3~6년	["C", "C++", "Mfc", "Qt", "Embedded Linux"]	모집마감	https://jumpit.saramin.co.kr/position/51496	other	f
2130	자율점검 드론/로봇 개발자(석사이상)	시에라베이스	울산 남구	신입	["C++", "Visual C++", "C++ Builder", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/51248	other	f
2131	자율 점검드론/로봇 개발자 모집(1~3)	시에라베이스	울산 남구	경력 1~3년	["C++", "Visual C++", "C++ Builder", "Python"]	모집마감	https://jumpit.saramin.co.kr/position/51249	other	f
2171	풀스택 개발자 (Next.js/React 외)	유리프트	서울 강남구	경력 4~10년	["Next.js", "· React", "· TypeScript", "· Firebase Realtime Database", "· TailwindCSS"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52132	frontend	t
2172	서버개발팀 모바일 개발자(경력)	사이버다임	서울 송파구	경력 5~15년	["Android Studio", "· Node.js", "· Webpack", "· Redux", "· React Native", "· Recoil"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51567	backend	t
2173	메세징 서비스 개발자 채용	디어유	서울 강남구	경력 3~7년	["Java", "· REST API", "· AWS", "· Spring Boot", "· Python", "· MySQL", "· NoSql", "· Django"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52208	backend	t
2174	모바일앱 플러터 Flutter 개발자	아몬드컴퍼니	서울 강남구	경력 2~5년	["Flutter", "· Android OS", "· iOS", "· REST API", "· WebRTC", "· Git", "· Jira", "· Zeplin"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52797	mobile	t
2175	단백질 서열 및 구조 생성 모델 연구자	에이인비	경기 과천시	신입~10년	["AI/인공지능", "· DeepLearning", "· MachineLearning", "· Python"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52330	backend	t
2176	프론트엔드 개발자 (Next.js/React 외)	유리프트	서울 강남구	경력 4~10년	["Next.js", "· React", "· TypeScript", "· Firebase Realtime Database", "· GCP"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52133	frontend	t
2177	브랜다즈 백엔드개발자(자바/코틀린)	헤렌	서울 성동구	경력 3~15년	["Java", "· Kotlin", "· Spring Boot", "· Mybatis", "· MariaDB", "· MySQL", "· DataGrip"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51754	backend	t
2178	[공비서] 자바/코틀린 백엔드 개발자	헤렌	서울 성동구	경력 4~25년	["Java", "· Kotlin", "· Spring Boot", "· Mybatis", "· MariaDB", "· MySQL", "· DataGrip"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51753	backend	t
2179	소프트웨어 QA/테스터	티엔에이치	경기 성남시	신입~2년	["QA"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51752	other	t
2180	자율주행 임베디드 SW 엔지니어(전문연 지원 가능)	에이스웍스코리아	서울 강남구	경력 1~7년	["C", "· Python", "· Embedded", "· FW", "· ethernet", "· RTOS", "· MCU"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52628	backend	t
2181	[코스닥상장사] iOS 앱 개발자 채용	디어유	서울 강남구	경력 5~10년	["iOS", "· Swift", "· Objective-C", "· REST API", "· SQLite", "· Git"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52542	mobile	t
2182	사내 시스템 담당자, ERP팀(대리-과장급)	리브스메드	경기 성남시	경력 4~12년	["ERP", "· MES", "· React Query", "· Kubernetes", "· MSA", "· Deta Cloud"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52681	frontend	t
2183	보안 솔루션 개발자 모집 공고 (Java기반)	위드네트웍스	서울 강서구	경력 5~10년	["Java", "· Spring", "· Vue.js"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51951	backend	t
2184	Prompt Engineer	보이스루	서울 강남구	신입	["NLP", "· Python", "· REST API", "· AWS", "· MachineLearning"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51731	backend	t
2185	[IT Infra]IT Administrative Engineer	오픈엣지테크놀로지	서울 강남구	경력 1~14년	["Shell", "· Docker", "· Kubernetes", "· Jenkins", "· Ansible", "· Git", "· Grafana"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52590	mobile	t
2186	Java(Back-End)개발자 [리더급 9~20년]	제네시스네스트	경기 용인시	경력 9~20년	["Spring", "· Java", "· Linux", "· Blockchain", "· MySQL", "· Oracle", "· REST API", "· Solidity"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52372	backend	t
2187	인증보안 백엔드 개발자	펜타시큐리티	서울 영등포구	경력 3~5년	["Spring Boot", "· Java", "· MariaDB", "· Mybatis"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52538	backend	t
2188	블록체인 엔지니어 채용	알로카도스	서울 강남구	경력 3~10년	["Blockchain", "· Solidity", "· Rust", "· Python", "· JavaScript"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51808	backend	t
2189	[코스닥 상장사] SRE 포지션 채용	디어유	서울 강남구	경력 3~10년	["AWS", "· Linux", "· Docker", "· Kubernetes", "· Redis", "· Kafka", "· Windows"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52720	mobile	t
2191	[플레이오] 안드로이드 개발자 (2년 이상)	지엔에이컴퍼니	서울 서초구	경력 2~5년	["Android OS", "· Kotlin", "· REST API", "· Android SDK", "· Lottie", "· Zeplin", "· Slack"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52682	mobile	t
2192	[플레이오] Python 백엔드	지엔에이컴퍼니	서울 서초구	경력 3~5년	["Python", "· REST API", "· AWS", "· MySQL", "· GitHub", "· Docker Swarm", "· FastAPI"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52701	backend	t
2193	[서울] Sr.프론트엔드 개발 (3년 ↑)	크리스틴컴퍼니	서울 강남구	경력 3~99년	["React", "· Next.js", "· TypeScript", "· React Query", "· Zustand", "· REST API"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52742	frontend	t
2194	프라이빗 클라우드 제품 개발	파이오링크	서울 금천구	신입~20년	["Linux", "· Python", "· C", "· Golang", "· Ansible", "· OpenStack", "· Kubernetes", "· GitHub"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52357	backend	t
2195	Node.js 백엔드 개발자 (3~5년)	티엔에이치	경기 성남시	경력 3~5년	["Node.js", "· JavaScript", "· TypeScript", "· MySQL", "· Linux"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52503	backend	t
2196	Entry-Level Software Engineer	두나미스아트테크놀로지스	서울 강남구	신입~2년	["Python", "· AWS", "· Docker", "· FastAPI", "· Flask", "· React", "· PostgreSQL", "· Redis"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52913	backend	t
2197	AI 엔지니어	바로팜	서울 강남구	경력 3~10년	["DeepLearning", "· Python"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52752	backend	t
2198	자율주행 차량제어 엔지니어 (전문연 지원 가능)	에이스웍스코리아	서울 강남구	경력 1~10년	["C++", "· Python"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52623	backend	t
2199	Java(Back-End)개발자 [경력 1~8년]	제네시스네스트	경기 용인시	경력 1~8년	["Spring", "· Java", "· Linux", "· Blockchain", "· Spring Framework", "· MySQL"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52373	backend	t
2200	딥러닝 / 이미지 프로세싱 연구 개발	스키아	서울 구로구	신입~3년	["OpenCV", "· PyTorch"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52786	data	t
2201	AI 시스템 개발 및 AI 프로젝트 관리	호전실업	서울 마포구	경력 10~13년	["AI/인공지능", "· Python", "· Java", "· JavaScript", "· MachineLearning"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52235	backend	t
2202	PHP 웹개발자 채용 (경력 6~8년)	엠투피아이	서울 성동구	경력 6~8년	["PHP", "· MySQL", "· Apache Tomcat", "· Linux", "· Laravel", "· XML", "· CSS 3"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52573	backend	t
2203	IP Verification Engineer	오픈엣지테크놀로지	서울 강남구	경력 4~14년	["Verilog", "· C", "· C++", "· Python", "· Perl"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52588	backend	t
2204	FPGA - HW Engineer (과장~차장급)	리브스메드	경기 성남시	경력 8~17년	["FPGA", "· MCU", "· VHDL"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52334	data	t
2205	FW 펌웨어 개발(7년 이상)	윌로그	서울 강남구	경력 7~12년	["FW", "· MCU", "· RTOS", "· C", "· C++", "· Git", "· HW"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52832	other	t
2206	백엔드 개발자(5-8년 경력)	싸이터	서울 금천구	경력 5~8년	["Spring Boot", "· Kubernetes", "· MySQL", "· Kafka", "· Elasticsearch", "· REST API"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52877	backend	t
2207	유니트체어 HW개발	덴티움	경기 수원시	경력 3~8년	["HW", "· FW", "· Orcad", "· Pads", "· ARM"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53101	other	t
2208	PHP 웹개발자 채용 (경력 3~5년)	엠투피아이	서울 성동구	경력 3~5년	["PHP", "· MySQL", "· Apache Tomcat", "· Linux", "· Laravel", "· XML", "· CSS 3"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52574	backend	t
2209	WEBFRONT-K 웹보안기능 / 시그니처개발	파이오링크	서울 금천구	경력 3~13년	["C", "· C++", "· Python", "· Linux", "· Java"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52883	backend	t
2210	DevOps 엔지니어(9-12년 경력)	싸이터	서울 금천구	경력 9~12년	["Kubernetes", "· Kafka", "· Redis", "· Elasticsearch", "· MSA", "· ISMS", "· Java", "· AWS"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52876	backend	t
2211	[WBCT] Medical CBCT 3D뷰어 SW개발	덴티움	경기 수원시	경력 3~7년	["c", "· c++", "· c#", "· OpenGL", "· WPF"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51996	other	t
2212	보안 네트워크 개발자 (경력)	펜타시큐리티	서울 영등포구	경력 7~20년	["Firewall", "· C++", "· Linux", "· TCP/IP", "· Python", "· Shell", "· C", "· Network"]	D-7	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51945	backend	t
2213	SAP 운영/개발(CO모듈)	한국네트웍스	경기 성남시	경력 10~20년	["SAP", "· ABAP"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52473	other	t
2214	CAD Engineer - 전문연구요원 가능	이마고웍스	서울 강남구	신입	["TypeScript", "· C++", "· CMake", "· OpenGL"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52465	frontend	t
2215	[MemoryController]RTLDesign Engineer	오픈엣지테크놀로지	서울 강남구	경력 2~15년	["Verilog", "· C", "· Python", "· C++"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52592	backend	t
2216	백엔드 개발자 채용	얼리페이	서울 영등포구	경력 4~10년	["Python", "· MVVM", "· AWS", "· Django", "· AWS Batch"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52646	backend	t
2217	네트워크장비 Web Management 솔루션개발	파이오링크	서울 금천구	경력 3~12년	["Python", "· C", "· C++", "· Linux", "· AWS", "· Spring Framework"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52793	backend	t
2218	데브옵스(DevOps) 엔지니어 (5년 이상)	씨드앤	서울 송파구	경력 5~10년	["Linux", "· Kafka", "· AWS", "· AZURE", "· Java", "· MySQL", "· Redis", "· MongoDB"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53085	backend	t
2219	[DRAM PHY] Digital Engineer	오픈엣지테크놀로지	서울 강남구	경력 2~15년	["Verilog", "· C", "· Python"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52594	backend	t
2220	QA 경력직 채용	베이리스	경기 성남시	경력 5~20년	["Git", "· Jenkins", "· QA", "· SW"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52178	other	t
2221	Cloud 백엔드 개발자 (5년 이상)	이우소프트	경기 화성시	경력 5~10년	["TypeScript", "· JavaScript", "· Node.js", "· ExpressJS", "· NestJS", "· PostgreSQL"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52379	backend	t
2222	QA 엔지니어 (2년 이상)	마카롱팩토리	경기 성남시	경력 2~5년	["Android OS", "· iOS", "· QA", "· Postman", "· MySQL"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52798	mobile	t
2223	광고 비즈니스 플랫폼 테스트엔지니어 (3년이상)	이노아이	경기 성남시	경력 3~4년	["iOS", "· Jira", "· Confluence", "· Android OS", "· Postman", "· Redmine", "· Slack", "· QA"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52956	mobile	t
2224	Solution Developer	이마고웍스	서울 강남구	경력 3~7년	["TypeScript", "· WebGL", "· Webpack", "· React", "· C++", "· CMake", "· OpenGL"]	D-25	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52982	frontend	t
2225	백엔드 개발자(Backend Developer)	더블엔씨	서울 강남구	경력 4~7년	["TypeScript", "· Node.js", "· NestJS", "· ExpressJS", "· TypeORM"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52463	backend	t
2226	Digital Logic 개발/분당R&D	아이디어스투실리콘	경기 성남시	경력 3~15년	["Verilog", "· C", "· C++", "· C#", "· Python", "· VHDL", "· FPGA", "· TCP/IP", "· ASIC", "· Perl"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51627	backend	t
2227	애플리케이션 및 클라우드 개발 (전문연구요원)	파이오링크	서울 금천구	신입~7년	["AngularJS", "· Linux", "· Java", "· JavaScript", "· SQL", "· jQuery", "· Python", "· C"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52890	backend	t
2228	WEBFRONT-K GUI 개발	파이오링크	서울 금천구	경력 3~13년	["Java", "· C", "· C++", "· Linux", "· Django", "· REST API"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52884	backend	t
2229	DevOps Engineer (3년 이상)	아보엠디코리아	서울 강남구	경력 3~6년	["AWS", "· GitHub", "· GCP"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53167	other	t
2230	시니어 클라우드 인프라 엔지니어 채용	알로카도스	서울 강남구	경력 5~15년	["Terraform", "· MongoDB", "· Amazon DynamoDB", "· Kafka", "· Ansible", "· AWS"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51809	backend	t
2231	Windows 개발자	펜타시큐리티	서울 영등포구	경력 2~5년	["C#", "· C++", "· C", "· Windows"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52990	other	t
2232	Project Manager (3년 이상)	이우소프트	경기 화성시	경력 3~10년	["Jira", "· Azure DevOps", "· Confluence"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52378	other	t
2233	React Native 개발자	안전집사	서울 영등포구	경력 1~3년	["React Native", "· TypeScript", "· Git", "· Zustand", "· Firebase", "· AWS"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53009	frontend	t
2234	기구설계 엔지니어 (경력)	에이스웍스코리아	서울 강남구	경력 3~10년	["Autocad", "· Solidworks"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51902	other	t
2235	APLUS AI_CORE_백엔드 엔지니어	버즈니	서울 관악구	경력 2~10년	["Python", "· AWS", "· Kubernetes", "· TensorFlow", "· PyTorch", "· Helm", "· MySQL"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53133	backend	t
2246	Medical CBCT HW개발	덴티움	경기 수원시	경력 2~7년	["Orcad", "· Pads"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51998	other	t
2236	SW Engineer:어플리케이션	리브스메드	경기 성남시	경력 3~12년	["SW", "· C", "· C++", "· Qt", "· GUI", "· Embedded Linux", "· Linux"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52336	other	t
2237	프라이빗 클라우드 제품 개발- 전문연구요원	파이오링크	서울 금천구	신입~20년	["Linux", "· Python", "· C", "· Golang", "· Ansible", "· OpenStack", "· Kubernetes", "· GitHub"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52358	backend	t
2238	어플리케이션 개발자 채용	스콥정보통신	서울 서초구	경력 3~15년	["C", "· C++", "· Linux", "· TCP/IP", "· L2", "· L3", "· L4", "· Go", "· Git", "· Network"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53146	backend	t
2239	App 개발자 (React Native)	솔닥	서울 강남구	경력 3~10년	["React Native", "· Android OS", "· iOS", "· JavaScript", "· TypeScript", "· WebRTC"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52872	backend	t
2240	백엔드 개발자 경력 (5년이상)	디윅스	서울 강남구	경력 5~20년	["Spring Framework", "· AI/인공지능", "· REST API", "· Spring Boot", "· Linux", "· Java"]	D-25	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53078	backend	t
2241	MES 시스템 개발리더 (10년이상~)	에스엠해썹	대구 서구	경력 10~15년	["Java", "· Spring Boot", "· Python", "· Flask", "· Django", "· MariaDB", "· MongoDB"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52964	backend	t
2242	백엔드 개발자(9-12년 경력)	싸이터	서울 금천구	경력 9~12년	["Spring Boot", "· Kubernetes", "· MySQL", "· Kafka", "· Elasticsearch", "· REST API"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52878	backend	t
2243	Tech Innovation 워킹그룹 풀스택 개발	프리윌린	서울 관악구	경력 8~15년	["TypeScript", "· AWS", "· Spring", "· RDB", "· Kotlin"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52788	backend	t
2244	개발 기획 및 관리	프라이빗테크놀로지	서울 마포구	경력 7~20년	["Jira", "· Network", "· Infra", "· Insight", "· ISMS"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53053	other	t
2245	LLM RAG 개발자 (경력)	엔닷라이트	경기 성남시	경력 2~10년	["NLP", "· AI/인공지능", "· Python"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51690	backend	t
2247	전력변환 시뮬레이션 엔지니어 (전문연 지원 가능)	에이스웍스코리아	서울 강남구	경력 1~15년	["MATLAB"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52629	other	t
2248	머신러닝 엔지니어 - 시니어	심플랫폼	서울 금천구	경력 6~15년	["Python", "· PyTorch", "· TensorFlow", "· DVC", "· Docker", "· Helm", "· Spark"]	D-25	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53175	backend	t
2249	[Network-on-Chip]RTL Design Engineer	오픈엣지테크놀로지	서울 강남구	경력 2~15년	["Verilog", "· C", "· Python"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52597	backend	t
2250	보안관제 개발	프라이빗테크놀로지	서울 마포구	경력 3~20년	["Network", "· Infra", "· Python", "· DB", "· ELK", "· Splunk", "· Docker", "· Redis"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53054	backend	t
2251	Sr. Backend Engineer	에이아이트릭스	서울 강남구	경력 5~10년	["MongoDB", "· Golang", "· MySQL", "· Python"]	D-7	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52017	backend	t
2252	React/React Native 프론트엔드 개발자	페이워크	서울 강남구	경력 3~8년	["HTML5", "· CSS 3", "· JavaScript", "· React", "· React Native", "· redux-saga"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52198	backend	t
2253	임베디드(펌웨어) 개발자	크래블	서울 성동구	신입	["HW", "· Linux", "· SW", "· MCU"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52549	other	t
2254	Backend Engineer(5년 이상)	콜로세움코퍼레이션	서울 강남구	경력 5~12년	["Java", "· Gradle", "· Kotlin", "· Spring Boot", "· Spring Batch", "· MySQL"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52370	backend	t
2255	Backend Engineer (Backend 엔지니어)	메이아이	서울 강남구	경력 1~3년	["FastAPI", "· Django", "· PostgreSQL", "· MySQL", "· Kafka", "· Airflow", "· Docker"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51864	backend	t
2256	산업용 모니터 개발	엠투아이코퍼레이션	경기 안양시	신입~3년	["HW", "· Embedded", "· MCU", "· Circuit design", "· PCB", "· Orcad", "· Pads"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51641	other	t
2257	백엔드 개발자	디플래닉스	서울 서초구	경력 8~12년	["Java", "· Spring Boot", "· Spring Data JPA", "· Mybatis", "· PostgreSQL", "· MySQL"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52159	backend	t
2258	Node.js 백엔드 개발자	드리븐	서울 강남구	경력 3~10년	["Node.js", "· MySQL", "· GitHub", "· React", "· Next.js", "· Jira", "· Confluence"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51756	backend	t
2259	웹 프론트엔드 개발자(React 4년 이상)	라라잡	서울 강서구	경력 4~15년	["React Native", "· JavaScript", "· TypeScript", "· Next.js", "· React Query", "· Zustand"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52376	backend	t
2260	안드로이드 개발자(신입)	레트리카	서울 서초구	신입~2년	["Java", "· RxJava", "· OpenGL", "· OpenCV"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53033	backend	t
2261	의료기기 백엔드 개발자 모집	에이엠시지	서울 서초구	경력 3~10년	["Python", "· FastAPI", "· Node.js", "· Fastify", "· ExpressJS", "· WebSocket", "· NumPy"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52950	backend	t
2262	[전문연구요원]AI엔지니어-Product	업스테이지	경기 용인시	신입~20년	["Python", "· Java", "· AI/인공지능", "· Ubuntu", "· Windows"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52278	backend	t
2263	프론트엔드 개발자 (3~5년)	아론티어	서울 서초구	경력 3~5년	["JavaScript", "· React", "· REST API", "· vuex", "· Redux", "· Webpack", "· Git"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52487	backend	t
2264	사내 시스템 개발자	펜타시큐리티	서울 영등포구	경력 3~10년	["Java", "· PHP", "· JavaScript", "· Git", "· MariaDB", "· Docker", "· Linux", "· Jenkins"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52088	backend	t
2265	백엔드 엔지니어	스패로우	서울 마포구	경력 5~10년	["Redis", "· Java", "· SQL", "· AWS", "· RDB", "· PostgreSQL", "· Spring Framework"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52049	backend	t
2266	AI 컴파일러 엔지니어 채용	에너자이	서울 강남구	신입~10년	["C++", "· Haskell", "· DeepLearning", "· F#", "· TensorFlow", "· Scala", "· PyTorch", "· C"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51799	mobile	t
2267	네트워크 엔지니어 정규직 채용	링네트	서울 구로구	경력 2~8년	["Network", "· L2", "· L3", "· L4", "· L7", "· Router", "· Switch", "· Cisco"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52842	other	t
2268	[긴급] 웹개발자 모집 (jsp,java)	상록아이엔씨	경기 부천시	신입~5년	["JSP", "· Java", "· JavaScript", "· React", "· Spring Boot", "· TypeScript", "· ExpressJS"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/12030	backend	t
2269	자사 HR Platform 서비스 개발팀장	아인잡	서울 강남구	경력 5~15년	["MySQL", "· Java", "· AWS", "· NoSql", "· Docker", "· Spring Framework"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51937	backend	t
2270	Runtime 소프트웨어 엔지니어 채용	에너자이	서울 강남구	신입	["AI/인공지능", "· C++", "· MachineLearning", "· Python", "· C"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51800	backend	t
2271	광고 시스템 SDK QA 담당자(경력 3년이상)	와이즈버즈	경기 성남시	경력 3~7년	["Android SDK"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52507	mobile	t
2272	데이터 엔지니어 (데이터레이크 개발)	스패로우	서울 마포구	경력 5~10년	["PostgreSQL", "· Kubernetes", "· Docker", "· Spark", "· Java", "· Kotlin", "· Scala"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52048	backend	t
2273	개발(파워빌더) 및 ERP 구축 경험 경력	호전실업	서울 마포구	경력 5~11년	["Power builder", "· ERP", "· MSSQL", "· Oracle", "· RDB"]	D-25	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52934	other	t
2274	Medical CBCT 기구설계	덴티움	경기 수원시	경력 8~12년	["Autocad", "· Solidworks"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51965	other	t
2275	Platform Development Engineer	두나미스아트테크놀로지스	서울 강남구	경력 3~10년	["Python", "· AWS", "· FastAPI", "· Flask", "· React", "· PostgreSQL", "· Redis", "· Linux"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52914	backend	t
2276	[삼성계열사]임베디드 S/W(안드로이드)	씨브이네트	서울 송파구	경력 3~20년	["Qt", "· ARM", "· Linux", "· Android OS", "· Embedded", "· SW", "· C++"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52658	mobile	t
2277	ML Engineer / Researcher	에너자이	서울 강남구	신입	["AI/인공지능", "· C++", "· MachineLearning", "· Python", "· C", "· PyTorch", "· Keras"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53047	backend	t
2278	JAVA,넥사크로 개발자	트윈스엔씨	서울 송파구	경력 7~15년	["Java", "· ERP"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52854	backend	t
2279	[병역특례_전문연구요원] 머신러닝 엔지니어 (LLM)	마키나락스	서울 서초구	신입	["NLP", "· Python", "· AI/인공지능", "· MachineLearning"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53112	backend	t
2280	S/W Engineer-Perception [전문연구요원가능]	토르드라이브	서울 영등포구	경력 3~10년	["C", "· C++", "· CUDA"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51971	other	t
2281	SW 라이브러리 개발자 모집	모픽	경기 안양시	경력 5~15년	["C", "· C++"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52841	other	t
2282	NPU Design Engineer	아이에이치더블유	경기 용인시	경력 3~20년	["EDA", "· Verilog", "· AI/인공지능", "· MachineLearning", "· Embedded", "· HW"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52571	mobile	t
2283	DevOps 엔지니어 (16년 ~ 20년)	데이터메이커	대전 유성구	경력 16~20년	["Terraform", "· Pulumi", "· GoLand", "· Argo", "· Linux", "· Ansible", "· Kubernetes"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51833	backend	t
2284	프론트엔드 개발자 채용(팀장급)	이파피루스	경기 성남시	경력 10~15년	["AngularJS", "· TypeScript", "· RxJS", "· Sass", "· GitLab", "· Jenkins", "· AWS", "· Vue.js"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52411	frontend	t
2565	AI Enterprise Manager	업스테이지	경기 용인시	경력 5~20년	["AI/인공지능"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52247	data	t
2285	AI기반 단백질 디자인 (병역특례)	아론티어	서울 서초구	경력 2~10년	["AI/인공지능", "· Linux", "· Python", "· GitHub", "· PyTorch"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52486	backend	t
2286	비행선 제어 SW/HW 개발	이카루스	광주 북구	신입	["C++"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52502	other	t
2287	S/W Engineer-SLAM [전문연구요원가능]	토르드라이브	서울 영등포구	경력 3~10년	["C++", "· ROS", "· Linux", "· Docker", "· Git"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51967	other	t
2288	[주4.5일] 네트워크 엔지니어 (5-10년)	에어키	서울 서초구	경력 5~10년	["Network", "· Cisco", "· TCP/IP", "· VPN", "· AWS", "· AZURE", "· Ccna", "· Ccnp", "· Ccie"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52857	other	t
2289	선행개발 경력 (3~5년)	제이티	충남 천안시	경력 3~5년	["HW", "· FW", "· MCU", "· FPGA", "· Linux", "· C", "· C++", "· C#", "· Orcad", "· Pads"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52025	other	t
2290	Backend Engineer (Go)	센트비	서울 영등포구	경력 4~10년	["Golang", "· gRPC", "· PostgreSQL", "· Redis", "· Git", "· Docker", "· Jira", "· Confluence"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52987	backend	t
2291	에듀테크(EduTech) 웹 서비스 풀스택 개발자	블루가	경기 성남시	경력 7~10년	["JavaScript", "· TypeScript", "· Node.js", "· NestJS", "· React"]	D-4	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51561	backend	t
2292	[주4.5일] 네트워크 엔지니어 (11-15년)	에어키	서울 서초구	경력 11~15년	["Network", "· Cisco", "· TCP/IP", "· VPN", "· AWS", "· AZURE", "· Ccna", "· Ccnp", "· Ccie"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53102	other	t
2293	FMS 설계,개발 S/W 엔지니어 [전문연구요원가능]	토르드라이브	서울 영등포구	경력 3~10년	["C", "· C++", "· CUDA", "· React", "· Kubernetes", "· gRPC", "· Golang", "· MQTT"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51972	backend	t
2294	서버 및 인프라 개발자 (11년 ~ 15년)	데이터메이커	대전 유성구	경력 11~15년	["Terraform", "· Pulumi", "· Golang", "· Argo", "· Linux", "· Ansible", "· Python", "· Shell"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51838	backend	t
2295	정보보안 담당자(경력 6~8년)	엑심베이	서울 구로구	경력 6~8년	["ISMS", "· FW", "· Network", "· Jira", "· Confluence", "· AWS", "· AWS WAF"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52816	other	t
2296	AI기반 바이오마커 예측 (병역특례)	아론티어	서울 서초구	경력 2~10년	["AI/인공지능", "· Linux", "· Python", "· GitHub", "· PyTorch"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52485	backend	t
2297	백엔드 개발자(JAVA) 개발자[10~15년]	이파피루스	경기 성남시	경력 10~15년	["Java", "· Spring Framework", "· Spring", "· Spring Boot", "· Spring Cloud", "· Jenkins"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52585	backend	t
2298	[Django,Spring] Backend Engineer (5-10년)	에이아이커넥트	서울 금천구	경력 5~10년	["Spring Boot", "· PostgreSQL", "· AWS", "· Docker", "· Kubernetes", "· Redis", "· Kotlin"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52219	backend	t
2299	Robot Control Engineer (전문연 가능)	플라잎	경기 성남시	경력 3~10년	["AI/인공지능", "· C", "· C++", "· Python", "· MachineLearning", "· ROS"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51876	backend	t
2300	자율주행 개발자(신입~3년차)	긴트	경기 성남시	신입~3년	["MATLAB", "· C", "· C++", "· SW", "· Python"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52926	backend	t
2301	Frontend Engineer(Lead)	콜로세움코퍼레이션	서울 강남구	경력 5~10년	["React", "· Next.js", "· TypeScript", "· Storybook", "· Emotion", "· JavaScript", "· jQuery"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52369	backend	t
2302	ML Engineer (3년 ~ 7년)	데이터메이커	대전 유성구	경력 3~7년	["Git", "· Ubuntu", "· NLP", "· Kubeflow", "· Kubernetes", "· TensorFlow", "· Python"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51828	backend	t
2303	USB Device SDK 개발_3년이상	엑스페릭스	경기 성남시	경력 3~6년	["Windows", "· Linux", "· C++", "· SW", "· C#", "· Java"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51879	backend	t
2304	[DRAM PHY]SiliconValidation Engineer	오픈엣지테크놀로지	서울 강남구	경력 2~15년	["C", "· Python"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52596	backend	t
2305	쇼핑몰서비스 PHP 개발자 3년↑ 모집	유디아이디	서울 구로구	경력 3~5년	["PHP", "· MySQL", "· MongoDB", "· Laravel", "· GitLab", "· JavaScript", "· jQuery"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52918	backend	t
2306	쇼핑몰서비스 PHP 개발자 6년 ↑ 모집	유디아이디	서울 구로구	경력 6~9년	["PHP", "· MySQL", "· MongoDB", "· Laravel", "· GitLab", "· JavaScript", "· jQuery"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52919	backend	t
2307	USB Device SDK 개발_7년이상	엑스페릭스	경기 성남시	경력 7~10년	["Windows", "· Linux", "· C++", "· SW", "· C#", "· Java"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51880	backend	t
2308	AMS사업부 PM 채용	유진로봇	인천 연수구	경력 10~15년	["Analog", "· Embedded"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52656	other	t
2309	쇼핑몰서비스 PHP 개발자 10년↑ 모집	유디아이디	서울 구로구	경력 10~20년	["PHP", "· MySQL", "· MongoDB", "· Laravel", "· GitLab", "· JavaScript", "· jQuery"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52920	backend	t
2310	개발본부C/C++ 엔지니어(Middleware)	유진로봇	인천 연수구	경력 4~15년	["C++", "· ROS", "· C", "· GUI"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52650	data	t
2311	서버 개발 (5년 이상)	마카롱팩토리	경기 성남시	경력 3~10년	["Spring", "· Kotlin", "· Java", "· AWS", "· MySQL", "· Redis", "· Git", "· Dynamo", "· Druid"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52799	backend	t
2312	iOS 개발 (5년 이상)	마카롱팩토리	경기 성남시	경력 5~10년	["iOS", "· Xcode", "· Flutter", "· Swift", "· Rxswift"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52800	mobile	t
2313	[CT] 의료영상처리 알고리즘 SW	덴티움	경기 수원시	경력 2~10년	["C++", "· OpenCV", "· CUDA", "· SW"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52000	other	t
2314	AI Field Application Engineer	에너자이	서울 강남구	신입	["PyTorch", "· TensorFlow", "· yolo", "· CUDA", "· Embedded", "· AI/인공지능"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53049	data	t
2315	ML 프로젝트 연구원 경력직 채용	하이스트레인저	서울 중구	경력 1~10년	["Python", "· MachineLearning", "· DeepLearning"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52416	backend	t
2316	SAS사업부 글로벌프로젝트 PM채용	유진로봇	인천 연수구	경력 10~15년	["Google Analytics", "· SQL", "· Microsoft Excel"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52657	backend	t
2317	어플리케이션 및 클라우드 개발	파이오링크	서울 금천구	경력 3~13년	["Java", "· Spring", "· Linux", "· Django", "· Python", "· REST API"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52881	backend	t
2318	프론트엔드 개발자 경력 (5년 이상)	디윅스	서울 강남구	경력 5~20년	["JavaScript", "· TypeScript", "· React", "· HTML5", "· Vue.js", "· AngularJS", "· CSS 3"]	D-25	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53077	backend	t
2319	소프트웨어 엔지니어 (경력)	에이스웍스코리아	서울 강남구	경력 3~12년	["C#", "· labview", "· sw", "· C", "· C++"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52070	other	t
2320	Full stack(풀스택) 개발자 모집[9년 이상]	알지티	대전 중구	경력 9~15년	["JavaScript", "· Python", "· TypeScript", "· Amazon RDS", "· AWS Lambda"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52456	backend	t
2321	[인공지능솔루션] Backend Engineer	제논	서울 강남구	경력 3~20년	["Docker", "· Python", "· FastAPI", "· GitHub", "· Django", "· Jira", "· NoSql", "· Flask", "· Linux"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52687	backend	t
2322	HW/FW Engineer (과장~차장급)	리브스메드	경기 성남시	경력 7~20년	["FPGA", "· MCU", "· VHDL", "· HW", "· FW", "· Embedded Linux", "· Orcad", "· C"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52994	data	t
2323	시스템 개발자 채용	스콥정보통신	서울 서초구	경력 3~15년	["C++", "· Go", "· Python", "· Vault", "· LDAP", "· Kubernetes", "· Rust", "· Linux", "· Network"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53145	backend	t
2324	APLUS AI_숏폼_백엔드 엔지니어	버즈니	서울 관악구	경력 2~10년	["Python", "· AWS", "· Amazon EKS", "· Kubernetes", "· Sentry", "· Prometheus"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53132	backend	t
2325	플러터 프론트 APP 개발[경력]	패션앤스타일컴퍼니	서울 종로구	경력 2~10년	["Flutter", "· iOS", "· Android OS", "· GitHub", "· Git", "· Figma"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53032	mobile	t
2326	Medical CBCT제어 FW개발	덴티움	경기 수원시	경력 3~7년	["C", "· C++"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51997	other	t
2327	웹 개발자 경력직 채용(3년 이상)	네비웍스	경기 안양시	경력 3~7년	["React", "· NestJS", "· SQL", "· REST API", "· Git", "· ExpressJS"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52151	backend	t
2328	자율주행 경로생성 SW 엔지니어(전문연 지원 가능)	에이스웍스코리아	서울 강남구	경력 3~15년	["C++", "· Python"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52624	backend	t
2329	보안 솔루션 엔지니어 (신입/경력)	위드네트웍스	서울 강서구	신입~5년	["Python"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52880	backend	t
2330	AI Engineer - 전문연구요원 가능	이마고웍스	서울 강남구	신입	["TypeScript", "· Python", "· C++", "· CMake"]	D-25	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52981	backend	t
2331	로봇 관제 시스템 설계 개발자 [리더]	클로봇	경기 성남시	경력 10~20년	["Spring", "· Spring Boot", "· DB", "· Docker", "· Kubernetes", "· Git", "· MSA"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52421	backend	t
2332	[NPU] System SW Engineer	오픈엣지테크놀로지	서울 강남구	신입~15년	["Linux", "· C", "· C++", "· TensorFlow", "· PyTorch"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52591	data	t
2333	Back-end 개발자 (시니어)	엔닷라이트	경기 성남시	경력 8~15년	["REST API", "· AWS", "· Node.js", "· MySQL", "· NestJS"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52666	backend	t
2334	Node.js 백엔드 개발자 (6~8년)	티엔에이치	경기 성남시	경력 6~8년	["Node.js", "· JavaScript", "· TypeScript", "· MySQL", "· Linux"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52504	backend	t
2335	SaaS 백엔드 개발자 (경력 2~5년)	에스엠해썹	경기 오산시	경력 2~5년	["Python", "· Django", "· Django REST framework", "· MariaDB", "· MongoDB", "· Git"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52515	backend	t
2336	전장설계 엔지니어 (경력)	에이스웍스코리아	서울 강남구	경력 3~10년	["Autocad", "· Solidworks"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52626	other	t
2337	[DRAM PHY] Analog Engineer	오픈엣지테크놀로지	서울 강남구	경력 2~15년	["Verilog", "· C", "· Python"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52589	backend	t
2338	자율주행 F/W엔지니어 (4~7년차)	알지티	대전 중구	경력 4~7년	["C", "· C++", "· Python", "· Orcad", "· FW"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52454	backend	t
2339	Visual SLAM 개발자	클로봇	경기 성남시	경력 2~10년	["Linux", "· Python", "· C++", "· ROS", "· Git"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52407	backend	t
2340	백엔드(Back-end)개발자(경력 7년이상)	유진로봇	인천 연수구	경력 7~15년	["JavaScript", "· Network", "· RDB", "· NoSql", "· Node.js", "· Linux"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52651	backend	t
2341	Backend 개발자	스마트푸드네트웍스	서울 강남구	경력 5~15년	["Java", "· Kotlin", "· Spring", "· QueryDSL", "· AWS", "· Git", "· Jira", "· Confluence"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52001	backend	t
2342	클라우드 솔루션 아키텍트 - GenAI(글로벌)	업스테이지	경기 용인시	신입~20년	["AI/인공지능", "· AWS", "· GCP", "· AZURE", "· PyTorch"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52258	data	t
2343	Backend Engineer (Java/Kotlin)	센트비	서울 영등포구	경력 4~13년	["Kotlin", "· Java", "· Spring Boot", "· Spring Framework", "· Git", "· GitHub", "· AWS"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52988	backend	t
2344	Computer Vision Engineer(CV엔지니어)	메이아이	서울 강남구	신입~10년	["MachineLearning", "· AI/인공지능"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51863	mobile	t
2345	Backend Junior Engineer(PHP/Python)	코비그룹	서울 강남구	신입~3년	["Linux", "· Python", "· AWS", "· SQL", "· Laravel", "· PHP", "· PySpark"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53194	backend	t
2346	백엔드 개발자(JAVA) 개발자[3~9년]	이파피루스	경기 성남시	경력 3~9년	["Java", "· Spring Framework", "· Spring", "· Spring Boot", "· Spring Cloud", "· Jenkins"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52584	backend	t
2347	임베디드 소프트웨어 개발자(신입~4년차)	긴트	경기 성남시	신입~4년	["C", "· C++", "· SW", "· Embedded"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52337	other	t
2348	Frontend 개발자	스마트푸드네트웍스	서울 강남구	경력 4~15년	["Next.js", "· React Query", "· Jotai", "· TailwindCSS", "· TypeScript", "· pnpm"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52911	frontend	t
2349	SoC RTL DFT Design Engineer	보스반도체	경기 성남시	경력 5~15년	["PCB", "· HW", "· Embedded"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52121	other	t
2350	Global SaaS Ops팀 Tech lead (영어 가능)	도브러너	서울 강남구	경력 10~25년	["AWS", "· Node.js", "· Next.js", "· NestJS", "· MSA", "· K8S", "· Elasticsearch"]	D-19	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52634	backend	t
2351	DRM team Tech Lead (Cloud SaaS)	도브러너	서울 강남구	경력 10~25년	["AWS", "· Elasticsearch", "· Java", "· Spring Boot", "· Kafka", "· Docker", "· Kubernetes"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52821	backend	t
2352	프로덕트 엔지니어 (백엔드)	플래닝고	서울 관악구	경력 1~5년	["AWS", "· Django", "· Python", "· REST API", "· Spring", "· Amazon EC2", "· GCP"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52145	backend	t
2353	Global 서비스 Back-end개발	숲	경기 성남시	경력 3~10년	["Node.js", "· JavaScript", "· TypeScript", "· NestJS", "· ExpressJS", "· REST API"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52354	backend	t
2354	[커머스프로덕션]Jr. QA 엔지니어 채용	미리디	서울 구로구	경력 1~4년	["Slack", "· Redmine", "· QA", "· Confluence", "· Jira", "· GitHub"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51893	other	t
2355	프론트엔드 개발	엔에이치엔링크	서울 강남구	경력 5~15년	["JavaScript", "· TypeScript", "· HTML5", "· CSS 3", "· React", "· jQuery", "· Jotai", "· pnpm"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52955	backend	t
2356	백엔드 개발자(경력)	아인잡	서울 강남구	경력 4~10년	["AWS", "· Java", "· MongoDB", "· MySQL", "· Redis", "· Spring Boot", "· GitHub", "· Slack"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51936	backend	t
2357	[TADA] QA Engineer 채용	이지식스(엠블)	서울 강남구	경력 1~5년	["SW", "· QA"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52475	other	t
2358	빅데이터 기반 Node/NestJS 백엔드 개발자	퍼플아카데미	서울 양천구	경력 3~8년	["JavaScript", "· SQL", "· BigData", "· Node.js", "· AWS", "· NestJS"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51826	backend	t
2359	AI 백엔드 시스템 엔지니어 채용	쉬모스랩	서울 강남구	경력 2~7년	["SQL", "· PostgreSQL", "· Python", "· Azure DevOps", "· REST API", "· gRPC"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52556	backend	t
2360	IT 시스템 연동·구축 담당자	팬택씨앤아이	서울 영등포구	경력 10~20년	["MSSQL", "· SQL", "· ERP", "· REST API", "· JSON", "· XML", "· Oracle"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52789	frontend	t
2361	웹 서비스 Front-end 개발자 (경력)	엔닷라이트	경기 성남시	경력 5~10년	["TypeScript", "· JavaScript", "· CSS 3", "· Next.js", "· React", "· GitHub Actions"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52664	backend	t
2362	컴퓨터비전 엔지니어 채용	쉬모스랩	서울 강남구	경력 2~7년	["Docker", "· Linux", "· Git", "· gRPC", "· SQL", "· Kubernetes", "· TensorFlow"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52554	mobile	t
2363	백엔드 개발자 (Java)	안전집사	서울 영등포구	신입	["Java", "· Spring Boot", "· Node.js", "· MySQL", "· MongoDB", "· Redis", "· AWS"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53224	backend	t
2364	AI 플랫폼 백엔드 개발자	악어디지털	경기 용인시	경력 3~5년	["Python", "· FastAPI", "· Docker", "· GitLab", "· Linux", "· MySQL", "· Vue.js", "· AWS", "· Jira"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52086	backend	t
2365	[신입] Python 개발자	에피넷	경기 안양시	신입	["AI/인공지능", "· Python", "· Django", "· PostgreSQL", "· Linux", "· Docker", "· Git"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51587	backend	t
2366	프론트엔드 개발 (3년 이상)	하이테커	서울 성동구	경력 3~5년	["Git", "· TypeScript", "· React", "· Next.js"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52498	frontend	t
2367	서버 백엔드 개발[신입]	패션앤스타일컴퍼니	서울 종로구	신입	["Java", "· Spring", "· Spring Framework", "· Spring Boot", "· Oracle", "· Git", "· GitHub"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52915	backend	t
2368	[삼보컴퓨터 계열사] SI개발자(2년 이상)	삼보컴퓨터	서울 강남구	경력 2~7년	["Java", "· JSP", "· jQuery", "· Oracle"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52189	backend	t
2369	센서 칼리브레이션 엔지니어 채용	토르드라이브	서울 영등포구	경력 3~10년	["C++", "· ROS", "· Python", "· OpenCV"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51966	backend	t
2370	프론트엔드 개발자 (11년 ~ 15년)	데이터메이커	대전 유성구	경력 11~15년	["JavaScript", "· ES6", "· Rust", "· three.js", "· Nuxt.js", "· TailwindCSS", "· Vue.js"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51844	backend	t
2371	[전문연구요원]AI연구엔지니어-LLM	업스테이지	경기 용인시	신입~20년	["AI/인공지능", "· TensorFlow", "· PyTorch", "· NLP"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52250	data	t
2372	Robot Multi Modal Learning Engineer	씨메스	서울 강남구	신입~15년	["Python", "· C++", "· gRPC", "· ZeroMQ"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52511	backend	t
2373	Devops (5년 이상)	퓨쳐위즈	서울 강남구	경력 5~10년	["AWS", "· Kubernetes", "· Terraform", "· Datadog", "· Grafana", "· Prometheus", "· Argo"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52108	backend	t
2374	정보보안 담당자(경력 3~5년)	엑심베이	서울 구로구	경력 3~5년	["ISMS", "· FW", "· Network", "· Jira", "· Confluence", "· AWS", "· AWS WAF"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52815	other	t
2375	프론트엔드 개발자 (5년 ~ 10년)	데이터메이커	대전 유성구	경력 5~10년	["JavaScript", "· ES6", "· Rust", "· three.js", "· Nuxt.js", "· TailwindCSS", "· Vue.js"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51843	backend	t
2376	백엔드 개발자 (12년 ~ 15년)	데이터메이커	대전 유성구	경력 12~15년	["Django", "· Django REST framework", "· MySQL", "· Rails", "· REST API", "· Node.js"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51836	backend	t
2377	NPU Compiler Engineer	모빌린트	서울 강남구	신입~10년	["Python", "· C++", "· Linux", "· DeepLearning", "· c"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51725	backend	t
2378	의료SW그룹 알고리즘 개발자 모집	에이엠시지	서울 서초구	경력 10~20년	["Python", "· MachineLearning", "· DeepLearning"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52948	backend	t
2380	프론트엔드 개발자 (6~10년)	아론티어	서울 서초구	경력 6~10년	["JavaScript", "· React", "· REST API", "· vuex", "· Redux", "· Webpack", "· Git"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52488	backend	t
2379	H/W 개발(경력 16~20년, Travel Adapter)	한솔테크닉스	경기 수원시	경력 16~20년	["PCB", "· HW"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51906	other	t
2381	H/W System Design Engineer(Senior)	모빌린트	서울 강남구	경력 8~12년	["PCB"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51728	other	t
2382	임베디드 소프트웨어 개발자(9~12년차)	긴트	경기 성남시	경력 9~12년	["C", "· C++", "· SW", "· Embedded"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52341	other	t
2383	프론트엔드 개발자 채용(팀원급)	이파피루스	경기 성남시	경력 4~8년	["AngularJS", "· TypeScript", "· RxJS", "· Sass", "· GitLab", "· Jenkins", "· AWS", "· Vue.js"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53105	frontend	t
2385	광고 비즈니스 플랫폼 테스트엔지니어	이노아이	경기 성남시	경력 5~6년	["iOS", "· Jira", "· Confluence", "· Android OS", "· Postman", "· Redmine", "· Slack", "· QA"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52957	mobile	t
2386	Verification Engineer/분당R&D	아이디어스투실리콘	경기 성남시	경력 3~15년	["Verilog", "· ASIC", "· Perl", "· TCP/IP", "· Python", "· C++", "· C#", "· VHDL", "· FPGA"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51626	backend	t
2387	백엔드 개발자(7년 이상)	에이아이파크	서울 마포구	경력 7~10년	["jQuery", "· Ajax", "· Java", "· Python", "· NGINX", "· Network", "· Docker"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52499	backend	t
2388	[대구] RTL 설계엔지니어(경력 4~16년)	칩스앤미디어	대구 동구	경력 4~16년	["Verilog", "· C", "· C++", "· Python", "· Linux", "· HW", "· FPGA", "· VHDL"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52170	backend	t
2389	안드로이드 개발 (3년 이상)	마카롱팩토리	경기 성남시	경력 3~10년	["Android OS", "· Java", "· Kotlin", "· Realm", "· Flutter"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52801	backend	t
2390	Beckhoff(백호프) PLC	유진로봇	인천 연수구	경력 3~18년	["PLC", "· SW"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52655	other	t
2391	AI 개발자(3년 이상)	네비웍스	경기 안양시	경력 3~10년	["Python", "· Linux", "· TensorFlow", "· PyTorch", "· AI/인공지능", "· DeepLearning"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52156	backend	t
2392	인공지능/머신러닝 솔루션 경력 (2년↑)	이글루코퍼레이션	서울 송파구	경력 2~7년	["AI/인공지능", "· MachineLearning", "· Python", "· K8S", "· Linux", "· PyTorch"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53209	backend	t
2393	풀스택개발 (node.js)	프라이빗테크놀로지	서울 마포구	경력 4~10년	["Node.js", "· Java", "· MySQL", "· MariaDB", "· Spring", "· Spring Data JPA"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53072	backend	t
2394	3D AI 엔지니어 (경력)	엔닷라이트	경기 성남시	경력 2~10년	["AI/인공지능"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52669	data	t
2395	[인공지능솔루션] Search Engineer	제논	서울 강남구	경력 3~20년	["Elasticsearch", "· Docker", "· Python", "· Kubernetes"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52685	backend	t
2396	전기전자 설계 개발(경력)	네비웍스	경기 안양시	경력 3~5년	["Orcad", "· PCB", "· 2D Rendering", "· 3D Rendering"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52152	other	t
2397	이기종 방화벽 정책관리 솔루션 개발자	위드네트웍스	서울 강서구	경력 5~10년	["Git", "· MongoDB", "· Docker", "· Linux"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51952	backend	t
2398	HW 기구 설계(경력)	네비웍스	경기 안양시	경력 5~15년	["Solidworks", "· Autocad"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52153	other	t
2399	Java 백엔드 개발자(5~10년) 모집	WATA Inc.	경기 성남시	경력 5~10년	["Java", "· Spring Framework", "· JSP", "· AWS", "· REST API", "· Linux", "· Python"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52470	backend	t
2400	소프트웨어 엔지니어 (경력 / 대구 근무)	에이스웍스코리아	대구 수성구	경력 3~12년	["labview", "· C++", "· C#", "· Python", "· C"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52627	backend	t
2401	데이터 엔지니어 채용	쉬모스랩	서울 강남구	경력 2~7년	["SQL", "· PostgreSQL", "· Python", "· Azure DevOps", "· Git", "· Docker", "· REST API"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52555	backend	t
2402	윈도우 응용 프로그래머(C++)	네비웍스	경기 안양시	경력 3~15년	["C", "· C++", "· C#", "· TCP/IP", "· GUI", "· Mfc", "· Linux"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52155	other	t
2403	AI 에이전트 엔지니어 (3년~5년차)	에스엠해썹	경기 오산시	경력 3~5년	["Python", "· PyTorch", "· Keras", "· Docker", "· Ubuntu"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52847	backend	t
2404	기술지원부장(기술지원팀 및 QA/QC팀 총괄 관리)	프라이빗테크놀로지	서울 마포구	경력 10~20년	["QA", "· SW", "· CISSP"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53056	other	t
2405	프론트엔드(Web apllication)	메디트	서울 영등포구	경력 3~15년	["Vue.js", "· React"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51663	frontend	t
2406	의료 데이터 베이스 구축 정규직 채용	메디플렉서스	서울 마포구	경력 1~10년	["MySQL", "· MariaDB", "· MSSQL", "· Linux", "· Windows", "· SQL", "· PostgreSQL"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52777	data	t
2407	ADAS NPU AI SW Engineer	보스반도체	경기 성남시	신입	["PyTorch", "· TensorFlow", "· DeepLearning"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52120	mobile	t
2408	비전기반 AI 엔지니어(1~3년)	에이딘로보틱스	경기 안양시	경력 1~3년	["Python", "· PyTorch", "· OpenCV", "· Linux", "· ROS", "· AI/인공지능"]	D-day	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51621	backend	t
2409	비젼개발팀 알고리즘 파트 경력 채용	크레셈	인천 연수구	경력 3~10년	["SW", "· C#", "· WPF", "· PCB", "· OpenCV", "· MachineLearning", "· HALCON"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52540	mobile	t
2410	비젼개발팀 Vision SW Part 경력 채용	크레셈	인천 연수구	경력 2~10년	["SW", "· C#", "· WPF", "· PCB"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52539	other	t
2411	웹 프론트엔드 개발자	코나투스	서울 서초구	경력 5~8년	["JavaScript", "· CSS 3", "· HTML5", "· TypeScript", "· React", "· Vue.js"]	D-7	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52007	backend	t
2412	SI 개발	미디어로그	서울 마포구	경력 8~10년	["Java", "· Spring Boot", "· Vue.js", "· Oracle", "· Python", "· Elasticsearch", "· AWS"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52027	backend	t
2413	MES 솔루션 (제조실행 시스템)개발 (경력 3년 이상)	블루비즈	서울 구로구, 전북 전주시	경력 3~15년	["Spring Framework", "· Spring Boot", "· Java", "· React", "· Next.js", "· TypeScript"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51735	backend	t
2414	ML Engineer (ML 엔지니어)	메이아이	서울 강남구	경력 5~10년	["FastAPI", "· Django", "· PostgreSQL", "· Airflow", "· Docker", "· Kubernetes", "· AWS"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51862	backend	t
2415	SM/SI 개발 8년↑ 채용	미디어로그	서울 마포구	경력 8~10년	["Java 8", "· Spring Boot", "· Vue.js", "· React.js Boilerplate", "· Oracle", "· MySQL"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51866	backend	t
2416	인사시스템 분석/설계 담당자 모집	지에스비즈플	서울 종로구	경력 10~15년	["Java", "· Oracle", "· MariaDB"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52417	backend	t
2417	SI 개발 PM	미디어로그	서울 마포구	경력 8~10년	["Java", "· Node.js", "· Vue.js", "· Oracle", "· MySQL", "· Docker", "· Kubernetes", "· AWS"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52028	backend	t
2418	Quality Engineer(신입 ~ 4년 경력)	뷰런테크놀로지	서울 서초구	신입~4년	["QA", "· Linux", "· C", "· C++", "· Python"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51613	backend	t
2419	DBA 담당(1~3년)	엑심베이	서울 구로구	경력 1~3년	["MySQL", "· Java", "· Slack", "· Linux", "· AWS", "· CentOS", "· DB", "· Oracle", "· Jira"]	D-12	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52280	backend	t
2420	Deep Learning Research Engineer	모빌린트	서울 강남구	신입~10년	["Python", "· PyTorch", "· TensorFlow", "· DeepLearning", "· C", "· C++"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51723	backend	t
2421	수요예측/데이터 분석 전문가(중/고급)	디에스이트레이드	서울 서초구	경력 3~10년	["Python", "· SQL", "· TensorFlow", "· Keras", "· PyTorch", "· PySpark", "· EDA"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52699	backend	t
2422	MES 솔루션 개발 R&D 리더	한솔피엔에스	서울 강서구	경력 12~20년	["MES", "· Spring Boot", "· Vue.js", "· Java", "· ERP", "· DB", "· PLC", "· Oracle", "· MSSQL"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51693	backend	t
2423	모바일 APP(IOS) 개발자 모집(주니어)	에스디바이오센서	경기 수원시	경력 1~5년	["iOS", "· REST API", "· C++", "· Objective-C", "· Swift"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51816	mobile	t
2424	3D 엔진개발 [메타개발팀] 리드급	상화	서울 강남구	경력 9~10년	["Unity", "· Unreal Engine", "· 3D Rendering", "· K3d", "· 3D Volume Rendering", "· AR"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52083	other	t
2425	[삼보컴퓨터 계열사] 네트워크 담당자(1년 이상)	삼보컴퓨터	서울 강남구	경력 1~10년	["VPN", "· IPS", "· TCP/IP"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52192	other	t
2426	프론트엔드 개발자	패스트레인	서울 강남구	경력 7~13년	["React", "· GitHub", "· Jira", "· Confluence", "· Python"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52603	backend	t
2427	클라우드 Java 백엔드 개발자 채용	아이파킹	서울 금천구	경력 4~6년	["Java", "· Spring Boot", "· NoSql", "· REST API"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52053	backend	t
2429	풀스택 개발자	데이터드리븐	경기 성남시	신입~7년	["Django", "· Python", "· React", "· Git", "· TypeScript", "· Kubernetes", "· Docker", "· Vite"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53170	backend	t
2428	[IT] 백엔드 SW개발 (전자차트)	덴티움	경기 수원시	경력 3~9년	["Node.js", "· GraphQL", "· AWS", "· RDB", "· MySQL", "· PostgreSQL", "· NestJS"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52002	backend	t
2430	프론트엔드 개발자 경력직 채용	퍼플아카데미	서울 양천구	경력 2~5년	["React", "· CSS 3", "· HTML5"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52005	frontend	t
2431	AI솔루션 개발자(경력 5~10년)	엠로	서울 영등포구	경력 3~10년	["Java", "· JavaScript", "· Spring Framework"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52904	backend	t
2432	아틀라시안 엔지니어	오픈소스컨설팅	서울 강남구	신입~15년	["Bitbucket", "· Git", "· Linux", "· Apache Tomcat", "· Confluence", "· Jira"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52804	other	t
2433	서버 백엔드 개발[경력]	패션앤스타일컴퍼니	서울 종로구	경력 6~15년	["Java", "· Spring", "· Spring Framework", "· Spring Boot", "· Oracle", "· Git", "· GitHub"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52916	backend	t
2434	APLUS AI_검색&추천_백엔드 엔지니어	버즈니	서울 관악구	경력 1~10년	["Python", "· AWS", "· Amazon EKS", "· Kubernetes", "· Sentry", "· Prometheus"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53131	backend	t
2435	앱 프론트엔드 개발자 추가 모집	마스터웨이	서울 강서구	신입~3년	["React", "· TypeScript", "· Recoil", "· React Query", "· Docker", "· AWS", "· Git"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51738	frontend	t
2436	Robotics S/W Engineer [전문연구요원가능]	토르드라이브	서울 영등포구	경력 3~10년	["C", "· C++", "· CUDA"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51969	other	t
2437	Cybersecurity Policy Manager	센트비	서울 영등포구	경력 1~3년	["Jira", "· Confluence", "· Slack", "· Google Workspace"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52986	backend	t
2438	S/W Engineer [전문연구요원가능]	토르드라이브	서울 영등포구	경력 3~10년	["C", "· C++", "· CUDA"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51974	other	t
2439	Soc Design Engineer	아이에이치더블유	경기 용인시	경력 3~20년	["Git", "· EDA", "· TCP/IP", "· ARM", "· Verilog", "· Embedded", "· HW"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52570	other	t
2440	F/W개발(MCU) (경력 3~7년)	원익피앤이	경기 수원시	경력 3~7년	["C", "· FW", "· MCU"]	D-19	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52494	other	t
2441	[로봇] 강화학습 엔지니어 채용	플라잎	경기 성남시	경력 3~5년	["C", "· C++", "· Python", "· MachineLearning", "· TensorFlow", "· PyTorch", "· Linux"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51875	backend	t
2442	안드로이드 개발자(경력)	레트리카	서울 서초구	경력 2~5년	["Java", "· Gradle", "· MVVM", "· RxJava", "· Realm", "· Room"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53034	backend	t
2443	DBA 담당(7년↑)	엑심베이	서울 구로구	경력 7~10년	["MySQL", "· Java", "· Slack", "· Linux", "· AWS", "· CentOS", "· DB", "· Oracle", "· Jira"]	D-12	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52282	backend	t
2444	혈액 감별 의료기기 알고리즘 개발자 [전문연구요원]	유아이엠디	경기 과천시	신입	["AI/인공지능", "· DeepLearning", "· SW", "· C", "· C++", "· Python", "· OpenCV", "· PyTorch"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52936	backend	t
2445	백엔드 개발자	라온피플	경기 과천시	경력 3~5년	["Python", "· RDB", "· NoSql", "· Redis", "· MongoDB"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52856	backend	t
2446	[DX사업본부] DevOps Engineer	딥노이드	서울 구로구	경력 3~10년	["Java", "· Kotlin", "· Spring Boot", "· Kafka", "· NoSql", "· K8S"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52099	backend	t
2447	H/W 개발(경력 8~15년, Travel Adapter)	한솔테크닉스	경기 수원시	경력 8~15년	["PCB", "· HW"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51907	other	t
2448	[Infra Div.] Publishing Tech PM	크래프톤	서울 강남구	경력 3~10년	["Python", "· PowerShell", "· Go", "· C#"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51812	backend	t
2449	Simulation S/W Engineer [전문연구요원가능]	토르드라이브	서울 영등포구	경력 3~10년	["C", "· C++", "· CUDA"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51968	other	t
2450	[4년 이상] Backend Engineer	큐픽스	경기 성남시	경력 4~12년	["Ruby", "· TypeScript", "· Java", "· Python", "· Node.js", "· Rails", "· AWS"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52458	backend	t
2451	개인정보보호 담당자(경력9년~14년)	피엠인터내셔널코리아	서울 영등포구	경력 9~14년	["ISMS", "· CPPG", "· CISSP", "· CISA", "· Jira", "· Confluence", "· AZURE", "· AWS"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51712	other	t
2452	시스템 소프트웨어 엔지니어 경력 채용	엠트리센	서울 금천구	경력 3~10년	["C++", "· Python", "· Rust", "· Linux", "· Git", "· JavaScript", "· Docker"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52380	backend	t
2453	벡앤드 엔지니어 정규직 채용	엠트리센	서울 금천구	경력 5~15년	["Node.js", "· Python", "· FastAPI", "· PostgreSQL", "· Redis"]	D-31	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53198	backend	t
2454	S/W개발(경력 9~13년, 모터 제어)	한솔테크닉스	경기 수원시	경력 9~13년	["SW", "· MATLAB"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51912	other	t
2384	회로개발 (경력 3~7년)	원익피앤이	경기 수원시	경력 3~7년	["HW", "· SW", "· Embedded", "· FW"]	D-19	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52491	other	t
2455	인공지능 SW개발 (5~7)	바이트사이즈	부산 부산진구	경력 5~10년	["Python", "· NLP", "· Git", "· Airflow", "· Java", "· Microsoft Teams"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51678	backend	t
2456	NPU Core Engineer (RTL)	모빌린트	서울 강남구	신입~10년	["C", "· C++", "· Linux", "· DeepLearning", "· MachineLearning", "· Embedded"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51727	mobile	t
2457	모바일 APP(IOS) 개발자 모집(시니어)	에스디바이오센서	경기 수원시	경력 6~10년	["iOS", "· REST API", "· C++", "· Objective-C", "· Swift"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51817	mobile	t
2458	[TADA]Android Engineer(Intermediate)	이지식스(엠블)	서울 강남구	경력 5~15년	["Kotlin", "· Android OS", "· RxJava", "· Gradle"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52138	backend	t
2459	Digital Logic 개발/대구	아이디어스투실리콘	대구 북구	경력 3~15년	["Verilog", "· C", "· C++", "· C#", "· Python", "· VHDL", "· FPGA", "· TCP/IP", "· ASIC", "· Perl"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51628	backend	t
2460	프론트엔드 엔지니어 (5년이상)	빅웨이브로보틱스	서울 강남구	경력 5~10년	["React", "· Next.js", "· TypeScript", "· JavaScript", "· WebSocket", "· AWS"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52212	backend	t
2461	DevOps/MLOps Engineer (3~6년)	웨어러블에이아이	서울 영등포구	경력 3~6년	["AWS", "· Linux", "· Docker", "· Kubernetes", "· Kubeflow"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52326	mobile	t
2462	CI/CD 엔지니어	오픈소스컨설팅	서울 강남구	경력 3~14년	["GitHub", "· GitLab", "· Bitbucket", "· Jenkins", "· Jira", "· Bamboo", "· Git"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52149	other	t
2463	[인공지능솔루션] AI Engineer	제논	서울 강남구	경력 3~20년	["PyTorch", "· TensorFlow", "· Python", "· Kubernetes"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52689	backend	t
2464	하드웨어 엔지니어 시니어급	혜연전자	인천 서구	경력 5~7년	["PCB", "· RF", "· Pads", "· HW"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52423	other	t
2465	Windows 개발자 경력사원 모집	에이피알	서울 송파구	경력 2~10년	["Windows", "· Windows Server", "· C#", "· WPF", "· OpenCV", "· REST API"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52962	backend	t
2466	솔루션 QA담당(경력 6~10년)	엠로	서울 영등포구	경력 6~10년	["QA"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52903	other	t
2467	Windows 응용소프트웨어 개발	프라이빗테크놀로지	서울 마포구	경력 3~25년	["Windows", "· SW", "· C", "· C#", "· TCP/IP", "· Network", "· SecureCRT"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53071	other	t
2468	EDA 데이터 엔지니어	럭스로보	서울 서초구	경력 5~12년	["Python", "· Flask", "· FastAPI", "· Git", "· PostgreSQL", "· MySQL", "· Redis"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52953	backend	t
2469	Java 백엔드 개발자(11~15년)모집	WATA Inc.	경기 성남시	경력 11~15년	["Java", "· Spring Framework", "· JSP", "· AWS", "· REST API", "· Linux", "· Python"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52469	backend	t
2470	병원용 모바일 서비스 개발자(풀스택)및 관리자(차/부장급)	포씨게이트	서울 영등포구	경력 10~20년	["Python", "· Spring Framework", "· AWS", "· Git", "· iOS", "· HTML5", "· CSS 3"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52480	backend	t
2471	전기차 충전 백엔드 개발자 채용	EVAR	경기 성남시	경력 3~10년	["AWS", "· Docker", "· MSA", "· Node.js", "· TypeScript", "· NoSql", "· DB"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52505	backend	t
2472	3D 엔진개발 [메타개발팀] 신입	상화	서울 강남구	신입~2년	["Unity", "· Unreal Engine", "· 3D Rendering", "· K3d", "· 3D Volume Rendering", "· AR"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52082	other	t
2473	[개발] Backend Developer/2~4년	빌드코퍼레이션	서울 강남구	경력 2~4년	["Node.js", "· Next.js", "· GitHub Actions", "· Pulumi", "· AWS"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52277	backend	t
2474	백엔드 경력 개발자 (Java & Spring, MSA, AWS)	도브러너	서울 강남구	경력 7~20년	["AWS", "· Kafka", "· Java", "· Spring Framework", "· MSA", "· Docker", "· K8S"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52822	backend	t
2475	[Python] AI 플랫폼 개발자	딥노이드	서울 구로구	경력 2~7년	["Python", "· Spark", "· Elasticsearch", "· Airflow", "· Git", "· Linux"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52097	backend	t
2476	SM/SI 개발 5년↑ 채용	미디어로그	서울 마포구	경력 5~7년	["Java 8", "· Spring Boot", "· Vue.js", "· React.js Boilerplate", "· Oracle", "· MySQL"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51865	backend	t
2477	프론트엔드 개발자 채용	두비덥	서울 마포구	경력 1~10년	["JavaScript", "· TypeScript", "· HTML5", "· Vue.js", "· Quasar"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51789	backend	t
2478	RF Module 개발 (사원~대리급)	브로던	경기 화성시	신입~5년	["HW", "· RF"]	D-25	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52968	other	t
2479	Flutter 개발자	코보시스	서울 송파구	경력 3~10년	["Flutter", "· Android OS", "· iOS", "· Dart", "· Git", "· React", "· Vue.js", "· Jira"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51871	frontend	t
2480	서버 개발자	코보시스	서울 송파구	경력 3~15년	["Java", "· Spring Boot", "· JSP", "· Linux", "· Mybatis", "· Oracle", "· MySQL", "· Bootstrap"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51872	backend	t
2481	SoC Design Engineer	모빌린트	서울 강남구	신입~10년	["Verilog", "· EDA", "· ASIC", "· FPGA", "· Python", "· c++", "· c", "· Java"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51719	backend	t
2482	알약 xLLM 제품 개발 (신입)	이스트시큐리티	서울 서초구	신입	["Go", "· Java", "· Python", "· REST API", "· SQL", "· NoSql", "· Git"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52608	backend	t
2483	Python Algorithm Engineer 채용	제너레잇	서울 영등포구	경력 2~10년	["Python", "· C#", "· Django", "· Celery", "· scikit-learn", "· SciPy"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52477	backend	t
2484	자사 쇼핑몰 전산팀원 모집	파츠몰	경기 고양시	경력 3~10년	["JavaScript", "· MSSQL", "· Spring Boot", "· JSP", "· MySQL"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52755	backend	t
2485	프론트엔드 개발자	넥써쓰	서울 강남구	경력 3~11년	["Blockchain", "· React Native", "· Next.js", "· React"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51921	frontend	t
2486	Android 개발자	넥써쓰	서울 강남구	경력 2~10년	["Android OS", "· React Native", "· Blockchain"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51920	frontend	t
2487	Motion Planning/Control Engineer	웨어러블에이아이	서울 영등포구	신입~10년	["C", "· C++", "· Python", "· MATLAB", "· Docker", "· ROS", "· SummitDB"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52329	backend	t
2488	[일레븐플러스]프론트엔드 개발자(React)	캔랩코리아	서울 서초구	경력 2~10년	["React", "· Vue.js", "· Mocha", "· Jasmine", "· Jest", "· TypeScript"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52924	frontend	t
2489	서버 백엔드 개발자(경력 3년 이상)	에이로직	서울 동작구	경력 3~6년	["Java", "· Spring Boot", "· AWS", "· Go", "· Python", "· MySQL", "· Docker", "· Git"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53204	backend	t
2490	백엔드 개발자 경력 정규직 채용	엠투클라우드	서울 송파구	경력 6~10년	["JavaScript", "· Spring MVC", "· MySQL", "· RDB", "· Node.js", "· REST API", "· AWS"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51978	backend	t
2491	언리얼 컨텐츠 개발 [메타개발팀]	상화	서울 강남구	경력 3~5년	["Unity", "· Unreal Engine", "· 3D Rendering", "· K3d", "· 3D Volume Rendering", "· AR"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52085	other	t
2492	UI/UX 개발자 경력 정규직 채용	엠투클라우드	서울 송파구	경력 2~6년	["JavaScript", "· HTML5", "· CSS 3", "· jQuery"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51977	backend	t
2493	[AI Agent 구축] AI 개발자(서울)	아파트너스	서울 금천구	경력 1~5년	["Python", "· AI/인공지능", "· Embedded"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51710	backend	t
2494	프론트엔드 개발자	아인잡	서울 강남구	경력 3~10년	["CSS 3", "· Jira", "· React", "· TypeScript", "· Webpack", "· Notion", "· GitHub", "· Next.js"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51938	frontend	t
2495	Full-Stack Engineer	커버링	서울 중구	경력 2~5년	["JavaScript", "· TypeScript", "· AWS", "· PostgreSQL", "· Flutter", "· Next.js", "· GitHub"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52562	backend	t
2496	SAP Project Manager 모집	지에스아이티엠	서울 종로구	경력 7~20년	["SAP", "· ERP"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52418	other	t
2497	선행개발 경력 (6~10년)	제이티	충남 천안시	경력 6~10년	["HW", "· FW", "· MCU", "· FPGA", "· Linux", "· C", "· C++", "· C#", "· Orcad", "· Pads"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52024	other	t
2498	Information Security Engineer	업스테이지	경기 용인시	경력 7~20년	["AI/인공지능", "· Jira", "· Confluence"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52260	data	t
2499	[플랫폼개발팀] Java Senior 개발자	델레오코리아	서울 강남구	경력 8~20년	["REST API", "· Java", "· Spring Boot", "· Spring", "· Kafka", "· Hibernate", "· Git", "· Jira"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52601	backend	t
2500	모바일 개발자 (Mobile Developer)	모픽	경기 안양시	경력 5~15년	["Swift", "· Objective-C", "· Kotlin", "· Java", "· C", "· C++", "· DirectX", "· OpenGL", "· Vulkan"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52604	backend	t
2501	완성차 검차라인 SW 개발(10년↑)	에이디티	경기 안산시	경력 10~15년	["C#", "· C", "· C++", "· Mfc", "· SW"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52073	other	t
2502	서버 및 인프라 개발자 (16년 ~ 20년)	데이터메이커	대전 유성구	경력 16~20년	["Terraform", "· Pulumi", "· Golang", "· Argo", "· Linux", "· Ansible", "· Python", "· Shell"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51839	backend	t
2503	.NET 웹 개발 경력 채용	필라넷	서울 강남구	경력 3~7년	["Windows", "· ASP.NET", "· Classic ASP", "· MSSQL", "· .NET", "· jQuery", "· JavaScript"]	D-4	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51614	backend	t
2504	알약 xLLM 제품 개발 (경력)	이스트시큐리티	서울 서초구	경력 3~6년	["Go", "· Java", "· Python", "· REST API", "· SQL", "· NoSql", "· Git"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52607	backend	t
2505	SCM 생산계획 시스템 개(10년 이상)	디에스이트레이드	서울 서초구	경력 10~25년	["SQL", "· Oracle", "· MSSQL", "· DB"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52700	other	t
2506	QA Engineer	콜로세움코퍼레이션	서울 강남구	경력 1~10년	["QA", "· Confluence", "· Jira"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53202	other	t
2507	[ECS사업부문] SI 프로젝트 PM	플래티어	서울 송파구	경력 15~20년	["JavaScript", "· Spring Boot", "· React", "· Next.js", "· Jira", "· Confluence"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51766	backend	t
2508	이커머스 플랫폼 개발자 (경력직)	플래티어	서울 송파구	경력 2~10년	["Java", "· JavaScript", "· JSP", "· Oracle", "· MySQL", "· NoSql", "· Vue.js", "· Spring"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51767	backend	t
2509	[EC솔루션사업본부] 프론트 엔지니어	플래티어	서울 송파구	경력 5~10년	["JavaScript", "· AWS", "· PostgreSQL", "· Oracle", "· MySQL", "· React", "· Next.js"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51867	backend	t
2510	[ECS사업부문] 어플리케이션 아키텍트	플래티어	서울 송파구	경력 7~20년	["AWS", "· AZURE", "· Azure DevOps", "· Python", "· JavaScript", "· Spring", "· GitLab"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51765	backend	t
2511	SaaS 백엔드 개발자 (경력 6~10년)	에스엠해썹	경기 오산시	경력 6~10년	["Python", "· Django", "· Django REST framework", "· MariaDB", "· MongoDB", "· Git"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52516	backend	t
2512	딥러닝 소프트웨어 개발자 채용	베이리스	경기 성남시	경력 5~20년	["DeepLearning", "· PyTorch", "· TensorFlow", "· AI/인공지능", "· Embedded Linux"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52181	mobile	t
2513	솔루션 개발자	메디트	서울 영등포구	경력 5~15년	["C++", "· Qt", "· macOS", "· Windows", "· WebSocket", "· REST API", "· Git", "· CMake"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51668	other	t
2514	Embedded FW 개발(육아휴직 대체)	슈프리마	경기 성남시	경력 10~15년	["C", "· C++", "· Embedded Linux"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51676	other	t
2515	Embedded Linux BSP 개발	슈프리마	경기 성남시	경력 10~15년	["C", "· C++", "· Android OS", "· Embedded Linux"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51677	mobile	t
2516	Cloud & 솔루션 엔지니어	스피디	경기 성남시	경력 3~7년	["Linux", "· Azure CDN", "· CloudFlare", "· Network"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51697	other	t
2517	Deep Learning Optimization Engineer	모빌린트	서울 강남구	신입~10년	["Python", "· PyTorch", "· TensorFlow", "· DeepLearning", "· C", "· C++"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51724	backend	t
2518	백엔드 개발자 채용	두비덥	서울 마포구	경력 2~10년	["TypeScript", "· ExpressJS", "· ExpressionEngine", "· Fastify"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51791	backend	t
2519	개인정보보호 담당자(경력15년~20년)	피엠인터내셔널코리아	서울 영등포구	경력 15~20년	["ISMS", "· CPPG", "· CISSP", "· CISA", "· Jira", "· Confluence", "· AZURE", "· AWS"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51713	other	t
2520	웹 풀스택 개발자 경력 2년 이상	나우디앤아이	경기 시흥시	경력 2~5년	["JavaScript", "· PHP", "· AWS", "· HTML5", "· Node.js", "· React", "· AZURE", "· MySQL"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52606	backend	t
2521	시스템 엔지니어 (PM, SE, SM)	넥서스커뮤니티	서울 영등포구	경력 3~10년	["Linux", "· Oracle", "· MariaDB"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51718	other	t
2522	C# 개발자	코보시스	서울 송파구	경력 3~10년	["C#", "· WPF", "· Git", "· .NET", "· SW"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51873	other	t
2523	비전기반 AI 엔지니어(4~6년)	에이딘로보틱스	경기 안양시	경력 4~6년	["Python", "· PyTorch", "· OpenCV", "· Linux", "· ROS", "· AI/인공지능"]	D-day	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51622	backend	t
2524	SoC RTL Design Engineer	보스반도체	경기 성남시	경력 2~15년	["C", "· C++", "· Python", "· Verilog"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52123	backend	t
2525	3D 엔진개발 [메타개발팀] 과장급	상화	서울 강남구	경력 6~8년	["Unity", "· Unreal Engine", "· 3D Rendering", "· K3d", "· 3D Volume Rendering", "· AR"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52084	other	t
2526	프론트엔드 개발자	에피소든	서울 강남구	경력 5~15년	["React", "· Next.js", "· TypeScript", "· WebRTC", "· React Native"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52355	frontend	t
2527	AI Research Engineer - Product	업스테이지	경기 용인시	신입~20년	["AI/인공지능", "· TensorFlow", "· PyTorch", "· NLP"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52267	data	t
2528	AI/LLM Curriculum Developer	업스테이지	경기 용인시	신입~20년	["AI/인공지능", "· PyTorch"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52256	data	t
2529	AI Application Engineer	업스테이지	경기 용인시	경력 3~20년	["AI/인공지능", "· PyTorch", "· NLP"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52255	data	t
2530	백엔드 개발자 (3년 ~ 7년)	데이터메이커	대전 유성구	경력 3~7년	["Django", "· Django REST framework", "· MySQL", "· Rails", "· REST API", "· Node.js"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51834	backend	t
2531	개인정보보호 담당자(경력4년~8년)	피엠인터내셔널코리아	서울 영등포구	경력 4~8년	["ISMS", "· CPPG", "· CISSP", "· CISA", "· Jira", "· Confluence", "· AZURE", "· AWS"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51711	other	t
2532	H/W설계(경력 4~8년, 3in1 Board)	한솔테크닉스	경기 수원시	경력 4~8년	["HW", "· PCB"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51911	other	t
2533	ITSM 구축 PM&PL 엔지니어	플래티어	서울 송파구	경력 5~20년	["Azure DevOps", "· Python"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51770	backend	t
2534	Software Quality Assurance	네비웍스	경기 안양시	경력 6~10년	["SW", "· QA", "· Jira", "· Confluence", "· HW"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52157	other	t
2535	[그루비 SaaS 솔루션] AI 엔지니어	플래티어	서울 송파구	경력 3~7년	["Python", "· R", "· TensorFlow", "· PyTorch", "· NLP", "· AWS", "· GCP"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51772	backend	t
2536	프론트엔드 개발자(5년 이상)	에이아이파크	서울 마포구	경력 5~10년	["JavaScript", "· TypeScript", "· HTML5", "· TailwindCSS", "· React", "· Vercel", "· Git"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52500	backend	t
2537	SW 개발자 경력 [Android, C, C++, QT]	모비루스	경기 성남시	경력 1~10년	["C++", "· C", "· SW", "· MCU", "· Embedded Linux", "· GitHub", "· Qt"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51822	mobile	t
2538	LLM Research Engineer	옵트에이아이	서울 강서구	신입~10년	["MachineLearning", "· DeepLearning", "· FPGA", "· SW", "· C++", "· RTOS", "· Python"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52106	backend	t
2539	Data Scientist in Financial (1~3년)	페니로이스	서울 종로구	경력 1~3년	["Python", "· R", "· BigData", "· MachineLearning"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52844	backend	t
2540	클라이언트 프로그래머	에이버튼	경기 성남시	경력 2~20년	["C++", "· Unreal Engine"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52363	other	t
2541	B2B소프트웨어 DevOps 운영팀(3~7년)	법틀	서울 성동구	경력 3~7년	["Python", "· Django", "· Java", "· Spring Boot", "· Vue.js", "· JavaScript", "· jQuery"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52922	backend	t
2542	AI 개발자 채용	에브리치	서울 영등포구	경력 5~10년	["C#", "· WPF", "· TensorFlow"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52050	data	t
2543	생성형 AI 데이터사이언티스트	애자일소다	서울 강남구	신입~10년	["Python", "· TensorFlow", "· DeepLearning"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52320	backend	t
2544	플랫폼 QA (5~10년)	엔카닷컴	서울 중구	경력 5~10년	["QA", "· Create React Native App", "· Jira", "· Confluence", "· Figma", "· Selenium"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52089	frontend	t
2546	백엔드 개발자 (5년 이상)	아이헤이트플라잉버그스	서울 영등포구	경력 5~7년	["NestJS", "· TypeScript", "· Node.js", "· Kotlin", "· Spring", "· GraphQL", "· Kubernetes"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52199	backend	t
2547	Embeded System SW 엔지니어	보스반도체	경기 성남시	신입~15년	["ARM", "· Verilog", "· Python", "· C++", "· SW", "· WPF", "· AWS", "· PyTorch", "· Spring Boot"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52124	backend	t
2548	알고리즘 개발자	메디트	서울 영등포구	신입~15년	["CUDA", "· OpenGL"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51665	other	t
2549	[개발] Backend Developer/8~10년	빌드코퍼레이션	서울 강남구	경력 8~10년	["Node.js", "· Next.js", "· GitHub Actions", "· Pulumi", "· AWS"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52274	backend	t
2550	[개발] Backend Developer/5~7년	빌드코퍼레이션	서울 강남구	경력 5~7년	["Node.js", "· Next.js", "· GitHub Actions", "· Pulumi", "· AWS"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52276	backend	t
2551	Application 개발자	메디트	서울 영등포구	신입~15년	["C++", "· Windows", "· macOS", "· iOS", "· Qt", "· AWS App Mesh"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51672	mobile	t
2552	얼굴인식 서버 풀스택 소프트웨어 개발자	슈프리마	경기 성남시	경력 3~7년	["C++", "· Go"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52093	backend	t
2553	헬스케어 시스템 개발자(DB개발자)	엘리오앤컴퍼니	서울 강남구	경력 5~12년	["Oracle", "· SQL", "· MSSQL", "· AWS", "· Oracle PL/SQL", "· DB", "· Dw"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52076	other	t
2554	프론트엔드 개발자	더파이러츠	서울 영등포구	경력 3~5년	["JavaScript", "· TypeScript", "· React", "· Next.js", "· styled-components"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52425	backend	t
2555	AI Research Engineer - LLM	업스테이지	경기 용인시	신입~20년	["AI/인공지능", "· TensorFlow", "· PyTorch", "· NLP"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52253	data	t
2556	아틀라시안&데브옵스 솔루션 엔지니어	플래티어	서울 송파구	경력 3~10년	["Linux", "· Windows", "· MySQL", "· Oracle", "· Jira", "· MSSQL", "· Bamboo"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51768	other	t
2557	[대구] 데이터 관리자 채용[경력]	모비루스	대구 동구	경력 2~10년	["Python", "· TensorFlow", "· Keras", "· PyTorch"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52644	backend	t
2558	소프트웨어 기술지원 채용	퀄리티아	서울 강남구	신입~3년	["SW", "· HW", "· Linux", "· Windows"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52683	other	t
2559	프로젝트 매니저 (3년 이상)	아이헤이트플라잉버그스	서울 영등포구	경력 3~10년	["Jira", "· Notion", "· Slack", "· Figma", "· DataGrip", "· Network", "· Insight", "· ISMS", "· C"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52201	data	t
2560	React 프론트엔드 개발자 (5년 이상)	아이헤이트플라잉버그스	서울 영등포구	경력 5~10년	["TypeScript", "· GraphQL", "· React", "· Apollo", "· Next.js", "· Storybook"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52200	frontend	t
2561	SAP S/4HANA FCM/SCM컨설턴트 모집	웅진	서울 중구	경력 7~20년	["SAP", "· ERP"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51737	other	t
2562	IoT시스템 개발 기획(PM) 경력자 모집	메타이노텍	경기 수원시	경력 5~10년	["Azure IoT Hub", "· Google Cloud IoT Core", "· AWS IoT Device Management"]	D-12	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52146	backend	t
2563	HW/임베디드 개발자 모집	메타이노텍	경기 수원시	경력 3~10년	["HW", "· FW", "· Embedded", "· SW", "· C", "· C++", "· PCB"]	D-12	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52147	other	t
2564	DevOps 엔지니어 (5년 ~ 10년)	데이터메이커	대전 유성구	경력 5~10년	["Terraform", "· Pulumi", "· GoLand", "· Argo", "· Linux", "· Ansible", "· Kubernetes"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51831	backend	t
2567	FPGA 개발자 /하드웨어 가속 및 알고리즘 포팅 (FPGA Developer)	모픽	경기 안양시	경력 5~15년	["FPGA", "· VHDL", "· Verilog", "· Quarkus"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52602	data	t
2568	Fullstack 개발 (5년이상)	바이트사이즈	부산 부산진구	경력 5~9년	["Python", "· JavaScript", "· MySQL", "· PyTorch", "· Git", "· Microsoft Teams"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51679	backend	t
2569	QA 담당자(3~5년차)	와디즈	경기 성남시	경력 3~5년	["QA"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51986	other	t
2570	S/W개발(경력 4~8년, 모터 제어)	한솔테크닉스	경기 수원시	경력 4~8년	["SW", "· MATLAB"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51913	other	t
2571	[대구] 소프트웨어 개발자 채용[경력]	모비루스	대구 동구	경력 2~10년	["C", "· C++", "· SW", "· Python", "· Embedded Linux", "· AI/인공지능"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51820	backend	t
2572	SW 개발자 신입 [Android, C, C++, QT]	모비루스	경기 성남시	신입	["C++", "· C", "· SW", "· MCU", "· Embedded Linux", "· GitHub", "· Qt"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51821	mobile	t
2573	이미지 프로세싱 알고리즘 개발 신입	포스로직	서울 강남구	신입	["C", "· C++", "· CUDA", "· DeepLearning", "· MachineLearning", "· AI/인공지능"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52386	mobile	t
2574	UI/UX 테스트 자동화 솔루션 엔지니어	플래티어	서울 송파구	경력 3~20년	["SAP", "· Azure DevOps"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51771	other	t
2575	On-Device AI Engineer (C++)	옵트에이아이	서울 강서구	신입~10년	["MachineLearning", "· DeepLearning", "· FPGA", "· SW", "· C++", "· RTOS"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52103	mobile	t
2576	Wi-Fi 소프트웨어 개발 15년이하	에이치원래디오	경기 안양시	경력 14~15년	["Embedded Linux", "· C", "· L2"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51707	other	t
2577	Embedded System 설계	메디트	서울 영등포구	경력 10~15년	["Linux", "· Embedded", "· Embedded Linux"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51675	other	t
2578	유니티 게임개발 과정 교강사(신입)	경일게임아이티아카데미	서울 강동구	신입	["Unity"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51870	other	t
2579	Web 개발자 채용	넥서스커뮤니티	서울 영등포구	경력 5~15년	["Java", "· Spring Boot", "· MySQL", "· MariaDB", "· Git", "· React", "· AWS", "· GCP"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51715	backend	t
2580	DevOps 엔지니어 (11년 ~ 15년)	데이터메이커	대전 유성구	경력 11~15년	["Terraform", "· Pulumi", "· GoLand", "· Argo", "· Linux", "· Ansible", "· Kubernetes"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51832	backend	t
2581	NPU Field Application Engineer	모빌린트	서울 강남구	경력 5~10년	["C++", "· TensorFlow", "· Python", "· PyTorch"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51720	backend	t
2582	AI 로보틱스 2D/3D Vision 개발자	씨메스	서울 강남구	신입~10년	["JavaScript", "· GitLab", "· Python"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52512	backend	t
2583	Data Analyst	스마트푸드네트웍스	서울 강남구	경력 5~12년	["SQL", "· Python", "· R"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52611	backend	t
2584	백엔드 개발자(웹,인프라)	에피소든	서울 강남구	경력 5~20년	["TypeScript", "· NestJS", "· PostgreSQL"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52356	backend	t
2585	글로벌 명품 플랫폼 백엔드 개발자	우노트레이딩	서울 강남구	경력 3~10년	["Python", "· MySQL", "· PostgreSQL", "· FastAPI", "· Django", "· Flask", "· SQL", "· Git"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51874	backend	t
2586	머신비전 하드웨어 개발자	아이코어	경기 안양시	경력 5~10년	["HW", "· PCB"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51703	other	t
2587	AWS 인프라 관련 설계/구축 경력직	클래스메소드코리아	서울 중구	경력 1~5년	["AWS", "· Network"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/3877	other	t
2588	Model Compression Research Engineer	옵트에이아이	서울 강서구	신입~10년	["MachineLearning", "· DeepLearning", "· FPGA"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52102	mobile	t
2589	POS/ KIOSK 개발자 모집 (계약직)	비버웍스	서울 강남구	경력 3~6년	["Git", "· C#", "· WPF", "· MVVM", "· REST API", "· SW"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51695	mobile	t
2590	시스템 사업부 신입 엔지니어	이비즈테크	서울 마포구	신입	["Azure DevOps", "· Azure DevOps Server", "· Windows", "· Linux"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52225	backend	t
2591	[경력] Java 풀스택 개발자	에피넷	경기 안양시	경력 2~7년	["Java", "· Linux", "· Docker", "· Spring Framework", "· Git", "· Python"]	D-19	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52569	backend	t
2592	AI (LLM RAG) 개발자	셀키	서울 서초구	경력 3~10년	["Python", "· PyTorch", "· Amazon SageMaker", "· TensorFlow", "· NLP"]	D-day	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51648	backend	t
2593	웹&앱 프론트엔드 개발자	에이아이컨실리움(AIConsiliumCo.,Ltd)	인천 부평구	경력 1~3년	["JavaScript", "· React", "· React Native", "· Git", "· Next.js", "· Figma", "· Kotlin", "· Swift"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52662	backend	t
2594	JAVA 개발자 채용	소프트넷	서울 강남구	경력 3~10년	["JavaScript", "· Angular 2", "· React", "· Vue.js", "· Java", "· Spring", "· SQL", "· REST API"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52544	backend	t
2595	PM (Project Manager)	인베스티	서울 성동구	경력 6~10년	["Node.js", "· React", "· AWS", "· SQL"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52415	backend	t
2596	프런트 개발 경력직 채용	인공지능팩토리	서울 중구	경력 1~5년	["HTML5", "· CSS 3", "· JavaScript", "· TypeScript", "· React", "· Next.js", "· TailwindCSS"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52892	backend	t
2597	AI 국제 물류 스타트업 백엔드 개발자	아로아랩스	서울 종로구	경력 2~5년	["Go", "· GitHub", "· SQL", "· AZURE", "· vscode.dev"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53158	backend	t
2598	[VOYAGER] AI 엔지니어	보이저	서울 구로구	신입~20년	["AI/인공지능", "· C", "· C++", "· Python", "· DeepLearning"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52620	backend	t
2599	쇼핑몰/헬스케어 서비스 개발자	보미오라한의원	서울 강남구	경력 3~10년	["CSS 3", "· HTML5", "· JavaScript", "· Node.js", "· Flutter", "· PHP"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52663	backend	t
2600	HW개발자(신입가능)	럭스로보	서울 서초구	신입~10년	["PCB"]	D-19	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52769	other	t
2601	배치시스템 개발자	한우리아이티	서울 강서구	경력 3~8년	["MySQL", "· Linux", "· Java", "· C", "· Oracle", "· Spring", "· Spring Boot", "· Python"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53139	backend	t
2602	Software Engineer (Front-End)	부스터스	서울 강남구	경력 2~5년	["Vue.js", "· jQuery", "· TailwindCSS", "· Bootstrap", "· SW", "· Dashboards by Keen IO"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52873	frontend	t
2603	Unity 클라이언트 개발자 (3년-6년)	WATA Inc.	경기 성남시	경력 3~6년	["Unity", "· C#", "· Java", "· C++", "· Lua"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53180	backend	t
2604	임베디드 리눅스 네트워크 개발_팀원급	누코드	서울 강남구	경력 3~5년	["Zephyr", "· Embedded Linux", "· Arduino", "· FPGA"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51780	other	t
2605	FW 엔지니어 (경력)	칩스앤미디어	서울 강남구	경력 5~12년	["C++", "· C", "· HW", "· FW"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52168	other	t
2606	Embedded Linux System 개발자 구인	미라텍	경기 성남시	경력 7~15년	["Embedded Linux", "· C", "· C++"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52833	other	t
2607	비전알고리즘 개발 연구원(11년-15년)	WATA Inc.	경기 성남시	경력 11~15년	["C++", "· OpenCV", "· C#", "· Rust", "· Python", "· Segment"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53027	backend	t
2608	SW Engineer-정보보안(암호화알고리즘)	리브스메드	경기 성남시	경력 5~12년	["Linux", "· C++", "· Network"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52331	other	t
2609	인공지능(AI) 엔지니어 중급 채용	알비에치	경기 안양시	경력 4~7년	["MachineLearning", "· DeepLearning", "· AI/인공지능", "· Python"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52232	backend	t
2610	RF Module 개발 (과장~차장급)	브로던	경기 화성시	경력 10~15년	["HW", "· RF"]	D-25	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52969	other	t
2611	임베디드 S/W 엔지니어 모집 (경력3~5년)	인터콘시스템스	경기 수원시	경력 3~5년	["MCU", "· RTOS", "· Embedded Linux", "· C", "· C++", "· ARM", "· SW"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52308	other	t
2612	H/W 엔지니어 모집(경력 6~10년)	인터콘시스템스	경기 수원시	경력 6~10년	["HW", "· Orcad", "· Pads", "· Autocad", "· MCU", "· FPGA"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52307	other	t
2613	[RE : IW] Game Server Programmer 채용	보이저	서울 구로구	신입~20년	["AZURE", "· Unity", "· ASP.NET", "· MySQL", "· NoSql", "· AWS", "· C++", "· C#"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52615	backend	t
2614	[RE : IW] 클라이언트 프로그래머	보이저	서울 구로구	신입~20년	["C++", "· DirectX", "· Redis", "· Unity", "· C#", "· Git"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52619	other	t
2615	앱 개발자 (고급)	알비에치	경기 안양시	경력 7~10년	["Flutter", "· Android OS", "· iOS", "· REST API", "· React"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52779	frontend	t
2616	평택연구소 SW개발 (경력 7~15년)	인텔리안테크놀로지스	경기 평택시	경력 7~15년	["C", "· C++", "· Embedded Linux", "· JsonAPI"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52805	frontend	t
2618	시니어 백엔드 SW Engineer	제이앤피메디	인천 연수구	경력 8~20년	["TypeScript", "· MSA", "· MySQL", "· Node.js", "· AWS", "· GitHub Actions"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53186	backend	t
2619	AI 국제 물류 스타트업 ITOps 개발자	아로아랩스	서울 종로구, 서울 마포구	신입~4년	["C#", "· AZURE", "· Go", "· GORM"]	D-32	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53254	backend	t
2620	펌웨어 엔지니어 시니어급	혜연전자	인천 서구	경력 5~7년	["C", "· C++", "· MCU", "· Bootsnap"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52420	other	t
2621	FW개발자(3년~5년)	럭스로보	서울 서초구	경력 3~5년	["Embedded", "· RTOS", "· MCU"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52766	other	t
2622	시니어 풀스택 SW Engineer	제이앤피메디	인천 연수구	경력 8~20년	["MSA", "· TypeScript", "· JSX", "· Sass", "· GitHub Actions", "· Node.js", "· MySQL"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53188	backend	t
2623	Flutter 프론트엔드 개발자 채용	서울거래	서울 영등포구	경력 3~20년	["Flutter", "· REST API", "· Git", "· MVVM", "· Dart", "· iOS", "· Android OS"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53230	frontend	t
2624	3D 그래픽스 엔지니어 (신입/경력)	엔닷라이트	경기 성남시	신입~10년	["WebGL", "· three.js", "· BabylonJS", "· OpenGL", "· 3D Rendering", "· React"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52668	frontend	t
2625	FW개발자(10년~15년)	럭스로보	서울 서초구	경력 10~15년	["Embedded", "· RTOS", "· MCU"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52768	other	t
2627	AI 비서 어플 개발 엔지니어 채용	보이저	서울 구로구	경력 1~15년	["Unity", "· Python", "· C", "· C++", "· Java", "· AI/인공지능", "· DeepLearning"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52622	backend	t
2628	FAE 펌웨어 엔지니어	누코드	서울 강남구	경력 1~6년	["GitHub", "· RTOS", "· Zephyr", "· Arduino"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52350	other	t
2629	판교연구소 SW개발 (경력 13~15년)	인텔리안테크놀로지스	경기 성남시	경력 13~15년	["C", "· C++", "· Embedded Linux", "· JsonAPI"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52808	frontend	t
2630	기술개발 총괄 및 리딩(16~20년)	WATA Inc.	경기 성남시	경력 16~20년	["RDB", "· REST API", "· C++", "· Java", "· AWS", "· React", "· SQL"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52977	backend	t
2631	펌웨어 엔지니어 주니어급	혜연전자	인천 서구	경력 1~3년	["C", "· C++", "· MCU", "· Bootsnap"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52419	other	t
2632	의료기기 GUI S/W 경력 채용	아프로코리아	경기 군포시	경력 5~10년	["SW", "· C#", "· Visual Studio", "· Embedded", "· Windows", "· .NET", "· GUI"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52077	other	t
2633	시스템 엔지니어 채용	소프트넷	서울 강남구	경력 3~15년	["Windows Server", "· Azure Synapse", "· AZURE", "· Windows"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52543	backend	t
2634	판교연구소 SW개발 (경력 7~9년)	인텔리안테크놀로지스	경기 성남시	경력 7~9년	["C", "· C++", "· Embedded Linux", "· JsonAPI"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52806	frontend	t
2635	Data Engineer(데이터 엔지니어)	셀키	서울 서초구	경력 3~10년	["AWS", "· Etl", "· Azure DevOps", "· REST API", "· Docker", "· Java", "· Python", "· Node.js"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52939	backend	t
2636	FW 펌웨어 개발(3년 이상)	윌로그	서울 강남구	경력 3~6년	["FW", "· MCU", "· RTOS", "· C", "· C++", "· Git", "· HW"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52831	other	t
2637	통신장비 시스템 h/w 개발자	에프알텍	경기 의왕시	신입	["PCB"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53125	other	t
2638	[하나금융그룹 자회사] DBA (3년이상)	핀크	서울 중구	경력 3~6년	["MariaDB", "· MaxScale", "· MySQL"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53199	other	t
2639	프론트엔드 및 앱 개발자 채용 (iOS)	아타드	서울 송파구, 부산 남구, 경기 성남시	경력 1~3년	["Objective-C", "· Swift", "· Java", "· React", "· React Native", "· Amazon EC2", "· Oracle"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52295	backend	t
2640	iOS 앱개발자(주35시간, 4.5일)	라쿠카라차	서울 강남구	경력 3~10년	["iOS"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52528	mobile	t
2641	AI 영상처리 개발자 채용	이노뎁	서울 금천구	신입~10년	["SQL", "· Docker", "· WebRTC", "· Kafka", "· Minio", "· MQTT", "· PostgreSQL", "· Python"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53031	backend	t
2642	웹 애플리케이션 개발(경력2~7)	쿤텍	경기 성남시	경력 2~7년	["Spring Boot", "· React", "· TypeScript", "· API Tracker", "· MySQL", "· Git"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52713	backend	t
2643	어플리케이션 개발 및 유지보수	엠투아이코퍼레이션	경기 안양시	신입~5년	["C++", "· Qt"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51640	other	t
2644	백엔드 개발자(주 35시간, 4.5일)	라쿠카라차	서울 강남구	경력 3~10년	["Spring Boot"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52529	backend	t
2645	SW공급망 보안솔루션 엔지니어(신입)	쿤텍	경기 성남시	신입	["Linux", "· Windows Server", "· Golang", "· Docker", "· Kubernetes"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52718	backend	t
2646	[AI연구소] AI연구-Computer Vision AI	딥노이드	서울 구로구	신입	["PyTorch", "· TensorFlow", "· Docker", "· Linux", "· Shell"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52098	data	t
2647	안드로이드 앱개발자(주35시간, 4.5일)	라쿠카라차	서울 강남구	경력 3~10년	["Android SDK"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52527	mobile	t
2648	[클라우드] 인프라 엔지니어 채용	아타드	서울 송파구, 부산 남구, 경기 성남시	경력 1~5년	["AWS", "· GCP", "· AZURE", "· Oracle", "· CloudQuery", "· Kubernetes", "· Docker"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52294	mobile	t
2649	프론트엔드 개발자 경력 채용	위볼린	서울 성동구	경력 2~5년	["GitLab", "· React", "· Next.js", "· Git", "· TypeScript", "· Router", "· Emotion"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53074	frontend	t
2650	[인공지능] LLM 개발자 채용	아타드	서울 송파구, 부산 남구, 경기 성남시	경력 1~3년	["AI/인공지능", "· MachineLearning", "· DeepLearning", "· SQL", "· AWS", "· C lang"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52293	mobile	t
2651	네트워크/OT 보안 엔지니어(신입)	쿤텍	경기 성남시	신입	["Linux", "· Windows Server", "· Firewall"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52728	backend	t
2652	[DX사업본부] 서비스 기획자	딥노이드	서울 구로구	경력 3~10년	["Figma", "· Microsoft Office 365", "· MySQL"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52100	other	t
2653	안드로이드 개발자(경력4~6년)	고스트패스	서울 영등포구	경력 4~6년	["Git", "· Jira", "· HTTPie", "· REST API", "· MVVM"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52172	mobile	t
2654	[백엔드,서버] 개발자 채용	아타드	서울 송파구, 부산 남구, 경기 성남시	경력 1~5년	["Node.js", "· ExpressJS", "· MySQL", "· MariaDB", "· AWS", "· AZURE", "· GCP"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52292	backend	t
3141	SAP MM 운영 및 개발자	브이엔티지	서울 마포구	경력 5~15년	["ABAP", "· ERP", "· SAP"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51549	other	t
2655	이미지 생성AI 전문 AI/DL 엔지니어	커넥트브릭	서울 마포구	경력 2~15년	["Python", "· DeepLearning", "· AI/인공지능", "· OpenCV", "· PyTorch"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52553	backend	t
2656	IDT실_기술(Tech)통역 (대리~과장)	리만코리아	서울 강남구	경력 5~12년	["Java", "· Spring Framework", "· Spring Boot", "· QueryDSL", "· JUnit"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52087	backend	t
2657	앱 개발자 (신입)	알비에치	경기 안양시	신입	["Flutter", "· Android OS", "· iOS", "· REST API", "· React"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52781	frontend	t
2658	STT/LLM 모델 연구 및 개발자 채용	넥서스커뮤니티	서울 영등포구	경력 7~20년	["Python", "· DeepLearning", "· NLP", "· Linux"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51722	backend	t
2659	인공지능(AI) 엔지니어 신입 채용	알비에치	경기 안양시	신입	["MachineLearning", "· DeepLearning", "· AI/인공지능", "· Python"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52234	backend	t
2660	클라우드 사업부 엔지니어	이비즈테크	서울 마포구	신입~3년	["Azure DevOps", "· Azure DevOps Server", "· Windows", "· Linux"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52224	backend	t
2661	사내그룹웨어,파트너 B2B 서비스 개발	지니언스	경기 안양시	경력 1~15년	["Laravel", "· Travis CI", "· PHP", "· Git", "· JavaScript", "· jQuery", "· ES6"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52406	backend	t
2662	앱 개발자 (초급)	알비에치	경기 안양시	경력 2~4년	["Flutter", "· Android OS", "· iOS", "· REST API", "· React"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52780	frontend	t
2663	백엔드 개발자	포트로직스	경기 성남시	경력 5~10년	["GitHub", "· Java", "· AWS", "· NGINX", "· MySQL", "· Spring Boot", "· Spring Data JPA"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51857	backend	t
2664	Data 엔지니어 - Junior (대전 근무)	시스트란	대전 서구	신입	["Python", "· TensorFlow", "· PyTorch", "· NLP", "· Linux", "· Docker", "· DeepLearning"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51919	backend	t
2665	인공지능(AI) 엔지니어 초급 채용	알비에치	경기 안양시	경력 1~3년	["MachineLearning", "· DeepLearning", "· AI/인공지능", "· Python"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52231	backend	t
2666	소프트웨어 엔지니어(Frontend)	사각	서울 마포구	경력 1~8년	["React", "· Next.js", "· Android OS", "· iOS", "· TypeScript"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52908	frontend	t
2667	NLP AI 엔지니어	에이블제이	경기 성남시	경력 3~15년	["PyTorch", "· TensorFlow", "· Transformers", "· TypeScript", "· NestJS", "· Python"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52691	backend	t
2668	블록체인 인프라 개발자	아타드	서울 송파구, 부산 남구, 경기 성남시	경력 1~5년	["Golang", "· Solidity", "· Hyperledger Indy", "· GCP", "· AWS", "· AZURE", "· Docker"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52296	backend	t
2669	풀스텍 개발자 경력 채용	위볼린	서울 성동구	경력 2~5년	["Next.js", "· Node.js", "· NestJS", "· TypeScript", "· MariaDB", "· MySQL", "· Prisma"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53075	backend	t
2670	2차전지 검사기 개발자 (경력8~10년)	아이비젼웍스	충남 천안시	경력 8~10년	["OpenCV", "· C++", "· Mfc"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52134	other	t
2671	[CTO레벨] NLP AI 엔지니어	에이블제이	경기 성남시	경력 5~15년	["PyTorch", "· TensorFlow", "· Transformers", "· TypeScript", "· NestJS", "· Python"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52692	backend	t
2672	Sr. AI & Data Analysis Specialist(5~10y)	피엠인터내셔널코리아	서울 영등포구	경력 5~10년	["SQL", "· NoSql", "· Tableau", "· AWS", "· AZURE", "· NLP"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52775	data	t
2674	GUI S/W 설계,개발 채용(15년↑)	에이디티	경기 안산시	경력 15~20년	["Visual C++", "· C#", "· JavaScript", "· Linux", "· REST API"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53192	backend	t
2675	Node.js 서버/백엔드 개발자(5~10년)	더스포츠커뮤니케이션	서울 강서구	경력 5~10년	["Node.js"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53181	backend	t
2676	2차전지 검사기 개발자 (신입 또는 경력1~4년)	아이비젼웍스	충남 천안시	신입~4년	["OpenCV", "· C++", "· Mfc"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52136	other	t
2677	2차전지 검사장비 개발/유지보수 채용	피닉슨컨트롤스	경기 화성시	경력 1~5년	["C#", "· MSSQL", "· SW", "· MySQL", "· C++", "· WPF"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51934	other	t
2678	QA 담당자(6~8년차)	와디즈	경기 성남시	경력 6~8년	["QA"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51987	other	t
2679	웹 프론트엔드 개발자 채용(4년 이상)	비글즈	경기 성남시	경력 4~15년	["Next.js", "· React", "· JavaScript", "· TypeScript"]	D-19	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52765	backend	t
2680	백엔드 시니어 개발자	딜리버리랩	서울 성동구	경력 5~15년	["MySQL", "· AWS", "· Spring Boot", "· PostgreSQL", "· Oracle"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53083	backend	t
2681	기구설계 엔지니어 모집	앤씨앤	경기 성남시	경력 5~15년	["Embedded Linux", "· C", "· C++", "· SW", "· TCP/IP", "· Embedded", "· GUI", "· Appium"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51884	other	t
2682	Embedded SW 10년↑ 경력 연구원 모집	오버컴테크	서울 금천구	경력 10~13년	["FW", "· RTOS", "· Embedded"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52033	other	t
2683	임베디드SW 또는 FW개발자(경력5~8)	쿤텍	경기 성남시	경력 5~8년	["Embedded Linux", "· C++", "· C"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52747	other	t
2684	H/W개발(9~13년,생활가전 모터/인버터)	한솔테크닉스	경기 수원시	경력 9~13년	["PCB", "· Orcad", "· Analog", "· Pads", "· PMD", "· SMPS"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51909	other	t
2685	통합보안관리 엔지니어(경력)	이너버스	서울 영등포구	경력 3~7년	["SW", "· Linux", "· Docker", "· Elasticsearch", "· Kafka", "· Python", "· Kibana"]	D-12	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52004	backend	t
2686	로봇 제품화 프로덕트 기술 매니저	씨메스	서울 강남구	경력 6~20년	["Solidworks", "· Autocad"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53060	other	t
2687	H/W개발(4~8년, 생활가전 모터/인버터)	한솔테크닉스	경기 수원시	경력 4~8년	["PCB", "· Orcad", "· Analog", "· Pads", "· PMD", "· SMPS"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51908	other	t
2688	Human Pose Estimation (딥러닝,경력)	스포츠투아이	경기 성남시	경력 3~20년	["3D Rendering", "· AI/인공지능", "· Python", "· PyTorch", "· OpenCV"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52796	backend	t
2689	의료기기 소프트웨어(SW) 개발자 모집	에이엠시지	서울 서초구	경력 3~10년	["DICOM", "· Qt", "· C++", "· SQL", "· GUI", "· Visual C++"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52949	other	t
2690	DBE 담당(6년↑)	엑심베이	서울 구로구	경력 6~8년	["NoSql", "· MySQL", "· MariaDB", "· Percona Server for MySQL", "· AWS", "· GCP"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53120	backend	t
2691	NPU Verification Engineer	모빌린트	서울 강남구	경력 5~10년	["C", "· C++", "· Linux", "· DeepLearning", "· MachineLearning", "· Embedded"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51726	mobile	t
2692	정보보호 인증 담당 모집	코닉글로리	서울 강남구	경력 3~10년	["Linux", "· Network"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52600	other	t
2693	[대만지사] 네트워크 엔지니어 경력	에어키	기타	경력 3~10년	["Network", "· Cisco", "· TCP/IP", "· VPN", "· AWS", "· AZURE", "· Ccna", "· Ccnp", "· Ccie"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53108	other	t
2694	Embedded SW 14년↑ 경력 연구원 모집	오버컴테크	서울 금천구	경력 14~17년	["FW", "· RTOS", "· Embedded"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52034	other	t
2695	Embedded Middleware 개발자	앤씨앤	경기 성남시	경력 5~10년	["Embedded Linux", "· C", "· C++", "· SW", "· TCP/IP", "· Embedded"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51883	data	t
2696	배구 3D 챌린지 시스템 개발	스포츠투아이	경기 성남시	경력 2~15년	["OpenGL", "· C++", "· Unreal Engine", "· C", "· AR", "· CUDA", "· Unity", "· 3D Rendering"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52795	other	t
2697	Python 백엔드개발지_의료기기 S/W	에스와이엠헬스케어	서울 광진구	경력 5~10년	["Python", "· Django", "· Linux", "· AWS", "· MariaDB", "· Docker", "· OpenCV"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53249	backend	t
2698	System Software Engineer	모빌린트	서울 강남구	경력 5~10년	["Linux", "· C++", "· Embedded", "· sw", "· C"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51721	other	t
2673	H/W System Design Engineer(Junior)	모빌린트	서울 강남구	경력 3~5년	["PCB", "· HW", "· Orcad"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51729	other	t
2699	웹 애플리케이션 개발(경력14~20)	쿤텍	경기 성남시	경력 14~20년	["Spring Boot", "· React", "· TypeScript", "· API Tracker", "· MySQL", "· Git"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52717	backend	t
2700	S/W개발	원익피앤이	경기 수원시	경력 6~20년	["Python", "· TensorFlow", "· Keras"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52497	backend	t
2701	DBE 담당(3년↑)	엑심베이	서울 구로구	경력 3~5년	["NoSql", "· MySQL", "· MariaDB", "· Percona Server for MySQL", "· AWS", "· GCP"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53119	backend	t
2702	Unreal 클라이언트 개발자 채용(경력)	네비웍스	경기 안양시	경력 3~10년	["C++", "· Unreal Engine"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52154	other	t
2703	개발 계획 및 개발 진행 PM(5~9년)	WATA Inc.	경기 성남시	경력 5~9년	["GitHub", "· Jira", "· Java", "· AWS", "· RDB", "· AWS Cloud Development Kit"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52975	backend	t
2704	임베디드 S/W 엔지니어 모집 (경력6~10년)	인터콘시스템스	경기 수원시	경력 6~10년	["MCU", "· RTOS", "· Embedded Linux", "· C", "· C++", "· ARM", "· SW"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52309	other	t
2705	앱 개발자 (중급)	알비에치	경기 안양시	경력 5~7년	["Flutter", "· Android OS", "· iOS", "· REST API", "· React"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52778	frontend	t
2706	소프트웨어 엔지니어 (Backend)	사각	서울 마포구	경력 1~8년	["Django", "· FastAPI", "· NestJS", "· PostgreSQL", "· MongoDB", "· AWS", "· Redis"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52909	backend	t
2707	Playce Cloud Pre-Sales	오픈소스컨설팅	서울 강남구	경력 7~20년	["OpenStack", "· Kubernetes", "· Jenkins", "· GitLab", "· Argo", "· AWS", "· AZURE", "· GCP"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52150	backend	t
2708	개발 계획 및 개발 진행 PM(15~20년)	WATA Inc.	경기 성남시	경력 15~20년	["GitHub", "· Jira", "· Java", "· AWS", "· RDB", "· AWS Cloud Development Kit"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52976	backend	t
2709	JAVA개발(8년~10년)	위즈코리아	서울 강서구	경력 8~10년	["Java", "· NoSql", "· Apache Tomcat", "· BigData"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52568	backend	t
2710	소프트웨어 엔지니어(AI)	사각	서울 마포구	경력 1~8년	["Svelte", "· FastAPI", "· Python", "· AI/인공지능"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52818	backend	t
2711	FW개발자(5년~10년)	럭스로보	서울 서초구	경력 5~10년	["Embedded", "· RTOS", "· MCU"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52767	other	t
2712	제어설계(PC) 분야 [경력10~15년]	태하	경기 남양주시	경력 10~15년	["SW", "· C", "· C#", "· C++", "· Mfc", "· MES", "· SQL", "· Windows", "· Linux"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52347	other	t
2713	전자제어 S/W [신입~4년]	태하	경기 남양주시	신입~4년	["SW", "· C", "· C++", "· FW"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52343	other	t
2714	풀스택 고급 개발자	지피에이코리아	서울 강남구	경력 7~10년	["Android OS", "· iOS", "· Java", "· Kotlin", "· Swift", "· Objective-C", "· Flutter", "· AWS"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52661	backend	t
2715	Cloud Engineer	메디트	서울 영등포구	경력 5~15년	["Backendless", "· Spring Framework", "· Google Cloud Platform", "· Java"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51667	backend	t
2716	의료기기 HW개발자(OrCad, Pads, 회로설계)	레이언스	경기 화성시	경력 3~13년	["Orcad"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52317	other	t
2717	LIS System 개발 및 운영	오픈헬스케어	서울 성동구	경력 5~15년	[".NET", "· C#", "· Java", "· Nexacro", "· REST API", "· Oracle", "· MariaDB", "· Git", "· AWS"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52205	backend	t
2718	RTOS F/W 및 Linux App 개발 모집	유니온바이오메트릭스	서울 송파구	신입~5년	["RTOS", "· FW", "· MCU", "· C", "· C++", "· Git", "· AWS", "· Linux", "· Qt"]	D-30	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52550	other	t
2719	웹(React) 개발자 (전문연 가능)	클라썸	서울 강남구	경력 2~5년	["HTML5", "· CSS 3", "· TypeScript", "· React", "· Redux", "· Git", "· Sass", "· SCSS"]	D-19	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52645	frontend	t
2720	Computer Vision	쓰리아이	서울 강남구	경력 1~20년	["C++", "· Python", "· TensorFlow", "· PyTorch", "· OpenCV", "· MachineLearning"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52849	backend	t
2721	시스템 관리자(병원 Network 및 PC 유지보수)	GC케어	서울 영등포구	경력 1~5년	["Windows", "· HW", "· Network"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/48788	other	t
2722	QA Engineer	쓰리아이	서울 강남구	경력 3~20년	["Jira", "· Redmine", "· HW", "· SW", "· QA"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52851	other	t
2723	하이브리드 앱 개발자	케이웨더	서울 구로구	경력 3~10년	["React Native"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52186	frontend	t
2724	풀스택 중급 개발자	지피에이코리아	서울 강남구	경력 3~6년	["Android OS", "· iOS", "· Java", "· Kotlin", "· Swift", "· Objective-C", "· Flutter", "· AWS"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52660	backend	t
2725	FrontEnd 개발자(Pivo Engineering)	쓰리아이	서울 강남구	경력 4~10년	["TypeScript", "· Vue.js", "· WebRTC", "· three.js", "· Confluence", "· Jira", "· Git", "· React"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52852	frontend	t
2726	백엔드 개발자 경력 채용	브이피피랩	서울 강남구	경력 3~10년	["Git", "· GitHub", "· AWS", "· Spring Framework", "· Spring Boot", "· Spring MVC"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52387	backend	t
2727	프론트엔드 개발자 (경력 1년 이상)	아이쿠카	서울 영등포구	경력 1~15년	["JavaScript", "· React", "· React Native", "· Java", "· HTML5", "· CSS 3"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52961	backend	t
2728	통합보안관리 엔지니어(신입)	이너버스	서울 영등포구	신입~2년	["SW", "· Linux", "· Docker", "· Elasticsearch", "· Kafka", "· Python", "· Kibana"]	D-12	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52003	backend	t
2730	언리얼 게임개발 과정 교강사(신입)	경일게임아이티아카데미	서울 강동구	신입	["C++", "· Unreal Engine"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51869	other	t
2731	EV charger S/W 개발자	피앤이시스템즈	경기 화성시	경력 3~13년	["Rust", "· C++"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53030	other	t
2732	EV charger embedded 개발	피앤이시스템즈	경기 화성시	경력 3~6년	["Rust", "· C++"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51882	other	t
2733	전자제어 S/W 경력 개발자 모집	코아비스	세종	경력 1~10년	["FW", "· Embedded", "· C", "· SW"]	D-7	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51984	other	t
2734	Physical Design Engineer	보스반도체	경기 성남시	경력 3~15년	["ASIC"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52119	other	t
2735	머신 비전 개발자	에이트테크	서울 구로구	경력 4~10년	["C#", "· C++", "· Python"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52917	backend	t
2736	의료기기 FW개발자 (C++, C#, QT, DB) (10~15년차)	레이언스	경기 화성시	경력 10~15년	["C++", "· C#", "· Qt", "· DB", "· TCP/IP", "· Embedded Linux", "· Linux", "· Mfc"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52318	other	t
2737	모바일파트- IOS 개발	비바이노베이션	서울 강남구	경력 5~15년	["Swift"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52932	mobile	t
2738	프론트엔드 엔지니어(경력 6~8년)	클래스101	서울 강남구	경력 6~8년	["React", "· TypeScript", "· GraphQL", "· Apollo", "· React Native"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52391	frontend	t
2739	Linux/Android BSP 개발 경력 모집	유니온바이오메트릭스	서울 송파구	경력 3~15년	["Linux", "· FW", "· C", "· C++"]	D-30	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52510	mobile	t
2740	프론트엔드 엔지니어(경력12-14년)	클래스101	서울 강남구	경력 12~14년	["React", "· TypeScript", "· GraphQL", "· Apollo", "· React Native"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52393	frontend	t
2741	AI 기술 개발자	비바이노베이션	서울 강남구	경력 6~15년	["Python", "· TensorFlow", "· PyTorch", "· scikit-learn", "· SQL", "· AWS", "· Docker"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52935	backend	t
2742	[전기차충전기]안드로이드 개발자	피앤이시스템즈	경기 화성시	경력 5~10년	["Kotlin", "· Jetpack", "· Composer", "· SQLite", "· WebSocket"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52090	mobile	t
2743	서버 파트 부문(경력)	비바이노베이션	서울 강남구	경력 5~15년	["Python", "· FastAPI", "· Django", "· Celery", "· MySQL", "· MongoDB", "· AWS", "· Docker"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52931	backend	t
2744	RTOS F/W 개발 경력 모집	유니온바이오메트릭스	서울 송파구	경력 3~15년	["RTOS", "· FW", "· MCU", "· Network", "· C", "· C++", "· Git"]	D-30	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52509	other	t
2746	AI Model Production - Document AI	업스테이지	경기 용인시	경력 2~20년	["Python", "· Java", "· AI/인공지능", "· Ubuntu", "· Windows"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52246	backend	t
2747	AI Model Production - LLM	업스테이지	경기 용인시	경력 2~20년	["AI/인공지능"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52248	data	t
2748	자율주행 하드웨어 기계설계 엔지니어	토르드라이브	서울 영등포구	경력 3~10년	["Solidworks"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51983	other	t
2749	SW공급망 보안솔루션설계(경력18~20)	쿤텍	경기 성남시	경력 18~20년	["Linux", "· Windows Server", "· Golang", "· Docker", "· Kubernetes", "· Python"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52745	backend	t
2750	의료 AI 제품 패키징 파이썬 개발자	딥노이드	서울 구로구	경력 5~10년	["Python", "· Docker", "· Linux", "· Shell", "· Java", "· C++"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52107	backend	t
2751	AI Product Owner	업스테이지	경기 용인시	경력 5~20년	["AI/인공지능", "· Python", "· C++", "· Linux", "· Shell"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52257	backend	t
2752	리눅스 C / C++ 서버 개발자	코닉글로리	서울 강남구	경력 2~15년	["C", "· C++", "· Linux", "· TCP/IP", "· Shell"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52599	backend	t
2753	Embedded SW 18년↑ 경력 연구원 모집	오버컴테크	서울 금천구	경력 18~20년	["FW", "· RTOS", "· Embedded"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52037	other	t
2754	AI 서비스 기획자	씨메스	서울 강남구	경력 3~10년	["Notion", "· Figma"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52513	data	t
2755	SW공급망 보안솔루션 엔지니어(경력)	쿤텍	경기 성남시	경력 2~4년	["Linux", "· Windows Server", "· Golang", "· Docker", "· Kubernetes"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52723	backend	t
2756	Android Frameworks/Application 개발	엠핀스	경기 안양시	경력 7~20년	["Android OS", "· Java", "· Kotlin", "· C++", "· C"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52268	backend	t
2757	F/W개발(MCU) (경력 8~10년)	원익피앤이	경기 수원시	경력 8~10년	["C", "· FW", "· MCU"]	D-19	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52495	other	t
2758	R&D 기술전략실 PM 채용	채비	서울 서초구	경력 7~20년	["SW"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52187	other	t
2759	R&D 부문 PM(신제품개발실)	채비	서울 서초구	경력 5~15년	["SW", "· HW"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51762	other	t
2760	풀스택 소프트웨어 엔지니어(AI)	애자일소다	서울 강남구	경력 2~10년	["Python", "· React", "· TypeScript"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52321	backend	t
2761	MultiOS팀 Linux보안 소프트웨어 개발	지니언스	경기 안양시	경력 7~15년	["C", "· C++", "· Linux", "· OpenSSL", "· Kafka", "· GitHub"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52402	mobile	t
2762	Computational Imaging Engineer (전문연구요원 가능)	토모큐브	대전 유성구	경력 2~5년	["MATLAB", "· CUDA", "· 3D Rendering"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52559	other	t
2763	프론트엔드 개발자 시니어[8년차이상]	잇올	서울 서초구	경력 8~10년	["Yarn", "· React", "· Next.js", "· TypeScript", "· React Query", "· Zustand", "· REST API"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51944	frontend	t
2764	군전장체계 프로젝트매니저 채용	피피에스	서울 광진구	경력 1~20년	["PM2", "· Deta Cloud"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51900	other	t
2765	스마트팩토리 로봇관제 S/W 개발자	인아텍앤코포	인천 남동구	경력 1~5년	["MES", "· C#", "· Java", "· MQTT", "· REST API", "· gRPC", "· Python", "· JavaScript", "· Git"]	D-12	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52242	backend	t
2766	JAVA개발(5년~7년)	위즈코리아	서울 강서구	경력 5~7년	["Java", "· NoSql", "· Apache Tomcat", "· BigData"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52567	backend	t
2767	SW 기술본부장	채비	서울 서초구	경력 10~20년	["FW", "· SW", "· C#", "· C", "· WPF"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51775	other	t
2768	프론트엔드 개발자 주니어[5년차이상]	잇올	서울 서초구	경력 5~7년	["Yarn", "· React", "· Next.js", "· TypeScript", "· React Query", "· Zustand", "· REST API"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51943	frontend	t
2769	자율주행로봇 백엔드 엔지니어 (서울)	폴라리스쓰리디	서울 용산구	경력 5~8년	["Java", "· Spring Boot", "· REST API", "· MySQL", "· PostgreSQL", "· React", "· Vue.js"]	D-12	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52266	backend	t
2770	인공지능 기획 및 개발자 채용	에이블테라퓨틱스	서울 영등포구	경력 2~15년	["PyTorch", "· AI/인공지능", "· TensorFlow", "· Azure Pipelines", "· DeepLearning"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52887	mobile	t
2771	데스크탑 앱 개발자	클레	서울 성동구	신입	["Python", "· C++", "· .NET", "· OpenGL", "· C#", "· Qt", "· SW", "· Windows", "· Linux"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52868	backend	t
2772	기술융합사업부 IT 프로젝트 PM/서브PM	엠더블유네트웍스	서울 강남구	신입~5년	["react-testing-library", "· QA", "· Flow", "· Project Reactor"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52344	frontend	t
2773	JAVA 웹 개발자 채용	에이블테라퓨틱스	서울 영등포구	경력 5~15년	["Python", "· Java", "· Spring Boot", "· Git", "· MariaDB", "· NGINX", "· Apache Tomcat"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52891	backend	t
2774	Python 개발자 모집	애드크림	서울 강남구	경력 3~5년	["Python", "· DB", "· AngularJS", "· Vue.js", "· Classic ASP", "· C#", "· ASP.NET", "· MSSQL"]	D-12	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52211	backend	t
2775	서버/백엔드/유지보수 개발자 모집	한국비즈넷	서울 구로구	경력 3~10년	["Java", "· MSSQL", "· Oracle", "· Spring Boot"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52375	backend	t
2776	프론트엔드 웹개발자 채용(경력5~7년)	케이웨더	서울 구로구	경력 5~7년	["Java", "· Linux", "· React", "· Next.js", "· TypeScript", "· JavaScript", "· REST API"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52184	backend	t
2777	프론트엔드 웹개발자 채용(경력8~10년)	케이웨더	서울 구로구	경력 8~10년	["Java", "· Linux", "· React", "· Next.js", "· TypeScript", "· JavaScript", "· REST API"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52185	backend	t
2778	ai 개발자	메디트	서울 영등포구	경력 5~12년	["C++", "· CUDA", "· DeepLearning", "· AI/인공지능", "· Flask", "· FastAPI"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51664	backend	t
2779	EV charger server 개발자	피앤이시스템즈	경기 화성시	경력 3~5년	["Node.js", "· TypeScript", "· NestJS", "· MySQL", "· Kafka", "· Redis", "· Elasticsearch"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51881	backend	t
2780	모바일파트- Android Native 개발	비바이노베이션	서울 강남구	경력 5~15년	["Kotlin", "· Jetpack", "· XML", "· Coroutine", "· Flow", "· MVVM"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51999	mobile	t
2781	인공지능 AI 개발자(4~6년)	피피에스	서울 광진구	경력 4~6년	["REST API", "· API Tracker", "· Unity"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51896	data	t
2782	[제어기개발팀] 임베디드 SW 개발	슈어소프트테크	경기 성남시	경력 5~10년	["C", "· MCU", "· SW", "· Embedded"]	D-25	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53002	other	t
2783	R&D 펌웨어 경력자 채용(서초)	채비	서울 서초구	경력 5~15년	["FW"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51764	other	t
2784	UI테스팅 자동화 솔루션 개발	슈어소프트테크	경기 성남시	경력 2~7년	["Java", "· Python", "· SW", "· Eclipse"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52483	backend	t
2785	Application SW Engineer 경력 채용	디오에프	서울 성동구	경력 3~15년	["SW", "· C++", "· Qt", "· Mfc", "· OpenGL"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53042	other	t
2786	기술연구소 S/W 개발자 팀장 (C언어)	엔클로니	서울 구로구	경력 10~20년	["C++", "· C", "· Embedded Linux", "· C#", "· SW"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52243	other	t
2787	R&D부문 하드웨어 담당자(과장~차장급)	채비	서울 서초구	경력 5~10년	["Analog", "· PCB", "· SMPS", "· Embedded", "· HW"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53156	other	t
2788	제어로직개발팀	슈어소프트테크	경기 성남시	경력 2~8년	["C", "· SW", "· MATLAB", "· C++"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52023	other	t
2789	R&D 인증 경력자 채용	채비	서울 서초구	경력 3~15년	["SW"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51761	other	t
2790	반도체 회로 설계 개발자 (경력)	블루닷	서울 강남구	경력 3~12년	["Git", "· GitHub", "· iOS", "· Python", "· AWS", "· Spring Framework"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52715	backend	t
2791	3차원 머신비전 알고리즘 개발자(5~7)	클레	서울 성동구	경력 5~7년	["Python", "· C", "· C++", "· PyTorch", "· CUDA", "· OpenCV", "· OpenGL", "· TensorFlow"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52865	backend	t
2792	3차원 머신비전 알고리즘 개발자8~10	클레	서울 성동구	경력 8~10년	["Python", "· C", "· C++", "· PyTorch", "· CUDA", "· OpenCV", "· OpenGL", "· TensorFlow"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52866	backend	t
2793	차량 데이터 검증 솔루션 개발	슈어소프트테크	경기 성남시	경력 2~7년	["Java", "· Python", "· SW"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52482	backend	t
2794	RF HW	엠씨넥스	인천 연수구	경력 5~12년	["HW", "· PCB", "· Verilog", "· C", "· C++", "· FPGA", "· MATLAB", "· RF"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52577	other	t
2795	머신비전 임베디드 개발(펌웨어, FPGA)	아이코어	경기 안양시	경력 5~10년	["FPGA", "· VHDL", "· Verilog", "· FW", "· Embedded"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51704	data	t
2796	인공지능 AI 개발자(7년 이상)	피피에스	서울 광진구	경력 7~20년	["REST API", "· API Tracker", "· Unity"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51897	data	t
2797	C#개발자(네트워크 기술팀)	슈어소프트테크	경기 성남시	경력 3~7년	["C", "· C++", "· Visual Studio", "· Embedded", "· SW", "· C#"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52481	other	t
2798	R&D부문 하드웨어 담당자	채비	서울 서초구	신입~3년	["Analog", "· PCB", "· SMPS", "· Embedded", "· HW", "· Orcad", "· Autocad", "· Pads"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53150	other	t
2799	영상 처리 연구/개발(전문연구요원가능)	베스텔라랩	대구 동구, 경기 안양시	경력 2~10년	["Python", "· OpenCV", "· Java", "· Spring Boot", "· C", "· C++", "· C#", "· Linux", "· AWS"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53210	backend	t
3171	인프라 TA 경력직 모집	웅진	서울 중구	경력 5~20년	["Windows", "· Linux"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52428	other	t
2800	S/W 개발(6~10년)	블루텍	대전 유성구	경력 6~10년	["SW", "· C", "· C++", "· C#", "· Linux", "· Embedded Linux", "· FW"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52031	other	t
2801	서비스기획자(3년이상)	온누리스토어	서울 양천구	경력 3~5년	["AI/인공지능", "· Chatkit", "· SW"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52462	data	t
2802	3차원 카메라 하드웨어 개발자(8~10)	클레	서울 성동구	경력 8~10년	["PCB", "· Orcad"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52871	other	t
2803	[그루비 SaaS 솔루션] Swift(iOS) 개발 가능 백엔드 개발자 (5년 미만)	플래티어	서울 송파구	경력 2~5년	["Swift", "· Java", "· Kotlin", "· GitHub", "· Firebase", "· MongoDB", "· Jira", "· Spring"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53099	backend	t
2804	[그루비 SaaS 솔루션] 프런트 개발이 가능한 퍼블리셔 (5년 이상)	플래티어	서울 송파구	경력 5~8년	["JavaScript", "· React", "· Next.js", "· HTML5", "· CSS 3"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53100	backend	t
2805	자율주행 연구원(전문연구요원가능)	베스텔라랩	대구 동구, 경기 안양시	경력 2~15년	["Python", "· Spring Framework", "· AWS", "· Git", "· iOS", "· ROS", "· R", "· SQL", "· C++"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53211	backend	t
2806	SDV 솔루션 2,3팀	슈어소프트테크	경기 성남시	신입~5년	["C", "· SW", "· MATLAB"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52020	other	t
2807	3차원 머신비전 알고리즘 개발자(2~4)	클레	서울 성동구	경력 2~4년	["Python", "· C", "· C++", "· PyTorch", "· CUDA", "· OpenCV", "· OpenGL", "· TensorFlow"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52864	backend	t
2808	빅데이터 개발자(전문연구요원가능)	베스텔라랩	대구 동구, 경기 안양시	신입~8년	["Python", "· Spring Framework", "· AWS", "· React", "· Git", "· GitHub", "· Linux", "· PHP"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53218	backend	t
2809	하드웨어 개발자(신입)	캐스트프로	경기 성남시	신입	["HW"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52063	other	t
2810	풀스택 앱 개발 (경력 13~15년)	에이치비엠피	서울 구로구	경력 13~15년	["Angular 2", "· Node.js", "· React", "· MySQL", "· Linux", "· AWS", "· Git", "· REST API"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52215	backend	t
2811	RADAR 신호처리 SW	엠씨넥스	인천 연수구	경력 5~20년	["SW", "· C++", "· C", "· Embedded", "· Linux", "· MCU", "· RTOS", "· Verilog"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52581	other	t
2812	반도체 회로 설계 개발자 (신입)	블루닷	서울 강남구	신입~2년	["Git", "· GitHub", "· iOS", "· Python", "· AWS", "· Spring Framework"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52714	backend	t
2813	데이터 사이언티스트(3년이상)	알라딘커뮤니케이션	서울 중구	경력 3~15년	["Dw", "· Etl", "· OLAP", "· Hadoop", "· Tableau", "· Metabase", "· Spark", "· Hive", "· Python"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52546	backend	t
2814	풀스택(Java) 개발자(전문연구요원가능)	베스텔라랩	대구 동구, 경기 안양시	경력 2~10년	["Spring Framework", "· Spring Boot", "· JavaScript", "· MySQL", "· NoSql"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53214	backend	t
2815	인공지능 AI 개발자(1~3년)	피피에스	서울 광진구	경력 1~3년	["REST API", "· API Tracker", "· Unity"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52910	data	t
2816	실내 내비게이션 연구/개발(전문연구요원가능)	베스텔라랩	대구 동구, 경기 안양시	신입~10년	["Python", "· Spring Framework", "· AWS", "· React", "· Git", "· GitHub", "· Linux", "· PHP"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53216	backend	t
2817	이리온 비전 기반 인지 모델 개발자	폴라리스쓰리디	경북 포항시	경력 2~3년	["DeepLearning", "· PyTorch", "· TensorFlow"]	D-12	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52272	mobile	t
2818	MCU 응용개발 및 FAE	어보브반도체	서울 강남구	경력 3~6년	["C", "· C++", "· R", "· Android OS", "· MCU"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53004	mobile	t
2819	임베디드 소프트웨어 개발자(11년↑)	엔엑스	서울 서초구	경력 11~15년	["C", "· C#", "· Embedded", "· Linux", "· FW", "· C++", "· MCU", "· SW", "· Network"]	D-day	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51617	other	t
2820	프론트 개발자	낭만상회	서울 강남구	경력 3~5년	["React", "· React Native", "· TypeScript", "· Git", "· Node.js", "· Infra"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51894	backend	t
2821	웹 프로그래머/경력직/JAVA JSP	비욘드테크	서울 금천구	경력 3~7년	["JSP", "· Java", "· SW", "· JavaScript", "· Spring Boot", "· Spring Framework"]	D-7	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51878	backend	t
2822	개발자	베스텔라랩	경기 안양시	경력 5~14년	["Python", "· Spring Boot", "· AWS", "· Git", "· ROS", "· SQL", "· C", "· C++", "· Linux", "· SW"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53212	backend	t
2823	[경력] 백엔드 개발자 (울산, 7년↑)	엔엑스	울산 울주군	경력 7~10년	["Node.js", "· MongoDB", "· AWS", "· Docker", "· REST API", "· Java", "· NoSql", "· Linux"]	D-day	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51620	backend	t
2824	서버개발자 채용	로지소프트	서울 강남구	경력 7~15년	["AZURE", "· C#", "· C++", "· NoSql", "· Node.js", "· Linux", "· SQL", "· MSSQL"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51758	backend	t
2825	Deep Learning Research Scientist(전문연 가능)	아이브	서울 서초구	경력 2~10년	["Python", "· PyTorch", "· TensorFlow", "· OpenCV", "· CUDA", "· Git", "· Notion", "· Jira"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52959	backend	t
2826	시스템 운용/유지보수	베스텔라랩	경기 안양시	신입~8년	["Ccna", "· Ccnp", "· VPN", "· Router", "· Linux"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53217	other	t
2827	S/W 개발(1~5년)	블루텍	대전 유성구	경력 1~5년	["SW", "· C", "· C++", "· C#", "· Linux", "· Embedded Linux", "· FW"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52032	other	t
2828	R&D UI 경력자 채용	채비	경북 구미시	경력 5~15년	["Java", "· Linux", "· Windows", "· WPF", "· C#"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51760	backend	t
2829	하드웨어(H/W)개발자 채용(신입)	블루텍	대전 유성구	신입	["SW", "· HW", "· C", "· Embedded Linux", "· Linux", "· Embedded", "· MCU", "· ARM"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52029	other	t
2830	풀스택 앱 개발 (경력 5~8년)	에이치비엠피	서울 구로구	경력 5~8년	["Angular 2", "· Node.js", "· React", "· MySQL", "· Linux", "· AWS", "· Git", "· REST API"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52213	backend	t
2831	풀스택 개발자 채용	부동산플래닛	서울 강남구	경력 7~9년	["Java", "· Spring Boot", "· PostgreSQL", "· Redis", "· Elasticsearch", "· Mybatis"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51551	backend	t
2832	안드로이드 개발자(경력 7~10년)	그로비교육	서울 동작구	경력 7~10년	["Android OS", "· Android SDK", "· iOS", "· React Native", "· Flutter", "· Objective-C"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52062	frontend	t
2833	안드로이드 개발자(경력 11~14년)	그로비교육	서울 동작구	경력 11~14년	["Android OS", "· Android SDK", "· iOS", "· React Native", "· Flutter", "· Objective-C"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52068	frontend	t
2834	H/W 개발(경력 4~8년, TV용 SMPS)	한솔테크닉스	경기 수원시	경력 4~8년	["PCB", "· HW"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51905	other	t
2835	백엔드 개발자 모집 (Node.js/Nest.js)	뽀득	서울 강남구	경력 2~5년	["AWS", "· Docker", "· Git", "· Node.js", "· SQL", "· NestJS", "· Redis", "· TypeScript"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53106	backend	t
2836	IOS 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["iOS", "· Swift", "· Objective-C"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51539	mobile	t
2837	앱개발 프로그래머 신입 채용	파이	경기 수원시	신입	["OpenCV", "· Flutter", "· React", "· Swift", "· Android Studio", "· Xcode", "· Objective-C"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52122	frontend	t
2838	웹퍼블리셔 신입 채용	에프엘이에스	서울 강서구	신입	["Zeplin", "· Vue.js", "· JavaScript", "· jQuery", "· CSS 3", "· HTML5"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51542	backend	t
2839	기술연구소 연구개발직 채용	금영제너럴	서울 광진구	신입~10년	["HW", "· SW", "· C"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52265	other	t
2840	웨어러블 로봇 앱 개발자	위로보틱스	경기 용인시	경력 2~8년	["Dart", "· Flutter", "· Java", "· Android Studio", "· iOS", "· Firebase", "· AWS", "· Git", "· Figma"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52802	backend	t
2841	flutter 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["Flutter", "· Linux", "· Git", "· Node.js", "· Firebase Hosting", "· iOS", "· Auth0", "· Firebase"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51544	backend	t
2842	프론트엔드 개발자 중급 0명 채용	퓨처플랫폼	서울 강서구	경력 5~7년	["JavaScript", "· TypeScript", "· React", "· Next.js", "· HTML5", "· CSS 3", "· SCSS"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52022	backend	t
2843	IT Admin 및 보안관제 (서울본사)	에스엔에프코리아	서울 중구	경력 2~12년	["Firewall", "· Vision Helpdesk", "· Windows", "· Linux", "· Network", "· VPN", "· vmware"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52674	other	t
2844	풀스택 개발자 중급 0명 채용	퓨처플랫폼	서울 강서구	경력 5~7년	["Java", "· JSP", "· REST API", "· Apache Tomcat", "· Oracle Weblogic Server", "· Git"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52021	backend	t
2845	안드로이드 앱개발 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["Android OS", "· Java", "· Kotlin"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51522	backend	t
2846	[펀픽] 플러터(Flutter) 개발자 채용	아이디자인랩	서울 마포구	경력 3~10년	["Flutter", "· MariaDB", "· MySQL", "· Python", "· Android OS", "· Swift", "· Kotlin"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51802	backend	t
2847	리엑트네이티브 채용	미스고	서울 강남구	신입~10년	["Java", "· React Native", "· React D3 Library", "· TypeScript"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52245	backend	t
2848	Java Back-end 개발자 (경력 3년이상)	셀리즈	서울 마포구	경력 3~10년	["AWS", "· Java", "· Spring", "· SQL", "· REST API", "· Kubernetes", "· Oracle"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52055	backend	t
2850	[미스고부동산] AOS 개발자 채용	미스고	서울 강남구	경력 2~10년	["Kotlin", "· RxJava", "· REST API", "· android os"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53091	backend	t
2851	flutter 개발자 신입 채용	에프엘이에스	서울 강서구	신입	["Flutter", "· Linux", "· Git", "· Node.js", "· Firebase Hosting", "· iOS", "· Auth0", "· Firebase"]	D-19	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52636	backend	t
2852	JAVA 풀스택 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["Java", "· JavaScript", "· Spring", "· Mybatis", "· DB", "· JSP"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51521	backend	t
2853	[펀픽] AI 기반 백엔드 개발자 채용	아이디자인랩	서울 마포구	경력 3~10년	["Python", "· MySQL", "· Microsoft Cognitive Services", "· AI/인공지능", "· Docker"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51801	backend	t
2854	프론트 개발자 시니어	낭만상회	서울 강남구	경력 5~7년	["React", "· React Native", "· TypeScript", "· Git", "· Node.js", "· Infra"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51895	backend	t
2855	웹 개발자 신입 채용	에프엘이에스	서울 강서구	신입	["MySQL", "· PHP", "· React", "· Node.js", "· Laravel", "· JavaScript"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51541	backend	t
2856	백엔드 개발자 신입 채용	에프엘이에스	서울 강서구	신입	["PostgreSQL", "· Kafka", "· Spring Boot", "· Git", "· GitHub", "· Docker"]	D-7	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51689	backend	t
2857	IT 서비스 운영 및 외주관리 PM	더블유쇼핑	서울 서초구	경력 8~12년	["Spring", "· Thymeleaf", "· Oracle", "· Java", "· SQL"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53097	backend	t
2858	Deep Learning Platform Engineer	아이브	서울 서초구	경력 2~7년	["Python", "· PyTorch", "· TensorFlow", "· FastAPI", "· gRPC", "· Docker", "· PostgreSQL"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51918	backend	t
2859	FE 엔지니어 (디지털 헬스케어 사업) 경력직 채용	아이디에스앤트러스트	서울 강남구	경력 3~10년	["CSS 3", "· HTML5", "· JavaScript", "· React", "· Next.js", "· TypeScript"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51755	backend	t
2860	QA/QC manager	아이브	서울 서초구	경력 10~15년	["QA", "· HW", "· SW"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52230	other	t
2861	Vision System SW Junior 개발자	아이브	서울 서초구	경력 1~5년	["SW", "· C++", "· C", "· JavaScript", "· Python"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52227	backend	t
2862	장비 제어 소프트웨어 엔지니어	액스비스	대전 유성구	경력 2~15년	["C#", "· C", "· C++", "· GUI", "· SW", "· Mfc", "· Java", "· Python", "· .NET", "· Git"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52443	backend	t
2863	FPGA개발 신입 채용	에프엘이에스	서울 강서구	신입	["FPGA", "· C", "· C++", "· Cisco ISE", "· Embedded Linux", "· HW", "· Verilog", "· VHDL"]	D-19	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52637	data	t
2864	레이저 공정 제어 소프트웨어 개발자	액스비스	대전 유성구	경력 3~15년	["C", "· C++", "· SW", "· InSpec", "· .NET", "· C#", "· Visual Studio", "· PLC", "· WPF"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52445	other	t
2865	SW 기반 머신 비전 개발자 채용	액스비스	대전 유성구	경력 3~15년	["C", "· C++", "· SW", "· Mfc", "· OpenCV", "· HALCON", "· Python", "· MachineLearning"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52446	backend	t
2866	DBA(오라클) 및 IT Infra 담당자	한국디지털거래소	서울 강남구	경력 4~10년	["AWS", "· Oracle", "· Infra"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52951	other	t
2867	H/W 개발 경력직원 채용	인텍에프에이	경기 용인시	경력 1~10년	["Orcad", "· HW", "· Pads"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53079	other	t
2868	소프트웨어 유지관리(11~15년)	젠큐릭스	서울 구로구	경력 11~15년	["JavaScript", "· HTML5", "· Python"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52564	backend	t
2869	회로설계 경력 엔지니어[경력 2~5년]	유버	경기 안산시	경력 2~5년	["Orcad", "· Pads", "· PCB"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52177	other	t
2870	PHP 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~6년	["PHP", "· JavaScript", "· Node.js"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52310	backend	t
2871	의료영상 3차원 개발자 채용(7~9)	제이피아이헬스케어	서울 구로구	경력 7~9년	["C", "· C#", "· C++", "· DeepLearning"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52839	mobile	t
2872	임베디드소프트웨어 개발(경력3~5)	아이도트	서울 송파구	경력 3~5년	["Embedded Linux", "· C", "· C++"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53141	other	t
2873	웨어러블 로봇 알고리즘 개발자	위로보틱스	경기 용인시	경력 2~8년	["C", "· C++", "· MATLAB", "· Python", "· TensorFlow", "· PyTorch", "· MachineLearning"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52803	backend	t
2874	시니어 백엔드 경력직 (6년 이상)	이노소니언	서울 서초구	경력 6~20년	["Python", "· Django", "· MySQL", "· PostgreSQL", "· AWS"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53052	backend	t
2875	AI 컴패니언 기획자 채용	고스트스튜디오	서울 강남구	경력 3~10년	["AI/인공지능", "· MachineLearning", "· DB"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52882	mobile	t
2876	회로설계 경력 엔지니어[경력 11~20년]	유버	경기 안산시	경력 11~20년	["Orcad", "· Pads", "· PCB"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52180	other	t
2877	Kt cloud zabbix 운영자	렉스시스템	서울 서초구	경력 1~3년	["Zabbix"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52980	other	t
2878	소프트웨어 유지관리(5~10년)	젠큐릭스	서울 구로구	경력 5~10년	["JavaScript", "· HTML5", "· Python"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52563	backend	t
2879	AI채용솔루션 프론트엔드 개발자	인딥에이아이	서울 강남구	경력 3~5년	["GitHub", "· React Hook Form", "· Datadog"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52092	frontend	t
2880	웹 풀스택 개발자 경력직 채용	세무법인프라이어	서울 강남구	경력 5~10년	["MySQL", "· PostgreSQL", "· Python", "· TypeScript", "· AWS", "· Docker", "· Next.js"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51825	backend	t
2881	임베디드 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["RTOS", "· Python", "· C++", "· C", "· HW", "· FW"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51929	backend	t
2882	AI/ML 엔지니어 경력 채용	액스비스	대전 유성구	경력 3~15년	["Python", "· JavaScript", "· Django", "· AI/인공지능", "· MachineLearning", "· REST API"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52447	backend	t
2883	ktds 고도화/운영 개발자	렉스시스템	경기 성남시	경력 6~15년	["Python", "· Vue.js", "· MongoDB", "· AWS", "· AZURE", "· K8S", "· MSA"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52696	backend	t
2884	FPGA & DSP 펌웨어 개발 엔지니어	액스비스	대전 유성구	경력 2~15년	["VHDL", "· FPGA", "· Verilog", "· Embedded Linux", "· C", "· C++", "· Cisco ISE", "· ARM"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52444	data	t
2885	컴퓨터 비전 딥러닝/머신러닝(5년이상)	에프에스솔루션	경기 성남시	경력 5~15년	["OpenCV", "· C++", "· MachineLearning", "· DeepLearning", "· TensorFlow"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52551	mobile	t
2886	node.js 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~6년	["Node.js", "· AWS", "· REST API"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52311	backend	t
2887	클라우드 엔지니어 신입 채용	에프엘이에스	서울 강서구	신입	["AZURE", "· GCP", "· AWS", "· DB", "· BigData", "· MachineLearning", "· MySQL", "· Redis"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52534	mobile	t
2888	웹서버 개발자 경력 채용	에프엘이에스	서울 강서구	경력 2~5년	["C++", "· Java", "· React", "· Spring"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52643	backend	t
2889	인프라 엔지니어 신입 채용	에프엘이에스	서울 강서구	신입	["Docker", "· TypeScript", "· AWS", "· AZURE", "· GCP", "· Solidity", "· Hyperledger Indy"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52705	frontend	t
2890	택스아이 개발팀리더	뉴아이	서울 서초구	경력 4~15년	["HTML5", "· CSS 3", "· Java", "· JavaScript", "· TypeScript", "· Next.js", "· Redux"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53122	backend	t
2891	컴퓨터 비전 딥러닝/머신러닝(팀장급)	에프에스솔루션	경기 성남시	경력 10~15년	["OpenCV", "· C++", "· MachineLearning", "· DeepLearning", "· TensorFlow"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52552	mobile	t
2892	Django Back-end 개발자 [CTO]	제일씨앤씨	부산 북구	경력 8~20년	["Django", "· Django REST framework", "· AWS", "· Docker", "· Redis", "· WebSocket"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52764	backend	t
2893	체외진단 의료기기 IT유지보수	시스멕스코리아	서울 강남구	경력 4~6년	["C#", "· Vb.net", "· Java", "· SQL", "· REST API"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53222	backend	t
2894	농진청 데이터 분석가 (AI)	렉스시스템	전북 전주시	경력 3~10년	["AI/인공지능", "· Python", "· SQL"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53163	backend	t
2895	프론트엔드 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["Node.js", "· Java", "· AWS", "· React.js Boilerplate"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52313	backend	t
2896	정보보안 담당자 신입 채용	에프엘이에스	서울 강서구	신입	["SecureCRT"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52640	other	t
2897	프론트엔드 개발자 (Next JS)_부산	뉴아이	부산 남구	경력 3~15년	["HTML5", "· CSS 3", "· Java", "· JavaScript", "· TypeScript", "· Next.js"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53124	backend	t
2898	서버 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["GitHub", "· GraphQL", "· Docker", "· AZURE", "· Golang", "· Kubernetes", "· AWS"]	D-day	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51353	backend	t
2899	SW개발/개발관리 7년 이상(과장급)채용	송암시스콤	전남 나주시	경력 7~15년	["Java", "· JSP", "· jQuery", "· Spring Boot"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52079	backend	t
2900	주니어 백엔드(Back-end) 엔지니어	바인드	서울 마포구	경력 2~8년	["Python", "· Django"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53247	backend	t
2901	웹퍼블리셔 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["Zeplin", "· Vue.js", "· JavaScript", "· jQuery", "· CSS 3", "· HTML5"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51543	backend	t
2902	앱개발 프로그래머 경력 (2~4년)채용	파이	경기 수원시	경력 2~4년	["OpenCV", "· Flutter", "· React", "· Swift", "· Android Studio", "· Xcode", "· Objective-C"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52125	frontend	t
2903	자동화 소프트웨어 엔지니어 채용	액스비스	대전 유성구	경력 4~15년	["Qt", "· C#", "· C", "· C++", "· Mfc", "· Git", "· .NET", "· OpenCV", "· Visual Studio", "· PLC"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52442	other	t
2904	자동화 장비제어 Software 개발 경력직 채용	나노젯코리아	경기 화성시	경력 3~15년	["SW", "· GUI"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52541	other	t
2905	백엔드 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~6년	["PostgreSQL", "· Kafka", "· Spring Boot", "· Git", "· GitHub", "· Docker"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52312	backend	t
2906	ktds(클라우드 위즈) 풀스택 개발자	렉스시스템	경기 성남시	경력 6~15년	["Python", "· Vue.js", "· MongoDB", "· AWS", "· AZURE", "· K8S", "· MSA"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52697	backend	t
2907	웹 풀스택 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~6년	["Java", "· JavaScript", "· Python", "· HTML5", "· CSS 3", "· Docker", "· Kubernetes"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52530	backend	t
2908	웹(Back-End) 개발자 채용 (근무지/전주)	아이엠아이	전북 전주시	경력 2~5년	["PHP", "· MySQL", "· REST API", "· Git", "· Jira", "· Laravel", "· Node.js", "· Redis"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51868	backend	t
2909	ktds 고객지원 포탈 고도화 개발자	렉스시스템	경기 성남시	경력 6~15년	["Python", "· Java", "· AZURE", "· REST API"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52698	backend	t
2910	임베디드소프트웨어 개발(경력6~8)	아이도트	서울 송파구	경력 6~8년	["Embedded Linux", "· C", "· C++"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53142	other	t
2911	하드웨어 개발자 경력 채용	에프엘이에스	서울 강서구	경력 2~5년	["HW", "· Embedded", "· PCB", "· ARM", "· Embedded Linux", "· Android OS"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51688	mobile	t
2912	웹 개발자	에프엘이에스	서울 강서구	경력 2~6년	["MySQL", "· PHP", "· React", "· Node.js", "· Laravel", "· JavaScript"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51824	backend	t
2913	임베디드 개발자 신입 채용	에프엘이에스	서울 강서구	신입	["RTOS", "· Python", "· C++", "· C", "· HW", "· FW"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51928	backend	t
2914	[인천] 백엔드 개발자 모집	에이치케이로지스틱스	인천 서구	경력 1~10년	["TypeScript", "· Java", "· Node.js", "· NestJS", "· Prisma", "· GitHub", "· PostgreSQL"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53233	backend	t
2915	CRM·이커머스 백엔드 개발자 (경력)	서플러스글로벌	경기 용인시	경력 5~20년	["Java", "· Spring Boot", "· Etl", "· Elasticsearch", "· MySQL", "· MariaDB", "· REST API"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52081	backend	t
2916	AIDOT 의료인공지능기반 연구개발	아이도트	서울 송파구	경력 1~3년	["AI/인공지능"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52598	data	t
2917	하드웨어 개발자 신입 채용	에프엘이에스	서울 강서구	신입	["HW", "· Embedded", "· PCB", "· ARM", "· Embedded Linux", "· Android OS"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51687	mobile	t
2918	앱개발 프로그래머 경력 (5~7년)채용	파이	경기 수원시	경력 5~7년	["OpenCV", "· Flutter", "· React", "· Swift", "· Android Studio", "· Xcode", "· Objective-C"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52126	frontend	t
2919	계측장비용 C/C++ S/W 개발 팀장	멀티스케일인스트루먼트	서울 관악구	경력 5~12년	["C++", "· C", "· Instrumental", "· Embedded"]	D-12	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52140	other	t
2920	데이터 엔지니어 경력직 채용	에프엘이에스	서울 강서구	경력 2~6년	["MSSQL", "· DB", "· AWS", "· PHP", "· MySQL", "· JavaScript", "· Node.js"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52531	backend	t
2921	보안 솔루션 엔지니어 신입 채용	에프엘이에스	서울 강서구	신입	["Java", "· Oracle", "· SQL", "· MariaDB", "· C++", "· Linux", "· Windows"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52532	backend	t
2922	택스아이 개발팀리더 (부산)	뉴아이	부산 남구	경력 4~15년	["HTML5", "· CSS 3", "· Java", "· JavaScript", "· TypeScript", "· Next.js", "· Redux"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53121	backend	t
2923	[EvryAI] 백엔드 개발자	에브리에이아이코리아	경기 성남시	경력 3~10년	["AI/인공지능", "· Node.js", "· Python", "· REST API", "· AWS", "· Git", "· Docker"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52989	backend	t
2924	R&D 펌웨어 경력자 채용(구미)	채비	경북 구미시	경력 5~15년	["FW"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51763	other	t
2925	3D Vision Algorithm Engineer	아이브	서울 서초구	경력 2~7년	["Milanote", "· OpenCV", "· C++", "· Git"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51749	backend	t
2926	[SCK 및 관계사] Microsoft 프로젝트 및 기술지원	에쓰씨케이	서울 강남구	경력 5~15년	["Microsoft Teams", "· Microsoft Office 365", "· Microsoft SharePoint"]	D-12	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51899	other	t
2927	펌웨어 개발자(10년~)	캐스트프로	경기 성남시	경력 10~20년	["MCU", "· C", "· FW"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52067	other	t
2928	PCB개발 경력 채용	트리즈	경기 화성시	경력 5~10년	["PCB", "· Orcad", "· HW"]	D-day	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51630	other	t
2929	제어SW 엔지니어	아이브	서울 서초구	경력 1~5년	["Git", "· C++", "· C", "· PLC", "· MES", "· TCP/IP", "· ethernet"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52228	mobile	t
2930	[경력] 백엔드 개발자 (울산, 11년↑)	엔엑스	울산 울주군	경력 11~15년	["Node.js", "· MongoDB", "· AWS", "· Docker", "· REST API", "· Java", "· NoSql", "· Linux"]	D-day	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51619	backend	t
2931	하드웨어 개발자(10년~)	캐스트프로	경기 성남시	경력 10~20년	["HW"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52064	other	t
2932	차량용 RADAR HW	엠씨넥스	인천 연수구	경력 3~12년	["HW", "· PCB", "· Verilog", "· C", "· C++", "· FPGA", "· MATLAB"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52575	other	t
2933	에뮬레이터/Application개발 채용	세미티에스	경기 용인시	경력 3~10년	["HW", "· C++", "· Docker", "· JavaScript", "· Java", "· ethernet", "· Kubernetes", "· React"]	D-4	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51751	backend	t
2934	펌웨어 개발자(1~10년)	캐스트프로	경기 성남시	경력 1~10년	["MCU", "· C", "· FW"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52066	other	t
2935	Windows개발자 (경력 11년↑)	페이타랩	서울 강남구	경력 11~20년	["WPF", "· C#", "· Visual Studio", "· C++", "· .NET", "· Git", "· Slack", "· Windows"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52238	other	t
2936	Backend Engineer (경력 8~12년)	위펀	서울 강남구	경력 8~12년	["MySQL", "· Spring Boot", "· Java", "· QueryDSL", "· MariaDB"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52166	backend	t
2938	향수 커머스 웹개발자(미들급) 채용	퍼퓸그라피	서울 종로구	경력 4~6년	["React", "· Node.js", "· HTML5", "· CSS 3", "· JavaScript", "· jQuery", "· TypeScript"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51887	backend	t
2939	의류제조시스템 AI 모델 적용 개발자 경력	호전실업	서울 마포구	경력 3~10년	["TensorFlow", "· PyTorch"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52160	data	t
2940	Zadara 솔루션 아키텍트	이비즈테크	서울 마포구	경력 5~10년	["vmware", "· Linux", "· AWS", "· Amazon MQ", "· WebGL", "· Backpack", "· Objective-C"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52226	mobile	t
3402	고급 백엔드 설계 개발자(10~12년)	티투엘	경기 고양시	경력 10~12년	["Java"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52038	backend	t
2941	프론트엔드 개발자 (경력 6년~9년)	퍼퓸그라피	서울 종로구	경력 6~9년	["React", "· Node.js", "· HTML5", "· CSS 3", "· JavaScript", "· jQuery", "· TypeScript"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51886	backend	t
2942	Backend Engineer (경력 5~7년)	위펀	서울 강남구	경력 5~7년	["MySQL", "· Spring Boot", "· Java", "· QueryDSL", "· MariaDB"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52165	backend	t
2943	AI 연구원 (3~9년)	한화비전	경기 성남시	경력 3~9년	["Git", "· BigData", "· C++", "· MachineLearning", "· DeepLearning", "· TensorFlow"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52058	mobile	t
2944	Software Engineer (Back-End)	부스터스	서울 강남구	경력 2~5년	["SW", "· ScrapingBot", "· Linux", "· MySQL", "· Python", "· PHP"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52874	backend	t
2937	Sowtware PM	메디트	서울 영등포구	경력 5년	["SW"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51670	other	t
2945	솔루션 백엔드(Backend) 개발자	노아시스템즈	서울 성동구	경력 3~7년	["Java", "· Shell", "· Spring", "· Spring Boot", "· Spring Security", "· Linux", "· Swagger UI"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52439	backend	t
2946	프론트엔드/풀스택 개발자 모집	엠엑스엔커머스코리아	서울 성동구	경력 2~4년	["React", "· JavaScript", "· Node.js", "· TypeScript"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52649	backend	t
2947	Jr.React Front-end Engineer	올거나이즈코리아	서울 강남구	경력 2~6년	["React", "· GraphQL", "· JavaScript", "· HTML5", "· CSS 3"]	D-25	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53152	backend	t
2948	iOS Engineer (Intermediate) 채용	이지식스(엠블)	서울 강남구	경력 3~7년	["Rxswift", "· Swift", "· iOS", "· MVVM"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52137	mobile	t
2949	프론트엔드/풀스택 시니어 개발자 모집	엠엑스엔커머스코리아	서울 성동구	경력 5~7년	["React", "· JavaScript", "· Node.js", "· TypeScript"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52648	backend	t
2950	솔루션 프론트엔드(Frontend) 개발자	노아시스템즈	서울 성동구	경력 3~7년	["GUI", "· REST API", "· JavaScript", "· React", "· TypeScript", "· IntelliJ IDEA"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52440	backend	t
2951	백엔드 개발자	아이트럭	서울 서초구	경력 3~10년	["Node.js", "· TypeScript", "· MySQL", "· Ubuntu", "· GitHub", "· AWS", "· JavaScript"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52733	backend	t
2952	백엔드 개발자 총괄 채용	아이스크림아트	서울 강남구	경력 10~15년	["Node.js", "· React", "· TypeScript", "· NestJS", "· ExpressJS", "· React Native"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52925	backend	t
2953	Python Back-end Enginner	올거나이즈코리아	서울 강남구	경력 2~5년	["Python", "· Backendless"]	D-25	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53154	backend	t
2954	Windows개발자 (신입~5년↓)	페이타랩	서울 강남구	신입~5년	["WPF", "· C#", "· Visual Studio", "· C++", "· .NET", "· Git", "· Slack", "· Windows"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52236	other	t
2955	Frontend Engineer(React)(경력 8~12년)	위펀	서울 강남구	경력 8~12년	["JavaScript", "· Git", "· TypeScript", "· React", "· Semantic UI", "· Semantic UI React"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52164	backend	t
2956	Java Backend 서비스 개발자 모집	트럼피아	서울 강남구	경력 7~15년	["Elasticsearch", "· MariaDB", "· Docker", "· REST API", "· Backendless", "· Java"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52441	backend	t
2957	(키퍼)Back End Engineer(5~9년)	한화비전	경기 성남시	경력 5~9년	["Node.js", "· REST API", "· PostgreSQL", "· MongoDB", "· NoSql", "· NestJS"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52060	backend	t
2958	Python 백엔드 개발자	펫박스	서울 마포구	경력 3~5년	["MySQL", "· PHP", "· Python", "· Selenium", "· CodeIgniter", "· AWS"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52433	backend	t
2959	프론트엔드 개발자_5년 이상	펫박스	서울 마포구	경력 5~7년	["React", "· REST API", "· HTML5", "· React Native", "· Vue.js", "· axios", "· CSS 3"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52429	frontend	t
2960	백엔드 주니어 개발자(.NET Core/GCP)	엠엑스엔커머스코리아	서울 성동구	경력 1~2년	[".NET", "· GitHub", "· RDB", "· PostgreSQL", "· MySQL", "· Docker"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52647	backend	t
2961	Frontend Engineer(React)(경력 5~7년)	위펀	서울 강남구	경력 5~7년	["JavaScript", "· Git", "· TypeScript", "· React", "· Semantic UI", "· Semantic UI React"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52163	backend	t
2962	QA Engineer (경력 6~10년↓)	페이타랩	서울 강남구	경력 6~10년	["QA", "· Jenkins"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52240	other	t
2963	향수 커머스 웹개발자(시니어급) 채용	퍼퓸그라피	서울 종로구	경력 6~9년	["React", "· Node.js", "· HTML5", "· CSS 3", "· JavaScript", "· jQuery", "· TypeScript"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51888	backend	t
2964	보안/인프라/서버 담당자	아이파킹	서울 금천구	경력 4~6년	["HW", "· Linux", "· Windows", "· vmware", "· NGINX", "· Apache Tomcat"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52052	other	t
2965	웹 서비스 자바 개발자	비즈톡	서울 강남구	경력 5~10년	["REST API", "· C++", "· Linux", "· Java", "· C", "· AngularJS"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52905	backend	t
2966	MLOps 엔지니어 채용	펀진	서울 성동구	경력 3~5년	["Git", "· Jenkins", "· AI/인공지능", "· Argo", "· MachineLearning", "· Kubernetes"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51815	backend	t
2967	프론트엔드 개발자 (경력 3년~5년)	퍼퓸그라피	서울 종로구	경력 3~5년	["React", "· Node.js", "· HTML5", "· CSS 3", "· JavaScript", "· jQuery", "· TypeScript"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51885	backend	t
2968	iOS APP 개발자 채용	아이파킹	서울 금천구	경력 2~5년	["iOS", "· Swift", "· Flutter", "· Objective-C", "· Kotlin"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52054	mobile	t
2969	Back-end Engineer 경력직 채용	피에프씨테크놀로지스	서울 서초구	경력 1~5년	["Django", "· FastAPI", "· REST API", "· Python", "· Vue.js", "· Angular 2", "· React"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52080	backend	t
2970	QA Engineer (경력 1~5년↓)	페이타랩	서울 강남구	경력 1~5년	["QA", "· Jenkins"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52239	other	t
2971	웹개발자 신입채용	엘리펀트키즈에듀테인먼트	인천 계양구	신입	["JavaScript", "· Node.js", "· React", "· Vue.js", "· ASP.NET"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52971	backend	t
2972	R&D 부문 신입사원 채용	스타마타	서울 강남구	신입	["DeepLearning", "· C", "· Linux", "· Python", "· AI/인공지능", "· VR", "· AR", "· Embedded"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51734	backend	t
2973	[이즈파크] PLM 개발자	이즈파크	서울 금천구	경력 3~15년	["Java", "· JavaScript", "· JSP"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/20878	backend	t
2974	[이즈파크] PLM 프로젝트 PM	이즈파크	서울 금천구	경력 8~20년	["Java", "· MSSQL", "· Oracle"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/20547	backend	t
2975	SW개발_Platform파트 선임~책임급 채용	알피니언메디칼시스템	서울 강서구	경력 2~15년	["Visual C++", "· C", "· C++", "· WPF", "· JavaScript", "· Windows", "· C#", "· SW"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51932	backend	t
2976	웹 퍼블리셔 경력채용 (2~5년)	텐빌리언	서울 구로구	경력 2~5년	["JavaScript", "· HTML5", "· CSS 3", "· jQuery"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52111	backend	t
2977	PNS팀 윈도 개발자	지니언스	경기 안양시	경력 5~15년	["C", "· C#", "· C++", "· VPN"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52400	other	t
2978	자연어처리 엔지니어 채용	쉬모스랩	서울 강남구	경력 2~7년	["SQL", "· PostgreSQL", "· Python", "· Azure DevOps", "· Git", "· Linux", "· AI/인공지능"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52557	backend	t
2979	IVR개발자 채용	넥서스커뮤니티	서울 영등포구	경력 5~15년	["C++", "· C", "· SQL"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53220	other	t
2980	AI 연구원 (10~12년)	한화비전	경기 성남시	경력 10~12년	["Git", "· BigData", "· C++", "· MachineLearning", "· DeepLearning", "· TensorFlow"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52059	mobile	t
2981	리눅스 개발	프라이빗테크놀로지	서울 마포구	경력 3~15년	["Linux", "· C", "· C++", "· Qt", "· TCP/IP", "· Flow", "· Embedded", "· Network"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53066	other	t
2982	AI 엔지니어(이미지 생성 AI 서비스)	바이스벌사	서울 서초구	경력 3~5년	["PyTorch", "· TensorFlow", "· AWS", "· GCP", "· AI/인공지능", "· MachineLearning"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52364	mobile	t
2983	Python 백엔드 개발자_6년~8년	펫박스	서울 마포구	경력 6~8년	["MySQL", "· PHP", "· Python", "· Selenium", "· CodeIgniter", "· AWS"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52435	backend	t
2984	인터페이스 개발자 채용	넥서스커뮤니티	서울 영등포구	경력 5~15년	["Kafka", "· RabbitMQ", "· Amazon SQS", "· AWS", "· GCP", "· OAuth2", "· Docker"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53221	other	t
2985	RAG Researcher / Engineer	올거나이즈코리아	서울 강남구	경력 2~10년	["AI/인공지능", "· NLP", "· DeepLearning", "· Backendless"]	D-25	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53155	backend	t
2986	에스크로 플랫폼 프론트 개발(6년~8년)	핀즐	서울 송파구	경력 6~8년	["JavaScript", "· HTML5", "· CSS Modules"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52287	backend	t
2987	Windows개발자 (경력 6~10년↓)	페이타랩	서울 강남구	경력 6~10년	["WPF", "· C#", "· Visual Studio", "· C++", "· .NET", "· Git", "· Slack", "· Windows"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52237	other	t
2988	GSC EDR IoC 및 악성코드 분석	지니언스	경기 안양시	신입~5년	["PowerShell", "· ScriptRock"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52401	other	t
2989	보안 소프트웨어 설치 및 기술지원	프라이빗테크놀로지	서울 마포구	경력 5~10년	["SW", "· CISSP", "· CISA", "· VPN", "· Infra", "· Firewall", "· Network"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53055	other	t
2990	기술개발 총괄 및 리딩(12~15년)	WATA Inc.	경기 성남시	경력 12~15년	["RDB", "· REST API", "· C++", "· Java", "· AWS", "· React", "· SQL"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52978	backend	t
2991	에스크로 플랫폼 시니어 개발(3년~5년)	핀즐	서울 송파구	경력 3~5년	["Spring Framework", "· React D3 Library"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52289	backend	t
2992	에스크로 플랫폼 프론트 개발(9년 이상)	핀즐	서울 송파구	경력 9~20년	["JavaScript", "· HTML5", "· CSS Modules"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52288	backend	t
2993	에스크로 플랫폼 시니어 개발(9년 이상)	핀즐	서울 송파구	경력 9~20년	["Spring Framework", "· React D3 Library"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52291	backend	t
2994	SAS사업부 SW(PLC) 채용	유진로봇	인천 연수구	경력 3~18년	["PLC", "· SW"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52652	other	t
2995	영상처리,비전(Vision) S/W채용(3~5년)	포우	경기 용인시	경력 3~5년	["SW", "· OpenCV", "· C++"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52188	other	t
2996	프론트엔드 개발 경력 정규직 채용	엠투클라우드	서울 송파구	경력 6~10년	["JavaScript", "· HTML5", "· CSS 3", "· AngularJS", "· AWS", "· Git", "· TypeScript"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51976	backend	t
2998	ML Engineer (Embedded, 5~7년)	웨어러블에이아이	서울 영등포구	경력 5~7년	["CUDA", "· C", "· C++", "· Embedded Linux", "· PyTorch"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52328	data	t
2999	영상처리,비전(Vision) S/W채용(9년↑)	포우	경기 용인시	경력 9~11년	["SW", "· OpenCV", "· C++"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52191	other	t
3000	개발 계획 및 개발 진행PM(10~14)	WATA Inc.	경기 성남시	경력 10~14년	["GitHub", "· Jira", "· Java", "· AWS", "· RDB", "· AWS Cloud Development Kit"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52974	backend	t
3001	네트워크 개발	프라이빗테크놀로지	서울 마포구	경력 3~10년	["Network", "· C", "· C++", "· TCP/IP", "· Linux", "· Windows Terminal", "· VPN", "· FW", "· IPS"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53065	other	t
3002	리눅스 네트워크 프로그래머	노아시스템즈	서울 성동구	경력 5~10년	["Linux", "· Utm", "· C", "· TCP/IP", "· Git", "· C++"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51629	other	t
3003	Application SW 개발자 경력 채용	토모큐브	대전 유성구	경력 1~5년	["SW", "· Azure Application Insights", "· GUI", "· C++"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52561	other	t
3004	Citrix 가상화 엔지니어 모집	누리인포스	경기 성남시	신입	["Citrix Gateway", "· Linux", "· Windows Server"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51939	backend	t
3005	SAP 운영/개발(MM 및 SD모듈)	한국네트웍스	경기 성남시	경력 10~15년	["SAP", "· ABAP"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52476	other	t
3006	응용 SW 개발 모집	비솔	경기 광명시	경력 7~20년	["Python", "· C++", "· C#", "· SW", "· OpenCV"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52792	backend	t
3007	머신러닝 개발자	아이트럭	서울 서초구	경력 5~10년	["scikit-learn", "· BigData", "· MachineLearning", "· Python", "· Keras", "· NumPy"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52730	backend	t
3008	데이터 분석 플랫폼 개발자(경력 6~10년)	엠로	서울 영등포구	경력 6~10년	["Java", "· Spring Framework", "· JavaScript", "· Python"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52902	backend	t
3009	[IPGAME] Client Programmer	보이저	서울 구로구	신입~20년	["C++", "· Unity", "· Visual C++", "· C#", "· Git", "· Redis", "· DirectX"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52954	other	t
3010	Front-end Platform Engineer (경력)	엔닷라이트	경기 성남시	경력 5~10년	["TypeScript", "· JavaScript", "· CSS 3", "· Next.js", "· React", "· 3D Rendering"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53000	backend	t
3011	MVL [TADA] Backend Engineer 채용	이지식스(엠블)	서울 강남구	경력 3~10년	["TypeScript", "· NestJS", "· Node.js", "· SQL", "· Kotlin", "· Spring Framework", "· gRPC"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53029	backend	t
3012	Mobile App 개발자	더블티	경기 수원시	신입	["REST API", "· iOS", "· Android OS", "· CrossBrowserTesting", "· React Native"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53113	frontend	t
3013	AI 개발자 채용	넥서스커뮤니티	서울 영등포구	경력 5~15년	["Python", "· C++", "· REST API", "· MachineLearning", "· DeepLearning"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53223	backend	t
3014	인프라서비스팀_백엔드개발(과장)	리만코리아	대구 수성구	경력 10~12년	["Java", "· Spring Framework", "· Spring Boot", "· QueryDSL", "· JUnit"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53252	backend	t
3015	SRE팀 SRE엔지니어(팀장)	지니언스	경기 안양시	경력 15~20년	["Jira", "· Testrail", "· QA"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52404	data	t
3016	프론트엔드 개발자_8년 이상	펫박스	서울 마포구	경력 8~10년	["React", "· REST API", "· HTML5", "· React Native", "· Vue.js", "· axios", "· CSS 3"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52431	frontend	t
3017	Infra 엔지니어 (9~15년)	메타넷글로벌	서울 강남구	경력 9~15년	["Python", "· MSA", "· Kafka", "· MariaDB"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52901	backend	t
3018	Frontend developer	유비퍼스트대원	경기 성남시	경력 4~10년	["Java", "· Kotlin", "· Spring Boot", "· CSS 3", "· Vue.js", "· React", "· OpenAPI"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53036	backend	t
3019	[외국계 게임사] 인큐베이션 개발자(계약직)	가레나코리아	서울 강남구	경력 2~5년	["Unity", "· Unreal Engine"]	D-25	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53148	other	t
3020	AI 연구개발자 (석사)	더블티	경기 수원시	신입	["AI/인공지능", "· scikit-learn", "· PyTorch", "· TensorFlow", "· Python", "· AWS"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53114	backend	t
3021	인프라서비스팀_백엔드개발(대리)	리만코리아	대구 수성구	경력 7~9년	["Java", "· Spring Framework", "· Spring Boot", "· QueryDSL", "· JUnit"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53251	backend	t
3022	Flutter 앱개발자	테일크루	경기 성남시	경력 3~10년	["Flutter", "· CSS 3", "· JavaScript", "· TypeScript", "· React Native"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53266	backend	t
3023	인프라 및 웹보안 개발(9년 이상)	핀즐	서울 송파구	경력 9~20년	["Infra", "· GCP", "· CloudFlare"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52285	other	t
3024	Embedded Hardware Engineer (Senior)	웨어러블에이아이	서울 영등포구	경력 3~10년	["MCU", "· PCB"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52324	other	t
3025	[TADA] Technical Product Manager (TPM) 채용	이지식스(엠블)	서울 강남구	경력 3~10년	["Notion", "· Jira", "· Confluence", "· Slack"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52474	other	t
3026	[누구(nugu)] BE엔지니어(시니어)	메디쿼터스	서울 강남구	경력 10~20년	["Go", "· gRPC", "· Kafka", "· RDB", "· NoSql", "· MSA", "· EDA"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52941	backend	t
3027	(키퍼) Back End Engineer (10년~)	한화비전	경기 성남시	경력 10~12년	["Node.js", "· REST API", "· PostgreSQL", "· MongoDB", "· NoSql", "· NestJS"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52061	backend	t
3028	펌웨어 개발자 경력 정규직 채용	엠투클라우드	서울 송파구	경력 10~15년	["FW", "· MCU", "· C", "· SW"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51975	other	t
3029	Server팀 Frontend 개발 및 유지보수	지니언스	경기 안양시	경력 10~20년	["HTML5", "· CSS 3", "· JavaScript", "· React", "· Next.js", "· AngularJS"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52403	backend	t
3030	알고리즘 개발자 신입 채용	엘리펀트키즈에듀테인먼트	인천 계양구	신입	["TensorFlow", "· Keras", "· Slim"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52631	data	t
3031	Infra/시스템 아키텍처 (4~7년)	메타넷글로벌	서울 강남구	경력 4~7년	["Python", "· MSA", "· Kafka", "· MariaDB"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52896	backend	t
3032	AI 배치·배선 알고리즘 엔지니어	럭스로보	서울 서초구	경력 5~12년	["PyTorch", "· TensorFlow", "· Python", "· NumPy", "· Matplotlib", "· Git", "· Notion"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52952	backend	t
3033	카카오/네이버 연계시스템 서버 개발자	비즈톡	서울 강남구	경력 5~10년	["Git", "· Spring Boot", "· REST API", "· Linux", "· AWS"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52906	backend	t
3034	Backend developer	유비퍼스트대원	경기 성남시	경력 4~10년	["Java", "· Kotlin", "· Spring Boot", "· CSS 3", "· Kafka", "· Amazon EKS"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53035	backend	t
3035	Windows 커널 드라이버 개발	프라이빗테크놀로지	서울 마포구	경력 3~20년	["Windows", "· C", "· C++", "· Windows Terminal", "· AssemblyScript"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53070	other	t
3036	Solution Engineer	에이아이트릭스	서울 강남구	신입~7년	["Git", "· Linux", "· Python", "· Docker Compose", "· Jira"]	D-25	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53149	backend	t
3037	DBA	디어유	서울 강남구	경력 5~10년	["AWS", "· NoSql", "· MySQL"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53129	other	t
3038	SRE팀 SRE엔지니어	지니언스	경기 안양시	경력 5~15년	["QA", "· Jira", "· Testrail"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52405	data	t
3039	자율주행 H/W엔지니어[8~10년]	알지티	대전 중구	경력 8~10년	["C", "· C++", "· Python", "· Orcad", "· FW"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52452	backend	t
3040	[인공지능솔루션] Data Scientist	제논	서울 강남구	경력 3~20년	["PyTorch", "· TensorFlow", "· Python", "· Kubernetes", "· MachineLearning"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52688	backend	t
3041	웹 서비스 Back-end 개발자 (경력)	엔닷라이트	경기 성남시	경력 5~10년	["TypeScript", "· JavaScript", "· GitHub Actions", "· AWS", "· REST API", "· GraphQL"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52665	backend	t
3042	[누구(nugu)] BE엔지니어	메디쿼터스	서울 강남구	경력 3~7년	["Go", "· gRPC", "· Kafka", "· RDB", "· NoSql", "· MSA", "· EDA"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52940	backend	t
3043	인프라서비스팀_백엔드개발(주임)	리만코리아	대구 수성구	경력 3~6년	["Java", "· Spring Framework", "· Spring Boot", "· QueryDSL", "· JUnit"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53250	backend	t
3044	JavaScript 프론드엔드 개발자 채용	서울거래	서울 영등포구	경력 3~20년	["Java", "· HTML5", "· CSS 3", "· jQuery", "· Django", "· Python", "· AWS", "· REST API"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53228	backend	t
3045	Cloud Security Engineer(5년~)	한화비전	경기 성남시	경력 5~9년	["ISMS", "· AWS", "· AZURE", "· Firewall", "· IPS", "· AWS IAM", "· AWS WAF"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52057	other	t
3046	[대구] RTL 설계 엔지니어 (신입)	칩스앤미디어	대구 동구	신입	["Verilog", "· C", "· C++", "· Python", "· Linux", "· HW", "· FPGA", "· VHDL"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52843	backend	t
3047	IT/AI부문(전문연구요원 포함)경력(4↑)	연합인포맥스	서울 종로구	경력 4~5년	["AI/인공지능", "· TypeScript", "· Next.js", "· Python", "· Chart.js", "· NLP"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53185	backend	t
3048	[신입] Flutter 앱 & Node.js 개발자	인졀미	서울 서초구	신입~4년	["TypeScript", "· Node.js", "· PostgreSQL", "· REST API", "· AWS", "· Flutter", "· Dart"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53109	backend	t
3049	에스크로 플랫폼 프론트 개발(3년~5년)	핀즐	서울 송파구	경력 3~5년	["JavaScript", "· HTML5", "· CSS Modules"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52286	backend	t
3050	[PJ_Youkai] Game Server Programmer 채용	보이저	서울 구로구	신입~20년	["SQL", "· Redis", "· C++", "· NoSql", "· AZURE", "· Unity", "· AI/인공지능", "· Docker", "· Linux"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52616	backend	t
3051	QA Engineer (경력 11년↑)	페이타랩	서울 강남구	경력 11~20년	["QA", "· Jenkins"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52241	other	t
3052	IT운영	유비퍼스트대원	경기 성남시	경력 3~10년	["AWS", "· Kafka", "· Amazon EKS", "· DB", "· Oracle", "· MySQL", "· Python", "· C", "· C++"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53039	backend	t
3053	이커머스 풀스템 팀장 앱웹	펫박스	서울 마포구	경력 8~15년	["React Native", "· Next.js", "· TypeScript", "· Kotlin", "· Java", "· Amazon CloudFront"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52438	backend	t
3054	SAS사업부 글로벌프로젝트 SW(PLC)채용	유진로봇	인천 연수구	경력 3~18년	["PLC", "· SW"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52653	other	t
3055	웹개발자(프론트앤드) 경력직 채용	엔터인	대구 수성구	경력 2~7년	["ERP", "· Vue.js", "· Oracle", "· Java", "· PostgreSQL"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52834	backend	t
3056	React Native 리드 개발자 (5~10년차)	팬딩	서울 강남구	경력 5~10년	["React"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53081	frontend	t
3057	전산팀 서버 구축 기획 경력 채용[8~11년]	오비오	경기 화성시	경력 8~11년	["MSSQL", "· ERP"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53206	other	t
3058	[경력직] Flutter 앱 & Node.js 개발자	인졀미	서울 서초구	경력 5~20년	["Flutter", "· iOS", "· Android OS", "· Visual Studio Code", "· Android Studio", "· Kotlin"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53110	backend	t
3059	AI 국제 물류 스타트업 프론트엔드 개발자	아로아랩스	서울 종로구	경력 1~10년	["GitHub", "· Visual Studio Code", "· JavaScript", "· HTML5", "· CSS 3", "· vuex"]	D-32	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53253	backend	t
3060	FinOps Junior 컨설턴트	메타넷글로벌	서울 강남구	경력 1~4년	["Azure DevOps"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52894	other	t
3061	Mobile(Flutter) developer	유비퍼스트대원	경기 성남시	경력 3~10년	["React Native", "· Android OS", "· iOS", "· Flutter"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53037	frontend	t
3062	시스템 개발/유지보수 신입 채용	엘리펀트키즈에듀테인먼트	인천 계양구	신입	["C#", "· MSSQL"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53176	other	t
3063	QA 엔지니어 (경력) (계약직)	엔닷라이트	경기 성남시	경력 3~6년	["QA", "· 3D Rendering", "· SW"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52670	other	t
3064	IT/AI부문(전문연구요원 포함)경력(1~3)	연합인포맥스	서울 종로구	경력 1~3년	["AI/인공지능", "· TypeScript", "· Next.js", "· Python", "· Chart.js", "· NLP"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53184	backend	t
3065	Cloud Security Engineer(10년~)	한화비전	경기 성남시	경력 10~12년	["ISMS", "· AWS", "· AZURE", "· Firewall", "· IPS", "· AWS IAM", "· AWS WAF"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52056	other	t
3066	클라우드 기술지원 엔지니어	오픈소스컨설팅	서울 강남구	경력 5~13년	["Linux", "· Kubernetes", "· L3", "· Network", "· L2", "· OpenStack"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52148	mobile	t
3067	DevOps/MLOps Engineer (7~10년)	웨어러블에이아이	서울 영등포구	경력 7~10년	["AWS", "· Linux", "· Docker", "· Kubernetes", "· Kubeflow"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52325	mobile	t
3068	개발팀장	아이트럭	서울 서초구	경력 7~25년	["MachineLearning", "· AI/인공지능"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52731	mobile	t
3069	C/C++개발(3년~6년)	위즈코리아	서울 강서구	경력 3~6년	["Linux", "· C", "· C++", "· C#", "· Java"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52861	backend	t
3070	Infra 엔지니어 (3~5년)	메타넷글로벌	서울 강남구	경력 3~5년	["Python", "· MSA", "· Kafka", "· MariaDB"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52899	backend	t
3071	웹개발자 경력(1~3년)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 1~3년	["JavaScript", "· Node.js", "· React", "· Vue.js", "· ASP.NET"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52972	backend	t
3072	[TADA] Infra/DevOps engineer 채용	이지식스(엠블)	서울 강남구	경력 3~8년	["AWS", "· Kubernetes", "· Infra"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53028	mobile	t
3073	회로설계 (본사근무)	비솔	경기 광명시	경력 8~15년	["HW", "· Orcad", "· PCB", "· Pads"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53238	other	t
3074	윈도우 클라이언트 개발 및 유지보수	지니언스	경기 안양시	경력 1~5년	["C", "· C++", "· Windows"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52408	other	t
3075	[PJ_Youkai] 네트워크 엔지니어 채용	보이저	서울 구로구	신입~20년	["SQL", "· Redis", "· C++", "· NoSql", "· AZURE", "· Unity", "· AI/인공지능", "· Docker", "· Linux"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52614	data	t
3076	생성형 AI/LLM 엔지니어	바이스벌사	서울 서초구	경력 3~5년	["PyTorch", "· TensorFlow", "· AWS", "· GCP", "· AI/인공지능", "· MachineLearning"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52365	mobile	t
3077	Infra/시스템 아키텍처 (8~10년)	메타넷글로벌	서울 강남구	경력 8~10년	["Python", "· MSA", "· Kafka", "· MariaDB"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52897	backend	t
3078	AI 개발자 연구원 경력	엔티엘헬스케어	경기 성남시	경력 3~10년	["AI/인공지능"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53128	data	t
3079	IT/AI부문(전문연구요원 포함)신입	연합인포맥스	서울 종로구	신입	["AI/인공지능", "· TypeScript", "· Next.js", "· Python", "· Chart.js", "· NLP"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53183	backend	t
3080	전산팀 서버 구축 기획 경력 채용[12~15년]	오비오	경기 화성시	경력 12~15년	["MSSQL", "· ERP"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53207	other	t
3081	Flutter & node.js 경력 개발자 채용	인졀미	서울 서초구	경력 5~20년	["Flutter", "· iOS", "· Android OS", "· Visual Studio Code", "· Android Studio", "· Kotlin"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53111	backend	t
3082	서버개발팀 백엔드 개발자(경력)	사이버다임	서울 송파구	경력 5~15년	["Java", "· JSP", "· Spring Framework", "· RDB"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53270	backend	t
3083	서버개발팀 웹클라이언트 개발자(경력)	사이버다임	서울 송파구	경력 5~15년	["JavaScript", "· CSS 3", "· HTML5"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53271	backend	t
3084	디지털헬스케어 플랫폼 SW개발자	엑소시스템즈	경기 성남시	경력 3~7년	["Kotlin", "· Android OS", "· SW", "· AWS", "· Firebase"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53278	mobile	t
3085	풀리팀 백엔드 개발자 (3년~5년)	프리윌린	서울 관악구	경력 3~5년	["TypeScript", "· AWS", "· Spring", "· Kotlin"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53280	backend	t
3086	풀리팀 프론트엔드 개발자 (3년~5년)	프리윌린	서울 관악구	경력 3~5년	["TypeScript", "· React", "· JavaScript", "· TailwindCSS", "· NestJS"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53281	backend	t
3087	AI(딥러닝) 연구 및 개발	뉴로다임	서울 성동구	신입~10년	["Linux", "· Python", "· TensorFlow", "· Keras"]	D-33	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53283	backend	t
3088	앱 개발자 경력 채용 (6~9년)	텐빌리언	서울 구로구	경력 6~9년	["Android OS", "· REST API", "· React", "· iOS", "· Flutter"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52113	frontend	t
3089	의료영상 3차원 개발자 채용(1~3)	제이피아이헬스케어	서울 구로구	경력 1~3년	["C", "· C#", "· C++", "· DeepLearning"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52837	mobile	t
3090	의료영상 3차원 개발자 채용(4~6)	제이피아이헬스케어	서울 구로구	경력 4~6년	["C", "· C#", "· C++", "· DeepLearning"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52838	mobile	t
3091	네트워크 엔지니어 경력(10년이상)	텐빌리언	서울 구로구	경력 10~15년	["Network"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52115	other	t
3092	FW개발 경력 채용(3~5년)	인엘씨테크놀러지	대전 유성구	경력 3~5년	["HW", "· FW", "· C", "· MCU", "· MATLAB", "· FPGA"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52449	other	t
3093	해외가상자산거래소 백엔드_10~12년	코베아그룹	서울 서초구	경력 10~12년	["Python", "· REST API", "· Git", "· AWS"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51698	backend	t
3094	R&D 부문 경력사원 채용	스타마타	서울 강남구	경력 1~5년	["DeepLearning", "· C", "· Linux", "· Python", "· AI/인공지능", "· VR", "· AR", "· Embedded"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51733	backend	t
3095	앱 개발자 경력 채용 (10년이상)	텐빌리언	서울 구로구	경력 10~15년	["Android OS", "· REST API", "· React", "· iOS", "· Flutter"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52112	frontend	t
3096	3D 어플리케이션 개발자	메디트	서울 영등포구	신입~15년	["Windows", "· macOS", "· iOS", "· C++", "· Swift", "· Java", "· Qt"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51666	backend	t
3097	웹 퍼블리셔 경력채용 (10년이상)	텐빌리언	서울 구로구	경력 10~15년	["JavaScript", "· HTML5", "· CSS 3", "· jQuery"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52109	backend	t
3098	엔진기술연구팀 AI/ML엔지니어 채용	인피닉	서울 금천구	경력 1~3년	["Python", "· PyTorch", "· AI/인공지능"]	D-day	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51616	backend	t
3099	[의료R&D본부] 프론트엔드 개발 PL	딥노이드	서울 구로구	경력 5~10년	["React", "· REST API", "· TypeScript", "· JavaScript", "· DICOM"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52105	backend	t
3100	[SCK 및 관계사] Microsoft Pre-Sales 채용	에쓰씨케이	서울 강남구	경력 5~10년	["Microsoft Office 365", "· Microsoft SharePoint", "· Microsoft Teams"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52690	other	t
3101	LLM 어플리케이션 개발자 채용	아이브릭스	경기 성남시	경력 7~15년	["Python", "· JavaScript", "· TypeScript", "· React", "· Node.js", "· REST API"]	D-day	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51642	backend	t
3102	모바일/웹 클라이언트 개발자 채용	스쿨버스	서울 강서구	경력 1~9년	["Flutter", "· iOS", "· Android OS", "· Dart", "· Node.js", "· JavaScript"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51806	backend	t
3103	하드웨어 개발자(1~9년)	캐스트프로	경기 성남시	경력 1~9년	["HW"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52065	other	t
3104	웹 프론트 개발자 (Vue.js)	티피씨인터넷	서울 강남구	경력 3~6년	["TypeScript", "· REST API", "· HTML5", "· CSS 3", "· JavaScript", "· Vue.js"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52044	backend	t
3105	보안솔루션(MDM) 개발자(선임급 이상)	비욘드테크	서울 금천구	경력 4~10년	["JSP", "· Java", "· C#", "· SW", "· Spring Boot", "· JavaScript", "· Spring Data JPA", "· AWS"]	D-4	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51877	backend	t
3106	장비제어 프로그램 개발자	제이엔에스	경기 화성시	경력 3~15년	["C#"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51786	other	t
3107	백엔드 및 서버 개발자 채용	스쿨버스	서울 강서구	경력 1~9년	["java", "· Node.js", "· JavaScript", "· REST API", "· AWS", "· MariaDB", "· Flutter", "· Dart"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51807	backend	t
3108	스마트팩토리 자율주행로봇 S/W 개발자	인아텍앤코포	인천 남동구	경력 1~5년	["ROS", "· C++", "· Python", "· AI/인공지능", "· Linux", "· Git", "· OpenCV", "· Embedded"]	D-12	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52244	backend	t
3109	Java Spring 웹개발자 (경력)	하이퍼정보	서울 강남구	경력 1~3년	["Java", "· Spring", "· Mybatis", "· SQL", "· Spring Framework"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52751	backend	t
3110	안드로이드 개발자	티피씨인터넷	서울 강남구	신입~3년	["Kotlin", "· Coroutine", "· Flow"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52046	mobile	t
3111	AI Agent Engineer 정규직	크레버스	서울 성동구	경력 3~15년	["Python", "· AI/인공지능", "· NLP", "· AZURE", "· FastAPI", "· gRPC"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52506	backend	t
3112	백엔드 개발자 경력 채용	위볼린	서울 성동구	경력 3~7년	["TypeScript", "· NestJS", "· PostgreSQL", "· Prisma", "· Docker", "· GitLab", "· AWS"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52759	backend	t
3113	게임 클라이언트 개발자(Cocos Creator)	111퍼센트	서울 강남구	신입~15년	["Cocos2D-X", "· TypeScript", "· Unity", "· Phaser", "· HTML5"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52758	frontend	t
3114	전산팀 (서버/ERP/개발) 경력직 채용	신보	서울 마포구	경력 3~6년	["Java", "· JavaScript", "· Spring", "· Mybatis", "· jQuery", "· ERP", "· Eclipse", "· MSSQL"]	D-25	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53143	backend	t
3115	보안솔루션 소프트웨어개발(경력13~15)	쿤텍	경기 성남시	경력 13~15년	["C", "· Rust", "· Python", "· Shell", "· NoSql", "· Network"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52710	backend	t
3116	PM(Logistics SI)	씨메스	서울 강남구	경력 3~15년	["Microsoft Office 365", "· notion.so", "· Microsoft Teams", "· Jira"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53062	other	t
3117	응용 프로그래머(로봇제어)	제이브이엠	대구 달서구	경력 3~8년	["C#", "· Microsoft SQL Server", "· Python"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52772	backend	t
3118	Field Application Engineer (HIL) 경력	디스페이스코리아	서울 서초구	경력 3~10년	["MATLAB", "· Python", "· SW", "· HW", "· ethernet", "· C", "· C++", "· C#"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51778	backend	t
3119	기업부설연구소 HW 4년↓ 연구원 모집	오버컴테크	서울 금천구	경력 1~4년	["FPGA", "· HW"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52042	other	t
3120	[제로아이즈] PM/기획 매니저	오래	부산 해운대구	경력 7~10년	["AWS", "· Swagger UI", "· MySQL", "· Node.js", "· Vue.js", "· Google Analytics"]	D-7	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52016	backend	t
3121	수원) SW 테스트 엔지니어(QA) (1~3년)	인피닉	서울 금천구	경력 1~3년	["QA", "· Python", "· C", "· SW"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52382	backend	t
3122	기업부설연구소 HW 7년↓ 연구원 모집	오버컴테크	서울 금천구	경력 5~7년	["FPGA", "· HW"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52043	other	t
3123	웹개발 풀스텍 개발자(경력8년이상 ~ )	오마이어스	경기 성남시	경력 8~15년	["PHP", "· Laravel"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52888	backend	t
3124	오픈소스 DB 엔지니어	하이퍼정보	서울 강남구	경력 2~10년	["MySQL", "· MariaDB", "· DB"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52746	other	t
3125	HW개발자(5년이상) 채용	씨앤유글로벌	경기 성남시	경력 5~10년	["Orcad", "· Pads", "· MCU", "· HW", "· Embedded Linux", "· Network"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51861	other	t
3126	H/W설계(경력 9~13년, 3in1 Board)	한솔테크닉스	경기 수원시	경력 9~13년	["HW", "· PCB"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51910	other	t
3127	[AI] Data Scientist(AI Engineer, 8년이상, 리더급)	혜움	서울 강남구	경력 8~20년	["Python", "· Django", "· AWS"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52078	backend	t
3128	PLM 시스템 운영/유지보수	이즈파크	경남 사천시	경력 5~15년	["Java", "· Oracle", "· MSSQL", "· Spring Framework"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/21804	backend	t
3129	프론트엔드 개발자 (16년 ~ 20년)	데이터메이커	대전 유성구	경력 16~20년	["JavaScript", "· ES6", "· Rust", "· three.js", "· Nuxt.js", "· TailwindCSS", "· Vue.js"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51845	backend	t
3130	웹 애플리케이션 개발(경력8~13)	쿤텍	경기 성남시	경력 8~13년	["Spring Boot", "· React", "· TypeScript", "· API Tracker", "· MySQL", "· Git"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52716	backend	t
3131	리눅스 엔지니어 (경력)	하이퍼정보	서울 강남구	경력 2~5년	["Linux"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52748	other	t
3132	웹 그래픽(F/E) 개발자 (16년 ~ 20년)	데이터메이커	대전 유성구	경력 16~20년	["JavaScript", "· Babel", "· React", "· REST API", "· Nuxt.js", "· Webpack", "· HTML5"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51842	backend	t
3133	SW공급망 보안솔루션 엔지니어(5~7년)	쿤텍	경기 성남시	경력 5~7년	["Linux", "· Windows Server", "· Golang", "· Docker", "· Kubernetes"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52726	backend	t
3134	백엔드 서버 개발자 & DevOps 엔지니어	아일리스프런티어	서울 중구	경력 5~10년	["Java", "· Python", "· C++", "· C", "· Kotlin", "· Go"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53246	backend	t
3135	[의료R&D본부] 뇌영상연구팀 AI연구원	딥노이드	서울 구로구	경력 3~5년	["Python", "· PyTorch", "· TensorFlow"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52104	backend	t
3136	5G/LTE/IoT 단말검증 및 기술지원 신입	스톤위즈	서울 영등포구	신입	["AI/인공지능", "· BigData", "· SW", "· AWS IoT Device Management", "· Network"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52761	data	t
3137	데이터 사이언티스트	진스토리코리아	서울 금천구	신입~3년	["TensorFlow", "· Python", "· AWS", "· PyTorch"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/23549	backend	t
3138	H/W 개발(경력 9~13년, TV용 SMPS)	한솔테크닉스	경기 수원시	경력 9~13년	["PCB", "· HW"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51904	other	t
3139	시스템 엔지니어 채용_신입	가야데이터	경남 진주시	신입	["Windows Server", "· VMware vSphere", "· Linux", "· Microsoft SQL Server"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52928	backend	t
3140	Full Stack Developer(Nest.js) 3년 이상	아이샵케어	서울 강남구	경력 3~6년	["TypeScript", "· Node.js", "· NestJS", "· MySQL", "· Google Cloud Platform", "· Sentry"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53227	backend	t
3142	웹개발 풀스텍 개발자(신입 )	오마이어스	경기 성남시	신입	["PHP", "· Laravel"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52889	backend	t
3143	AI 로보틱스 SW 품질 QA 담당자	씨메스	서울 강남구	경력 4~20년	["Qt", "· QA", "· SW", "· GitHub", "· Python", "· JavaScript", "· Docker"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53173	backend	t
3144	웹개발 풀스텍 개발자(경력2~4년)	오마이어스	경기 성남시	경력 2~4년	["PHP", "· Laravel"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52885	backend	t
3145	WiFi Router 개발 신입 채용	가온브로드밴드	경기 성남시	신입	["C", "· Linux", "· C++", "· Embedded", "· Router", "· Network", "· Embedded Linux"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53241	other	t
3146	검사장비 HW/FW 개발 경력 채용	피닉슨컨트롤스	경기 화성시	경력 5~15년	["HW", "· FW", "· ARM", "· PCB"]	D-12	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52176	other	t
3147	front End 개발자(threejs)	씨메스	서울 강남구	경력 3~10년	["TypeScript", "· three.js", "· Next.js", "· React", "· FastAPI", "· Python", "· JavaScript"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53172	backend	t
3148	[제로아이즈]개발팀 Lead_경력13~15년	오래	부산 해운대구	경력 13~15년	["Vue.js", "· TypeScript", "· Node.js", "· ExpressJS", "· MySQL", "· AWS", "· Docker"]	D-7	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52015	backend	t
3149	네트워크/OT 보안엔지니어(경력5~7년)	쿤텍	경기 성남시	경력 5~7년	["Linux", "· Windows Server", "· Firewall"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52735	backend	t
3150	응용 프로그래머	제이브이엠	대구 달서구	경력 3~8년	["C#", "· Microsoft SQL Server", "· WPF", "· WCF", "· Blazor"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52771	backend	t
3151	backend (python) 개발자	씨메스	서울 강남구	경력 3~5년	["Python", "· JavaScript", "· MariaDB", "· C++"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53174	backend	t
3152	백엔드 개발자 (5년 이상)	씨앤유글로벌	경기 성남시	경력 5~10년	["Java", "· Spring", "· Oracle", "· MariaDB"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53193	backend	t
3153	[제로아이즈]개발팀 Lead_경력3~9년	오래	부산 해운대구	경력 3~9년	["Vue.js", "· TypeScript", "· Node.js", "· ExpressJS", "· MySQL", "· AWS", "· Docker"]	D-7	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52013	backend	t
3154	앱 개발자 경력 채용 (2~5년)	텐빌리언	서울 구로구	경력 2~5년	["Android OS", "· REST API", "· React", "· iOS", "· Flutter"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52114	frontend	t
3155	수원) SW 테스트 엔지니어(QA) (4~8년)	인피닉	서울 금천구	경력 4~8년	["QA", "· Python", "· C", "· SW"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52383	backend	t
3156	HW/RF 설계 경력 (7년~15년)	세기알앤디	인천 부평구	경력 7~15년	["HW", "· RF"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52694	other	t
3157	게임 클라이언트 개발자	111퍼센트	서울 강남구	경력 5~15년	["Unity", "· Photon", "· TCP/IP", "· Network"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52757	other	t
3158	응용 프로그래머(인공지능)	제이브이엠	대구 달서구	경력 3~8년	["C#", "· Microsoft SQL Server", "· Python", "· WPF", "· WCF"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52773	backend	t
3159	5G/LTE/IoT 단말검증 및 기술지원 경력	스톤위즈	서울 영등포구	경력 3~10년	["AI/인공지능", "· BigData", "· SW", "· AWS IoT Device Management", "· Network"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52762	data	t
3160	Field Application Engineer (HIL) 신입	디스페이스코리아	서울 서초구	신입	["MATLAB", "· Python", "· SW", "· HW", "· ethernet", "· C", "· C++", "· C#"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51777	backend	t
3161	[제로아이즈]개발팀 Lead_경력10~12년	오래	부산 해운대구	경력 10~12년	["Vue.js", "· TypeScript", "· Node.js", "· ExpressJS", "· MySQL", "· AWS", "· Docker"]	D-7	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52014	backend	t
3162	AI 인프라, AI Ops 환경 구성	디에스앤지	서울 영등포구	경력 6~20년	["AI/인공지능", "· CUDA", "· DeepLearning", "· Python", "· Infra", "· K8S"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53153	backend	t
3163	Java 백엔드 개발자(8~10년)	아파트아이	서울 금천구	경력 8~10년	["Spring", "· JavaScript", "· jQuery", "· Java"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53265	backend	t
3164	SW개발_Measurement파트 채용	알피니언메디칼시스템	서울 강서구	경력 2~15년	["Windows", "· C++", "· C", "· Visual C++", "· C#", "· WPF", "· SW"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51931	other	t
3165	웹개발 풀스텍 개발자(경력5~7년)	오마이어스	경기 성남시	경력 5~7년	["PHP", "· Laravel"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52886	backend	t
3166	시스템 엔지니어 채용_4년이상	가야데이터	경남 진주시	경력 4~7년	["Windows Server", "· VMware vSphere", "· Linux", "· Microsoft SQL Server"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52930	backend	t
3167	안드로이드 앱 개발자(java, kotlin)	크래블	서울 성동구	신입~15년	["Java", "· Kotlin", "· Swift", "· Android SDK", "· TypeScript"]	D-30	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53295	backend	t
3168	AWS/NCP Cloud Architect 모집	웅진	서울 중구	경력 4~20년	["AWS", "· Azure DevOps"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52426	other	t
3169	의료IT 클라우드 인프라 경력 채용	이지케어텍(edge&next)	서울 중구	경력 1~18년	["C#", "· WPF", "· .NET", "· Oracle", "· JavaScript", "· AWS", "· GCP"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52828	backend	t
3170	DBA 경력 직원 채용 (20년 이상)	엘아이지시스템	서울 종로구	경력 20~21년	["SQL", "· Azure SQL Database", "· DB"]	D-7	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51940	data	t
3172	네트워크 장비 구축 엔지니어 채용	유씨아이	대전 서구	신입~15년	["Ccna", "· Cisco", "· Network", "· Ccie", "· TCP/IP", "· AWS", "· VPN", "· AZURE", "· Ccnp"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51813	other	t
3173	의료IT S/W 개발직 경력 채용	이지케어텍(edge&next)	서울 중구	경력 2~18년	["C#", "· WPF", "· .NET", "· Oracle", "· JavaScript", "· MySQL"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52829	backend	t
3174	DBA 경력 직원 채용 (16~19년)	엘아이지시스템	서울 용산구	경력 16~19년	["SQL", "· Azure SQL Database", "· DB"]	D-7	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51941	data	t
3175	백엔드 개발자	더블미디어	서울 강남구	경력 3~20년	["Golang", "· JavaScript", "· MySQL", "· Redis", "· AWS"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52667	backend	t
3176	클라우드 서버 네트워크	이지케어텍(edge&next)	서울 중구	경력 1~18년	["AWS", "· AZURE", "· GCP", "· Linux", "· Windows", "· vmware", "· Kubernetes"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52826	mobile	t
3177	네트워크 운영 경력직 모집	웅진	서울 중구	경력 5~20년	["FW", "· IPS", "· VPN"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52427	other	t
3178	웹 퍼블리셔 경력채용 (6~9년)	텐빌리언	서울 구로구	경력 6~9년	["JavaScript", "· HTML5", "· CSS 3", "· jQuery"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52110	backend	t
3179	제어설계(PC) 분야 [경력5~9년]	태하	경기 남양주시	경력 5~9년	["SW", "· C", "· C#", "· C++", "· Mfc", "· MES", "· SQL", "· Windows", "· Linux"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52346	other	t
3180	웹개발자 경력(4~7년)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 4~7년	["JavaScript", "· Node.js", "· React", "· Vue.js", "· ASP.NET"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52973	backend	t
3181	AI 에이전트 엔지니어 (5년~10년차)	에스엠해썹	경기 오산시	경력 5~10년	["Python", "· PyTorch", "· Keras", "· Docker", "· Ubuntu", "· FastAPI"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52848	backend	t
3182	파이썬 백엔드 리드(10~12년)	샐러드랩	서울 강남구	경력 5~9년	["Python", "· Django", "· FastAPI", "· AWS", "· AWS Lambda", "· Amazon Route 53"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53196	backend	t
3183	[하나금융그룹 자회사] DBA (7년이상)	핀크	서울 중구	경력 7~10년	["MariaDB", "· MySQL", "· MaxScale"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53200	other	t
3184	[인공지능솔루션] ML Engineer	제논	서울 강남구	경력 3~20년	["Docker", "· PyTorch", "· Kubernetes"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52686	mobile	t
3185	AMS사업부 ACS 개발자 채용	유진로봇	인천 연수구	경력 5~12년	["C#", "· Java", "· JavaScript", "· PLC", "· Git", "· MES", "· TypeScript", "· MySQL"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52654	backend	t
3186	전자제어 H/W [경력10~14년]	태하	경기 남양주시	경력 10~14년	["HW", "· MCU", "· PCB"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52348	other	t
3187	비전알고리즘 개발 연구원(5년-10년)	WATA Inc.	경기 성남시	경력 5~10년	["C++", "· OpenCV", "· C#", "· Rust", "· Python", "· Segment"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53026	backend	t
3188	ML Engineer (Embedded,8~10년)	웨어러블에이아이	서울 영등포구	경력 8~10년	["CUDA", "· C", "· C++", "· Embedded Linux", "· PyTorch"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52327	data	t
3189	서비스개발 총괄매니저 채용	서울거래	서울 영등포구	경력 7~20년	["Python", "· Flutter"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53229	backend	t
3190	로봇제어Engineer:Senior(과장-부장)[박사급]	리브스메드	경기 성남시	경력 7~18년	["C++", "· Python", "· Git", "· Notion", "· Jira", "· C", "· MATLAB", "· SW"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52333	backend	t
3191	인프라 및 웹보안 개발(3년~5년)	핀즐	서울 송파구	경력 3~5년	["Infra", "· GCP", "· CloudFlare"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52283	other	t
3192	카카오톡 상담톡/챗봇 서비스 개발자	비즈톡	서울 강남구	경력 5~10년	["C++", "· C"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52907	other	t
3193	Game Server Programmer 팀장급 채용	보이저	서울 구로구	경력 8~20년	["MySQL", "· AZURE", "· SQL", "· C#", "· C++", "· Unity", "· Redis", "· Unreal Engine"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52621	backend	t
3194	알고리즘 개발자 경력 채용(6~8년)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 6~8년	["TensorFlow", "· Keras", "· Slim"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52633	data	t
3195	시스템개발/유지보수(4~6년)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 4~6년	["C#", "· MSSQL"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53178	other	t
3196	알고리즘 개발자 경력 채용(3~5년)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 3~5년	["TensorFlow", "· Keras", "· Slim"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52632	data	t
3197	PNS팀 서버 개발자 10년 이상	지니언스	경기 안양시	경력 10~15년	["C", "· C++", "· Linux", "· VPN"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52399	backend	t
3198	임베디드 리눅스 네트워크 개발_팀장급	누코드	서울 강남구	경력 3~5년	["Zephyr", "· Embedded Linux", "· Arduino", "· FPGA"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51781	other	t
3199	에스크로 플랫폼 시니어 개발(6년~8년)	핀즐	서울 송파구	경력 6~8년	["Spring Framework", "· React D3 Library"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52290	backend	t
3200	인프라 및 웹보안 개발(6년~8년)	핀즐	서울 송파구	경력 6~8년	["Infra", "· GCP", "· CloudFlare"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52284	other	t
3201	영상처리,비전(Vision) S/W채용(6~8년)	포우	경기 용인시	경력 6~8년	["SW", "· OpenCV", "· C++"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52190	other	t
3202	PEP팀 ZTNA개발자	지니언스	경기 안양시	경력 10~15년	["C", "· C++", "· Linux", "· VPN", "· Linux Mint"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52409	other	t
3203	프록시 서버 개발	프라이빗테크놀로지	서울 마포구	경력 3~15년	["NGINX", "· TCP/IP", "· Lua", "· C", "· C++", "· Linux", "· Nginx Proxy Manager"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53064	backend	t
3204	ADC(L4-L7 스위치) 애플리케이션 개발	파이오링크	서울 금천구	경력 2~10년	["Linux", "· C", "· L4", "· L7", "· Git", "· React", "· C++", "· Java", "· Python", "· Docker"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52794	backend	t
3205	C/C++개발(7년~10년)	위즈코리아	서울 강서구	경력 7~10년	["Linux", "· C", "· C++", "· C#", "· Java"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52862	backend	t
3206	전자제어 S/W [경력5~10년]	태하	경기 남양주시	경력 5~10년	["SW", "· C", "· C++", "· FW"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52345	other	t
3207	머신러닝 연구원/엔지니어	에이아이파크	서울 마포구	경력 3~10년	["Python", "· PyTorch", "· TensorFlow", "· AZURE", "· Docker", "· Git", "· GitHub"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52501	backend	t
3208	백엔드 개발자 채용	서울거래	서울 영등포구	경력 4~20년	["Python", "· Django", "· Git", "· AWS", "· PostgreSQL", "· Celery", "· RDB", "· HTML5"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53231	backend	t
3209	판교연구소 SW개발 (경력 10~12년)	인텔리안테크놀로지스	경기 성남시	경력 10~12년	["C", "· C++", "· Embedded Linux", "· JsonAPI"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52807	frontend	t
3210	프론트엔드 리드 개발자 (5~10년차)	팬딩	서울 강남구	경력 5~10년	["Vue.js"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53082	frontend	t
3211	파이썬 백엔드 리드(5~9년)	샐러드랩	서울 강남구	경력 5~9년	["Python", "· Django", "· FastAPI", "· AWS", "· AWS Lambda", "· Amazon Route 53"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53195	backend	t
3212	[Riiid] MLOps Engineer (2년 이상)	뤼이드	서울 강남구	경력 2~8년	["Airflow", "· Databricks", "· PyTorch", "· TensorFlow", "· Git", "· Kubernetes"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52523	mobile	t
3213	DevOps 엔지니어	시스트란	대전 서구	경력 3~10년	["Python", "· TensorFlow", "· PyTorch", "· NLP", "· Linux", "· Docker", "· DeepLearning"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53160	backend	t
3214	스마트공장 PLC/DCS 엔지니어	에스엠해썹	경기 오산시	경력 2~7년	["PLC", "· HW", "· SW"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53135	other	t
3215	로봇제어Engineer:Senior(과장-부장)	리브스메드	경기 성남시	경력 7~18년	["C++", "· Python", "· Git", "· Notion", "· Jira", "· C", "· MATLAB", "· SW"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52332	backend	t
3216	Technical Artist 채용	보이저	서울 구로구	경력 3~15년	["Unreal Engine", "· Python", "· Unity"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52613	backend	t
3217	Android OS 개발 병역특례	엔티엘헬스케어	경기 성남시	신입	["Android OS", "· iOS"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53127	mobile	t
3218	바이오인식 / OCR 알고리즘 개발	엑스페릭스	경기 성남시	경력 2~7년	["C", "· C++", "· C#", "· Java", "· Python", "· DeepLearning"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53144	backend	t
3219	기술개발 총괄 및 리딩(8~11년)	WATA Inc.	경기 성남시	경력 8~11년	["RDB", "· REST API", "· C++", "· Java", "· AWS", "· React", "· SQL"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52979	backend	t
3220	시스템개발/유지보수(1~3년)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 1~3년	["C#", "· MSSQL"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53177	other	t
3221	전산팀 서버 구축 기획 경력 채용[5~7년]	오비오	경기 화성시	경력 5~7년	["MSSQL", "· ERP"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53205	other	t
3222	임베디드 S/W 개발자	넥스트랩	서울 강남구	경력 2~5년	["Embedded", "· Linux", "· Python", "· C++", "· C"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53248	backend	t
3223	PNS팀 서버 개발자 5년 이상	지니언스	경기 안양시	경력 5~9년	["C", "· C++", "· Linux", "· VPN"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52398	backend	t
3224	AI 연구개발자 (박사)	더블티	경기 수원시	신입	["AI/인공지능", "· PyTorch", "· TestNG", "· DeepLearning"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53115	mobile	t
3225	인공지능(AI) 엔지니어 고급 채용	알비에치	경기 안양시	경력 8~10년	["MachineLearning", "· DeepLearning", "· AI/인공지능", "· Python"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52233	backend	t
3226	Infra/시스템 아키텍처 (11~13년)	메타넷글로벌	서울 강남구	경력 11~13년	["Python", "· MSA", "· Kafka", "· MariaDB"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52898	backend	t
3227	Verification Engineer/대구	아이디어스투실리콘	대구 북구	경력 3~15년	["Verilog", "· ASIC", "· Perl", "· TCP/IP", "· FPGA", "· VHDL", "· C#", "· C++", "· Python"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51625	backend	t
3228	데이터 사이언티스트	바로팜	서울 강남구	경력 5~10년	["MachineLearning", "· SQL", "· Python", "· DeepLearning", "· Tableau", "· PowerBI"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52753	backend	t
3229	[IPGAME] Game Server Programmer	보이저	서울 구로구	경력 1~20년	["Unity", "· C++", "· Golang", "· NoSql", "· Android OS", "· iOS"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53116	backend	t
3230	DB개발자 채용	넥서스커뮤니티	서울 영등포구	경력 5~15년	["RDB", "· AWS", "· MySQL", "· Oracle", "· PostgreSQL", "· SQL", "· DB", "· NoSql"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53219	other	t
3231	플랫폼 서비스 개발자 채용	유니버스에이아이	서울 영등포구	경력 2~10년	["Node.js", "· Python", "· PostgreSQL", "· Infra", "· RDB", "· MySQL", "· Linux", "· DB"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53239	backend	t
3232	FPGA - HW Engineer (대리~과장급)	리브스메드	경기 성남시	경력 5~8년	["FPGA", "· MCU", "· VHDL"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52335	data	t
3233	[Network-on-Chip] Software Engineer	오픈엣지테크놀로지	서울 강남구	경력 10~15년	["C", "· C++", "· Python", "· JavaScript", "· ES6", "· EDA"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52587	backend	t
3234	시니어 클라이언트 프로그래머 채용	보이저	서울 구로구	경력 6~20년	["C++", "· DirectX", "· Redis", "· Unity", "· C#"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52617	other	t
3235	TA(Technical Architect)/DBA	메타넷글로벌	서울 강남구	경력 10~16년	["Oracle", "· ERP", "· Tibero"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52895	other	t
3236	DevOps 엔지니어(5-8년 경력)	싸이터	서울 금천구	경력 5~8년	["Kubernetes", "· Kafka", "· Redis", "· Elasticsearch", "· MSA", "· ISMS", "· Java", "· AWS"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52875	backend	t
3237	플랫폼 및 운영 엔지니어(DevOps/SRE)	위펀	서울 강남구	경력 5~10년	["MySQL", "· Spring Boot", "· Java", "· QueryDSL", "· MariaDB"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53240	backend	t
3238	SW개발 경력(Labview)	에이스웍스코리아	서울 강남구	경력 3~10년	["labview", "· SW"]	D-31	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53190	other	t
3239	Technical Support 엔지니어 주니어 채용(대전)	시스트란	대전 서구	경력 1~2년	["AI/인공지능", "· Python", "· Linux", "· Docker", "· K8S"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53159	backend	t
3240	Unity 클라이언트 개발자 (7년-10년)	WATA Inc.	경기 성남시	경력 7~10년	["Unity", "· C#", "· Java", "· C++", "· Lua"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53182	backend	t
3241	시니어 프론트엔드 SW Engineer	제이앤피메디	인천 연수구	경력 8~20년	["JavaScript", "· MSA", "· TypeScript", "· React", "· Sass", "· JSX", "· GitHub Actions"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53187	backend	t
3242	시니어 프론트엔드 개발자	아이트럭	서울 서초구	경력 5~10년	["JavaScript", "· Kotlin", "· Node.js", "· REST API", "· Java", "· Python", "· SQL", "· Vue.js"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52729	backend	t
3243	Service architect(VDMS)	유비퍼스트대원	경기 성남시	경력 3~10년	["Figma", "· Microsoft Excel"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53038	other	t
3244	솔루션 프론트엔드 개발자 계약직 (정규직 전환) 경력자 채용	하이케어넷	서울 송파구	경력 4~8년	["React", "· NestJS", "· TypeORM", "· TypeScript", "· Bitbucket", "· Jira"]	D-33	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53269	backend	t
3245	디지털헬스케어 플랫폼임베디드 개발자	엑소시스템즈	경기 성남시	경력 3~10년	["HW", "· FW", "· Analog", "· Embedded", "· RTOS"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53277	other	t
3246	디지털헬스케어 플랫폼 AI 엔지니어	엑소시스템즈	경기 성남시	신입~10년	["AI/인공지능", "· C++", "· MATLAB", "· TensorFlow", "· Python"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53279	backend	t
3247	[바이브 코딩 외주 개발] 시니어 풀스택 개발자 채용	언더밀리	강원 춘천시	경력 3~5년	["JavaScript", "· Node.js", "· Python", "· AWS", "· AZURE", "· GitHub"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53296	backend	t
3248	의료IT 모바일 인공지능 경력 채용	이지케어텍(edge&next)	서울 중구	경력 1~18년	["C#", "· WPF", "· .NET", "· Oracle", "· JavaScript", "· MySQL"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52827	backend	t
3249	PC 제어(시스템제어팀) (8~10년)	쎄크	경기 수원시	경력 8~10년	["C++", "· Mfc", "· SW", "· Embedded", "· C"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51743	other	t
3250	PLC (SIEMENS) 제어 (5~7년)	쎄크	경기 수원시	경력 5~7년	["C++", "· Mfc", "· SW", "· C"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51748	other	t
3251	PC 제어(시스템제어팀) (2~4년)	쎄크	경기 수원시	경력 2~4년	["C++", "· Mfc", "· SW", "· Embedded", "· C"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51741	other	t
3252	PLC (SIEMENS) 제어 (2~4년)	쎄크	경기 수원시	경력 2~4년	["C++", "· Mfc", "· SW", "· C"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51747	other	t
3253	병원정보시스템 클라우드(EMR) 개발자	이지케어텍(edge&next)	서울 중구	경력 3~18년	["C#", "· WPF", "· .NET", "· Oracle", "· JavaScript"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52824	backend	t
3254	영상처리(Vision) S/W 개발 (8~10년)	쎄크	경기 수원시	경력 8~10년	["C++", "· C#", "· OpenCV", "· SW", "· HALCON"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51746	other	t
3255	영상처리(Vision) S/W 개발 (2~4년)	쎄크	경기 수원시	경력 2~4년	["C++", "· C#", "· OpenCV", "· SW", "· HALCON"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51744	other	t
3256	CA/RA 개발자 경력 모집	한국전자인증	서울 서초구	경력 7~10년	["Linux", "· C++", "· C", "· Java", "· AWS", "· Eclipse", "· Python"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53013	backend	t
3257	PWA (Mobile / Web & WebApp)	에프씨지	경기 광명시	신입~10년	["AWS", "· QA"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53107	other	t
3258	PLC (Mitsubishi) 제어 (2년이상)	쎄크	경기 수원시	경력 2~5년	["PLC", "· HW"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51740	other	t
3259	AI/ML Senior 연구자	서플러스글로벌	경기 용인시	경력 5~20년	["AI/인공지능", "· Python", "· R", "· NLP", "· PyTorch", "· NumPy", "· Pandas", "· scikit-learn"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52702	backend	t
3260	플러터 개발자 (Flutter, 3~6년)	클레온	서울 중구	경력 3~6년	["Flutter", "· Kotlin", "· JavaScript", "· Dart", "· Figma"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52999	backend	t
3261	시스템 설계 Manager	서플러스글로벌	경기 용인시	경력 7~20년	["ERP", "· Jira", "· Java", "· MSSQL"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52704	backend	t
3262	SAP ERP(S/4HANA컨설턴트)	웅진	서울 중구	경력 7~20년	["SAP", "· ERP", "· SW"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51891	other	t
3263	시스템 개발 Manager	서플러스글로벌	경기 용인시	경력 5~20년	["Java", "· REST API", "· Spring", "· Spring Boot", "· MSSQL", "· MariaDB", "· PostgreSQL"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52703	backend	t
3264	플러터 개발자 (Flutter, 7~10년)	클레온	서울 중구	경력 7~10년	["Flutter", "· Kotlin", "· JavaScript", "· Dart", "· Figma"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52998	backend	t
3265	병원정보시스템 S/W 경력 개발자	이지케어텍(edge&next)	서울 중구	경력 2~18년	["C#", "· WPF", "· .NET", "· Oracle", "· JavaScript", "· MySQL"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52825	backend	t
3266	CA/RA 개발자 신입 모집	한국전자인증	서울 서초구	신입	["Linux", "· C++", "· C", "· Java", "· AWS", "· Eclipse", "· Python"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53014	backend	t
3267	웹 프론트엔드 개발자	더블미디어	서울 강남구	경력 3~20년	["React", "· NestJS", "· Vue.js", "· CSS 3"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52984	backend	t
3268	Frontend Engineer	아이브	서울 서초구	경력 3~10년	["React", "· Next.js", "· TypeScript", "· JavaScript", "· CSS 3", "· HTML5", "· REST API"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52229	backend	t
3269	엘리하이/엠베스트 웹개발 경력직 채용	메가스터디교육	서울 서초구	경력 3~7년	["Classic ASP", "· Spring", "· Spring Boot", "· SQL", "· MSSQL", "· MySQL", "· MariaDB"]	D-4	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52836	backend	t
3270	포탈 웹사이트 Back-end 개발자 경력직	아이디에스앤트러스트	서울 강남구	경력 3~12년	["Spring Framework", "· Java", "· Kotlin", "· React", "· NoSql", "· Python", "· C#", "· MySQL"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52635	backend	t
3271	[플랫폼Tech팀] 데이터플랫폼 서비스 엔지니어 경력사원 채용	롯데이노베이트	서울 금천구	경력 3~6년	["Java", "· Spring", "· PostgreSQL", "· Kubernetes", "· Jenkins", "· Spring Framework"]	D-4	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53021	backend	t
3272	백엔드 개발 (경력 1~5년)	에이치비엠피	서울 구로구	경력 1~5년	["GitHub", "· MySQL", "· Node.js", "· Amazon EC2", "· NGINX", "· React.js Boilerplate"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52216	backend	t
3273	인프라 개발 경력직 채용	쥬비스다이어트	서울 강남구	경력 3~5년	["Java", "· Spring Framework", "· Spring Boot", "· MySQL", "· Angular 2", "· React"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52774	backend	t
3274	ERP/MES 개발자 채용	이맥스하이텍	경기 남양주시	경력 1~15년	["Java", "· ERP", "· MES", "· C#", "· .NET", "· SW", "· JSP", "· MSSQL"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52271	backend	t
3275	시스템 엔지니어 (경력)	아주큐엠에스	서울 서초구	경력 2~5년	["Linux", "· Windows", "· AWS", "· AZURE", "· GCP"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52322	other	t
3276	iOS 개발자 (1년 이상)	이스트소프트	서울 서초구	경력 1~5년	["SwiftUI", "· Android OS", "· iOS", "· AR", "· Swift", "· Lottie", "· OAuth2"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52518	mobile	t
3277	전산실 ERP/쇼핑몰 개발 및 운영 개발자	린컴퍼니	서울 강남구	경력 5~15년	["Java", "· Spring", "· Miplatform", "· ERP", "· Oracle"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52756	backend	t
3278	AOP 엔지니어링_UE파트 연구원 채용	알피니언메디칼시스템	서울 강서구	신입~10년	["MATLAB", "· Python", "· labview", "· SW"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51933	backend	t
3279	HW개발_아날로그/파워 책임급 채용	알피니언메디칼시스템	서울 강서구	경력 8~13년	["HW", "· PCB"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51930	other	t
3280	임베디드SW 또는 FW개발자(경력13~15)	쿤텍	경기 성남시	경력 13~15년	["Embedded Linux", "· C++", "· C"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52750	other	t
3281	알약 PC/Mobile 제품기획자	이스트시큐리티	서울 서초구	경력 5~15년	["GitLab", "· Figma", "· Google Analytics", "· Firebase"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52609	backend	t
3282	서버 및 인프라 개발자 (5년 ~ 10년)	데이터메이커	대전 유성구	경력 5~10년	["Terraform", "· Pulumi", "· Golang", "· Argo", "· Linux", "· Ansible", "· Python", "· Shell"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51837	backend	t
3283	완성차 검차라인 SW 개발(5년↑)	에이디티	경기 안산시	경력 5~9년	["C#", "· C", "· C++", "· Mfc", "· SW"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52072	other	t
3284	2차전지 검사기 개발자 (경력5~7년)	아이비젼웍스	충남 천안시	경력 5~7년	["OpenCV", "· C++", "· Mfc"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52135	other	t
3285	로봇 시스템 엔지니어	씨메스	서울 강남구	경력 10~20년	["PLC", "· HW"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53058	other	t
3286	WiFi Router개발 경력 6~10년	가온브로드밴드	경기 성남시	경력 6~10년	["C", "· Linux", "· C++", "· Embedded", "· Router", "· Network", "· Embedded Linux"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53243	other	t
3287	GPON 개발자 경력 채용(3~10년)	가온브로드밴드	경기 성남시	경력 3~10년	["C", "· Linux", "· C++", "· Embedded Linux", "· SW", "· TCP/IP", "· Network"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53244	other	t
3288	SW공급망 보안솔루션 엔지니어(8~10년)	쿤텍	경기 성남시	경력 8~10년	["Linux", "· Windows Server", "· Golang", "· Docker", "· Kubernetes"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52727	backend	t
3289	SW공급망 보안솔루션개발자(경력17~20)	쿤텍	경기 성남시	경력 17~20년	["Linux", "· Windows Server", "· Golang", "· Docker", "· Kubernetes", "· Python"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52741	backend	t
3290	자율주행차량 제어 시스템 엔지니어	토르드라이브	서울 영등포구	경력 3~10년	["C++", "· Python"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51982	backend	t
3291	Multi Agent Path Finding S/W Engineer (전문연 가능)	토르드라이브	서울 영등포구	경력 3~10년	["C++", "· ROS"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51981	other	t
3292	SAP BC 운영 및 개발자 (4년 이상)	브이엔티지	서울 마포구	경력 4~10년	["ABAP", "· ERP", "· SAP"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51548	other	t
3293	보안솔루션 소프트웨어개발(경력10~12)	쿤텍	경기 성남시	경력 10~12년	["C", "· Rust", "· Python", "· Shell", "· NoSql", "· Network"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52709	backend	t
3294	IMS & ECS 개발 (경력 10~12년)	원익피앤이	경기 수원시	경력 10~12년	["C#", "· WPF"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51994	other	t
3295	ML Engineer (13년 이상)	데이터메이커	대전 유성구	경력 13~15년	["Git", "· Ubuntu", "· NLP", "· Kubeflow", "· Kubernetes", "· TensorFlow", "· Python"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51830	backend	t
3296	기업부설연구소 HW 10년↓ 연구원 모집	오버컴테크	서울 금천구	경력 8~10년	["FPGA", "· HW"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52041	other	t
3297	Senior S/W Engineer-Embedded AI [전문연구요원가능]	토르드라이브	서울 영등포구	경력 3~10년	["C", "· C++", "· CUDA"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51970	data	t
3298	IMS & ECS 개발 (경력 13~15년)	원익피앤이	경기 수원시	경력 13~15년	["C#", "· WPF"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51993	other	t
3299	모터제어 엔지니어(6~10년차)	긴트	경기 성남시	경력 6~10년	["C", "· C++", "· SW", "· Embedded"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52342	other	t
3300	IMS & ECS 개발 (경력 6~9년)	원익피앤이	경기 수원시	경력 6~9년	["C#", "· WPF"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51992	other	t
3301	HW/ 전장 설계 경력	세기알앤디	인천 부평구	경력 7~15년	["HW", "· RF", "· Pads"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52693	other	t
3302	ML Engineer (8년 ~ 12년)	데이터메이커	대전 유성구	경력 8~12년	["Git", "· Ubuntu", "· NLP", "· Kubeflow", "· Kubernetes", "· TensorFlow", "· Python"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51829	backend	t
3303	Sr. AI & Data Analysis Specialist(11~15y)	피엠인터내셔널코리아	서울 영등포구	경력 11~15년	["SQL", "· NoSql", "· Tableau", "· AWS", "· AZURE", "· NLP"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52776	data	t
3304	SW공급망 보안솔루션설계(경력7~12)	쿤텍	경기 성남시	경력 7~12년	["Linux", "· Windows Server", "· Golang", "· Docker", "· Kubernetes", "· Python"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52743	backend	t
3305	SW공급망 보안솔루션설계(경력13~17)	쿤텍	경기 성남시	경력 13~17년	["Linux", "· Windows Server", "· Golang", "· Docker", "· Kubernetes", "· Python"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52744	backend	t
3306	Camera Sensor Engineer	모빌린트	서울 강남구	경력 3~5년	["Linux"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51716	other	t
3307	AI Lifecyle 유지관리를 위한 AI Engineer	씨메스	서울 강남구	경력 3~10년	["TensorFlow", "· Python"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52514	backend	t
3308	Fullstack 개발리더 (10년이상)	바이트사이즈	부산 부산진구	경력 10~15년	["Python", "· JavaScript", "· MySQL", "· PyTorch", "· Git", "· Microsoft Teams"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53197	backend	t
3309	[플랫폼개발팀] DevOps 시스템 관리자	델레오코리아	서울 강남구	경력 6~12년	["AWS", "· Git", "· Prometheus", "· Grafana", "· Java", "· Kubernetes", "· Docker"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52586	backend	t
3310	네트워크/OT 보안엔지니어(경력8~10년)	쿤텍	경기 성남시	경력 8~10년	["Linux", "· Windows Server", "· Firewall"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52738	backend	t
3311	GUI S/W 설계,개발 채용(5년↑)	에이디티	경기 안산시	경력 5~9년	["Visual C++", "· C#", "· JavaScript", "· Linux", "· REST API"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53189	backend	t
3312	웹 그래픽(F/E) 개발자 (11년 ~ 15년)	데이터메이커	대전 유성구	경력 11~15년	["JavaScript", "· Babel", "· React", "· REST API", "· Nuxt.js", "· Webpack", "· HTML5"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51841	backend	t
3313	SW공급망 보안솔루션개발자(경력7~11)	쿤텍	경기 성남시	경력 7~11년	["Linux", "· Windows Server", "· Golang", "· Docker", "· Kubernetes", "· Python"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52739	backend	t
3314	회로개발 (경력 8~10년)	원익피앤이	경기 수원시	경력 8~10년	["HW", "· SW", "· Embedded", "· FW"]	D-19	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52492	other	t
3315	시스템 엔지니어 채용_1~3년	가야데이터	경남 진주시	경력 1~3년	["Windows Server", "· VMware vSphere", "· Linux", "· Microsoft SQL Server"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52929	backend	t
3316	GPON 개발자 경력 채용(11~20년)	가온브로드밴드	경기 성남시	경력 11~20년	["C", "· Linux", "· C++", "· Embedded Linux", "· SW", "· TCP/IP", "· Network"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53245	other	t
3317	임베디드 소프트웨어 개발자(5~8년차)	긴트	경기 성남시	경력 5~8년	["C", "· C++", "· SW", "· Embedded"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52340	other	t
3318	자율주행 개발자(3~6년차)	긴트	경기 성남시	경력 3~6년	["MATLAB", "· C", "· C++", "· SW", "· Python"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52338	backend	t
3319	임베디드SW 또는 FW개발자(경력9~12)	쿤텍	경기 성남시	경력 9~12년	["Embedded Linux", "· C++", "· C"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52749	other	t
3320	시스템 엔지니어 경력 채용	디에스앤지	서울 영등포구	경력 7~15년	["Ubuntu", "· Linux", "· Kubernetes", "· Docker", "· Docker Compose"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53151	mobile	t
3321	자율주행 개발자(7~10년차)	긴트	경기 성남시	경력 7~10년	["MATLAB", "· C", "· C++", "· SW", "· Python"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52339	backend	t
3322	회로개발 (경력 11~15년)	원익피앤이	경기 수원시	경력 11~15년	["HW", "· SW", "· Embedded", "· FW"]	D-19	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52493	other	t
3323	Developer Relations Engineer	업스테이지	기타	경력 3~20년	["AI/인공지능"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52259	data	t
3324	DevOps 엔지니어 [전문연구요원가능]	토르드라이브	서울 영등포구	경력 3~10년	["C", "· C++", "· CUDA", "· Kubernetes"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51973	mobile	t
3325	SW공급망 보안솔루션개발자(경력12~16)	쿤텍	경기 성남시	경력 12~16년	["Linux", "· Windows Server", "· Golang", "· Docker", "· Kubernetes", "· Python"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52740	backend	t
3326	F/W개발(MCU) (경력 11~15년)	원익피앤이	경기 수원시	경력 11~15년	["C", "· FW", "· MCU"]	D-19	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52496	other	t
3327	GUI S/W 설계,개발 채용(10년↑)	에이디티	경기 안산시	경력 10~14년	["Visual C++", "· C#", "· JavaScript", "· Linux", "· REST API"]	D-27	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53191	backend	t
3328	웹 그래픽(F/E) 개발자 (5년 ~ 10년)	데이터메이커	대전 유성구	경력 5~10년	["JavaScript", "· Babel", "· React", "· REST API", "· Nuxt.js", "· Webpack", "· HTML5"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51840	backend	t
3329	[보안AI사업본부] 백엔드 개발자_경력	딥노이드	서울 구로구	경력 8~10년	["Python", "· Kotlin", "· RDB", "· NoSql", "· Docker"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52101	backend	t
3330	백엔드 개발자 (7년 ~ 12년)	데이터메이커	대전 유성구	경력 7~12년	["Django", "· Django REST framework", "· MySQL", "· Rails", "· REST API", "· Node.js"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51835	backend	t
3331	DBA 담당(4~6년)	엑심베이	서울 구로구	경력 4~6년	["MySQL", "· Java", "· Slack", "· Linux", "· AWS", "· CentOS", "· DB", "· Oracle", "· Jira"]	D-12	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52281	backend	t
3332	WiFi Router개발 경력 1~5년	가온브로드밴드	경기 성남시	경력 1~5년	["C", "· Linux", "· C++", "· Embedded", "· Router", "· Network", "· Embedded Linux"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53242	other	t
3333	정보보안(관리)	미디어로그	서울 마포구	경력 10~15년	["ISMS", "· CPPG"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53276	other	t
3334	PG플랫폼 개발자	엑심베이	서울 구로구	경력 3~8년	["Java", "· Spring Framework", "· DB", "· Next.js", "· AI/인공지능", "· Refactor.io"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53288	backend	t
3335	[강남/선릉] DX 하드웨어 개발 경력	에스디티	서울 강남구	경력 2~10년	["MCU"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53290	other	t
3336	[강남/선릉] 소프트웨어 개발 경력	에스디티	서울 강남구	경력 5~10년	["C", "· C++", "· C#", "· Linux", "· Windows", "· Python"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53289	backend	t
3337	이리온 로봇 자율주행 SW 개발(서울)	폴라리스쓰리디	서울 용산구	경력 2~7년	["SW", "· C++", "· Linux", "· Git", "· Notion"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52684	other	t
3338	IoT Embedded FW Engineer	럭키박스솔루션	서울 서초구	경력 5~10년	["C++", "· FW", "· ARM", "· MCU", "· Embedded", "· Python", "· C", "· C#", "· RTOS"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52572	backend	t
3339	[SCK 및 관계사] Cloud 엔지니어 경력	에쓰씨케이	서울 강남구	경력 3~15년	["Azure DevOps", "· Azure DevOps Server", "· Azure Application Insights"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53137	backend	t
3340	풀스택 앱 개발 (경력 3~6년, 제주)	에이치비엠피	제주 제주시	경력 3~6년	["Angular 2", "· Node.js", "· React", "· MySQL", "· Linux", "· AWS", "· Git", "· REST API"]	D-12	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52221	backend	t
3341	RADAR 시험장비 SW	엠씨넥스	인천 연수구	경력 3~10년	["SW", "· C++", "· C", "· Embedded", "· Linux", "· MCU", "· RTOS", "· Verilog"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52580	other	t
3342	와이파이 H/W제품 개발 10~20년	에이치원래디오	경기 안양시	경력 10~20년	["Pads", "· HW", "· RF"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51705	other	t
3343	와이파이 H/W제품 개발 5~10년	에이치원래디오	경기 안양시	경력 5~10년	["Pads", "· HW", "· RF"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51706	other	t
3344	RADAR RF HW	엠씨넥스	인천 연수구	경력 5~12년	["HW", "· PCB", "· Verilog", "· C", "· C++", "· FPGA", "· MATLAB", "· RF"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52579	other	t
3345	[석사/경력]영상처리/rPPG 연구개발	바이오커넥트	서울 서초구	경력 1~10년	["OpenCV", "· DeepLearning", "· Python", "· Visual C++"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52395	backend	t
3346	HW 연구소 시스템개발2팀	엠씨넥스	인천 연수구	경력 13~20년	["HW", "· PCB", "· Verilog", "· C", "· C++", "· FPGA", "· MATLAB", "· RF"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52578	other	t
3347	풀스택 앱 개발 (경력 9~12년)	에이치비엠피	서울 구로구	경력 9~12년	["Angular 2", "· Node.js", "· React", "· MySQL", "· Linux", "· AWS", "· Git", "· REST API"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52214	backend	t
3348	백엔드 개발 (경력 11~15년)	에이치비엠피	서울 구로구	경력 11~15년	["GitHub", "· MySQL", "· Node.js", "· Amazon EC2", "· NGINX", "· React.js Boilerplate"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52218	backend	t
3349	모빌리티 Embedded SW 경력 개발자	아이비스	경기 수원시	경력 3~15년	["Linux", "· SW", "· C++", "· Python", "· Embedded", "· C", "· C#", "· Jira", "· RTOS"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52659	backend	t
3350	이리온 로봇 자율주행 SW 개발(포항)	폴라리스쓰리디	경북 포항시	경력 2~7년	["SW", "· C++", "· Linux", "· Git", "· Notion"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52262	other	t
3351	자율주행 로봇 개발자	베스텔라랩	대구 동구, 경기 안양시	경력 2~15년	["Python", "· Spring Framework", "· AWS", "· Git", "· iOS", "· ROS", "· R", "· SQL", "· C++"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53213	backend	t
3352	ERP/MES 개발자 및 PL 채용	이맥스하이텍	경기 남양주시	경력 4~15년	["Java", "· ERP", "· MES", "· C#", "· .NET", "· SW", "· JSP", "· MSSQL"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52273	backend	t
3353	[보안운영팀] 플랫폼 운영/개발 경력사원 채용	롯데이노베이트	서울 금천구	경력 4~5년	["JavaScript", "· SQL", "· Python"]	D-4	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53118	backend	t
3354	백엔드 개발 (경력 6~10년)	에이치비엠피	서울 구로구	경력 6~10년	["GitHub", "· MySQL", "· Node.js", "· Amazon EC2", "· NGINX", "· React.js Boilerplate"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52217	backend	t
3355	플랫폼개발팀 Backend 개발자 경력모집	이브릿지	서울 중구	경력 5~10년	["PHP", "· MySQL", "· Apache HTTP Server", "· REST API", "· HTML5", "· CSS 3"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52945	backend	t
3356	[보안사업팀] 보안솔루션 구축 경력사원 채용	롯데이노베이트	서울 금천구	경력 3~12년	["Network", "· ESET Endpoint Security"]	D-day	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53012	other	t
3357	[D&AX혁신팀] Data Scientist 경력사원 채용	롯데이노베이트	서울 금천구	경력 3~12년	["Python", "· SQL", "· BI"]	D-4	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53020	backend	t
3358	ERP/MES 개발자 및 PM 채용	이맥스하이텍	경기 남양주시	경력 5~15년	["Java", "· ERP", "· MES", "· C#", "· .NET", "· SW", "· JSP", "· MSSQL"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52275	backend	t
3359	3D 컴퓨터 비전 연구개발	마이공사	서울 서초구	경력 2~9년	["DeepLearning", "· AI/인공지능", "· Python", "· PyTorch", "· MachineLearning", "· C++"]	D-19	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52763	backend	t
3360	자율주행로봇 백엔드 엔지니어 (포항)	폴라리스쓰리디	경북 포항시	경력 5~8년	["Java", "· Spring Boot", "· REST API", "· MySQL", "· PostgreSQL", "· React", "· Vue.js"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53104	backend	t
3361	솔루션개발 및 구축 경력 채용 공고	아이브릭스	경기 성남시	경력 4~8년	["Elasticsearch", "· Node.js", "· React", "· Java", "· Spring"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51643	backend	t
3362	제조 자동화 로봇 DevOps 엔지니어	폴라리스쓰리디	경북 포항시	경력 3~8년	["Flutter"]	D-6	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51827	mobile	t
3363	[플랫폼 Biz팀] 플랫폼서비스 구축 PM 경력사원 채용	롯데이노베이트	서울 금천구	경력 10~18년	["AI/인공지능", "· AWS", "· GCP"]	D-4	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53023	data	t
3364	[박사]영상처리/rPPG 연구개발	바이오커넥트	서울 서초구	신입~10년	["OpenCV", "· DeepLearning", "· Python", "· Visual C++"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52396	backend	t
3365	[D&AX추진팀] AI Biz PM 경력사원 채용	롯데이노베이트	서울 금천구	경력 10~19년	["AI/인공지능"]	D-4	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53024	data	t
3366	의료기기 S/W 개발자(서울, 경력 7~10년)	프리시젼바이오	서울 서초구	경력 7~10년	["C"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53260	other	t
3367	PHP 풀스택 개발자	엠제이티	경기 광명시	경력 5~10년	["PHP", "· Redis", "· AWS", "· GitHub", "· DB"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52353	other	t
3368	[플랫폼Tech팀] 데이터플랫폼 엔지니어 경력사원 채용	롯데이노베이트	서울 금천구	경력 3~6년	["Kubernetes", "· Minio", "· Hive", "· PostgreSQL", "· Tableau", "· Superset"]	D-4	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53022	mobile	t
3369	[석사/신입]영상처리/rPPG 연구개발	바이오커넥트	서울 서초구	신입	["OpenCV", "· DeepLearning", "· Python", "· Visual C++"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52394	backend	t
3370	풀스택 앱 개발 (경력 7~10년, 제주)	에이치비엠피	제주 제주시	경력 7~10년	["Angular 2", "· Node.js", "· React", "· MySQL", "· Linux", "· AWS", "· Git", "· REST API"]	D-12	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52222	backend	t
3371	App(React Native) 개발자(전문연구요원가능)	베스텔라랩	대구 동구, 경기 안양시	경력 2~10년	["Python", "· Spring Framework", "· AWS", "· React", "· Git", "· GitHub", "· Linux", "· PHP"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53215	backend	t
3372	백엔드 서버 개발자 [경력 7년 이상]	아이피샵	서울 강남구	경력 7~10년	["Java", "· JSP", "· SQL", "· MySQL", "· MariaDB"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52361	backend	t
3373	프론트엔드 개발자	아이피샵	서울 강남구	경력 2~4년	["JavaScript", "· PHP"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52359	backend	t
3374	S/W 개발자 채용[신입]	건강누리	서울 영등포구	신입	["Android OS", "· iOS", "· Flutter"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51852	mobile	t
3375	개발팀(인공지능·머신러닝) 모집 (신입~3년)	리뷰닷컴	경기 화성시	신입~3년	["jQuery", "· Apache Tomcat", "· GitHub", "· JavaScript", "· Java", "· Linux", "· Spring"]	D-4	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51922	backend	t
3376	백엔드 서버 개발자 [경력 3년 이상]	아이피샵	서울 강남구	경력 3~6년	["Java", "· JSP", "· SQL", "· MySQL", "· MariaDB"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52360	backend	t
3377	광통신/정보통신 네트워크 엔지니어 채용	혜성테크윈	경기 성남시	신입	["Ccna", "· Ccnp", "· TCP/IP", "· Linux", "· Windows Server"]	D-day	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51636	backend	t
3378	국제 물류 시스템 백엔드 개발자	에이엘로지스틱스	서울 금천구	신입~3년	["Kotlin", "· MySQL", "· Node.js", "· TypeScript"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51787	backend	t
3379	웹 개발자 채용[신입]	건강누리	서울 영등포구	신입	["JavaScript", "· HTML5", "· Uniform CSS"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51683	backend	t
3380	플랫폼 개발자 채용공고	프로덕션고금	서울 영등포구	신입	["Python", "· Solidity", "· AWS", "· AZURE"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52414	backend	t
3381	국제 물류 시스템 프론트엔드 개발자	에이엘로지스틱스	서울 금천구	경력 1~4년	["JavaScript", "· HTML5", "· CSS 3"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51784	backend	t
3382	기업용 소프트웨어 개발 내부 개발자(재택근무)	권남테크	경기 성남시	경력 2년	["Python"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51739	backend	t
3383	웹 개발자 채용[대리]	건강누리	서울 영등포구	경력 1~5년	["JavaScript", "· HTML5", "· Uniform CSS"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51684	backend	t
3384	크로스플랫폼 앱 개발자 채용[신입]	건강누리	서울 영등포구	신입	["Android OS", "· iOS", "· Flutter"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51849	mobile	t
3385	워터마킹&CV 개발자	도브러너	서울 강남구	경력 3~8년	["FFMPEG", "· OpenCV", "· C", "· C++", "· Python"]	D-4	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51593	backend	t
3386	인메모리 엔진 개발자	미리비트	경기 성남시	경력 15~20년	["Spark", "· Scala", "· Kubernetes"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53040	mobile	t
3387	영상처리(Vision) S/W 개발 (5~7년)	쎄크	경기 수원시	경력 5~7년	["C++", "· C#", "· OpenCV", "· SW", "· HALCON"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51745	other	t
3388	PC 제어(시스템제어팀) (5~7년)	쎄크	경기 수원시	경력 5~7년	["C++", "· Mfc", "· SW", "· Embedded", "· C"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51742	other	t
3389	전장설계엔지니어 채용	EVAR	경기 성남시	경력 5~15년	["HW", "· PCB", "· FW"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52508	other	t
3390	유니티 게임개발 과정 교강사(경력)	경일게임아이티아카데미	서울 강동구	경력 1~30년	["Unity"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52472	other	t
3391	서버 개발자 (공동 및 사설 CA/RA)	한국전자인증	서울 서초구	경력 4~7년	["Linux", "· C++", "· C", "· Java", "· AWS", "· Oracle", "· MariaDB", "· Visual Studio", "· Eclipse"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53015	backend	t
3392	프론트엔드 엔지니어(경력 9~11년)	클래스101	서울 강남구	경력 9~11년	["React", "· TypeScript", "· GraphQL", "· Apollo", "· React Native"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52392	frontend	t
3393	MLOps Engineer	쓰리아이	서울 강남구	경력 1~20년	["Python", "· AWS", "· Docker", "· Kubeflow", "· Grafana"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53098	backend	t
3394	백엔드 엔지니어	프롬프트팩토리	경기 성남시	경력 3~7년	["Python", "· Java", "· AWS", "· FastAPI", "· Docker", "· React"]	D-4	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53255	backend	t
3395	언리얼 게임개발 과정 교강사(경력)	경일게임아이티아카데미	서울 강동구	경력 1~30년	["C++", "· Unreal Engine"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52471	other	t
3396	EV charger GUI 개발	피앤이시스템즈	경기 화성시	경력 10~14년	["Rust", "· GUI", "· C", "· C++", "· Python"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53168	backend	t
3397	펌웨어/플랫폼 개발(경력16~20년)	아세아텍	대구 달성군	경력 16~20년	["FW", "· C", "· HW"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52390	other	t
3398	전력전자 H/W 개발(1년~4년)	설텍	대구 달서구	경력 1~4년	["HW", "· Orcad"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51956	other	t
3399	웹 개발자 채용[과장]	건강누리	서울 영등포구	경력 6~12년	["JavaScript", "· HTML5", "· Uniform CSS"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51686	backend	t
3400	프론트엔드 개발자 (5년 이상)	버티컬바	서울 강남구	경력 5~10년	["React", "· JavaScript", "· RDB", "· NoSql", "· TypeScript", "· Datadog"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53087	backend	t
3401	AI 엔지니어 (5년 이상)	버티컬바	서울 강남구	경력 5~10년	["Python", "· PyTorch", "· TensorFlow", "· Transformers", "· AWS", "· GCP"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53086	backend	t
3403	클라우드 엔지니어 경력 채용(3년~5년)	디지털포토	서울 서초구	경력 3~5년	["CentOS", "· Linux", "· Apache HTTP Server", "· NGINX", "· Oracle"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52366	backend	t
3404	에이전시 PHP 백엔드 채용[과장]	코워커넷	서울 은평구	경력 6~10년	["PHP", "· MySQL", "· Laravel", "· Linux", "· MariaDB", "· REST API"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52352	backend	t
3405	펌웨어/플랫폼 개발(경력10~15년)	아세아텍	대구 달성군	경력 10~15년	["FW", "· C", "· HW"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52389	other	t
3406	고급 백엔드 설계 개발자(16~18년)	티투엘	경기 고양시	경력 16~18년	["Java"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52040	backend	t
3407	반도체비전 S/W 개발 경력 3년이상	이노비즈	경기 시흥시	경력 3~5년	["SW", "· C++", "· Visual C++", "· MachineLearning"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52565	mobile	t
3408	프론트엔드 개발(7~9년)	블링크큐벡스핀	경기 군포시	경력 7~9년	["JavaScript", "· PHP", "· Figma", "· HTML5", "· jQuery", "· CSS 3"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52678	backend	t
3409	FW개발 경력 채용(11~15년)	인엘씨테크놀러지	대전 유성구	경력 11~15년	["HW", "· FW", "· C", "· MCU", "· MATLAB", "· FPGA"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52451	other	t
3410	네트워크 엔지니어 경력(6~9년)	텐빌리언	서울 구로구	경력 6~9년	["Network"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52116	other	t
3411	클라우드 엔지니어 경력 채용(6년~8년)	디지털포토	서울 서초구	경력 6~8년	["CentOS", "· Linux", "· Apache HTTP Server", "· NGINX", "· Oracle"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52367	backend	t
3412	중급 백엔드 개발자 (5~7년)	티투엘	경기 고양시	경력 5~7년	["Java"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52035	backend	t
3413	전기,전자 소프트웨어 설계(10~14)	설텍	대구 달서구	경력 10~14년	["C", "· C++", "· SW", "· FPGA"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51964	other	t
3414	통신장비 연구개발 채용 - 주임/대리급	혜성테크윈	경기 성남시	경력 2~5년	["Ccna", "· Ccnp", "· Embedded", "· Network"]	D-day	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51637	other	t
3415	전력전자 H/W 개발(5년~9년)	설텍	대구 달서구	경력 3~9년	["HW", "· Orcad"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51957	other	t
3416	펌웨어/플랫폼 개발(경력3~9년)	아세아텍	대구 달성군	경력 3~9년	["FW", "· C", "· HW"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52388	other	t
3417	중급 백엔드 개발자 (8~10년)	티투엘	경기 고양시	경력 8~10년	["Java"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52036	backend	t
3418	웹 진단 모의해킹 (7~10년)	대진정보통신	서울 관악구	경력 7~10년	["Hack", "· Azure Security Center", "· ISMS", "· CISA", "· CISSP"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52197	other	t
3419	국제 물류 시스템 Sr.프론트엔드 개발자	에이엘로지스틱스	서울 금천구	경력 7~10년	["JavaScript", "· HTML5", "· CSS 3"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51785	backend	t
3420	펌웨어 개발자 채용[과장]	건강누리	서울 영등포구	경력 6~12년	["FW", "· C", "· C++", "· C#", "· SW", "· HW"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51860	other	t
3421	개발팀(인공지능·머신러닝) 모집 (4~6년)	리뷰닷컴	경기 화성시	경력 4~6년	["jQuery", "· Apache Tomcat", "· GitHub", "· JavaScript", "· Java", "· Linux", "· Spring"]	D-4	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51923	backend	t
3422	임베디드 소프트웨어 개발자 (Junior)	디엑스솔루션	경기 성남시	신입	["Spring Framework", "· AI/인공지능", "· C++", "· Linux", "· SW", "· Embedded Linux"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52863	backend	t
3423	인프라(시스템엔지니어) 개발자_6~10년	바텍	경기 화성시	경력 6~10년	["Kubernetes", "· GitHub", "· Jira", "· MongoDB", "· Grafana", "· Amazon EC2", "· Argo"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52996	backend	t
3424	[SW 개발] C++/C# 개발자 신입	파이	경기 수원시	신입	["C++", "· C#"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52128	other	t
3425	전기,전자 소프트웨어 설계(5년~9년)	설텍	대구 달서구	경력 5~9년	["C", "· C++", "· SW", "· MCU", "· RTOS", "· FPGA"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51963	other	t
3426	[EvryAI] AI 솔루션 개발자	에브리에이아이코리아	경기 성남시	경력 4~10년	["AI/인공지능", "· Linux", "· Docker", "· Python", "· Git", "· PyTorch", "· TensorFlow", "· NLP"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52991	backend	t
3427	크로스플랫폼 앱 개발자 채용[대리]	건강누리	서울 영등포구	경력 1~5년	["Android OS", "· iOS", "· Flutter"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51850	mobile	t
3428	[SW 개발] C++/C# 개발자 경력(5~7년)	파이	경기 수원시	경력 5~7년	["C++", "· C#"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52130	other	t
3429	프론트엔드 개발(13~15년)	블링크큐벡스핀	경기 군포시	경력 13~15년	["JavaScript", "· PHP", "· Figma", "· HTML5", "· jQuery", "· CSS 3"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52676	backend	t
3430	풀스택 초급 개발자	미조리장갑	경북 칠곡군	경력 2~4년	["Linux", "· React Router", "· SW", "· Embedded"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52782	frontend	t
3431	Principal Fullstack Engineer (풀스택)	버티컬바	서울 강남구	경력 5~10년	["Python", "· NoSql", "· RDB", "· GCP", "· Oracle", "· SAP"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53088	backend	t
3461	제어 컨트롤러 펌웨어 개발자 (7~10년)	유앤아이솔루션	경기 광주시	경력 7~10년	["C", "· C++", "· ARM", "· FPGA", "· Embedded"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53166	other	t
3432	모바일(안드로이드/iOS) 애플리케이션 개발	모빌리티네트웍스	경기 안양시	경력 10~20년	["Android OS", "· iOS", "· Kotlin", "· PHP-MVC", "· REST API", "· GraphQL", "· Jira", "· Git"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53007	mobile	t
3433	서비스 기획자 (PM, PO)	이노소니언	서울 서초구	경력 5~20년	["Jira", "· Notion", "· AWS", "· Git", "· REST API"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53051	other	t
3434	프론트엔드 개발자 (Next JS)_서울	뉴아이	서울 서초구	경력 3~15년	["HTML5", "· CSS 3", "· Java", "· JavaScript", "· TypeScript", "· Next.js"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53123	backend	t
3435	임베디드 개발자 채용 (신입)	넥스트테크	인천 연수구	신입~2년	["Arduino", "· Embedded", "· GNU Bash", "· C", "· C++"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52859	other	t
3436	Back-end 개발자 추가 모집	오투플러스	경기 용인시	경력 3~10년	["RDB", "· MySQL", "· RabbitMQ", "· PHP", "· Laravel", "· Elasticsearch"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53068	backend	t
3437	펌웨어 개발자 채용[신입]	건강누리	서울 영등포구	신입	["FW", "· C", "· C++", "· C#", "· SW", "· HW"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51858	other	t
3438	[SW 개발] C++/C# 개발자 경력(8~10년)	파이	경기 수원시	경력 8~10년	["C++", "· C#"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52131	other	t
3439	웹 진단 모의해킹 (3~6년)	대진정보통신	서울 관악구	경력 3~6년	["Hack", "· Azure Security Center", "· ISMS", "· CISA", "· CISSP"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52195	other	t
3440	쇼핑몰어드민PHP개발자 경력(10년이상)	텐빌리언	서울 구로구	경력 10~15년	["Git", "· AWS", "· PHP"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52737	other	t
3441	프론트엔드 개발자 경력(8~10년) 채용	세계입찰	경기 부천시	경력 8~10년	["HTML5", "· C", "· C#", "· JavaScript", "· Node.js"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52810	backend	t
3442	[SW 개발] C++/C# 개발자 경력(2~4년)	파이	경기 수원시	경력 2~4년	["C++", "· C#"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52129	other	t
3443	앱개발 프로그래머 경력(8~10년)채용	파이	경기 수원시	경력 8~10년	["OpenCV", "· Flutter", "· React", "· Swift", "· Android Studio", "· Xcode", "· Objective-C"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52127	frontend	t
3444	백엔드 경력 채용 (2~5년)	텐빌리언	서울 구로구	경력 2~5년	["Git", "· Spring Boot", "· DB"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52719	backend	t
3445	자동차 전기·전자 분야 개발/엔지니어링 6년↑	모빌리티네트웍스	경기 안양시	경력 6~15년	["HW", "· SW", "· Embedded", "· Jira", "· Confluence", "· C++", "· RTOS"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53006	other	t
3446	S/W 개발자 채용[대리]	건강누리	서울 영등포구	경력 1~5년	["Android OS", "· iOS", "· Flutter"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51855	mobile	t
3447	쇼핑몰 건강 헬스케어 서비스 개발자	세은바이오	강원 춘천시	경력 5~10년	["JavaScript", "· HTML5"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53171	backend	t
3448	인도 첸나이법인 IT팀장	GLOVIS INDIA ANANTAPUR PRIVATE LIMITED	기타	경력 5~13년	["Network", "· SAP"]	D-day	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52018	other	t
3449	전기,전자 소프트웨어 설계(1년~4년)	설텍	대구 달서구	경력 1~4년	["C", "· C++", "· SW", "· MCU", "· RTOS", "· FPGA"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51962	other	t
3450	에이전시 PHP 백엔드 채용[대리]	코워커넷	서울 은평구	경력 1~5년	["PHP", "· MySQL", "· Laravel", "· Linux", "· MariaDB", "· REST API"]	D-13	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52351	backend	t
3451	프론트엔드 개발 경력 (2~5년)	텐빌리언	서울 구로구	경력 2~5년	["JavaScript", "· HTML5"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52724	backend	t
3452	웹 프론트엔드 개발자(재택근무 가능)	캐치잇플레이	제주 제주시	경력 5~20년	["JavaScript", "· React", "· Vue.js"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52993	backend	t
3453	백엔드 개발자 (5년 이상)	포레스트디자인	광주 광산구	경력 5~10년	["Java", "· JavaScript", "· Jira", "· React", "· REST API"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53256	backend	t
3454	플랫폼 운영 및 개발 경력	에이엘로지스틱스	서울 금천구	신입	["Splunk"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51790	other	t
3455	풀스택 신입 개발자	미조리장갑	경북 칠곡군	신입	["Linux", "· React Router", "· SW", "· Embedded"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52785	frontend	t
3456	프론트엔드 개발자	오투플러스	경기 용인시	경력 3~10년	["Git", "· REST API", "· React", "· vuex", "· Vue.js", "· AngularJS"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53069	frontend	t
3457	Back-End 개발자 경력직원 채용 (1~3년)	리뷰닷컴	경기 화성시	경력 1~3년	["jQuery", "· Apache Tomcat", "· GitHub", "· JavaScript", "· Java", "· Linux", "· Spring"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53138	backend	t
3458	DBA 경력 직원 채용 (13~15년)	엘아이지시스템	서울 용산구	경력 13~15년	["SQL", "· Azure SQL Database", "· DB"]	D-7	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51942	data	t
3459	고급 백엔드 설계 개발자(13~15년)	티투엘	경기 고양시	경력 13~15년	["Java"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52039	backend	t
3460	Back-End 개발자 경력직원 채용 (4~6년)	리뷰닷컴	경기 화성시	경력 4~6년	["jQuery", "· Apache Tomcat", "· GitHub", "· JavaScript", "· Java", "· Linux", "· Spring"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53140	backend	t
3462	SW/임베디드 정규직 채용[경력]	네오티스	경기 안성시	경력 1~10년	["C", "· C++", "· HW", "· Embedded", "· SW"]	D-26	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53147	other	t
3463	S/W 개발자 채용[과장]	건강누리	서울 영등포구	경력 6~12년	["Android OS", "· iOS", "· Flutter"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51856	mobile	t
3464	백엔드 경력 채용 (10년 이상)	텐빌리언	서울 구로구	경력 10~15년	["Git", "· Spring Boot", "· DB"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52722	backend	t
3465	시니어 QA (재택근무 가능)	캐치잇플레이	제주 제주시	경력 5~20년	["QA", "· SW"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52992	other	t
3466	통신장비 연구개발 채용 - 팀장급	혜성테크윈	경기 성남시	경력 11~15년	["Ccna", "· Ccnp", "· Embedded", "· Network"]	D-day	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51639	other	t
3467	크로스플랫폼 앱 개발자 채용[과장]	건강누리	서울 영등포구	경력 6~12년	["Android OS", "· iOS", "· Flutter"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51851	mobile	t
3468	프론트엔드 개발자 경력(11~13년) 채용	세계입찰	경기 부천시	경력 11~13년	["HTML5", "· C", "· C#", "· JavaScript", "· Node.js"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52809	backend	t
3469	풀스택 중급 개발자	미조리장갑	경북 칠곡군	경력 5~7년	["Linux", "· React Router", "· SW", "· Embedded"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52783	frontend	t
3470	개발PM	오투플러스	경기 용인시	경력 10~15년	["React", "· Java", "· PHP", "· Docker", "· Redis Cloud"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53067	backend	t
3471	RADAR 알고리즘 SW	엠씨넥스	인천 연수구	경력 8~20년	["SW", "· C++", "· C", "· Embedded", "· Linux", "· MCU", "· RTOS", "· Verilog"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52582	other	t
3472	[SCK 및 관계사] Microsoft 제품교육 및 기술지원	에쓰씨케이	서울 강남구	경력 4~10년	["Microsoft Office 365", "· SW", "· AWS Copilot", "· GitHub Copilot"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52536	other	t
3473	풀스택 앱 개발 (경력 11~15년, 제주)	에이치비엠피	제주 제주시	경력 11~15년	["Angular 2", "· Node.js", "· React", "· MySQL", "· Linux", "· AWS", "· Git", "· REST API"]	D-12	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52223	backend	t
3474	[DOF] Algorithm SW Engineer	디오에프	서울 성동구	경력 7~15년	["CUDA", "· C++"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53041	backend	t
3475	Wi-Fi 소프트웨어 개발자 11~13년	에이치원래디오	경기 안양시	경력 11~13년	["Embedded Linux", "· C", "· L2"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51708	other	t
3476	3D Scan Engineer 경력 채용	디오에프	서울 성동구	경력 3~15년	["SW", "· C++", "· MachineLearning", "· OpenCV", "· PyTorch"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53044	mobile	t
3477	3차원 카메라 하드웨어 개발자(2~4)	클레	서울 성동구	경력 2~4년	["PCB", "· Orcad"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52869	other	t
3478	Wi-Fi 소프트웨어 개발자 8~10년	에이치원래디오	경기 안양시	경력 8~10년	["Embedded Linux", "· C", "· L2"]	D-1	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51709	other	t
3479	3차원 카메라 하드웨어 개발자(5~7)	클레	서울 성동구	경력 5~7년	["PCB", "· Orcad"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52870	other	t
3480	AI 카메라 임베디드 소프트웨어 엔지니어	슈프리마	경기 성남시	경력 1~10년	["C", "· C++"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52489	data	t
3481	Data Scientist in Financial (7~10년)	페니로이스	서울 종로구	경력 7~10년	["Python", "· R", "· BigData", "· MachineLearning"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52846	backend	t
3482	Touch Key/Sensor MCU 응용엔지니어	어보브반도체	서울 강남구	경력 3~6년	["C", "· C++", "· R", "· Android OS", "· MCU"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53003	mobile	t
3483	자율 점검드론/로봇 개발자 모집(4~6)	시에라베이스	울산 남구	경력 4~6년	["C++", "· Visual C++", "· C++ Builder", "· Python", "· ROS", "· Node.js", "· Java", "· Spring"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53061	backend	t
3484	자율 점검드론/로봇 개발자 모집(1~3)	시에라베이스	울산 남구	경력 1~3년	["C++", "· Visual C++", "· C++ Builder", "· Python", "· ROS", "· Node.js", "· Java", "· Spring"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53059	backend	t
3485	의료기기 S/W 개발자(서울, 경력 3~6년)	프리시젼바이오	서울 서초구	경력 3~6년	["C"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53259	other	t
3486	자율점검 드론/로봇 개발자(석사이상)	시에라베이스	울산 남구	신입	["C++", "· Visual C++", "· C++ Builder", "· Python", "· ROS", "· Node.js", "· Java", "· Spring"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53057	backend	t
3487	의료기기 S/W 개발자(대전, 경력 7~10년)	프리시젼바이오	대전 유성구	경력 7~10년	["C", "· C++", "· Mfc", "· Qt", "· Embedded Linux", "· Android OS", "· SQLite", "· Yocto"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53258	mobile	t
3488	하드웨어(H/W)개발자 채용(경력)	블루텍	대전 유성구	경력 1~15년	["SW", "· HW", "· C", "· Embedded Linux", "· Linux", "· Embedded", "· MCU", "· ARM"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52030	other	t
3489	[대전서구] 공공 SI 제안서 PM 모집 (10년~20년)	에스넷아이씨티	대전 서구	경력 10~20년	["Cisco", "· Network", "· Ccna", "· Ccnp"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52958	other	t
3490	3D Geometry SW Engineer 경력 채용	디오에프	서울 성동구	경력 1~15년	["SW", "· C++", "· 3D Rendering"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53043	other	t
3491	Data Scientist in Financial (4~6년)	페니로이스	서울 종로구	경력 4~6년	["Python", "· R", "· BigData", "· MachineLearning"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52845	backend	t
3492	[SDx플랫폼팀] 임베디드 SW 개발	슈어소프트테크	경기 성남시	경력 5~10년	["C", "· MCU", "· RTOS", "· Embedded", "· Linux"]	D-25	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53001	other	t
3493	자율 점검드론/로봇 개발자 모집(7~10)	시에라베이스	울산 남구	경력 7~10년	["C++", "· Visual C++", "· C++ Builder", "· Python", "· ROS", "· Node.js", "· Java", "· Spring"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53063	backend	t
3494	의료기기 S/W 개발자(대전, 경력 3~6년)	프리시젼바이오	대전 유성구	경력 3~6년	["C", "· C++", "· Mfc", "· Qt", "· Embedded Linux", "· Android OS", "· SQLite", "· Yocto"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53257	mobile	t
3495	임베디드소프트웨어개발(경력9~11)	아이도트	서울 송파구	경력 9~11년	["Embedded Linux", "· C", "· C++"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53157	other	t
3496	풀스택 고급 개발자	미조리장갑	경북 칠곡군	경력 8~10년	["Linux", "· React Router", "· SW", "· Embedded"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52784	frontend	t
3497	데이터분석가 경력(11~13년) 채용	세계입찰	경기 부천시	경력 11~13년	["Python", "· SQL", "· MySQL"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52812	backend	t
3498	반도체비전 S/W 개발 경력 6년이상	이노비즈	경기 시흥시	경력 6~9년	["SW", "· C++", "· Visual C++", "· MachineLearning"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52593	mobile	t
3499	FPGA개발 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["FPGA", "· C", "· C++", "· Cisco ISE", "· Embedded Linux", "· HW", "· Verilog", "· VHDL"]	D-19	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52638	data	t
3500	개발팀(인공지능·머신러닝) 모집 (7~10년)	리뷰닷컴	경기 화성시	경력 7~10년	["jQuery", "· Apache Tomcat", "· GitHub", "· JavaScript", "· Java", "· Linux", "· Spring"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53136	backend	t
3501	하드웨어 및 펌웨어 개발자	한솔리드텍	경기 의왕시	경력 3~5년	["C", "· C++", "· Linux", "· Orcad"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52526	other	t
3502	소프트웨어개발자 경력자 채용	라온솔루션	충북 청주시	경력 2~5년	["C", "· C++", "· C#", "· Windows", "· SW", "· Embedded", "· Embedded Linux"]	D-11	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51935	other	t
3503	반도체비전 S/W 개발 경력 10년이상	이노비즈	경기 시흥시	경력 10~13년	["SW", "· C++", "· Visual C++", "· MachineLearning"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52595	mobile	t
3504	하드웨어 및 펌웨어 개발자	한솔리드텍	경기 의왕시	경력 9~11년	["C", "· C++", "· Linux", "· Orcad"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52524	other	t
3505	PIA자격 필수/개인정보보호컨설팅(6~10)	대진정보통신	서울 관악구	경력 6~10년	["ISMS", "· CPPG"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52196	other	t
3506	정보보안 담당자 경력 채용	에프엘이에스	서울 강서구	경력 2~5년	["SecureCRT"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52641	other	t
3507	해외가상자산거래소 백엔드_13~15년	코베아그룹	서울 서초구	경력 13~15년	["Python", "· REST API", "· Git", "· AWS"]	D-2	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51700	backend	t
3508	Linux OS 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~6년	["Linux", "· Embedded", "· SW", "· Docker", "· Yocto", "· Qt"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52639	other	t
3509	FPGA 시니어급 채용(10~15년)	인엘씨테크놀러지	대전 유성구	경력 10~15년	["FPGA", "· Verilog"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52453	other	t
3510	하드웨어 및 펌웨어 개발자	한솔리드텍	경기 의왕시	경력 6~8년	["C", "· C++", "· Linux", "· Orcad"]	D-15	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52525	other	t
3511	통신장비 연구개발 채용 - 과장급	혜성테크윈	경기 성남시	경력 6~10년	["Ccna", "· Ccnp", "· Embedded", "· Network"]	D-day	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51638	other	t
3512	PIA자격 필수/개인정보보호컨설팅(1~5)	대진정보통신	서울 관악구	경력 1~5년	["ISMS", "· CPPG"]	D-9	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52194	other	t
3513	전력전자 H/W 개발(10년~14년)	설텍	대구 달서구	경력 10~14년	["HW", "· Orcad"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51958	other	t
3514	프론트엔드 개발 경력 (6~9년)	텐빌리언	서울 구로구	경력 6~9년	["JavaScript", "· HTML5"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52725	backend	t
3515	평촌 LG U+ IDC 네트워크 운영자	렉스시스템	경기 안양시	경력 2~5년	["Cisco", "· GraphQL Nexus"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53161	other	t
3516	CXK(Citrix) NetScaler TS엔지니어	나무기술	서울 강서구	경력 4~10년	["Citrix Gateway", "· VPN", "· L7"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53090	other	t
3517	펌웨어 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["C++", "· VHDL", "· Python", "· MATLAB", "· Git", "· FW"]	D-5	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51540	backend	t
3518	데이터분석가 경력(5~7년) 채용	세계입찰	경기 부천시	경력 5~7년	["Python", "· SQL", "· MySQL"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52814	backend	t
3519	임베디드 개발자 채용 (경력)	넥스트테크	인천 연수구	경력 3~10년	["Arduino", "· Embedded", "· GNU Bash", "· C", "· C++"]	D-20	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52860	other	t
3549	펌웨어 개발자 채용[대리]	건강누리	서울 영등포구	경력 1~5년	["FW", "· C", "· C++", "· C#", "· SW", "· HW"]	D-3	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51859	other	t
3520	AI 연구개발 경력직원 채용 (7년 이상)	에이치비솔루션	경기 성남시	경력 7~10년	["DeepLearning", "· AI/인공지능", "· SW", "· HW", "· Algolia"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53235	backend	t
3521	S/W 신입 개발자	미조리장갑	경북 칠곡군	신입	["Linux", "· React Router", "· SW", "· Embedded"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53264	frontend	t
3522	FPGA 시니어급 채용 (16~20년)	인엘씨테크놀러지	대전 유성구	경력 16~20년	["FPGA", "· Verilog"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52455	other	t
3523	알고리즘 개발자 경력직 채용	에프엘이에스	대전 유성구	경력 2~5년	["Slim", "· Keras", "· TensorFlow", "· Java", "· Node.js"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53093	backend	t
3524	전기,전자 하드웨어 설계(1년~4년)	설텍	대구 달서구	경력 1~4년	["HW", "· Embedded Linux", "· MCU", "· SW", "· RTOS", "· FPGA", "· Embedded"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51959	other	t
3525	네트워크 엔지니어 경력(2~5년)	텐빌리언	서울 구로구	경력 2~5년	["Network"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52117	other	t
3526	프론트엔드 개발 경력 (10년 이상)	텐빌리언	서울 구로구	경력 10~13년	["JavaScript", "· HTML5"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52732	backend	t
3527	클라우드 엔지니어 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["AZURE", "· GCP", "· AWS", "· DB", "· BigData", "· MachineLearning", "· MySQL", "· Redis"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52535	mobile	t
3528	전기,전자 하드웨어 설계(5년~9년)	설텍	대구 달서구	경력 5~9년	["HW", "· Embedded Linux", "· MCU", "· SW", "· RTOS", "· FPGA", "· Embedded"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51960	other	t
3529	프론트엔드 개발(10~12년)	블링크큐벡스핀	경기 군포시	경력 10~12년	["JavaScript", "· PHP", "· Figma", "· HTML5", "· jQuery", "· CSS 3"]	D-16	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52677	backend	t
3530	쇼핑몰 어드민 PHP개발자 경력(2~5년)	텐빌리언	서울 구로구	경력 2~5년	["Git", "· AWS", "· PHP"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52734	other	t
3531	인프라(시스템엔지니어) 개발자_11년↑	바텍	경기 화성시	경력 11~20년	["Kubernetes", "· GitHub", "· Jira", "· MongoDB", "· Grafana", "· Amazon EC2", "· Argo"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52997	backend	t
3532	S/W 고급 개발자	미조리장갑	경북 칠곡군	경력 8~10년	["Linux", "· React Router", "· SW", "· Embedded"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53263	frontend	t
3533	프론트엔드 개발자 경력(5~7년) 채용	세계입찰	경기 부천시	경력 5~7년	["HTML5", "· C", "· C#", "· JavaScript", "· Node.js"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52811	backend	t
3534	자동차 전기·전자 분야 개발/엔지니어링 3년↑	모빌리티네트웍스	경기 안양시	경력 3~5년	["HW", "· SW", "· Embedded", "· Jira", "· Confluence", "· C++", "· RTOS"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53005	other	t
3535	데이터베이스(DB) 개발	모빌리티네트웍스	경기 안양시	경력 10~20년	["SQL", "· NoSql", "· MySQL", "· Oracle", "· Azure DevOps", "· AWS", "· GCP", "· AZURE"]	D-23	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53008	data	t
3536	AI 연구개발 경력직원 채용 (3년 이상)	에이치비솔루션	경기 성남시	경력 3~6년	["DeepLearning", "· AI/인공지능", "· SW", "· HW", "· Algolia"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53234	backend	t
3537	S/W 중급 개발자	미조리장갑	경북 칠곡군	경력 5~7년	["Linux", "· React Router", "· SW", "· Embedded"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53262	frontend	t
3538	백엔드 경력 채용 (6~9년)	텐빌리언	서울 구로구	경력 6~9년	["Git", "· Spring Boot", "· DB"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52721	backend	t
3539	보안 솔루션 엔지니어 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["Java", "· Oracle", "· SQL", "· MariaDB", "· C++", "· Linux", "· Windows"]	D-18	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52533	backend	t
3540	회로설계 경력 엔지니어[경력 6~10년]	유버	경기 안산시	경력 6~10년	["Orcad", "· Pads", "· PCB"]	D-10	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52179	other	t
3541	쇼핑몰 어드민 PHP개발자 경력(6~9년)	텐빌리언	서울 구로구	경력 6~9년	["Git", "· AWS", "· PHP"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52736	other	t
3542	데이터분석가 경력(8~10년) 채용	세계입찰	경기 부천시	경력 8~10년	["Python", "· SQL", "· MySQL"]	D-17	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52813	backend	t
3543	인프라 엔지니어 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["Docker", "· TypeScript", "· AWS", "· AZURE", "· GCP", "· Solidity", "· Hyperledger Indy"]	D-21	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52706	frontend	t
3544	인프라(시스템엔지니어) 개발자_3~5년	바텍	경기 화성시	경력 3~5년	["Kubernetes", "· GitHub", "· Jira", "· MongoDB", "· Grafana", "· Amazon EC2", "· Argo"]	D-22	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52995	backend	t
3545	제어 컨트롤러 펌웨어 개발자 (3~6년)	유앤아이솔루션	경기 광주시	경력 3~6년	["C", "· C++", "· ARM", "· FPGA", "· Embedded"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53165	other	t
3546	S/W 초급 개발자	미조리장갑	경북 칠곡군	경력 2~4년	["Linux", "· React Router", "· SW", "· Embedded"]	D-28	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53261	frontend	t
3547	서비스플랫폼 백엔드 개발자	우리의이야기	서울 강남구	경력 3~5년	["React", "· Node.js", "· Rust"]	D-30	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53237	backend	t
3548	FW개발 경력 채용(6~10년)	인엘씨테크놀러지	대전 유성구	경력 6~10년	["HW", "· FW", "· C", "· MCU", "· MATLAB", "· FPGA"]	D-14	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/52450	other	t
3550	전기,전자 하드웨어 설계(10년~14년)	설텍	대구 달서구	경력 10~14년	["HW", "· Embedded Linux", "· MCU", "· SW", "· RTOS", "· FPGA", "· Embedded"]	D-8	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/51961	other	t
3551	농진청 응용 SW 개발자 (AI)	렉스시스템	전북 전주시	경력 3~10년	["AI/인공지능", "· Kubernetes", "· Elasticsearch"]	D-24	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53162	mobile	t
3552	데이터허브 개발 리더(7~9년)	디토닉	경기 성남시	경력 7~9년	["Java", "· Kotlin", "· Linux", "· Spring Boot", "· Mybatis", "· BigData", "· Ambari", "· Python"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53273	backend	t
3553	데이터허브 개발 리더(13~15년)	디토닉	경기 성남시	경력 13~15년	["Java", "· Kotlin", "· Linux", "· Spring Boot", "· Mybatis", "· BigData", "· Ambari", "· Python"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53275	backend	t
3554	데이터허브 개발 리더(10~12년)	디토닉	경기 성남시	경력 10~12년	["Java", "· Kotlin", "· Linux", "· Spring Boot", "· Mybatis", "· BigData", "· Ambari", "· Python"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53274	backend	t
3555	ktds 인프라 자동화 파트 개발자	렉스시스템	서울 서초구	경력 7~10년	["Python", "· TypeScript", "· Node.js", "· Vue.js", "· AWS CodeCommit", "· Docker"]	D-29	https://jumpit.saramin.co.krhttps://jumpit.saramin.co.kr/position/53291	backend	t
\.


--
-- Data for Name: resumes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resumes (resume_id, user_id, file_path, extracted_keywords, job_category, created_at) FROM stdin;
\.


--
-- Data for Name: roadmaps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roadmaps (roadmap_id, user_id, resume_id, generated_roadmap, similarity_score, target_job_category, created_at) FROM stdin;
\.


--
-- Data for Name: tech_trends; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tech_trends (trend_id, keyword, job_category, count, trend_date, created_at) FROM stdin;
\.


--
-- Data for Name: user_favorite_posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_favorite_posts (favorite_job_id, user_id, job_post_id, created_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, social_provider, social_id, email, name, profile_image, is_active, created_at) FROM stdin;
2	google	100376111963179056395	wodnd992362@gmail.com	최재웅	https://lh3.googleusercontent.com/a/ACg8ocIUxKMPTSud_WYECFfCpj_eFwsYbwUHFzlazHILDQ0jgea4Mg=s96-c	t	2025-06-18 16:03:19.191333
6	google	existing_google_id	exist@example.com	기존구글		t	2025-06-18 17:23:26.666821
7	kakao	existing_kakao_id	existkakao@example.com	기존카카오		t	2025-06-18 17:23:26.690944
8	naver	existing_naver_id	existnaver@example.com	기존네이버		t	2025-06-18 17:23:26.710891
3	google	mocked_google_id_12345	googleuser1@example.com	구글 사용자 수정됨(1)	http://google.image.url/updated.png(1)	t	2025-06-18 16:59:20.794846
9	naver	cF71_zAc3Y5xQMfkxlPX71HDhPBUdCOUSXWMwpmbrgo	wodnd992362@naver.com	최재웅	\N	t	2025-06-19 16:26:52.096899
10	kakao	4312219058	4312219058@kakao.com	최재웅	http://k.kakaocdn.net/dn/bGfFxv/btsOyroFwEz/btHftGztUYLqMKkoQvP0v1/img_640x640.jpg	t	2025-06-19 16:49:37.039208
21	naver	naver_mock_id_123	naveruser@example.com	네이버 유저	http://naver.image	t	2025-06-23 12:33:54.954562
22	google	google_user_12345	testuser@example.com	테스트 사용자	http://example.com/profile.jpg	t	2025-06-23 12:33:58.126711
23	kakao	98765	kakao_user@example.com	카카오유저	http://kakao.image	t	2025-06-23 12:34:01.213547
\.


--
-- Name: jumpit_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jumpit_jobs_id_seq', 3555, true);


--
-- Name: resumes_resume_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.resumes_resume_id_seq', 1, false);


--
-- Name: roadmaps_roadmap_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roadmaps_roadmap_id_seq', 1, false);


--
-- Name: tech_trends_trend_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tech_trends_trend_id_seq', 1, false);


--
-- Name: user_favorite_posts_favorite_job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_favorite_posts_favorite_job_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 23, true);


--
-- Name: jobs jumpit_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jumpit_jobs_pkey PRIMARY KEY (job_post_id);


--
-- Name: jobs jumpit_jobs_url_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jumpit_jobs_url_key UNIQUE (url);


--
-- Name: resumes resumes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resumes
    ADD CONSTRAINT resumes_pkey PRIMARY KEY (resume_id);


--
-- Name: roadmaps roadmaps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roadmaps
    ADD CONSTRAINT roadmaps_pkey PRIMARY KEY (roadmap_id);


--
-- Name: tech_trends tech_trends_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tech_trends
    ADD CONSTRAINT tech_trends_pkey PRIMARY KEY (trend_id);


--
-- Name: user_favorite_posts uq_favorite; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_favorite_posts
    ADD CONSTRAINT uq_favorite UNIQUE (user_id, job_post_id);


--
-- Name: user_favorite_posts user_favorite_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_favorite_posts
    ADD CONSTRAINT user_favorite_posts_pkey PRIMARY KEY (favorite_job_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_social_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_social_id_key UNIQUE (social_id);


--
-- Name: resumes resumes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resumes
    ADD CONSTRAINT resumes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: roadmaps roadmaps_resume_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roadmaps
    ADD CONSTRAINT roadmaps_resume_id_fkey FOREIGN KEY (resume_id) REFERENCES public.resumes(resume_id);


--
-- Name: roadmaps roadmaps_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roadmaps
    ADD CONSTRAINT roadmaps_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: user_favorite_posts user_favorite_posts_job_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_favorite_posts
    ADD CONSTRAINT user_favorite_posts_job_post_id_fkey FOREIGN KEY (job_post_id) REFERENCES public.jobs(job_post_id);


--
-- Name: user_favorite_posts user_favorite_posts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_favorite_posts
    ADD CONSTRAINT user_favorite_posts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

