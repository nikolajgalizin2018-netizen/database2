--
-- PostgreSQL database dump
--

\restrict UWTubxrZXXSYOInCZj5PUcfzQ6nL6gk5gDsPt9DyW48Qrcd7FEsmncUNGpAbLzS

-- Dumped from database version 18.6 (Debian 18.6-1.pgdg13+2)
-- Dumped by pg_dump version 18.6 (Debian 18.6-1.pgdg13+2)

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
-- Name: branch; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.branch (
    branch_id integer NOT NULL,
    address character varying(300) NOT NULL
);


ALTER TABLE public.branch OWNER TO postgres;

--
-- Name: branch_branch_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.branch_branch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.branch_branch_id_seq OWNER TO postgres;

--
-- Name: branch_branch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.branch_branch_id_seq OWNED BY public.branch.branch_id;


--
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    department_id integer NOT NULL,
    name character varying(200) NOT NULL,
    type_id integer NOT NULL
);


ALTER TABLE public.department OWNER TO postgres;

--
-- Name: department_department_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.department_department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.department_department_id_seq OWNER TO postgres;

--
-- Name: department_department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.department_department_id_seq OWNED BY public.department.department_id;


--
-- Name: department_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department_type (
    type_id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.department_type OWNER TO postgres;

--
-- Name: department_type_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.department_type_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.department_type_type_id_seq OWNER TO postgres;

--
-- Name: department_type_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.department_type_type_id_seq OWNED BY public.department_type.type_id;


--
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    employee_id integer NOT NULL,
    full_name character varying(200) NOT NULL,
    salary numeric(12,2) NOT NULL,
    hire_date date NOT NULL,
    position_id integer NOT NULL,
    department_id integer NOT NULL,
    branch_id integer NOT NULL,
    CONSTRAINT employee_salary_check CHECK ((salary > (0)::numeric))
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- Name: employee_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employee_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employee_employee_id_seq OWNER TO postgres;

--
-- Name: employee_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employee_employee_id_seq OWNED BY public.employee.employee_id;


--
-- Name: employee_project; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee_project (
    employee_id integer NOT NULL,
    project_id integer NOT NULL
);


ALTER TABLE public.employee_project OWNER TO postgres;

--
-- Name: position; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."position" (
    position_id integer NOT NULL,
    title character varying(200) NOT NULL
);


ALTER TABLE public."position" OWNER TO postgres;

--
-- Name: position_position_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.position_position_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.position_position_id_seq OWNER TO postgres;

--
-- Name: position_position_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.position_position_id_seq OWNED BY public."position".position_id;


--
-- Name: project; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project (
    project_id integer NOT NULL,
    name character varying(300) NOT NULL
);


ALTER TABLE public.project OWNER TO postgres;

--
-- Name: project_project_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.project_project_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_project_id_seq OWNER TO postgres;

--
-- Name: project_project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.project_project_id_seq OWNED BY public.project.project_id;


--
-- Name: branch branch_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branch ALTER COLUMN branch_id SET DEFAULT nextval('public.branch_branch_id_seq'::regclass);


--
-- Name: department department_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department ALTER COLUMN department_id SET DEFAULT nextval('public.department_department_id_seq'::regclass);


--
-- Name: department_type type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department_type ALTER COLUMN type_id SET DEFAULT nextval('public.department_type_type_id_seq'::regclass);


--
-- Name: employee employee_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee ALTER COLUMN employee_id SET DEFAULT nextval('public.employee_employee_id_seq'::regclass);


--
-- Name: position position_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."position" ALTER COLUMN position_id SET DEFAULT nextval('public.position_position_id_seq'::regclass);


--
-- Name: project project_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project ALTER COLUMN project_id SET DEFAULT nextval('public.project_project_id_seq'::regclass);


--
-- Data for Name: branch; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.branch (branch_id, address) FROM stdin;
1	Приморский край, г. Владивосток, ул Нижнепортовая, д. 1
2	Краснодарский край, г. Краснодар, ул Путевая, д. 1
3	Ростовская обл, г. Ростов-на-Дону, ул 2-я Краснодарская, д. 135/2
\.


--
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.department (department_id, name, type_id) FROM stdin;
1	Центр компетенций QA Москва	1
2	Группа сервисной поддержки	2
3	Центр разработки продуктов для digital-маркетинга	1
4	Департамент Техническая поддержка	3
5	Группа CRM 2	2
6	Центр управления сервисами	1
7	Департамент FBF	3
8	Группа первичной диагностики №2	2
9	Группа Billing	2
10	Группа DOC	2
11	Группа ODS	2
12	Группа Rating	2
13	Центр анализа и архитектуры Medio	1
14	Центр разработки Medio	1
15	Группа инфраструктуры	2
16	Департамент Rating and Charging	3
\.


--
-- Data for Name: department_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.department_type (type_id, name) FROM stdin;
1	Отдел
2	Группа
3	Департамент
\.


--
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee (employee_id, full_name, salary, hire_date, position_id, department_id, branch_id) FROM stdin;
1	Суханова Арина Руслановна	103333.00	2020-01-13	1	1	1
2	Баранов Георгий Александрович	12130.00	2003-12-17	2	2	2
3	Вишневская Виктория Матвеевна	12130.00	2017-11-17	3	2	2
4	Алексеев Константин Николаевич	12366.00	2023-06-20	3	2	3
5	Лаптев Владислав Даниилович	71000.00	2022-06-16	4	3	3
6	Коновалов Даниил Матвеевич	62000.00	2013-11-26	4	3	2
7	Фролов Тимур Тимофеевич	55000.00	2017-03-22	5	3	3
8	Левина Елизавета Артёмовна	33000.00	2013-03-10	10	4	2
9	Сафонов Леонид Максимович	60615.00	2013-11-23	5	5	2
10	Журавлев Денис Георгиевич	33300.00	2016-03-26	6	5	2
11	Ильина Злата Игоревна	33250.00	2016-05-13	6	5	2
12	Дементьев Лев Маркович	31000.00	2013-03-23	7	8	2
13	Шилов Глеб Николаевич	32000.00	2017-10-31	6	9	2
14	Еремеев Денис Степанович	60300.00	2017-10-23	5	10	2
15	Тарасова Анастасия Даниловна	33752.00	2015-12-31	6	11	2
16	Высоцкая Ольга Константиновна	55000.00	2017-03-16	7	12	2
17	Богданова Софья Никитична	56000.00	2017-10-31	6	12	2
18	Новиков Марк Евгеньевич	65600.00	2013-07-01	11	6	2
19	Гусева Екатерина Марковна	60000.00	2017-07-16	8	7	2
20	Воробьев Герман Ильич	136000.00	2020-07-13	9	7	2
21	Григорьева Вера Константиновна	135200.00	2012-03-10	14	13	2
22	Осипов Андрей Алексеевич	116600.00	2012-03-23	15	13	2
23	Назарова Мария Альбертовна	151600.00	2017-05-23	4	14	2
24	Лаптева Анна Максимовна	33000.00	2017-01-25	8	14	2
25	Ситникова Эмилия Николаевна	132132.00	2013-03-30	9	14	2
26	Кузнецова Любовь Даниэльевна	75300.00	2013-07-27	9	14	2
27	Трофимов Вячеслав Романович	67100.00	2013-07-26	5	15	2
28	Пантелеева Есения Серафимовна	76550.00	2017-03-13	12	16	2
29	Зуев Георгий Ильич	135000.00	2012-11-21	13	16	2
\.


--
-- Data for Name: employee_project; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee_project (employee_id, project_id) FROM stdin;
1	1
2	2
3	3
4	4
4	28
5	8
6	5
7	9
8	10
9	11
10	12
11	13
12	14
13	15
14	16
15	17
16	18
17	19
18	20
19	21
20	6
21	22
22	7
23	23
24	24
25	25
26	26
27	27
28	28
29	6
\.


--
-- Data for Name: position; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."position" (position_id, title) FROM stdin;
1	ведущий QA инженер
2	специалист
3	специалист по персоналу
4	ведущий разработчик
5	ведущий инженер
6	старший инженер
7	инженер
8	разработчик
9	старший разработчик
10	руководитель проектов по интеграции
11	руководитель сервисных проектов
12	руководитель проектов
13	руководитель направления разработки
14	ведущий архитектор
15	старший архитектор
\.


--
-- Data for Name: project; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project (project_id, name) FROM stdin;
1	Итэлма Инженерный корпус
2	Севастополь ТВ
3	Кристалл Доп объем
4	Ростелеком. Гончарная, ВТБ Башня PM
5	Газпромбанк Бирюзова
6	Сколково
7	РТИ
8	Гпб Оазис Кабинет З.
9	Комплекс Pine Creek Доп работы
10	Сбербанк Нижний Новгород
11	Рособоронэкспорт _ PM
12	Ростелеком Академик
13	Оформление планировочных Итэлма
14	ТМК. Сколково
15	16120_1_TUL (ДС5)
16	ИКСпФОН (РД)
17	Европлан
18	Газпромбанк Аквамарин АН,Гурзуф
19	Департамент финансов и кадров
20	Пансионат Дельфин (Крым)
21	Ледовая Арена Кристалл РД АИ
22	Билайн. Ставрополь,ТПУ Томск
23	ИТЭЛМА
24	Билайн. Нижний Новгород,Итэлма АМО ЗИЛ
25	Общественное пространство Норильск
26	17110_2_TMK
27	Открытие Спартаковская
28	ВТБ Башня PM
\.


--
-- Name: branch_branch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.branch_branch_id_seq', 3, true);


--
-- Name: department_department_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.department_department_id_seq', 16, true);


--
-- Name: department_type_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.department_type_type_id_seq', 3, true);


--
-- Name: employee_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employee_employee_id_seq', 29, true);


--
-- Name: position_position_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.position_position_id_seq', 15, true);


--
-- Name: project_project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.project_project_id_seq', 28, true);


--
-- Name: branch branch_address_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branch
    ADD CONSTRAINT branch_address_key UNIQUE (address);


--
-- Name: branch branch_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branch
    ADD CONSTRAINT branch_pkey PRIMARY KEY (branch_id);


--
-- Name: department department_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_name_key UNIQUE (name);


--
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (department_id);


--
-- Name: department_type department_type_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department_type
    ADD CONSTRAINT department_type_name_key UNIQUE (name);


--
-- Name: department_type department_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department_type
    ADD CONSTRAINT department_type_pkey PRIMARY KEY (type_id);


--
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_id);


