--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.4
-- Dumped by pg_dump version 9.2.2
-- Started on 2013-05-17 17:59:25 MSK

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 182 (class 1259 OID 808202)
-- Name: field_templates; Type: TABLE; Schema: public; Owner: nhpktyenubqzxo; Tablespace: 
--

CREATE TABLE field_templates (
    id integer NOT NULL,
    title character varying(255),
    tariff_template_id integer,
    field_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    is_for_calc boolean,
    value character varying(255),
    reading_field_title character varying(255),
    field_units character varying(255)
);


ALTER TABLE public.field_templates OWNER TO nhpktyenubqzxo;

--
-- TOC entry 181 (class 1259 OID 808200)
-- Name: field_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: nhpktyenubqzxo
--

CREATE SEQUENCE field_templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.field_templates_id_seq OWNER TO nhpktyenubqzxo;

--
-- TOC entry 2962 (class 0 OID 0)
-- Dependencies: 181
-- Name: field_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nhpktyenubqzxo
--

ALTER SEQUENCE field_templates_id_seq OWNED BY field_templates.id;


--
-- TOC entry 2953 (class 2604 OID 808205)
-- Name: id; Type: DEFAULT; Schema: public; Owner: nhpktyenubqzxo
--

ALTER TABLE ONLY field_templates ALTER COLUMN id SET DEFAULT nextval('field_templates_id_seq'::regclass);


--
-- TOC entry 2957 (class 0 OID 808202)
-- Dependencies: 182
-- Data for Name: field_templates; Type: TABLE DATA; Schema: public; Owner: nhpktyenubqzxo
--

COPY field_templates (id, title, tariff_template_id, field_type, created_at, updated_at, is_for_calc, value, reading_field_title, field_units) FROM stdin;
1	Холодная вода	1	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	t	2.20	Введите показания	руб/куб. м
2	Водоотведение	1	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	t	1.50	Введите показания	руб/куб. м
24	Холодная вода	19	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	t	\N	Введите показания	руб/куб. м
25	Газ	20	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	t	\N	Введите показания	руб/куб. м
18	Холодная вода	16	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	t	\N	Введите показания	руб/куб. м
26	Газ	21	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	t	\N	Введите показания	руб/куб. м
27	Абонентская плата	22	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	\N	\N	руб
28	Минимальная сумма платежа	23	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	\N	\N	руб
17	Минимальная сумма платежа	15	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	0	\N	руб
16	Минимальная сумма платежа	14	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	0	\N	руб
15	Минимальная сумма платежа	10	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	0	\N	руб
14	Минимальная сумма платежа	9	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	0	\N	руб
13	Минимальная сумма платежа	8	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	0	\N	руб
12	Минимальная сумма платежа	7	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	0	\N	руб
19	Холодная вода	17	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	t	\N	Введите показания	руб/куб. м
20	Горячая вода	17	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	t	\N	Введите показания	руб/куб. м
21	Холодная вода	18	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	t	\N	Введите показания	руб/куб. м
22	Горячая вода	18	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	t	\N	Введите показания	руб/куб. м
23	Водоотведение	18	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	t	\N	Введите показания	руб/куб. м
11	Минимальная сумма платежа	6	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	0	\N	руб
9	Минимальная сумма платежа	5	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	0	\N	руб
8	Минимальная сумма платежа	4	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	0	\N	руб
7	Абонентская плата	13	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	200	\N	руб
6	Абонентская плата	12	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	1000	\N	руб
5	Абонентская плата	11	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	700	\N	руб
4	Абонентская плата	3	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	500	\N	руб
3	Минимальная сумма платежа	2	text_field	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	f	0	\N	руб
\.


--
-- TOC entry 2963 (class 0 OID 0)
-- Dependencies: 181
-- Name: field_templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nhpktyenubqzxo
--

SELECT pg_catalog.setval('field_templates_id_seq', 28, true);


--
-- TOC entry 2955 (class 2606 OID 808210)
-- Name: field_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: nhpktyenubqzxo; Tablespace: 
--

ALTER TABLE ONLY field_templates
    ADD CONSTRAINT field_templates_pkey PRIMARY KEY (id);


-- Completed on 2013-05-17 17:59:38 MSK

--
-- PostgreSQL database dump complete
--

