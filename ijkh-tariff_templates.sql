--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.4
-- Dumped by pg_dump version 9.2.2
-- Started on 2013-05-17 17:55:13 MSK

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 180 (class 1259 OID 808194)
-- Name: tariff_templates; Type: TABLE; Schema: public; Owner: nhpktyenubqzxo; Tablespace: 
--

CREATE TABLE tariff_templates (
    id integer NOT NULL,
    title character varying(255),
    service_type_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    has_readings boolean,
    vendor_id integer
);


ALTER TABLE public.tariff_templates OWNER TO nhpktyenubqzxo;

--
-- TOC entry 179 (class 1259 OID 808192)
-- Name: tariff_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: nhpktyenubqzxo
--

CREATE SEQUENCE tariff_templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tariff_templates_id_seq OWNER TO nhpktyenubqzxo;

--
-- TOC entry 2962 (class 0 OID 0)
-- Dependencies: 179
-- Name: tariff_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nhpktyenubqzxo
--

ALTER SEQUENCE tariff_templates_id_seq OWNED BY tariff_templates.id;


--
-- TOC entry 2953 (class 2604 OID 808197)
-- Name: id; Type: DEFAULT; Schema: public; Owner: nhpktyenubqzxo
--

ALTER TABLE ONLY tariff_templates ALTER COLUMN id SET DEFAULT nextval('tariff_templates_id_seq'::regclass);


--
-- TOC entry 2957 (class 0 OID 808194)
-- Dependencies: 180
-- Data for Name: tariff_templates; Type: TABLE DATA; Schema: public; Owner: nhpktyenubqzxo
--

COPY tariff_templates (id, title, service_type_id, created_at, updated_at, has_readings, vendor_id) FROM stdin;
1	Холодная вода, Водоотведение	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	t	1
2	Оплата штрафа ГИБДД	12	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	25
3	Улитка	5	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	16
4	Оплата коммунальных услуг	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	14
5	Оплата коммунальных услуг	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	15
6	Оплата коммунальных услуг	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	21
7	Оплата коммунальных услуг	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	22
8	Оплата коммунальных услуг	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	24
9	Оплата коммунальных услуг	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	13
10	Оплата коммунальных услуг	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	23
11	Домашний	5	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	16
12	КачОК	5	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	16
13	Колибри	5	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	16
16	Холодная вода	1	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	t	0
17	Холодная, горячая вода	1	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	t	0
18	Холодная, горячая вода, водоотведение	1	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	t	0
19	Холодная вода, водоотведение	1	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	t	0
20	Плита, Колонка	3	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	t	0
21	Плита	3	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	t	0
22	Безлимитный	5	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	0
14	Базовый тариф	6	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	19
15	Базовый тариф	6	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	20
23	Базовый тариф	6	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	0
\.


--
-- TOC entry 2963 (class 0 OID 0)
-- Dependencies: 179
-- Name: tariff_templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nhpktyenubqzxo
--

SELECT pg_catalog.setval('tariff_templates_id_seq', 23, true);


--
-- TOC entry 2955 (class 2606 OID 808199)
-- Name: tariff_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: nhpktyenubqzxo; Tablespace: 
--

ALTER TABLE ONLY tariff_templates
    ADD CONSTRAINT tariff_templates_pkey PRIMARY KEY (id);


-- Completed on 2013-05-17 17:55:27 MSK

--
-- PostgreSQL database dump complete
--

