--
-- PostgreSQL database dump
--

\restrict 3myhlwNbUHxoB0GlRUyVLKcbj0oZF9V1FgVZVEdiYMtCBLQlHZnZF5n0VRVSy65

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

\unrestrict 3myhlwNbUHxoB0GlRUyVLKcbj0oZF9V1FgVZVEdiYMtCBLQlHZnZF5n0VRVSy65