--
-- Name: employee_project employee_project_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_project
    ADD CONSTRAINT employee_project_pkey PRIMARY KEY (employee_id, project_id);


--
-- Name: position position_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."position"
    ADD CONSTRAINT position_pkey PRIMARY KEY (position_id);


--
-- Name: position position_title_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."position"
    ADD CONSTRAINT position_title_key UNIQUE (title);


--
-- Name: project project_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_name_key UNIQUE (name);


--
-- Name: project project_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_pkey PRIMARY KEY (project_id);


--
-- Name: department fk_department_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT fk_department_type FOREIGN KEY (type_id) REFERENCES public.department_type(type_id);


--
-- Name: employee fk_emp_branch; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT fk_emp_branch FOREIGN KEY (branch_id) REFERENCES public.branch(branch_id);


--
-- Name: employee fk_emp_department; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT fk_emp_department FOREIGN KEY (department_id) REFERENCES public.department(department_id);


--
-- Name: employee fk_emp_position; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT fk_emp_position FOREIGN KEY (position_id) REFERENCES public."position"(position_id);


--
-- Name: employee_project fk_ep_employee; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_project
    ADD CONSTRAINT fk_ep_employee FOREIGN KEY (employee_id) REFERENCES public.employee(employee_id) ON DELETE CASCADE;


--
-- Name: employee_project fk_ep_project; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_project
    ADD CONSTRAINT fk_ep_project FOREIGN KEY (project_id) REFERENCES public.project(project_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict UWTubxrZXXSYOInCZj5PUcfzQ6nL6gk5gDsPt9DyW48Qrcd7FEsmncUNGpAbLzS

