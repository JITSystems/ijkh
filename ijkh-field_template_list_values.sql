--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.4
-- Dumped by pg_dump version 9.2.2
-- Started on 2013-05-17 18:01:14 MSK

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 186 (class 1259 OID 808221)
-- Name: field_template_list_values; Type: TABLE; Schema: public; Owner: nhpktyenubqzxo; Tablespace: 
--

CREATE TABLE field_template_list_values (
    id integer NOT NULL,
    field_template_id integer,
    value character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.field_template_list_values OWNER TO nhpktyenubqzxo;

--
-- TOC entry 185 (class 1259 OID 808219)
-- Name: field_template_list_values_id_seq; Type: SEQUENCE; Schema: public; Owner: nhpktyenubqzxo
--

CREATE SEQUENCE field_template_list_values_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.field_template_list_values_id_seq OWNER TO nhpktyenubqzxo;

--
-- TOC entry 2962 (class 0 OID 0)
-- Dependencies: 185
-- Name: field_template_list_values_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nhpktyenubqzxo
--

ALTER SEQUENCE field_template_list_values_id_seq OWNED BY field_template_list_values.id;


--
-- TOC entry 2953 (class 2604 OID 808224)
-- Name: id; Type: DEFAULT; Schema: public; Owner: nhpktyenubqzxo
--

ALTER TABLE ONLY field_template_list_values ALTER COLUMN id SET DEFAULT nextval('field_template_list_values_id_seq'::regclass);


--
-- TOC entry 2957 (class 0 OID 808221)
-- Dependencies: 186
-- Data for Name: field_template_list_values; Type: TABLE DATA; Schema: public; Owner: nhpktyenubqzxo
--

COPY field_template_list_values (id, field_template_id, value, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 2963 (class 0 OID 0)
-- Dependencies: 185
-- Name: field_template_list_values_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nhpktyenubqzxo
--

SELECT pg_catalog.setval('field_template_list_values_id_seq', 1, false);


--
-- TOC entry 2955 (class 2606 OID 808226)
-- Name: field_template_list_values_pkey; Type: CONSTRAINT; Schema: public; Owner: nhpktyenubqzxo; Tablespace: 
--

ALTER TABLE ONLY field_template_list_values
    ADD CONSTRAINT field_template_list_values_pkey PRIMARY KEY (id);


-- Completed on 2013-05-17 18:01:28 MSK

--
-- PostgreSQL database dump complete
--

