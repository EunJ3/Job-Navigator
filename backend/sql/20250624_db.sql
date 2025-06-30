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
    job_type character varying
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

COPY public.jobs (job_post_id, title, company, location, experience, tech_stack, due_date_text, url, job_type) FROM stdin;
732	React-Native 스태프 엔지니어 채용	알로카도스	서울 강남구	경력 5~15년	["JavaScript", "Kotlin", "TypeScript", "iOS"]	마감 기한: D-1	https://jumpit.saramin.co.kr/position/49893	frontend
791	DBA	디어유	서울 강남구	경력 5~10년	["AWS", "NoSql", "MySQL"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51346	devops
802	Backend Engineer (Backend 엔지니어)	메이아이	서울 강남구	경력 1~3년	["FastAPI", "Django", "PostgreSQL", "MySQL"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49943	backend
825	AI 엔지니어	바로팜	서울 강남구	경력 3~10년	["DeepLearning", "Python"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50873	data
837	자율주행 임베디드 SW 엔지니어(전문연 지원 가능)	에이스웍스코리아	서울 강남구	신입~7년	["C", "Python", "Embedded", "FW", "ethernet"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50700	embedded
907	네트워크 엔지니어 정규직 채용	링네트	서울 구로구	경력 2~8년	["Network", "L2", "L3", "L4", "L7", "Router"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50485	other
946	AI Engineer	코넥티브	서울 강남구	신입~5년	["Python", "PyTorch", "OpenCV"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/51086	data
943	SI 개발 PM	미디어로그	서울 마포구	경력 8~10년	["Java", "Node.js", "Vue.js", "Oracle", "MySQL"]	마감 기한: D-7	https://jumpit.saramin.co.kr/position/50146	backend
944	헬스케어 시스템 개발자(DB개발자)	엘리오앤컴퍼니	서울 강남구	경력 5~12년	["Oracle", "SQL", "MSSQL", "AWS"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50120	devops
945	Backend Engineer (Java/Kotlin)	센트비	서울 영등포구	경력 4~13년	["Kotlin", "Java", "Spring Boot"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50707	backend
979	SAP Project Manager 모집	지에스아이티엠	서울 종로구	경력 7~20년	["SAP", "ERP"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50775	other
1087	통합보안관리 엔지니어(신입)	이너버스	서울 영등포구	신입~2년	["SW", "Linux", "Docker", "Elasticsearch"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50496	devops
1122	안드로이드 개발자(경력)	레트리카	서울 서초구	경력 2~5년	["Java", "Gradle", "MVVM", "RxJava", "Realm"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/51411	other
1123	Sr. AI & Data Analysis Specialist(5~10y)	피엠인터내셔널코리아	서울 영등포구	경력 5~10년	["SQL", "NoSql", "Tableau", "AWS", "AZURE"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50982	devops
1976	중급 백엔드 개발자 (5~7년)	티투엘	경기 고양시	경력 5~7년	["Java"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50168	backend
1252	FPGA개발 신입 채용	에프엘이에스	서울 강서구	신입	["FPGA", "C", "C++", "Cisco ISE"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/50585	other
1263	[박사]영상처리/rPPG 연구개발	바이오커넥트	서울 서초구	신입~10년	["OpenCV", "DeepLearning", "Python"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50385	other
1267	백엔드 개발자	버추얼랩	서울 성동구	경력 5~10년	["Django", "Backendless"]	마감 기한: D-3	https://jumpit.saramin.co.kr/position/50010	backend
1299	DevOps 엔지니어 채용 (4년 이상)	싸이터	서울 금천구	경력 4~12년	["Kubernetes", "Kafka", "Redis"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51276	devops
1300	Flutter 프론트엔드 개발자 채용	서울거래	서울 영등포구	경력 3~99년	["Flutter", "REST API", "Git", "MVVM", "Dart"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51535	frontend
1335	카카오/네이버 연계시스템 서버 개발자	비즈톡	서울 강남구	경력 5~10년	["Git", "Spring Boot", "REST API", "Linux"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51056	backend
1336	백앤드 개발(11-15년)	더블유닷에이아이	서울 서초구	경력 11~15년	["MySQL", "Spring Boot", "Java"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51420	backend
1480	Quality Engineer(신입 ~ 4년 경력)	뷰런테크놀로지	서울 서초구	신입~4년	["QA", "Linux", "C", "C++", "Python"]	마감 기한: D-30	https://jumpit.saramin.co.kr/position/51613	qa
1489	ABAP 개발	웅진	서울 중구	경력 3~20년	["SAP", "ABAP", "SQL"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49902	other
1515	전산실 SAP SD 운영 신입 채용	벨아이앤에스	서울 서대문구	신입	["ABAP", "SQL", "SAP"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50422	other
1551	개발 팀장 모집(경력5~7년)	데이터누리	서울 강서구	경력 5~7년	["Java", "JavaScript"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51242	frontend
731	Software QA Engineer	이마고웍스	서울 강남구	경력 3~5년	["QA"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50676	qa
1658	[WBCT] 정형외과용 3D뷰어 SW 개발	덴티움	경기 수원시	경력 3~7년	["c", "c++", "c#", "OpenGL", "WPF"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50735	other
1766	Physical Design Engineer	보스반도체	경기 성남시	경력 3~15년	["ASIC"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/50105	other
1802	AI 테스트 도구 UI 개발	슈어소프트테크	경기 성남시	경력 2~8년	["AI/인공지능", "React", "FastAPI", "Flask"]	마감 기한: D-27	https://jumpit.saramin.co.kr/position/51363	backend
1803	실내 내비게이션 연구/개발(전문연구요원가능)	베스텔라랩	대구 동구, 경기 안양시	신입~10년	["Python", "Spring Framework", "AWS"]	마감 기한: D-26	https://jumpit.saramin.co.kr/position/51256	backend
1804	영상처리(Vision) S/W 개발 (2~4년)	쎄크	경기 수원시	경력 2~4년	["C++", "C#", "OpenCV", "SW", "HALCON"]	마감 기한: D-1	https://jumpit.saramin.co.kr/position/49843	other
1840	윈도우 클라이언트 개발 및 유지보수	지니언스	경기 안양시	경력 1~5년	["C", "C++", "Windows"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50597	other
1841	IT운영	유비퍼스트대원	경기 성남시	경력 3~10년	["AWS", "Kafka", "Amazon EKS", "DB", "Oracle"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51201	devops
1843	반도체설비제어 SoftwarePlatform 개발(분당)	한국알박	경기 성남시	경력 10~20년	["SW", "C#"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50617	robotics
1844	Frontend developer	유비퍼스트대원	경기 성남시	경력 4~10년	["Java", "Kotlin", "Spring Boot", "CSS 3"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51198	backend
1877	Cloud Security Engineer(10년~)	한화비전	경기 성남시	경력 10~12년	["ISMS", "AWS", "AZURE", "Firewall", "IPS"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50243	devops
1878	GSC EDR IoC 및 악성코드 분석	지니언스	경기 안양시	신입~5년	["PowerShell", "ScriptRock"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50591	pm
1950	주차장 개발자(Mobility Hub Platform)	하이파킹	경기 성남시	신입~20년	["Azure DevOps"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51354	devops
2136	[경력] 백엔드 개발자 (울산, 11년↑)	엔엑스	울산 울주군	경력 11~15년	["Node.js", "MongoDB", "AWS", "Docker"]	마감 기한: D-29	https://jumpit.saramin.co.kr/position/51619	backend
2138	SW 개발 PM(Project Manager) 대리급	팜클	강원 횡성군	경력 5~8년	["Python", "AWS", "Git", "iOS", "Linux"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51414	mobile
1278	플러터 프론트 APP 개발[신입]	패션앤스타일컴퍼니	서울 종로구	신입~2년	["Flutter", "iOS", "Android", "GitHub", "Git"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50281	mobile
1306	[계약직] Flutter & node.js 경력 개발자 채용	인졀미	서울 서초구	경력 5~20년	["Flutter", "iOS", "Android"]	마감 기한: D-27	https://jumpit.saramin.co.kr/position/51474	backend
1322	http/proxy 개발자	프라이빗테크놀로지	서울 마포구	경력 7~15년	["Android", "Java", "Kotlin", "MVVM", "Git"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/49925	mobile
1345	[경력직] Flutter 앱 & Node.js 개발자	인졀미	서울 서초구	경력 5~20년	["Flutter", "iOS", "Android"]	마감 기한: D-27	https://jumpit.saramin.co.kr/position/51473	backend
1368	모바일/웹 클라이언트 개발자 채용	스쿨버스	서울 강서구	경력 1~9년	["Flutter", "iOS", "Android", "Dart"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/50032	mobile
1510	앱 개발자 경력 채용 (10년이상)	텐빌리언	서울 구로구	경력 10~15년	["Android", "REST API", "React", "iOS"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50253	frontend
1518	앱 개발자 경력 채용 (2~5년)	텐빌리언	서울 구로구	경력 2~5년	["Android", "REST API", "React", "iOS"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50251	frontend
1643	안드로이드 개발 (3년 이상)	마카롱팩토리	경기 성남시	경력 3~10년	["Android", "Java", "Kotlin", "Realm"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/51099	mobile
1657	QA 엔지니어 (2년 이상)	마카롱팩토리	경기 성남시	경력 2~5년	["Android", "iOS", "QA", "Postman"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/51096	mobile
1797	임베디드 SW 개발자(리눅스/안드로이드) 개발자	슈프리마	경기 성남시	경력 5~10년	["C", "C++", "Android", "iOS", "Java"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50345	mobile
1836	앱 개발자 (신입)	알비에치	경기 안양시	신입	["Flutter", "Android", "iOS", "REST API"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/51000	mobile
1837	Mobile App 개발자	더블티	경기 수원시	신입	["Flutter", "REST API", "iOS", "Android"]	마감 기한: D-26	https://jumpit.saramin.co.kr/position/51440	mobile
1839	앱 개발자 (고급)	알비에치	경기 안양시	경력 7~10년	["Flutter", "Android", "iOS", "REST API"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50998	mobile
1842	Android OS 개발 병역특례	엔티엘헬스케어	경기 성남시	신입	["Android", "iOS"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51422	mobile
733	PHP 웹개발자 채용 (경력 6~8년)	엠투피아이	서울 성동구	경력 6~8년	["PHP", "MySQL", "Apache Tomcat", "Linux"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/49789	design
734	백엔드 엔지니어	스패로우	서울 마포구	경력 5~10년	["Redis", "Java", "SQL", "AWS", "RDB"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/50818	backend
735	PHP 웹개발자 채용 (경력 3~5년)	엠투피아이	서울 성동구	경력 3~5년	["PHP", "MySQL", "Apache Tomcat", "Linux"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/49788	design
736	서버/백엔드 개발자	언더라이터	서울 마포구	경력 5~15년	["Kotlin", "Spring Boot", "AWS", "GitHub"]	마감 기한: D-1	https://jumpit.saramin.co.kr/position/49889	backend
737	프라이빗 클라우드 제품 개발	파이오링크	서울 금천구	신입~20년	["Linux", "Python", "C", "Golang", "Ansible"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50418	backend
738	백엔드 개발자 채용 (5년 이상)	싸이터	서울 금천구	경력 5~12년	["Spring Boot", "Kubernetes", "MySQL"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51275	backend
739	[코스닥상장사] iOS 앱 개발자 채용	디어유	서울 강남구	경력 5~10년	["iOS", "Swift", "Objective-C", "REST API"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50635	mobile
740	브랜다즈 백엔드개발자(자바/코틀린)	헤렌	서울 성동구	경력 3~15년	["Java", "Kotlin", "Spring Boot", "Mybatis"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49842	backend
741	헬스케어 소프트웨어 백엔드 개발자 (경력직)	탈로스	서울 강남구	경력 1~5년	["Python", "FastAPI", "MySQL", "Docker"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51421	backend
742	블록체인 엔지니어 채용	알로카도스	서울 강남구	경력 3~10년	["Blockchain", "Solidity", "Rust", "Python"]	마감 기한: D-1	https://jumpit.saramin.co.kr/position/49890	data
743	소프트웨어 엔지니어 (Backend)	사각	서울 마포구	경력 1~8년	["Django", "FastAPI", "NestJS", "PostgreSQL"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50843	backend
744	프론트엔드 개발 (3년 이상)	하이테커	서울 성동구	경력 3~5년	["Git", "TypeScript", "React", "Next.js"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50832	frontend
745	AI솔루션 개발자(경력 5~10년)	엠로	서울 영등포구	경력 3~10년	["Java", "JavaScript", "Spring Framework"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51083	backend
746	백엔드 개발자	가우디오랩	서울 강남구	경력 3~8년	["Spring Boot", "RDB", "SQL"]	마감 기한: D-3	https://jumpit.saramin.co.kr/position/51152	backend
747	AI 국제 물류 스타트업 ITOps 개발자	아로아랩스	서울 마포구	신입~4년	["C#", "AZURE", "Go", "GORM"]	마감 기한: D-27	https://jumpit.saramin.co.kr/position/51349	backend
748	솔루션운영 엔지니어	로민	서울 서초구	경력 1~15년	["Python", "Java", "PostgreSQL", "NGINX"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51268	pm
749	컴퓨터비전 엔지니어 채용	쉬모스랩	서울 강남구	경력 2~7년	["Docker", "Linux", "Git", "gRPC", "SQL"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50691	devops
750	빅데이터 엔진 개발	에스티씨랩	서울 강남구	경력 3~5년	["Go", "Python", "Java", "JavaScript", "TCP/IP"]	마감 기한: D-1	https://jumpit.saramin.co.kr/position/49865	backend
752	리눅스 C / C++ 서버 개발자	코닉글로리	서울 강남구	경력 2~15년	["C", "C++", "Linux", "TCP/IP", "Shell"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/51088	backend
753	AI 백엔드 시스템 엔지니어 채용	쉬모스랩	서울 강남구	경력 2~7년	["SQL", "PostgreSQL", "Python"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50693	backend
754	Windows 개발자	펜타시큐리티	서울 영등포구	경력 2~5년	["C#", "C++", "C", "Visual Studio"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51277	other
755	IT/AI부문(전문연구요원 포함)경력(1~3)	연합인포맥스	서울 종로구	경력 1~3년	["AI/인공지능", "TypeScript", "Next.js"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51368	frontend
756	[IT Infra]IT Administrative Engineer	오픈엣지테크놀로지	서울 강남구	경력 1~14년	["Shell", "Docker", "Kubernetes", "Jenkins"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50491	devops
757	APLUS AI_검색&추천_백엔드 엔지니어	버즈니	서울 관악구	경력 1~10년	["Python", "AWS", "Amazon EKS"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51175	backend
758	AI 국제 물류 스타트업 프론트엔드 개발자	아로아랩스	서울 마포구	경력 1~10년	["GitHub", "Visual Studio Code", "JavaScript"]	마감 기한: D-27	https://jumpit.saramin.co.kr/position/51348	frontend
759	프론트엔드 개발자	넥써쓰	서울 강남구	경력 3~11년	["Blockchain", "React Native", "Next.js"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/50004	frontend
760	네트워크 기획, 운영 담당	팬택씨앤아이	서울 영등포구	경력 3~10년	["Cisco", "Firewall", "IPS", "VPN", "L2", "L3", "L4"]	마감 기한: D-20	https://jumpit.saramin.co.kr/position/51214	pm
761	프라이빗 클라우드 제품 개발- 전문연구요원	파이오링크	서울 금천구	신입~20년	["Linux", "Python", "C", "Golang", "Ansible"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50419	backend
762	[DRAM PHY]SiliconValidation Engineer	오픈엣지테크놀로지	서울 강남구	경력 2~15년	["C", "Python"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50487	other
763	소프트웨어 엔지니어(AI)	사각	서울 마포구	경력 1~8년	["Svelte", "FastAPI", "Python", "AI/인공지능"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50844	backend
764	이기종 방화벽 정책관리 솔루션 개발자	위드네트웍스	서울 강서구	경력 5~10년	["Git", "MongoDB", "Docker", "Linux"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50244	backend
765	네트워크장비 Web Management 솔루션개발	파이오링크	서울 금천구	경력 3~12년	["Python", "C", "C++", "Linux", "AWS"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/51021	devops
766	데이터 엔지니어 (데이터레이크 개발)	스패로우	서울 마포구	경력 5~10년	["PostgreSQL", "Kubernetes", "Docker"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/50816	devops
767	솔루션 프론트엔드 개발자 계약직 (정규직 전환) 경력자 채용	하이케어넷	서울 송파구	경력 4~8년	["React", "NestJS", "TypeORM", "TypeScript"]	마감 기한: D-20	https://jumpit.saramin.co.kr/position/50925	backend
768	IP Verification Engineer	오픈엣지테크놀로지	서울 강남구	경력 4~14년	["Verilog", "C", "C++", "Python", "Perl"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50494	other
769	애플리케이션 및 클라우드 개발 (전문연구요원)	파이오링크	서울 금천구	신입~7년	["AngularJS", "Linux", "Java", "JavaScript"]	마감 기한: D-20	https://jumpit.saramin.co.kr/position/51125	frontend
770	서버개발팀 모바일 개발자(경력)	사이버다임	서울 송파구	경력 5~15년	["Android Studio", "Node.js", "Webpack"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51567	backend
771	[DRAM PHY] Digital Engineer	오픈엣지테크놀로지	서울 강남구	경력 2~15년	["Verilog", "C", "Python"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50488	other
772	[DEV] 앱개발자 채용	루티너리	서울 서초구	경력 3~15년	["React Native", "JavaScript", "TypeScript"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50965	frontend
773	머신러닝 엔지니어 - 시니어	심플랫폼	서울 금천구	경력 6~15년	["Python", "PyTorch", "TensorFlow", "DVC"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51390	data
774	[Network-on-Chip]RTL Design Engineer	오픈엣지테크놀로지	서울 강남구	경력 2~15년	["Verilog", "C", "Python"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50486	other
775	BE Engineer	이마고웍스	서울 강남구	경력 5~8년	["TypeScript", "NestJS", "MongoDB", "NoSql"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50677	backend
776	SQA실 테스트 담당자 (0~3년이하)	파이오링크	서울 금천구	신입~3년	["QA", "AWS", "SW", "vmware", "Ccna"]	마감 기한: D-20	https://jumpit.saramin.co.kr/position/51124	devops
777	[DRAM PHY] Analog Engineer	오픈엣지테크놀로지	서울 강남구	경력 2~15년	["Verilog", "C", "Python"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50492	other
778	프론트엔드 개발자(5년 이상)	에이아이파크	서울 마포구	경력 5~10년	["JavaScript", "TypeScript", "HTML5"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/51035	frontend
779	[MemoryController]RTLDesign Engineer	오픈엣지테크놀로지	서울 강남구	경력 2~15년	["Verilog", "C", "Python", "C++"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50489	other
780	전력변환 시뮬레이션 엔지니어 (전문연 지원 가능)	에이스웍스코리아	서울 강남구	신입	["MATLAB"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50701	other
781	AI Engineer - 전문연구요원 가능	이마고웍스	서울 강남구	신입	["TypeScript", "Python", "C++", "CMake"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50675	frontend
782	[플레이오] iOS 개발자 (3년 이상)	지엔에이컴퍼니	서울 서초구	경력 3~5년	["Slack", "Notion", "Google Workspace", "Jira"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51209	backend
783	시니어 파이썬 백엔드 엔지니어 채용	알로카도스	서울 강남구	경력 5~15년	["AWS", "Django", "Python", "MongoDB"]	마감 기한: D-1	https://jumpit.saramin.co.kr/position/49892	backend
784	시니어 클라우드 인프라 엔지니어 채용	알로카도스	서울 강남구	경력 5~15년	["Terraform", "MongoDB"]	마감 기한: D-1	https://jumpit.saramin.co.kr/position/49891	backend
785	Front-End Engineer/6~10년	불마켓랩스(BullMarketLabsCo.Ltd.)	서울 강남구	경력 6~10년	["JavaScript", "TypeScript", "Vue.js", "React"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50302	frontend
786	[코스닥 상장사] SRE 포지션 채용	디어유	서울 강남구	경력 3~10년	["AWS", "Linux", "Docker", "Kubernetes"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50795	devops
787	어플리케이션 및 클라우드 개발	파이오링크	서울 금천구	경력 3~13년	["Java", "Spring", "Linux", "Django", "Python"]	마감 기한: D-20	https://jumpit.saramin.co.kr/position/51121	backend
788	보안 네트워크 개발자 (경력)	펜타시큐리티	서울 영등포구	경력 7~20년	["Firewall", "C++", "Linux", "TCP/IP", "Python"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50121	security
789	솔루션 QA담당(경력 6~10년)	엠로	서울 영등포구	경력 6~10년	["QA"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51082	qa
790	백엔드 개발자 (Python)	바로팜	서울 강남구	경력 5~15년	["Git", "Python", "AWS", "TypeScript", "Svelte"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51387	backend
792	[NPU] System SW Engineer	오픈엣지테크놀로지	서울 강남구	신입~15년	["Linux", "C", "C++", "TensorFlow", "PyTorch"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50490	data
793	데이터 사이언티스트	바로팜	서울 강남구	경력 5~10년	["MachineLearning", "SQL", "Python"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50874	data
794	IT/AI부문(전문연구요원 포함)경력(4↑)	연합인포맥스	서울 종로구	경력 4~5년	["AI/인공지능", "TypeScript", "Next.js"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51369	frontend
795	서버개발팀 웹클라이언트 개발자(경력)	사이버다임	서울 송파구	경력 5~15년	["JavaScript", "CSS 3", "HTML5"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51565	backend
796	프론트엔드 개발자	패스트레인	서울 강남구	경력 7~13년	["React", "GitHub", "Jira", "Confluence"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50865	frontend
797	AI Agent Developer	휴먼컨설팅그룹	서울 서초구	경력 3~7년	["Python", "MySQL", "FastAPI", "PostgreSQL"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50643	backend
798	Full-Stack Engineer	커버링	서울 종로구	경력 2~5년	["JavaScript", "TypeScript", "AWS"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50705	frontend
799	AI기반 프로젝트 개발 PL	미디어로그	서울 마포구	경력 7~12년	["Java", "Spring Boot", "Python", "PyTorch"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50355	backend
800	Java 개발자	벳플럭스	서울 강남구	경력 3~5년	["Java", "WebRTC", "MQTT", "Firebase", "AWS"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50684	devops
801	AI기반 바이오마커 예측 (병역특례)	아론티어	서울 서초구	경력 2~10년	["AI/인공지능", "Linux", "Python", "GitHub"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50499	data
803	Backend Engineer(5년 이상)	콜로세움코퍼레이션	서울 강남구	경력 5~12년	["Java", "Gradle", "Kotlin", "Spring Boot"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50357	backend
804	AI기반 단백질 디자인 (병역특례)	아론티어	서울 서초구	경력 2~10년	["AI/인공지능", "Linux", "Python", "GitHub"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50500	data
805	Frontend Engineer	스펙터	서울 강남구	경력 5~10년	["TypeScript", "Next.js", "Zustand"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50688	frontend
806	의료기기 백엔드 개발자 모집	에이엠시지	서울 서초구	경력 3~10년	["Python", "FastAPI", "Node.js", "Fastify"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/51150	backend
807	웹 프론트 개발자 (Vue.js)	티피씨인터넷	서울 강남구	경력 3~6년	["TypeScript", "REST API", "HTML5", "CSS 3"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50562	frontend
808	React/React Native 프론트엔드 개발자	페이워크	서울 강남구	경력 3~8년	["HTML5", "CSS 3", "JavaScript", "React"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50429	frontend
809	Microsoft M365 보안/규정 준수 엔지니어	콘센트릭스서비스코리아	서울 구로구	경력 3~20년	["microsoft office 365", "microsoft teams"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/49979	security
810	MES 솔루션 개발 R&D 리더	한솔피엔에스	서울 강서구	경력 12~20년	["MES", "Spring Boot", "Vue.js", "Java", "ERP"]	마감 기한: D-1	https://jumpit.saramin.co.kr/position/49847	backend
811	보안/인프라/서버 담당자	아이파킹	서울 금천구	경력 4~6년	["HW", "Linux", "Windows", "vmware", "NGINX"]	마감 기한: D-3	https://jumpit.saramin.co.kr/position/49995	backend
812	메세징 서비스 개발자 채용	디어유	서울 강남구	경력 3~7년	["Java", "REST API", "AWS", "Spring Boot"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50347	backend
813	솔루션 프론트엔드(Frontend) 개발자	노아시스템즈	서울 성동구	경력 3~7년	["GUI", "REST API", "JavaScript", "React"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50681	frontend
814	Web Frontend Developer	바비톡	서울 강남구	경력 7~9년	["aws", "react", "TypeScript", "JavaScript"]	마감 기한: D-7	https://jumpit.saramin.co.kr/position/50129	frontend
815	빅데이터 시스템 구축 및 운영 담당자	엑셈	서울 강서구	경력 3~7년	["Java", "Docker", "Kubernetes", "Etl"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50481	devops
816	AI 모델 개발자(2년 이상)	엑셈	서울 강서구	경력 2~10년	["Python", "SQL", "TensorFlow", "AI/인공지능"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50479	data
817	솔루션 백엔드(Backend) 개발자	노아시스템즈	서울 성동구	경력 3~7년	["Java", "Shell", "Spring", "Spring Boot"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50680	backend
818	[공비서] 자바/코틀린 백엔드 개발자	헤렌	서울 성동구	경력 4~25년	["Java", "Kotlin", "Spring Boot", "Mybatis"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49841	backend
819	IT 시스템 연동·구축 담당자	팬택씨앤아이	서울 영등포구	경력 10~20년	["MSSQL", "SQL", "ERP", "REST API", "JSON"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50848	other
820	Runtime 소프트웨어 엔지니어 채용	에너자이	서울 강남구	신입	["AI/인공지능", "C++", "MachineLearning"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/50029	data
821	데이터 분석 플랫폼 개발자(경력 6~10년)	엠로	서울 영등포구	경력 6~10년	["Java", "Spring Framework", "JavaScript"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51081	backend
822	백엔드 디벨로퍼 채용	퀸버	서울 용산구	경력 4~9년	["GitHub", "Node.js", "Python", "AWS", "NoSql"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51182	backend
823	IT/AI부문(전문연구요원 포함)신입	연합인포맥스	서울 종로구	신입	["AI/인공지능", "TypeScript", "Next.js"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51367	frontend
824	프론트엔드 엔지니어 (5년이상)	빅웨이브로보틱스	서울 강남구	경력 5~10년	["React", "Next.js", "TypeScript", "JavaScript"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50668	frontend
826	딥러닝 / 이미지 프로세싱 연구 개발	스키아	서울 구로구	신입~3년	["OpenCV", "PyTorch"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/51017	data
827	데이터 엔지니어 채용	쉬모스랩	서울 강남구	경력 2~7년	["SQL", "PostgreSQL", "Python"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50692	data
828	[신제품개발] 금융 관련 솔루션 개발자	이노룰스	서울 송파구	경력 7~12년	["Java", "Spring Boot", "JavaScript", "Node.js"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50849	backend
829	[챌린저스] QA Manager	화이트큐브	서울 강남구	신입~10년	["Jira", "QA", "Notion", "Slack", "SW"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/51079	qa
830	[커머스프로덕션] Jr. QA 엔지니어 채용	미리디	서울 구로구	경력 1~4년	["Slack", "Redmine", "QA", "Confluence", "Jira"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50618	qa
831	자연어처리 엔지니어 채용	쉬모스랩	서울 강남구	경력 2~7년	["SQL", "PostgreSQL", "Python"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50694	pm
833	Windows 개발자 경력사원 모집	에이피알	서울 송파구	경력 2~4년	["Windows", "Windows Server", "C#", "WPF"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51204	other
834	웹 퍼블리싱 경력 채용	NE능률	서울 마포구	경력 2~8년	["HTML5", "CSS 3", "SCSS", "JavaScript"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51332	frontend
835	APLUS AI_숏폼_백엔드 엔지니어	버즈니	서울 관악구	경력 2~10년	["Python", "AWS", "Amazon EKS"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51176	backend
836	APLUS AI_Knoi_백엔드 엔지니어	버즈니	서울 관악구	경력 1~10년	["Python", "FastAPI", "Kafka", "pytest"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51174	backend
839	프론트엔드 개발자 경력사원 모집	에이피알	서울 송파구	경력 5~10년	["React", "Next.js", "pnpm", "Yarn", "Zustand"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51205	frontend
840	자율주행 차량제어 엔지니어 (전문연 지원 가능)	에이스웍스코리아	서울 강남구	신입~10년	["C++", "Python"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50695	robotics
841	전장설계 엔지니어 (신입)	에이스웍스코리아	서울 강남구	신입	["Autocad", "Solidworks"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50697	other
842	모바일 앱 프론트엔드 (React Native)	라라잡	서울 강서구	경력 2~15년	["React Native", "JavaScript", "TypeScript"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50612	frontend
843	FMS 설계,개발 S/W 엔지니어 [전문연구요원가능]	토르드라이브	서울 영등포구	경력 3~10년	["C", "C++", "CUDA", "React", "Kubernetes"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50074	frontend
844	Multi Agent Path Finding S/W Engineer (전문연 가능)	토르드라이브	서울 영등포구	경력 3~10년	["C++", "ROS"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/51342	robotics
845	NPU Verification Engineer	모빌린트	서울 강남구	경력 5~10년	["C", "C++", "Linux", "DeepLearning"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50332	design
846	프론트엔드 개발자(시니어_7년 이상)	에이피티플레이	서울 강남구	경력 7~20년	["TypeScript", "Next.js", "React", "Recoil"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51207	frontend
847	Frontend Engineer(Lead)	콜로세움코퍼레이션	서울 강남구	경력 5~10년	["React", "Next.js", "TypeScript", "Storybook"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50356	frontend
848	의료SW그룹 알고리즘 개발자 모집	에이엠시지	서울 서초구	경력 10~20년	["Python", "MachineLearning"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/51038	other
849	Product Manager	스펙터	서울 강남구	경력 3~10년	["JavaScript", "Python", "Confluence", "Jira"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/51027	frontend
850	DBA 담당(7년↑)	엑심베이	서울 구로구	경력 7~10년	["MySQL", "Java", "Slack", "Linux", "AWS"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50678	devops
851	안드로이드 개발자 경력사원(3~7년) 모집	와그	서울 종로구	경력 3~7년	["Kotlin", "Moshi", "Retrofit"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50755	mobile
852	의료기기 소프트웨어(SW) 개발자 모집	에이엠시지	서울 서초구	경력 3~10년	["DICOM", "Qt", "C++", "SQL", "GUI"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/51039	design
853	안드로이드 개발자 경력사원(8~10년) 모집	와그	서울 종로구	경력 8~10년	["Kotlin", "Moshi", "Retrofit"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50757	mobile
854	Devops (5년 이상)	퓨쳐위즈	서울 강남구	경력 5~10년	["AWS", "Kubernetes", "Terraform", "Datadog"]	마감 기한: D-8	https://jumpit.saramin.co.kr/position/50144	devops
855	RTL 설계 엔지니어 (경력)	칩스앤미디어	서울 강남구	경력 8~15년	["ASIC", "FPGA", "Verilog", "C", "C++", "Python"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50077	other
856	ML Engineer (Embedded, 5~7년)	웨어러블에이아이	서울 영등포구	경력 5~7년	["CUDA", "C", "C++", "Embedded Linux"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50377	data
857	ML Engineer (Embedded,8~10년)	웨어러블에이아이	서울 영등포구	경력 8~10년	["CUDA", "C", "C++", "Embedded Linux"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50376	data
858	데이터 사이언티스트(5년 이상)	엑셈	서울 강서구	경력 5~15년	["MachineLearning", "DeepLearning"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50480	data
859	Site Reliability Engineer/5~8년	불마켓랩스(BullMarketLabsCo.Ltd.)	서울 강남구	경력 5~8년	["AWS", "Amazon EC2 Container Service"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50296	devops
860	펌웨어 개발자 경력 정규직 채용	엠투클라우드	서울 송파구	경력 10~15년	["FW", "MCU", "C", "SW"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50599	embedded
861	Back-End Engineer	불마켓랩스(BullMarketLabsCo.Ltd.)	서울 강남구	경력 7~10년	["Kotlin", "Spring Boot", "Go", "Python", "Java"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50303	backend
862	쇼핑몰서비스 PHP 개발자 10년↑ 모집	유디아이디	서울 구로구	경력 10~20년	["PHP", "MySQL", "MongoDB", "Laravel"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/51120	backend
863	Backend Engineer 채용	한국디지털에셋	서울 강남구	경력 5~15년	["Java", "Kotlin", "Gradle", "Go", "TypeScript"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51172	backend
864	Tech Innovation 워킹그룹 풀스택 개발	프리윌린	서울 관악구	경력 8~15년	["TypeScript", "AWS", "Spring", "RDB", "Kotlin"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50978	backend
865	멀티모달 AI 엔지니어	로민	서울 서초구	경력 2~15년	["Python", "Docker", "PyTorch", "TensorFlow"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51269	devops
866	품질보증관리자(QC/QA)	디카르고	서울 강남구	경력 3~5년	["Jira", "Notion", "Slack", "Selenium", "Appium"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51360	qa
867	CAD Engineer - 전문연구요원 가능	이마고웍스	서울 강남구	신입	["TypeScript", "C++", "CMake", "OpenGL"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50674	frontend
868	AI 백엔드 시스템 엔지니어	로민	서울 서초구	경력 3~15년	["Python", "FastAPI", "PostgreSQL", "Redis"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51270	backend
869	플랫폼 및 운영 엔지니어(DevOps/SRE)	위펀	서울 강남구	경력 5~10년	["MySQL", "Spring Boot", "Java", "QueryDSL"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51524	backend
870	백엔드 개발자(PHP) 팀원	테크랩스	서울 강남구	경력 5~10년	["PHP", "JavaScript", "HTML5", "CSS 3"]	마감 기한: D-20	https://jumpit.saramin.co.kr/position/51151	backend
871	서버개발팀 백엔드 개발자(경력)	사이버다임	서울 송파구	경력 5~15년	["Java", "JSP", "Spring Framework", "RDB"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51566	backend
872	FW 엔지니어 (경력)	칩스앤미디어	서울 강남구	경력 5~12년	["C++", "C", "HW", "FW"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50078	other
873	[인공지능솔루션] Backend Engineer	제논	서울 강남구	경력 3~20년	["Docker", "Python", "FastAPI", "GitHub"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50939	backend
874	[인공지능솔루션] AI Engineer	제논	서울 강남구	경력 3~20년	["PyTorch", "TensorFlow", "Python"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50941	data
875	B2B소프트웨어 DevOps 운영팀(3~7년)	법틀	서울 성동구	경력 3~7년	["Python", "Django", "Java", "Spring Boot"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51213	backend
876	전장설계 엔지니어 (경력)	에이스웍스코리아	서울 강남구	경력 3~10년	["Autocad", "Solidworks"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50698	other
877	[8년 이상] Web Full Stack개발 경력	알스퀘어	서울 강남구	경력 8~15년	["Spring Boot", "Java", "AWS", "Spring", "SQL"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51191	backend
878	[Dev] RN Developer 채용	루티너리	서울 서초구	경력 3~15년	["React Native", "JavaScript", "TypeScript"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50966	frontend
879	프론트엔드 개발자 (8년 이상)	알스퀘어	서울 강남구	경력 8~15년	["JavaScript", "TypeScript", "React", "vuex"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51189	frontend
880	[외국계 게임사] 인큐베이션 개발자(계약직)	가레나코리아	서울 강남구	경력 2~5년	["Unity", "Unreal Engine"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51410	game
881	[인공지능솔루션] Search Engineer	제논	서울 강남구	경력 3~20년	["Elasticsearch", "Docker", "Python"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50937	devops
882	Sr. 백엔드개발자(경력 5-10년)	리코	서울 강남구	경력 5~10년	["Vue.js", "TypeScript", "Kotlin", "Java"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50647	backend
883	풀스택 개발자 (5~10년) [강남구]	모멘티	서울 강남구	경력 5~10년	["Vue.js", "React", "Flutter", "React Native"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/51130	frontend
884	풀스택 개발자 (1~4년) [강남구]	모멘티	서울 강남구	경력 1~4년	["Vue.js", "React", "Flutter", "React Native"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/51108	frontend
885	프론트엔드 개발자 (1~4년) [강남구]	모멘티	서울 강남구	경력 1~4년	["HTML5", "CSS 3", "JavaScript", "Bootstrap"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/51107	frontend
886	백엔드 개발자 (Java & Spring, AWS 클라우드)	주식회사 도브러너	서울 강남구	경력 7~20년	["AWS", "Kafka", "Java", "Spring Framework"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/50774	backend
887	ML Engineer (ML 엔지니어)	메이아이	서울 강남구	경력 5~10년	["FastAPI", "Django", "PostgreSQL", "Airflow"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49941	backend
888	안드로이드 개발자	티피씨인터넷	서울 강남구	신입~3년	["Kotlin", "Coroutine", "Flow"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50433	mobile
889	Deep Learning Optimization Engineer	모빌린트	서울 강남구	신입~10년	["Python", "PyTorch", "TensorFlow"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50328	data
890	DRM team Tech Lead (Cloud SaaS)	주식회사 도브러너	서울 강남구	경력 10~25년	["AWS", "Elasticsearch", "Java", "Spring Boot"]	마감 기한: D-13	https://jumpit.saramin.co.kr/position/50298	backend
891	Tech Lead (Backend, Frontend, Cloud SaaS)	주식회사 도브러너	서울 강남구	경력 10~25년	["AWS", "Elasticsearch", "Java", "Spring Boot"]	마감 기한: D-13	https://jumpit.saramin.co.kr/position/50299	backend
892	AI 국제 물류 스타트업 백엔드 개발자	아로아랩스	서울 마포구	경력 2~5년	["Go", "GitHub", "SQL", "AZURE", "vscode.dev"]	마감 기한: D-13	https://jumpit.saramin.co.kr/position/50430	backend
893	Backend Engineer (경력 8~12년)	위펀	서울 강남구	경력 8~12년	["MySQL", "Spring Boot", "Java", "QueryDSL"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50203	backend
894	보안 솔루션 엔지니어 (신입)	위드네트웍스	서울 강서구	신입	["Python"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50247	security
895	소프트웨어 QA(신입/~2년이하)	엑셈	서울 강서구	신입~2년	["Kubernetes", "K8S", "Oracle", "QA", "SW"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50902	devops
896	백엔드 개발자 경력 정규직 채용	엠투클라우드	서울 송파구	경력 6~10년	["JavaScript", "Spring MVC", "MySQL", "RDB"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50602	backend
897	Motion Planning/Control Engineer	웨어러블에이아이	서울 영등포구	신입~10년	["C", "C++", "Python", "MATLAB", "Docker"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50378	devops
898	의류제조시스템 AI 모델 적용 개발자 경력	호전실업	서울 마포구	경력 3~10년	["TensorFlow", "PyTorch"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51280	data
899	프론트엔드 개발	엔에이치엔링크	서울 강남구	경력 5~15년	["JavaScript", "TypeScript", "HTML5", "CSS 3"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51208	frontend
900	프론트엔드 개발 경력 정규직 채용	엠투클라우드	서울 송파구	경력 6~10년	["JavaScript", "HTML5", "CSS 3", "AngularJS"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50600	frontend
901	[일레븐플러스]프론트엔드 개발자(React)	캔랩코리아	서울 서초구	경력 2~10년	["React", "Vue.js", "Mocha", "Jasmine", "Jest"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50184	frontend
902	클라우드 Java 백엔드 개발자 채용	아이파킹	서울 금천구	경력 4~6년	["Java", "Spring Boot", "NoSql", "REST API"]	마감 기한: D-3	https://jumpit.saramin.co.kr/position/49996	backend
903	AI 최적화 Researcher 채용	에너자이	서울 강남구	신입	["AI/인공지능", "TensorFlow", "Python"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/50027	data
904	안드로이드 개발자 (Android Developer)	바로팜	서울 강남구	경력 5~7년	["Kotlin", "Java"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50875	mobile
905	정보보안 담당자 (6년 이상)	이지스엔터프라이즈	서울 금천구	경력 6~15년	["ISMS", "CPPG", "CISA", "CISSP", "IPS", "AWS"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51014	devops
906	티켓링크 연동 서비스 개발	엔에이치엔링크	서울 강남구	경력 3~4년	["Java", "Spring", "REST API", "NoSql", "Git"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50980	backend
908	Backend Junior Engineer(PHP/Python)	코비그룹	서울 강남구	신입~3년	["Linux", "Python", "AWS", "SQL", "Laravel"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51347	backend
909	Windows개발자 (경력 11년↑)	페이타랩	서울 강남구	경력 11~20년	["WPF", "C#", "Visual Studio", "C++", ".NET"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50427	other
910	웹어플리케이션 백엔드 경력 (2년↑)	이글루코퍼레이션	서울 송파구	경력 2~7년	["Spring Framework", "MySQL", "REST API"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51188	backend
911	[삼성계열사]백엔드 서버/보안 솔루션	씨브이네트	서울 송파구	경력 5~20년	["Java", "Spring", "Spring Boot", "C", "C++"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50863	backend
912	HRIS 풀스택	메디쿼터스	서울 강남구	경력 1~3년	["Python", "PostgreSQL", "Git", "GitHub"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51529	fullstack
913	자사 HR Platform 서비스 개발팀장	아인잡	서울 강남구	경력 5~15년	["MySQL", "Java", "AWS", "NoSql", "Docker"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50079	devops
914	Back-End 개발자(9년 이상 필수)	오로라파이브	서울 영등포구	경력 9~10년	["MongoDB", "TypeScript", "MySQL"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50516	backend
915	기술지원 Field Engineer	이노뎁	서울 금천구	경력 5~20년	["Windows", "Windows Server", "Network"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50167	other
916	SAP 운영, 개발자 채용(7~8년)	제너시스비비큐	서울 송파구	경력 7~8년	["SAP", "ABAP"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50964	other
917	Software Engineer (NPU SDK)	모빌린트	서울 강남구	신입~10년	["C", "C++"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51298	other
918	WEBFRONT-K GUI 개발	파이오링크	서울 금천구	경력 3~13년	["Java", "C", "C++", "Linux", "Django"]	마감 기한: D-20	https://jumpit.saramin.co.kr/position/51123	backend
919	Frontend Engineer(React)(경력 8~12년)	위펀	서울 강남구	경력 8~12년	["JavaScript", "Git", "TypeScript", "React"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50201	frontend
920	머신러닝 연구원/엔지니어	에이아이파크	서울 마포구	경력 3~10년	["Python", "PyTorch", "TensorFlow", "AZURE"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/51036	devops
921	DevOps/MLOps Engineer (3~6년)	웨어러블에이아이	서울 영등포구	경력 3~6년	["AWS", "Linux", "Docker", "Kubernetes"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50375	devops
922	백엔드 개발자(6~10년)	더블미디어	서울 강남구	경력 6~10년	["Golang", "Redis", "SQL", "Git"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50181	backend
923	백엔드 개발자(7년 이상)	에이아이파크	서울 마포구	경력 7~10년	["jQuery", "Ajax", "Java", "Python", "NGINX"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/51034	backend
924	백엔드 개발자(3~5년)	더블미디어	서울 강남구	경력 3~5년	["Golang", "Redis", "SQL", "Git"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50180	backend
925	ADC(L4-L7 스위치) 애플리케이션 개발	파이오링크	서울 금천구	경력 2~10년	["Linux", "C", "L4", "L7", "Git", "React", "C++"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/51022	frontend
926	C 개발자(3년 이상)	엑셈	서울 강서구	경력 3~7년	["C++", "C", "Linux", "Network"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50845	design
927	매쓰플랫 백엔드 개발	프리윌린	서울 관악구	경력 5~10년	["TypeScript", "AWS", "Spring", "RDB", "Kotlin"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50976	backend
928	Golang 개발자(3년 이상)	엑셈	서울 강서구	경력 3~8년	["Go", "Docker", "Kubernetes", "gRPC"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50846	backend
929	[인공지능솔루션] Data Scientist	제논	서울 강남구	경력 3~20년	["PyTorch", "TensorFlow", "Python"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50940	data
930	CI/CD 엔지니어	오픈소스컨설팅	서울 강남구	경력 3~14년	["GitHub", "GitLab", "Bitbucket", "Jenkins"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/49980	devops
931	클라우드 기술지원 엔지니어	오픈소스컨설팅	서울 강남구	경력 5~13년	["Linux", "Kubernetes", "L3", "Network", "L2"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/49976	devops
932	쇼핑몰서비스 PHP 개발자 3년↑ 모집	유디아이디	서울 구로구	경력 3~5년	["PHP", "MySQL", "MongoDB", "Laravel"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/51118	backend
934	시니어 풀스택 개발자	아보엠디코리아	서울 강남구	경력 5~15년	["React", "NoCodeAPI", "TypeScript"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51333	frontend
935	프론트엔드 개발자 (5~10년) [강남구]	모멘티	서울 강남구	경력 5~10년	["HTML5", "CSS 3", "JavaScript", "Bootstrap"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/51110	frontend
936	Business Data Analyst(데이터 분석가)	엔카닷컴	서울 중구	경력 3~10년	["Insight", "DB", "DataTables", "Dw", "SQL"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50498	data
937	[DOF] Algorithm SW Engineer	디오에프	서울 성동구	경력 7~15년	["CUDA", "C++"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51143	backend
938	의료기기 인공지능 엔지니어	오션스바이오	서울 용산구	경력 3~20년	["DeepLearning", "MachineLearning"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50519	other
939	3차원 카메라 하드웨어 개발자(2~4)	클레	서울 성동구	경력 2~4년	["PCB", "Orcad"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51071	other
940	SI 개발	미디어로그	서울 마포구	경력 8~10년	["Java", "Spring Boot", "Vue.js", "Oracle"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/50145	backend
941	Computer Vision Engineer(CV엔지니어)	메이아이	서울 강남구	신입~10년	["MachineLearning", "AI/인공지능"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49942	data
942	오프라인 결제 개발자(4~6년)	엑심베이	서울 구로구	경력 4~6년	["Java", "JavaScript", "Spring Framework"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50310	backend
947	[Python] AI 플랫폼 개발자	딥노이드	서울 구로구	경력 2~7년	["Python", "Spark", "Elasticsearch", "Airflow"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/31070	data
948	빅데이터 기반 교육 플랫폼 Node/NestJS 백엔드 개발자	퍼플아카데미	서울 양천구	경력 3~8년	["JavaScript", "SQL", "BigData", "Node.js"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49866	backend
949	Frontend Engineer(React)(경력 5~7년)	위펀	서울 강남구	경력 5~7년	["JavaScript", "Git", "TypeScript", "React"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50200	frontend
950	프론트엔드 개발자 (경력 6년~9년)	퍼퓸그라피	서울 종로구	경력 6~9년	["React", "Node.js", "HTML5", "CSS 3"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/49849	backend
951	AI 컴파일러 엔지니어 채용	에너자이	서울 강남구	신입~10년	["C++", "Haskell", "DeepLearning", "F#"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/50028	data
952	ERP시스템 운영 담당자(4년 이상)	이지스엔터프라이즈	서울 금천구	경력 4~10년	["Java", "JavaScript", "Oracle", "MySQL"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51015	frontend
954	백엔드 주니어 개발자(.NET Core/GCP)	엠엑스엔커머스코리아	서울 성동구	경력 1~2년	[".NET", "GitHub", "RDB", "PostgreSQL"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51179	backend
955	Frontend Engineer 채용	한국디지털에셋	서울 강남구	신입~3년	["React", "Next.js", "Zustand", "CSS 3"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51173	frontend
956	백엔드 개발자(경력)	아인잡	서울 강남구	경력 4~10년	["AWS", "Java", "MongoDB", "MySQL", "Redis"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50080	backend
957	프론트엔드/풀스택 개발자 모집	엠엑스엔커머스코리아	서울 성동구	경력 2~4년	["React", "JavaScript", "Node.js", "TypeScript"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51181	backend
958	Windows개발자 (신입~5년↓)	페이타랩	서울 강남구	신입~5년	["WPF", "C#", "Visual Studio", "C++", ".NET"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50425	other
959	Python Back-end Enginner	올거나이즈코리아	서울 강남구	경력 2~5년	["Python", "Backendless"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51372	backend
960	자바(JAVA) 웹 개발자 모집	뉴버드	서울 서대문구	경력 3~5년	["MySQL", "Vue.js", "Java", "Spring"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50961	backend
961	소프트웨어 QA	윌로그	서울 강남구	경력 3~12년	["QA", "Jira", "Slack", "Confluence", "Redmine"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50870	qa
963	네트워크 정보보호 개발자 (경력)	위드네트웍스	서울 강서구	경력 5~10년	["Java", "Spring Boot", "React", "TypeScript"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50245	backend
964	서버 백엔드 개발[경력]	패션앤스타일컴퍼니	서울 종로구	경력 6~15년	["Java", "Spring", "Spring Framework"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50900	backend
966	프론트엔드 개발자 경력 채용	위볼린	서울 성동구	경력 2~5년	["GitLab", "React", "Next.js", "Git", "TypeScript"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51350	frontend
967	프론트엔드 개발자	아인잡	서울 강남구	경력 3~10년	["CSS 3", "Jira", "React", "TypeScript"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50081	frontend
968	웹 프론트엔드 개발자 추가 모집	마스터웨이	서울 강서구	신입~3년	["React", "TypeScript", "Recoil", "React Query"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49781	frontend
969	MES개발/운영 경력 채용	한솔피엔에스	서울 강서구	경력 5~10년	["MES", "Spring Boot", "Vue.js", "Java", "ERP"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50666	backend
970	Senior S/W Engineer-Embedded AI [전문연구요원가능]	토르드라이브	서울 영등포구	경력 3~10년	["C", "C++", "CUDA"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50072	data
971	프론트엔드 개발자	에피소든	서울 강남구	경력 5~15년	["React", "Next.js", "TypeScript", "WebRTC"]	마감 기한: D-13	https://jumpit.saramin.co.kr/position/50628	frontend
972	백엔드 개발 팀장 (3~5년)	앱티마이저	서울 관악구	경력 3~5년	["Django", "Celery", "Redis", "Amazon S3"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50790	backend
973	DBA 담당(4~6년)	엑심베이	서울 구로구	경력 4~6년	["MySQL", "Java", "Slack", "Linux", "AWS"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50679	devops
974	Back-end Developer (5년 이상)	미소	서울 종로구	경력 5~20년	["MSA", "Node.js", "AWS", "TypeScript"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50807	backend
975	System Software Engineer	모빌린트	서울 강남구	경력 5~10년	["Linux", "C++", "Embedded", "sw", "C"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50326	design
976	임베디드(펌웨어) 개발자	크래블	서울 성동구	경력 1~20년	["HW", "Linux", "SW", "MCU"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50502	design
977	웹 프론트엔드 개발자(React 4년 이상)	라라잡	서울 강서구	경력 4~15년	["React Native", "JavaScript", "TypeScript"]	마감 기한: D-13	https://jumpit.saramin.co.kr/position/50611	frontend
978	리눅스 App. 개발자	코넥티브	서울 강남구	경력 3~10년	["Git", "C", "C++", "GUI", "Linux", "Qt", "Ubuntu"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/51087	design
980	Sr. AI & Data Analysis Specialist(11~15y)	피엠인터내셔널코리아	서울 영등포구	경력 11~15년	["SQL", "NoSql", "Tableau", "AWS", "AZURE"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50990	devops
981	[스윗트래커]프론트엔드개발(5년 이상)	커넥트웨이브	서울 금천구	경력 5~10년	["JavaScript", "jQuery", "Vue.js", "React"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50851	frontend
982	Software Developer	씨메스	서울 강남구	신입~3년	["C", "C++", "Python", "Blender", "Solidworks"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51157	other
983	Windows개발자 (경력 6~10년↓)	페이타랩	서울 강남구	경력 6~10년	["WPF", "C#", "Visual Studio", "C++", ".NET"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50426	other
984	Playce Cloud Pre-Sales	오픈소스컨설팅	서울 강남구	경력 7~20년	["OpenStack", "Kubernetes", "Jenkins"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/49981	devops
985	FW 펌웨어 개발(3년 이상)	윌로그	서울 강남구	경력 3~6년	["FW", "MCU", "RTOS", "C", "C++", "Git", "HW"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50871	embedded
986	FW 펌웨어 개발(7년 이상)	윌로그	서울 강남구	경력 7~12년	["FW", "MCU", "RTOS", "C", "C++", "Git", "HW"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50872	embedded
987	프론트엔드/풀스택 시니어 개발자 모집	엠엑스엔커머스코리아	서울 성동구	경력 5~7년	["React", "JavaScript", "Node.js", "TypeScript"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51180	backend
988	생성형 AI 개발자 채용	시어스랩	서울 서초구	경력 3~10년	["AI/인공지능"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50358	data
989	웹 개발자(경력) 채용	씨알에스큐브	서울 마포구	경력 3~8년	["Java", "jQuery", "JavaScript", "HTML5"]	마감 기한: D-3	https://jumpit.saramin.co.kr/position/49922	frontend
990	자연어처리/ Python 엔진 개발	아일리스프런티어	서울 종로구	경력 1~3년	["NoSql", "Python", "Django", "Flask", "FastAPI"]	마감 기한: D-day	https://jumpit.saramin.co.kr/position/49815	backend
991	ML 엔지니어 (2년 이상)	피카부랩스	서울 강남구	경력 2~20년	["Python", "PyTorch", "TensorFlow"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50959	data
992	[플랫폼개발팀] Java Senior 개발자	델레오코리아	서울 강남구	경력 8~20년	["REST API", "Java", "Spring Boot", "Spring"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/49911	backend
993	Deep Learning Research Engineer	모빌린트	서울 강남구	신입~10년	["Python", "PyTorch", "TensorFlow"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50327	data
994	정보보안 담당자 (5년 이상)	퓨쳐위즈	서울 강남구	경력 5~10년	["AWS", "Amazon EKS"]	마감 기한: D-8	https://jumpit.saramin.co.kr/position/50143	devops
995	IoT Embedded FW Engineer	럭키박스솔루션	서울 서초구	경력 5~10년	["C++", "FW", "ARM", "MCU", "Embedded"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50660	embedded
996	자사앱/웹 관리자 채용[9~12년]	제너시스비비큐	서울 송파구	경력 9~12년	["Java", "Spring Boot", "MSSQL", "MySQL"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50888	backend
997	iOS 개발자	티피씨인터넷	서울 강남구	경력 2~4년	["iOS", "Swift", "Rxswift"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51153	mobile
999	서버 개발자	코보시스	서울 송파구	경력 3~15년	["Java", "Spring Boot", "JSP", "Linux"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49934	backend
1000	C# 개발자	코보시스	서울 송파구	경력 3~10년	["C#", "WPF", "Git", ".NET", "SW"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49935	other
1001	3D 엔진개발 [메타개발팀] 과장급	상화	서울 강남구	경력 6~8년	["Unity", "Unreal Engine", "3D Rendering"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50189	game
1002	향수 커머스 웹개발자(미들급) 채용	퍼퓸그라피	서울 종로구	경력 4~6년	["React", "Node.js", "HTML5", "CSS 3"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/49850	backend
1003	Vision AI/Graphics 기술연구 총괄	시어스랩	서울 서초구	경력 15~20년	["AI/인공지능"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50360	data
1004	UI/UX 개발자 경력 정규직 채용	엠투클라우드	서울 송파구	경력 2~6년	["JavaScript", "HTML5", "CSS 3", "jQuery"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50601	frontend
1005	iOS Engineer (Intermediate) 채용	이지식스(엠블)	서울 강남구	경력 3~7년	["Rxswift", "Swift", "iOS", "MVVM"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50339	mobile
1006	프론트엔드 개발자 (경력 3년~5년)	퍼퓸그라피	서울 종로구	경력 3~5년	["React", "Node.js", "HTML5", "CSS 3"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/49848	backend
1007	서버 백엔드 개발[신입]	패션앤스타일컴퍼니	서울 종로구	신입	["Java", "Spring", "Spring Framework"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50901	backend
1008	Robotics Engineer	씨메스	서울 강남구	신입	["C++", "Python", "C"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50330	robotics
1009	인사시스템 분석/설계 담당자 모집	지에스비즈플	서울 종로구	경력 10~15년	["Java", "Oracle", "MariaDB"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50776	other
1010	Back-End 개발자(6년 이상 필수)	오로라파이브	서울 영등포구	경력 6~8년	["MongoDB", "TypeScript", "MySQL"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50515	backend
1011	SAP 운영, 개발자 채용(4~6년)	제너시스비비큐	서울 송파구	경력 4~6년	["SAP", "ABAP"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50963	other
1012	Backend Engineer (Go)	센트비	서울 영등포구	경력 4~10년	["Golang", "gRPC", "PostgreSQL", "Redis", "Git"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50708	backend
1013	NPU Core Engineer (RTL)	모빌린트	서울 강남구	신입~10년	["C", "C++", "Linux", "DeepLearning"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50333	design
1014	AI개발자 (3D 피부분석)	룰루랩	서울 강남구	경력 1~10년	["Python", "PyTorch"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50199	data
1015	Flutter 앱개발자 (3~5년)	시어스랩	서울 서초구	경력 3~5년	["Flutter", "Dart", "REST API", "WebSocket"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50361	mobile
1016	3D 엔진개발 [메타개발팀]	상화	서울 강남구	경력 3~5년	["Unity", "Unreal Engine", "3D Rendering"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50188	game
1017	3D Scan Engineer 경력 채용	디오에프	서울 성동구	경력 3~15년	["SW", "C++", "MachineLearning", "OpenCV"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51140	other
1018	[DOF] 회로설계 엔지니어 채용	디오에프	서울 성동구	경력 5~15년	["FPGA", "MCU", "SMPS", "RF"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50431	embedded
1019	IT Infra Manager	모빌린트	서울 강남구	경력 7~15년	["Linux", "Windows", "Network", "ERP", "Jira"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50283	design
1020	SM/SI 개발 채용	미디어로그	서울 마포구	경력 5~10년	["Java 8", "Spring Boot", "Vue.js"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/49906	backend
1021	SoC Design Engineer	모빌린트	서울 강남구	신입~10년	["Verilog", "EDA", "ASIC", "FPGA", "Python"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50324	other
1022	[플랫폼개발팀] Java 주니어 개발자	델레오코리아	서울 강남구	경력 4~8년	["REST API", "Git", "Redis", "RabbitMQ", "RDB"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/49910	other
1023	Back-End 개발자(3년 이상 필수)	오로라파이브	서울 영등포구	경력 3~5년	["MongoDB", "TypeScript", "MySQL"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50514	backend
1024	Vision AI(Vision Model/VLM) 연구개발	씨이랩	서울 강남구	경력 3~10년	["AI/인공지능", "PyTorch", "MachineLearning"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50918	data
1025	자사앱/웹 관리자 채용[6~8년]	제너시스비비큐	서울 송파구	경력 6~8년	["Java", "Spring Boot", "MSSQL", "MySQL"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50887	backend
1026	SAP 운영, 개발자 채용(0~3년)	제너시스비비큐	서울 송파구	신입~3년	["SAP", "ABAP"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50962	other
1027	자사앱/웹 관리자 채용[2~5년]	제너시스비비큐	서울 송파구	경력 2~5년	["Java", "Spring Boot", "MSSQL", "MySQL"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50886	backend
1028	웹 프로그래머/경력직/JAVA JSP	비욘드테크	서울 금천구	경력 3~7년	["JSP", "Java", "SW", "JavaScript"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/49793	frontend
1029	언리얼 게임개발 과정 교강사(경력)	경일게임아이티아카데미	서울 강동구	신입~30년	["C++", "Unreal Engine"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50613	game
1030	병원정보시스템 클라우드(EMR) 개발자	이지케어텍(edge&next)	서울 중구	경력 3~18년	["C#", "WPF", ".NET", "Oracle", "JavaScript"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50471	frontend
1031	Backend Engineer (경력 5~7년)	위펀	서울 강남구	경력 5~7년	["MySQL", "Spring Boot", "Java", "QueryDSL"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50202	backend
1032	풀스텍 개발자 경력 채용	위볼린	서울 성동구	경력 2~5년	["Next.js", "Node.js", "NestJS", "TypeScript"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51351	backend
1033	프론트엔드 개발자	버추얼랩	서울 성동구	경력 3~10년	["Vue.js", "Bootstrap", "Nuxt.js", "Vuetify"]	마감 기한: D-3	https://jumpit.saramin.co.kr/position/50009	frontend
1034	오프라인 결제 개발자(7년↑)	엑심베이	서울 구로구	경력 7~10년	["Java", "JavaScript", "Spring Framework"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50311	backend
1035	백엔드 개발자(웹,인프라)	에피소든	서울 강남구	경력 5~20년	["TypeScript", "NestJS", "PostgreSQL"]	마감 기한: D-13	https://jumpit.saramin.co.kr/position/50627	backend
1036	정보보안(관리)	미디어로그	서울 마포구	경력 10~15년	["ISMS", "CPPG"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51397	security
1037	[누구(nugu)] BE엔지니어(시니어)	메디쿼터스	서울 강남구	경력 10~20년	["Go", "gRPC", "Kafka", "RDB", "NoSql", "MSA"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50943	backend
1038	AI개발자 채용	웅진	서울 중구	경력 3~20년	["Java", "AI/인공지능", "SQL", "Python", "R"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/49992	data
1039	백엔드 개발자 (5년 이상)	아이헤이트플라잉버그스	서울 영등포구	경력 5~7년	["NestJS", "TypeScript", "Node.js", "Kotlin"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50304	backend
1040	프론트엔드 (3년 이상)	시어스랩	서울 서초구	경력 3~10년	["WebSocket", "GraphQL", "React", "Vue.js"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50359	frontend
1041	수요예측/데이터 분석 전문가(중/고급)	디에스이트레이드	서울 서초구	경력 3~10년	["Python", "SQL", "TensorFlow", "Keras"]	마감 기한: D-1	https://jumpit.saramin.co.kr/position/49882	data
1042	오프라인 결제 개발자(1~3년)	엑심베이	서울 구로구	경력 1~3년	["Java", "JavaScript", "Spring Framework"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51398	backend
1043	향수 커머스 웹개발자(시니어급) 채용	퍼퓸그라피	서울 종로구	경력 6~9년	["React", "Node.js", "HTML5", "CSS 3"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/49851	backend
1044	React 프론트엔드 개발자 (5년 이상)	아이헤이트플라잉버그스	서울 영등포구	경력 5~10년	["TypeScript", "GraphQL", "React", "Apollo"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50306	frontend
1045	프로젝트 매니저 (3년 이상)	아이헤이트플라잉버그스	서울 영등포구	경력 3~10년	["Jira", "Notion", "Slack", "Figma", "DataGrip"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50307	data
1046	유니티 게임개발 과정 교강사(신입)	경일게임아이티아카데미	서울 강동구	신입~30년	["Unity"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49908	game
1047	QA/테스트 엔지니어(경력 3년 이상)	와이즈스톤티	서울 서초구	경력 3~9년	["QA", "Jira", "Mantis", "Redmine"]	마감 기한: 상시	https://jumpit.saramin.co.kr/position/16538	qa
1048	NPU Compiler Engineer	모빌린트	서울 강남구	신입~10년	["Python", "C++", "Linux", "DeepLearning", "c"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50329	design
1049	Robotics S/W Engineer [전문연구요원가능]	토르드라이브	서울 영등포구	경력 3~10년	["C", "C++", "CUDA"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50071	robotics
1050	Data Scientist in Financial (1~3년)	페니로이스	서울 종로구	경력 1~3년	["Python", "R", "BigData", "MachineLearning"]	마감 기한: D-20	https://jumpit.saramin.co.kr/position/51111	data
1051	[주4.5일] 네트워크 엔지니어 경력	에어키	서울 서초구	경력 5~15년	["Network", "Cisco", "TCP/IP", "VPN", "AWS"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/48850	devops
1052	M365 보안 및 인증 관리 담당자 (Team Leader/Manager)	콘센트릭스서비스코리아	서울 구로구	경력 2~10년	["Active Directory", "Microsoft Azure"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/44166	devops
1054	SAP SCM Manager	쏘카	서울 성동구	경력 2~5년	["ABAP", "SAP"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50474	other
1055	인프라 개발 경력직 채용	쥬비스다이어트	서울 강남구	경력 3~5년	["Java", "Spring Framework", "Spring Boot"]	마감 기한: D-3	https://jumpit.saramin.co.kr/position/50783	backend
1056	서버/백엔드 개발자	룰루랩	서울 강남구	경력 5~15년	["Java", "Kotlin"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50198	backend
1057	AWS 인프라 관련 설계/구축 경력직	클래스메소드코리아	서울 중구	경력 1~5년	["AWS", "Network"]	마감 기한: 상시	https://jumpit.saramin.co.kr/position/3877	devops
1058	프론트앤드 웹 개발자 채용	이폴리움	서울 서초구	경력 1~5년	["HTML5", "CSS 3", "Ajax", "MySQL", "SQL"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/51069	data
1059	백엔드개발자(Node.js)	리비바이오	서울 강남구	경력 2~5년	["Git", "Node.js", "REST API", "AWS"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50607	backend
1060	프런트 개발 경력직 채용	인공지능팩토리	서울 중구	경력 1~5년	["HTML5", "CSS 3", "JavaScript", "TypeScript"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/50979	frontend
1061	[삼보컴퓨터 계열사] 서버 운영 담당자	삼보컴퓨터	서울 강남구	경력 2~7년	["Windows", "Linux", "MSSQL", "MySQL"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50458	backend
1062	[누구(nugu)] BE엔지니어	메디쿼터스	서울 강남구	경력 3~7년	["Go", "gRPC", "Kafka", "RDB", "NoSql", "MSA"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50944	backend
1063	[백엔드] 웹 백엔드 개발자	오앤	서울 강서구	경력 3~5년	["Spring Boot", "AWS", "Amazon EC2", "Redis"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50354	backend
1064	프론트엔드 개발자	리비바이오	서울 강남구	경력 2~7년	["NestJS", "React", "Zustand", "Recoil"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50608	backend
1065	백엔드 개발자 경력 채용	위볼린	서울 성동구	경력 3~7년	["TypeScript", "NestJS", "PostgreSQL"]	마감 기한: D-20	https://jumpit.saramin.co.kr/position/51052	backend
1066	[RE : IW] Server 신입 및 경력 채용	보이저	서울 구로구	신입~20년	["AZURE", "Unity", "ASP.NET", "MySQL"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50653	devops
1067	[RE : IW] AI 엔지니어	보이저	서울 구로구	신입~20년	["AI/인공지능", "C", "C++", "Python"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50658	data
1068	품질관리 보안솔루션 QA 담당자 모집	프라이빗테크놀로지	서울 마포구	경력 3~15년	["QA", "Windows", "Linux", "Network"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51324	qa
1069	JAVA개발(8년~10년)	위즈코리아	서울 강서구	경력 8~10년	["Java", "NoSql", "Apache Tomcat", "BigData"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50831	data
1070	쇼핑몰/헬스케어 서비스 개발자	보미오라한의원	서울 강남구	경력 3~10년	["CSS 3", "HTML5", "JavaScript", "Node.js"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50847	backend
1071	[병역특례]백엔드 산업기능요원 모집	리비바이오	서울 강남구	신입~2년	["Git", "REST API", "Node.js", "AWS"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50609	backend
1072	정보보호 인증 담당 모집	코닉글로리	서울 강남구	경력 3~10년	["Linux", "Network"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/51089	design
1073	보안 솔루션 엔지니어 (경력)	위드네트웍스	서울 강서구	경력 1~5년	["Python"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50248	security
1074	Sr. Backend Engineer	에이아이트릭스	서울 강남구	경력 5~10년	["MongoDB", "Golang", "MySQL", "Python"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50127	backend
1075	[PJ_Youkai] Server 신입 및 경력 채용	보이저	서울 구로구	신입~20년	["SQL", "Redis", "C++", "NoSql", "AZURE"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50654	devops
1076	데브옵스(DevOps) 엔지니어 (5년 이상)	씨드앤	서울 송파구	경력 5~10년	["Linux", "Kafka", "AWS", "AZURE", "Java"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51274	devops
1077	[RE : IW] 클라이언트 프로그래머	보이저	서울 구로구	신입~20년	["C++", "DirectX", "Redis", "Unity", "C#", "Git"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50657	game
1078	파이썬 백엔드 리드	샐러드랩	서울 강남구	경력 5~12년	["Python", "Django", "FastAPI", "AWS"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50777	backend
1079	시니어 백엔드 개발자(8년 이상)	씨드앤	서울 송파구	경력 8~10년	["Java", "JavaScript", "Kafka", "AWS", "AZURE"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51273	backend
1080	시니어 클라이언트 프로그래머 채용	보이저	서울 구로구	경력 6~20년	["C++", "DirectX", "Redis", "Unity", "C#"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50655	game
1081	백엔드 개발자 (5년 이상)	씨드앤	서울 송파구	경력 5~8년	["Java", "JavaScript", "Kafka", "AWS", "AZURE"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51272	backend
1082	[병역특례]프론트엔드 산업기능요원	리비바이오	서울 강남구	신입~2년	["JavaScript", "React", "Node.js", "jQuery"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50610	backend
1083	[PJ_Youkai] 네트워크 엔지니어 채용	보이저	서울 구로구	신입~20년	["SQL", "Redis", "C++", "NoSql", "AZURE"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50652	devops
1084	AI 기반 영상처리 개발자 (전문연구요원 가능)	이노뎁	서울 금천구	신입~10년	["Kafka", "MQTT", "PyTorch", "TensorFlow"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50157	data
1085	[AI연구소] AI연구-Computer Vision AI	딥노이드	서울 구로구	신입	["PyTorch", "TensorFlow", "Docker", "Linux"]	마감 기한: D-8	https://jumpit.saramin.co.kr/position/50130	devops
1086	[DX사업본부] 서비스 기획자	딥노이드	서울 구로구	경력 3~10년	["Figma", "Microsoft Office 365", "MySQL"]	마감 기한: D-8	https://jumpit.saramin.co.kr/position/50132	pm
1088	[의료R&D본부] 뇌영상연구팀 AI연구원	딥노이드	서울 구로구	경력 3~5년	["Python", "PyTorch", "TensorFlow"]	마감 기한: D-8	https://jumpit.saramin.co.kr/position/50134	data
1089	서버 개발자	마이베네핏	서울 서초구	경력 2~8년	["REST API", "MySQL", "Java"]	마감 기한: D-1	https://jumpit.saramin.co.kr/position/49855	backend
1090	웹 기반 영상분석 시스템 개발자 (전문연구요원 가능)	이노뎁	서울 금천구	신입~10년	["React", "Golang", "WebRTC", "Kafka"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50150	backend
1091	데이터분석가 신입/경력 채용	퍼플아카데미	서울 양천구	신입~3년	["Python", "MachineLearning"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/51006	data
1092	Frontend 개발자	스마트푸드네트웍스	서울 강남구	경력 4~15년	["Next.js", "React Query", "Jotai"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/51030	frontend
1093	DBA 담당(1~3년)	엑심베이	서울 구로구	경력 1~3년	["MySQL", "Java", "Slack", "Linux", "AWS"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51400	devops
1094	프론트엔드 및 앱 개발자 채용 (iOS)	아타드	서울 송파구, 부산 남구, 경기 성남시	경력 1~3년	["Objective-C", "Swift", "Java", "React"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/42829	frontend
1095	[ECS사업부문] 어플리케이션 아키텍트	플래티어	서울 송파구	경력 7~20년	["AWS", "AZURE", "Azure DevOps", "Python"]	마감 기한: D-3	https://jumpit.saramin.co.kr/position/49912	devops
1096	[인공지능] 개발자 채용	아타드	서울 송파구, 부산 남구, 경기 성남시	경력 1~3년	["DeepLearning", "MachineLearning", "AWS"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50262	devops
1097	딥러닝 추론 최적화 개발자	뷰런테크놀로지	서울 서초구	신입~10년	["C", "C++", "Python", "PyTorch", "TensorFlow"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51451	data
1098	[ECS사업부문] SI 프로젝트 PM	플래티어	서울 송파구	경력 15~20년	["JavaScript", "Spring Boot", "React", "Next.js"]	마감 기한: D-3	https://jumpit.saramin.co.kr/position/49914	backend
1099	기업부설연구소 HW 5년↓ 연구원 모집	오버컴테크	서울 금천구	신입~5년	["FPGA", "HW"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50508	other
1100	[백엔드,서버] 개발자 채용	아타드	서울 송파구, 부산 남구, 경기 성남시	경력 1~5년	["VPN", "Go", "Linux", "REST API", "C", "TCP/IP"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50264	backend
1102	IOS 개발 엔지니어 구인	고스트패스	서울 영등포구	경력 3~5년	["iOS", "SwiftUI", "Swift", "Git", "MVVM"]	마감 기한: D-day	https://jumpit.saramin.co.kr/position/49778	mobile
1103	이커머스 플랫폼 개발자 (경력직)	플래티어	서울 송파구	경력 2~10년	["Java", "JavaScript", "JSP", "Oracle", "MySQL"]	마감 기한: D-3	https://jumpit.saramin.co.kr/position/49915	frontend
1104	블록체인 인프라 개발자	아타드	서울 송파구, 부산 남구, 경기 성남시	경력 1~5년	["Golang", "Solidity", "Hyperledger Indy"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50263	backend
1105	AI Agent 개발자	포지큐브	서울 강남구	경력 1~8년	["Python", "JavaScript"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50544	frontend
1106	기업부설연구소 HW 10년↓ 연구원 모집	오버컴테크	서울 금천구	경력 5~10년	["FPGA", "HW"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50507	other
1107	GitLab 솔루션 엔지니어	플래티어	서울 송파구	경력 3~20년	["Jira", "Confluence", "Kubernetes"]	마감 기한: D-3	https://jumpit.saramin.co.kr/position/49917	devops
1108	Embedded SW 10년↑ 경력 연구원 모집	오버컴테크	서울 금천구	경력 10~20년	["FW", "RTOS", "Embedded"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50135	embedded
1109	Perception Engineer(자율주행 인지)	뷰런테크놀로지	서울 서초구	신입~10년	["C", "C++", "Python", "DeepLearning"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51450	other
1110	센서 칼리브레이션 엔지니어 채용	토르드라이브	서울 영등포구	경력 3~10년	["C++", "ROS", "Python", "OpenCV"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50068	robotics
1111	Frontend Developer(프론트엔드 개발자)	뷰런테크놀로지	서울 서초구	경력 5~10년	["JavaScript", "TypeScript", "Vue.js"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51456	frontend
1112	통합보안관리 엔지니어(경력)	이너버스	서울 영등포구	경력 3~7년	["SW", "Linux", "Docker", "Elasticsearch"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50497	devops
1113	생성형 AI B2B 서비스 프론트엔드 개발자 충원	필라넷	서울 강남구	경력 3~5년	["TypeScript", "React"]	마감 기한: D-29	https://jumpit.saramin.co.kr/position/51517	frontend
1115	Quality Engineer(4~10년)	뷰런테크놀로지	서울 서초구	경력 4~10년	["Selenium", "Python", "QA", "Appium"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51453	qa
1116	5G/LTE/IoT 단말검증 및 기술지원 신입	스톤위즈	서울 영등포구	신입	["AI/인공지능", "BigData", "SW"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/51144	data
1117	안드로이드 개발자(신입)	레트리카	서울 서초구	신입~2년	["Java", "RxJava", "OpenGL", "OpenCV"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/51412	other
1118	Mobile App Engineer_React Native	브레이브모바일	서울 강남구	경력 1~3년	["React", "React Native", "TypeScript"]	마감 기한: D-26	https://jumpit.saramin.co.kr/position/51448	frontend
1119	5G/LTE/IoT 단말검증 및 기술지원 경력	스톤위즈	서울 영등포구	경력 3~10년	["AI/인공지능", "BigData", "SW"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/51145	data
1120	[DX사업본부] DevOps Engineer	딥노이드	서울 구로구	경력 3~10년	["Java", "Kotlin", "Spring Boot", "Kafka"]	마감 기한: D-8	https://jumpit.saramin.co.kr/position/50131	backend
1121	System Engineer	뷰런테크놀로지	서울 서초구	신입~5년	["C", "C++", "Python", "GUI"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51449	design
1101	Deep Learning Engineer	뷰런테크놀로지	서울 서초구	신입~10년	["C", "C++", "Python"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51454	AI
1124	백엔드 개발자 총괄 채용	아이스크림아트	서울 강남구	경력 10~15년	["Node.js", "React", "TypeScript", "NestJS"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/51060	backend
1125	Backend Developer(백엔드 개발자)	뷰런테크놀로지	서울 서초구	경력 5~10년	["Golang", "Linux"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51457	backend
1126	[PJ_Youkai] 클라이언트 프로그래머	보이저	서울 구로구	신입~20년	["C++", "DirectX", "Redis"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50656	data
1127	프론트엔드 주니어 개발자(HD)	알스퀘어	서울 강남구	경력 5~7년	["JavaScript", "TypeScript", "React", "vuex"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51366	frontend
1128	회로설계 (하드웨어 및 펌웨어) 개발자	누코드	서울 강남구	경력 2~5년	["Autocad", "Orcad", "Embedded"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50606	embedded
1129	[격주 4.5일 근무] 린컴퍼니 전산실 ERP, 쇼핑몰 개발 및 운영	린컴퍼니	서울 강남구	경력 5~15년	["Java", "Spring", "Miplatform", "ERP", "Oracle"]	마감 기한: 상시	https://jumpit.saramin.co.kr/position/10287	backend
1130	프론트엔드 개발자	와탭랩스	서울 서초구	경력 3~6년	["React"]	마감 기한: D-day	https://jumpit.saramin.co.kr/position/49821	frontend
1131	서버 엔지니어	와탭랩스	서울 서초구	경력 10~20년	["Linux", "Windows", "Python", "Shell"]	마감 기한: D-day	https://jumpit.saramin.co.kr/position/49822	backend
1132	의료IT 클라우드 인프라 경력 채용	이지케어텍(edge&next)	서울 중구	경력 1~18년	["C#", "WPF", ".NET", "Oracle", "JavaScript"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50124	frontend
1133	LIS System 개발 및 운영	오픈헬스케어	서울 성동구	경력 5~15년	[".NET", "C#", "Java", "Nexacro", "REST API"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/49998	other
1134	[개발] Backend Developer/2~4년	빌드코퍼레이션	서울 강남구	경력 2~4년	["Node.js", "Next.js", "GitHub Actions"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50305	backend
1135	모바일파트- Android Native 개발	비바이노베이션	서울 강남구	경력 5~15년	["Kotlin", "Jetpack", "XML", "Coroutine", "Flow"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/50083	mobile
1137	AI (LLM RAG) 개발자 / 3~5년	셀키	서울 서초구	경력 3~5년	["Python", "PyTorch", "Amazon SageMaker"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50432	data
1139	웹디자이너 / 퍼블리셔 / React 개발자 모집	한국비즈넷	서울 구로구	경력 1~5년	["Adobe Photoshop", "HTML5", "CSS 3"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50770	frontend
1140	백엔드(Node.js) 개발자	클라썸	서울 강남구	경력 2~8년	["AWS", "GCP", "Node.js", "JavaScript"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51212	backend
1141	ITSM 구축 PM&PL 엔지니어	플래티어	서울 송파구	경력 5~20년	["Azure DevOps", "Python"]	마감 기한: D-3	https://jumpit.saramin.co.kr/position/49919	devops
1142	클라우드 인프라 엔지니어	아타드	서울 송파구, 부산 남구, 경기 성남시	경력 1~5년	["IBM Containers", "Node.js", "Network"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/32125	backend
1143	[그루비 SaaS 솔루션] AI 엔지니어	플래티어	서울 송파구	경력 3~7년	["Python", "R", "TensorFlow", "PyTorch", "NLP"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50183	data
1144	프론트엔드 개발자 (*CGM의료기기)	아이센스(caresens)	서울 서초구	경력 10~15년	["React", "Vue.js", "HTML5", "CSS 3"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50911	frontend
1145	언리얼 게임개발 과정 교강사(신입)	경일게임아이티아카데미	서울 강동구	신입~30년	["C++", "Unreal Engine"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49907	game
1146	프론트엔드 엔지니어(경력 6~8년)	클래스101	서울 강남구	경력 6~8년	["React", "TypeScript", "GraphQL", "Apollo"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50399	frontend
1147	AI (LLM RAG) 개발자 / 9년↑	셀키	서울 서초구	경력 9~20년	["Python", "PyTorch", "Amazon SageMaker"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50435	data
1148	LLM 어플리케이션 엔지니어	넥스큐브코퍼레이션	서울 금천구	경력 3~5년	["Rest.li", "JavaScript", "Node.js"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50706	backend
1149	AI (LLM RAG) 개발자 / 6~8년	셀키	서울 서초구	경력 6~8년	["Python", "PyTorch", "Amazon SageMaker"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50434	data
1150	유니티 게임개발 과정 교강사(경력)	경일게임아이티아카데미	서울 강동구	신입~30년	["Unity"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50614	game
1151	모바일파트- IOS 개발	비바이노베이션	서울 강남구	경력 5~15년	["Swift"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/50974	mobile
1152	데브옵스 엔지니어	아이헤이트플라잉버그스	서울 영등포구	경력 3~10년	["AWS", "Kubernetes", "Terraform", "Kafka"]	마감 기한: D-26	https://jumpit.saramin.co.kr/position/51245	devops
1153	[개발] Backend Developer/5~7년	빌드코퍼레이션	서울 강남구	경력 5~7년	["Node.js", "Next.js", "GitHub Actions"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50308	backend
1154	서버 파트 부문(경력)	비바이노베이션	서울 강남구	경력 5~15년	["Python", "FastAPI", "Django", "Celery"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/50973	backend
1155	Back-End 개발자 채용	브이씨	서울 강남구	경력 5~10년	["SQL", "Spring Data JPA"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51159	backend
1156	아틀라시안&데브옵스 솔루션 엔지니어	플래티어	서울 송파구	경력 3~10년	["Linux", "Windows", "MySQL", "Oracle", "Jira"]	마감 기한: D-3	https://jumpit.saramin.co.kr/position/49916	design
1157	UI/UX 테스트 자동화 솔루션 엔지니어	플래티어	서울 송파구	경력 3~20년	["SAP", "Azure DevOps"]	마감 기한: D-3	https://jumpit.saramin.co.kr/position/49920	devops
1158	백엔드 개발자 (*CGM의료기기)	아이센스(caresens)	서울 서초구	경력 10~15년	["JavaScript", "Golang", "Linux", "Docker"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50913	backend
1159	자율주행 하드웨어 전장 엔지니어	토르드라이브	서울 영등포구	경력 3~10년	["HW"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50791	other
1160	Field Application Engineer (HIL) 신입	디스페이스코리아	서울 서초구	신입	["MATLAB", "Python", "SW", "HW", "ethernet"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/49929	other
1161	선행 연구 개발 (SW), 비전 장비 개발	엔클로니	서울 구로구	신입~5년	["C++", "C#", "SW", "CUDA"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50371	other
1162	QA/QC manager	아이브	서울 서초구	경력 10~15년	["QA", "HW", "SW"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50625	qa
1163	반도체 회로 설계 개발자 (신입)	블루닷	서울 강남구	신입~2년	["Git", "GitHub", "iOS", "Python", "AWS"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/51054	mobile
1164	백엔드 개발 (경력 1~5년)	에이치비엠피	서울 구로구	경력 1~5년	["GitHub", "MySQL", "Node.js", "Amazon EC2"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50212	backend
1165	Backend Developer	쏘카	서울 성동구	경력 5~7년	["Java", "Kotlin", "Spring Boot", "OAuth2"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50621	backend
1166	생성형 AI 데이터사이언티스트	애자일소다	서울 강남구	신입~10년	["Python", "TensorFlow", "DeepLearning"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50560	data
1167	인공지능 AI 개발자	피피에스	서울 광진구	경력 1~20년	["REST API", "API Tracker", "Unity"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51196	data
1168	풀스택 소프트웨어 엔지니어(AI)	애자일소다	서울 강남구	경력 2~10년	["Python", "React", "TypeScript"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50571	frontend
1169	R&D 기술전략실 PM 채용	채비	서울 서초구	경력 7~20년	["SW"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50460	pm
1170	자율주행로봇 백엔드 엔지니어 (서울)	폴라리스쓰리디	서울 용산구	경력 5~8년	["Java", "Spring Boot", "REST API", "MySQL"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50619	backend
1171	3D Vision Algorithm Engineer	아이브	서울 서초구	경력 2~7년	["Milanote", "OpenCV", "C++", "Git"]	마감 기한: D-day	https://jumpit.saramin.co.kr/position/49775	backend
1172	LLM Research Engineer	옵트에이아이	서울 강서구	신입~10년	["MachineLearning", "DeepLearning", "FPGA"]	마감 기한: D-7	https://jumpit.saramin.co.kr/position/50140	other
1173	프론트엔드 개발자 시니어 채용 [본사]	잇올	서울 서초구	경력 7~10년	["Yarn", "React", "Next.js", "TypeScript"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50195	frontend
1174	Vision System SW Junior 개발자	아이브	서울 서초구	경력 1~5년	["SW", "C++", "C", "JavaScript", "Python"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50622	frontend
1175	RTOS F/W 개발 경력 모집	유니온바이오메트릭스	서울 송파구	경력 3~15년	["RTOS", "FW", "MCU", "Network", "C", "C++"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50750	embedded
1176	Embedded Hardware Engineer (Senior)	웨어러블에이아이	서울 영등포구	경력 3~10년	["MCU", "PCB"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50373	embedded
1177	전산팀 (서버/ERP/개발) 경력직 채용	신보	서울 마포구	경력 3~6년	["Java", "JavaScript", "Spring", "Mybatis"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51399	backend
1178	프론트엔드 개발자 주니어 채용 [본사]	잇올	서울 서초구	경력 3~6년	["Yarn", "React", "Next.js", "TypeScript"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50194	frontend
1179	포탈 웹사이트 Front-End 개발자 경력	아이디에스앤트러스트	서울 강남구	경력 3~8년	["Java", "Spring Framework", "React"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50236	backend
1180	의료IT 모바일 인공지능 경력 채용	이지케어텍(edge&next)	서울 중구	경력 1~18년	["C#", "WPF", ".NET", "Oracle", "JavaScript"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50126	frontend
1181	데브옵스 엔지니어	케이웨더	서울 구로구	신입~3년	["Docker", "Kubernetes", "CDNetworks"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50315	devops
1182	의료IT S/W 개발직 경력 채용	이지케어텍(edge&next)	서울 중구	경력 2~18년	["C#", "WPF", ".NET", "Oracle", "JavaScript"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50122	frontend
1183	클라우드 서버 네트워크	이지케어텍(edge&next)	서울 중구	경력 1~18년	["AWS", "AZURE", "GCP", "Linux", "Windows"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50215	backend
1184	[개발] Backend Developer/8~10년	빌드코퍼레이션	서울 강남구	경력 8~10년	["Node.js", "Next.js", "GitHub Actions"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50309	backend
1185	Linux App 개발 경력 모집	유니온바이오메트릭스	서울 송파구	경력 3~15년	["Linux", "Qt", "Java", "Kotlin"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50751	mobile
1186	기술개발 경력(SolutionEngineer)	엔클로니	서울 구로구	경력 4~10년	["C++", "C", "Embedded", "SW", "Solidworks"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51300	embedded
1187	의료기기 S/W 개발자(서울, 경력 3~6년)	프리시젼바이오	서울 서초구	경력 3~6년	["C"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51508	other
1188	Model Compression Research Engineer	옵트에이아이	서울 강서구	신입~10년	["MachineLearning", "DeepLearning", "FPGA"]	마감 기한: D-7	https://jumpit.saramin.co.kr/position/50138	other
1189	[보안운영팀] 플랫폼 운영/개발 경력사원 채용	롯데이노베이트	서울 금천구	경력 5~7년	["Splunk", "ELK", "Linux", "Log4j"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/51344	security
1190	SAP MM 운영(ABAP개발)경력	아이디에스앤트러스트	서울 강남구	경력 7~14년	["SAP", "ABAP", "ERP", "Oracle", "SQL", "DB2"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50235	other
1191	백엔드 개발 (경력 11~년)	에이치비엠피	서울 구로구	경력 11~15년	["GitHub", "MySQL", "Node.js", "Amazon EC2"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50214	backend
1192	제어SW 엔지니어	아이브	서울 서초구	경력 1~5년	["Git", "C++", "C", "PLC", "MES", "TCP/IP"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50623	robotics
1193	Linux/Android BSP 개발 경력 모집	유니온바이오메트릭스	서울 송파구	경력 3~15년	["Linux", "FW", "C", "C++"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50752	mobile
1194	인프라 경력사원 채용 (9년↑)	테크핀레이팅스	서울 중구	경력 9~20년	["Infra", "Linux", "HW", "SW", "DB"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51415	devops
1195	풀스택 앱 개발 (경력 5~8년)	에이치비엠피	서울 구로구	경력 5~8년	["Angular 2", "Node.js", "React", "MySQL"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50210	backend
1196	선행연구 S/W 개발자(C언어) / 팀장	엔클로니	서울 구로구	경력 10~20년	["C++", "C", "Embedded Linux", "C#", "SW"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50372	design
1197	Vision AI 제품 코어 개발 엔지니어	씨이랩	서울 강남구	경력 3~10년	["AI/인공지능", "PyTorch", "MachineLearning"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/51005	data
1198	기술개발 신입/경력(SolutionEngineer)	엔클로니	서울 구로구	신입~3년	["C++", "C", "Embedded", "SW", "Solidworks"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51299	embedded
1199	[SCK 및 관계사] Microsoft 프로젝트 및 기술지원	에쓰씨케이	서울 강남구	경력 5~15년	["Microsoft Teams", "Microsoft Office 365"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50702	robotics
1200	On-Device AI Engineer (C++)	옵트에이아이	서울 강서구	신입~10년	["MachineLearning", "DeepLearning", "FPGA"]	마감 기한: D-7	https://jumpit.saramin.co.kr/position/50139	data
1201	반도체 회로 설계 개발자 (경력)	블루닷	서울 강남구	경력 3~12년	["Git", "GitHub", "iOS", "Python", "AWS"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/51053	mobile
1202	병원정보시스템 S/W 경력 개발자	이지케어텍(edge&next)	서울 중구	경력 2~18년	["C#", "WPF", ".NET", "Oracle", "JavaScript"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50470	frontend
1203	데이터 엔지니어	메이븐클라우드서비스	서울 강남구	경력 5~20년	["AZURE", "Django", "Flask", "React", "CSS 3"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/51020	backend
1204	하이브리드 앱 개발자	케이웨더	서울 구로구	경력 3~10년	["React Native"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50316	frontend
1205	[펀픽] 플러터(Flutter) 개발자 채용	아이디자인랩	서울 마포구	경력 3~10년	["Flutter", "MariaDB", "MySQL", "Python"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/50035	mobile
1206	백엔드 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~6년	["PostgreSQL", "Kafka", "Spring Boot", "Git"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50445	backend
1207	SW개발_Measurement파트 채용	알피니언메디칼시스템	서울 강서구	경력 2~15년	["Windows", "C++", "C", "Visual C++", "C#"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50052	other
1208	기술연구소 연구개발직 채용	금영제너럴	서울 광진구	신입~10년	["HW", "SW", "C"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50388	other
1209	웹서버 개발자 신입 채용	에프엘이에스	서울 강서구	신입	["C++", "Java", "React", "Spring"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/50721	backend
1210	프론트엔드 개발자 (Next JS)_서울	뉴아이	서울 서초구	경력 3~15년	["HTML5", "CSS 3", "Java", "JavaScript"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51295	frontend
1211	JAVA 풀스택 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["Java", "JavaScript", "Spring", "Mybatis", "DB"]	마감 기한: D-day	https://jumpit.saramin.co.kr/position/49432	backend
1212	리엑트네이티브 채용	미스고	서울 강남구	신입~10년	["Java", "React Native", "React D3 Library"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50337	frontend
1214	백엔드 개발자 신입 채용	에프엘이에스	서울 강서구	신입	["PostgreSQL", "Kafka", "Spring Boot", "Git"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/49880	backend
1215	Vue.js 프론트엔드 개발자	더스포츠커뮤니케이션	서울 강서구	경력 3~5년	["Vue.js"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/51331	frontend
1216	서버/백엔드 (3년이상)	매쓰마스터	서울 강서구	경력 3~5년	["Java", "Spring Boot", "Git", "MySQL", "Redis"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51155	backend
1217	flutter 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["Flutter", "Linux", "Git", "Node.js"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49877	backend
1218	시스템 사업부 신입 엔지니어	이비즈테크	서울 마포구	신입	["Azure DevOps", "Azure DevOps Server"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50106	devops
1219	서비스 운영 (*CGM의료기기)	아이센스(caresens)	서울 서초구	경력 10~15년	["Infra", "Golang", "Python", "Java"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50914	backend
1220	Python 응용 소프트웨어 운용	엠코프	서울 강동구	신입~10년	["C++", "Lua", "BigData", "C#"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51252	data
1221	풀스택 개발자 채용	부동산플래닛	서울 강남구	경력 7~9년	["Java", "Spring Boot", "PostgreSQL", "Redis"]	마감 기한: D-3	https://jumpit.saramin.co.kr/position/49948	backend
1222	IOS 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["iOS", "Swift", "Objective-C"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49872	mobile
1223	클라우드 사업부 엔지니어	이비즈테크	서울 마포구	신입~3년	["Azure DevOps", "Azure DevOps Server"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50104	devops
1224	flutter 개발자 신입 채용	에프엘이에스	서울 강서구	신입	["Flutter", "Linux", "Git", "Node.js"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/50584	backend
1225	웹퍼블리셔 신입 채용	에프엘이에스	서울 강서구	신입	["Zeplin", "Vue.js", "JavaScript", "jQuery"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49875	frontend
1226	[펀픽] AI 기반 백엔드 개발자 채용	아이디자인랩	서울 마포구	경력 3~10년	["Python", "MySQL"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/50034	backend
1227	웹 개발자 신입 채용	에프엘이에스	서울 강서구	신입	["MySQL", "PHP", "React", "Node.js", "Laravel"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49874	backend
1228	웹퍼블리셔 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["Zeplin", "Vue.js", "JavaScript", "jQuery"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49876	frontend
1229	Node.js 서버/백엔드 개발자	더스포츠커뮤니케이션	서울 강서구	신입~3년	["Node.js"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/51329	backend
1230	에이전시 PHP 백엔드 채용[대리]	코워커넷	서울 은평구	경력 1~5년	["PHP", "MySQL", "Laravel", "Linux", "MariaDB"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50461	backend
1231	프론트엔드 개발자(전환형/체험형 인턴)	링글잉글리시에듀케이션서비스	서울 강남구	신입	["React", "Redux", "SCSS"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50506	frontend
1232	포탈 웹사이트 Back-end 개발자 경력직	아이디에스앤트러스트	서울 강남구	경력 3~12년	["Spring Framework", "Java", "Kotlin", "React"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50237	backend
1233	기술융합사업부 IT 프로젝트 PM/서브PM	엠더블유네트웍스	서울 강남구	신입~5년	["react-testing-library", "QA", "Flow"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50636	frontend
1234	정보보안 담당자 경력 채용	에프엘이에스	서울 강서구	경력 2~5년	["SecureCRT"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/50720	security
1235	NPU 컴파일러 개발 엔지니어	아티크론	서울 동대문구	신입	["C", "C++", "Python", "Linux", "TensorFlow"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50667	data
1236	보안 솔루션 엔지니어 신입 채용	에프엘이에스	서울 강서구	신입	["Java", "Oracle", "SQL", "MariaDB", "C++"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50579	security
1237	데이터베이스 개발자 Oracle DW Mart ETL	잇솔루션	서울 강남구	경력 3~20년	["Oracle PL/SQL", "Dw", "Etl", "RDB"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51406	data
1238	프론트엔드 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["Node.js", "Java", "AWS"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50446	backend
1239	웹 풀스택 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~6년	["Java", "JavaScript", "Python", "HTML5"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50447	frontend
1240	보안 솔루션 엔지니어 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["Java", "Oracle", "SQL", "MariaDB", "C++"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50580	security
1241	웹서버 개발자 경력 채용	에프엘이에스	서울 강서구	경력 2~5년	["C++", "Java", "React", "Spring"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/50722	backend
1242	인프라 엔지니어 신입 채용	에프엘이에스	서울 강서구	신입	["Docker", "TypeScript", "AWS", "AZURE"]	마감 기한: D-20	https://jumpit.saramin.co.kr/position/50723	frontend
1243	의료영상 3차원 개발자 채용(1~3)	제이피아이헬스케어	서울 구로구	경력 1~3년	["C", "C#", "C++", "DeepLearning"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51063	other
1244	임베디드 개발자 신입 채용	에프엘이에스	서울 강서구	신입	["RTOS", "Python", "C++", "C", "HW", "FW"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50049	embedded
1245	임베디드 소프트웨어 개발자(7년↑)	엔엑스	서울 서초구	경력 7~10년	["C", "C#", "Embedded", "Linux", "FW", "C++"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51395	design
1246	클라우드 엔지니어 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["AZURE", "GCP", "AWS", "DB", "BigData"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50582	devops
1247	에이전시 PHP 백엔드 채용[과장]	코워커넷	서울 은평구	경력 6~10년	["PHP", "MySQL", "Laravel", "Linux", "MariaDB"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50462	backend
1248	웹 풀스택 개발자 경력직 채용	세무법인프라이어	서울 강남구	경력 5~10년	["MySQL", "PostgreSQL", "Python"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50524	fullstack
1249	펌웨어 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["C++", "VHDL", "Python", "MATLAB", "Git"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49873	embedded
1250	웹 진단 모의해킹 (3~6년)	대진정보통신	서울 관악구	경력 3~6년	["Hack", "Azure Security Center", "ISMS"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/49951	devops
1251	하드웨어 개발자 신입 채용	에프엘이에스	서울 강서구	신입	["HW", "Embedded", "PCB", "ARM"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/49878	embedded
1253	택스아이 개발팀리더	뉴아이	서울 서초구	경력 4~15년	["HTML5", "CSS 3", "Java", "JavaScript"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51294	frontend
1254	정보보안 담당자 신입 채용	에프엘이에스	서울 강서구	신입	["SecureCRT"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/50719	security
1255	node.js 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~6년	["Node.js", "AWS", "REST API"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50444	backend
1256	시니어 백엔드 경력직 (6년 이상)	이노소니언	서울 서초구	경력 6~20년	["Python", "Django", "MySQL", "PostgreSQL"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51334	backend
1257	웹 개발자	에프엘이에스	서울 강서구	경력 2~6년	["MySQL", "PHP", "React", "Node.js", "Laravel"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50047	backend
1258	PHP 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~6년	["PHP", "JavaScript", "Node.js"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50443	backend
1259	데이터 엔지니어 경력직 채용	에프엘이에스	서울 강서구	경력 2~6년	["MSSQL", "DB", "AWS", "PHP", "MySQL"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50448	devops
1260	클라우드 엔지니어 신입 채용	에프엘이에스	서울 강서구	신입	["AZURE", "GCP", "AWS", "DB", "BigData"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50581	devops
1261	인프라 엔지니어 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["Docker", "TypeScript", "AWS", "AZURE"]	마감 기한: D-20	https://jumpit.saramin.co.kr/position/50724	frontend
1262	LLM Researcher (병역특례)	애자일소다	서울 강남구	신입~5년	["Python", "TensorFlow", "PyTorch"]	마감 기한: D-day	https://jumpit.saramin.co.kr/position/49817	data
1264	Document AI Researcher (병역특례)	애자일소다	서울 강남구	신입~5년	["Python", "TensorFlow", "PyTorch", "Docker"]	마감 기한: D-day	https://jumpit.saramin.co.kr/position/49816	devops
1265	[석사/경력]영상처리/rPPG 연구개발	바이오커넥트	서울 서초구	경력 1~10년	["OpenCV", "DeepLearning", "Python"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50384	other
1266	Data Scientist in Financial (4~6년)	페니로이스	서울 종로구	경력 4~6년	["Python", "R", "BigData", "MachineLearning"]	마감 기한: D-20	https://jumpit.saramin.co.kr/position/51112	data
1268	프론트엔드 개발자_5년 이상	펫박스	서울 마포구	경력 5~7년	["React", "REST API", "HTML5"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50539	frontend
1269	Product Engineer	코드스테이츠	서울 성동구	경력 2~5년	["React", "Next.js", "TypeScript", "REST API"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50538	frontend
1270	QA Engineer (경력 11년↑)	페이타랩	서울 강남구	경력 11~20년	["QA", "Jenkins"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50840	qa
1271	Java Backend 서비스 개발자 모집	트럼피아	서울 강남구	경력 7~15년	["Elasticsearch", "MariaDB", "Docker"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50782	backend
1272	웹 백엔드 개발자 (3년 이상)	뉴스젤리	서울 성동구	경력 3~6년	["Python", "Java", "Django", "FastAPI", "Flask"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50841	backend
1273	프론트엔드 주니어 개발자 (2~4년차)	팬딩	서울 강남구	경력 2~4년	["Vue.js"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51234	frontend
1274	프론트엔드 개발자 (경력 5~10년)	브레인즈컴퍼니	서울 성동구	경력 5~10년	["Java", "Spring Framework", "React", "SQL"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50334	backend
1275	AI 엔지니어(이미지 생성 AI 서비스)	바이스벌사	서울 서초구	경력 3~5년	["PyTorch", "TensorFlow", "AWS", "GCP"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/50769	devops
1276	Software Engineer (Front-End)	부스터스	서울 강남구	경력 2~5년	["Vue.js", "jQuery", "TailwindCSS", "Bootstrap"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51192	frontend
1277	QA Engineer (경력 1~5년↓)	페이타랩	서울 강남구	경력 1~5년	["QA", "Jenkins"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50837	qa
1279	웹 프론트엔드 개발자 (3년 이상)	뉴스젤리	서울 성동구	경력 3~6년	["React", "Next.js", "Vue.js", "JavaScript"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50836	frontend
1280	MVL [TADA] Backend Engineer 채용	이지식스(엠블)	서울 강남구	경력 3~10년	["TypeScript", "NestJS", "Node.js", "SQL"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51302	backend
1281	iOS APP 개발자 채용	아이파킹	서울 금천구	경력 2~5년	["iOS", "Swift", "Flutter", "Objective-C", "Kotlin"]	마감 기한: D-3	https://jumpit.saramin.co.kr/position/49997	mobile
1282	연구소 풀스텍 개발(java)	프라이빗테크놀로지	서울 마포구	경력 4~10년	["Java", "MySQL", "Spring", "JavaScript"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50632	backend
1283	백엔드 개발자	아이트럭	서울 서초구	경력 3~10년	["Node.js", "TypeScript", "MySQL", "Ubuntu"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/50987	backend
1284	플랫폼 서비스 개발자 경력 채용	인공지능팩토리	서울 중구	경력 1~5년	["AWS", "GCP", "AZURE", "Cloud CMS", "Java"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51206	devops
1285	QA Engineer (경력 6~10년↓)	페이타랩	서울 강남구	경력 6~10년	["QA", "Jenkins"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50839	qa
1286	웹 서비스 자바 개발자	비즈톡	서울 강남구	경력 5~10년	["REST API", "C++", "Linux", "Java", "C"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51057	design
1287	Software Engineer (Back-End)	부스터스	서울 강남구	경력 2~5년	["SW", "ScrapingBot", "Linux", "MySQL"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51193	backend
1288	React Native 주니어 개발자 (2~4년차)	팬딩	서울 강남구	경력 2~4년	["React"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51232	frontend
1289	백앤드 개발(2-10년)	더블유닷에이아이	서울 서초구	경력 2~10년	["MySQL", "Spring Boot", "Java"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51419	backend
1290	Python 백엔드 개발자	펫박스	서울 마포구	경력 3~5년	["MySQL", "PHP", "Python", "Selenium"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50541	backend
1291	웹 개발자 책임급	뉴스젤리	서울 성동구	경력 6~10년	["React", "Next.js", "Vue.js", "Python", "Java"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50838	frontend
1292	[이즈파크] PLM 프로젝트 PM	이즈파크	서울 금천구	경력 8~20년	["Java", "MSSQL", "Oracle"]	마감 기한: 상시	https://jumpit.saramin.co.kr/position/20547	pm
1293	[이즈파크] PLM 개발자	이즈파크	서울 금천구	경력 3~15년	["Java", "JavaScript", "JSP"]	마감 기한: 상시	https://jumpit.saramin.co.kr/position/20878	frontend
1294	SW개발_Platform파트 선임~책임급 채용	알피니언메디칼시스템	서울 강서구	경력 2~15년	["Visual C++", "C", "C++", "WPF", "JavaScript"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50053	frontend
1295	프론트엔드 리드 개발자 (5~10년차)	팬딩	서울 강남구	경력 5~10년	["Vue.js"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51233	frontend
1296	FinOps Junior 컨설턴트	메타넷글로벌	서울 강남구	경력 1~4년	["Azure DevOps"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50552	devops
1297	Infra/시스템 아키텍처 (11~13년)	메타넷글로벌	서울 강남구	경력 11~13년	["Python", "MSA", "Kafka", "MariaDB"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50556	other
1298	시스템 엔지니어 채용	소프트넷	서울 강남구	경력 3~15년	["Windows Server", "Azure Synapse"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50761	devops
1301	Infra/시스템 아키텍처 (4~7년)	메타넷글로벌	서울 강남구	경력 4~7년	["Python", "MSA", "Kafka", "MariaDB"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50554	other
1302	백엔드개발자 시니어채용(8~10년)	비큐에이아이	서울 중구	경력 8~10년	["Spring Boot", "Flask", "FastAPI"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51418	backend
1303	Java 개발자 책임급	아주큐엠에스	서울 서초구	경력 8~12년	["Java", "JavaScript", "jQuery", "Oracle"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/48618	frontend
1304	JAVA개발(5년~7년)	위즈코리아	서울 강서구	경력 5~7년	["Java", "NoSql", "Apache Tomcat", "BigData"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50830	data
1305	백엔드개발자 시니어채용(11~13년)	비큐에이아이	서울 중구	경력 11~13년	["Spring Boot", "Flask", "FastAPI"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51417	backend
1307	백엔드 개발자 채용	서울거래	서울 영등포구	경력 3~99년	["Python", "Django", "Git", "AWS"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51536	backend
1308	서비스개발 총괄매니저 채용	서울거래	서울 영등포구	경력 7~99년	["Python", "Flutter"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51533	mobile
1309	Infra/시스템 아키텍처 (8~10년)	메타넷글로벌	서울 강남구	경력 8~10년	["Python", "MSA", "Kafka", "MariaDB"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50555	other
1310	서버 프로그래머 팀장급 채용	보이저	서울 구로구	경력 8~20년	["MySQL", "AZURE", "SQL", "C#", "C++", "Unity"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50659	backend
1311	자율주행 경로생성 SW 엔지니어(전문연 지원 가능)	에이스웍스코리아	서울 강남구	경력 3~15년	["C++", "Python"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50696	other
1312	리눅스 개발	프라이빗테크놀로지	서울 마포구	경력 3~15년	["C++", "Linux", "Qt", "VPN", "C", "MVVM", "Git"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50629	design
1313	프로덕트관리 및 개발PM 담당자	프라이빗테크놀로지	서울 마포구	경력 10~20년	["Jira", "Network", "Infra", "Insight", "ISMS"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50633	security
1314	[인공지능솔루션] ML Engineer	제논	서울 강남구	경력 3~20년	["Docker", "PyTorch", "Kubernetes"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50938	devops
1315	프론트엔드 개발자 경력 (5년 이상)	디윅스	서울 강남구	경력 5~20년	["JavaScript", "TypeScript", "React", "HTML5"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51327	frontend
1316	Software QA Manager	에이아이트릭스	서울 강남구	경력 3~8년	["Apache JMeter", "Postman", "Playwright"]	마감 기한: D-26	https://jumpit.saramin.co.kr/position/51317	qa
1317	플랫폼 서비스 개발자 채용	유니버스에이아이	서울 영등포구	경력 2~10년	["Node.js", "Python", "PostgreSQL", "Infra"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51538	backend
1318	TA(Technical Architect)/DBA	메타넷글로벌	서울 강남구	경력 10~16년	["Oracle", "ERP", "Tibero"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50553	other
1319	백엔드 리드 개발자 (5~10년차)	팬딩	서울 강남구	경력 5~10년	["REST API"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51236	backend
1320	QA Engineer (3년 이상)	올거나이즈코리아	서울 강남구	경력 3~10년	["QA", "Python", "SW"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51371	qa
1321	[신입] Flutter 앱 & Node.js 개발자	인졀미	서울 서초구	신입~4년	["TypeScript", "Node.js", "PostgreSQL"]	마감 기한: D-27	https://jumpit.saramin.co.kr/position/51472	backend
1323	프론트엔드 개발자_8년 이상	펫박스	서울 마포구	경력 8~10년	["React", "REST API", "HTML5"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50540	frontend
1324	Infra 엔지니어 (3~5년)	메타넷글로벌	서울 강남구	경력 3~5년	["Python", "MSA", "Kafka", "MariaDB"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50557	other
1325	개발팀장	아이트럭	서울 서초구	경력 7~25년	["MachineLearning", "AI/인공지능"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/50986	data
1326	보안 소프트웨어 설치 및 기술지원	프라이빗테크놀로지	서울 마포구	경력 5~10년	["SW", "CISSP", "CISA", "VPN", "Infra"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50346	security
1327	이커머스 풀스템 팀장 앱웹	펫박스	서울 마포구	경력 8~15년	["React Native", "Next.js", "TypeScript"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50543	frontend
1328	시니어 프론트엔드 개발자	아이트럭	서울 서초구	경력 5~10년	["JavaScript", "Kotlin", "Node.js", "REST API"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/50984	backend
1329	C/C++개발(3년~6년)	위즈코리아	서울 강서구	경력 3~6년	["Linux", "C", "C++", "C#", "Java"]	마감 기한: D-20	https://jumpit.saramin.co.kr/position/51116	design
1330	[TADA] Infra/DevOps engineer 채용	이지식스(엠블)	서울 강남구	경력 3~8년	["AWS", "Kubernetes", "Infra"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51301	devops
1331	기술지원 담당자 모집	프라이빗테크놀로지	서울 마포구	경력 5~15년	["QA", "SW", "Infra", "VPN", "Network", "CISSP"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51345	qa
1332	AI 엔지니어	럭스로보	서울 서초구	경력 5~15년	["MachineLearning", "DeepLearning"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51525	data
1333	JavaScript 프론드엔드 개발자 채용	서울거래	서울 영등포구	경력 3~99년	["Java", "HTML5", "CSS 3", "jQuery", "Django"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51532	backend
1334	생성형 AI/LLM 엔지니어	바이스벌사	서울 서초구	경력 3~5년	["PyTorch", "TensorFlow", "AWS", "GCP"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/50767	devops
1337	리눅스 네트워크 프로그래머	노아시스템즈	서울 성동구	경력 5~10년	["Linux", "Utm", "C", "TCP/IP", "Git", "C++"]	마감 기한: D-day	https://jumpit.saramin.co.kr/position/49638	design
1338	Windows 커널 드라이버 개발	프라이빗테크놀로지	서울 마포구	경력 7~20년	["Windows", "C", "C++", "Network", "Mfc"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/49926	other
1339	Python 백엔드 개발자_6년~8년	펫박스	서울 마포구	경력 6~8년	["MySQL", "PHP", "Python", "Selenium"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50542	backend
1340	Infra 엔지니어 (9~15년)	메타넷글로벌	서울 강남구	경력 9~15년	["Python", "MSA", "Kafka", "MariaDB"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50559	other
1341	아틀라시안 개발	오픈소스컨설팅	서울 강남구	경력 3~12년	["Java", "Confluence", "Jira", "Trello"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/49975	other
1342	보안관제 개발	프라이빗테크놀로지	서울 마포구	경력 3~20년	["Network", "Infra", "Python", "DB", "ELK"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50634	security
1343	백엔드 개발자 경력 (5년이상)	디윅스	서울 강남구	경력 5~20년	["Spring Framework", "AI/인공지능"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51328	backend
1344	RAG Researcher / Engineer	올거나이즈코리아	서울 강남구	경력 2~10년	["AI/인공지능", "NLP", "DeepLearning"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51373	data
1346	Infra 엔지니어 (6~8년)	메타넷글로벌	서울 강남구	경력 6~8년	["Python", "MSA", "Kafka", "MariaDB"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50558	other
1347	HW개발자(3년 이상)	럭스로보	서울 서초구	경력 3~12년	["PCB"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/51149	other
1348	C/C++개발(7년~10년)	위즈코리아	서울 강서구	경력 7~10년	["Linux", "C", "C++", "C#", "Java"]	마감 기한: D-20	https://jumpit.saramin.co.kr/position/51117	design
1349	내부시스템 개발(파워빌더) 경력	호전실업	서울 마포구	경력 5~15년	["Power builder", "Backendless", "MSSQL"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51281	backend
1350	기술지원부장(기술지원팀 및 QA/QC팀 총괄 관리)	프라이빗테크놀로지	서울 마포구	경력 10~20년	["QA", "SW", "CISSP"]	마감 기한: D-27	https://jumpit.saramin.co.kr/position/51476	qa
1351	QA 엔지니어	바로팜	서울 강남구	경력 5~12년	["QA", "Notion", "Jira", "Slack", "Confluence"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51568	qa
1352	백엔드 개발자 경력 채용	인공지능팩토리	서울 중구	경력 1~5년	["AWS", "GCP", "AZURE", "Cloud CMS", "Java"]	마감 기한: D-29	https://jumpit.saramin.co.kr/position/51612	backend
1353	Zadara 솔루션 아키텍트	이비즈테크	서울 마포구	경력 5~10년	["vmware", "Linux", "AWS", "Amazon MQ"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51253	devops
1354	AOP 엔지니어링_UE파트 연구원 채용	알피니언메디칼시스템	서울 강서구	신입~10년	["MATLAB", "Python", "labview", "SW"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50054	other
1355	Python 개발자 모집	애드크림	서울 강남구	경력 3~5년	["Python", "DB", "AngularJS", "Vue.js"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50644	frontend
1356	비전 AI 연구개발 채용	인피닉	서울 금천구	경력 3~10년	["AI/인공지능", "Python", "PyTorch", "Pandas"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50468	data
1357	써머스플랫폼 서비스기획자 (신입)	커넥트웨이브	서울 금천구	신입	["Microsoft Excel"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50853	pm
1358	Data Scientist in Financial (7~10년)	페니로이스	서울 종로구	경력 7~10년	["Python", "R", "BigData", "MachineLearning"]	마감 기한: D-20	https://jumpit.saramin.co.kr/position/51113	data
1359	백엔드 및 서버 개발자 채용	스쿨버스	서울 강서구	경력 1~9년	["java", "Node.js", "JavaScript", "REST API"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/50033	backend
1360	Backend팀 개발자 채용	인피닉	서울 금천구	경력 3~10년	["Java", "Docker", "SW", "DB"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50467	backend
1361	[다나와개발본부] Backend Engineer	커넥트웨이브	서울 금천구	신입~10년	["Python", "Django", "Flask", "FastAPI", "Java"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50854	backend
1362	백엔드 시니어 개발자	딜리버리랩	서울 성동구	경력 5~15년	["MySQL", "AWS", "Spring Boot"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51168	backend
1363	서버개발자 채용	로지소프트	서울 강남구	경력 7~15년	["AZURE", "C#", "C++", "NoSql", "Node.js"]	마감 기한: D-day	https://jumpit.saramin.co.kr/position/49677	backend
1364	알약 xLLM 제품 개발 (경력)	이스트시큐리티	서울 서초구	경력 3~6년	["Go", "Java", "Python", "REST API", "SQL"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50011	backend
1365	[석사/신입]영상처리/rPPG 연구개발	바이오커넥트	서울 서초구	신입	["OpenCV", "DeepLearning", "Python"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50383	other
1366	FrontEnd팀 개발자 채용	인피닉	서울 금천구	신입	["Java", "JavaScript", "Docker", "SW", "React"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50466	frontend
1367	데이터 분석가(Data Analyst)	더스윙	서울 용산구	경력 1~3년	["REST API", "Python", "SQL", "Hadoop"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51187	data
1369	보안솔루션(MDM) 개발자(선임급 이상)	비욘드테크	서울 금천구	경력 4~10년	["JSP", "Java", "C#", "SW", "Spring Boot"]	마감 기한: D-3	https://jumpit.saramin.co.kr/position/49790	backend
1370	[의료R&D본부] 프론트엔드 개발 PL	딥노이드	서울 구로구	경력 5~10년	["React", "REST API", "TypeScript"]	마감 기한: D-8	https://jumpit.saramin.co.kr/position/50136	frontend
1371	언리얼 엔지니어 채용	인피닉	서울 금천구	경력 1~5년	["C++", "VR", "AR", "AWS", "AZURE"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50465	devops
1372	금융/NL2SQL 데이터 사이언티스트	다큐브	서울 영등포구	신입~10년	["PyTorch", "Transformers", "TensorFlow"]	마감 기한: D-20	https://jumpit.saramin.co.kr/position/51114	data
1373	수원) SW 테스트 엔지니어(QA) (4~8년)	인피닉	서울 금천구	경력 4~8년	["QA", "Python", "C", "SW"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50463	qa
1374	풀스택 개발자	에브리심	서울 성북구, 대전 유성구	경력 3~10년	["React", "TypeScript", "Node.js", "Git", "AWS"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51469	backend
1375	[AI] Data Scientist(AI Engineer, 8년이상, 리더급)	혜움	서울 강남구	경력 8~20년	["Python", "Django", "AWS"]	마감 기한: D-8	https://jumpit.saramin.co.kr/position/50227	backend
1376	[CC CTO] Dev&AI Ops	커넥트웨이브	서울 금천구	경력 3~15년	["Kubernetes", "Docker", "Kafka", "Hadoop"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50859	devops
1377	python 에이전트 개발자	다큐브	서울 영등포구	경력 1~10년	["Python", "FastAPI"]	마감 기한: D-20	https://jumpit.saramin.co.kr/position/51115	backend
1378	[강남/선릉] 소프트웨어 개발 경력	에스디티	서울 강남구	경력 5~10년	["C", "C++", "C#", "Linux", "Windows", "Python"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51195	design
1379	정보보안(운영)	미디어로그	서울 마포구	경력 2~10년	["ISMS", "CPPG"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51563	security
1380	풀스택 개발자 중급 0명 채용	퓨처플랫폼	서울 강서구	경력 5~10년	["Java", "JSP", "REST API", "Apache Tomcat"]	마감 기한: D-day	https://jumpit.saramin.co.kr/position/49807	fullstack
1381	S/W Engineer-SLAM [전문연구요원가능]	토르드라이브	서울 영등포구	경력 3~10년	["C++", "ROS", "Linux", "Docker", "Git"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50069	devops
1382	[다나와개발본부] Search Engineer	커넥트웨이브	서울 금천구	경력 5~10년	["Python", "Django", "Flask", "FastAPI", "Java"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50855	backend
1383	써머스플랫폼 서비스기획자 (경력3~10)	커넥트웨이브	서울 금천구	경력 3~10년	["Microsoft Excel"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50852	pm
1384	[보안AI사업본부] 백엔드 개발자_경력	딥노이드	서울 구로구	경력 8~10년	["Python", "Kotlin", "RDB", "NoSql", "Docker"]	마감 기한: D-8	https://jumpit.saramin.co.kr/position/50133	backend
1385	CTO	딜리버리랩	서울 성동구	경력 10~30년	["AWS", "NestJS", "Node.js", "React"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51170	backend
1386	데이터 사이언티스트	진스토리코리아	서울 금천구	신입~3년	["TensorFlow", "Python", "AWS", "PyTorch"]	마감 기한: 상시	https://jumpit.saramin.co.kr/position/23549	devops
1387	[Infra Div.] Publishing Tech PM	크래프톤	서울 강남구	경력 3~10년	["Python", "PowerShell", "Go", "C#"]	마감 기한: D-1	https://jumpit.saramin.co.kr/position/49888	backend
1388	front End 개발자(threejs)	씨메스	서울 강남구	경력 3~10년	["TypeScript", "three.js", "Next.js", "React"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51492	frontend
1389	Field Engineer	뷰런테크놀로지	서울 서초구	경력 1~10년	["Python", "MATLAB"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51452	other
1390	AI 인프라, AI Ops 환경 구성	디에스앤지	서울 영등포구	경력 6~20년	["AI/인공지능", "CUDA", "DeepLearning"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51408	devops
1391	Agent AI 연구 개발자 채용	인피닉	서울 금천구	경력 3~10년	["Python", "SQL", "TensorFlow", "PyTorch"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50464	data
1392	알약 PC/Mobile 제품기획자	이스트시큐리티	서울 서초구	경력 5~15년	["GitLab", "Figma", "Google Analytics"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50850	backend
1393	다국어번역/UI (Product Owner)	아이센스(caresens)	서울 서초구	경력 2~7년	["GUI", "Lokalise", "Crowdin", "iOS"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50916	mobile
1394	AI 로보틱스 SW 품질 QA 담당자	씨메스	서울 강남구	경력 4~20년	["Qt", "QA", "SW", "GitHub", "Python"]	마감 기한: D-26	https://jumpit.saramin.co.kr/position/51491	data
1395	철도 시뮬레이터 SW 엔진 개발자	이노시뮬레이션	서울 강서구	경력 2~7년	["C++", "C#"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51095	other
1396	[강남/선릉] DX 하드웨어 개발 경력	에스디티	서울 강남구	경력 2~10년	["MCU"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51194	embedded
1397	풀스택 개발자 PM급 채용	퓨처플랫폼	서울 강서구	경력 5~10년	["Java", "JSP", "REST API", "Apache Tomcat"]	마감 기한: D-day	https://jumpit.saramin.co.kr/position/49803	fullstack
1398	backend (python) 개발자	씨메스	서울 강남구	경력 3~5년	["Python", "JavaScript", "MariaDB", "C++"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51490	backend
1399	Java 백엔드 개발자(8~10년)	아파트아이	서울 금천구	경력 8~10년	["Spring", "JavaScript", "jQuery", "Java"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51582	backend
1400	S/W Engineer [전문연구요원가능]	토르드라이브	서울 영등포구	경력 3~10년	["C", "C++", "CUDA"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50082	other
1401	[CC CTO] AI Engineer	커넥트웨이브	서울 금천구	경력 3~15년	["Python", "Django", "FastAPI", "Java", "Kotlin"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50858	backend
1402	Java 백엔드 개발자(5~7년)	아파트아이	서울 금천구	경력 5~7년	["Spring", "JavaScript", "jQuery", "Java"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51581	backend
1403	Field Application Engineer (HIL) 경력	디스페이스코리아	서울 서초구	경력 3~10년	["MATLAB", "Python", "SW", "HW", "ethernet"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/49930	other
1404	수원) SW 테스트 엔지니어(QA) (1~3년)	인피닉	서울 금천구	경력 1~3년	["QA", "Python", "C", "SW"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50459	qa
1405	윈도우기반 응용프로그래머 개발자 모집	시와소프트	서울 금천구	경력 2~10년	["c#", "wpf", ".net", "rpa"]	마감 기한: 상시	https://jumpit.saramin.co.kr/position/15072	other
1406	플러터 개발자 (Flutter, 3~6년)	클레온	서울 중구	경력 3~6년	["Flutter", "Kotlin", "JavaScript", "Dart"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51314	frontend
1407	DBA 경력 직원 채용 (20년 이상)	엘아이지시스템	서울 용산구	경력 20~21년	["SQL", "Azure SQL Database", "DB"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50294	devops
1408	프론트엔드 웹개발자 채용(경력5~7년)	케이웨더	서울 구로구	경력 5~7년	["Java", "Linux", "React", "Next.js"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50313	frontend
1409	프론트엔드 개발자 (경력 1년 이상)	아이쿠카	서울 영등포구	경력 1~15년	["JavaScript", "React", "React Native", "Java"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/51552	frontend
1410	LG에너지솔루션 개발프로젝트[1~7년]	에이핀테크놀러지	서울 구로구	경력 1~7년	["C#", "MSSQL", "Oracle", "DB", "Java"]	마감 기한: D-8	https://jumpit.saramin.co.kr/position/50185	other
1411	DBA 경력 직원 채용 (13~15년)	엘아이지시스템	서울 용산구	경력 13~15년	["SQL", "Azure SQL Database", "DB"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50292	devops
1412	Computer Vision / Machine Learning 소프트웨어 개발자 채용	쓰리아이	서울 강남구	경력 1~20년	["C++", "Python", "TensorFlow", "PyTorch"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/51138	data
1413	프론트엔드 웹개발자 채용(경력8~10년)	케이웨더	서울 구로구	경력 8~10년	["Java", "Linux", "React", "Next.js"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50314	frontend
1414	[분당] 병원정보시스템 진료파트개발자	이지케어텍(edge&next)	서울 중구	경력 1~8년	["WPF", ".NET", "JavaScript", "Oracle"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50472	frontend
1415	백엔드 개발자 (1~4년) [강남구]	모멘티	서울 강남구	경력 1~4년	["Python", "Django", "PHP", "MySQL"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/51109	backend
1416	QA Engineer	쓰리아이	서울 강남구	경력 3~20년	["Jira", "Redmine", "HW", "SW", "QA"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/51133	qa
1417	[원주] 병원정보시스템 S/W 개발자(SI)	이지케어텍(edge&next)	서울 중구	경력 2~20년	["JavaScript", "Oracle", "WPF", ".NET"]	마감 기한: D-13	https://jumpit.saramin.co.kr/position/50473	frontend
1418	FrontEnd 개발자(Pivo Engineering)	쓰리아이	서울 강남구	경력 4~10년	["TypeScript", "Vue.js", "WebRTC", "three.js"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/51132	frontend
1419	Technical Artist 채용	보이저	서울 구로구	경력 3~15년	["Unreal Engine", "Python", "Unity"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50651	game
1420	Sr. Researcher (LLM)	에이아이트릭스	서울 강남구	경력 5~12년	["MachineLearning", "AI/인공지능", "NLP"]	마감 기한: D-13	https://jumpit.saramin.co.kr/position/50128	data
1421	쇼핑몰서비스 PHP 개발자 6년 ↑ 모집	유디아이디	서울 구로구	경력 6~9년	["PHP", "MySQL", "MongoDB", "Laravel"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/51119	backend
1422	Registration 연구 개발	스키아	서울 구로구	경력 3~10년	["C++", "Python", "Swift"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/51019	mobile
1423	개발 및 플랫폼 기획	프라이빗테크놀로지	서울 마포구	경력 7~20년	["Network", "Infra", "Flow", "QA", "TCP/IP"]	마감 기한: D-27	https://jumpit.saramin.co.kr/position/51475	qa
1424	[Network-on-Chip] Software Engineer	오픈엣지테크놀로지	서울 강남구	경력 10~15년	["C", "C++", "Python", "JavaScript", "ES6"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50495	frontend
1425	WEBFRONT-K 웹보안기능 / 시그니처개발	파이오링크	서울 금천구	경력 3~13년	["C", "C++", "Python", "Linux", "Java"]	마감 기한: D-20	https://jumpit.saramin.co.kr/position/51122	security
1426	React Native 리드 개발자 (5~10년차)	팬딩	서울 강남구	경력 5~10년	["React"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51235	frontend
1427	카카오톡 상담톡/챗봇 서비스 개발자	비즈톡	서울 강남구	경력 5~10년	["C++", "C"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51055	other
1428	Solution Engineer	에이아이트릭스	서울 강남구	신입~7년	["Git", "Linux", "Python", "Docker Compose"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51315	devops
1429	DevOps/MLOps Engineer (7~10년)	웨어러블에이아이	서울 영등포구	경력 7~10년	["AWS", "Linux", "Docker", "Kubernetes"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50374	devops
1430	클라이언트 프로그래머 채용	보이저	서울 구로구	경력 7~20년	["C++", "DirectX", "Redis", "Unreal Engine"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50650	game
1431	네트워크 개발	프라이빗테크놀로지	서울 마포구	경력 3~10년	["C", "C++", "TCP/IP", "Linux", "VPN", "FW"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50631	design
1432	머신러닝 개발자	아이트럭	서울 서초구	경력 5~10년	["scikit-learn", "BigData", "MachineLearning"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/50985	data
1433	[하나금융그룹 자회사] DBA (7년이상)	핀크	서울 중구	경력 7~10년	["MariaDB", "MySQL", "MaxScale"]	마감 기한: D-32	https://jumpit.saramin.co.kr/position/51606	other
1434	[하나금융그룹 자회사] DBA (3년이상)	핀크	서울 중구	경력 3~6년	["MariaDB", "MaxScale", "MySQL"]	마감 기한: D-32	https://jumpit.saramin.co.kr/position/51605	other
1435	DevOps / Infra Engineer	법틀	서울 성동구	경력 2~5년	["Docker"]	마감 기한: D-29	https://jumpit.saramin.co.kr/position/51615	devops
1436	백엔드 개발자 (5~10년) [강남구]	모멘티	서울 강남구	경력 5~10년	["Python", "Django", "PHP", "MySQL"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/51131	backend
1437	플러터 개발자 (Flutter, 7~10년)	클레온	서울 중구	경력 7~10년	["Flutter", "Kotlin", "JavaScript", "Dart"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51316	frontend
1438	3D 엔진개발 [메타개발팀] 신입	상화	서울 강남구	신입~2년	["Unity", "Unreal Engine", "3D Rendering"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51570	game
1439	3D 엔진개발 [메타개발팀] 리드급	상화	서울 강남구	경력 9~10년	["Unity", "Unreal Engine", "3D Rendering"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51559	game
1440	백엔드 개발자(6-10년)	와탭랩스	서울 서초구	경력 6~10년	["Netty", "Spring Framework"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51595	backend
1441	필드 엔지니어	오리온디스플레이	서울 금천구	신입~3년	["Autocad", "Fusion 360", "HW"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/50125	other
1442	MLOps 엔지니어	룰루랩	서울 강남구	경력 1~10년	["Python", "PyTorch"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51177	data
1443	백엔드 개발자(2-5년)	와탭랩스	서울 서초구	경력 2~5년	["Netty", "Spring Framework"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51594	backend
1444	AI 기술 개발자	비바이노베이션	서울 강남구	경력 6~15년	["Python", "TensorFlow", "PyTorch"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51477	data
1445	CA/RA 개발자 신입 모집	한국전자인증	서울 서초구	신입	["Linux", "C++", "C", "Java", "AWS", "Eclipse"]	마감 기한: D-27	https://jumpit.saramin.co.kr/position/51577	devops
1446	LG에너지솔루션 개발프로젝트[15~20년]	에이핀테크놀러지	서울 구로구	경력 15~20년	["C#", "MSSQL", "Oracle", "DB", "Java"]	마감 기한: D-8	https://jumpit.saramin.co.kr/position/50187	other
1447	DB 엔지니어(16-20년)	와탭랩스	서울 서초구	경력 16~20년	["SQL", "Oracle", "AWS"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51600	devops
1448	LG에너지솔루션 개발프로젝트[8~14년]	에이핀테크놀러지	서울 구로구	경력 8~14년	["C#", "MSSQL", "Oracle", "DB", "Java"]	마감 기한: D-8	https://jumpit.saramin.co.kr/position/50186	other
1449	iPaaS 프로젝트 매니저 PM	메이븐클라우드서비스	서울 강남구	경력 5~30년	["Microsoft PowerApps"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/51024	pm
1450	데브옵스 엔지니어(5-8년)	와탭랩스	서울 서초구	경력 5~8년	["AWS", "AZURE", "GCP", "Java", "Python"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51596	devops
1451	클라우드 모니터링 솔루션운영 및 유지보수	웅진	서울 중구	경력 5~13년	["Java", "Kubernetes", "JSP"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/49905	devops
1452	[AI 기술팀] 언어 AI 최적화 경력사원 채용	롯데이노베이트	서울 금천구	경력 3~5년	["AI/인공지능", "PyTorch", "Keras"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/51470	data
1453	3차원 머신비전 알고리즘 개발자(2~4)	클레	서울 성동구	경력 2~4년	["Python", "C", "C++", "PyTorch", "CUDA"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51066	data
1454	로우코드 웹 기반 시스템 개발/설계	웅진	서울 중구	경력 10~18년	["Java", "NoCodeAPI", "LowCodeEngine"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49900	other
1455	Frontend Engineer	아이브	서울 서초구	경력 3~10년	["React", "Next.js", "TypeScript", "JavaScript"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50624	frontend
1456	항공 및 로보틱스 엔지니어	니어스랩	서울 송파구	경력 3~10년	["C", "C++", "Kotlin", "MATLAB", "Python"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50687	mobile
1457	데스크탑 앱 개발자	클레	서울 성동구	신입	["Python", "C++", ".NET", "OpenGL", "C#", "Qt"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51070	other
1458	ERP 개발(.NET, C#, VB.NET)	웅진	서울 중구	경력 3~20년	["ERP", "SAP", ".NET", "Vb.net", "C#"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/49989	other
1459	웹 시스템 설계	웅진	서울 중구	경력 10~20년	["Java", "MSA"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49901	other
1460	데이터 엔지니어 경력직 모집	웅진	서울 중구	경력 3~16년	["PowerBI", "Microsoft PowerApps"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/49987	data
1461	RPA(업무자동화) Developer	웅진	서울 중구	경력 3~13년	["RPA", "Microsoft Power Automate"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/49991	pm
1462	자율주행차량 제어 시스템 엔지니어	토르드라이브	서울 영등포구	경력 3~10년	["C++", "Python"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/51343	robotics
1463	Camera Sensor Engineer	모빌린트	서울 강남구	경력 3~5년	["Linux"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50196	design
1464	네트워크 엔지니어 채용	필라넷	서울 강남구	경력 3~15년	["Network", "Cisco"]	마감 기한: D-27	https://jumpit.saramin.co.kr/position/51323	other
1465	NPU Field Application Engineer	모빌린트	서울 강남구	경력 5~10년	["C++", "TensorFlow", "Python", "PyTorch"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50325	data
1466	프론트엔드 개발자 (과장급)	아파트아이	서울 금천구	경력 8~10년	["Next.js", "HTML5", "JavaScript", "React"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51580	frontend
1467	Perception Engineer(Tech Lead)	뷰런테크놀로지	서울 서초구	경력 5~10년	["C", "C++", "Python", "DeepLearning"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51455	other
1468	프론트엔드 개발자 채용	딜리버리랩	서울 성동구	경력 5~15년	["Vue.js", "Java", "JavaScript", "HTML5"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51169	frontend
1469	SAP MM 운영 및 개발자	브이엔티지	서울 마포구	경력 5~15년	["ABAP", "ERP", "SAP"]	마감 기한: D-30	https://jumpit.saramin.co.kr/position/51549	other
1470	S/W Engineer-Perception [전문연구요원가능]	토르드라이브	서울 영등포구	경력 3~10년	["C", "C++", "CUDA"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50073	other
1471	H/W System Design Engineer(Senior)	모빌린트	서울 강남구	경력 8~12년	["PCB"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50335	other
1472	의료 AI 제품 패키징 파이썬 개발자	딥노이드	서울 구로구	경력 5~10년	["Python", "Docker", "Linux", "Shell", "Java"]	마감 기한: D-8	https://jumpit.saramin.co.kr/position/50137	devops
1473	시스템 엔지니어 경력 채용	디에스앤지	서울 영등포구	경력 7~15년	["Ubuntu", "Linux", "Kubernetes", "Docker"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51407	devops
1474	SAP BC 운영 및 개발자 (4년 이상)	브이엔티지	서울 마포구	경력 4~10년	["ABAP", "ERP", "SAP"]	마감 기한: D-30	https://jumpit.saramin.co.kr/position/51548	other
1475	H/W System Design Engineer(Junior)	모빌린트	서울 강남구	경력 3~5년	["PCB", "HW", "Orcad"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50451	other
1476	Simulation S/W Engineer [전문연구요원가능]	토르드라이브	서울 영등포구	경력 3~10년	["C", "C++", "CUDA"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50070	other
1477	DevOps 엔지니어 [전문연구요원가능]	토르드라이브	서울 영등포구	경력 3~10년	["C", "C++", "CUDA", "Kubernetes"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50075	devops
1478	프론트엔드 개발자 (대리급)	아파트아이	서울 금천구	경력 5~7년	["Next.js", "HTML5", "JavaScript", "React"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51579	frontend
1479	[급구] AD/ADFS 운영 가능한 Windows 엔지니어 모집	필라넷	서울 중구	경력 3~10년	["Active Directory", "Windows Server"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/51603	other
1481	.NET 웹 개발 경력 채용	필라넷	서울 강남구	경력 3~7년	["Windows", "ASP.NET", "Classic ASP"]	마감 기한: D-33	https://jumpit.saramin.co.kr/position/51614	other
1482	엔진기술연구팀 AI/ML엔지니어 채용	인피닉	서울 금천구	경력 1~3년	["Python", "PyTorch", "AI/인공지능"]	마감 기한: D-29	https://jumpit.saramin.co.kr/position/51616	data
1483	M365 개발 리더(PL)채용	웅진	서울 중구	경력 10~15년	["Spring Boot", "AZURE", "MSSQL"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49897	backend
1484	3차원 머신비전 알고리즘 개발자8~10	클레	서울 성동구	경력 8~10년	["Python", "C", "C++", "PyTorch", "CUDA"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51068	data
1485	Microsoft Power Platform Developer	웅진	서울 중구	경력 3~20년	["Microsoft Azure", "Microsoft PowerApps"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49899	devops
1486	MS Power Platform Project Leader	웅진	서울 중구	경력 10~20년	["Microsoft Azure", "Microsoft PowerApps"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/49990	devops
1487	3D 컴퓨터 비전 연구개발	마이공사	서울 서초구	경력 2~9년	["DeepLearning", "AI/인공지능", "Python"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/50995	data
1488	3차원 머신비전 알고리즘 개발자(5~7)	클레	서울 성동구	경력 5~7년	["Python", "C", "C++", "PyTorch", "CUDA"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51067	data
1490	풀스택 앱 개발 (경력 13~15년)	에이치비엠피	서울 구로구	경력 13~15년	["Angular 2", "Node.js", "React", "MySQL"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50209	backend
1491	임베디드 소프트웨어 (센서 통합)	니어스랩	서울 송파구	경력 3~10년	["C", "C++", "Embedded", "Embedded Linux"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50686	design
1492	SAP FCM/SCM/EWM 모듈개발자	웅진	서울 중구	경력 3~13년	["SAP", "ABAP"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/49986	other
1493	실시간 영상 분석 엔지니어	씨이랩	서울 강남구	경력 3~10년	["CUDA", "Python", "Flask", "Docker"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50763	backend
1494	iOS Developer	쏘카	서울 성동구	경력 3~8년	["Swift", "Objective-C", "iOS"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/51139	mobile
1495	대외 SAP ERP 모듈 유지보수	웅진	서울 중구	경력 3~13년	["ABAP", "SAP"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49903	other
1496	백엔드 개발 (경력 6~10년)	에이치비엠피	서울 구로구	경력 6~10년	["GitHub", "MySQL", "Node.js", "Amazon EC2"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50213	backend
1497	임베디드 소프트웨어_카메라&통신 모듈	니어스랩	서울 송파구	경력 3~10년	["C", "C++", "Embedded", "Embedded Linux"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50685	design
1498	[SCK 및 관계사] Microsoft 제품교육 및 기술지원	에쓰씨케이	서울 강남구	경력 4~10년	["Microsoft Office 365", "SW", "AWS Copilot"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50583	devops
2073	비행선 제어 SW/HW 개발	이카루스	광주 북구	신입	["C++"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51322	robotics
1499	[5년 이상] 백엔드 개발자	오아시스비즈니스	서울 성동구	경력 5~10년	["Spring Boot", "NoSql", "Java", "AWS"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50936	backend
1500	3차원 카메라 하드웨어 개발자(5~7)	클레	서울 성동구	경력 5~7년	["PCB", "Orcad"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51072	other
1501	C# 기반 통신 플랫폼 ,서버 어플리케이션	마린웍스	서울 종로구	경력 10~13년	["C#", "AI/인공지능", "RDB", "BigData", "TCP/IP"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51426	backend
1502	[AI 기술팀] NLP AI 경력사원 채용	롯데이노베이트	서울 금천구	경력 3~12년	["AI/인공지능", "PyTorch", "Keras"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/51471	data
1503	SAP Public Cloud 컨설턴트	웅진	서울 중구	경력 12~25년	["SAP", "ERP"]	마감 기한: D-8	https://jumpit.saramin.co.kr/position/49984	other
1504	이리온 로봇 자율주행 SW 개발(서울)	폴라리스쓰리디	서울 용산구	경력 2~7년	["SW", "C++", "Linux", "Git", "Notion"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50893	design
1505	3차원 카메라 하드웨어 개발자(8~10)	클레	서울 성동구	경력 8~10년	["PCB", "Orcad"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51073	other
1506	Node.js 서버/백엔드 개발자(시니어)	더스포츠커뮤니케이션	서울 강서구	경력 5~8년	["Node.js"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/51330	backend
1507	플랫폼 개발자 채용공고	프로덕션고금	서울 영등포구	신입	["Python", "Solidity", "AWS", "AZURE"]	마감 기한: D-day	https://jumpit.saramin.co.kr/position/49830	devops
1508	프론트엔드 개발자	아이피샵	서울 강남구	경력 2~4년	["JavaScript", "PHP"]	마감 기한: D-13	https://jumpit.saramin.co.kr/position/50646	frontend
1509	인프라 담당자 채용	영원아웃도어	서울 중구, 경기 성남시	경력 5~10년	["Infra", "Network", "Linux", "Windows", "AWS"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51379	devops
1511	웹 퍼블리셔 경력채용 (2~5년)	텐빌리언	서울 구로구	경력 2~5년	["JavaScript", "HTML5", "CSS 3", "jQuery"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50254	frontend
1512	백엔드 서버 개발자 [경력 7년 이상]	아이피샵	서울 강남구	경력 7~10년	["Java", "JSP", "SQL", "MySQL", "MariaDB"]	마감 기한: D-13	https://jumpit.saramin.co.kr/position/50649	backend
1513	백엔드 개발자(전환형 인턴)	링글잉글리시에듀케이션서비스	서울 강남구	신입	["Ruby", "Python", "Java", "AWS"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51313	backend
1514	백엔드 경력 채용 (2~5년)	텐빌리언	서울 구로구	경력 2~5년	["Git", "Spring Boot", "DB"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50935	backend
1516	하루콩 Flutter 개발팀원	블루시그넘	서울 관악구	경력 2~8년	["Flutter"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51303	mobile
1517	임베디드 소프트웨어 개발자(IoT SaaS)	카르노플릿	서울 서초구, 경기 안양시	경력 5~10년	["MCU", "AWS", "MQTT", "C", "C++", "FW"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50123	devops
1519	백엔드 서버 개발자 [경력 3년 이상]	아이피샵	서울 강남구	경력 3~6년	["Java", "JSP", "SQL", "MySQL", "MariaDB"]	마감 기한: D-13	https://jumpit.saramin.co.kr/position/50648	backend
1520	서버 개발팀원	블루시그넘	서울 관악구	경력 2~8년	["Django"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51304	backend
1521	IT Team Leader 채용	영원아웃도어	서울 중구, 경기 성남시	경력 10~20년	["Oracle", "Linux", "Windows", "Network"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51386	design
1522	프론트엔드개발자 모집(3년~5년)	위버스브레인	서울 구로구	경력 3~5년	["Flutter", "React", "REST API", "Git", "Redux"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50732	frontend
1523	iPaaS 엔지니어	메이븐클라우드서비스	서울 강남구	경력 3~10년	["Microsoft PowerApps"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/51023	pm
1524	데브옵스 엔지니어(9-12년)	와탭랩스	서울 서초구	경력 9~12년	["AWS", "AZURE", "GCP", "Java", "Python"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51597	devops
1525	클라우드 네이티브 플랫폼 엔지니어(K8S)	미리비트	서울 서초구	경력 5~15년	["Kubernetes", "BigData", "Spark", "Minio"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51569	devops
1526	임베디드 소프트웨어 개발(10~13년)	비알랩	서울 강남구	경력 10~13년	["Embedded", "Embedded Linux", "ARM", "C"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51425	design
1527	빅데이터 엔지니어링	미리비트	서울 서초구, 경기 성남시, 경기 이천시	경력 5~15년	["Kubernetes", "Spark", "Apache Flink"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51564	devops
1528	CA/RA 개발자 경력 모집	한국전자인증	서울 서초구	경력 7~10년	["Linux", "C++", "C", "Java", "AWS", "Eclipse"]	마감 기한: D-27	https://jumpit.saramin.co.kr/position/51576	devops
1529	Hardware Product Manager	쓰리아이	서울 강남구	경력 5~20년	["HW", "PCB"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/51134	other
1530	임베디드 소프트웨어 개발(7~9년)	비알랩	서울 강남구	경력 7~9년	["Embedded", "Embedded Linux", "ARM", "C"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51424	design
1531	서버 개발자 (공동 및 사설 CA/RA)	한국전자인증	서울 서초구	경력 4~7년	["Linux", "C++", "C", "Java", "AWS", "Oracle"]	마감 기한: D-27	https://jumpit.saramin.co.kr/position/51578	backend
1532	DB 엔지니어(5-10년)	와탭랩스	서울 서초구	경력 5~10년	["SQL", "Oracle", "AWS"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51598	devops
1533	프론트엔드 엔지니어(경력 9~11년)	클래스101	서울 강남구	경력 9~11년	["React", "TypeScript", "GraphQL", "Apollo"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50401	frontend
1534	데이터서비스 운영SM	티사이언티픽	서울 동작구	경력 7~15년	["AWS", "Linux", "Kubernetes"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51292	devops
1535	DB 엔지니어(11-15년)	와탭랩스	서울 서초구	경력 11~15년	["SQL", "Oracle", "AWS"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51599	devops
1536	프론트엔드 엔지니어(경력12년 이상)	클래스101	서울 강남구	경력 12~14년	["React", "TypeScript", "GraphQL", "Apollo"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50402	frontend
1537	QA 테스터 모집(3년~5년/계약직)	위버스브레인	서울 구로구	경력 3~5년	["QA"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50728	qa
1538	정보보호 담당자 채용	영원아웃도어	서울 중구, 경기 성남시	경력 5~10년	["ISMS", "Linux", "Windows", "Firewall", "VPN"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51378	security
1539	HW개발_아날로그/파워 책임급 채용	알피니언메디칼시스템	서울 강서구	경력 8~13년	["HW", "PCB"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50051	other
1540	DBA 경력 직원 채용 (16~19년)	엘아이지시스템	서울 용산구	경력 16~19년	["SQL", "Azure SQL Database", "DB"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50293	devops
1541	프론트엔드 개발 경력 (10년 이상)	텐빌리언	서울 구로구	경력 10~13년	["JavaScript", "HTML5"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50930	frontend
1542	서버/백엔드 (6년이상)	매쓰마스터	서울 강서구	경력 6~8년	["Java", "Spring Boot", "Git", "MySQL", "Redis"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51409	backend
1543	웹 진단 모의해킹 (7~10년)	대진정보통신	서울 관악구	경력 7~10년	["Hack", "Azure Security Center", "ISMS"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/49953	devops
1544	전산실 SAP SD 운영 채용(경력 7~10년)	벨아이앤에스	서울 서대문구	경력 7~10년	["ABAP", "SQL", "SAP"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50424	other
1545	QA 테스터 모집(6년~10년/계약직)	위버스브레인	서울 구로구	경력 6~10년	["QA"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50729	qa
1546	프론트엔드 개발 경력 (2~5년)	텐빌리언	서울 구로구	경력 2~5년	["JavaScript", "HTML5"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50932	frontend
1547	서비스 기획자 (PM, PO)	이노소니언	서울 서초구	경력 5~20년	["Jira", "Notion", "AWS", "Git", "REST API"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51335	devops
1548	백엔드개발자 모집(11년~15년)	위버스브레인	서울 구로구	경력 11~15년	["PHP", "Git", "Python", "REST API"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50725	backend
1549	쇼핑몰어드민PHP개발자 경력(10년이상)	텐빌리언	서울 구로구	경력 10~15년	["Git", "AWS", "PHP"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50927	devops
1550	TA 모집(경력1~3년)	데이터누리	서울 강서구	경력 1~3년	["Linux", "MSA", "Python"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51238	design
1552	백엔드 Python 경력직 개발자 모집	아이디벨롭	서울 송파구	경력 3~10년	["Python", "Azure DevOps", "AWS"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51501	backend
1554	프론트엔드개발자 모집(11년~15년)	위버스브레인	서울 구로구	경력 11~15년	["Flutter", "React", "REST API", "Git", "Redux"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50730	frontend
1555	개발 팀장 모집(경력2~4년)	데이터누리	서울 강서구	경력 2~4년	["Java", "JavaScript"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51240	frontend
1556	PRM(Web POS)/BI Web개발자 채용	영원아웃도어	서울 중구, 경기 성남시	경력 5~10년	["Linux", "Oracle", "Java", "JSP", "REST API"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51383	pm
1557	풀 스택 개발자(Python, React)[7~10년]	세라크래프트	서울 동대문구	경력 7~10년	["Redux", "React", "Python", "Django"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51439	backend
1558	웹 퍼블리셔 경력채용 (6~9년)	텐빌리언	서울 구로구	경력 6~9년	["JavaScript", "HTML5", "CSS 3", "jQuery"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50255	frontend
1559	프론트엔드개발자 모집(6년~10년)	위버스브레인	서울 구로구	경력 6~10년	["Flutter", "React", "REST API", "Git", "Redux"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50731	frontend
1560	의료영상 3차원 개발자 채용(7~9)	제이피아이헬스케어	서울 구로구	경력 7~9년	["C", "C#", "C++", "DeepLearning"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51065	other
1561	개발 팀장 모집(경력8~10년)	데이터누리	서울 강서구	경력 8~10년	["Java", "JavaScript"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51241	frontend
1562	클라우드 엔지니어 경력 채용(6년~8년)	디지털포토	서울 서초구	경력 6~8년	["CentOS", "Linux", "Apache HTTP Server"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/51008	devops
1563	TA 모집(경력4~6년)	데이터누리	서울 강서구	경력 4~6년	["Linux", "MSA", "Python"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51239	design
1564	TA 모집(경력7~10년)	데이터누리	서울 강서구	경력 7~10년	["Linux", "MSA", "Python"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51237	design
1565	WMS Web 개발자 채용	영원아웃도어	서울 중구, 경기 성남시	경력 5~10년	["Linux", "Oracle", "Java", "JSP", "REST API"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51382	design
1566	웹 퍼블리셔 경력채용 (10년이상)	텐빌리언	서울 구로구	경력 10~15년	["JavaScript", "HTML5", "CSS 3", "jQuery"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50258	frontend
1567	백엔드개발자 모집(6년~10년)	위버스브레인	서울 구로구	경력 6~10년	["PHP", "Git", "Python", "REST API"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50726	backend
1568	쇼핑몰 어드민 PHP개발자 경력(2~5년)	텐빌리언	서울 구로구	경력 2~5년	["Git", "AWS", "PHP"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50929	devops
1569	E-Commerce 개발 담당자 채용	영원아웃도어	서울 중구, 경기 성남시	경력 7~15년	["Microsoft Excel", "Google Analytics"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51380	backend
1570	전산실 SAP SD 운영 채용 (경력 3~6년)	벨아이앤에스	서울 서대문구	경력 3~6년	["ABAP", "SQL", "SAP"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50423	other
1571	쇼핑몰 어드민 PHP개발자 경력(6~9년)	텐빌리언	서울 구로구	경력 6~9년	["Git", "AWS", "PHP"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50928	devops
1572	백엔드 경력 채용 (10년 이상)	텐빌리언	서울 구로구	경력 10~15년	["Git", "Spring Boot", "DB"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50933	backend
1573	Python/Java 개발(경력5~7)	데이터누리	서울 강서구	경력 5~7년	["Linux", "MSA", "Python", "Java"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51244	design
1574	네트워크 엔지니어 경력(2~5년)	텐빌리언	서울 구로구	경력 2~5년	["Network"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50246	other
1575	Python/Java 개발(경력8~10)	데이터누리	서울 강서구	경력 8~10년	["Linux", "MSA", "Python", "Java"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51243	design
1576	백엔드개발자 모집(3년~5년)	위버스브레인	서울 구로구	경력 3~5년	["PHP", "Git", "Python", "REST API"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50727	backend
1577	네트워크 엔지니어 경력(10년이상)	텐빌리언	서울 구로구	경력 10~15년	["Network"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50250	other
1578	클라우드 엔지니어 경력 채용(3년~5년)	디지털포토	서울 서초구	경력 3~5년	["CentOS", "Linux", "Apache HTTP Server"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/51007	devops
1579	데이터 사이언티스트 (Data Scientist) 채용	영원아웃도어	서울 중구, 경기 성남시	경력 5~10년	["Python", "MachineLearning", "SQL"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51385	data
1580	백엔드 경력 채용 (6~9년)	텐빌리언	서울 구로구	경력 6~9년	["Git", "Spring Boot", "DB"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50934	backend
1581	CRM/AI 고객 분석 담당 채용	영원아웃도어	서울 중구, 경기 성남시	경력 5~10년	["SQL", "Microsoft Excel", "Salesforce"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51381	data
1582	풀 스택 개발자(Python, React)[3~6년]	세라크래프트	서울 동대문구	경력 3~6년	["Redux", "React", "Python", "Django"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51437	backend
1583	SAP LE/MM/PP모듈 유지보수 경력	웅진	서울 중구	경력 5~13년	["SAP", "ABAP"]	마감 기한: D-8	https://jumpit.saramin.co.kr/position/49985	other
1584	풀스택 앱 개발 (경력 9~12년)	에이치비엠피	서울 구로구	경력 9~12년	["Angular 2", "Node.js", "React", "MySQL"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50208	backend
1585	3D Geometry SW Engineer 경력 채용	디오에프	서울 성동구	경력 1~15년	["SW", "C++", "3D Rendering"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51141	other
1553	앱 개발자 경력 채용 (6~9년)	텐빌리언	서울 구로구	경력 6~9년	["Android", "REST API", "React", "iOS"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50252	frontend
1586	C# 기반 통신 플랫폼 ,서버 어플리케이션(15년이상)	마린웍스	서울 종로구	경력 15~20년	["C#", "AI/인공지능", "RDB", "BigData", "TCP/IP"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51427	backend
1587	Application SW Engineer 경력 채용	디오에프	서울 성동구	경력 3~15년	["SW", "C++", "Qt", "Mfc", "OpenGL"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51142	other
1588	[DOF] HW Linux App 엔지니어 채용	디오에프	서울 성동구	경력 3~7년	["Linux"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51146	design
1589	풀스택 앱 개발 (경력 5~8년)	에이치비엠피	서울 구로구	경력 5~8년	["Angular 2", "Node.js", "React", "MySQL"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50204	backend
1590	의료기기 S/W 개발자(서울, 경력 7~10년)	프리시젼바이오	서울 서초구	경력 7~10년	["C"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51509	other
1591	DE (5년↑)	테크핀레이팅스	서울 중구	경력 5~15년	["DB", "SQL", "Python", "PostgreSQL", "Oracle"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51416	pm
1592	SAP ERP(S/4HANA컨설턴트)	웅진	서울 중구	경력 7~20년	["SAP", "ERP", "SW"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49904	other
1593	ERP컨설턴트(SAP B1/MS D365) 채용	웅진	서울 중구	경력 3~25년	["SAP", "ERP", "SW"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50020	other
1594	데이터 엔지니어(5년 이상)	이노케어플러스	서울 서초구	경력 5~10년	["Python", "SQL", "Scala", "AWS Glue"]	마감 기한: D-29	https://jumpit.saramin.co.kr/position/51607	devops
1595	네트워크 엔지니어 경력(6~9년)	텐빌리언	서울 구로구	경력 6~9년	["Network"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50249	other
1596	SAP SD 모듈 담당자 채용	영원아웃도어	서울 중구, 경기 성남시	경력 5~10년	["SAP", "Microsoft Excel"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51375	robotics
1597	서버 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["GitHub", "GraphQL", "Docker", "AZURE"]	마감 기한: D-29	https://jumpit.saramin.co.kr/position/51353	backend
1598	PIA자격 필수/개인정보보호컨설팅(1~5)	대진정보통신	서울 관악구	경력 1~5년	["ISMS", "CPPG"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/49950	security
1599	FPGA개발 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["FPGA", "C", "C++", "Cisco ISE"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/50586	other
1600	하드웨어 개발자 경력 채용	에프엘이에스	서울 강서구	경력 2~5년	["HW", "Embedded", "PCB", "ARM"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/49879	embedded
1601	Linux OS 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~6년	["Linux", "Embedded", "SW", "Docker", "Yocto"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/50718	devops
1602	SAP CO 모듈 담당자 채용	영원아웃도어	서울 중구, 경기 성남시	경력 5~10년	["SAP", "Microsoft Excel"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51377	robotics
1603	알고리즘 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["Slim", "Keras", "TensorFlow", "Java"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51352	data
1604	Embedded Vision System	엠코프	서울 강동구	신입~22년	["C++", "Lua", "BigData", "C#"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51246	data
1605	의료영상 3차원 개발자 채용(4~6)	제이피아이헬스케어	서울 구로구	경력 4~6년	["C", "C#", "C++", "DeepLearning"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51064	other
1606	SAP MM 모듈 담당자 채용	영원아웃도어	서울 중구, 경기 성남시	경력 5~10년	["SAP", "Microsoft Excel"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51374	robotics
1607	DX/AX 채용	영원아웃도어	서울 중구, 경기 성남시	경력 5~10년	["Oracle", "MySQL", "MariaDB"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51384	other
1608	연구소 소프트웨어 개발자 채용(5~7년)	이노카	서울 구로구	경력 5~7년	["C", "C++", "Linux", "MCU", "Libraries.io"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51550	design
1609	임베디드 개발자 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["RTOS", "Python", "C++", "C", "HW", "FW"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50050	embedded
1610	Lua C++ 응용프로그램 운용	엠코프	서울 강동구	신입	["BigData", "Lua", "C#", "C++"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51247	data
1611	PIA자격 필수/개인정보보호컨설팅(6~10)	대진정보통신	서울 관악구	경력 6~10년	["ISMS", "CPPG"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/49952	security
1612	연구소 소프트웨어 개발자 채용(8년~)	이노카	서울 구로구	경력 8~10년	["C", "C++", "Linux", "MCU", "Libraries.io"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51553	design
1613	프론트엔드 개발 경력 (6~9년)	텐빌리언	서울 구로구	경력 6~9년	["JavaScript", "HTML5"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50931	frontend
1614	SAP FI 모듈 담당자 채용	영원아웃도어	서울 중구, 경기 성남시	경력 5~10년	["SAP", "Microsoft Excel"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51376	robotics
1615	클라우드 엔지니어 경력직 채용	엠포스	서울 서초구	경력 3~10년	["AWS", "Docker", "GCP", "Django", "MySQL"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51562	backend
1616	임베디드 소프트웨어 개발자(4년↑)	엔엑스	서울 서초구	경력 4~6년	["C", "C#", "Embedded", "Linux", "FW", "C++"]	마감 기한: D-29	https://jumpit.saramin.co.kr/position/51618	design
1617	임베디드 소프트웨어 개발자(11년↑)	엔엑스	서울 서초구	경력 11~15년	["C", "C#", "Embedded", "Linux", "FW", "C++"]	마감 기한: D-29	https://jumpit.saramin.co.kr/position/51617	design
1618	Java(Back-End)개발자 [리더급 9~20년]	제네시스네스트	경기 용인시	경력 9~20년	["Spring", "Java", "Linux", "Blockchain"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50822	backend
1619	Data Engineer(Knowledge Engineering)	에스투더블유	경기 성남시	경력 1~5년	["Docker", "Hadoop", "Kubeflow", "Git"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50641	devops
1620	Data Engineer (상주 인턴)	에스투더블유	경기 성남시	신입	["Docker", "Hadoop", "Kubeflow", "Git"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50640	devops
1621	Front-End 개발자	제네시스네스트	경기 용인시	경력 1~10년	["React", "AngularJS", "Vue.js", "JavaScript"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51365	frontend
1622	Java(Back-End)개발자 [경력 1~8년]	제네시스네스트	경기 용인시	경력 1~8년	["Spring", "Java", "Linux", "Blockchain"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50821	backend
1623	.Net, C# Application Developer (Junior 가능)	우리엔	경기 화성시	경력 4~10년	["C++", "Windows", "Delphi", "SQL", "C#"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/49858	other
1624	Frontend Engineer	에스투더블유	경기 성남시	경력 2~6년	["React", "Zustand", "TypeScript", "SQL"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50981	frontend
1625	백엔드 개발자	포트로직스	경기 성남시	경력 5~10년	["GitHub", "Java", "AWS", "NGINX", "MySQL"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/49974	backend
1626	Frontend Software Engineer	뉴로퓨전	경기 용인시	경력 3~10년	["React", "Next.js", "HTML5", "CSS 3"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50190	frontend
1627	Backend Software Engineer	뉴로퓨전	경기 용인시	경력 3~10년	["TypeScript", "Python", "Java", "AWS"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50192	backend
1628	Data Engineer (포트 스캐너 개발)	에스투더블유	경기 성남시	경력 4~15년	["Git", "MongoDB", "Python", "Docker"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50638	backend
1629	환경 에너지 플랫폼 AI 엔지니어	에이알티플러스	경기 이천시	경력 5~10년	["BigData", "AI/인공지능", "Docker", "Hadoop"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50683	devops
1630	Digital Logic 개발/분당R&D	아이디어스투실리콘	경기 성남시	경력 3~15년	["Verilog", "C", "C++", "C#", "Python", "VHDL"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/49885	other
1631	Frontend Engineer 시니어(Product 3)	에스투더블유	경기 성남시	경력 3~7년	["TypeScript", "SCSS", "Angular 2", "RxJS"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50642	frontend
1632	판교연구소 SW개발 (경력 7~9년)	인텔리안테크놀로지스	경기 평택시	경력 7~9년	["C", "C++", "Embedded Linux", "JsonAPI"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/50971	design
1633	R/F개발 5~7년 채용	테스	경기 용인시	경력 5~7년	["MATLAB", "Network", "RF"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/50753	other
1634	SW Engineer-정보보안(암호화알고리즘)	리브스메드	경기 성남시	경력 5~12년	["Linux", "C++", "Network"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50322	security
1635	Project Manager (3년 이상)	이우소프트	경기 화성시	경력 3~10년	["Jira", "Azure DevOps", "Confluence"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50341	devops
1636	클라이언트 프로그래머	에이버튼	경기 성남시	경력 2~20년	["C++", "Unreal Engine"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50476	game
1637	R/F개발 8~10년 채용	테스	경기 용인시	경력 8~10년	["MATLAB", "Network", "RF"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50754	other
1638	로봇제어Engineer:Senior(과장-부장)	리브스메드	경기 성남시	경력 7~18년	["C++", "Python", "Git", "Notion", "Jira", "C"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50321	robotics
1639	Cloud 백엔드 개발자 (5년 이상)	이우소프트	경기 화성시	경력 5~10년	["TypeScript", "JavaScript", "Node.js"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50340	backend
1640	Front-end Platform Engineer (경력)	엔닷라이트	경기 성남시	경력 5~10년	["TypeScript", "JavaScript", "CSS 3", "Next.js"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51261	frontend
1641	Offensive Researcher (오펜시브 리서쳐)	에스투더블유	경기 성남시	신입	["Python", "Go", "Git", "Slack"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50561	backend
1642	환경 에너지 플랫폼 개발 PL	에이알티플러스	경기 이천시	경력 10~15년	["Java", "JavaScript", "DB", "SQL"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50682	frontend
1644	에듀테크(EduTech) 웹 서비스 풀스택 개발자	블루가	경기 성남시	경력 7~10년	["JavaScript", "TypeScript", "Node.js"]	마감 기한: D-day	https://jumpit.saramin.co.kr/position/49820	backend
1645	[전문연구요원]AI연구엔지니어-LLM	업스테이지	경기 용인시	신입~20년	["AI/인공지능", "TensorFlow", "PyTorch", "NLP"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50522	data
1646	Back-end 개발자 (시니어)	엔닷라이트	경기 성남시	경력 8~15년	["REST API", "AWS", "Node.js", "MySQL"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50906	backend
1647	[긴급] 웹개발자 모집 (jsp,java)	상록아이엔씨	경기 부천시	신입~5년	["JSP", "Java", "JavaScript", "React"]	마감 기한: 상시	https://jumpit.saramin.co.kr/position/12030	frontend
1648	사내 시스템 담당자, ERP팀(대리-과장급)	리브스메드	경기 성남시	경력 4~12년	["ERP", "MES", "React Query", "Kubernetes"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50766	frontend
1649	임베디드 소프트웨어 개발자(신입~4년차)	긴트	경기 성남시	신입~4년	["C", "C++", "SW", "Embedded"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50353	embedded
1650	[전문연구요원]AI엔지니어-DocumentAI	업스테이지	경기 용인시	신입~20년	["Python", "Java", "AI/인공지능", "Ubuntu"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50521	data
1651	반도체 테스트 자동화 장비 SW 개발자	네오셈	경기 안양시	경력 2~8년	["SW", "Linux", "C", "C#"]	마감 기한: D-20	https://jumpit.saramin.co.kr/position/51059	qa
1652	Software Engineer - Backend	업스테이지	경기 용인시	경력 5~20년	["SW", "Backendless", "Python", "Golang"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50533	backend
1653	F/W개발(MCU) (경력 8~10년)	원익피앤이	경기 수원시	경력 8~10년	["C", "FW", "MCU"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/50993	embedded
1654	C++ 개발자 (수습평가 따라 재택 가능)	이파피루스	경기 성남시	경력 5~10년	["C", "C++", "Jenkins", "Git", "Linux", "C#", "Qt"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50256	design
1655	회로개발 (경력 3~7년)	원익피앤이	경기 수원시	경력 3~7년	["HW", "SW", "Embedded", "FW"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/50988	embedded
751	소프트웨어 엔지니어(Frontend)	사각	서울 마포구	경력 1~8년	["React", "Next.js", "Android", "iOS"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50842	frontend
1656	웹 서비스 Back-end 개발자 (경력)	엔닷라이트	경기 성남시	경력 5~10년	["TypeScript", "JavaScript", "GitHub Actions"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50905	backend
1659	Verification Engineer/분당R&D	아이디어스투실리콘	경기 성남시	경력 3~15년	["Verilog", "ASIC", "Perl", "TCP/IP", "Python"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/49886	other
1660	AI 개발자 채용	티에스엔랩	경기 용인시	경력 2~5년	["Python", "AI/인공지능", "DeepLearning"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/50787	data
1661	산업용 모니터 개발	엠투아이코퍼레이션	경기 안양시	신입~3년	["HW", "Embedded", "MCU", "Circuit design"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/50007	design
1662	[4년 이상] Backend Engineer	큐픽스	경기 성남시	경력 4~12년	["Ruby", "TypeScript", "Java", "Python"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50673	backend
1663	AI Research Engineer - LLM	업스테이지	경기 용인시	신입~20년	["AI/인공지능", "TensorFlow", "PyTorch", "NLP"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50525	data
1664	IoT시스템 개발 기획(PM) 경력자 모집	메타이노텍	경기 수원시	경력 5~10년	["Azure IoT Hub", "Google Cloud IoT Core"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50603	backend
1665	HW/임베디드 개발자 모집	메타이노텍	경기 수원시	경력 3~10년	["HW", "FW", "Embedded", "SW", "C", "C++"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50604	embedded
1666	모바일 APP(IOS) 개발자 모집	에스디바이오센서	경기 수원시	경력 1~20년	["iOS", "REST API", "C++", "Objective-C"]	마감 기한: D-1	https://jumpit.saramin.co.kr/position/49868	mobile
1667	Flutter 앱 개발자	제네시스네스트	경기 용인시	경력 1~7년	["Flutter", "Swift", "Kotlin", "Git", "REST API"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50823	mobile
1668	Software Quality Assurance	네비웍스	경기 안양시	경력 6~10년	["SW", "QA", "Jira", "Confluence", "HW"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50570	qa
1669	웹 서비스 Front-end 개발자 (경력)	엔닷라이트	경기 성남시	경력 5~10년	["TypeScript", "JavaScript", "CSS 3", "Next.js"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50904	frontend
1670	Global 서비스 Back-end개발	숲	경기 성남시	경력 3~10년	["Node.js", "JavaScript", "TypeScript"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50568	backend
1671	[신입] Python 개발자	에피넷	경기 안양시	신입	["AI/인공지능", "Python", "Django"]	마감 기한: D-32	https://jumpit.saramin.co.kr/position/51587	backend
1672	회로개발 (경력 11~15년)	원익피앤이	경기 수원시	경력 11~15년	["HW", "SW", "Embedded", "FW"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/50991	embedded
1673	AI Research Engineer - Document AI	업스테이지	경기 용인시	신입~20년	["AI/인공지능", "TensorFlow", "PyTorch", "NLP"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50523	data
1674	솔루션 엔지니어(시스템 엔지니어/SE)	이파피루스	경기 성남시	경력 2~10년	["Docker", "Python", "Network", "Java"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50894	devops
1675	완성차 검차라인 SW 개발(10년↑)	에이디티	경기 안산시	경력 10~15년	["C#", "C", "C++", "Mfc", "SW"]	마감 기한: D-7	https://jumpit.saramin.co.kr/position/50220	other
1676	프론트엔드 개발자 채용(팀장급)	이파피루스	경기 성남시	경력 7~15년	["AngularJS", "TypeScript", "RxJS", "Sass"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50620	frontend
1677	AI모델 개발 전략매니저	업스테이지	경기 용인시	경력 3~20년	["AI/인공지능"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50529	data
1678	Human Pose Estimation (딥러닝,경력)	스포츠투아이	경기 성남시	경력 3~20년	["3D Rendering", "AI/인공지능", "Python"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/51101	data
1679	반도체 자동화시스템개발(RMS/FDC)경력	엘비세미콘	경기 평택시	경력 3~5년	["C", "Vb.net", "Oracle", "MSSQL", "C#"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/49978	other
1680	반도체 TEST 프로그램 개발 (경력)	엘비세미콘	경기 평택시	경력 5~20년	["QA", "IPS", "FLEX", "EDA", "Python", "C#"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51325	qa
1681	임베디드 소프트웨어 개발자(9~12년차)	긴트	경기 성남시	경력 9~12년	["C", "C++", "SW", "Embedded"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50349	embedded
1682	언리얼 엔진 프로그래머	에이버튼	경기 성남시	경력 2~20년	["C++", "Unreal Engine"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50475	game
1683	서버 개발 (5년 이상)	마카롱팩토리	경기 성남시	경력 3~10년	["Spring", "Kotlin", "Java", "AWS", "MySQL"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/51097	backend
1684	Unreal 클라이언트 개발자 채용(경력)	네비웍스	경기 안양시	경력 3~10년	["C++", "Unreal Engine"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50151	game
1685	판교연구소 SW개발 (경력 13~15년)	인텔리안테크놀로지스	경기 평택시	경력 13~15년	["C", "C++", "Embedded Linux", "JsonAPI"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/50969	design
1686	전기차 충전 백엔드 개발자 채용	EVAR	경기 성남시	경력 3~10년	["AWS", "Docker", "MSA", "Node.js"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50663	backend
1687	이미지 프로세싱 알고리즘 개발 신입	포스로직	경기 안양시	신입	["C", "C++", "CUDA", "DeepLearning"]	마감 기한: D-13	https://jumpit.saramin.co.kr/position/50626	other
1688	AI/LLM Curriculum Developer	업스테이지	경기 용인시	신입~20년	["AI/인공지능", "PyTorch"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50535	data
1689	임베디드 S/W 엔지니어 모집 [경력]	인터콘시스템스	경기 안양시	경력 3~10년	["MCU", "RTOS", "Embedded Linux", "C"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50415	design
1690	기구설계 엔지니어 모집	앤씨앤	경기 성남시	경력 5~15년	["Embedded Linux", "C", "C++", "SW", "TCP/IP"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49994	design
1691	클라우드 솔루션 아키텍트 - GenAI(글로벌)	업스테이지	경기 용인시	신입~20년	["AI/인공지능", "AWS", "GCP", "AZURE"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50537	devops
1692	F/W 펌웨어 개발	오토엘	경기 성남시	경력 5~12년	["ARM", "C", "C++", "Embedded Linux", "FW"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50824	design
1693	AI 개발자(3년 이상)	네비웍스	경기 안양시	경력 3~10년	["Python", "Linux", "TensorFlow", "PyTorch"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50153	data
1694	[경력] Java 풀스택 개발자	에피넷	경기 안양시	경력 2~7년	["Java", "Linux", "Docker"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/46044	fullstack
1695	QA 엔지니어 (경력)	엔닷라이트	경기 성남시	경력 3~6년	["QA", "3D Rendering", "SW"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50912	qa
1696	IMS & ECS 개발 (경력 6~9년)	원익피앤이	경기 수원시	경력 6~9년	["C#", "WPF"]	마감 기한: D-8	https://jumpit.saramin.co.kr/position/49798	other
1697	IMS & ECS 개발 (경력 13~15년)	원익피앤이	경기 수원시	경력 13~15년	["C#", "WPF"]	마감 기한: D-8	https://jumpit.saramin.co.kr/position/49799	other
1698	[로봇] 강화학습 엔지니어 채용	플라잎	경기 성남시	경력 3~5년	["C", "C++", "Python", "MachineLearning"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50056	robotics
1699	F/W개발(MCU) (경력 3~7년)	원익피앤이	경기 수원시	경력 3~7년	["C", "FW", "MCU"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/50992	embedded
1700	H/W 엔지니어 모집(경력 1~5년)	인터콘시스템스	경기 안양시	경력 1~5년	["HW", "Orcad", "Pads", "Autocad", "MCU"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50417	embedded
1701	Java 백엔드 개발자(5~10년) 모집	WATA Inc.	경기 성남시	경력 5~10년	["Java", "Spring Framework", "JSP", "AWS"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50396	backend
1702	AI Model Production - Document AI	업스테이지	경기 용인시	경력 2~20년	["Python", "Java", "AI/인공지능", "Ubuntu"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50530	data
1703	AI Application Engineer	업스테이지	경기 용인시	경력 3~20년	["AI/인공지능", "PyTorch", "NLP"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50534	data
1704	웹 개발자 경력직 채용(3년 이상)	네비웍스	경기 안양시	경력 3~7년	["React", "NestJS", "SQL", "REST API", "Git"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50147	backend
1705	전기전자 설계 개발(경력)	네비웍스	경기 안양시	경력 3~5년	["Orcad", "PCB", "2D Rendering"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50148	other
1706	HW 기구 설계(경력)	네비웍스	경기 안양시	경력 5~15년	["Solidworks", "Autocad"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50149	other
1707	SW Engineer:어플리케이션	리브스메드	경기 성남시	경력 3~12년	["SW", "C", "C++", "Qt", "GUI"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50317	design
1708	Node.js 백엔드 개발자 (4년 이상)	티엔에이치	경기 성남시	경력 4~6년	["Node.js", "JavaScript", "TypeScript"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51278	backend
1709	[CT] 의료영상처리 알고리즘 SW	덴티움	경기 수원시	경력 2~10년	["C++", "OpenCV", "CUDA", "SW"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50736	other
1710	의료기기 GUI S/W 경력 채용	아프로코리아	경기 군포시	경력 5~10년	["SW", "C#", "Visual Studio", "Embedded"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/49947	design
1711	자율주행 개발자(신입~3년차)	긴트	경기 성남시	신입~3년	["MATLAB", "C", "C++", "SW", "Python"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51485	other
1712	3D AI 엔지니어 (경력)	엔닷라이트	경기 성남시	경력 2~10년	["AI/인공지능"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50910	data
1713	반도체 자동화시스템개발(RMS/FDC)신입	엘비세미콘	경기 평택시	신입	["C", "Vb.net", "Oracle", "MSSQL", "C#"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/49977	other
1714	ERP/MES 개발자 및 PM 채용	이맥스하이텍	경기 남양주시	경력 5~15년	["Java", "ERP", "MES", "C#", ".NET", "SW", "JSP"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50513	pm
1715	임베디드 S/W 엔지니어 모집 [신입]	인터콘시스템스	경기 안양시	신입~2년	["MCU", "RTOS", "Embedded Linux", "C"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50416	design
1716	DEVOPS 엔지니어	보스반도체	경기 성남시	경력 1~8년	["JavaScript", "Python", "Jenkins", "GitHub"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/50113	frontend
1717	백엔드 개발자 (5년 ~ 7년)	프롬프트팩토리	경기 성남시	경력 5~7년	["AWS", "Node.js", "ExpressJS", "Django"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/51062	backend
1718	[전기차충전기]안드로이드 개발자	피앤이시스템즈	경기 수원시	경력 5~10년	["Kotlin", "Jetpack", "Composer", "SQLite"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50174	mobile
1719	[IT] 백엔드 SW개발 (전자차트)	덴티움	경기 수원시	경력 3~9년	["Node.js", "GraphQL", "AWS", "RDB", "MySQL"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50734	backend
1720	Robot Control Engineer (전문연 가능)	플라잎	경기 성남시	경력 3~10년	["AI/인공지능", "C", "C++", "Python"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50055	data
1721	자율주행 개발자(7~10년차)	긴트	경기 성남시	경력 7~10년	["MATLAB", "C", "C++", "SW", "Python"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50351	other
1722	웹서버 개발자 모집	슈프리마	경기 성남시	경력 5~10년	["C++", "Java", "Spring", "React"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/49794	backend
1723	얼굴인식 서버 풀스택 소프트웨어 개발자	슈프리마	경기 성남시	경력 3~7년	["C++", "Go"]	마감 기한: D-13	https://jumpit.saramin.co.kr/position/50616	backend
1724	SDK개발 (C++, C#, QT, DB)	레이언스	경기 화성시	경력 5~15년	["C++", "C#", "Qt", "DB", "TCP/IP"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50478	other
1725	QA 담당자(3~5년차)	와디즈	경기 성남시	경력 3~5년	["QA"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49946	qa
1726	ERP/MES 개발자 및 PL 채용	이맥스하이텍	경기 남양주시	경력 4~15년	["Java", "ERP", "MES", "C#", ".NET", "SW", "JSP"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50512	other
1727	FPGA 개발자 채용	티에스엔랩	경기 용인시	신입~5년	["FPGA", "Verilog", "Git", "AI/인공지능"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/50165	data
1728	응용 소프트웨어 개발	오토엘	경기 성남시	경력 5~10년	["C", "C++"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50825	other
1729	임베디드 소프트웨어 개발자(5~8년차)	긴트	경기 성남시	경력 5~8년	["C", "C++", "SW", "Embedded"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50350	embedded
1730	ERP/MES 개발자 채용	이맥스하이텍	경기 남양주시	경력 1~15년	["Java", "ERP", "MES", "C#", ".NET", "SW", "JSP"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50511	other
1731	ADAS NPU AI SW Engineer	보스반도체	경기 성남시	신입	["PyTorch", "TensorFlow", "DeepLearning"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/50109	data
1732	Embedded Middleware 개발자	앤씨앤	경기 성남시	경력 5~10년	["Embedded Linux", "C", "C++", "SW", "TCP/IP"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49993	design
1733	SOC TOP Design Enginer	보스반도체	경기 성남시	경력 2~15년	["ARM", "Verilog", "Python", "C++", "OpenCV"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/50111	other
1734	인공지능(AI) 엔지니어 신입 채용	알비에치	경기 안양시	신입	["MachineLearning", "DeepLearning"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50551	data
1735	통신장비 시스템 h/w 개발자	에프알텍	경기 의왕시	신입	["PCB"]	마감 기한: D-26	https://jumpit.saramin.co.kr/position/51446	other
1736	강화학습 기반 AI 엔지니어 (3~5년)	아이리브	경기 성남시	경력 3~5년	["PyTorch", "DeepLearning", "Unity"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50176	data
1737	응용 SW 개발 모집	비솔	경기 광명시	경력 7~20년	["Python", "C++", "C#", "SW", "OpenCV"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50768	other
1738	윈도우 어플리케이션 개발자	체크멀	경기 용인시	경력 2~10년	["Visual Studio", "Mfc", "C", "C++", "Windows"]	마감 기한: D-13	https://jumpit.saramin.co.kr/position/50637	other
1739	전자제어 H/W [경력15~20년]	태하	경기 남양주시	경력 15~20년	["HW", "MCU", "PCB"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50413	embedded
1740	전자제어 S/W [신입~4년]	태하	경기 남양주시	신입~4년	["SW", "C", "C++", "FW"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50406	robotics
1741	강화학습 기반 AI 엔지니어 (6~10년)	아이리브	경기 성남시	경력 6~10년	["PyTorch", "DeepLearning", "Unity"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50177	data
1742	제어설계(PC) 분야 [경력10~15년]	태하	경기 남양주시	경력 10~15년	["SW", "C", "C#", "C++", "Mfc", "MES", "SQL"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50409	robotics
1743	웹개발 풀스텍 개발자(신입 )	오마이어스	경기 성남시	신입	["PHP", "Laravel"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50955	backend
1744	Java 백엔드 개발자(11~15년)모집	WATA Inc.	경기 성남시	경력 11~15년	["Java", "Spring Framework", "JSP", "AWS"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50395	backend
1745	어플리케이션 개발 및 유지보수	엠투아이코퍼레이션	경기 안양시	신입~5년	["C++", "Qt"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/50008	other
1746	사내그룹웨어,파트너 B2B 서비스 개발	지니언스	경기 안양시	경력 1~15년	["Laravel", "Travis CI", "PHP", "Git"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50596	backend
1747	인공지능(AI) 엔지니어 초급 채용	알비에치	경기 안양시	경력 1~3년	["MachineLearning", "DeepLearning"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50548	data
1748	AI 기반 업무 자동화 엔지니어 (4~6년)	큐픽스	경기 성남시	경력 4~6년	["RPA", "Zapier"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51506	data
1749	배구 3D 챌린지 시스템 개발	스포츠투아이	경기 성남시	경력 2~15년	["OpenGL", "C++", "Unreal Engine", "C", "AR"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/51100	game
1750	웹 프론트엔드 개발자 채용(4년 이상)	비글즈	경기 성남시	경력 4~15년	["Next.js", "React", "JavaScript", "TypeScript"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/51051	frontend
1751	[CTO레벨] NLP AI 엔지니어	에이블제이	경기 성남시	경력 5~15년	["PyTorch", "TensorFlow", "Transformers"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/51127	data
1752	자사 쇼핑몰 전산팀원 모집	파츠몰	경기 고양시	경력 3~10년	["JavaScript", "MSSQL", "Spring Boot", "JSP"]	마감 기한: D-32	https://jumpit.saramin.co.kr/position/51554	backend
1753	S/W개발	원익피앤이	경기 수원시	경력 6~20년	["Python", "TensorFlow", "Keras"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51012	data
1754	영상관제 응용프로그램 개발(10년↑)	엘케이삼양	경기 과천시	경력 10~20년	["C#", "WPF", "SW", "OpenCV", "FFMPEG", "Git"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50740	other
1755	NLP AI 엔지니어	에이블제이	경기 성남시	경력 3~15년	["PyTorch", "TensorFlow", "Transformers"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50903	data
1756	AI 기반 업무 자동화 엔지니어 (1~3년)	큐픽스	경기 성남시	경력 1~3년	["RPA", "Zapier"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51505	data
1757	개발 계획 및 개발 진행 PM(15~20년)	WATA Inc.	경기 성남시	경력 15~20년	["GitHub", "Jira", "Java", "AWS", "RDB"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50951	devops
1758	2차전지 검사장비 개발/유지보수 채용	피닉슨컨트롤스	경기 화성시	경력 1~5년	["C#", "MSSQL", "SW", "MySQL", "C++", "WPF"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49944	other
1759	회로개발 (경력 8~10년)	원익피앤이	경기 수원시	경력 8~10년	["HW", "SW", "Embedded", "FW"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/50989	embedded
1760	영상관제 응용프로그램 개발(6년↑)	엘케이삼양	경기 과천시	경력 6~9년	["C#", "WPF", "SW", "OpenCV", "FFMPEG", "Git"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50760	other
1761	AI Product Owner	업스테이지	경기 용인시	경력 5~20년	["AI/인공지능", "Python", "C++", "Linux", "Shell"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50536	data
1762	영상관제 응용프로그램 개발(3년↑)	엘케이삼양	경기 과천시	경력 3~5년	["C#", "WPF", "SW", "OpenCV", "FFMPEG", "Git"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50759	other
1763	공급망보안관리솔루션설계/개발(16~20)	쿤텍	경기 성남시	경력 16~20년	["Linux", "Windows Server", "Golang"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50261	backend
1764	Embeded System SW 엔지니어	보스반도체	경기 성남시	신입~15년	["ARM", "Verilog", "Python", "C++", "SW"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/50110	other
1765	EV charger server 개발자	피앤이시스템즈	경기 수원시	경력 3~5년	["Node.js", "TypeScript", "NestJS", "MySQL"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/50171	backend
1767	PC 제어(시스템제어팀) (5~7년)	쎄크	경기 수원시	경력 5~7년	["C++", "Mfc", "SW", "Embedded", "C"]	마감 기한: D-1	https://jumpit.saramin.co.kr/position/49839	embedded
1768	SoC Design Verification	보스반도체	경기 성남시	경력 2~15년	["C", "C++", "Java", "PM2", "Verilog"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/50112	pm
1769	SoC RTL DFT Design Engineer	보스반도체	경기 성남시	경력 5~15년	["PCB", "HW", "Embedded"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/50107	embedded
1770	EV charger embedded 개발	피앤이시스템즈	경기 수원시	경력 3~6년	["Rust", "C++"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/50173	embedded
1771	소프트웨어 엔지니어(3~5년)	에이딘로보틱스	경기 안양시	경력 3~5년	["Python", "C++", "Linux", "ethernet", "TCP/IP"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50381	design
1772	SoC RTL Design Engineer	보스반도체	경기 성남시	경력 2~15년	["C", "C++", "Python", "Verilog"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/50108	other
1773	미디어아트 XR 임베디드 시스템 개발자	프롬프트팩토리	경기 성남시	신입	["Python", "C", "C++", "Java", "MCU"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50898	embedded
1774	검사장비 HW/FW 개발 경력 채용	피닉슨컨트롤스	경기 화성시	경력 5~15년	["HW", "FW", "ARM", "PCB"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50453	other
1775	개발 계획 및 개발 진행PM(10~14)	WATA Inc.	경기 성남시	경력 10~14년	["GitHub", "Jira", "Java", "AWS", "RDB"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50949	devops
1776	웹개발 풀스텍 개발자(경력8년이상 ~ )	오마이어스	경기 성남시	경력 8~15년	["PHP", "Laravel"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50954	backend
1777	기술개발 총괄 및 리딩(16~20년)	WATA Inc.	경기 성남시	경력 16~20년	["RDB", "REST API", "C++", "Java", "AWS"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50946	devops
1778	기술개발 총괄 및 리딩(12~15년)	WATA Inc.	경기 성남시	경력 12~15년	["RDB", "REST API", "C++", "Java", "AWS"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50947	devops
1779	웹개발 풀스텍 개발자(경력5~7년)	오마이어스	경기 성남시	경력 5~7년	["PHP", "Laravel"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50953	backend
1780	QA 담당자(6~8년차)	와디즈	경기 성남시	경력 6~8년	["QA"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49945	qa
1781	H/W 엔지니어 모집(경력 6~10년)	인터콘시스템스	경기 안양시	경력 6~10년	["HW", "Orcad", "Pads", "Autocad", "MCU"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50414	embedded
1782	SDV 솔루션 2,3팀	슈어소프트테크	경기 성남시	신입~5년	["C", "SW", "MATLAB"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/50221	other
1783	시스템 엔지니어 (경력)	아주큐엠에스	경기 용인시	경력 2~5년	["Linux", "Windows", "AWS", "AZURE", "GCP"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50569	devops
1784	풀스택(Java) 개발자(전문연구요원가능)	베스텔라랩	대구 동구, 경기 안양시	경력 2~10년	["Spring Framework", "Spring Boot"]	마감 기한: D-26	https://jumpit.saramin.co.kr/position/51257	backend
1785	프론트엔드/풀스택 개발자 채용	크레스콤	경기 성남시	경력 2~20년	["CSS 3", "JavaScript", "React", "Vue.js"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50689	frontend
1786	3D 그래픽스 엔지니어 (신입/경력)	엔닷라이트	경기 성남시	신입~10년	["WebGL", "three.js", "BabylonJS", "OpenGL"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50907	other
1787	제어로직개발팀	슈어소프트테크	경기 성남시	경력 2~8년	["C", "SW", "MATLAB", "C++"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50222	robotics
1788	AI 테스트 도구 백엔드 개발	슈어소프트테크	경기 성남시	경력 2~8년	["Python", "AI/인공지능", "FastAPI", "Flask"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50234	backend
1789	인공지능/데이터 분석 개발자 채용	크레스콤	경기 성남시	경력 2~20년	["DeepLearning", "AI/인공지능", "Python"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50690	data
1790	시스템 운영 및 웹 개발자 모집	코스메카코리아	경기 성남시	경력 3~7년	["Java", "JSP", "DB", "MSSQL", "MySQL"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51336	other
1791	차량 데이터 검증 솔루션 개발	슈어소프트테크	경기 성남시	경력 2~7년	["Java", "Python", "SW"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50908	data
1792	PLC (Mitsubishi) 제어 (2년이상)	쎄크	경기 수원시	경력 2~5년	["PLC", "HW"]	마감 기한: D-1	https://jumpit.saramin.co.kr/position/49837	robotics
1793	자율주행 로봇 개발자	베스텔라랩	대구 동구, 경기 안양시	경력 2~15년	["Python", "Spring Framework", "AWS", "Git"]	마감 기한: D-26	https://jumpit.saramin.co.kr/position/51260	backend
1794	빅데이터 개발자(전문연구요원가능)	베스텔라랩	대구 동구, 경기 안양시	신입~8년	["Python", "Spring Framework", "AWS"]	마감 기한: D-26	https://jumpit.saramin.co.kr/position/51254	backend
1795	시스템 운용/유지보수	베스텔라랩	경기 안양시	신입~8년	["Ccna", "Ccnp", "VPN", "Router", "Linux"]	마감 기한: D-26	https://jumpit.saramin.co.kr/position/51255	design
1796	자율주행 연구원(전문연구요원가능)	베스텔라랩	대구 동구, 경기 안양시	경력 2~15년	["Python", "Spring Framework", "AWS", "Git"]	마감 기한: D-26	https://jumpit.saramin.co.kr/position/51262	backend
1798	AI 카메라 임베디드 소프트웨어 엔지니어	슈프리마	경기 성남시	경력 1~10년	["C", "C++"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50897	data
1799	C#개발자(네트워크 기술팀)	슈어소프트테크	경기 성남시	경력 3~7년	["C", "C++", "Visual Studio", "Embedded"]	마감 기한: D-13	https://jumpit.saramin.co.kr/position/50223	embedded
1800	UI테스팅 자동화 솔루션 개발	슈어소프트테크	경기 성남시	경력 2~7년	["Java", "Python", "SW", "Eclipse"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50909	design
1801	영상 처리 연구/개발(전문연구요원가능)	베스텔라랩	대구 동구, 경기 안양시	경력 2~10년	["Python", "OpenCV", "Java", "Spring Boot"]	마감 기한: D-26	https://jumpit.saramin.co.kr/position/51263	backend
1805	영상처리(Vision) S/W 개발 (7~10년)	쎄크	경기 수원시	경력 7~10년	["C++", "C#", "OpenCV", "SW", "HALCON"]	마감 기한: D-1	https://jumpit.saramin.co.kr/position/49845	other
1806	영상처리(Vision) S/W 개발 (5~7년)	쎄크	경기 수원시	경력 5~7년	["C++", "C#", "OpenCV", "SW", "HALCON"]	마감 기한: D-1	https://jumpit.saramin.co.kr/position/49844	other
1807	PLC (SIEMENS) 제어 (2~4년)	쎄크	경기 수원시	경력 2~4년	["C++", "Mfc", "SW", "C"]	마감 기한: D-1	https://jumpit.saramin.co.kr/position/49852	robotics
1808	PLC (SIEMENS) 제어 (5~7년)	쎄크	경기 수원시	경력 5~7년	["C++", "Mfc", "SW", "C"]	마감 기한: D-1	https://jumpit.saramin.co.kr/position/49853	robotics
1809	PC 제어(시스템제어팀) (2~4년)	쎄크	경기 수원시	경력 2~4년	["C++", "Mfc", "SW", "Embedded", "C"]	마감 기한: D-1	https://jumpit.saramin.co.kr/position/49838	embedded
1810	PC 제어(시스템제어팀) (8~10년)	쎄크	경기 수원시	경력 8~10년	["C++", "Mfc", "SW", "Embedded", "C"]	마감 기한: D-1	https://jumpit.saramin.co.kr/position/49840	embedded
1811	앱개발 프로그래머 신입 채용	파이	경기 수원시	신입	["OpenCV", "Flutter", "React", "Swift"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50012	frontend
1812	전산 담당자 계약직 채용(4~6년)	얼라인드제네틱스	경기 안양시	경력 4~6년	["ERP", "SW"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50773	other
1813	제어 컨트롤러 펌웨어 개발자 (7~10년)	유앤아이솔루션	경기 광주시	경력 7~10년	["C", "C++", "ARM", "FPGA", "Embedded"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51203	embedded
1814	앱개발 프로그래머 경력(8~10년)채용	파이	경기 수원시	경력 8~10년	["OpenCV", "Flutter", "React", "Swift"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50019	frontend
1815	하드웨어 및 펌웨어 개발자	한솔리드텍	경기 의왕시	경력 9~11년	["C", "C++", "Linux", "Orcad"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50671	design
1816	주차장 서비스기획자 경력 채용	하이파킹	경기 성남시	경력 10~20년	["Figma", "ProtoPie", "Adobe XD", "Firebase"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51357	pm
1817	[SW 개발] C++/C# 개발자 신입	파이	경기 수원시	신입	["C++", "C#"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50021	other
1818	앱개발 프로그래머 경력 (5~7년)채용	파이	경기 수원시	경력 5~7년	["OpenCV", "Flutter", "React", "Swift"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50016	frontend
1819	H/W 개발 경력직원 채용	인텍에프에이	경기 용인시	경력 1~10년	["Orcad", "HW", "Pads"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51290	other
1820	Soc Design Engineer	아이에이치더블유	경기 용인시	경력 3~20년	["Git", "EDA", "TCP/IP", "ARM", "Verilog"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/51009	other
1821	자동차 전기·전자 분야 개발/엔지니어링 3년↑	모빌리티네트웍스	경기 안양시	경력 3~5년	["HW", "SW", "Embedded", "Jira", "Confluence"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51282	embedded
1822	[SW 개발] C++/C# 개발자 경력(8~10년)	파이	경기 수원시	경력 8~10년	["C++", "C#"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50024	other
1823	회로설계 경력 엔지니어 채용	유버	경기 안산시	경력 2~20년	["Orcad", "Pads", "PCB"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50291	other
1824	하드웨어 및 펌웨어 개발자	한솔리드텍	경기 의왕시	경력 3~5년	["C", "C++", "Linux", "Orcad"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50669	design
1825	[SW 개발] C++/C# 개발자 경력(2~4년)	파이	경기 수원시	경력 2~4년	["C++", "C#"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50022	other
1826	전산 담당자 계약직 채용(1~3년)	얼라인드제네틱스	경기 안양시	경력 1~3년	["ERP", "SW"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50772	other
1827	NPU Design Engineer	아이에이치더블유	경기 용인시	경력 3~20년	["EDA", "Verilog", "AI/인공지능"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/51010	data
1828	앱개발 프로그래머 경력 (2~4년)채용	파이	경기 수원시	경력 2~4년	["OpenCV", "Flutter", "React", "Swift"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50013	frontend
1829	하드웨어 개발자(10년~)	캐스트프로	경기 성남시	경력 10~20년	["HW"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50368	other
1830	펌웨어 개발자(10년~)	캐스트프로	경기 성남시	경력 10~20년	["MCU", "C", "FW"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50421	embedded
1832	펌웨어 개발자(1~10년)	캐스트프로	경기 성남시	경력 1~10년	["MCU", "C", "FW"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50420	embedded
1833	장비제어 프로그램 개발자	제이엔에스	경기 화성시	경력 3~15년	["C#"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/49924	robotics
1834	하드웨어 개발자(1~9년)	캐스트프로	경기 성남시	경력 1~9년	["HW"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50369	other
1835	(키퍼)Back End Engineer(5~9년)	한화비전	경기 성남시	경력 5~9년	["Node.js", "REST API", "PostgreSQL"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50239	backend
1838	AI 연구원 (3~9년)	한화비전	경기 성남시	경력 3~9년	["Git", "BigData", "C++", "MachineLearning"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50241	data
1845	윈도우 응용 프로그래머(C++)	네비웍스	경기 안양시	경력 3~15년	["C", "C++", "C#", "TCP/IP", "GUI", "Mfc", "Linux"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50152	design
1846	인공지능(AI) 엔지니어 고급 채용	알비에치	경기 안양시	경력 8~10년	["MachineLearning", "DeepLearning"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50550	data
1847	Backend developer	유비퍼스트대원	경기 성남시	경력 4~10년	["Java", "Kotlin", "Spring Boot", "CSS 3"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51197	backend
1848	로봇제어Engineer:Senior(과장-부장)[박사급]	리브스메드	경기 성남시	경력 7~18년	["C++", "Python", "Git", "Notion", "Jira", "C"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50320	robotics
1849	영상처리,비전(Vision) S/W채용(3~5년)	포우	경기 용인시	경력 3~5년	["SW", "OpenCV", "C++"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50397	other
1851	전산팀 서버 구축 기획 경력 채용[8~11년]	오비오	경기 화성시	경력 8~11년	["MSSQL", "ERP"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51511	backend
1852	공급망보안관리솔루션 설계/개발(7~10)	쿤텍	경기 성남시	경력 7~10년	["Linux", "Windows Server", "Golang"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50257	backend
1853	악성코드 분석가(전문연구요원) 신입	시큐레터	경기 성남시	신입	["Network", "Linux", "Ddos", "IPS", "Firewall"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50449	design
1854	SRE팀 SRE엔지니어(팀장)	지니언스	경기 안양시	경력 15~20년	["Jira", "Testrail", "QA"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50594	data
1856	디지털헬스케어 플랫폼 AI 엔지니어	엑소시스템즈	경기 성남시	신입~10년	["AI/인공지능", "C++", "MATLAB"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51468	data
1857	PNS팀 서버 개발자	지니언스	경기 안양시	경력 5~15년	["C", "C++", "Linux", "VPN"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50589	backend
1858	Flutter 앱개발자	테일크루	경기 성남시	경력 3~10년	["Flutter", "CSS 3", "JavaScript", "TypeScript"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51537	frontend
1859	Cloud Security Engineer(5년~)	한화비전	경기 성남시	경력 5~9년	["ISMS", "AWS", "AZURE", "Firewall", "IPS"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50242	devops
1860	Citrix 가상화 엔지니어 모집	누리인포스	경기 성남시	신입	["Citrix Gateway", "Linux", "Windows Server"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/50100	design
1861	영상처리,비전(Vision) S/W채용(9년↑)	포우	경기 용인시	경력 9~11년	["SW", "OpenCV", "C++"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50400	other
1862	PNS팀 윈도 개발자	지니언스	경기 안양시	경력 5~15년	["C", "C#", "C++", "VPN"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50590	other
1864	AI 연구원 (10~12년)	한화비전	경기 성남시	경력 10~12년	["Git", "BigData", "C++", "MachineLearning"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50240	data
1865	iOS 개발 (5년 이상)	마카롱팩토리	경기 성남시	경력 5~10년	["iOS", "Xcode", "Flutter", "Swift", "Rxswift"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/51098	mobile
1866	AI 개발자 연구원 경력	엔티엘헬스케어	경기 성남시	경력 3~10년	["AI/인공지능"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51423	data
1867	바이오인식 / OCR 알고리즘 개발	엑스페릭스	경기 성남시	경력 2~7년	["C", "C++", "C#", "Java", "Python"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51404	other
1868	전산팀 서버 구축 기획 경력 채용[5~7년]	오비오	경기 화성시	경력 5~7년	["MSSQL", "ERP"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51510	backend
1869	(키퍼) Back End Engineer (10년~)	한화비전	경기 성남시	경력 10~12년	["Node.js", "REST API", "PostgreSQL"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50238	backend
1870	공급망보안관리솔루션설계/개발(11~15)	쿤텍	경기 성남시	경력 11~15년	["Linux", "Windows Server", "Golang"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50259	backend
1871	MultiOS팀 Linux보안 소프트웨어 개발	지니언스	경기 안양시	경력 7~15년	["C", "C++", "Linux", "OpenSSL", "Kafka"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50592	mobile
1873	전산팀 서버 구축 기획 경력 채용[12~15년]	오비오	경기 화성시	경력 12~15년	["MSSQL", "ERP"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51512	backend
1874	Server팀 Frontend 개발 및 유지보수	지니언스	경기 안양시	경력 10~20년	["HTML5", "CSS 3", "JavaScript", "React"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50593	frontend
1875	SRE팀 SRE엔지니어	지니언스	경기 안양시	경력 5~15년	["QA", "Jira", "Testrail"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50595	data
1876	AI 연구개발자 (석사)	더블티	경기 수원시	신입	["AI/인공지능", "scikit-learn", "PyTorch"]	마감 기한: D-26	https://jumpit.saramin.co.kr/position/51441	data
1879	ERP운영/유지보수 개발자_2년 이상	블루닉스	경기 안산시	경력 2~4년	["Delphi", "C#", "Oracle", "MSSQL", "MySQL"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51165	other
1880	ERP운영/유지보수 개발자_5년 이상	블루닉스	경기 안산시	경력 5~7년	["Delphi", "C#", "Oracle", "MSSQL", "MySQL"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51166	other
1881	데이터베이스(DB) 개발	모빌리티네트웍스	경기 안양시	경력 10~20년	["SQL", "NoSql", "MySQL", "Oracle"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51287	data
1882	백엔드 개발자 채용(경력 10년이상)	하이파킹	경기 성남시	경력 10~20년	["Java", "Spring Boot", "K8S", "Docker", "ELK"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51355	backend
1883	컴퓨터 비전 딥러닝/머신러닝(3년이상)	에프에스솔루션	경기 성남시	경력 3~9년	["OpenCV", "C++", "MachineLearning"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50268	data
1885	ERP운영/유지보수 개발자_8년 이상	블루닉스	경기 안산시	경력 8~10년	["Delphi", "C#", "Oracle", "MSSQL", "MySQL"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51167	other
1886	백엔드 개발자 채용(경력 5년~10년)	하이파킹	경기 성남시	경력 5~10년	["Java", "Spring Boot", "ELK", "Kafka"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51356	backend
1887	컴퓨터 비전 딥러닝/머신러닝(신입)	에프에스솔루션	경기 성남시	신입	["OpenCV", "C++", "MachineLearning"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50269	data
1888	개발 계획 및 개발 진행 PM(5~9년)	WATA Inc.	경기 성남시	경력 5~9년	["GitHub", "Jira", "Java", "AWS", "RDB"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50950	devops
1889	HW개발자(5년이상) 채용	씨앤유글로벌	경기 성남시	경력 5~10년	["Orcad", "Pads", "MCU", "HW"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49936	embedded
1890	WiFi Router개발 경력 1~5년	가온브로드밴드	경기 성남시	경력 1~5년	["C", "Linux", "C++", "Embedded", "Router"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51572	design
1891	Java 백엔드 개발(광고 서비스)	와디즈	경기 성남시	경력 5~10년	["Java", "Spring", "Spring Boot", "REST API"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51337	backend
1892	웹개발 풀스텍 개발자(경력2~4년)	오마이어스	경기 성남시	경력 2~4년	["PHP", "Laravel"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50952	backend
1893	완성차 검차라인 SW 개발(5년↑)	에이디티	경기 안산시	경력 5~9년	["C#", "C", "C++", "Mfc", "SW"]	마감 기한: D-7	https://jumpit.saramin.co.kr/position/50219	other
1894	WiFi Router 개발 신입 채용	가온브로드밴드	경기 성남시	신입	["C", "Linux", "C++", "Embedded", "Router"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51571	design
1895	AI Model Production - LLM	업스테이지	경기 용인시	경력 2~20년	["AI/인공지능"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50528	data
1897	컴퓨터 비전 딥러닝/머신러닝(팀장급)	에프에스솔루션	경기 성남시	경력 10~15년	["OpenCV", "C++", "MachineLearning"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50267	data
1898	AI/ML Senior 연구자	서플러스글로벌	경기 성남시	경력 5~20년	["AI/인공지능", "Python", "R", "NLP", "PyTorch"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50737	data
1899	모터제어 엔지니어(6~10년차)	긴트	경기 성남시	경력 6~10년	["C", "C++", "SW", "Embedded"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50348	embedded
1900	전자제어 S/W [경력5~10년]	태하	경기 남양주시	경력 5~10년	["SW", "C", "C++", "FW"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50407	robotics
1901	Service architect(VDMS)	유비퍼스트대원	경기 성남시	경력 3~10년	["Figma", "Microsoft Excel"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51200	design
1902	제어설계(PC) 분야 [경력5~9년]	태하	경기 남양주시	경력 5~9년	["SW", "C", "C#", "C++", "Mfc", "MES", "SQL"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50408	robotics
1903	자율주행 개발자(3~6년차)	긴트	경기 성남시	경력 3~6년	["MATLAB", "C", "C++", "SW", "Python"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50352	other
1904	전자제어 H/W [경력10~14년]	태하	경기 남양주시	경력 10~14년	["HW", "MCU", "PCB"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50411	embedded
1905	AI 연구개발자 (박사)	더블티	경기 수원시	신입	["AI/인공지능", "PyTorch", "TestNG"]	마감 기한: D-26	https://jumpit.saramin.co.kr/position/51442	data
1906	FPGA - HW Engineer (대리~과장급)	리브스메드	경기 성남시	경력 5~12년	["FPGA", "MCU", "VHDL"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50318	embedded
1907	악성코드 분석가(대리/과장급) 경력	시큐레터	경기 성남시	경력 2~10년	["Network", "Linux", "Ddos", "IPS", "Firewall"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50450	design
1908	SAP 운영/개발(MM 및 SD모듈)	한국네트웍스	경기 성남시	경력 10~15년	["SAP", "ABAP"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50366	other
1909	임베디드 무선 펌웨어 개발자 모집	미라텍	경기 성남시	경력 5~10년	["Embedded", "C", "C++", "Python"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51326	embedded
1910	PEP팀 ZTNA개발자	지니언스	경기 안양시	경력 10~15년	["C", "C++", "Linux", "VPN", "Linux Mint"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50598	design
1911	3D 모션 생성 AI 엔지니어(6~10년)	아이리브	경기 성남시	경력 6~10년	["PyTorch", "DeepLearning", "Unity"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50179	data
1912	FPGA - HW Engineer (과장~차장급)	리브스메드	경기 성남시	경력 8~17년	["FPGA", "MCU", "VHDL"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50319	embedded
1831	하드웨어 개발자(신입)	캐스트프로	경기 성남시	신입	["HW"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50367	other
1913	평택연구소 SW개발 (경력 7~15년)	인텔리안테크놀로지스	경기 평택시	경력 7~15년	["C", "C++", "Embedded Linux", "JsonAPI"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50968	design
1914	판교연구소 SW개발 (경력 10~12년)	인텔리안테크놀로지스	경기 평택시	경력 10~12년	["C", "C++", "Embedded Linux", "JsonAPI"]	마감 기한: D-19	https://jumpit.saramin.co.kr/position/50970	design
1915	가상화 솔루션 개발자(경력9~11)	쿤텍	경기 성남시	경력 9~11년	["C", "Rust", "Python", "Shell", "NoSql"]	마감 기한: D-20	https://jumpit.saramin.co.kr/position/50922	other
1916	USB Device SDK 개발_3년이상	엑스페릭스	경기 성남시	경력 3~6년	["Windows", "Linux", "C++", "SW", "C#", "Java"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49791	design
1917	SOC/IP Verificiation 엔지니어	잇다반도체	경기 화성시	경력 5~8년	["Python", "XML", "Verilog"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51523	data
1918	3D 모션 생성 AI 엔지니어(3~5년)	아이리브	경기 성남시	경력 3~5년	["PyTorch", "DeepLearning", "Unity"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50178	data
1919	Senior Threat Analyst	에스투더블유	경기 성남시	경력 3~15년	["Git", "MongoDB", "Python", "Docker"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50639	backend
1920	소프트웨어개발 (PL급/13~15년)	쿤텍	경기 성남시	경력 13~15년	["C", "Rust", "Python", "Shell", "NoSql"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50924	other
1921	영상처리,비전(Vision) S/W채용(6~8년)	포우	경기 용인시	경력 6~8년	["SW", "OpenCV", "C++"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50398	other
1922	디지털헬스케어 플랫폼임베디드 개발자	엑소시스템즈	경기 성남시	경력 3~10년	["HW", "FW", "Analog", "Embedded", "RTOS"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51466	embedded
1923	소프트웨어개발 (PL급/10~12년)	쿤텍	경기 성남시	경력 10~12년	["C", "Rust", "Python", "Shell", "NoSql"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50923	other
1924	인공지능(AI) 엔지니어 중급 채용	알비에치	경기 안양시	경력 4~7년	["MachineLearning", "DeepLearning"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50549	data
1925	SAP 운영/개발(CO모듈)	한국네트웍스	경기 성남시	경력 10~20년	["SAP", "ABAP"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50365	other
1926	가상화 솔루션 개발자(경력3~5)	쿤텍	경기 성남시	경력 3~5년	["C", "Rust", "Python", "Shell", "NoSql"]	마감 기한: D-20	https://jumpit.saramin.co.kr/position/50920	other
1927	USB Device SDK 개발_7년이상	엑스페릭스	경기 성남시	경력 7~10년	["Windows", "Linux", "C++", "SW", "C#", "Java"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49792	design
1928	소프트웨어 개발(경력8~10년)	인포그램	경기 화성시	경력 8~10년	["C#", "Java", "MachineLearning"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50588	other
1929	시스템 설계 Manager	서플러스글로벌	경기 용인시	경력 7~20년	["ERP", "Jira", "Java", "MSSQL"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50739	other
1930	소프트웨어 엔지니어(6~8년)	에이딘로보틱스	경기 안양시	경력 6~8년	["Python", "C++", "Linux", "ethernet", "TCP/IP"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50382	design
1931	시스템 개발 Manager	서플러스글로벌	경기 용인시	경력 5~20년	["Java", "REST API", "Spring", "Spring Boot"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50738	backend
1932	솔루션개발 및 구축 경력 채용 공고	아이브릭스	경기 성남시	경력 4~8년	["Elasticsearch", "Node.js", "React", "Java"]	마감 기한: D-day	https://jumpit.saramin.co.kr/position/49806	backend
1933	AI Enterprise Manager	업스테이지	경기 용인시	경력 5~20년	["AI/인공지능"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50531	data
1934	모터센스 솔루션 구축 엔지니어	이파피루스	경기 성남시	경력 7~10년	["Windows", "Linux", "Docker", "VPN"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50895	devops
1935	GUI S/W 설계,개발 채용(10년↑)	에이디티	경기 안산시	경력 10~14년	["Visual C++", "C#", "JavaScript", "Linux"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51402	frontend
1936	GUI S/W 설계,개발 채용(15년↑)	에이디티	경기 안산시	경력 15~20년	["Visual C++", "C#", "JavaScript", "Linux"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51403	frontend
1937	GPON 개발자 경력 채용(11~20년)	가온브로드밴드	경기 성남시	경력 11~20년	["C", "Linux", "C++", "Embedded Linux", "SW"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51575	pm
1938	Senior Data Engineer - LLM	업스테이지	경기 용인시	경력 7~15년	["DeepLearning", "AI/인공지능"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50526	data
1939	GUI S/W 설계,개발 채용(5년↑)	에이디티	경기 안산시	경력 5~9년	["Visual C++", "C#", "JavaScript", "Linux"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51401	frontend
1940	백엔드 개발자 (5년 이상)	씨앤유글로벌	경기 성남시	경력 5~10년	["Java", "Spring", "Oracle", "MariaDB"]	마감 기한: D-27	https://jumpit.saramin.co.kr/position/51461	backend
1941	GPON 개발자 경력 채용(3~10년)	가온브로드밴드	경기 성남시	경력 3~10년	["C", "Linux", "C++", "Embedded Linux", "SW"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51574	pm
1942	F/W개발(MCU) (경력 11~15년)	원익피앤이	경기 수원시	경력 11~15년	["C", "FW", "MCU"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/50994	embedded
1943	WiFi Router개발 경력 6~10년	가온브로드밴드	경기 성남시	경력 6~10년	["C", "Linux", "C++", "Embedded", "Router"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51573	design
1944	IMS & ECS 개발 (경력 10~12년)	원익피앤이	경기 수원시	경력 10~12년	["C#", "WPF"]	마감 기한: D-8	https://jumpit.saramin.co.kr/position/49800	other
1945	기술개발 총괄 및 리딩(8~11년)	WATA Inc.	경기 성남시	경력 8~11년	["RDB", "REST API", "C++", "Java", "AWS"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50948	devops
1946	[제어기개발팀] 임베디드 SW 개발	슈어소프트테크	경기 성남시	경력 5~10년	["C", "MCU", "SW", "Embedded"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51362	embedded
832	모바일앱 플러터 Flutter 개발자	아몬드컴퍼니	서울 강남구	경력 2~5년	["Flutter", "Android", "iOS", "REST API"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/51061	mobile
1947	솔루션개발 및 구축 PL 채용	아이브릭스	경기 성남시	경력 8~15년	["Node.js", "JavaScript", "ELK", "React"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50996	backend
1948	모빌리티 Embedded SW 경력 개발자	아이비스	경기 수원시	경력 3~15년	["Linux", "SW", "C++", "Python", "Embedded"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50803	design
1949	[SDx플랫폼팀] 임베디드 SW 개발	슈어소프트테크	경기 성남시	경력 5~10년	["C", "MCU", "RTOS", "Embedded", "Linux"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51361	design
1951	프론트엔드 개발자	오투플러스	경기 용인시	경력 3~10년	["Git", "REST API", "React", "vuex", "Vue.js"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51224	frontend
1952	소프트웨어 개발(경력5~7년)	인포그램	경기 화성시	경력 5~7년	["C#", "Java", "MachineLearning"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50587	other
1953	빅데이터,서버 백엔드 엔지니어	미리비트	경기 성남시	경력 7~15년	["Kubernetes", "BigData", "Spark"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51555	backend
1954	전장설계엔지니어 채용	EVAR	경기 성남시	경력 5~15년	["HW", "PCB", "FW"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50665	other
1955	[하이닉스] k8s 기반 FDS 과제	미리비트	경기 성남시	경력 5~10년	["Python", "Minio", "Kafka", "Apache Flink"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51556	other
1956	FDS k8s devops	미리비트	경기 성남시	경력 5~15년	["Kubernetes", "BigData"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51557	devops
1957	비전기반 AI 엔지니어(4~6년)	에이딘로보틱스	경기 안양시	경력 4~6년	["Python", "PyTorch", "OpenCV", "Linux"]	마감 기한: D-29	https://jumpit.saramin.co.kr/position/51622	data
1958	비전기반 AI 엔지니어(1~3년)	에이딘로보틱스	경기 안양시	경력 1~3년	["Python", "PyTorch", "OpenCV", "Linux"]	마감 기한: D-29	https://jumpit.saramin.co.kr/position/51621	data
1959	고급 백엔드 설계 개발자(13~15년)	티투엘	경기 고양시	경력 13~15년	["Java"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50172	backend
1960	고급 백엔드 설계 개발자(10~12년)	티투엘	경기 고양시	경력 10~12년	["Java"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50170	backend
1961	인프라(시스템엔지니어) 개발자_11년↑	바텍	경기 화성시	경력 11~20년	["Kubernetes", "GitHub", "Jira", "MongoDB"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/51106	backend
1962	[SW 개발] C++/C# 개발자 경력(5~7년)	파이	경기 수원시	경력 5~7년	["C++", "C#"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50023	other
1963	프론트엔드 개발(7~9년)	블링크큐벡스핀	경기 군포시	경력 7~9년	["JavaScript", "PHP", "Figma", "HTML5"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50565	frontend
1964	Back-end 개발자 추가 모집	오투플러스	경기 용인시	경력 3~10년	["RDB", "MySQL", "RabbitMQ", "PHP"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51223	backend
1965	데이터허브 개발 리더(13~15년)	디토닉	경기 성남시	경력 13~15년	["Java", "Kotlin", "Linux", "Spring Boot"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51482	backend
1966	연구개발 신입/경력직원 채용	인텍에프에이	경기 용인시	신입~10년	["Orcad", "HW", "Pads"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51588	other
1967	프론트엔드 개발(13~15년)	블링크큐벡스핀	경기 군포시	경력 13~15년	["JavaScript", "PHP", "Figma", "HTML5"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50567	frontend
1968	중급 백엔드 개발자 (8~10년)	티투엘	경기 고양시	경력 8~10년	["Java"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50169	backend
1969	Digital HW 개발자	삼지전자	경기 화성시	신입~2년	["HW", "FPGA"]	마감 기한: D-12	https://jumpit.saramin.co.kr/position/50605	other
1970	의료기기 SW 개발자 채용(11년이상)	디노바	경기 군포시	경력 11~15년	["C", "C#", "C++", "SW", "Embedded", "GUI"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50820	design
1971	의료기기 SW 개발자 채용(5년이상)	디노바	경기 군포시	경력 5~10년	["C", "C#", "C++", "SW", "Embedded", "GUI"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50819	design
1972	영상 AI개발자	호각	경기 성남시	경력 2~10년	["Kafka", "MQTT", "DeepLearning", "PyTorch"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51530	data
1973	인프라(시스템엔지니어) 개발자_3~5년	바텍	경기 화성시	경력 3~5년	["Kubernetes", "GitHub", "Jira", "MongoDB"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/51104	backend
1974	SW/임베디드 정규직 채용[신입]	네오티스	경기 안성시	신입	["C", "C++", "HW", "Embedded", "SW"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51458	embedded
1975	고급 백엔드 설계 개발자(16~18년)	티투엘	경기 고양시	경력 16~18년	["Java"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50175	backend
1977	임베디드 소프트웨어 개발자 (Junior)	디엑스솔루션	경기 성남시	신입	["Spring Framework", "AI/인공지능", "C++"]	마감 기한: D-20	https://jumpit.saramin.co.kr/position/51147	backend
1978	프론트엔드 개발자 경력(11~13년) 채용	세계입찰	경기 부천시	경력 11~13년	["HTML5", "C", "C#", "JavaScript", "Node.js"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51520	backend
1979	App(React Native) 개발자(전문연구요원가능)	베스텔라랩	대구 동구, 경기 안양시	경력 2~10년	["Python", "Spring Framework", "AWS"]	마감 기한: D-26	https://jumpit.saramin.co.kr/position/51258	backend
1980	개발자	베스텔라랩	경기 안양시	경력 5~14년	["Python", "Spring Boot", "AWS", "Git", "ROS"]	마감 기한: D-26	https://jumpit.saramin.co.kr/position/51259	backend
1981	데이터분석가 경력(8~10년) 채용	세계입찰	경기 부천시	경력 8~10년	["Python", "SQL", "MySQL"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51503	data
1982	프론트엔드 개발자 경력(5~7년) 채용	세계입찰	경기 부천시	경력 5~7년	["HTML5", "C", "C#", "JavaScript", "Node.js"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51518	backend
1983	SW/임베디드 정규직 채용[경력]	네오티스	경기 안성시	경력 1~10년	["C", "C++", "HW", "Embedded", "SW"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51459	embedded
1984	자동차 전기·전자 분야 개발/엔지니어링 6년↑	모빌리티네트웍스	경기 안양시	경력 6~15년	["HW", "SW", "Embedded", "Jira", "Confluence"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51283	embedded
1985	인프라(시스템엔지니어) 개발자_6~10년	바텍	경기 화성시	경력 6~10년	["Kubernetes", "GitHub", "Jira", "MongoDB"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/51105	backend
1986	제어 컨트롤러 펌웨어 개발자 (3~6년)	유앤아이솔루션	경기 광주시	경력 3~6년	["C", "C++", "ARM", "FPGA", "Embedded"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51202	embedded
1987	데이터허브 개발 리더(7~9년)	디토닉	경기 성남시	경력 7~9년	["Java", "Kotlin", "Linux", "Spring Boot"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51480	backend
1988	데이터분석가 경력(11~13년) 채용	세계입찰	경기 부천시	경력 11~13년	["Python", "SQL", "MySQL"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51507	data
1989	개발PM	오투플러스	경기 용인시	경력 10~15년	["React", "Java", "PHP", "Docker"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51222	frontend
1990	프론트엔드 개발(10~12년)	블링크큐벡스핀	경기 군포시	경력 10~12년	["JavaScript", "PHP", "Figma", "HTML5"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50566	frontend
1991	하드웨어 및 펌웨어 개발자	한솔리드텍	경기 의왕시	경력 6~8년	["C", "C++", "Linux", "Orcad"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50670	design
1992	데이터분석가 경력(5~7년) 채용	세계입찰	경기 부천시	경력 5~7년	["Python", "SQL", "MySQL"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51502	data
1993	프론트엔드 개발자 경력(8~10년) 채용	세계입찰	경기 부천시	경력 8~10년	["HTML5", "C", "C#", "JavaScript", "Node.js"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51519	backend
1994	데이터허브 개발 리더(10~12년)	디토닉	경기 성남시	경력 10~12년	["Java", "Kotlin", "Linux", "Spring Boot"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51481	backend
1995	시니어 백엔드 SW Engineer	제이앤피메디	인천 연수구	경력 8~20년	["TypeScript", "MSA", "MySQL", "Node.js"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/50036	backend
1996	시니어 프론트엔드 SW Engineer	제이앤피메디	인천 연수구	경력 8~20년	["JavaScript", "MSA", "TypeScript", "React"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/50037	frontend
1997	AMS사업부 PM 채용	유진로봇	인천 연수구	경력 10~15년	["Analog", "Embedded"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50271	pm
1998	개발본부C/C++ 엔지니어(Middleware)	유진로봇	인천 연수구	경력 4~15년	["C++", "ROS", "C", "GUI"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50277	design
1999	백엔드(Back-end)개발자(경력 7년이상)	유진로봇	인천 연수구	경력 7~15년	["JavaScript", "Network", "RDB", "NoSql"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50276	backend
2000	SAS사업부 글로벌프로젝트 PM채용	유진로봇	인천 연수구	경력 10~15년	["Google Analytics", "SQL", "Microsoft Excel"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50270	backend
2001	SAS사업부 SW(PLC) 채용	유진로봇	인천 연수구	경력 3~18년	["PLC", "SW"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50275	other
2002	시니어 풀스택 SW Engineer	제이앤피메디	인천 연수구	경력 8~20년	["MSA", "TypeScript", "JSX", "Sass"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/50038	frontend
2003	비젼개발팀 Vision SW Part 경력 채용	크레셈	인천 연수구	경력 2~10년	["SW", "C#", "WPF", "PCB"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50504	other
2004	비젼개발팀 알고리즘 파트 경력 채용	크레셈	인천 연수구	경력 3~10년	["SW", "C#", "WPF", "PCB", "OpenCV"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50505	other
2005	스마트팩토리 로봇관제 S/W 개발자	인아텍앤코포	인천 남동구	경력 1~5년	["MES", "C#", "Java", "MQTT", "REST API"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50483	robotics
2006	스마트팩토리 자율주행로봇 S/W 개발자	인아텍앤코포	인천 남동구	경력 1~5년	["ROS", "C++", "Python", "AI/인공지능", "Linux"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50484	data
2007	RADAR 알고리즘 SW	엠씨넥스	인천 연수구	경력 8~20년	["SW", "C++", "C", "Embedded", "Linux", "MCU"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51305	design
2008	HW 연구소 시스템개발2팀	엠씨넥스	인천 연수구	경력 13~20년	["HW", "PCB", "Verilog", "C", "C++", "FPGA"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51308	other
2009	홈페이지 유지보수 경력(1~3년)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 1~3년	["Java", "JavaScript", "JSP"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/50039	frontend
2010	전산팀 앱개발 경력 채용(8년 이상)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 8~10년	["Java", "Spring Boot", "Linux", "Oracle", "Git"]	마감 기한: D-day	https://jumpit.saramin.co.kr/position/49825	backend
2011	웹개발자 경력(8년이상)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 8~10년	["JavaScript", "Node.js", "React", "Vue.js"]	마감 기한: D-day	https://jumpit.saramin.co.kr/position/49826	backend
2012	시스템 개발/유지보수 신입 채용	엘리펀트키즈에듀테인먼트	인천 계양구	신입	["C#", "MSSQL"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/51040	other
2013	알고리즘 개발자 신입 채용	엘리펀트키즈에듀테인먼트	인천 계양구	신입	["TensorFlow", "Keras", "Slim"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50878	data
2014	홈페이지 유지보수 경력채용	엘리펀트키즈에듀테인먼트	인천 계양구	경력 4~6년	["Java", "JavaScript", "JSP"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51592	frontend
2015	HW/ 전장 설계 경력	세기알앤디	인천 부평구	경력 7~15년	["HW", "RF", "Pads"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50826	other
2016	Beckhoff(백호프) PLC	유진로봇	인천 연수구	경력 3~18년	["PLC", "SW"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50272	other
2017	시스템개발/유지보수(1~3년)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 1~3년	["C#", "MSSQL"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50958	other
2018	프론트엔드 개발자 경력채용(2~4년)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 2~4년	["JavaScript", "Next.js", "TypeScript", "Git"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51589	frontend
2019	알고리즘 개발자 경력 채용(3~5년)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 3~5년	["TensorFlow", "Keras", "Slim"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50879	data
2020	SAS사업부 글로벌프로젝트 SW(PLC)채용	유진로봇	인천 연수구	경력 3~18년	["PLC", "SW"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50274	other
2021	알고리즘 개발자 경력 채용(6~8년)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 6~8년	["TensorFlow", "Keras", "Slim"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50880	data
2022	프론트엔드 개발자 경력채용(8~10년)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 8~10년	["JavaScript", "Next.js", "TypeScript", "Git"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51591	frontend
2023	프론트엔드 개발 경력(5~7년)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 5~7년	["JavaScript", "Next.js", "TypeScript", "Git"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51590	frontend
2024	AMS사업부 ACS 개발자 채용	유진로봇	인천 연수구	경력 5~12년	["C#", "Java", "JavaScript", "PLC", "Git", "MES"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50273	frontend
2025	시스템개발/유지보수(4~6년)	엘리펀트키즈에듀테인먼트	인천 계양구	경력 4~6년	["C#", "MSSQL"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/51041	other
2026	HW/RF 설계 경력 (7년~15년)	세기알앤디	인천 부평구	경력 7~15년	["HW", "RF"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50827	other
2027	RADAR 시험장비 SW	엠씨넥스	인천 연수구	경력 3~10년	["SW", "C++", "C", "Embedded", "Linux", "MCU"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51307	design
2028	차량용 RADAR HW	엠씨넥스	인천 연수구	경력 3~12년	["HW", "PCB", "Verilog", "C", "C++", "FPGA"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51311	other
2029	임베디드 개발자 채용 (신입)	넥스트테크	인천 연수구	신입~2년	["Arduino", "Embedded", "GNU Bash", "C"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50869	design
2030	RADAR 신호처리 SW	엠씨넥스	인천 연수구	경력 5~20년	["SW", "C++", "C", "Embedded", "Linux", "MCU"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51306	design
2031	RF HW	엠씨넥스	인천 연수구	경력 5~12년	["HW", "PCB", "Verilog", "C", "C++", "FPGA"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51309	other
2032	RADAR RF HW	엠씨넥스	인천 연수구	경력 5~12년	["HW", "PCB", "Verilog", "C", "C++", "FPGA"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51310	other
2033	임베디드 개발자 채용 (경력)	넥스트테크	인천 연수구	경력 3~10년	["Arduino", "Embedded", "GNU Bash", "C"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50868	design
2034	인공지능 SW개발 (5~7)	바이트사이즈	부산 부산진구	경력 5~10년	["Python", "NLP", "Git", "Airflow", "Java"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/49896	data
2035	Fullstack 개발 (5년이상)	바이트사이즈	부산 부산진구	경력 5~9년	["Python", "JavaScript", "MySQL", "PyTorch"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/49895	frontend
2036	AI(인공지능) 개발 및 데이터 분석 연구자	마린웍스	부산 동구	경력 1~3년	["Python", "C#", "DeepLearning", "BigData"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51216	data
2037	택스아이 개발팀리더 (부산)	뉴아이	부산 남구	경력 4~15년	["HTML5", "CSS 3", "Java", "JavaScript"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51293	frontend
2038	프론트엔드 개발자 (Next JS)_부산	뉴아이	부산 남구	경력 3~15년	["HTML5", "CSS 3", "Java", "JavaScript"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51296	frontend
2039	Tech - Software Engineer	벙커키즈	부산 금정구	경력 1~10년	["Python", "Redis", "PyTorch", "TensorFlow"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/51129	data
2040	Tech - Frontend Engineer	벙커키즈	부산 금정구	경력 3~10년	["JavaScript", "TypeScript", "Emotion"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/51128	frontend
2041	[제로아이즈]개발팀 Lead_경력10~12년	오래	부산 해운대구	경력 10~12년	["Vue.js", "TypeScript", "Node.js", "ExpressJS"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50043	backend
2042	[제로아이즈] PM/기획 매니저	오래	부산 해운대구	경력 7~10년	["AWS", "Swagger UI", "MySQL", "Node.js"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50045	backend
2074	[AI Agent 구축] AI 개발자	아파트너스	광주 동구	경력 1~5년	["Python", "AI/인공지능", "Embedded"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/51084	data
2043	[제로아이즈]개발팀 Lead_경력13~15년	오래	부산 해운대구	경력 13~15년	["Vue.js", "TypeScript", "Node.js", "ExpressJS"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50044	backend
2044	[제로아이즈]개발팀 Lead_경력3~9년	오래	부산 해운대구	경력 3~7년	["Vue.js", "TypeScript", "Node.js", "ExpressJS"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50042	backend
2045	AI 개발 및 데이터 분석 연구자(1-3년)	마린웍스	부산 동구	경력 1~3년	["Python", "C#", "DeepLearning", "BigData"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51526	data
2046	백앤드 개발 리더 [5~7년]	론픽	부산 해운대구	경력 5~7년	["Python", "Django", "PostgreSQL", "Docker"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51513	backend
2047	AI 개발 및 데이터 분석 연구자(3년이상)	마린웍스	부산 동구	경력 3~5년	["Python", "C#", "DeepLearning", "BigData"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51527	data
2048	백앤드 개발 리더 [11년 이상]	론픽	부산 해운대구	경력 11~20년	["Python", "Django", "PostgreSQL", "Docker"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51515	backend
2050	백앤드 개발 리더 [8~10년]	론픽	부산 해운대구	경력 8~10년	["Python", "Django", "PostgreSQL", "Docker"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51514	backend
2051	소프트웨어 엔지니어 (경력 / 대구 근무)	에이스웍스코리아	대구 수성구	경력 3~12년	["labview", "C++", "C#", "Python", "C"]	마감 기한: D-14	https://jumpit.saramin.co.kr/position/50699	other
2052	Verification Engineer/대구	아이디어스투실리콘	대구 북구	경력 3~15년	["Verilog", "ASIC", "Perl", "TCP/IP", "FPGA"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/49887	other
2053	Digital Logic 개발/대구	아이디어스투실리콘	대구 북구	경력 3~15년	["Verilog", "C", "C++", "C#", "Python", "VHDL"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/49884	other
2054	응용 프로그래머	제이브이엠	대구 달서구	경력 3~8년	["C#", "Microsoft SQL Server", "WPF", "WCF"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50860	robotics
2055	인프라서비스팀_백엔드개발(주임)	리만코리아	대구 수성구	경력 3~6년	["Java", "Spring Framework", "Spring Boot"]	마감 기한: D-26	https://jumpit.saramin.co.kr/position/51184	backend
2056	응용 프로그래머(인공지능)	제이브이엠	대구 달서구	경력 3~8년	["C#", "Microsoft SQL Server", "Python"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50862	robotics
2057	인프라서비스팀_백엔드개발(과장)	리만코리아	대구 수성구	경력 10~12년	["Java", "Spring Framework", "Spring Boot"]	마감 기한: D-26	https://jumpit.saramin.co.kr/position/51186	backend
2058	인프라서비스팀_백엔드개발(대리)	리만코리아	대구 수성구	경력 7~9년	["Java", "Spring Framework", "Spring Boot"]	마감 기한: D-26	https://jumpit.saramin.co.kr/position/51185	backend
2059	[대구] RTL 설계엔지니어(경력 4~16년)	칩스앤미디어	대구 동구	경력 4~16년	["Verilog", "C", "C++", "Python", "Linux", "HW"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50076	design
2060	응용 프로그래머(로봇제어)	제이브이엠	대구 달서구	경력 3~8년	["C#", "Microsoft SQL Server", "Python"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50861	robotics
2061	펌웨어/플랫폼 개발(경력16~20년)	아세아텍	대구 달성군	경력 16~20년	["FW", "C", "HW"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50405	embedded
2062	전기,전자 소프트웨어 설계(1년~4년)	설텍	대구 달서구	경력 1~4년	["C", "C++", "SW", "MCU", "RTOS", "FPGA"]	마감 기한: D-7	https://jumpit.saramin.co.kr/position/50093	embedded
2063	전기,전자 하드웨어 설계(10년~14년)	설텍	대구 달서구	경력 10~12년	["HW", "Embedded Linux", "MCU", "SW"]	마감 기한: D-7	https://jumpit.saramin.co.kr/position/50092	design
2064	펌웨어/플랫폼 개발(경력10~15년)	아세아텍	대구 달성군	경력 10~15년	["FW", "C", "HW"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50404	embedded
2065	전력전자 H/W 개발(1년~4년)	설텍	대구 달서구	경력 1~4년	["HW", "Orcad"]	마감 기한: D-7	https://jumpit.saramin.co.kr/position/50086	other
2066	전기,전자 소프트웨어 설계(5년~9년)	설텍	대구 달서구	경력 5~9년	["C", "C++", "SW", "MCU", "RTOS", "FPGA"]	마감 기한: D-7	https://jumpit.saramin.co.kr/position/50094	embedded
2067	펌웨어/플랫폼 개발(경력3~9년)	아세아텍	대구 달성군	경력 3~9년	["FW", "C", "HW"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50403	embedded
2068	전기,전자 하드웨어 설계(5년~9년)	설텍	대구 달서구	경력 5~9년	["HW", "Embedded Linux", "MCU", "SW"]	마감 기한: D-7	https://jumpit.saramin.co.kr/position/50091	design
2069	전기,전자 하드웨어 설계(1년~4년)	설텍	대구 달서구	경력 1~4년	["HW", "Embedded Linux", "MCU", "SW"]	마감 기한: D-7	https://jumpit.saramin.co.kr/position/50090	design
2070	전기,전자 소프트웨어 설계(10~14)	설텍	대구 달서구	경력 10~14년	["C", "C++", "SW", "FPGA"]	마감 기한: D-7	https://jumpit.saramin.co.kr/position/50097	other
2071	전력전자 H/W 개발(5년~9년)	설텍	대구 달서구	경력 3~9년	["HW", "Orcad"]	마감 기한: D-7	https://jumpit.saramin.co.kr/position/50087	other
2072	전력전자 H/W 개발(10년~14년)	설텍	대구 달서구	경력 10~14년	["HW", "Orcad"]	마감 기한: D-7	https://jumpit.saramin.co.kr/position/50089	other
2075	DevOps 엔지니어 (11년 ~ 15년)	데이터메이커	대전 유성구	경력 11~15년	["Terraform", "Pulumi", "GoLand", "Argo"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49958	backend
2076	ML Engineer (8년 ~ 12년)	데이터메이커	대전 유성구	경력 8~12년	["Git", "Ubuntu", "NLP", "Kubeflow"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49955	data
2077	기업부설연구소 전문연구요원(병역특례)	알지티	대전 중구	신입	["Python", "AWS WAF", "Git", "Java"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50882	devops
2111	FW개발 경력 채용	인엘씨테크놀러지	대전 유성구	경력 3~15년	["HW", "FW", "C", "MCU", "MATLAB", "FPGA"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50343	embedded
2078	서버 및 인프라 개발자 (16년 ~ 20년)	데이터메이커	대전 유성구	경력 16~20년	["Terraform", "Pulumi", "Golang", "Argo"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49965	backend
2079	백엔드 개발자 (16년 ~ 20년)	데이터메이커	대전 유성구	경력 16~20년	["Django", "Django REST framework"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49962	backend
2080	프론트엔드 개발자 (11년 ~ 15년)	데이터메이커	대전 유성구	경력 11~15년	["JavaScript", "ES6", "Rust", "three.js"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49970	frontend
2081	프론트엔드 개발자 (16년 ~ 20년)	데이터메이커	대전 유성구	경력 16~20년	["JavaScript", "ES6", "Rust", "three.js"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49971	frontend
2082	ML Engineer (13년 이상)	데이터메이커	대전 유성구	경력 13~15년	["Git", "Ubuntu", "NLP", "Kubeflow"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49956	data
2083	웹 그래픽(F/E) 개발자 (16년 ~ 20년)	데이터메이커	대전 유성구	경력 16~20년	["JavaScript", "Babel", "React", "REST API"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49968	frontend
2084	백엔드 개발자 (11년 ~ 15년)	데이터메이커	대전 유성구	경력 11~15년	["Django", "Django REST framework"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49961	backend
2085	ML Engineer (3년 ~ 7년)	데이터메이커	대전 유성구	경력 3~7년	["Git", "Ubuntu", "NLP", "Kubeflow"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49954	data
2086	웹 그래픽(F/E) 개발자 (5년 ~ 10년)	데이터메이커	대전 유성구	경력 5~10년	["JavaScript", "Babel", "React", "REST API"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49966	frontend
2087	웹 그래픽(F/E) 개발자 (11년 ~ 15년)	데이터메이커	대전 유성구	경력 11~15년	["JavaScript", "Babel", "React", "REST API"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49967	frontend
2088	백엔드 개발자 (5년 ~ 10년)	데이터메이커	대전 유성구	경력 5~10년	["Django", "Django REST framework"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49960	backend
2089	Data 엔지니어 - Junior (대전 근무)	시스트란	대전 서구	신입	["Python", "TensorFlow", "PyTorch", "NLP"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/50006	data
2090	Optical Engineer / Senior 채용	토모큐브	대전 유성구	경력 2~5년	["MATLAB", "CUDA", "3D Rendering"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50781	other
2091	2차전지 검사기 개발자 (신입 또는 경력1~4년)	아이비젼웍스	대전 유성구	신입~4년	["OpenCV", "C++", "Mfc"]	마감 기한: D-8	https://jumpit.saramin.co.kr/position/50224	other
2092	이미지 생성AI 전문 AI/DL 엔지니어	커넥트브릭	대전 유성구	경력 2~15년	["Python", "DeepLearning", "AI/인공지능"]	마감 기한: D-18	https://jumpit.saramin.co.kr/position/50926	data
2093	프론트엔드 개발자 (5년 ~ 10년)	데이터메이커	대전 유성구	경력 5~10년	["JavaScript", "ES6", "Rust", "three.js"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49969	frontend
2094	S/W 개발(1~5년)	블루텍	대전 유성구	경력 1~5년	["SW", "C", "C++", "C#", "Linux"]	마감 기한: D-7	https://jumpit.saramin.co.kr/position/50205	design
2095	하드웨어(H/W) 개발자 채용	블루텍	대전 유성구	신입~15년	["SW", "HW", "C", "Embedded Linux", "Linux"]	마감 기한: D-7	https://jumpit.saramin.co.kr/position/50207	design
2096	S/W 개발(6~10년)	블루텍	대전 유성구	경력 6~10년	["SW", "C", "C++", "C#", "Linux"]	마감 기한: D-7	https://jumpit.saramin.co.kr/position/50206	design
2097	[대전서구] 공공 SI 제안서 PM 모집 (경력 13년~16년)	에스넷아이씨티	대전 서구	경력 13~16년	["Cisco", "Network", "Ccna", "Ccnp"]	마감 기한: D-29	https://jumpit.saramin.co.kr/position/51478	pm
2098	AI/ML 엔지니어 경력 채용	액스비스	대전 유성구	경력 3~15년	["Python", "JavaScript", "Django"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50808	backend
2099	장비 제어 소프트웨어 엔지니어	액스비스	대전 유성구	경력 2~15년	["C#", "C", "C++", "GUI", "SW", "Mfc", "Java"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50800	design
2100	SW 기반 머신 비전 개발자 채용	액스비스	대전 유성구	경력 3~15년	["C", "C++", "SW", "Mfc", "OpenCV", "HALCON"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50806	other
2101	레이저 공정 제어 소프트웨어 개발자	액스비스	대전 유성구	경력 3~15년	["C", "C++", "SW", "InSpec", ".NET", "C#"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50804	robotics
2102	소프트웨어 개발 엔지니어 채용	이서	대전 유성구	경력 2~5년	["C", "C++", "Python", "MachineLearning"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50945	other
2103	자동화 소프트웨어 엔지니어 채용	액스비스	대전 유성구	경력 4~15년	["Qt", "C#", "C", "C++", "Mfc", "Git", ".NET"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50799	other
2104	FPGA & DSP 펌웨어 개발 엔지니어	액스비스	대전 유성구	경력 2~15년	["VHDL", "FPGA", "Verilog"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50801	embedded
2105	SW/솔루션 정규직 채용(신입)	와이파워원	대전 유성구	신입	["C", "C++", "Embedded", "MCU", "FW"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50564	embedded
2106	Technical Support 엔지니어 주니어 채용(대전)	시스트란	대전 서구	경력 1~2년	["AI/인공지능", "Python", "Linux", "Docker"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51464	devops
2107	SW/솔루션 정규직 채용(경력)	와이파워원	대전 유성구	경력 1~10년	["C", "C++", "Embedded", "MCU", "FW"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50563	embedded
2108	하드웨어 엔지니어 경력(7~10)	토모큐브	대전 유성구	경력 7~10년	["Git", "MATLAB", "Python", "C++", "VHDL"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50780	other
2109	DevOps 엔지니어	시스트란	대전 서구	경력 3~10년	["Python", "TensorFlow", "PyTorch", "NLP"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51465	devops
2110	FPGA 시니어급 채용	인엘씨테크놀러지	대전 유성구	경력 10~20년	["FPGA", "Verilog"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50344	other
2120	DevOps 엔지니어 (16년 ~ 20년)	데이터메이커	대전 유성구	경력 16~20년	["Terraform", "Pulumi", "GoLand", "Argo"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49959	backend
2121	2차전지 검사기 개발자 (경력5~7년)	아이비젼웍스	대전 유성구	경력 5~7년	["OpenCV", "C++", "Mfc"]	마감 기한: D-8	https://jumpit.saramin.co.kr/position/50225	other
2122	C/C++ 이동통신 코어 백엔드 개발자	두두원	대전 유성구	경력 3~8년	["C", "C++", "Network", "Linux", "Ubuntu"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50509	backend
2123	5G/6G 코어망 소프트웨어 개발자	두두원	대전 유성구	경력 3~8년	["C", "C++", "Linux", "TCP/IP", "Socket.IO"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50510	design
2124	서버 및 인프라 개발자 (11년 ~ 15년)	데이터메이커	대전 유성구	경력 11~15년	["Terraform", "Pulumi", "Golang", "Argo"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49964	backend
2125	2차전지 검사기 개발자 (경력8~10년)	아이비젼웍스	대전 유성구	경력 8~10년	["OpenCV", "C++", "Mfc"]	마감 기한: D-8	https://jumpit.saramin.co.kr/position/50226	other
2126	네트워크 장비 구축 엔지니어 채용	유씨아이	대전 서구	신입~15년	["Ccna", "Cisco", "Network", "Ccie", "TCP/IP"]	마감 기한: D-1	https://jumpit.saramin.co.kr/position/49883	other
2127	의료기기 S/W 개발자(대전, 경력 7~10년)	프리시젼바이오	대전 유성구	경력 7~10년	["C", "C++", "Mfc", "Qt", "Embedded Linux"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51497	design
2128	[대전 서구] 네트워크/보안 엔지니어 채용	에스넷아이씨티	대전 서구	경력 5~12년	["Cisco", "Network", "Ccna", "Ccnp"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50067	security
2129	의료기기 S/W 개발자(대전, 경력 3~6년)	프리시젼바이오	대전 유성구	경력 3~6년	["C", "C++", "Mfc", "Qt", "Embedded Linux"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51496	design
2130	자율점검 드론/로봇 개발자(석사이상)	시에라베이스	울산 남구	신입	["C++", "Visual C++", "C++ Builder", "Python"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51248	design
2131	자율 점검드론/로봇 개발자 모집(1~3)	시에라베이스	울산 남구	경력 1~3년	["C++", "Visual C++", "C++ Builder", "Python"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51249	design
2132	[경력] 백엔드 개발자 (울산, 3년↑)	엔엑스	울산 울주군	경력 3~6년	["Node.js", "MongoDB", "AWS", "Docker"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51391	backend
2133	자율 점검드론/로봇 개발자 모집(4~6)	시에라베이스	울산 남구	경력 4~6년	["C++", "Visual C++", "C++ Builder", "Python"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51250	design
2134	자율 점검드론/로봇 개발자 모집(7~10)	시에라베이스	울산 남구	경력 7~10년	["C++", "Visual C++", "C++ Builder", "Python"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51251	design
2135	[경력] 백엔드 개발자 (울산, 7년↑)	엔엑스	울산 울주군	경력 7~10년	["Node.js", "MongoDB", "AWS", "Docker"]	마감 기한: D-29	https://jumpit.saramin.co.kr/position/51620	backend
2139	SW 개발 PM(Project Manager) 주임급	팜클	강원 횡성군	경력 2~4년	["Python", "AWS", "Git", "iOS", "Linux"]	마감 기한: D-24	https://jumpit.saramin.co.kr/position/51413	mobile
2140	CTO 신규채용	비지트	강원 원주시	경력 4~10년	["OpenCV", "TensorFlow", "TensorFlow.js"]	마감 기한: D-day	https://jumpit.saramin.co.kr/position/49814	data
2142	소프트웨어개발자 경력자 채용	라온솔루션	충북 청주시	경력 2~5년	["C", "C++", "C#", "Windows", "SW"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50342	other
2144	선행개발 경력 (3~5년)	제이티	충남 천안시	경력 3~5년	["HW", "FW", "MCU", "FPGA", "Linux", "C", "C++"]	마감 기한: D-7	https://jumpit.saramin.co.kr/position/50163	design
2145	선행개발 경력 (6~10년)	제이티	충남 천안시	경력 6~10년	["HW", "FW", "MCU", "FPGA", "Linux", "C", "C++"]	마감 기한: D-7	https://jumpit.saramin.co.kr/position/50164	design
2146	웹(Back-End) 개발자 채용 (근무지/전주)	아이엠아이	전북 전주시	경력 2~5년	["PHP", "MySQL", "REST API", "Git", "Jira"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49909	backend
2147	자율주행로봇 백엔드 엔지니어 (포항)	폴라리스쓰리디	경북 포항시	경력 5~8년	["Java", "Spring Boot", "REST API", "MySQL"]	마감 기한: D-23	https://jumpit.saramin.co.kr/position/51291	backend
2148	이리온 비전 기반 인지 모델 개발자	폴라리스쓰리디	경북 포항시	경력 2~3년	["DeepLearning", "PyTorch", "TensorFlow"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50662	data
2149	제조 자동화 로봇 DevOps 엔지니어	폴라리스쓰리디	경북 포항시	경력 3~8년	["Flutter"]	마감 기한: D-5	https://jumpit.saramin.co.kr/position/50232	mobile
2150	이리온 로봇 자율주행 SW 개발(포항)	폴라리스쓰리디	경북 포항시	경력 2~7년	["SW", "C++", "Linux", "Git", "Notion"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50233	design
2151	풀스택 고급 개발자	미조리장갑	경북 칠곡군	경력 8~10년	["Linux", "React Router", "SW", "Embedded"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/51003	frontend
2152	풀스택 신입 개발자	미조리장갑	경북 칠곡군	신입	["Linux", "React Router", "SW", "Embedded"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/51004	frontend
2153	S/W 신입 개발자	미조리장갑	경북 칠곡군	신입	["Linux", "React Router", "SW", "Embedded"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51231	frontend
2154	풀스택 중급 개발자	미조리장갑	경북 칠곡군	경력 5~7년	["Linux", "React Router", "SW", "Embedded"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/51002	frontend
2155	S/W 중급 개발자	미조리장갑	경북 칠곡군	경력 5~7년	["Linux", "React Router", "SW", "Embedded"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51227	frontend
2156	S/W 고급 개발자	미조리장갑	경북 칠곡군	경력 8~10년	["Linux", "React Router", "SW", "Embedded"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51230	frontend
2157	풀스택 초급 개발자	미조리장갑	경북 칠곡군	경력 2~4년	["Linux", "React Router", "SW", "Embedded"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/51001	frontend
2158	S/W 초급 개발자	미조리장갑	경북 칠곡군	경력 2~4년	["Linux", "React Router", "SW", "Embedded"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51226	frontend
2159	시스템운영/테스트및관리(신입)	씨맥스	경남 창원시	신입	["Oracle", "Python", "AI/인공지능"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51443	data
2160	Web Java Oracle개발(1~3년)	씨맥스	경남 창원시	경력 1~3년	["REST API", "WebGL", "WebRTC", "Spring"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50412	backend
2161	PLM 시스템 운영/유지보수	이즈파크	경남 사천시	경력 5~15년	["Java", "Oracle", "MSSQL"]	마감 기한: 상시	https://jumpit.saramin.co.kr/position/21804	other
2162	시스템 엔지니어 채용_신입	가야데이터	경남 진주시	신입	["Windows Server", "VMware vSphere"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51164	other
838	Android 개발자	넥써쓰	서울 강남구	경력 2~10년	["Android", "React Native", "Blockchain"]	마감 기한: D-2	https://jumpit.saramin.co.kr/position/50005	frontend
933	[TADA]Android Engineer(Intermediate)	이지식스(엠블)	서울 강남구	경력 5~15년	["Kotlin", "Android", "RxJava", "Gradle"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50338	mobile
953	[삼성계열사]임베디드(리눅스) S/W개발	씨브이네트	서울 송파구	경력 5~20년	["Qt", "ARM", "Linux", "Android"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50864	mobile
962	[플레이오] 안드로이드 개발자 (2년 이상)	지엔에이컴퍼니	서울 서초구	경력 2~5년	["Android", "Kotlin", "REST API"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51210	mobile
965	플러터 프론트 APP 개발[경력]	패션앤스타일컴퍼니	서울 종로구	경력 2~10년	["Flutter", "iOS", "Android", "GitHub", "Git"]	마감 기한: D-9	https://jumpit.saramin.co.kr/position/50282	mobile
998	Flutter 개발자	코보시스	서울 송파구	경력 3~10년	["Flutter", "Android", "iOS", "Dart", "Git"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49933	mobile
1114	앱 기획/UX (Product Owner)	아이센스(caresens)	서울 서초구	경력 8~16년	["iOS", "Android", "Figma", "Zeplin"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50915	mobile
1136	풀스택 고급 개발자	지피에이코리아	서울 강남구	경력 7~10년	["Android", "iOS", "Java", "Kotlin", "Swift"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50857	fullstack
1138	풀스택 중급 개발자	지피에이코리아	서울 강남구	경력 3~6년	["Android", "iOS", "Java", "Kotlin", "Swift"]	마감 기한: D-15	https://jumpit.saramin.co.kr/position/50856	fullstack
1213	안드로이드 앱개발 경력직 채용	에프엘이에스	서울 강서구	경력 2~5년	["Android", "Java", "Kotlin"]	마감 기한: D-day	https://jumpit.saramin.co.kr/position/49433	mobile
1850	Mobile(Flutter) developer	유비퍼스트대원	경기 성남시	경력 3~10년	["React Native", "Android", "iOS", "Flutter"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51199	frontend
1855	앱 개발자 (중급)	알비에치	경기 안양시	경력 5~7년	["Flutter", "Android", "iOS", "REST API"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50997	mobile
1863	디지털헬스케어 플랫폼 SW개발자	엑소시스템즈	경기 성남시	경력 3~7년	["Kotlin", "Android", "SW", "AWS"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51467	mobile
1872	앱 개발자 (초급)	알비에치	경기 안양시	경력 2~4년	["Flutter", "Android", "iOS", "REST API"]	마감 기한: D-17	https://jumpit.saramin.co.kr/position/50999	mobile
1884	모바일(안드로이드/iOS) 애플리케이션 개발	모빌리티네트웍스	경기 안양시	경력 10~20년	["Android", "iOS", "Kotlin", "PHP-MVC"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51286	mobile
1896	Android Frameworks/Application 개발	엠핀스	경기 안양시	경력 7~20년	["Android", "Java", "Kotlin", "C++", "C"]	마감 기한: D-10	https://jumpit.saramin.co.kr/position/50387	mobile
2141	Touch Key/Sensor MCU 응용엔지니어	어보브반도체	충북 청주시	경력 3~6년	["C", "C++", "R", "Android", "MCU"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51318	mobile
2049	로봇 시스템 개발 엔지니어	론픽	부산 해운대구	경력 3~5년	["MCU"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51516	embedded
2143	MCU 응용개발 및 FAE	어보브반도체	충북 청주시	경력 3~6년	["C", "C++", "R", "Android", "MCU"]	마감 기한: D-22	https://jumpit.saramin.co.kr/position/51319	mobile
2112	Full stack(풀스택) 개발자 모집[9년 이상]	알지티	대전 중구	경력 9~15년	["JavaScript", "Python", "TypeScript"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51585	frontend
2113	하드웨어 엔지니어 경력(4~6)	토모큐브	대전 유성구	경력 4~6년	["Git", "MATLAB", "Python", "C++", "VHDL"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50779	other
2114	자율주행 H/W엔지니어[8~10년]	알지티	대전 중구	경력 8~10년	["C", "C++", "Python", "Orcad", "FW"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51584	other
2115	하드웨어 엔지니어 경력(1~3)	토모큐브	대전 유성구	경력 1~3년	["Git", "MATLAB", "Python", "C++", "VHDL"]	마감 기한: D-16	https://jumpit.saramin.co.kr/position/50778	other
2116	자율주행 F/W엔지니어	알지티	대전 중구	경력 4~7년	["C", "C++", "Python", "Orcad", "FW"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51586	other
2117	자율주행 H/W엔지니어[5~7년]	알지티	대전 중구	경력 5~7년	["C", "C++", "Python", "Orcad", "FW"]	마감 기한: D-28	https://jumpit.saramin.co.kr/position/51583	other
2118	서버 및 인프라 개발자 (5년 ~ 10년)	데이터메이커	대전 유성구	경력 5~10년	["Terraform", "Pulumi", "Golang", "Argo"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49963	backend
2119	DevOps 엔지니어 (5년 ~ 10년)	데이터메이커	대전 유성구	경력 5~10년	["Terraform", "Pulumi", "GoLand", "Argo"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/49957	backend
2137	전자제어 S/W 경력 개발자 모집	코아비스	세종	경력 1~10년	["FW", "Embedded", "C"]	마감 기한: D-6	https://jumpit.saramin.co.kr/position/50182	embedded
1053	AI 시니어 개발자	룰루랩	서울 강남구	경력 10~20년	["Python", "PyTorch"]	마감 기한: D-4	https://jumpit.saramin.co.kr/position/50197	data
2163	시스템 엔지니어 채용_1~3년	가야데이터	경남 진주시	경력 1~3년	["Windows Server", "VMware vSphere"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51162	other
2164	시스템 엔지니어 채용_4년이상	가야데이터	경남 진주시	경력 4~7년	["Windows Server", "VMware vSphere"]	마감 기한: D-21	https://jumpit.saramin.co.kr/position/51163	other
2165	Web Java Oracle개발(4~6년)	씨맥스	경남 창원시	경력 4~6년	["REST API", "WebGL", "WebRTC", "Spring"]	마감 기한: D-11	https://jumpit.saramin.co.kr/position/50410	backend
2166	시스템운영/테스트및관리(경력6년)	씨맥스	경남 창원시	경력 4~6년	["Oracle", "Python", "AI/인공지능"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51445	data
2167	시스템운영/테스트및관리(경력3년)	씨맥스	경남 창원시	경력 1~3년	["Oracle", "Python", "AI/인공지능"]	마감 기한: D-25	https://jumpit.saramin.co.kr/position/51444	data
2168	Spring기반 유지보수/개발(경력4~6)	씨맥스	경남 창원시	경력 4~6년	["Python", "Java", "REST API", "Spring", "JSP"]	마감 기한: D-29	https://jumpit.saramin.co.kr/position/51609	backend
2169	Spring기반 유지보수/개발	씨맥스	경남 창원시	경력 1~3년	["Python", "Java", "REST API", "Spring", "JSP"]	마감 기한: D-29	https://jumpit.saramin.co.kr/position/51608	backend
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

SELECT pg_catalog.setval('public.jumpit_jobs_id_seq', 2169, true);


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

