--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.4
-- Dumped by pg_dump version 9.2.2
-- Started on 2013-05-17 17:53:43 MSK

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 176 (class 1259 OID 808175)
-- Name: vendors; Type: TABLE; Schema: public; Owner: nhpktyenubqzxo; Tablespace: 
--

CREATE TABLE vendors (
    id integer NOT NULL,
    title character varying(255),
    service_type_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    merchant_id integer,
    is_active boolean
);


ALTER TABLE public.vendors OWNER TO nhpktyenubqzxo;

--
-- TOC entry 175 (class 1259 OID 808173)
-- Name: vendors_id_seq; Type: SEQUENCE; Schema: public; Owner: nhpktyenubqzxo
--

CREATE SEQUENCE vendors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vendors_id_seq OWNER TO nhpktyenubqzxo;

--
-- TOC entry 2962 (class 0 OID 0)
-- Dependencies: 175
-- Name: vendors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nhpktyenubqzxo
--

ALTER SEQUENCE vendors_id_seq OWNED BY vendors.id;


--
-- TOC entry 2953 (class 2604 OID 808178)
-- Name: id; Type: DEFAULT; Schema: public; Owner: nhpktyenubqzxo
--

ALTER TABLE ONLY vendors ALTER COLUMN id SET DEFAULT nextval('vendors_id_seq'::regclass);


--
-- TOC entry 2957 (class 0 OID 808175)
-- Dependencies: 176
-- Data for Name: vendors; Type: TABLE DATA; Schema: public; Owner: nhpktyenubqzxo
--

COPY vendors (id, title, service_type_id, created_at, updated_at, merchant_id, is_active) FROM stdin;
25	Штрафы ГИБДД	12	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	\N	f
1	УК Финстрой	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	43222	f
2	УК Квартал-НД	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	43222	f
3	Самарские коммунальные системы	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	43222	f
4	УК Визит-М	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	43222	f
5	Цифрал-сервис	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	43222	f
6	ЖСК 38	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	43222	f
7	ЖСК 43	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	43222	f
8	ЖСК 36	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	43222	f
9	ТСЖ Партнер-21	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	43222	f
10	ТСЖ Сокол	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	43222	f
11	ТСЖ Ленинская 202	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	43222	f
12	ТСЖ 21	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	43222	f
13	ТСЖ 320	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	43222	t
14	ООО МПО ПЖРТ	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	43222	t
15	ТСЖ Промышленный 261	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	43222	t
16	Жигули-Телеком	5	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	43222	t
17	Автошкола ДО СОУК	10	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	43222	f
18	Автостоянка ВОА	9	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	43222	f
19	Дельта Тольятти	6	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	43222	t
20	Дельта Самара	6	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	43222	t
21	ТСЖ Старый город	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	43222	t
22	ТСЖ На самарской	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	43222	t
23	ТСЖ У озера-2	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	43222	t
24	ТСЖ Молодежный 1	4	2013-04-24 11:33:49.669971	2013-04-24 11:33:49.669971	43222	t
\.


--
-- TOC entry 2963 (class 0 OID 0)
-- Dependencies: 175
-- Name: vendors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nhpktyenubqzxo
--

SELECT pg_catalog.setval('vendors_id_seq', 25, true);


--
-- TOC entry 2955 (class 2606 OID 808180)
-- Name: vendors_pkey; Type: CONSTRAINT; Schema: public; Owner: nhpktyenubqzxo; Tablespace: 
--

ALTER TABLE ONLY vendors
    ADD CONSTRAINT vendors_pkey PRIMARY KEY (id);


-- Completed on 2013-05-17 17:53:56 MSK

--
-- PostgreSQL database dump complete
--

