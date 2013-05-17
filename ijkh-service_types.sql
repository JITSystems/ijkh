--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.4
-- Dumped by pg_dump version 9.2.2
-- Started on 2013-05-17 17:43:00 MSK

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 172 (class 1259 OID 808159)
-- Name: service_types; Type: TABLE; Schema: public; Owner: nhpktyenubqzxo; Tablespace: 
--

CREATE TABLE service_types (
    id integer NOT NULL,
    title character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.service_types OWNER TO nhpktyenubqzxo;

--
-- TOC entry 171 (class 1259 OID 808157)
-- Name: service_types_id_seq; Type: SEQUENCE; Schema: public; Owner: nhpktyenubqzxo
--

CREATE SEQUENCE service_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.service_types_id_seq OWNER TO nhpktyenubqzxo;

--
-- TOC entry 2962 (class 0 OID 0)
-- Dependencies: 171
-- Name: service_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nhpktyenubqzxo
--

ALTER SEQUENCE service_types_id_seq OWNED BY service_types.id;


--
-- TOC entry 2953 (class 2604 OID 808162)
-- Name: id; Type: DEFAULT; Schema: public; Owner: nhpktyenubqzxo
--

ALTER TABLE ONLY service_types ALTER COLUMN id SET DEFAULT nextval('service_types_id_seq'::regclass);


--
-- TOC entry 2957 (class 0 OID 808159)
-- Dependencies: 172
-- Data for Name: service_types; Type: TABLE DATA; Schema: public; Owner: nhpktyenubqzxo
--

COPY service_types (id, title, created_at, updated_at) FROM stdin;
1	Водоснабжение	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971
3	Газификация	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971
4	Коммунальные услуги	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971
5	Интернет	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971
6	Охрана	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971
9	Автостоянки	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971
12	Штрафы	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971
\.


--
-- TOC entry 2963 (class 0 OID 0)
-- Dependencies: 171
-- Name: service_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nhpktyenubqzxo
--

SELECT pg_catalog.setval('service_types_id_seq', 12, true);


--
-- TOC entry 2955 (class 2606 OID 808164)
-- Name: service_types_pkey; Type: CONSTRAINT; Schema: public; Owner: nhpktyenubqzxo; Tablespace: 
--

ALTER TABLE ONLY service_types
    ADD CONSTRAINT service_types_pkey PRIMARY KEY (id);


-- Completed on 2013-05-17 17:43:38 MSK

--
-- PostgreSQL database dump complete
--

