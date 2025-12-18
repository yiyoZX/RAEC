--
-- PostgreSQL database dump
--

\restrict rA6nugevfdkZHfGuQ3VzdbjVXs2kci6Vmmjod1SVhv5gXH6FJdPLIeUh19nH7e7

-- Dumped from database version 17.7 (Debian 17.7-3.pgdg13+1)
-- Dumped by pg_dump version 17.6

-- Started on 2025-12-15 00:28:56

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
-- TOC entry 217 (class 1259 OID 16385)
-- Name: actividad; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.actividad (
    id_actividad integer NOT NULL,
    nombre_actividad character varying NOT NULL,
    id_subcategoria integer NOT NULL,
    dato1 character varying,
    dato2 character varying,
    dato3 character varying
);


--
-- TOC entry 218 (class 1259 OID 16390)
-- Name: actividad_id_actividad_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.actividad_id_actividad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3571 (class 0 OID 0)
-- Dependencies: 218
-- Name: actividad_id_actividad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.actividad_id_actividad_seq OWNED BY public.actividad.id_actividad;


--
-- TOC entry 219 (class 1259 OID 16391)
-- Name: actividad_id_subcategoria_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.actividad_id_subcategoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3572 (class 0 OID 0)
-- Dependencies: 219
-- Name: actividad_id_subcategoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.actividad_id_subcategoria_seq OWNED BY public.actividad.id_subcategoria;


--
-- TOC entry 220 (class 1259 OID 16392)
-- Name: alumno; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alumno (
    rut_alumno character varying(10) NOT NULL,
    nombres character varying(50) NOT NULL,
    apellidos character varying(50) NOT NULL,
    correo character varying(60) NOT NULL,
    ano_egreso integer NOT NULL,
    id_carrera integer NOT NULL,
    password_hash text
);


--
-- TOC entry 3573 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN alumno.rut_alumno; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.alumno.rut_alumno IS 'Rut sin codigo verificador';


--
-- TOC entry 221 (class 1259 OID 16397)
-- Name: alumno_id_carrera_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.alumno_id_carrera_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3574 (class 0 OID 0)
-- Dependencies: 221
-- Name: alumno_id_carrera_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.alumno_id_carrera_seq OWNED BY public.alumno.id_carrera;


--
-- TOC entry 222 (class 1259 OID 16398)
-- Name: alumno_rut_alumno_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.alumno_rut_alumno_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3575 (class 0 OID 0)
-- Dependencies: 222
-- Name: alumno_rut_alumno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.alumno_rut_alumno_seq OWNED BY public.alumno.rut_alumno;


--
-- TOC entry 223 (class 1259 OID 16399)
-- Name: carrera; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.carrera (
    id_carrera integer NOT NULL,
    nombre_carrera character varying NOT NULL
);


--
-- TOC entry 224 (class 1259 OID 16404)
-- Name: carrera_id_carrera_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.carrera_id_carrera_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3576 (class 0 OID 0)
-- Dependencies: 224
-- Name: carrera_id_carrera_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.carrera_id_carrera_seq OWNED BY public.carrera.id_carrera;


--
-- TOC entry 225 (class 1259 OID 16405)
-- Name: categoria; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categoria (
    id_categoria integer NOT NULL,
    nombre_categoria character varying(100) NOT NULL
);


--
-- TOC entry 226 (class 1259 OID 16408)
-- Name: categoria_id_categoria_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categoria_id_categoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3577 (class 0 OID 0)
-- Dependencies: 226
-- Name: categoria_id_categoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categoria_id_categoria_seq OWNED BY public.categoria.id_categoria;


--
-- TOC entry 227 (class 1259 OID 16409)
-- Name: estado; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.estado (
    id_estado integer NOT NULL,
    nombre_estado character varying(25) NOT NULL
);


--
-- TOC entry 228 (class 1259 OID 16412)
-- Name: estado_id_estado_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.estado_id_estado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3578 (class 0 OID 0)
-- Dependencies: 228
-- Name: estado_id_estado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.estado_id_estado_seq OWNED BY public.estado.id_estado;


--
-- TOC entry 229 (class 1259 OID 16413)
-- Name: instituto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.instituto (
    id_instituto integer NOT NULL,
    nombre_instituto character varying NOT NULL
);


--
-- TOC entry 230 (class 1259 OID 16418)
-- Name: instituto-carrera; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."instituto-carrera" (
    id_instituto_carrera integer NOT NULL,
    id_carrera integer,
    id_instituto integer
);


--
-- TOC entry 231 (class 1259 OID 16421)
-- Name: instituto_id_instituto_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.instituto_id_instituto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3579 (class 0 OID 0)
-- Dependencies: 231
-- Name: instituto_id_instituto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.instituto_id_instituto_seq OWNED BY public.instituto.id_instituto;


--
-- TOC entry 232 (class 1259 OID 16422)
-- Name: periodos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.periodos (
    id_periodos integer NOT NULL,
    inicio timestamp with time zone NOT NULL,
    fin timestamp with time zone NOT NULL,
    id_profesor character varying(10) NOT NULL,
    extra boolean NOT NULL
);


--
-- TOC entry 233 (class 1259 OID 16425)
-- Name: periodos_id_periodos_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.periodos_id_periodos_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3580 (class 0 OID 0)
-- Dependencies: 233
-- Name: periodos_id_periodos_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.periodos_id_periodos_seq OWNED BY public.periodos.id_periodos;


--
-- TOC entry 234 (class 1259 OID 16426)
-- Name: profesor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.profesor (
    id_profesor character varying(10) NOT NULL,
    nombres character varying(50) NOT NULL,
    apellidos character varying(50) NOT NULL,
    correo character varying(50) NOT NULL,
    id_instituto integer NOT NULL,
    id_rol integer NOT NULL,
    password_hash text
);


--
-- TOC entry 235 (class 1259 OID 16431)
-- Name: profesor_id_instituto_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.profesor_id_instituto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3581 (class 0 OID 0)
-- Dependencies: 235
-- Name: profesor_id_instituto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.profesor_id_instituto_seq OWNED BY public.profesor.id_instituto;


--
-- TOC entry 236 (class 1259 OID 16432)
-- Name: profesor_id_profesor_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.profesor_id_profesor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3582 (class 0 OID 0)
-- Dependencies: 236
-- Name: profesor_id_profesor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.profesor_id_profesor_seq OWNED BY public.profesor.id_profesor;


--
-- TOC entry 237 (class 1259 OID 16433)
-- Name: profesor_id_rol_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.profesor_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3583 (class 0 OID 0)
-- Dependencies: 237
-- Name: profesor_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.profesor_id_rol_seq OWNED BY public.profesor.id_rol;


--
-- TOC entry 238 (class 1259 OID 16434)
-- Name: registro; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.registro (
    fecha_creacion timestamp with time zone NOT NULL,
    fecha_emision timestamp with time zone,
    archivo_data bytea,
    comentario character varying(400),
    id_registro integer NOT NULL,
    id_estado integer,
    id_profesor character varying(10) NOT NULL,
    id_actividad integer NOT NULL,
    id_alumno character varying(10) NOT NULL,
    archivo_nombre character varying(255),
    fecha_inicio_actividad timestamp with time zone,
    fecha_termino_actividad timestamp with time zone,
    horas_totales integer,
    dato1 character varying,
    dato2 character varying,
    dato3 character varying
);


--
-- TOC entry 239 (class 1259 OID 16439)
-- Name: registro_id_actividad_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.registro_id_actividad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3584 (class 0 OID 0)
-- Dependencies: 239
-- Name: registro_id_actividad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.registro_id_actividad_seq OWNED BY public.registro.id_actividad;


--
-- TOC entry 240 (class 1259 OID 16440)
-- Name: registro_id_alumno_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.registro_id_alumno_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3585 (class 0 OID 0)
-- Dependencies: 240
-- Name: registro_id_alumno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.registro_id_alumno_seq OWNED BY public.registro.id_alumno;


--
-- TOC entry 241 (class 1259 OID 16441)
-- Name: registro_id_profesor_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.registro_id_profesor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3586 (class 0 OID 0)
-- Dependencies: 241
-- Name: registro_id_profesor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.registro_id_profesor_seq OWNED BY public.registro.id_profesor;


--
-- TOC entry 242 (class 1259 OID 16442)
-- Name: registro_id_registro_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.registro_id_registro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3587 (class 0 OID 0)
-- Dependencies: 242
-- Name: registro_id_registro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.registro_id_registro_seq OWNED BY public.registro.id_registro;


--
-- TOC entry 243 (class 1259 OID 16443)
-- Name: rol; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rol (
    id_rol integer NOT NULL,
    nombre_rol character varying NOT NULL
);


--
-- TOC entry 244 (class 1259 OID 16448)
-- Name: rol_id_rol_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rol_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3588 (class 0 OID 0)
-- Dependencies: 244
-- Name: rol_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rol_id_rol_seq OWNED BY public.rol.id_rol;


--
-- TOC entry 245 (class 1259 OID 16449)
-- Name: subcategoria; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.subcategoria (
    id_subcategoria integer NOT NULL,
    subcategoria character varying(100) NOT NULL,
    id_categoria integer NOT NULL
);


--
-- TOC entry 246 (class 1259 OID 16452)
-- Name: subcategoria_id_categoria_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.subcategoria_id_categoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3589 (class 0 OID 0)
-- Dependencies: 246
-- Name: subcategoria_id_categoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.subcategoria_id_categoria_seq OWNED BY public.subcategoria.id_categoria;


--
-- TOC entry 247 (class 1259 OID 16453)
-- Name: subcategoria_id_subcategoria_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.subcategoria_id_subcategoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3590 (class 0 OID 0)
-- Dependencies: 247
-- Name: subcategoria_id_subcategoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.subcategoria_id_subcategoria_seq OWNED BY public.subcategoria.id_subcategoria;


--
-- TOC entry 3336 (class 2604 OID 16454)
-- Name: actividad id_actividad; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actividad ALTER COLUMN id_actividad SET DEFAULT nextval('public.actividad_id_actividad_seq'::regclass);


--
-- TOC entry 3337 (class 2604 OID 16455)
-- Name: actividad id_subcategoria; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actividad ALTER COLUMN id_subcategoria SET DEFAULT nextval('public.actividad_id_subcategoria_seq'::regclass);


--
-- TOC entry 3338 (class 2604 OID 16456)
-- Name: alumno rut_alumno; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alumno ALTER COLUMN rut_alumno SET DEFAULT nextval('public.alumno_rut_alumno_seq'::regclass);


--
-- TOC entry 3339 (class 2604 OID 16457)
-- Name: alumno id_carrera; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alumno ALTER COLUMN id_carrera SET DEFAULT nextval('public.alumno_id_carrera_seq'::regclass);


--
-- TOC entry 3340 (class 2604 OID 16458)
-- Name: carrera id_carrera; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carrera ALTER COLUMN id_carrera SET DEFAULT nextval('public.carrera_id_carrera_seq'::regclass);


--
-- TOC entry 3341 (class 2604 OID 16459)
-- Name: categoria id_categoria; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categoria ALTER COLUMN id_categoria SET DEFAULT nextval('public.categoria_id_categoria_seq'::regclass);


--
-- TOC entry 3342 (class 2604 OID 16460)
-- Name: estado id_estado; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estado ALTER COLUMN id_estado SET DEFAULT nextval('public.estado_id_estado_seq'::regclass);


--
-- TOC entry 3343 (class 2604 OID 16461)
-- Name: instituto id_instituto; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instituto ALTER COLUMN id_instituto SET DEFAULT nextval('public.instituto_id_instituto_seq'::regclass);


--
-- TOC entry 3344 (class 2604 OID 16462)
-- Name: profesor id_profesor; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profesor ALTER COLUMN id_profesor SET DEFAULT nextval('public.profesor_id_profesor_seq'::regclass);


--
-- TOC entry 3345 (class 2604 OID 16463)
-- Name: profesor id_instituto; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profesor ALTER COLUMN id_instituto SET DEFAULT nextval('public.profesor_id_instituto_seq'::regclass);


--
-- TOC entry 3346 (class 2604 OID 16464)
-- Name: profesor id_rol; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profesor ALTER COLUMN id_rol SET DEFAULT nextval('public.profesor_id_rol_seq'::regclass);


--
-- TOC entry 3347 (class 2604 OID 16465)
-- Name: registro id_registro; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registro ALTER COLUMN id_registro SET DEFAULT nextval('public.registro_id_registro_seq'::regclass);


--
-- TOC entry 3348 (class 2604 OID 16466)
-- Name: registro id_profesor; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registro ALTER COLUMN id_profesor SET DEFAULT nextval('public.registro_id_profesor_seq'::regclass);


--
-- TOC entry 3349 (class 2604 OID 16467)
-- Name: registro id_actividad; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registro ALTER COLUMN id_actividad SET DEFAULT nextval('public.registro_id_actividad_seq'::regclass);


--
-- TOC entry 3350 (class 2604 OID 16468)
-- Name: registro id_alumno; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registro ALTER COLUMN id_alumno SET DEFAULT nextval('public.registro_id_alumno_seq'::regclass);


--
-- TOC entry 3351 (class 2604 OID 16469)
-- Name: rol id_rol; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rol ALTER COLUMN id_rol SET DEFAULT nextval('public.rol_id_rol_seq'::regclass);


--
-- TOC entry 3352 (class 2604 OID 16470)
-- Name: subcategoria id_subcategoria; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subcategoria ALTER COLUMN id_subcategoria SET DEFAULT nextval('public.subcategoria_id_subcategoria_seq'::regclass);


--
-- TOC entry 3353 (class 2604 OID 16471)
-- Name: subcategoria id_categoria; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subcategoria ALTER COLUMN id_categoria SET DEFAULT nextval('public.subcategoria_id_categoria_seq'::regclass);


--
-- TOC entry 3535 (class 0 OID 16385)
-- Dependencies: 217
-- Data for Name: actividad; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.actividad (id_actividad, nombre_actividad, id_subcategoria, dato1, dato2, dato3) FROM stdin;
7	Dirigencias	4	\N	\N	\N
8	Deportivo destacado	4	\N	\N	\N
9	Artístico destacado	4	\N	\N	\N
10	Trabajo social destacado	4	\N	\N	\N
11	Compromiso ambiental	4	\N	\N	\N
12	Inclusion	4	\N	\N	\N
1	Curso optativo completo	1	\N	\N	\N
2	Curso optativo parcial	1	\N	\N	\N
3	Trabajo en proyecto investigacion	2	\N	\N	\N
4	Trabajo en proyecto de I+D	2	\N	\N	\N
5	Asistencia a congresos	3	\N	\N	\N
6	Publicaciones	2	\N	\N	\N
\.


--
-- TOC entry 3538 (class 0 OID 16392)
-- Dependencies: 220
-- Data for Name: alumno; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.alumno (rut_alumno, nombres, apellidos, correo, ano_egreso, id_carrera, password_hash) FROM stdin;
12345678-9	Juan P	Smith A	juansmith@alumnos.uach.cl	2024	1	\N
21111111-1	Nicolás	Muñoz	nicolas.munoz@mail.com	2023	1	$2b$12$A5ec0285W.WxF7xspD0KOuBvmjXlpfiM6ZitQodZOe/yj3soWdz1K
22222222-2	Camila	Castillo	camila.castillo@mail.com	2024	2	$2b$12$o9i.aIk8QuUF6OcFXxsAG.XSZpbNkFDpVOV0Loh0QV8CgdwmLDdW.
23333333-3	Matías	Sepúlveda	matias.sepulveda@mail.com	2025	3	$2b$12$yQj8bIE4Za/yCyd0lvMvZuiYQ8Vij5MN5k8pyR3j8Vd1qIeluQ2KG
24444444-4	Valentina	Figueroa	valentina.figueroa@mail.com	2023	4	$2b$12$lkD/30FONq.TaQzr5cw9oe/0Ud53sZp0/WiZHsArfpHd29CpSaDam
25555555-5	Ignacio	Araya	ignacio.araya@mail.com	2024	5	$2b$12$07o6QTWqGTc5oPxNg98w/.r15dDpiS6OCGqQsiPijiQfVmhymEt66
26666666-6	Josefa	Aguilar	josefa.aguilar@mail.com	2025	6	$2b$12$MJCYWanTBUvxppK7VCQ4EuPRxhHHBKA7xxjECKb87RDZRcMgF0aWS
27777777-7	Martín	Meza	martin.meza@mail.com	2023	7	$2b$12$o/CoA6ygrvq6vjihjHhQM.uVmvSOBPmbs1Wp6W7/Q1mVYwgLcPecS
28888888-8	Constanza	Sáez	constanza.saez@mail.com	2024	1	$2b$12$eTZiC4PnyWiPTyu2ZpWd0eZ2ujx3T5K2FxV11dIS8nP3uyZ6rQ6QW
29999999-9	Diego	Peña	diego.pena@mail.com	2025	2	$2b$12$SKuZuy1S3.mcWJsS0oRz2e1MiGFNheeJ7tcJP7pRdtq3TCFKRmk9W
30101010-0	Antonia	Leiva	antonia.leiva@mail.com	2023	3	$2b$12$0Rc65jpBbl4KA7ZDFF.nfe/Zyg3/bOcacnMF4REc5G.Yh3Z/7qs4u
31111111-1	Francisco	Bravo	francisco.bravo@mail.com	2024	4	$2b$12$/QPFO43x1pLDA8D0tkSDxun0GyJtE0K1AA5v/Ygzr830i2TcwcRkO
32222222-2	Sofía	Palma	sofia.palma@mail.com	2025	5	$2b$12$Qj6a9zP9DhAEbunhVc91BO4WHun.E2AacE4Mi3QjbMtbfv1B.acPi
33333333-3	Benjamín	Campos	benjamin.campos@mail.com	2023	6	$2b$12$JPy946Ejy5n0l64izoB9XueQJWFTnJL1zvv2Pka7BbPcVGvQ3wZ.S
34444444-4	Catalina	Vega	catalina.vega@mail.com	2024	7	$2b$12$.lDjH8ObLGbRo03ZCsw5fuRy/SHanxFcsAdt4gHYV7Pl3K/rntBie
35555555-5	Tomás	Acosta	tomas.acosta@mail.com	2025	1	$2b$12$iMx/z.HHKLSbZ7fTS3E3mudKW8lWl3IbTKySftoomt6ngf0mk1dMK
36666666-6	Isidora	Pizarro	isidora.pizarro@mail.com	2023	2	$2b$12$wYTLrcgomt1RBDYa7EAVSOWVoOAemvWmskEom6NA153QEvXwmbcg2
37777777-7	Emilio	Salazar	emilio.salazar@mail.com	2024	3	$2b$12$ZVtZHWZ2YHi/DyEgOxXfuOIMtaxgZMtR7392Zbw3YGaSasB500Nrm
38888888-8	Florencia	Mendoza	florencia.mendoza@mail.com	2025	4	$2b$12$sz3d2G/DiKK8hllDbo5jxupYZkDtfBtVlHX6N5Rnlpq0V/o9KmUMi
39999999-9	Samuel	Bustamante	samuel.bustamante@mail.com	2023	5	$2b$12$MsD5U8yadjkB/KQ.wqvLj.Y2I5ynwtuZBG0RLk1SXbvESNQZ/..Ia
40101010-0	Josefina	Valdés	josefina.valdes@mail.com	2024	6	$2b$12$147YCUsyS3miB0b4.cy4sOrriTsG.BRs1DZjohLH..tn4DMg4XI8q
23456789-0	María	López Silva	maria.lopez@alumnos.uach.cl	2025	2	$2b$12$w1WqdoM6qSPdT.f1cdA4we555EwmwTC2YSz3htql6HVqsWhWq6Dv2
\.


--
-- TOC entry 3541 (class 0 OID 16399)
-- Dependencies: 223
-- Data for Name: carrera; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.carrera (id_carrera, nombre_carrera) FROM stdin;
1	informatica
2	electronica
3	naval
4	mecánica
5	acustica
6	obras civiles
7	industrial
\.


--
-- TOC entry 3543 (class 0 OID 16405)
-- Dependencies: 225
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.categoria (id_categoria, nombre_categoria) FROM stdin;
2	No academica
1	Academica
\.


--
-- TOC entry 3545 (class 0 OID 16409)
-- Dependencies: 227
-- Data for Name: estado; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.estado (id_estado, nombre_estado) FROM stdin;
1	aceptado
2	rechazado
3	pendiente
\.


--
-- TOC entry 3547 (class 0 OID 16413)
-- Dependencies: 229
-- Data for Name: instituto; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.instituto (id_instituto, nombre_instituto) FROM stdin;
1	informatica
2	electronica
3	naval
4	mecánica
5	acustica
6	obras civiles
7	industrial
\.


--
-- TOC entry 3548 (class 0 OID 16418)
-- Dependencies: 230
-- Data for Name: instituto-carrera; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."instituto-carrera" (id_instituto_carrera, id_carrera, id_instituto) FROM stdin;
1	1	1
2	2	2
3	3	3
4	4	4
5	5	5
6	6	6
7	7	7
\.


--
-- TOC entry 3550 (class 0 OID 16422)
-- Dependencies: 232
-- Data for Name: periodos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.periodos (id_periodos, inicio, fin, id_profesor, extra) FROM stdin;
\.


--
-- TOC entry 3552 (class 0 OID 16426)
-- Dependencies: 234
-- Data for Name: profesor; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.profesor (id_profesor, nombres, apellidos, correo, id_instituto, id_rol, password_hash) FROM stdin;
1	Luis	Veas	lveas@example.com	1	1	$2b$12$UTt1hNZDukYMzFbq2O8L0OMbLATqO7SyN8kU9KKZA92zbKiMHVQRO
12222222-2	Marta	González	marta.gonzalez@instituto2.cl	2	1	$2b$12$1hPTu1W5O2PgDmSWcqyN3uiPuvBGr9HqhvBh0GDE2OMidEbHpZQiy
13333333-3	Juan	Ramírez	juan.ramirez@instituto3.cl	3	1	$2b$12$pIPWvC4tbCDyjw7XSg8GV.hPfEhkuXrg3vO10FgxlrhioD9DDoCZG
14444444-4	Ana	Fernández	ana.fernandez@instituto4.cl	4	1	$2b$12$16w73NBOsWBiMl0gHGn6I.7FG6EoxlXNnXGaVFqhOJdihUNE1yvcO
15555555-5	Luis	Torres	luis.torres@instituto5.cl	5	1	$2b$12$/YrE.Lpy92Qi783MMNA9NezwxA2vKWOzf5BGoVMFSyhszP15K5ARq
16666666-6	Claudia	Vargas	claudia.vargas@instituto6.cl	6	1	$2b$12$8WN1fHDDTrx5Q/mmbwxKHur13XSvBCMYc0qqPeSNhBwS4f.3PZwuC
17777777-7	Pedro	Morales	pedro.morales@instituto7.cl	7	1	$2b$12$K8Kn9DbICTHDgXyni1sRsOQMhoH3D5UYl4WViQICXR8.EaZS6/ytO
26666666-6	Francisca	Herrera	francisca.herrera@instituto2.cl	2	1	$2b$12$0ZAGb5q8RqGRzx5bcrTkEejovmNQhz/KMRogd7oWKqnA1xhTHgSQq
27777777-7	Tomás	Reyes	tomas.reyes@instituto3.cl	3	1	$2b$12$gN91Jg3WwZ5LW09vFviAOeO44MTnbM7zqLGGWkw.RXh6ZGSxhj9E.
28888888-8	Javiera	Navarro	javiera.navarro@instituto4.cl	4	1	$2b$12$KDSSzL/aWeOrQhx6JKF1b.XwC8PFKq2h3KFX3RTSEcPDzLd9dHP2u
29999999-9	José	Ortega	jose.ortega@instituto5.cl	5	1	$2b$12$ZBKo9ItfGDDPgD2ARrt0v.273O6/WozRLHoDm8CFsys.gsfLocwJK
30101010-0	Carolina	Sánchez	carolina.sanchez@instituto6.cl	6	1	$2b$12$6yMP7vjTa0rEQk6dDWt.Vu1MWe2YL2PxBZHJ/w9AHdqCzfqXJlXFi
11111111-1	Carlos	Pérez	carlos.perez@instituto1.cl	1	2	$2b$12$jlt2uRgLE0MzDMY753N86ucpwkL.ddALF20Yv5dvqEcYE6Rj.2rAi
19999999-9	Ricardo	Castro	ricardo.castro@instituto2.cl	2	2	$2b$12$G0/36HguJP4exVHIaavm3ewiIPlBk/zQv9Df/TK6gtrsBAgTDbWjm
20101010-0	Verónica	Silva	veronica.silva@instituto3.cl	3	2	$2b$12$NN1mVCh99KFAu6F/M34LjO/OV783X4mjUDlTie6gsVkTeURUVidFi
21111111-1	Sebastián	López	sebastian.lopez@instituto4.cl	4	2	$2b$12$h04zyTyhzhDvDbzB2GGZe.3G3erEm2YulgApPtfZazEMlkFPl2L8S
22222222-2	Patricia	Martínez	patricia.martinez@instituto5.cl	5	2	$2b$12$iAlZXqajafODNNJFvq.XCOtcYRJ6.4fvHSrayGQJB9aBwZwFAY/NG
23333333-3	Andrés	Contreras	andres.contreras@instituto6.cl	6	2	$2b$12$qTE7vSysdGhcXYRsOyQLIuDswxtdrdCdVN12vixiFI.smHn9fuQ7q
24444444-4	Daniela	Gutiérrez	daniela.gutierrez@instituto7.cl	7	2	$2b$12$W5IgFBqlaVHKB9lZudxXD.vHREMDV9iJTyc5G9AimiVPnF7DbVczy
25555555-5	Diego	Fuentes	diego.fuentes@instituto1.cl	1	3	$2b$12$saYyW8hlfVbf/ghmbhp3YuH2ga43RNKiel/FHy.6HVOtWHo2kCCW6
18888888-8	María	Rojas	maria.rojas@instituto1.cl	1	4	$2b$12$lRHhWuMTq8gEotFxG8zQU.ZUUANjme9xOJaxT2ttT4GfMKXa9fjkC
\.


--
-- TOC entry 3556 (class 0 OID 16434)
-- Dependencies: 238
-- Data for Name: registro; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.registro (fecha_creacion, fecha_emision, archivo_data, comentario, id_registro, id_estado, id_profesor, id_actividad, id_alumno, archivo_nombre, fecha_inicio_actividad, fecha_termino_actividad, horas_totales, dato1, dato2, dato3) FROM stdin;
2025-09-29 03:53:51.649511+00	2025-09-29 03:53:51.651294+00	\N		6	1	11111111-1	1	22222222-2	\N	2025-04-08 00:00:00+00	2025-09-29 00:00:00+00	199	\N	\N	\N
2025-09-29 13:25:57.605454+00	2025-09-29 13:25:57.608317+00	\N		7	1	1	1	22222222-2	\N	2025-09-02 00:00:00+00	2025-09-29 00:00:00+00	30	\N	\N	\N
2025-10-05 22:25:57.081867+00	2025-10-05 22:25:57.083601+00	\N		8	1	1	5	21111111-1	\N	2025-09-28 00:00:00+00	2025-10-05 00:00:00+00	10	\N	\N	\N
2025-10-16 22:06:51.513805+00	2025-10-16 22:06:51.516186+00	\N		9	1	1	1	23333333-3	\N	2025-10-11 00:00:00+00	2025-10-16 00:00:00+00	2	\N	\N	\N
2025-10-23 17:55:26.926528+00	2025-10-23 17:55:26.927957+00	\N		10	1	1	8	21111111-1	\N	2025-10-09 00:00:00+00	2025-10-23 00:00:00+00	10	\N	\N	\N
2025-10-23 18:59:49.999336+00	2025-10-23 18:59:50.006311+00	\N	raye el decanato	11	2	1	9	21111111-1	\N	2025-10-09 00:00:00+00	2025-10-23 00:00:00+00	13	\N	\N	\N
2025-11-03 03:24:52.798458+00	2025-11-04 03:24:52.798458+00	\N	Cumple con los requisitos	12	1	1	1	33333333-3	\N	2025-10-04 03:24:52.798458+00	2025-11-03 03:24:52.798458+00	17	\N	\N	\N
2025-11-02 03:24:52.798458+00	2025-11-03 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	13	1	1	2	34444444-4	\N	2025-10-03 03:24:52.798458+00	2025-11-02 03:24:52.798458+00	18	\N	\N	\N
2025-11-01 03:24:52.798458+00	2025-11-02 03:24:52.798458+00	\N	\N	14	1	1	3	35555555-5	\N	2025-10-02 03:24:52.798458+00	2025-11-01 03:24:52.798458+00	19	\N	\N	\N
2025-10-31 03:24:52.798458+00	2025-11-01 03:24:52.798458+00	\N	Excelente trabajo y dedicación	15	1	1	4	36666666-6	\N	2025-10-01 03:24:52.798458+00	2025-10-31 03:24:52.798458+00	20	\N	\N	\N
2025-10-30 03:24:52.798458+00	2025-10-31 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	16	1	1	5	37777777-7	\N	2025-09-30 03:24:52.798458+00	2025-10-30 03:24:52.798458+00	21	\N	\N	\N
2025-10-29 03:24:52.798458+00	2025-10-30 03:24:52.798458+00	\N	Cumple con los requisitos	17	1	1	6	38888888-8	\N	2025-09-29 03:24:52.798458+00	2025-10-29 03:24:52.798458+00	22	\N	\N	\N
2025-10-28 03:24:52.798458+00	2025-10-29 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	18	1	1	7	21111111-1	\N	2025-09-28 03:24:52.798458+00	2025-10-28 03:24:52.798458+00	23	\N	\N	\N
2025-10-27 03:24:52.798458+00	2025-10-28 03:24:52.798458+00	\N	\N	19	1	1	8	22222222-2	\N	2025-09-27 03:24:52.798458+00	2025-10-27 03:24:52.798458+00	24	\N	\N	\N
2025-10-26 03:24:52.798458+00	2025-10-27 03:24:52.798458+00	\N	Excelente trabajo y dedicación	20	1	1	9	23333333-3	\N	2025-09-26 03:24:52.798458+00	2025-10-26 03:24:52.798458+00	25	\N	\N	\N
2025-10-25 03:24:52.798458+00	2025-10-26 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	21	1	1	10	24444444-4	\N	2025-09-25 03:24:52.798458+00	2025-10-25 03:24:52.798458+00	26	\N	\N	\N
2025-10-24 03:24:52.798458+00	2025-10-25 03:24:52.798458+00	\N	Cumple con los requisitos	22	1	1	11	25555555-5	\N	2025-09-24 03:24:52.798458+00	2025-10-24 03:24:52.798458+00	27	\N	\N	\N
2025-10-23 03:24:52.798458+00	2025-10-24 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	23	1	1	12	26666666-6	\N	2025-09-23 03:24:52.798458+00	2025-10-23 03:24:52.798458+00	28	\N	\N	\N
2025-10-22 03:24:52.798458+00	2025-10-23 03:24:52.798458+00	\N	\N	24	1	1	1	27777777-7	\N	2025-09-22 03:24:52.798458+00	2025-10-22 03:24:52.798458+00	29	\N	\N	\N
2025-10-21 03:24:52.798458+00	2025-10-22 03:24:52.798458+00	\N	Excelente trabajo y dedicación	25	1	1	2	28888888-8	\N	2025-09-21 03:24:52.798458+00	2025-10-21 03:24:52.798458+00	30	\N	\N	\N
2025-10-20 03:24:52.798458+00	2025-10-21 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	26	1	1	3	29999999-9	\N	2025-09-20 03:24:52.798458+00	2025-10-20 03:24:52.798458+00	31	\N	\N	\N
2025-10-19 03:24:52.798458+00	2025-10-20 03:24:52.798458+00	\N	Cumple con los requisitos	27	1	1	4	30101010-0	\N	2025-09-19 03:24:52.798458+00	2025-10-19 03:24:52.798458+00	32	\N	\N	\N
2025-10-18 03:24:52.798458+00	2025-10-19 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	28	1	1	5	31111111-1	\N	2025-09-18 03:24:52.798458+00	2025-10-18 03:24:52.798458+00	33	\N	\N	\N
2025-10-17 03:24:52.798458+00	2025-10-18 03:24:52.798458+00	\N	\N	29	1	1	6	32222222-2	\N	2025-09-17 03:24:52.798458+00	2025-10-17 03:24:52.798458+00	34	\N	\N	\N
2025-10-16 03:24:52.798458+00	2025-10-17 03:24:52.798458+00	\N	Excelente trabajo y dedicación	30	1	1	7	33333333-3	\N	2025-09-16 03:24:52.798458+00	2025-10-16 03:24:52.798458+00	35	\N	\N	\N
2025-10-15 03:24:52.798458+00	2025-10-16 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	31	1	1	8	34444444-4	\N	2025-09-15 03:24:52.798458+00	2025-10-15 03:24:52.798458+00	36	\N	\N	\N
2025-10-14 03:24:52.798458+00	2025-10-15 03:24:52.798458+00	\N	Cumple con los requisitos	32	1	1	9	35555555-5	\N	2025-09-14 03:24:52.798458+00	2025-10-14 03:24:52.798458+00	37	\N	\N	\N
2025-10-13 03:24:52.798458+00	2025-10-14 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	33	1	1	10	36666666-6	\N	2025-09-13 03:24:52.798458+00	2025-10-13 03:24:52.798458+00	38	\N	\N	\N
2025-10-12 03:24:52.798458+00	2025-10-13 03:24:52.798458+00	\N	\N	34	1	1	11	37777777-7	\N	2025-09-12 03:24:52.798458+00	2025-10-12 03:24:52.798458+00	39	\N	\N	\N
2025-10-11 03:24:52.798458+00	2025-10-12 03:24:52.798458+00	\N	Excelente trabajo y dedicación	35	1	1	12	38888888-8	\N	2025-09-11 03:24:52.798458+00	2025-10-11 03:24:52.798458+00	40	\N	\N	\N
2025-10-10 03:24:52.798458+00	2025-10-11 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	36	1	1	1	21111111-1	\N	2025-09-10 03:24:52.798458+00	2025-10-10 03:24:52.798458+00	41	\N	\N	\N
2025-10-09 03:24:52.798458+00	2025-10-10 03:24:52.798458+00	\N	Cumple con los requisitos	37	1	12222222-2	2	22222222-2	\N	2025-09-09 03:24:52.798458+00	2025-10-09 03:24:52.798458+00	42	\N	\N	\N
2025-10-08 03:24:52.798458+00	2025-10-09 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	38	1	12222222-2	3	23333333-3	\N	2025-09-08 03:24:52.798458+00	2025-10-08 03:24:52.798458+00	43	\N	\N	\N
2025-10-07 03:24:52.798458+00	2025-10-08 03:24:52.798458+00	\N	\N	39	1	12222222-2	4	24444444-4	\N	2025-09-07 03:24:52.798458+00	2025-10-07 03:24:52.798458+00	44	\N	\N	\N
2025-10-06 03:24:52.798458+00	2025-10-07 03:24:52.798458+00	\N	Excelente trabajo y dedicación	40	1	12222222-2	5	25555555-5	\N	2025-09-06 03:24:52.798458+00	2025-10-06 03:24:52.798458+00	45	\N	\N	\N
2025-10-05 03:24:52.798458+00	2025-10-06 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	41	1	12222222-2	6	26666666-6	\N	2025-09-05 03:24:52.798458+00	2025-10-05 03:24:52.798458+00	46	\N	\N	\N
2025-10-04 03:24:52.798458+00	2025-10-05 03:24:52.798458+00	\N	Cumple con los requisitos	42	1	12222222-2	7	27777777-7	\N	2025-09-04 03:24:52.798458+00	2025-10-04 03:24:52.798458+00	47	\N	\N	\N
2025-10-03 03:24:52.798458+00	2025-10-04 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	43	1	12222222-2	8	28888888-8	\N	2025-09-03 03:24:52.798458+00	2025-10-03 03:24:52.798458+00	48	\N	\N	\N
2025-10-02 03:24:52.798458+00	2025-10-03 03:24:52.798458+00	\N	\N	44	1	12222222-2	9	29999999-9	\N	2025-09-02 03:24:52.798458+00	2025-10-02 03:24:52.798458+00	49	\N	\N	\N
2025-10-01 03:24:52.798458+00	2025-10-02 03:24:52.798458+00	\N	Excelente trabajo y dedicación	45	1	12222222-2	10	30101010-0	\N	2025-09-01 03:24:52.798458+00	2025-10-01 03:24:52.798458+00	5	\N	\N	\N
2025-09-30 03:24:52.798458+00	2025-10-01 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	46	1	12222222-2	11	31111111-1	\N	2025-08-31 03:24:52.798458+00	2025-09-30 03:24:52.798458+00	6	\N	\N	\N
2025-09-29 03:24:52.798458+00	2025-09-30 03:24:52.798458+00	\N	Cumple con los requisitos	47	1	12222222-2	12	32222222-2	\N	2025-08-30 03:24:52.798458+00	2025-09-29 03:24:52.798458+00	7	\N	\N	\N
2025-09-28 03:24:52.798458+00	2025-09-29 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	48	1	12222222-2	1	33333333-3	\N	2025-08-29 03:24:52.798458+00	2025-09-28 03:24:52.798458+00	8	\N	\N	\N
2025-09-27 03:24:52.798458+00	2025-09-28 03:24:52.798458+00	\N	\N	49	1	12222222-2	2	34444444-4	\N	2025-08-28 03:24:52.798458+00	2025-09-27 03:24:52.798458+00	9	\N	\N	\N
2025-09-26 03:24:52.798458+00	2025-09-27 03:24:52.798458+00	\N	Excelente trabajo y dedicación	50	1	12222222-2	3	35555555-5	\N	2025-08-27 03:24:52.798458+00	2025-09-26 03:24:52.798458+00	10	\N	\N	\N
2025-09-25 03:24:52.798458+00	2025-09-26 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	51	1	12222222-2	4	36666666-6	\N	2025-08-26 03:24:52.798458+00	2025-09-25 03:24:52.798458+00	11	\N	\N	\N
2025-09-24 03:24:52.798458+00	2025-09-25 03:24:52.798458+00	\N	Cumple con los requisitos	52	1	12222222-2	5	37777777-7	\N	2025-08-25 03:24:52.798458+00	2025-09-24 03:24:52.798458+00	12	\N	\N	\N
2025-09-23 03:24:52.798458+00	2025-09-24 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	53	1	12222222-2	6	38888888-8	\N	2025-08-24 03:24:52.798458+00	2025-09-23 03:24:52.798458+00	13	\N	\N	\N
2025-09-22 03:24:52.798458+00	2025-09-23 03:24:52.798458+00	\N	\N	54	1	12222222-2	7	21111111-1	\N	2025-08-23 03:24:52.798458+00	2025-09-22 03:24:52.798458+00	14	\N	\N	\N
2025-09-21 03:24:52.798458+00	2025-09-22 03:24:52.798458+00	\N	Excelente trabajo y dedicación	55	1	12222222-2	8	22222222-2	\N	2025-08-22 03:24:52.798458+00	2025-09-21 03:24:52.798458+00	15	\N	\N	\N
2025-09-20 03:24:52.798458+00	2025-09-21 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	56	1	12222222-2	9	23333333-3	\N	2025-08-21 03:24:52.798458+00	2025-09-20 03:24:52.798458+00	16	\N	\N	\N
2025-09-19 03:24:52.798458+00	2025-09-20 03:24:52.798458+00	\N	Cumple con los requisitos	57	1	12222222-2	10	24444444-4	\N	2025-08-20 03:24:52.798458+00	2025-09-19 03:24:52.798458+00	17	\N	\N	\N
2025-09-18 03:24:52.798458+00	2025-09-19 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	58	1	12222222-2	11	25555555-5	\N	2025-08-19 03:24:52.798458+00	2025-09-18 03:24:52.798458+00	18	\N	\N	\N
2025-09-17 03:24:52.798458+00	2025-09-18 03:24:52.798458+00	\N	\N	59	1	12222222-2	12	26666666-6	\N	2025-08-18 03:24:52.798458+00	2025-09-17 03:24:52.798458+00	19	\N	\N	\N
2025-09-16 03:24:52.798458+00	2025-09-17 03:24:52.798458+00	\N	Excelente trabajo y dedicación	60	1	12222222-2	1	27777777-7	\N	2025-08-17 03:24:52.798458+00	2025-09-16 03:24:52.798458+00	20	\N	\N	\N
2025-09-15 03:24:52.798458+00	2025-09-16 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	61	1	12222222-2	2	28888888-8	\N	2025-08-16 03:24:52.798458+00	2025-09-15 03:24:52.798458+00	21	\N	\N	\N
2025-09-14 03:24:52.798458+00	2025-09-15 03:24:52.798458+00	\N	Cumple con los requisitos	62	1	13333333-3	3	29999999-9	\N	2025-08-15 03:24:52.798458+00	2025-09-14 03:24:52.798458+00	22	\N	\N	\N
2025-09-13 03:24:52.798458+00	2025-09-14 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	63	1	13333333-3	4	30101010-0	\N	2025-08-14 03:24:52.798458+00	2025-09-13 03:24:52.798458+00	23	\N	\N	\N
2025-09-12 03:24:52.798458+00	2025-09-13 03:24:52.798458+00	\N	\N	64	1	13333333-3	5	31111111-1	\N	2025-08-13 03:24:52.798458+00	2025-09-12 03:24:52.798458+00	24	\N	\N	\N
2025-09-11 03:24:52.798458+00	2025-09-12 03:24:52.798458+00	\N	Excelente trabajo y dedicación	65	1	13333333-3	6	32222222-2	\N	2025-08-12 03:24:52.798458+00	2025-09-11 03:24:52.798458+00	25	\N	\N	\N
2025-09-10 03:24:52.798458+00	2025-09-11 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	66	1	13333333-3	7	33333333-3	\N	2025-08-11 03:24:52.798458+00	2025-09-10 03:24:52.798458+00	26	\N	\N	\N
2025-09-09 03:24:52.798458+00	2025-09-10 03:24:52.798458+00	\N	Cumple con los requisitos	67	1	13333333-3	8	34444444-4	\N	2025-08-10 03:24:52.798458+00	2025-09-09 03:24:52.798458+00	27	\N	\N	\N
2025-09-08 03:24:52.798458+00	2025-09-09 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	68	1	13333333-3	9	35555555-5	\N	2025-08-09 03:24:52.798458+00	2025-09-08 03:24:52.798458+00	28	\N	\N	\N
2025-09-07 03:24:52.798458+00	2025-09-08 03:24:52.798458+00	\N	\N	69	1	13333333-3	10	36666666-6	\N	2025-08-08 03:24:52.798458+00	2025-09-07 03:24:52.798458+00	29	\N	\N	\N
2025-09-06 03:24:52.798458+00	2025-09-07 03:24:52.798458+00	\N	Excelente trabajo y dedicación	70	1	13333333-3	11	37777777-7	\N	2025-08-07 03:24:52.798458+00	2025-09-06 03:24:52.798458+00	30	\N	\N	\N
2025-09-05 03:24:52.798458+00	2025-09-06 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	71	1	13333333-3	12	38888888-8	\N	2025-08-06 03:24:52.798458+00	2025-09-05 03:24:52.798458+00	31	\N	\N	\N
2025-09-04 03:24:52.798458+00	2025-09-05 03:24:52.798458+00	\N	Cumple con los requisitos	72	1	13333333-3	1	21111111-1	\N	2025-08-05 03:24:52.798458+00	2025-09-04 03:24:52.798458+00	32	\N	\N	\N
2025-09-03 03:24:52.798458+00	2025-09-04 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	73	1	13333333-3	2	22222222-2	\N	2025-08-04 03:24:52.798458+00	2025-09-03 03:24:52.798458+00	33	\N	\N	\N
2025-09-02 03:24:52.798458+00	2025-09-03 03:24:52.798458+00	\N	\N	74	1	13333333-3	3	23333333-3	\N	2025-08-03 03:24:52.798458+00	2025-09-02 03:24:52.798458+00	34	\N	\N	\N
2025-09-01 03:24:52.798458+00	2025-09-02 03:24:52.798458+00	\N	Excelente trabajo y dedicación	75	1	13333333-3	4	24444444-4	\N	2025-08-02 03:24:52.798458+00	2025-09-01 03:24:52.798458+00	35	\N	\N	\N
2025-08-31 03:24:52.798458+00	2025-09-01 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	76	1	13333333-3	5	25555555-5	\N	2025-08-01 03:24:52.798458+00	2025-08-31 03:24:52.798458+00	36	\N	\N	\N
2025-08-30 03:24:52.798458+00	2025-08-31 03:24:52.798458+00	\N	Cumple con los requisitos	77	1	13333333-3	6	26666666-6	\N	2025-07-31 03:24:52.798458+00	2025-08-30 03:24:52.798458+00	37	\N	\N	\N
2025-08-29 03:24:52.798458+00	2025-08-30 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	78	1	13333333-3	7	27777777-7	\N	2025-07-30 03:24:52.798458+00	2025-08-29 03:24:52.798458+00	38	\N	\N	\N
2025-08-28 03:24:52.798458+00	2025-08-29 03:24:52.798458+00	\N	\N	79	1	13333333-3	8	28888888-8	\N	2025-07-29 03:24:52.798458+00	2025-08-28 03:24:52.798458+00	39	\N	\N	\N
2025-08-27 03:24:52.798458+00	2025-08-28 03:24:52.798458+00	\N	Excelente trabajo y dedicación	80	1	13333333-3	9	29999999-9	\N	2025-07-28 03:24:52.798458+00	2025-08-27 03:24:52.798458+00	40	\N	\N	\N
2025-08-26 03:24:52.798458+00	2025-08-27 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	81	1	13333333-3	10	30101010-0	\N	2025-07-27 03:24:52.798458+00	2025-08-26 03:24:52.798458+00	41	\N	\N	\N
2025-08-25 03:24:52.798458+00	2025-08-26 03:24:52.798458+00	\N	Cumple con los requisitos	82	1	13333333-3	11	31111111-1	\N	2025-07-26 03:24:52.798458+00	2025-08-25 03:24:52.798458+00	42	\N	\N	\N
2025-08-24 03:24:52.798458+00	2025-08-25 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	83	1	13333333-3	12	32222222-2	\N	2025-07-25 03:24:52.798458+00	2025-08-24 03:24:52.798458+00	43	\N	\N	\N
2025-08-23 03:24:52.798458+00	2025-08-24 03:24:52.798458+00	\N	\N	84	1	13333333-3	1	33333333-3	\N	2025-07-24 03:24:52.798458+00	2025-08-23 03:24:52.798458+00	44	\N	\N	\N
2025-08-22 03:24:52.798458+00	2025-08-23 03:24:52.798458+00	\N	Excelente trabajo y dedicación	85	1	13333333-3	2	34444444-4	\N	2025-07-23 03:24:52.798458+00	2025-08-22 03:24:52.798458+00	45	\N	\N	\N
2025-08-21 03:24:52.798458+00	2025-08-22 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	86	1	13333333-3	3	35555555-5	\N	2025-07-22 03:24:52.798458+00	2025-08-21 03:24:52.798458+00	46	\N	\N	\N
2025-08-20 03:24:52.798458+00	2025-08-21 03:24:52.798458+00	\N	Cumple con los requisitos	87	1	14444444-4	4	36666666-6	\N	2025-07-21 03:24:52.798458+00	2025-08-20 03:24:52.798458+00	47	\N	\N	\N
2025-08-19 03:24:52.798458+00	2025-08-20 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	88	1	14444444-4	5	37777777-7	\N	2025-07-20 03:24:52.798458+00	2025-08-19 03:24:52.798458+00	48	\N	\N	\N
2025-08-18 03:24:52.798458+00	2025-08-19 03:24:52.798458+00	\N	\N	89	1	14444444-4	6	38888888-8	\N	2025-07-19 03:24:52.798458+00	2025-08-18 03:24:52.798458+00	49	\N	\N	\N
2025-08-17 03:24:52.798458+00	2025-08-18 03:24:52.798458+00	\N	Excelente trabajo y dedicación	90	1	14444444-4	7	21111111-1	\N	2025-07-18 03:24:52.798458+00	2025-08-17 03:24:52.798458+00	5	\N	\N	\N
2025-08-16 03:24:52.798458+00	2025-08-17 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	91	1	14444444-4	8	22222222-2	\N	2025-07-17 03:24:52.798458+00	2025-08-16 03:24:52.798458+00	6	\N	\N	\N
2025-08-15 03:24:52.798458+00	2025-08-16 03:24:52.798458+00	\N	Cumple con los requisitos	92	1	14444444-4	9	23333333-3	\N	2025-07-16 03:24:52.798458+00	2025-08-15 03:24:52.798458+00	7	\N	\N	\N
2025-08-14 03:24:52.798458+00	2025-08-15 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	93	1	14444444-4	10	24444444-4	\N	2025-07-15 03:24:52.798458+00	2025-08-14 03:24:52.798458+00	8	\N	\N	\N
2025-08-13 03:24:52.798458+00	2025-08-14 03:24:52.798458+00	\N	\N	94	1	14444444-4	11	25555555-5	\N	2025-07-14 03:24:52.798458+00	2025-08-13 03:24:52.798458+00	9	\N	\N	\N
2025-08-12 03:24:52.798458+00	2025-08-13 03:24:52.798458+00	\N	Excelente trabajo y dedicación	95	1	14444444-4	12	26666666-6	\N	2025-07-13 03:24:52.798458+00	2025-08-12 03:24:52.798458+00	10	\N	\N	\N
2025-08-11 03:24:52.798458+00	2025-08-12 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	96	1	14444444-4	1	27777777-7	\N	2025-07-12 03:24:52.798458+00	2025-08-11 03:24:52.798458+00	11	\N	\N	\N
2025-08-10 03:24:52.798458+00	2025-08-11 03:24:52.798458+00	\N	Cumple con los requisitos	97	1	14444444-4	2	28888888-8	\N	2025-07-11 03:24:52.798458+00	2025-08-10 03:24:52.798458+00	12	\N	\N	\N
2025-08-09 03:24:52.798458+00	2025-08-10 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	98	1	14444444-4	3	29999999-9	\N	2025-07-10 03:24:52.798458+00	2025-08-09 03:24:52.798458+00	13	\N	\N	\N
2025-08-08 03:24:52.798458+00	2025-08-09 03:24:52.798458+00	\N	\N	99	1	14444444-4	4	30101010-0	\N	2025-07-09 03:24:52.798458+00	2025-08-08 03:24:52.798458+00	14	\N	\N	\N
2025-08-07 03:24:52.798458+00	2025-08-08 03:24:52.798458+00	\N	Excelente trabajo y dedicación	100	1	14444444-4	5	31111111-1	\N	2025-07-08 03:24:52.798458+00	2025-08-07 03:24:52.798458+00	15	\N	\N	\N
2025-08-06 03:24:52.798458+00	2025-08-07 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	101	1	14444444-4	6	32222222-2	\N	2025-07-07 03:24:52.798458+00	2025-08-06 03:24:52.798458+00	16	\N	\N	\N
2025-08-05 03:24:52.798458+00	2025-08-06 03:24:52.798458+00	\N	Cumple con los requisitos	102	1	14444444-4	7	33333333-3	\N	2025-07-06 03:24:52.798458+00	2025-08-05 03:24:52.798458+00	17	\N	\N	\N
2025-08-04 03:24:52.798458+00	2025-08-05 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	103	1	14444444-4	8	34444444-4	\N	2025-07-05 03:24:52.798458+00	2025-08-04 03:24:52.798458+00	18	\N	\N	\N
2025-08-03 03:24:52.798458+00	2025-08-04 03:24:52.798458+00	\N	\N	104	1	14444444-4	9	35555555-5	\N	2025-07-04 03:24:52.798458+00	2025-08-03 03:24:52.798458+00	19	\N	\N	\N
2025-08-02 03:24:52.798458+00	2025-08-03 03:24:52.798458+00	\N	Excelente trabajo y dedicación	105	1	14444444-4	10	36666666-6	\N	2025-07-03 03:24:52.798458+00	2025-08-02 03:24:52.798458+00	20	\N	\N	\N
2025-08-01 03:24:52.798458+00	2025-08-02 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	106	1	14444444-4	11	37777777-7	\N	2025-07-02 03:24:52.798458+00	2025-08-01 03:24:52.798458+00	21	\N	\N	\N
2025-07-31 03:24:52.798458+00	2025-08-01 03:24:52.798458+00	\N	Cumple con los requisitos	107	1	14444444-4	12	38888888-8	\N	2025-07-01 03:24:52.798458+00	2025-07-31 03:24:52.798458+00	22	\N	\N	\N
2025-07-30 03:24:52.798458+00	2025-07-31 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	108	1	14444444-4	1	21111111-1	\N	2025-06-30 03:24:52.798458+00	2025-07-30 03:24:52.798458+00	23	\N	\N	\N
2025-07-29 03:24:52.798458+00	2025-07-30 03:24:52.798458+00	\N	\N	109	1	14444444-4	2	22222222-2	\N	2025-06-29 03:24:52.798458+00	2025-07-29 03:24:52.798458+00	24	\N	\N	\N
2025-07-28 03:24:52.798458+00	2025-07-29 03:24:52.798458+00	\N	Excelente trabajo y dedicación	110	1	14444444-4	3	23333333-3	\N	2025-06-28 03:24:52.798458+00	2025-07-28 03:24:52.798458+00	25	\N	\N	\N
2025-07-27 03:24:52.798458+00	2025-07-28 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	111	1	14444444-4	4	24444444-4	\N	2025-06-27 03:24:52.798458+00	2025-07-27 03:24:52.798458+00	26	\N	\N	\N
2025-07-26 03:24:52.798458+00	2025-07-27 03:24:52.798458+00	\N	Cumple con los requisitos	112	1	15555555-5	5	25555555-5	\N	2025-06-26 03:24:52.798458+00	2025-07-26 03:24:52.798458+00	27	\N	\N	\N
2025-07-25 03:24:52.798458+00	2025-07-26 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	113	1	15555555-5	6	26666666-6	\N	2025-06-25 03:24:52.798458+00	2025-07-25 03:24:52.798458+00	28	\N	\N	\N
2025-07-24 03:24:52.798458+00	2025-07-25 03:24:52.798458+00	\N	\N	114	1	15555555-5	7	27777777-7	\N	2025-06-24 03:24:52.798458+00	2025-07-24 03:24:52.798458+00	29	\N	\N	\N
2025-07-23 03:24:52.798458+00	2025-07-24 03:24:52.798458+00	\N	Excelente trabajo y dedicación	115	1	15555555-5	8	28888888-8	\N	2025-06-23 03:24:52.798458+00	2025-07-23 03:24:52.798458+00	30	\N	\N	\N
2025-07-22 03:24:52.798458+00	2025-07-23 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	116	1	15555555-5	9	29999999-9	\N	2025-06-22 03:24:52.798458+00	2025-07-22 03:24:52.798458+00	31	\N	\N	\N
2025-07-21 03:24:52.798458+00	2025-07-22 03:24:52.798458+00	\N	Cumple con los requisitos	117	1	15555555-5	10	30101010-0	\N	2025-06-21 03:24:52.798458+00	2025-07-21 03:24:52.798458+00	32	\N	\N	\N
2025-07-20 03:24:52.798458+00	2025-07-21 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	118	1	15555555-5	11	31111111-1	\N	2025-06-20 03:24:52.798458+00	2025-07-20 03:24:52.798458+00	33	\N	\N	\N
2025-07-19 03:24:52.798458+00	2025-07-20 03:24:52.798458+00	\N	\N	119	1	15555555-5	12	32222222-2	\N	2025-06-19 03:24:52.798458+00	2025-07-19 03:24:52.798458+00	34	\N	\N	\N
2025-07-18 03:24:52.798458+00	2025-07-19 03:24:52.798458+00	\N	Excelente trabajo y dedicación	120	1	15555555-5	1	33333333-3	\N	2025-06-18 03:24:52.798458+00	2025-07-18 03:24:52.798458+00	35	\N	\N	\N
2025-07-17 03:24:52.798458+00	2025-07-18 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	121	1	15555555-5	2	34444444-4	\N	2025-06-17 03:24:52.798458+00	2025-07-17 03:24:52.798458+00	36	\N	\N	\N
2025-07-16 03:24:52.798458+00	2025-07-17 03:24:52.798458+00	\N	Cumple con los requisitos	122	1	15555555-5	3	35555555-5	\N	2025-06-16 03:24:52.798458+00	2025-07-16 03:24:52.798458+00	37	\N	\N	\N
2025-07-15 03:24:52.798458+00	2025-07-16 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	123	1	15555555-5	4	36666666-6	\N	2025-06-15 03:24:52.798458+00	2025-07-15 03:24:52.798458+00	38	\N	\N	\N
2025-07-14 03:24:52.798458+00	2025-07-15 03:24:52.798458+00	\N	\N	124	1	15555555-5	5	37777777-7	\N	2025-06-14 03:24:52.798458+00	2025-07-14 03:24:52.798458+00	39	\N	\N	\N
2025-07-13 03:24:52.798458+00	2025-07-14 03:24:52.798458+00	\N	Excelente trabajo y dedicación	125	1	15555555-5	6	38888888-8	\N	2025-06-13 03:24:52.798458+00	2025-07-13 03:24:52.798458+00	40	\N	\N	\N
2025-07-12 03:24:52.798458+00	2025-07-13 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	126	1	15555555-5	7	21111111-1	\N	2025-06-12 03:24:52.798458+00	2025-07-12 03:24:52.798458+00	41	\N	\N	\N
2025-07-11 03:24:52.798458+00	2025-07-12 03:24:52.798458+00	\N	Cumple con los requisitos	127	1	15555555-5	8	22222222-2	\N	2025-06-11 03:24:52.798458+00	2025-07-11 03:24:52.798458+00	42	\N	\N	\N
2025-07-10 03:24:52.798458+00	2025-07-11 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	128	1	15555555-5	9	23333333-3	\N	2025-06-10 03:24:52.798458+00	2025-07-10 03:24:52.798458+00	43	\N	\N	\N
2025-07-09 03:24:52.798458+00	2025-07-10 03:24:52.798458+00	\N	\N	129	1	15555555-5	10	24444444-4	\N	2025-06-09 03:24:52.798458+00	2025-07-09 03:24:52.798458+00	44	\N	\N	\N
2025-07-08 03:24:52.798458+00	2025-07-09 03:24:52.798458+00	\N	Excelente trabajo y dedicación	130	1	15555555-5	11	25555555-5	\N	2025-06-08 03:24:52.798458+00	2025-07-08 03:24:52.798458+00	45	\N	\N	\N
2025-07-07 03:24:52.798458+00	2025-07-08 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	131	1	15555555-5	12	26666666-6	\N	2025-06-07 03:24:52.798458+00	2025-07-07 03:24:52.798458+00	46	\N	\N	\N
2025-07-06 03:24:52.798458+00	2025-07-07 03:24:52.798458+00	\N	Cumple con los requisitos	132	1	15555555-5	1	27777777-7	\N	2025-06-06 03:24:52.798458+00	2025-07-06 03:24:52.798458+00	47	\N	\N	\N
2025-07-05 03:24:52.798458+00	2025-07-06 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	133	1	15555555-5	2	28888888-8	\N	2025-06-05 03:24:52.798458+00	2025-07-05 03:24:52.798458+00	48	\N	\N	\N
2025-07-04 03:24:52.798458+00	2025-07-05 03:24:52.798458+00	\N	\N	134	1	15555555-5	3	29999999-9	\N	2025-06-04 03:24:52.798458+00	2025-07-04 03:24:52.798458+00	49	\N	\N	\N
2025-07-03 03:24:52.798458+00	2025-07-04 03:24:52.798458+00	\N	Excelente trabajo y dedicación	135	1	15555555-5	4	30101010-0	\N	2025-06-03 03:24:52.798458+00	2025-07-03 03:24:52.798458+00	5	\N	\N	\N
2025-07-02 03:24:52.798458+00	2025-07-03 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	136	1	15555555-5	5	31111111-1	\N	2025-06-02 03:24:52.798458+00	2025-07-02 03:24:52.798458+00	6	\N	\N	\N
2025-07-01 03:24:52.798458+00	2025-07-02 03:24:52.798458+00	\N	Cumple con los requisitos	137	1	16666666-6	6	32222222-2	\N	2025-06-01 03:24:52.798458+00	2025-07-01 03:24:52.798458+00	7	\N	\N	\N
2025-06-30 03:24:52.798458+00	2025-07-01 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	138	1	16666666-6	7	33333333-3	\N	2025-05-31 03:24:52.798458+00	2025-06-30 03:24:52.798458+00	8	\N	\N	\N
2025-06-29 03:24:52.798458+00	2025-06-30 03:24:52.798458+00	\N	\N	139	1	16666666-6	8	34444444-4	\N	2025-05-30 03:24:52.798458+00	2025-06-29 03:24:52.798458+00	9	\N	\N	\N
2025-06-28 03:24:52.798458+00	2025-06-29 03:24:52.798458+00	\N	Excelente trabajo y dedicación	140	1	16666666-6	9	35555555-5	\N	2025-05-29 03:24:52.798458+00	2025-06-28 03:24:52.798458+00	10	\N	\N	\N
2025-06-27 03:24:52.798458+00	2025-06-28 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	141	1	16666666-6	10	36666666-6	\N	2025-05-28 03:24:52.798458+00	2025-06-27 03:24:52.798458+00	11	\N	\N	\N
2025-06-26 03:24:52.798458+00	2025-06-27 03:24:52.798458+00	\N	Cumple con los requisitos	142	1	16666666-6	11	37777777-7	\N	2025-05-27 03:24:52.798458+00	2025-06-26 03:24:52.798458+00	12	\N	\N	\N
2025-06-25 03:24:52.798458+00	2025-06-26 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	143	1	16666666-6	12	38888888-8	\N	2025-05-26 03:24:52.798458+00	2025-06-25 03:24:52.798458+00	13	\N	\N	\N
2025-06-24 03:24:52.798458+00	2025-06-25 03:24:52.798458+00	\N	\N	144	1	16666666-6	1	21111111-1	\N	2025-05-25 03:24:52.798458+00	2025-06-24 03:24:52.798458+00	14	\N	\N	\N
2025-06-23 03:24:52.798458+00	2025-06-24 03:24:52.798458+00	\N	Excelente trabajo y dedicación	145	1	16666666-6	2	22222222-2	\N	2025-05-24 03:24:52.798458+00	2025-06-23 03:24:52.798458+00	15	\N	\N	\N
2025-06-22 03:24:52.798458+00	2025-06-23 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	146	1	16666666-6	3	23333333-3	\N	2025-05-23 03:24:52.798458+00	2025-06-22 03:24:52.798458+00	16	\N	\N	\N
2025-06-21 03:24:52.798458+00	2025-06-22 03:24:52.798458+00	\N	Cumple con los requisitos	147	1	16666666-6	4	24444444-4	\N	2025-05-22 03:24:52.798458+00	2025-06-21 03:24:52.798458+00	17	\N	\N	\N
2025-06-20 03:24:52.798458+00	2025-06-21 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	148	1	16666666-6	5	25555555-5	\N	2025-05-21 03:24:52.798458+00	2025-06-20 03:24:52.798458+00	18	\N	\N	\N
2025-06-19 03:24:52.798458+00	2025-06-20 03:24:52.798458+00	\N	\N	149	1	16666666-6	6	26666666-6	\N	2025-05-20 03:24:52.798458+00	2025-06-19 03:24:52.798458+00	19	\N	\N	\N
2025-11-15 03:24:52.798458+00	2025-11-16 03:24:52.798458+00	\N	Excelente trabajo y dedicación	150	1	16666666-6	7	27777777-7	\N	2025-10-16 03:24:52.798458+00	2025-11-15 03:24:52.798458+00	20	\N	\N	\N
2025-11-14 03:24:52.798458+00	2025-11-15 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	151	1	16666666-6	8	28888888-8	\N	2025-10-15 03:24:52.798458+00	2025-11-14 03:24:52.798458+00	21	\N	\N	\N
2025-11-13 03:24:52.798458+00	2025-11-14 03:24:52.798458+00	\N	Cumple con los requisitos	152	1	16666666-6	9	29999999-9	\N	2025-10-14 03:24:52.798458+00	2025-11-13 03:24:52.798458+00	22	\N	\N	\N
2025-11-12 03:24:52.798458+00	2025-11-13 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	153	1	16666666-6	10	30101010-0	\N	2025-10-13 03:24:52.798458+00	2025-11-12 03:24:52.798458+00	23	\N	\N	\N
2025-11-11 03:24:52.798458+00	2025-11-12 03:24:52.798458+00	\N	\N	154	1	16666666-6	11	31111111-1	\N	2025-10-12 03:24:52.798458+00	2025-11-11 03:24:52.798458+00	24	\N	\N	\N
2025-11-10 03:24:52.798458+00	2025-11-11 03:24:52.798458+00	\N	Excelente trabajo y dedicación	155	1	16666666-6	12	32222222-2	\N	2025-10-11 03:24:52.798458+00	2025-11-10 03:24:52.798458+00	25	\N	\N	\N
2025-11-09 03:24:52.798458+00	2025-11-10 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	156	1	16666666-6	1	33333333-3	\N	2025-10-10 03:24:52.798458+00	2025-11-09 03:24:52.798458+00	26	\N	\N	\N
2025-11-08 03:24:52.798458+00	2025-11-09 03:24:52.798458+00	\N	Cumple con los requisitos	157	1	16666666-6	2	34444444-4	\N	2025-10-09 03:24:52.798458+00	2025-11-08 03:24:52.798458+00	27	\N	\N	\N
2025-11-07 03:24:52.798458+00	2025-11-08 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	158	1	16666666-6	3	35555555-5	\N	2025-10-08 03:24:52.798458+00	2025-11-07 03:24:52.798458+00	28	\N	\N	\N
2025-11-06 03:24:52.798458+00	2025-11-07 03:24:52.798458+00	\N	\N	159	1	16666666-6	4	36666666-6	\N	2025-10-07 03:24:52.798458+00	2025-11-06 03:24:52.798458+00	29	\N	\N	\N
2025-11-05 03:24:52.798458+00	2025-11-06 03:24:52.798458+00	\N	Excelente trabajo y dedicación	160	1	16666666-6	5	37777777-7	\N	2025-10-06 03:24:52.798458+00	2025-11-05 03:24:52.798458+00	30	\N	\N	\N
2025-11-04 03:24:52.798458+00	2025-11-05 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	161	1	16666666-6	6	38888888-8	\N	2025-10-05 03:24:52.798458+00	2025-11-04 03:24:52.798458+00	31	\N	\N	\N
2025-11-03 03:24:52.798458+00	2025-11-04 03:24:52.798458+00	\N	Cumple con los requisitos	162	1	17777777-7	7	21111111-1	\N	2025-10-04 03:24:52.798458+00	2025-11-03 03:24:52.798458+00	32	\N	\N	\N
2025-11-02 03:24:52.798458+00	2025-11-03 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	163	1	17777777-7	8	22222222-2	\N	2025-10-03 03:24:52.798458+00	2025-11-02 03:24:52.798458+00	33	\N	\N	\N
2025-11-01 03:24:52.798458+00	2025-11-02 03:24:52.798458+00	\N	\N	164	1	17777777-7	9	23333333-3	\N	2025-10-02 03:24:52.798458+00	2025-11-01 03:24:52.798458+00	34	\N	\N	\N
2025-10-31 03:24:52.798458+00	2025-11-01 03:24:52.798458+00	\N	Excelente trabajo y dedicación	165	1	17777777-7	10	24444444-4	\N	2025-10-01 03:24:52.798458+00	2025-10-31 03:24:52.798458+00	35	\N	\N	\N
2025-10-30 03:24:52.798458+00	2025-10-31 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	166	1	17777777-7	11	25555555-5	\N	2025-09-30 03:24:52.798458+00	2025-10-30 03:24:52.798458+00	36	\N	\N	\N
2025-10-29 03:24:52.798458+00	2025-10-30 03:24:52.798458+00	\N	Cumple con los requisitos	167	1	17777777-7	12	26666666-6	\N	2025-09-29 03:24:52.798458+00	2025-10-29 03:24:52.798458+00	37	\N	\N	\N
2025-10-28 03:24:52.798458+00	2025-10-29 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	168	1	17777777-7	1	27777777-7	\N	2025-09-28 03:24:52.798458+00	2025-10-28 03:24:52.798458+00	38	\N	\N	\N
2025-10-27 03:24:52.798458+00	2025-10-28 03:24:52.798458+00	\N	\N	169	1	17777777-7	2	28888888-8	\N	2025-09-27 03:24:52.798458+00	2025-10-27 03:24:52.798458+00	39	\N	\N	\N
2025-10-26 03:24:52.798458+00	2025-10-27 03:24:52.798458+00	\N	Excelente trabajo y dedicación	170	1	17777777-7	3	29999999-9	\N	2025-09-26 03:24:52.798458+00	2025-10-26 03:24:52.798458+00	40	\N	\N	\N
2025-10-25 03:24:52.798458+00	2025-10-26 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	171	1	17777777-7	4	30101010-0	\N	2025-09-25 03:24:52.798458+00	2025-10-25 03:24:52.798458+00	41	\N	\N	\N
2025-10-24 03:24:52.798458+00	2025-10-25 03:24:52.798458+00	\N	Cumple con los requisitos	172	1	17777777-7	5	31111111-1	\N	2025-09-24 03:24:52.798458+00	2025-10-24 03:24:52.798458+00	42	\N	\N	\N
2025-10-23 03:24:52.798458+00	2025-10-24 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	173	1	17777777-7	6	32222222-2	\N	2025-09-23 03:24:52.798458+00	2025-10-23 03:24:52.798458+00	43	\N	\N	\N
2025-10-22 03:24:52.798458+00	2025-10-23 03:24:52.798458+00	\N	\N	174	1	17777777-7	7	33333333-3	\N	2025-09-22 03:24:52.798458+00	2025-10-22 03:24:52.798458+00	44	\N	\N	\N
2025-10-21 03:24:52.798458+00	2025-10-22 03:24:52.798458+00	\N	Excelente trabajo y dedicación	175	1	17777777-7	8	34444444-4	\N	2025-09-21 03:24:52.798458+00	2025-10-21 03:24:52.798458+00	45	\N	\N	\N
2025-10-20 03:24:52.798458+00	2025-10-21 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	176	1	17777777-7	9	35555555-5	\N	2025-09-20 03:24:52.798458+00	2025-10-20 03:24:52.798458+00	46	\N	\N	\N
2025-10-19 03:24:52.798458+00	2025-10-20 03:24:52.798458+00	\N	Cumple con los requisitos	177	1	17777777-7	10	36666666-6	\N	2025-09-19 03:24:52.798458+00	2025-10-19 03:24:52.798458+00	47	\N	\N	\N
2025-10-18 03:24:52.798458+00	2025-10-19 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	178	1	17777777-7	11	37777777-7	\N	2025-09-18 03:24:52.798458+00	2025-10-18 03:24:52.798458+00	48	\N	\N	\N
2025-10-17 03:24:52.798458+00	2025-10-18 03:24:52.798458+00	\N	\N	179	1	17777777-7	12	38888888-8	\N	2025-09-17 03:24:52.798458+00	2025-10-17 03:24:52.798458+00	49	\N	\N	\N
2025-10-16 03:24:52.798458+00	2025-10-17 03:24:52.798458+00	\N	Excelente trabajo y dedicación	180	1	17777777-7	1	21111111-1	\N	2025-09-16 03:24:52.798458+00	2025-10-16 03:24:52.798458+00	5	\N	\N	\N
2025-10-15 03:24:52.798458+00	2025-10-16 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	181	1	17777777-7	2	22222222-2	\N	2025-09-15 03:24:52.798458+00	2025-10-15 03:24:52.798458+00	6	\N	\N	\N
2025-10-14 03:24:52.798458+00	2025-10-15 03:24:52.798458+00	\N	Cumple con los requisitos	182	1	17777777-7	3	23333333-3	\N	2025-09-14 03:24:52.798458+00	2025-10-14 03:24:52.798458+00	7	\N	\N	\N
2025-10-13 03:24:52.798458+00	2025-10-14 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	183	1	17777777-7	4	24444444-4	\N	2025-09-13 03:24:52.798458+00	2025-10-13 03:24:52.798458+00	8	\N	\N	\N
2025-10-12 03:24:52.798458+00	2025-10-13 03:24:52.798458+00	\N	\N	184	1	17777777-7	5	25555555-5	\N	2025-09-12 03:24:52.798458+00	2025-10-12 03:24:52.798458+00	9	\N	\N	\N
2025-10-11 03:24:52.798458+00	2025-10-12 03:24:52.798458+00	\N	Excelente trabajo y dedicación	185	1	17777777-7	6	26666666-6	\N	2025-09-11 03:24:52.798458+00	2025-10-11 03:24:52.798458+00	10	\N	\N	\N
2025-10-10 03:24:52.798458+00	2025-10-11 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	186	1	17777777-7	7	27777777-7	\N	2025-09-10 03:24:52.798458+00	2025-10-10 03:24:52.798458+00	11	\N	\N	\N
2025-10-09 03:24:52.798458+00	2025-10-10 03:24:52.798458+00	\N	Cumple con los requisitos	187	1	26666666-6	8	28888888-8	\N	2025-09-09 03:24:52.798458+00	2025-10-09 03:24:52.798458+00	12	\N	\N	\N
2025-10-08 03:24:52.798458+00	2025-10-09 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	188	1	26666666-6	9	29999999-9	\N	2025-09-08 03:24:52.798458+00	2025-10-08 03:24:52.798458+00	13	\N	\N	\N
2025-10-07 03:24:52.798458+00	2025-10-08 03:24:52.798458+00	\N	\N	189	1	26666666-6	10	30101010-0	\N	2025-09-07 03:24:52.798458+00	2025-10-07 03:24:52.798458+00	14	\N	\N	\N
2025-10-06 03:24:52.798458+00	2025-10-07 03:24:52.798458+00	\N	Excelente trabajo y dedicación	190	1	26666666-6	11	31111111-1	\N	2025-09-06 03:24:52.798458+00	2025-10-06 03:24:52.798458+00	15	\N	\N	\N
2025-10-05 03:24:52.798458+00	2025-10-06 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	191	1	26666666-6	12	32222222-2	\N	2025-09-05 03:24:52.798458+00	2025-10-05 03:24:52.798458+00	16	\N	\N	\N
2025-10-04 03:24:52.798458+00	2025-10-05 03:24:52.798458+00	\N	Cumple con los requisitos	192	1	26666666-6	1	33333333-3	\N	2025-09-04 03:24:52.798458+00	2025-10-04 03:24:52.798458+00	17	\N	\N	\N
2025-10-03 03:24:52.798458+00	2025-10-04 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	193	1	26666666-6	2	34444444-4	\N	2025-09-03 03:24:52.798458+00	2025-10-03 03:24:52.798458+00	18	\N	\N	\N
2025-10-02 03:24:52.798458+00	2025-10-03 03:24:52.798458+00	\N	\N	194	1	26666666-6	3	35555555-5	\N	2025-09-02 03:24:52.798458+00	2025-10-02 03:24:52.798458+00	19	\N	\N	\N
2025-10-01 03:24:52.798458+00	2025-10-02 03:24:52.798458+00	\N	Excelente trabajo y dedicación	195	1	26666666-6	4	36666666-6	\N	2025-09-01 03:24:52.798458+00	2025-10-01 03:24:52.798458+00	20	\N	\N	\N
2025-09-30 03:24:52.798458+00	2025-10-01 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	196	1	26666666-6	5	37777777-7	\N	2025-08-31 03:24:52.798458+00	2025-09-30 03:24:52.798458+00	21	\N	\N	\N
2025-09-29 03:24:52.798458+00	2025-09-30 03:24:52.798458+00	\N	Cumple con los requisitos	197	1	26666666-6	6	38888888-8	\N	2025-08-30 03:24:52.798458+00	2025-09-29 03:24:52.798458+00	22	\N	\N	\N
2025-09-28 03:24:52.798458+00	2025-09-29 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	198	1	26666666-6	7	21111111-1	\N	2025-08-29 03:24:52.798458+00	2025-09-28 03:24:52.798458+00	23	\N	\N	\N
2025-09-27 03:24:52.798458+00	2025-09-28 03:24:52.798458+00	\N	\N	199	1	26666666-6	8	22222222-2	\N	2025-08-28 03:24:52.798458+00	2025-09-27 03:24:52.798458+00	24	\N	\N	\N
2025-09-26 03:24:52.798458+00	2025-09-27 03:24:52.798458+00	\N	Excelente trabajo y dedicación	200	1	26666666-6	9	23333333-3	\N	2025-08-27 03:24:52.798458+00	2025-09-26 03:24:52.798458+00	25	\N	\N	\N
2025-09-25 03:24:52.798458+00	2025-09-26 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	201	1	26666666-6	10	24444444-4	\N	2025-08-26 03:24:52.798458+00	2025-09-25 03:24:52.798458+00	26	\N	\N	\N
2025-09-24 03:24:52.798458+00	2025-09-25 03:24:52.798458+00	\N	Cumple con los requisitos	202	1	26666666-6	11	25555555-5	\N	2025-08-25 03:24:52.798458+00	2025-09-24 03:24:52.798458+00	27	\N	\N	\N
2025-09-23 03:24:52.798458+00	2025-09-24 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	203	1	26666666-6	12	26666666-6	\N	2025-08-24 03:24:52.798458+00	2025-09-23 03:24:52.798458+00	28	\N	\N	\N
2025-09-22 03:24:52.798458+00	2025-09-23 03:24:52.798458+00	\N	\N	204	1	26666666-6	1	27777777-7	\N	2025-08-23 03:24:52.798458+00	2025-09-22 03:24:52.798458+00	29	\N	\N	\N
2025-09-21 03:24:52.798458+00	2025-09-22 03:24:52.798458+00	\N	Excelente trabajo y dedicación	205	1	26666666-6	2	28888888-8	\N	2025-08-22 03:24:52.798458+00	2025-09-21 03:24:52.798458+00	30	\N	\N	\N
2025-09-20 03:24:52.798458+00	2025-09-21 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	206	1	26666666-6	3	29999999-9	\N	2025-08-21 03:24:52.798458+00	2025-09-20 03:24:52.798458+00	31	\N	\N	\N
2025-09-19 03:24:52.798458+00	2025-09-20 03:24:52.798458+00	\N	Cumple con los requisitos	207	1	26666666-6	4	30101010-0	\N	2025-08-20 03:24:52.798458+00	2025-09-19 03:24:52.798458+00	32	\N	\N	\N
2025-09-18 03:24:52.798458+00	2025-09-19 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	208	1	26666666-6	5	31111111-1	\N	2025-08-19 03:24:52.798458+00	2025-09-18 03:24:52.798458+00	33	\N	\N	\N
2025-09-17 03:24:52.798458+00	2025-09-18 03:24:52.798458+00	\N	\N	209	1	26666666-6	6	32222222-2	\N	2025-08-18 03:24:52.798458+00	2025-09-17 03:24:52.798458+00	34	\N	\N	\N
2025-09-16 03:24:52.798458+00	2025-09-17 03:24:52.798458+00	\N	Excelente trabajo y dedicación	210	1	26666666-6	7	33333333-3	\N	2025-08-17 03:24:52.798458+00	2025-09-16 03:24:52.798458+00	35	\N	\N	\N
2025-09-15 03:24:52.798458+00	2025-09-16 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	211	1	26666666-6	8	34444444-4	\N	2025-08-16 03:24:52.798458+00	2025-09-15 03:24:52.798458+00	36	\N	\N	\N
2025-09-14 03:24:52.798458+00	2025-09-15 03:24:52.798458+00	\N	Cumple con los requisitos	212	1	27777777-7	9	35555555-5	\N	2025-08-15 03:24:52.798458+00	2025-09-14 03:24:52.798458+00	37	\N	\N	\N
2025-09-13 03:24:52.798458+00	2025-09-14 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	213	1	27777777-7	10	36666666-6	\N	2025-08-14 03:24:52.798458+00	2025-09-13 03:24:52.798458+00	38	\N	\N	\N
2025-09-12 03:24:52.798458+00	2025-09-13 03:24:52.798458+00	\N	\N	214	1	27777777-7	11	37777777-7	\N	2025-08-13 03:24:52.798458+00	2025-09-12 03:24:52.798458+00	39	\N	\N	\N
2025-09-11 03:24:52.798458+00	2025-09-12 03:24:52.798458+00	\N	Excelente trabajo y dedicación	215	1	27777777-7	12	38888888-8	\N	2025-08-12 03:24:52.798458+00	2025-09-11 03:24:52.798458+00	40	\N	\N	\N
2025-09-10 03:24:52.798458+00	2025-09-11 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	216	1	27777777-7	1	21111111-1	\N	2025-08-11 03:24:52.798458+00	2025-09-10 03:24:52.798458+00	41	\N	\N	\N
2025-09-09 03:24:52.798458+00	2025-09-10 03:24:52.798458+00	\N	Cumple con los requisitos	217	1	27777777-7	2	22222222-2	\N	2025-08-10 03:24:52.798458+00	2025-09-09 03:24:52.798458+00	42	\N	\N	\N
2025-09-08 03:24:52.798458+00	2025-09-09 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	218	1	27777777-7	3	23333333-3	\N	2025-08-09 03:24:52.798458+00	2025-09-08 03:24:52.798458+00	43	\N	\N	\N
2025-09-07 03:24:52.798458+00	2025-09-08 03:24:52.798458+00	\N	\N	219	1	27777777-7	4	24444444-4	\N	2025-08-08 03:24:52.798458+00	2025-09-07 03:24:52.798458+00	44	\N	\N	\N
2025-09-06 03:24:52.798458+00	2025-09-07 03:24:52.798458+00	\N	Excelente trabajo y dedicación	220	1	27777777-7	5	25555555-5	\N	2025-08-07 03:24:52.798458+00	2025-09-06 03:24:52.798458+00	45	\N	\N	\N
2025-09-05 03:24:52.798458+00	2025-09-06 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	221	1	27777777-7	6	26666666-6	\N	2025-08-06 03:24:52.798458+00	2025-09-05 03:24:52.798458+00	46	\N	\N	\N
2025-09-04 03:24:52.798458+00	2025-09-05 03:24:52.798458+00	\N	Cumple con los requisitos	222	1	27777777-7	7	27777777-7	\N	2025-08-05 03:24:52.798458+00	2025-09-04 03:24:52.798458+00	47	\N	\N	\N
2025-09-03 03:24:52.798458+00	2025-09-04 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	223	1	27777777-7	8	28888888-8	\N	2025-08-04 03:24:52.798458+00	2025-09-03 03:24:52.798458+00	48	\N	\N	\N
2025-09-02 03:24:52.798458+00	2025-09-03 03:24:52.798458+00	\N	\N	224	1	27777777-7	9	29999999-9	\N	2025-08-03 03:24:52.798458+00	2025-09-02 03:24:52.798458+00	49	\N	\N	\N
2025-09-01 03:24:52.798458+00	2025-09-02 03:24:52.798458+00	\N	Excelente trabajo y dedicación	225	1	27777777-7	10	30101010-0	\N	2025-08-02 03:24:52.798458+00	2025-09-01 03:24:52.798458+00	5	\N	\N	\N
2025-08-31 03:24:52.798458+00	2025-09-01 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	226	1	27777777-7	11	31111111-1	\N	2025-08-01 03:24:52.798458+00	2025-08-31 03:24:52.798458+00	6	\N	\N	\N
2025-08-30 03:24:52.798458+00	2025-08-31 03:24:52.798458+00	\N	Cumple con los requisitos	227	1	27777777-7	12	32222222-2	\N	2025-07-31 03:24:52.798458+00	2025-08-30 03:24:52.798458+00	7	\N	\N	\N
2025-08-29 03:24:52.798458+00	2025-08-30 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	228	1	27777777-7	1	33333333-3	\N	2025-07-30 03:24:52.798458+00	2025-08-29 03:24:52.798458+00	8	\N	\N	\N
2025-08-28 03:24:52.798458+00	2025-08-29 03:24:52.798458+00	\N	\N	229	1	27777777-7	2	34444444-4	\N	2025-07-29 03:24:52.798458+00	2025-08-28 03:24:52.798458+00	9	\N	\N	\N
2025-08-27 03:24:52.798458+00	2025-08-28 03:24:52.798458+00	\N	Excelente trabajo y dedicación	230	1	27777777-7	3	35555555-5	\N	2025-07-28 03:24:52.798458+00	2025-08-27 03:24:52.798458+00	10	\N	\N	\N
2025-08-26 03:24:52.798458+00	2025-08-27 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	231	1	27777777-7	4	36666666-6	\N	2025-07-27 03:24:52.798458+00	2025-08-26 03:24:52.798458+00	11	\N	\N	\N
2025-08-25 03:24:52.798458+00	2025-08-26 03:24:52.798458+00	\N	Cumple con los requisitos	232	1	27777777-7	5	37777777-7	\N	2025-07-26 03:24:52.798458+00	2025-08-25 03:24:52.798458+00	12	\N	\N	\N
2025-08-24 03:24:52.798458+00	2025-08-25 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	233	1	27777777-7	6	38888888-8	\N	2025-07-25 03:24:52.798458+00	2025-08-24 03:24:52.798458+00	13	\N	\N	\N
2025-08-23 03:24:52.798458+00	2025-08-24 03:24:52.798458+00	\N	\N	234	1	27777777-7	7	21111111-1	\N	2025-07-24 03:24:52.798458+00	2025-08-23 03:24:52.798458+00	14	\N	\N	\N
2025-08-22 03:24:52.798458+00	2025-08-23 03:24:52.798458+00	\N	Excelente trabajo y dedicación	235	1	27777777-7	8	22222222-2	\N	2025-07-23 03:24:52.798458+00	2025-08-22 03:24:52.798458+00	15	\N	\N	\N
2025-08-21 03:24:52.798458+00	2025-08-22 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	236	1	27777777-7	9	23333333-3	\N	2025-07-22 03:24:52.798458+00	2025-08-21 03:24:52.798458+00	16	\N	\N	\N
2025-08-20 03:24:52.798458+00	2025-08-21 03:24:52.798458+00	\N	Cumple con los requisitos	237	1	28888888-8	10	24444444-4	\N	2025-07-21 03:24:52.798458+00	2025-08-20 03:24:52.798458+00	17	\N	\N	\N
2025-08-19 03:24:52.798458+00	2025-08-20 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	238	1	28888888-8	11	25555555-5	\N	2025-07-20 03:24:52.798458+00	2025-08-19 03:24:52.798458+00	18	\N	\N	\N
2025-08-18 03:24:52.798458+00	2025-08-19 03:24:52.798458+00	\N	\N	239	1	28888888-8	12	26666666-6	\N	2025-07-19 03:24:52.798458+00	2025-08-18 03:24:52.798458+00	19	\N	\N	\N
2025-08-17 03:24:52.798458+00	2025-08-18 03:24:52.798458+00	\N	Excelente trabajo y dedicación	240	1	28888888-8	1	27777777-7	\N	2025-07-18 03:24:52.798458+00	2025-08-17 03:24:52.798458+00	20	\N	\N	\N
2025-08-16 03:24:52.798458+00	2025-08-17 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	241	1	28888888-8	2	28888888-8	\N	2025-07-17 03:24:52.798458+00	2025-08-16 03:24:52.798458+00	21	\N	\N	\N
2025-08-15 03:24:52.798458+00	2025-08-16 03:24:52.798458+00	\N	Cumple con los requisitos	242	1	28888888-8	3	29999999-9	\N	2025-07-16 03:24:52.798458+00	2025-08-15 03:24:52.798458+00	22	\N	\N	\N
2025-08-14 03:24:52.798458+00	2025-08-15 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	243	1	28888888-8	4	30101010-0	\N	2025-07-15 03:24:52.798458+00	2025-08-14 03:24:52.798458+00	23	\N	\N	\N
2025-08-13 03:24:52.798458+00	2025-08-14 03:24:52.798458+00	\N	\N	244	1	28888888-8	5	31111111-1	\N	2025-07-14 03:24:52.798458+00	2025-08-13 03:24:52.798458+00	24	\N	\N	\N
2025-08-12 03:24:52.798458+00	2025-08-13 03:24:52.798458+00	\N	Excelente trabajo y dedicación	245	1	28888888-8	6	32222222-2	\N	2025-07-13 03:24:52.798458+00	2025-08-12 03:24:52.798458+00	25	\N	\N	\N
2025-08-11 03:24:52.798458+00	2025-08-12 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	246	1	28888888-8	7	33333333-3	\N	2025-07-12 03:24:52.798458+00	2025-08-11 03:24:52.798458+00	26	\N	\N	\N
2025-08-10 03:24:52.798458+00	2025-08-11 03:24:52.798458+00	\N	Cumple con los requisitos	247	1	28888888-8	8	34444444-4	\N	2025-07-11 03:24:52.798458+00	2025-08-10 03:24:52.798458+00	27	\N	\N	\N
2025-08-09 03:24:52.798458+00	2025-08-10 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	248	1	28888888-8	9	35555555-5	\N	2025-07-10 03:24:52.798458+00	2025-08-09 03:24:52.798458+00	28	\N	\N	\N
2025-08-08 03:24:52.798458+00	2025-08-09 03:24:52.798458+00	\N	\N	249	1	28888888-8	10	36666666-6	\N	2025-07-09 03:24:52.798458+00	2025-08-08 03:24:52.798458+00	29	\N	\N	\N
2025-08-07 03:24:52.798458+00	2025-08-08 03:24:52.798458+00	\N	Excelente trabajo y dedicación	250	1	28888888-8	11	37777777-7	\N	2025-07-08 03:24:52.798458+00	2025-08-07 03:24:52.798458+00	30	\N	\N	\N
2025-08-06 03:24:52.798458+00	2025-08-07 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	251	1	28888888-8	12	38888888-8	\N	2025-07-07 03:24:52.798458+00	2025-08-06 03:24:52.798458+00	31	\N	\N	\N
2025-08-05 03:24:52.798458+00	2025-08-06 03:24:52.798458+00	\N	Cumple con los requisitos	252	1	28888888-8	1	21111111-1	\N	2025-07-06 03:24:52.798458+00	2025-08-05 03:24:52.798458+00	32	\N	\N	\N
2025-08-04 03:24:52.798458+00	2025-08-05 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	253	1	28888888-8	2	22222222-2	\N	2025-07-05 03:24:52.798458+00	2025-08-04 03:24:52.798458+00	33	\N	\N	\N
2025-08-03 03:24:52.798458+00	2025-08-04 03:24:52.798458+00	\N	\N	254	1	28888888-8	3	23333333-3	\N	2025-07-04 03:24:52.798458+00	2025-08-03 03:24:52.798458+00	34	\N	\N	\N
2025-08-02 03:24:52.798458+00	2025-08-03 03:24:52.798458+00	\N	Excelente trabajo y dedicación	255	1	28888888-8	4	24444444-4	\N	2025-07-03 03:24:52.798458+00	2025-08-02 03:24:52.798458+00	35	\N	\N	\N
2025-08-01 03:24:52.798458+00	2025-08-02 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	256	1	28888888-8	5	25555555-5	\N	2025-07-02 03:24:52.798458+00	2025-08-01 03:24:52.798458+00	36	\N	\N	\N
2025-07-31 03:24:52.798458+00	2025-08-01 03:24:52.798458+00	\N	Cumple con los requisitos	257	1	28888888-8	6	26666666-6	\N	2025-07-01 03:24:52.798458+00	2025-07-31 03:24:52.798458+00	37	\N	\N	\N
2025-07-30 03:24:52.798458+00	2025-07-31 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	258	1	28888888-8	7	27777777-7	\N	2025-06-30 03:24:52.798458+00	2025-07-30 03:24:52.798458+00	38	\N	\N	\N
2025-07-29 03:24:52.798458+00	2025-07-30 03:24:52.798458+00	\N	\N	259	1	28888888-8	8	28888888-8	\N	2025-06-29 03:24:52.798458+00	2025-07-29 03:24:52.798458+00	39	\N	\N	\N
2025-07-28 03:24:52.798458+00	2025-07-29 03:24:52.798458+00	\N	Excelente trabajo y dedicación	260	1	28888888-8	9	29999999-9	\N	2025-06-28 03:24:52.798458+00	2025-07-28 03:24:52.798458+00	40	\N	\N	\N
2025-07-27 03:24:52.798458+00	2025-07-28 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	261	1	28888888-8	10	30101010-0	\N	2025-06-27 03:24:52.798458+00	2025-07-27 03:24:52.798458+00	41	\N	\N	\N
2025-07-26 03:24:52.798458+00	2025-07-27 03:24:52.798458+00	\N	Cumple con los requisitos	262	1	29999999-9	11	31111111-1	\N	2025-06-26 03:24:52.798458+00	2025-07-26 03:24:52.798458+00	42	\N	\N	\N
2025-07-25 03:24:52.798458+00	2025-07-26 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	263	1	29999999-9	12	32222222-2	\N	2025-06-25 03:24:52.798458+00	2025-07-25 03:24:52.798458+00	43	\N	\N	\N
2025-07-24 03:24:52.798458+00	2025-07-25 03:24:52.798458+00	\N	\N	264	1	29999999-9	1	33333333-3	\N	2025-06-24 03:24:52.798458+00	2025-07-24 03:24:52.798458+00	44	\N	\N	\N
2025-07-23 03:24:52.798458+00	2025-07-24 03:24:52.798458+00	\N	Excelente trabajo y dedicación	265	1	29999999-9	2	34444444-4	\N	2025-06-23 03:24:52.798458+00	2025-07-23 03:24:52.798458+00	45	\N	\N	\N
2025-07-22 03:24:52.798458+00	2025-07-23 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	266	1	29999999-9	3	35555555-5	\N	2025-06-22 03:24:52.798458+00	2025-07-22 03:24:52.798458+00	46	\N	\N	\N
2025-07-21 03:24:52.798458+00	2025-07-22 03:24:52.798458+00	\N	Cumple con los requisitos	267	1	29999999-9	4	36666666-6	\N	2025-06-21 03:24:52.798458+00	2025-07-21 03:24:52.798458+00	47	\N	\N	\N
2025-07-20 03:24:52.798458+00	2025-07-21 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	268	1	29999999-9	5	37777777-7	\N	2025-06-20 03:24:52.798458+00	2025-07-20 03:24:52.798458+00	48	\N	\N	\N
2025-07-19 03:24:52.798458+00	2025-07-20 03:24:52.798458+00	\N	\N	269	1	29999999-9	6	38888888-8	\N	2025-06-19 03:24:52.798458+00	2025-07-19 03:24:52.798458+00	49	\N	\N	\N
2025-07-18 03:24:52.798458+00	2025-07-19 03:24:52.798458+00	\N	Excelente trabajo y dedicación	270	1	29999999-9	7	21111111-1	\N	2025-06-18 03:24:52.798458+00	2025-07-18 03:24:52.798458+00	5	\N	\N	\N
2025-07-17 03:24:52.798458+00	2025-07-18 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	271	1	29999999-9	8	22222222-2	\N	2025-06-17 03:24:52.798458+00	2025-07-17 03:24:52.798458+00	6	\N	\N	\N
2025-07-16 03:24:52.798458+00	2025-07-17 03:24:52.798458+00	\N	Cumple con los requisitos	272	1	29999999-9	9	23333333-3	\N	2025-06-16 03:24:52.798458+00	2025-07-16 03:24:52.798458+00	7	\N	\N	\N
2025-07-15 03:24:52.798458+00	2025-07-16 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	273	1	29999999-9	10	24444444-4	\N	2025-06-15 03:24:52.798458+00	2025-07-15 03:24:52.798458+00	8	\N	\N	\N
2025-07-14 03:24:52.798458+00	2025-07-15 03:24:52.798458+00	\N	\N	274	1	29999999-9	11	25555555-5	\N	2025-06-14 03:24:52.798458+00	2025-07-14 03:24:52.798458+00	9	\N	\N	\N
2025-07-13 03:24:52.798458+00	2025-07-14 03:24:52.798458+00	\N	Excelente trabajo y dedicación	275	1	29999999-9	12	26666666-6	\N	2025-06-13 03:24:52.798458+00	2025-07-13 03:24:52.798458+00	10	\N	\N	\N
2025-07-12 03:24:52.798458+00	2025-07-13 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	276	1	29999999-9	1	27777777-7	\N	2025-06-12 03:24:52.798458+00	2025-07-12 03:24:52.798458+00	11	\N	\N	\N
2025-07-11 03:24:52.798458+00	2025-07-12 03:24:52.798458+00	\N	Cumple con los requisitos	277	1	29999999-9	2	28888888-8	\N	2025-06-11 03:24:52.798458+00	2025-07-11 03:24:52.798458+00	12	\N	\N	\N
2025-07-10 03:24:52.798458+00	2025-07-11 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	278	1	29999999-9	3	29999999-9	\N	2025-06-10 03:24:52.798458+00	2025-07-10 03:24:52.798458+00	13	\N	\N	\N
2025-07-09 03:24:52.798458+00	2025-07-10 03:24:52.798458+00	\N	\N	279	1	29999999-9	4	30101010-0	\N	2025-06-09 03:24:52.798458+00	2025-07-09 03:24:52.798458+00	14	\N	\N	\N
2025-07-08 03:24:52.798458+00	2025-07-09 03:24:52.798458+00	\N	Excelente trabajo y dedicación	280	1	29999999-9	5	31111111-1	\N	2025-06-08 03:24:52.798458+00	2025-07-08 03:24:52.798458+00	15	\N	\N	\N
2025-07-07 03:24:52.798458+00	2025-07-08 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	281	1	29999999-9	6	32222222-2	\N	2025-06-07 03:24:52.798458+00	2025-07-07 03:24:52.798458+00	16	\N	\N	\N
2025-07-06 03:24:52.798458+00	2025-07-07 03:24:52.798458+00	\N	Cumple con los requisitos	282	1	29999999-9	7	33333333-3	\N	2025-06-06 03:24:52.798458+00	2025-07-06 03:24:52.798458+00	17	\N	\N	\N
2025-07-05 03:24:52.798458+00	2025-07-06 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	283	1	29999999-9	8	34444444-4	\N	2025-06-05 03:24:52.798458+00	2025-07-05 03:24:52.798458+00	18	\N	\N	\N
2025-07-04 03:24:52.798458+00	2025-07-05 03:24:52.798458+00	\N	\N	284	1	29999999-9	9	35555555-5	\N	2025-06-04 03:24:52.798458+00	2025-07-04 03:24:52.798458+00	19	\N	\N	\N
2025-07-03 03:24:52.798458+00	2025-07-04 03:24:52.798458+00	\N	Excelente trabajo y dedicación	285	1	29999999-9	10	36666666-6	\N	2025-06-03 03:24:52.798458+00	2025-07-03 03:24:52.798458+00	20	\N	\N	\N
2025-07-02 03:24:52.798458+00	2025-07-03 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	286	1	29999999-9	11	37777777-7	\N	2025-06-02 03:24:52.798458+00	2025-07-02 03:24:52.798458+00	21	\N	\N	\N
2025-07-01 03:24:52.798458+00	2025-07-02 03:24:52.798458+00	\N	Cumple con los requisitos	287	1	30101010-0	12	38888888-8	\N	2025-06-01 03:24:52.798458+00	2025-07-01 03:24:52.798458+00	22	\N	\N	\N
2025-06-30 03:24:52.798458+00	2025-07-01 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	288	1	30101010-0	1	21111111-1	\N	2025-05-31 03:24:52.798458+00	2025-06-30 03:24:52.798458+00	23	\N	\N	\N
2025-06-29 03:24:52.798458+00	2025-06-30 03:24:52.798458+00	\N	\N	289	1	30101010-0	2	22222222-2	\N	2025-05-30 03:24:52.798458+00	2025-06-29 03:24:52.798458+00	24	\N	\N	\N
2025-06-28 03:24:52.798458+00	2025-06-29 03:24:52.798458+00	\N	Excelente trabajo y dedicación	290	1	30101010-0	3	23333333-3	\N	2025-05-29 03:24:52.798458+00	2025-06-28 03:24:52.798458+00	25	\N	\N	\N
2025-06-27 03:24:52.798458+00	2025-06-28 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	291	1	30101010-0	4	24444444-4	\N	2025-05-28 03:24:52.798458+00	2025-06-27 03:24:52.798458+00	26	\N	\N	\N
2025-06-26 03:24:52.798458+00	2025-06-27 03:24:52.798458+00	\N	Cumple con los requisitos	292	1	30101010-0	5	25555555-5	\N	2025-05-27 03:24:52.798458+00	2025-06-26 03:24:52.798458+00	27	\N	\N	\N
2025-06-25 03:24:52.798458+00	2025-06-26 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	293	1	30101010-0	6	26666666-6	\N	2025-05-26 03:24:52.798458+00	2025-06-25 03:24:52.798458+00	28	\N	\N	\N
2025-06-24 03:24:52.798458+00	2025-06-25 03:24:52.798458+00	\N	\N	294	1	30101010-0	7	27777777-7	\N	2025-05-25 03:24:52.798458+00	2025-06-24 03:24:52.798458+00	29	\N	\N	\N
2025-06-23 03:24:52.798458+00	2025-06-24 03:24:52.798458+00	\N	Excelente trabajo y dedicación	295	1	30101010-0	8	28888888-8	\N	2025-05-24 03:24:52.798458+00	2025-06-23 03:24:52.798458+00	30	\N	\N	\N
2025-06-22 03:24:52.798458+00	2025-06-23 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	296	1	30101010-0	9	29999999-9	\N	2025-05-23 03:24:52.798458+00	2025-06-22 03:24:52.798458+00	31	\N	\N	\N
2025-06-21 03:24:52.798458+00	2025-06-22 03:24:52.798458+00	\N	Cumple con los requisitos	297	1	30101010-0	10	30101010-0	\N	2025-05-22 03:24:52.798458+00	2025-06-21 03:24:52.798458+00	32	\N	\N	\N
2025-06-20 03:24:52.798458+00	2025-06-21 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	298	1	30101010-0	11	31111111-1	\N	2025-05-21 03:24:52.798458+00	2025-06-20 03:24:52.798458+00	33	\N	\N	\N
2025-06-19 03:24:52.798458+00	2025-06-20 03:24:52.798458+00	\N	\N	299	1	30101010-0	12	32222222-2	\N	2025-05-20 03:24:52.798458+00	2025-06-19 03:24:52.798458+00	34	\N	\N	\N
2025-11-15 03:24:52.798458+00	2025-11-16 03:24:52.798458+00	\N	Excelente trabajo y dedicación	300	1	30101010-0	1	33333333-3	\N	2025-10-16 03:24:52.798458+00	2025-11-15 03:24:52.798458+00	35	\N	\N	\N
2025-11-14 03:24:52.798458+00	2025-11-15 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	301	1	30101010-0	2	34444444-4	\N	2025-10-15 03:24:52.798458+00	2025-11-14 03:24:52.798458+00	36	\N	\N	\N
2025-11-13 03:24:52.798458+00	2025-11-14 03:24:52.798458+00	\N	Cumple con los requisitos	302	1	30101010-0	3	35555555-5	\N	2025-10-14 03:24:52.798458+00	2025-11-13 03:24:52.798458+00	37	\N	\N	\N
2025-11-12 03:24:52.798458+00	2025-11-13 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	303	1	30101010-0	4	36666666-6	\N	2025-10-13 03:24:52.798458+00	2025-11-12 03:24:52.798458+00	38	\N	\N	\N
2025-11-11 03:24:52.798458+00	2025-11-12 03:24:52.798458+00	\N	\N	304	1	30101010-0	5	37777777-7	\N	2025-10-12 03:24:52.798458+00	2025-11-11 03:24:52.798458+00	39	\N	\N	\N
2025-11-10 03:24:52.798458+00	2025-11-11 03:24:52.798458+00	\N	Excelente trabajo y dedicación	305	1	30101010-0	6	38888888-8	\N	2025-10-11 03:24:52.798458+00	2025-11-10 03:24:52.798458+00	40	\N	\N	\N
2025-11-09 03:24:52.798458+00	2025-11-10 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	306	1	30101010-0	7	21111111-1	\N	2025-10-10 03:24:52.798458+00	2025-11-09 03:24:52.798458+00	41	\N	\N	\N
2025-11-08 03:24:52.798458+00	2025-11-09 03:24:52.798458+00	\N	Cumple con los requisitos	307	1	30101010-0	8	22222222-2	\N	2025-10-09 03:24:52.798458+00	2025-11-08 03:24:52.798458+00	42	\N	\N	\N
2025-11-07 03:24:52.798458+00	2025-11-08 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	308	1	30101010-0	9	23333333-3	\N	2025-10-08 03:24:52.798458+00	2025-11-07 03:24:52.798458+00	43	\N	\N	\N
2025-11-06 03:24:52.798458+00	2025-11-07 03:24:52.798458+00	\N	\N	309	1	30101010-0	10	24444444-4	\N	2025-10-07 03:24:52.798458+00	2025-11-06 03:24:52.798458+00	44	\N	\N	\N
2025-11-05 03:24:52.798458+00	2025-11-06 03:24:52.798458+00	\N	Excelente trabajo y dedicación	310	1	30101010-0	11	25555555-5	\N	2025-10-06 03:24:52.798458+00	2025-11-05 03:24:52.798458+00	45	\N	\N	\N
2025-11-04 03:24:52.798458+00	2025-11-05 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	311	1	30101010-0	12	26666666-6	\N	2025-10-05 03:24:52.798458+00	2025-11-04 03:24:52.798458+00	46	\N	\N	\N
2025-11-03 03:24:52.798458+00	2025-11-04 03:24:52.798458+00	\N	Cumple con los requisitos	312	1	11111111-1	1	27777777-7	\N	2025-10-04 03:24:52.798458+00	2025-11-03 03:24:52.798458+00	47	\N	\N	\N
2025-11-02 03:24:52.798458+00	2025-11-03 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	313	1	11111111-1	2	28888888-8	\N	2025-10-03 03:24:52.798458+00	2025-11-02 03:24:52.798458+00	48	\N	\N	\N
2025-11-01 03:24:52.798458+00	2025-11-02 03:24:52.798458+00	\N	\N	314	1	11111111-1	3	29999999-9	\N	2025-10-02 03:24:52.798458+00	2025-11-01 03:24:52.798458+00	49	\N	\N	\N
2025-10-31 03:24:52.798458+00	2025-11-01 03:24:52.798458+00	\N	Excelente trabajo y dedicación	315	1	11111111-1	4	30101010-0	\N	2025-10-01 03:24:52.798458+00	2025-10-31 03:24:52.798458+00	5	\N	\N	\N
2025-10-30 03:24:52.798458+00	2025-10-31 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	316	1	11111111-1	5	31111111-1	\N	2025-09-30 03:24:52.798458+00	2025-10-30 03:24:52.798458+00	6	\N	\N	\N
2025-10-29 03:24:52.798458+00	2025-10-30 03:24:52.798458+00	\N	Cumple con los requisitos	317	1	11111111-1	6	32222222-2	\N	2025-09-29 03:24:52.798458+00	2025-10-29 03:24:52.798458+00	7	\N	\N	\N
2025-10-28 03:24:52.798458+00	2025-10-29 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	318	1	11111111-1	7	33333333-3	\N	2025-09-28 03:24:52.798458+00	2025-10-28 03:24:52.798458+00	8	\N	\N	\N
2025-10-27 03:24:52.798458+00	2025-10-28 03:24:52.798458+00	\N	\N	319	1	11111111-1	8	34444444-4	\N	2025-09-27 03:24:52.798458+00	2025-10-27 03:24:52.798458+00	9	\N	\N	\N
2025-10-26 03:24:52.798458+00	2025-10-27 03:24:52.798458+00	\N	Excelente trabajo y dedicación	320	1	11111111-1	9	35555555-5	\N	2025-09-26 03:24:52.798458+00	2025-10-26 03:24:52.798458+00	10	\N	\N	\N
2025-10-25 03:24:52.798458+00	2025-10-26 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	321	1	11111111-1	10	36666666-6	\N	2025-09-25 03:24:52.798458+00	2025-10-25 03:24:52.798458+00	11	\N	\N	\N
2025-10-24 03:24:52.798458+00	2025-10-25 03:24:52.798458+00	\N	Cumple con los requisitos	322	1	11111111-1	11	37777777-7	\N	2025-09-24 03:24:52.798458+00	2025-10-24 03:24:52.798458+00	12	\N	\N	\N
2025-10-23 03:24:52.798458+00	2025-10-24 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	323	1	11111111-1	12	38888888-8	\N	2025-09-23 03:24:52.798458+00	2025-10-23 03:24:52.798458+00	13	\N	\N	\N
2025-10-22 03:24:52.798458+00	2025-10-23 03:24:52.798458+00	\N	\N	324	1	11111111-1	1	21111111-1	\N	2025-09-22 03:24:52.798458+00	2025-10-22 03:24:52.798458+00	14	\N	\N	\N
2025-10-21 03:24:52.798458+00	2025-10-22 03:24:52.798458+00	\N	Excelente trabajo y dedicación	325	1	11111111-1	2	22222222-2	\N	2025-09-21 03:24:52.798458+00	2025-10-21 03:24:52.798458+00	15	\N	\N	\N
2025-10-20 03:24:52.798458+00	2025-10-21 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	326	1	11111111-1	3	23333333-3	\N	2025-09-20 03:24:52.798458+00	2025-10-20 03:24:52.798458+00	16	\N	\N	\N
2025-10-19 03:24:52.798458+00	2025-10-20 03:24:52.798458+00	\N	Cumple con los requisitos	327	1	11111111-1	4	24444444-4	\N	2025-09-19 03:24:52.798458+00	2025-10-19 03:24:52.798458+00	17	\N	\N	\N
2025-10-18 03:24:52.798458+00	2025-10-19 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	328	1	11111111-1	5	25555555-5	\N	2025-09-18 03:24:52.798458+00	2025-10-18 03:24:52.798458+00	18	\N	\N	\N
2025-10-17 03:24:52.798458+00	2025-10-18 03:24:52.798458+00	\N	\N	329	1	11111111-1	6	26666666-6	\N	2025-09-17 03:24:52.798458+00	2025-10-17 03:24:52.798458+00	19	\N	\N	\N
2025-10-16 03:24:52.798458+00	2025-10-17 03:24:52.798458+00	\N	Excelente trabajo y dedicación	330	1	11111111-1	7	27777777-7	\N	2025-09-16 03:24:52.798458+00	2025-10-16 03:24:52.798458+00	20	\N	\N	\N
2025-10-15 03:24:52.798458+00	2025-10-16 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	331	1	11111111-1	8	28888888-8	\N	2025-09-15 03:24:52.798458+00	2025-10-15 03:24:52.798458+00	21	\N	\N	\N
2025-10-14 03:24:52.798458+00	2025-10-15 03:24:52.798458+00	\N	Cumple con los requisitos	332	1	11111111-1	9	29999999-9	\N	2025-09-14 03:24:52.798458+00	2025-10-14 03:24:52.798458+00	22	\N	\N	\N
2025-10-13 03:24:52.798458+00	2025-10-14 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	333	1	11111111-1	10	30101010-0	\N	2025-09-13 03:24:52.798458+00	2025-10-13 03:24:52.798458+00	23	\N	\N	\N
2025-10-12 03:24:52.798458+00	2025-10-13 03:24:52.798458+00	\N	\N	334	1	11111111-1	11	31111111-1	\N	2025-09-12 03:24:52.798458+00	2025-10-12 03:24:52.798458+00	24	\N	\N	\N
2025-10-11 03:24:52.798458+00	2025-10-12 03:24:52.798458+00	\N	Excelente trabajo y dedicación	335	1	11111111-1	12	32222222-2	\N	2025-09-11 03:24:52.798458+00	2025-10-11 03:24:52.798458+00	25	\N	\N	\N
2025-10-10 03:24:52.798458+00	2025-10-11 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	336	1	11111111-1	1	33333333-3	\N	2025-09-10 03:24:52.798458+00	2025-10-10 03:24:52.798458+00	26	\N	\N	\N
2025-10-09 03:24:52.798458+00	2025-10-10 03:24:52.798458+00	\N	Cumple con los requisitos	337	1	19999999-9	2	34444444-4	\N	2025-09-09 03:24:52.798458+00	2025-10-09 03:24:52.798458+00	27	\N	\N	\N
2025-10-08 03:24:52.798458+00	2025-10-09 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	338	1	19999999-9	3	35555555-5	\N	2025-09-08 03:24:52.798458+00	2025-10-08 03:24:52.798458+00	28	\N	\N	\N
2025-10-07 03:24:52.798458+00	2025-10-08 03:24:52.798458+00	\N	\N	339	1	19999999-9	4	36666666-6	\N	2025-09-07 03:24:52.798458+00	2025-10-07 03:24:52.798458+00	29	\N	\N	\N
2025-10-06 03:24:52.798458+00	2025-10-07 03:24:52.798458+00	\N	Excelente trabajo y dedicación	340	1	19999999-9	5	37777777-7	\N	2025-09-06 03:24:52.798458+00	2025-10-06 03:24:52.798458+00	30	\N	\N	\N
2025-10-05 03:24:52.798458+00	2025-10-06 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	341	1	19999999-9	6	38888888-8	\N	2025-09-05 03:24:52.798458+00	2025-10-05 03:24:52.798458+00	31	\N	\N	\N
2025-10-04 03:24:52.798458+00	2025-10-05 03:24:52.798458+00	\N	Cumple con los requisitos	342	1	19999999-9	7	21111111-1	\N	2025-09-04 03:24:52.798458+00	2025-10-04 03:24:52.798458+00	32	\N	\N	\N
2025-10-03 03:24:52.798458+00	2025-10-04 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	343	1	19999999-9	8	22222222-2	\N	2025-09-03 03:24:52.798458+00	2025-10-03 03:24:52.798458+00	33	\N	\N	\N
2025-10-02 03:24:52.798458+00	2025-10-03 03:24:52.798458+00	\N	\N	344	1	19999999-9	9	23333333-3	\N	2025-09-02 03:24:52.798458+00	2025-10-02 03:24:52.798458+00	34	\N	\N	\N
2025-10-01 03:24:52.798458+00	2025-10-02 03:24:52.798458+00	\N	Excelente trabajo y dedicación	345	1	19999999-9	10	24444444-4	\N	2025-09-01 03:24:52.798458+00	2025-10-01 03:24:52.798458+00	35	\N	\N	\N
2025-09-30 03:24:52.798458+00	2025-10-01 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	346	1	19999999-9	11	25555555-5	\N	2025-08-31 03:24:52.798458+00	2025-09-30 03:24:52.798458+00	36	\N	\N	\N
2025-09-29 03:24:52.798458+00	2025-09-30 03:24:52.798458+00	\N	Cumple con los requisitos	347	1	19999999-9	12	26666666-6	\N	2025-08-30 03:24:52.798458+00	2025-09-29 03:24:52.798458+00	37	\N	\N	\N
2025-09-28 03:24:52.798458+00	2025-09-29 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	348	1	19999999-9	1	27777777-7	\N	2025-08-29 03:24:52.798458+00	2025-09-28 03:24:52.798458+00	38	\N	\N	\N
2025-09-27 03:24:52.798458+00	2025-09-28 03:24:52.798458+00	\N	\N	349	1	19999999-9	2	28888888-8	\N	2025-08-28 03:24:52.798458+00	2025-09-27 03:24:52.798458+00	39	\N	\N	\N
2025-09-26 03:24:52.798458+00	2025-09-27 03:24:52.798458+00	\N	Excelente trabajo y dedicación	350	1	19999999-9	3	29999999-9	\N	2025-08-27 03:24:52.798458+00	2025-09-26 03:24:52.798458+00	40	\N	\N	\N
2025-09-25 03:24:52.798458+00	2025-09-26 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	351	1	19999999-9	4	30101010-0	\N	2025-08-26 03:24:52.798458+00	2025-09-25 03:24:52.798458+00	41	\N	\N	\N
2025-09-24 03:24:52.798458+00	2025-09-25 03:24:52.798458+00	\N	Cumple con los requisitos	352	1	19999999-9	5	31111111-1	\N	2025-08-25 03:24:52.798458+00	2025-09-24 03:24:52.798458+00	42	\N	\N	\N
2025-09-23 03:24:52.798458+00	2025-09-24 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	353	1	19999999-9	6	32222222-2	\N	2025-08-24 03:24:52.798458+00	2025-09-23 03:24:52.798458+00	43	\N	\N	\N
2025-09-22 03:24:52.798458+00	2025-09-23 03:24:52.798458+00	\N	\N	354	1	19999999-9	7	33333333-3	\N	2025-08-23 03:24:52.798458+00	2025-09-22 03:24:52.798458+00	44	\N	\N	\N
2025-09-21 03:24:52.798458+00	2025-09-22 03:24:52.798458+00	\N	Excelente trabajo y dedicación	355	1	19999999-9	8	34444444-4	\N	2025-08-22 03:24:52.798458+00	2025-09-21 03:24:52.798458+00	45	\N	\N	\N
2025-09-20 03:24:52.798458+00	2025-09-21 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	356	1	19999999-9	9	35555555-5	\N	2025-08-21 03:24:52.798458+00	2025-09-20 03:24:52.798458+00	46	\N	\N	\N
2025-09-19 03:24:52.798458+00	2025-09-20 03:24:52.798458+00	\N	Cumple con los requisitos	357	1	19999999-9	10	36666666-6	\N	2025-08-20 03:24:52.798458+00	2025-09-19 03:24:52.798458+00	47	\N	\N	\N
2025-09-18 03:24:52.798458+00	2025-09-19 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	358	1	19999999-9	11	37777777-7	\N	2025-08-19 03:24:52.798458+00	2025-09-18 03:24:52.798458+00	48	\N	\N	\N
2025-09-17 03:24:52.798458+00	2025-09-18 03:24:52.798458+00	\N	\N	359	1	19999999-9	12	38888888-8	\N	2025-08-18 03:24:52.798458+00	2025-09-17 03:24:52.798458+00	49	\N	\N	\N
2025-09-16 03:24:52.798458+00	2025-09-17 03:24:52.798458+00	\N	Excelente trabajo y dedicación	360	1	19999999-9	1	21111111-1	\N	2025-08-17 03:24:52.798458+00	2025-09-16 03:24:52.798458+00	5	\N	\N	\N
2025-09-15 03:24:52.798458+00	2025-09-16 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	361	1	19999999-9	2	22222222-2	\N	2025-08-16 03:24:52.798458+00	2025-09-15 03:24:52.798458+00	6	\N	\N	\N
2025-09-14 03:24:52.798458+00	2025-09-15 03:24:52.798458+00	\N	Cumple con los requisitos	362	1	20101010-0	3	23333333-3	\N	2025-08-15 03:24:52.798458+00	2025-09-14 03:24:52.798458+00	7	\N	\N	\N
2025-09-13 03:24:52.798458+00	2025-09-14 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	363	1	20101010-0	4	24444444-4	\N	2025-08-14 03:24:52.798458+00	2025-09-13 03:24:52.798458+00	8	\N	\N	\N
2025-09-12 03:24:52.798458+00	2025-09-13 03:24:52.798458+00	\N	\N	364	1	20101010-0	5	25555555-5	\N	2025-08-13 03:24:52.798458+00	2025-09-12 03:24:52.798458+00	9	\N	\N	\N
2025-09-11 03:24:52.798458+00	2025-09-12 03:24:52.798458+00	\N	Excelente trabajo y dedicación	365	1	20101010-0	6	26666666-6	\N	2025-08-12 03:24:52.798458+00	2025-09-11 03:24:52.798458+00	10	\N	\N	\N
2025-09-10 03:24:52.798458+00	2025-09-11 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	366	1	20101010-0	7	27777777-7	\N	2025-08-11 03:24:52.798458+00	2025-09-10 03:24:52.798458+00	11	\N	\N	\N
2025-09-09 03:24:52.798458+00	2025-09-10 03:24:52.798458+00	\N	Cumple con los requisitos	367	1	20101010-0	8	28888888-8	\N	2025-08-10 03:24:52.798458+00	2025-09-09 03:24:52.798458+00	12	\N	\N	\N
2025-09-08 03:24:52.798458+00	2025-09-09 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	368	1	20101010-0	9	29999999-9	\N	2025-08-09 03:24:52.798458+00	2025-09-08 03:24:52.798458+00	13	\N	\N	\N
2025-09-07 03:24:52.798458+00	2025-09-08 03:24:52.798458+00	\N	\N	369	1	20101010-0	10	30101010-0	\N	2025-08-08 03:24:52.798458+00	2025-09-07 03:24:52.798458+00	14	\N	\N	\N
2025-09-06 03:24:52.798458+00	2025-09-07 03:24:52.798458+00	\N	Excelente trabajo y dedicación	370	1	20101010-0	11	31111111-1	\N	2025-08-07 03:24:52.798458+00	2025-09-06 03:24:52.798458+00	15	\N	\N	\N
2025-09-05 03:24:52.798458+00	2025-09-06 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	371	1	20101010-0	12	32222222-2	\N	2025-08-06 03:24:52.798458+00	2025-09-05 03:24:52.798458+00	16	\N	\N	\N
2025-09-04 03:24:52.798458+00	2025-09-05 03:24:52.798458+00	\N	Cumple con los requisitos	372	1	20101010-0	1	33333333-3	\N	2025-08-05 03:24:52.798458+00	2025-09-04 03:24:52.798458+00	17	\N	\N	\N
2025-09-03 03:24:52.798458+00	2025-09-04 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	373	1	20101010-0	2	34444444-4	\N	2025-08-04 03:24:52.798458+00	2025-09-03 03:24:52.798458+00	18	\N	\N	\N
2025-09-02 03:24:52.798458+00	2025-09-03 03:24:52.798458+00	\N	\N	374	1	20101010-0	3	35555555-5	\N	2025-08-03 03:24:52.798458+00	2025-09-02 03:24:52.798458+00	19	\N	\N	\N
2025-09-01 03:24:52.798458+00	2025-09-02 03:24:52.798458+00	\N	Excelente trabajo y dedicación	375	1	20101010-0	4	36666666-6	\N	2025-08-02 03:24:52.798458+00	2025-09-01 03:24:52.798458+00	20	\N	\N	\N
2025-08-31 03:24:52.798458+00	2025-09-01 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	376	1	20101010-0	5	37777777-7	\N	2025-08-01 03:24:52.798458+00	2025-08-31 03:24:52.798458+00	21	\N	\N	\N
2025-08-30 03:24:52.798458+00	2025-08-31 03:24:52.798458+00	\N	Cumple con los requisitos	377	1	20101010-0	6	38888888-8	\N	2025-07-31 03:24:52.798458+00	2025-08-30 03:24:52.798458+00	22	\N	\N	\N
2025-08-29 03:24:52.798458+00	2025-08-30 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	378	1	20101010-0	7	21111111-1	\N	2025-07-30 03:24:52.798458+00	2025-08-29 03:24:52.798458+00	23	\N	\N	\N
2025-08-28 03:24:52.798458+00	2025-08-29 03:24:52.798458+00	\N	\N	379	1	20101010-0	8	22222222-2	\N	2025-07-29 03:24:52.798458+00	2025-08-28 03:24:52.798458+00	24	\N	\N	\N
2025-08-27 03:24:52.798458+00	2025-08-28 03:24:52.798458+00	\N	Excelente trabajo y dedicación	380	1	20101010-0	9	23333333-3	\N	2025-07-28 03:24:52.798458+00	2025-08-27 03:24:52.798458+00	25	\N	\N	\N
2025-08-26 03:24:52.798458+00	2025-08-27 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	381	1	20101010-0	10	24444444-4	\N	2025-07-27 03:24:52.798458+00	2025-08-26 03:24:52.798458+00	26	\N	\N	\N
2025-08-25 03:24:52.798458+00	2025-08-26 03:24:52.798458+00	\N	Cumple con los requisitos	382	1	20101010-0	11	25555555-5	\N	2025-07-26 03:24:52.798458+00	2025-08-25 03:24:52.798458+00	27	\N	\N	\N
2025-08-24 03:24:52.798458+00	2025-08-25 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	383	1	20101010-0	12	26666666-6	\N	2025-07-25 03:24:52.798458+00	2025-08-24 03:24:52.798458+00	28	\N	\N	\N
2025-08-23 03:24:52.798458+00	2025-08-24 03:24:52.798458+00	\N	\N	384	1	20101010-0	1	27777777-7	\N	2025-07-24 03:24:52.798458+00	2025-08-23 03:24:52.798458+00	29	\N	\N	\N
2025-08-22 03:24:52.798458+00	2025-08-23 03:24:52.798458+00	\N	Excelente trabajo y dedicación	385	1	20101010-0	2	28888888-8	\N	2025-07-23 03:24:52.798458+00	2025-08-22 03:24:52.798458+00	30	\N	\N	\N
2025-08-21 03:24:52.798458+00	2025-08-22 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	386	1	20101010-0	3	29999999-9	\N	2025-07-22 03:24:52.798458+00	2025-08-21 03:24:52.798458+00	31	\N	\N	\N
2025-08-20 03:24:52.798458+00	2025-08-21 03:24:52.798458+00	\N	Cumple con los requisitos	387	1	21111111-1	4	30101010-0	\N	2025-07-21 03:24:52.798458+00	2025-08-20 03:24:52.798458+00	32	\N	\N	\N
2025-08-19 03:24:52.798458+00	2025-08-20 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	388	1	21111111-1	5	31111111-1	\N	2025-07-20 03:24:52.798458+00	2025-08-19 03:24:52.798458+00	33	\N	\N	\N
2025-08-18 03:24:52.798458+00	2025-08-19 03:24:52.798458+00	\N	\N	389	1	21111111-1	6	32222222-2	\N	2025-07-19 03:24:52.798458+00	2025-08-18 03:24:52.798458+00	34	\N	\N	\N
2025-08-17 03:24:52.798458+00	2025-08-18 03:24:52.798458+00	\N	Excelente trabajo y dedicación	390	1	21111111-1	7	33333333-3	\N	2025-07-18 03:24:52.798458+00	2025-08-17 03:24:52.798458+00	35	\N	\N	\N
2025-08-16 03:24:52.798458+00	2025-08-17 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	391	1	21111111-1	8	34444444-4	\N	2025-07-17 03:24:52.798458+00	2025-08-16 03:24:52.798458+00	36	\N	\N	\N
2025-08-15 03:24:52.798458+00	2025-08-16 03:24:52.798458+00	\N	Cumple con los requisitos	392	1	21111111-1	9	35555555-5	\N	2025-07-16 03:24:52.798458+00	2025-08-15 03:24:52.798458+00	37	\N	\N	\N
2025-08-14 03:24:52.798458+00	2025-08-15 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	393	1	21111111-1	10	36666666-6	\N	2025-07-15 03:24:52.798458+00	2025-08-14 03:24:52.798458+00	38	\N	\N	\N
2025-08-13 03:24:52.798458+00	2025-08-14 03:24:52.798458+00	\N	\N	394	1	21111111-1	11	37777777-7	\N	2025-07-14 03:24:52.798458+00	2025-08-13 03:24:52.798458+00	39	\N	\N	\N
2025-08-12 03:24:52.798458+00	2025-08-13 03:24:52.798458+00	\N	Excelente trabajo y dedicación	395	1	21111111-1	12	38888888-8	\N	2025-07-13 03:24:52.798458+00	2025-08-12 03:24:52.798458+00	40	\N	\N	\N
2025-08-11 03:24:52.798458+00	2025-08-12 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	396	1	21111111-1	1	21111111-1	\N	2025-07-12 03:24:52.798458+00	2025-08-11 03:24:52.798458+00	41	\N	\N	\N
2025-08-10 03:24:52.798458+00	2025-08-11 03:24:52.798458+00	\N	Cumple con los requisitos	397	1	21111111-1	2	22222222-2	\N	2025-07-11 03:24:52.798458+00	2025-08-10 03:24:52.798458+00	42	\N	\N	\N
2025-08-09 03:24:52.798458+00	2025-08-10 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	398	1	21111111-1	3	23333333-3	\N	2025-07-10 03:24:52.798458+00	2025-08-09 03:24:52.798458+00	43	\N	\N	\N
2025-08-08 03:24:52.798458+00	2025-08-09 03:24:52.798458+00	\N	\N	399	1	21111111-1	4	24444444-4	\N	2025-07-09 03:24:52.798458+00	2025-08-08 03:24:52.798458+00	44	\N	\N	\N
2025-08-07 03:24:52.798458+00	2025-08-08 03:24:52.798458+00	\N	Excelente trabajo y dedicación	400	1	21111111-1	5	25555555-5	\N	2025-07-08 03:24:52.798458+00	2025-08-07 03:24:52.798458+00	45	\N	\N	\N
2025-08-06 03:24:52.798458+00	2025-08-07 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	401	1	21111111-1	6	26666666-6	\N	2025-07-07 03:24:52.798458+00	2025-08-06 03:24:52.798458+00	46	\N	\N	\N
2025-08-05 03:24:52.798458+00	2025-08-06 03:24:52.798458+00	\N	Cumple con los requisitos	402	1	21111111-1	7	27777777-7	\N	2025-07-06 03:24:52.798458+00	2025-08-05 03:24:52.798458+00	47	\N	\N	\N
2025-08-04 03:24:52.798458+00	2025-08-05 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	403	1	21111111-1	8	28888888-8	\N	2025-07-05 03:24:52.798458+00	2025-08-04 03:24:52.798458+00	48	\N	\N	\N
2025-08-03 03:24:52.798458+00	2025-08-04 03:24:52.798458+00	\N	\N	404	1	21111111-1	9	29999999-9	\N	2025-07-04 03:24:52.798458+00	2025-08-03 03:24:52.798458+00	49	\N	\N	\N
2025-08-02 03:24:52.798458+00	2025-08-03 03:24:52.798458+00	\N	Excelente trabajo y dedicación	405	1	21111111-1	10	30101010-0	\N	2025-07-03 03:24:52.798458+00	2025-08-02 03:24:52.798458+00	5	\N	\N	\N
2025-08-01 03:24:52.798458+00	2025-08-02 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	406	1	21111111-1	11	31111111-1	\N	2025-07-02 03:24:52.798458+00	2025-08-01 03:24:52.798458+00	6	\N	\N	\N
2025-07-31 03:24:52.798458+00	2025-08-01 03:24:52.798458+00	\N	Cumple con los requisitos	407	1	21111111-1	12	32222222-2	\N	2025-07-01 03:24:52.798458+00	2025-07-31 03:24:52.798458+00	7	\N	\N	\N
2025-07-30 03:24:52.798458+00	2025-07-31 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	408	1	21111111-1	1	33333333-3	\N	2025-06-30 03:24:52.798458+00	2025-07-30 03:24:52.798458+00	8	\N	\N	\N
2025-07-29 03:24:52.798458+00	2025-07-30 03:24:52.798458+00	\N	\N	409	1	21111111-1	2	34444444-4	\N	2025-06-29 03:24:52.798458+00	2025-07-29 03:24:52.798458+00	9	\N	\N	\N
2025-07-28 03:24:52.798458+00	2025-07-29 03:24:52.798458+00	\N	Excelente trabajo y dedicación	410	1	21111111-1	3	35555555-5	\N	2025-06-28 03:24:52.798458+00	2025-07-28 03:24:52.798458+00	10	\N	\N	\N
2025-07-27 03:24:52.798458+00	2025-07-28 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	411	1	21111111-1	4	36666666-6	\N	2025-06-27 03:24:52.798458+00	2025-07-27 03:24:52.798458+00	11	\N	\N	\N
2025-07-26 03:24:52.798458+00	2025-07-27 03:24:52.798458+00	\N	Cumple con los requisitos	412	1	22222222-2	5	37777777-7	\N	2025-06-26 03:24:52.798458+00	2025-07-26 03:24:52.798458+00	12	\N	\N	\N
2025-07-25 03:24:52.798458+00	2025-07-26 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	413	1	22222222-2	6	38888888-8	\N	2025-06-25 03:24:52.798458+00	2025-07-25 03:24:52.798458+00	13	\N	\N	\N
2025-07-24 03:24:52.798458+00	2025-07-25 03:24:52.798458+00	\N	\N	414	1	22222222-2	7	21111111-1	\N	2025-06-24 03:24:52.798458+00	2025-07-24 03:24:52.798458+00	14	\N	\N	\N
2025-07-23 03:24:52.798458+00	2025-07-24 03:24:52.798458+00	\N	Excelente trabajo y dedicación	415	1	22222222-2	8	22222222-2	\N	2025-06-23 03:24:52.798458+00	2025-07-23 03:24:52.798458+00	15	\N	\N	\N
2025-07-22 03:24:52.798458+00	2025-07-23 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	416	1	22222222-2	9	23333333-3	\N	2025-06-22 03:24:52.798458+00	2025-07-22 03:24:52.798458+00	16	\N	\N	\N
2025-07-21 03:24:52.798458+00	2025-07-22 03:24:52.798458+00	\N	Cumple con los requisitos	417	1	22222222-2	10	24444444-4	\N	2025-06-21 03:24:52.798458+00	2025-07-21 03:24:52.798458+00	17	\N	\N	\N
2025-07-20 03:24:52.798458+00	2025-07-21 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	418	1	22222222-2	11	25555555-5	\N	2025-06-20 03:24:52.798458+00	2025-07-20 03:24:52.798458+00	18	\N	\N	\N
2025-07-19 03:24:52.798458+00	2025-07-20 03:24:52.798458+00	\N	\N	419	1	22222222-2	12	26666666-6	\N	2025-06-19 03:24:52.798458+00	2025-07-19 03:24:52.798458+00	19	\N	\N	\N
2025-07-18 03:24:52.798458+00	2025-07-19 03:24:52.798458+00	\N	Excelente trabajo y dedicación	420	1	22222222-2	1	27777777-7	\N	2025-06-18 03:24:52.798458+00	2025-07-18 03:24:52.798458+00	20	\N	\N	\N
2025-07-17 03:24:52.798458+00	2025-07-18 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	421	1	22222222-2	2	28888888-8	\N	2025-06-17 03:24:52.798458+00	2025-07-17 03:24:52.798458+00	21	\N	\N	\N
2025-07-16 03:24:52.798458+00	2025-07-17 03:24:52.798458+00	\N	Cumple con los requisitos	422	1	22222222-2	3	29999999-9	\N	2025-06-16 03:24:52.798458+00	2025-07-16 03:24:52.798458+00	22	\N	\N	\N
2025-07-15 03:24:52.798458+00	2025-07-16 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	423	1	22222222-2	4	30101010-0	\N	2025-06-15 03:24:52.798458+00	2025-07-15 03:24:52.798458+00	23	\N	\N	\N
2025-07-14 03:24:52.798458+00	2025-07-15 03:24:52.798458+00	\N	\N	424	1	22222222-2	5	31111111-1	\N	2025-06-14 03:24:52.798458+00	2025-07-14 03:24:52.798458+00	24	\N	\N	\N
2025-07-13 03:24:52.798458+00	2025-07-14 03:24:52.798458+00	\N	Excelente trabajo y dedicación	425	1	22222222-2	6	32222222-2	\N	2025-06-13 03:24:52.798458+00	2025-07-13 03:24:52.798458+00	25	\N	\N	\N
2025-07-12 03:24:52.798458+00	2025-07-13 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	426	1	22222222-2	7	33333333-3	\N	2025-06-12 03:24:52.798458+00	2025-07-12 03:24:52.798458+00	26	\N	\N	\N
2025-07-11 03:24:52.798458+00	2025-07-12 03:24:52.798458+00	\N	Cumple con los requisitos	427	1	22222222-2	8	34444444-4	\N	2025-06-11 03:24:52.798458+00	2025-07-11 03:24:52.798458+00	27	\N	\N	\N
2025-07-10 03:24:52.798458+00	2025-07-11 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	428	1	22222222-2	9	35555555-5	\N	2025-06-10 03:24:52.798458+00	2025-07-10 03:24:52.798458+00	28	\N	\N	\N
2025-07-09 03:24:52.798458+00	2025-07-10 03:24:52.798458+00	\N	\N	429	1	22222222-2	10	36666666-6	\N	2025-06-09 03:24:52.798458+00	2025-07-09 03:24:52.798458+00	29	\N	\N	\N
2025-07-08 03:24:52.798458+00	2025-07-09 03:24:52.798458+00	\N	Excelente trabajo y dedicación	430	1	22222222-2	11	37777777-7	\N	2025-06-08 03:24:52.798458+00	2025-07-08 03:24:52.798458+00	30	\N	\N	\N
2025-07-07 03:24:52.798458+00	2025-07-08 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	431	1	22222222-2	12	38888888-8	\N	2025-06-07 03:24:52.798458+00	2025-07-07 03:24:52.798458+00	31	\N	\N	\N
2025-07-06 03:24:52.798458+00	2025-07-07 03:24:52.798458+00	\N	Cumple con los requisitos	432	1	22222222-2	1	21111111-1	\N	2025-06-06 03:24:52.798458+00	2025-07-06 03:24:52.798458+00	32	\N	\N	\N
2025-07-05 03:24:52.798458+00	2025-07-06 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	433	1	22222222-2	2	22222222-2	\N	2025-06-05 03:24:52.798458+00	2025-07-05 03:24:52.798458+00	33	\N	\N	\N
2025-07-04 03:24:52.798458+00	2025-07-05 03:24:52.798458+00	\N	\N	434	1	22222222-2	3	23333333-3	\N	2025-06-04 03:24:52.798458+00	2025-07-04 03:24:52.798458+00	34	\N	\N	\N
2025-07-03 03:24:52.798458+00	2025-07-04 03:24:52.798458+00	\N	Excelente trabajo y dedicación	435	1	22222222-2	4	24444444-4	\N	2025-06-03 03:24:52.798458+00	2025-07-03 03:24:52.798458+00	35	\N	\N	\N
2025-07-02 03:24:52.798458+00	2025-07-03 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	436	1	22222222-2	5	25555555-5	\N	2025-06-02 03:24:52.798458+00	2025-07-02 03:24:52.798458+00	36	\N	\N	\N
2025-07-01 03:24:52.798458+00	2025-07-02 03:24:52.798458+00	\N	Cumple con los requisitos	437	1	23333333-3	6	26666666-6	\N	2025-06-01 03:24:52.798458+00	2025-07-01 03:24:52.798458+00	37	\N	\N	\N
2025-06-30 03:24:52.798458+00	2025-07-01 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	438	1	23333333-3	7	27777777-7	\N	2025-05-31 03:24:52.798458+00	2025-06-30 03:24:52.798458+00	38	\N	\N	\N
2025-06-29 03:24:52.798458+00	2025-06-30 03:24:52.798458+00	\N	\N	439	1	23333333-3	8	28888888-8	\N	2025-05-30 03:24:52.798458+00	2025-06-29 03:24:52.798458+00	39	\N	\N	\N
2025-06-28 03:24:52.798458+00	2025-06-29 03:24:52.798458+00	\N	Excelente trabajo y dedicación	440	1	23333333-3	9	29999999-9	\N	2025-05-29 03:24:52.798458+00	2025-06-28 03:24:52.798458+00	40	\N	\N	\N
2025-06-27 03:24:52.798458+00	2025-06-28 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	441	1	23333333-3	10	30101010-0	\N	2025-05-28 03:24:52.798458+00	2025-06-27 03:24:52.798458+00	41	\N	\N	\N
2025-06-26 03:24:52.798458+00	2025-06-27 03:24:52.798458+00	\N	Cumple con los requisitos	442	1	23333333-3	11	31111111-1	\N	2025-05-27 03:24:52.798458+00	2025-06-26 03:24:52.798458+00	42	\N	\N	\N
2025-06-25 03:24:52.798458+00	2025-06-26 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	443	1	23333333-3	12	32222222-2	\N	2025-05-26 03:24:52.798458+00	2025-06-25 03:24:52.798458+00	43	\N	\N	\N
2025-06-24 03:24:52.798458+00	2025-06-25 03:24:52.798458+00	\N	\N	444	1	23333333-3	1	33333333-3	\N	2025-05-25 03:24:52.798458+00	2025-06-24 03:24:52.798458+00	44	\N	\N	\N
2025-06-23 03:24:52.798458+00	2025-06-24 03:24:52.798458+00	\N	Excelente trabajo y dedicación	445	1	23333333-3	2	34444444-4	\N	2025-05-24 03:24:52.798458+00	2025-06-23 03:24:52.798458+00	45	\N	\N	\N
2025-06-22 03:24:52.798458+00	2025-06-23 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	446	1	23333333-3	3	35555555-5	\N	2025-05-23 03:24:52.798458+00	2025-06-22 03:24:52.798458+00	46	\N	\N	\N
2025-06-21 03:24:52.798458+00	2025-06-22 03:24:52.798458+00	\N	Cumple con los requisitos	447	1	23333333-3	4	36666666-6	\N	2025-05-22 03:24:52.798458+00	2025-06-21 03:24:52.798458+00	47	\N	\N	\N
2025-06-20 03:24:52.798458+00	2025-06-21 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	448	1	23333333-3	5	37777777-7	\N	2025-05-21 03:24:52.798458+00	2025-06-20 03:24:52.798458+00	48	\N	\N	\N
2025-06-19 03:24:52.798458+00	2025-06-20 03:24:52.798458+00	\N	\N	449	1	23333333-3	6	38888888-8	\N	2025-05-20 03:24:52.798458+00	2025-06-19 03:24:52.798458+00	49	\N	\N	\N
2025-11-15 03:24:52.798458+00	2025-11-16 03:24:52.798458+00	\N	Excelente trabajo y dedicación	450	1	23333333-3	7	21111111-1	\N	2025-10-16 03:24:52.798458+00	2025-11-15 03:24:52.798458+00	5	\N	\N	\N
2025-11-14 03:24:52.798458+00	2025-11-15 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	451	1	23333333-3	8	22222222-2	\N	2025-10-15 03:24:52.798458+00	2025-11-14 03:24:52.798458+00	6	\N	\N	\N
2025-11-13 03:24:52.798458+00	2025-11-14 03:24:52.798458+00	\N	Cumple con los requisitos	452	1	23333333-3	9	23333333-3	\N	2025-10-14 03:24:52.798458+00	2025-11-13 03:24:52.798458+00	7	\N	\N	\N
2025-11-12 03:24:52.798458+00	2025-11-13 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	453	1	23333333-3	10	24444444-4	\N	2025-10-13 03:24:52.798458+00	2025-11-12 03:24:52.798458+00	8	\N	\N	\N
2025-11-11 03:24:52.798458+00	2025-11-12 03:24:52.798458+00	\N	\N	454	1	23333333-3	11	25555555-5	\N	2025-10-12 03:24:52.798458+00	2025-11-11 03:24:52.798458+00	9	\N	\N	\N
2025-11-10 03:24:52.798458+00	2025-11-11 03:24:52.798458+00	\N	Excelente trabajo y dedicación	455	1	23333333-3	12	26666666-6	\N	2025-10-11 03:24:52.798458+00	2025-11-10 03:24:52.798458+00	10	\N	\N	\N
2025-11-09 03:24:52.798458+00	2025-11-10 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	456	1	23333333-3	1	27777777-7	\N	2025-10-10 03:24:52.798458+00	2025-11-09 03:24:52.798458+00	11	\N	\N	\N
2025-11-08 03:24:52.798458+00	2025-11-09 03:24:52.798458+00	\N	Cumple con los requisitos	457	1	23333333-3	2	28888888-8	\N	2025-10-09 03:24:52.798458+00	2025-11-08 03:24:52.798458+00	12	\N	\N	\N
2025-11-07 03:24:52.798458+00	2025-11-08 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	458	1	23333333-3	3	29999999-9	\N	2025-10-08 03:24:52.798458+00	2025-11-07 03:24:52.798458+00	13	\N	\N	\N
2025-11-06 03:24:52.798458+00	2025-11-07 03:24:52.798458+00	\N	\N	459	1	23333333-3	4	30101010-0	\N	2025-10-07 03:24:52.798458+00	2025-11-06 03:24:52.798458+00	14	\N	\N	\N
2025-11-05 03:24:52.798458+00	2025-11-06 03:24:52.798458+00	\N	Excelente trabajo y dedicación	460	1	23333333-3	5	31111111-1	\N	2025-10-06 03:24:52.798458+00	2025-11-05 03:24:52.798458+00	15	\N	\N	\N
2025-11-04 03:24:52.798458+00	2025-11-05 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	461	1	23333333-3	6	32222222-2	\N	2025-10-05 03:24:52.798458+00	2025-11-04 03:24:52.798458+00	16	\N	\N	\N
2025-11-03 03:24:52.798458+00	2025-11-04 03:24:52.798458+00	\N	Cumple con los requisitos	462	1	24444444-4	7	33333333-3	\N	2025-10-04 03:24:52.798458+00	2025-11-03 03:24:52.798458+00	17	\N	\N	\N
2025-11-02 03:24:52.798458+00	2025-11-03 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	463	1	24444444-4	8	34444444-4	\N	2025-10-03 03:24:52.798458+00	2025-11-02 03:24:52.798458+00	18	\N	\N	\N
2025-11-01 03:24:52.798458+00	2025-11-02 03:24:52.798458+00	\N	\N	464	1	24444444-4	9	35555555-5	\N	2025-10-02 03:24:52.798458+00	2025-11-01 03:24:52.798458+00	19	\N	\N	\N
2025-10-31 03:24:52.798458+00	2025-11-01 03:24:52.798458+00	\N	Excelente trabajo y dedicación	465	1	24444444-4	10	36666666-6	\N	2025-10-01 03:24:52.798458+00	2025-10-31 03:24:52.798458+00	20	\N	\N	\N
2025-10-30 03:24:52.798458+00	2025-10-31 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	466	1	24444444-4	11	37777777-7	\N	2025-09-30 03:24:52.798458+00	2025-10-30 03:24:52.798458+00	21	\N	\N	\N
2025-10-29 03:24:52.798458+00	2025-10-30 03:24:52.798458+00	\N	Cumple con los requisitos	467	1	24444444-4	12	38888888-8	\N	2025-09-29 03:24:52.798458+00	2025-10-29 03:24:52.798458+00	22	\N	\N	\N
2025-10-28 03:24:52.798458+00	2025-10-29 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	468	1	24444444-4	1	21111111-1	\N	2025-09-28 03:24:52.798458+00	2025-10-28 03:24:52.798458+00	23	\N	\N	\N
2025-10-27 03:24:52.798458+00	2025-10-28 03:24:52.798458+00	\N	\N	469	1	24444444-4	2	22222222-2	\N	2025-09-27 03:24:52.798458+00	2025-10-27 03:24:52.798458+00	24	\N	\N	\N
2025-10-26 03:24:52.798458+00	2025-10-27 03:24:52.798458+00	\N	Excelente trabajo y dedicación	470	1	24444444-4	3	23333333-3	\N	2025-09-26 03:24:52.798458+00	2025-10-26 03:24:52.798458+00	25	\N	\N	\N
2025-10-25 03:24:52.798458+00	2025-10-26 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	471	1	24444444-4	4	24444444-4	\N	2025-09-25 03:24:52.798458+00	2025-10-25 03:24:52.798458+00	26	\N	\N	\N
2025-10-24 03:24:52.798458+00	2025-10-25 03:24:52.798458+00	\N	Cumple con los requisitos	472	1	24444444-4	5	25555555-5	\N	2025-09-24 03:24:52.798458+00	2025-10-24 03:24:52.798458+00	27	\N	\N	\N
2025-10-23 03:24:52.798458+00	2025-10-24 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	473	1	24444444-4	6	26666666-6	\N	2025-09-23 03:24:52.798458+00	2025-10-23 03:24:52.798458+00	28	\N	\N	\N
2025-10-22 03:24:52.798458+00	2025-10-23 03:24:52.798458+00	\N	\N	474	1	24444444-4	7	27777777-7	\N	2025-09-22 03:24:52.798458+00	2025-10-22 03:24:52.798458+00	29	\N	\N	\N
2025-10-21 03:24:52.798458+00	2025-10-22 03:24:52.798458+00	\N	Excelente trabajo y dedicación	475	1	24444444-4	8	28888888-8	\N	2025-09-21 03:24:52.798458+00	2025-10-21 03:24:52.798458+00	30	\N	\N	\N
2025-10-20 03:24:52.798458+00	2025-10-21 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	476	1	24444444-4	9	29999999-9	\N	2025-09-20 03:24:52.798458+00	2025-10-20 03:24:52.798458+00	31	\N	\N	\N
2025-10-19 03:24:52.798458+00	2025-10-20 03:24:52.798458+00	\N	Cumple con los requisitos	477	1	24444444-4	10	30101010-0	\N	2025-09-19 03:24:52.798458+00	2025-10-19 03:24:52.798458+00	32	\N	\N	\N
2025-10-18 03:24:52.798458+00	2025-10-19 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	478	1	24444444-4	11	31111111-1	\N	2025-09-18 03:24:52.798458+00	2025-10-18 03:24:52.798458+00	33	\N	\N	\N
2025-10-17 03:24:52.798458+00	2025-10-18 03:24:52.798458+00	\N	\N	479	1	24444444-4	12	32222222-2	\N	2025-09-17 03:24:52.798458+00	2025-10-17 03:24:52.798458+00	34	\N	\N	\N
2025-10-16 03:24:52.798458+00	2025-10-17 03:24:52.798458+00	\N	Excelente trabajo y dedicación	480	1	24444444-4	1	33333333-3	\N	2025-09-16 03:24:52.798458+00	2025-10-16 03:24:52.798458+00	35	\N	\N	\N
2025-10-15 03:24:52.798458+00	2025-10-16 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	481	1	24444444-4	2	34444444-4	\N	2025-09-15 03:24:52.798458+00	2025-10-15 03:24:52.798458+00	36	\N	\N	\N
2025-10-14 03:24:52.798458+00	2025-10-15 03:24:52.798458+00	\N	Cumple con los requisitos	482	1	24444444-4	3	35555555-5	\N	2025-09-14 03:24:52.798458+00	2025-10-14 03:24:52.798458+00	37	\N	\N	\N
2025-10-13 03:24:52.798458+00	2025-10-14 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	483	1	24444444-4	4	36666666-6	\N	2025-09-13 03:24:52.798458+00	2025-10-13 03:24:52.798458+00	38	\N	\N	\N
2025-10-12 03:24:52.798458+00	2025-10-13 03:24:52.798458+00	\N	\N	484	1	24444444-4	5	37777777-7	\N	2025-09-12 03:24:52.798458+00	2025-10-12 03:24:52.798458+00	39	\N	\N	\N
2025-10-11 03:24:52.798458+00	2025-10-12 03:24:52.798458+00	\N	Excelente trabajo y dedicación	485	1	24444444-4	6	38888888-8	\N	2025-09-11 03:24:52.798458+00	2025-10-11 03:24:52.798458+00	40	\N	\N	\N
2025-10-10 03:24:52.798458+00	2025-10-11 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	486	1	24444444-4	7	21111111-1	\N	2025-09-10 03:24:52.798458+00	2025-10-10 03:24:52.798458+00	41	\N	\N	\N
2025-10-09 03:24:52.798458+00	2025-10-10 03:24:52.798458+00	\N	Cumple con los requisitos	487	1	25555555-5	8	22222222-2	\N	2025-09-09 03:24:52.798458+00	2025-10-09 03:24:52.798458+00	42	\N	\N	\N
2025-10-08 03:24:52.798458+00	2025-10-09 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	488	1	25555555-5	9	23333333-3	\N	2025-09-08 03:24:52.798458+00	2025-10-08 03:24:52.798458+00	43	\N	\N	\N
2025-10-07 03:24:52.798458+00	2025-10-08 03:24:52.798458+00	\N	\N	489	1	25555555-5	10	24444444-4	\N	2025-09-07 03:24:52.798458+00	2025-10-07 03:24:52.798458+00	44	\N	\N	\N
2025-10-06 03:24:52.798458+00	2025-10-07 03:24:52.798458+00	\N	Excelente trabajo y dedicación	490	1	25555555-5	11	25555555-5	\N	2025-09-06 03:24:52.798458+00	2025-10-06 03:24:52.798458+00	45	\N	\N	\N
2025-10-05 03:24:52.798458+00	2025-10-06 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	491	1	25555555-5	12	26666666-6	\N	2025-09-05 03:24:52.798458+00	2025-10-05 03:24:52.798458+00	46	\N	\N	\N
2025-10-04 03:24:52.798458+00	2025-10-05 03:24:52.798458+00	\N	Cumple con los requisitos	492	1	25555555-5	1	27777777-7	\N	2025-09-04 03:24:52.798458+00	2025-10-04 03:24:52.798458+00	47	\N	\N	\N
2025-10-03 03:24:52.798458+00	2025-10-04 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	493	1	25555555-5	2	28888888-8	\N	2025-09-03 03:24:52.798458+00	2025-10-03 03:24:52.798458+00	48	\N	\N	\N
2025-10-02 03:24:52.798458+00	2025-10-03 03:24:52.798458+00	\N	\N	494	1	25555555-5	3	29999999-9	\N	2025-09-02 03:24:52.798458+00	2025-10-02 03:24:52.798458+00	49	\N	\N	\N
2025-10-01 03:24:52.798458+00	2025-10-02 03:24:52.798458+00	\N	Excelente trabajo y dedicación	495	1	25555555-5	4	30101010-0	\N	2025-09-01 03:24:52.798458+00	2025-10-01 03:24:52.798458+00	5	\N	\N	\N
2025-09-30 03:24:52.798458+00	2025-10-01 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	496	1	25555555-5	5	31111111-1	\N	2025-08-31 03:24:52.798458+00	2025-09-30 03:24:52.798458+00	6	\N	\N	\N
2025-09-29 03:24:52.798458+00	2025-09-30 03:24:52.798458+00	\N	Cumple con los requisitos	497	1	25555555-5	6	32222222-2	\N	2025-08-30 03:24:52.798458+00	2025-09-29 03:24:52.798458+00	7	\N	\N	\N
2025-09-28 03:24:52.798458+00	2025-09-29 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	498	1	25555555-5	7	33333333-3	\N	2025-08-29 03:24:52.798458+00	2025-09-28 03:24:52.798458+00	8	\N	\N	\N
2025-09-27 03:24:52.798458+00	2025-09-28 03:24:52.798458+00	\N	\N	499	1	25555555-5	8	34444444-4	\N	2025-08-28 03:24:52.798458+00	2025-09-27 03:24:52.798458+00	9	\N	\N	\N
2025-09-26 03:24:52.798458+00	2025-09-27 03:24:52.798458+00	\N	Excelente trabajo y dedicación	500	1	25555555-5	9	35555555-5	\N	2025-08-27 03:24:52.798458+00	2025-09-26 03:24:52.798458+00	10	\N	\N	\N
2025-09-25 03:24:52.798458+00	2025-09-26 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	501	1	25555555-5	10	36666666-6	\N	2025-08-26 03:24:52.798458+00	2025-09-25 03:24:52.798458+00	11	\N	\N	\N
2025-09-24 03:24:52.798458+00	2025-09-25 03:24:52.798458+00	\N	Cumple con los requisitos	502	1	25555555-5	11	37777777-7	\N	2025-08-25 03:24:52.798458+00	2025-09-24 03:24:52.798458+00	12	\N	\N	\N
2025-09-23 03:24:52.798458+00	2025-09-24 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	503	1	25555555-5	12	38888888-8	\N	2025-08-24 03:24:52.798458+00	2025-09-23 03:24:52.798458+00	13	\N	\N	\N
2025-09-22 03:24:52.798458+00	2025-09-23 03:24:52.798458+00	\N	\N	504	1	25555555-5	1	21111111-1	\N	2025-08-23 03:24:52.798458+00	2025-09-22 03:24:52.798458+00	14	\N	\N	\N
2025-09-21 03:24:52.798458+00	2025-09-22 03:24:52.798458+00	\N	Excelente trabajo y dedicación	505	1	25555555-5	2	22222222-2	\N	2025-08-22 03:24:52.798458+00	2025-09-21 03:24:52.798458+00	15	\N	\N	\N
2025-09-20 03:24:52.798458+00	2025-09-21 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	506	1	25555555-5	3	23333333-3	\N	2025-08-21 03:24:52.798458+00	2025-09-20 03:24:52.798458+00	16	\N	\N	\N
2025-09-19 03:24:52.798458+00	2025-09-20 03:24:52.798458+00	\N	Cumple con los requisitos	507	1	25555555-5	4	24444444-4	\N	2025-08-20 03:24:52.798458+00	2025-09-19 03:24:52.798458+00	17	\N	\N	\N
2025-09-18 03:24:52.798458+00	2025-09-19 03:24:52.798458+00	\N	Actividad completada satisfactoriamente	508	1	25555555-5	5	25555555-5	\N	2025-08-19 03:24:52.798458+00	2025-09-18 03:24:52.798458+00	18	\N	\N	\N
2025-09-17 03:24:52.798458+00	2025-09-18 03:24:52.798458+00	\N	\N	509	1	25555555-5	6	26666666-6	\N	2025-08-18 03:24:52.798458+00	2025-09-17 03:24:52.798458+00	19	\N	\N	\N
2025-09-16 03:24:52.798458+00	2025-09-17 03:24:52.798458+00	\N	Excelente trabajo y dedicación	510	1	25555555-5	7	27777777-7	\N	2025-08-17 03:24:52.798458+00	2025-09-16 03:24:52.798458+00	20	\N	\N	\N
2025-09-15 03:24:52.798458+00	2025-09-16 03:24:52.798458+00	\N	Aprobado según los criterios establecidos	511	1	25555555-5	8	28888888-8	\N	2025-08-16 03:24:52.798458+00	2025-09-15 03:24:52.798458+00	21	\N	\N	\N
2025-12-13 03:24:52.798458+00	\N	\N	Pendiente de aprobación	512	3	1	2	21111111-1	\N	2025-11-23 03:24:52.798458+00	2025-12-13 03:24:52.798458+00	4	\N	\N	\N
2025-12-12 03:24:52.798458+00	\N	\N	En proceso de verificación	513	3	12222222-2	3	22222222-2	\N	2025-11-22 03:24:52.798458+00	2025-12-12 03:24:52.798458+00	5	\N	\N	\N
2025-12-11 03:24:52.798458+00	\N	\N	\N	514	3	13333333-3	4	23333333-3	\N	2025-11-21 03:24:52.798458+00	2025-12-11 03:24:52.798458+00	6	\N	\N	\N
2025-12-10 03:24:52.798458+00	\N	\N	Esperando revisión de documentación	515	3	14444444-4	5	24444444-4	\N	2025-11-20 03:24:52.798458+00	2025-12-10 03:24:52.798458+00	7	\N	\N	\N
2025-12-09 03:24:52.798458+00	\N	\N	Pendiente de aprobación	516	3	15555555-5	6	25555555-5	\N	2025-11-19 03:24:52.798458+00	2025-12-09 03:24:52.798458+00	8	\N	\N	\N
2025-12-08 03:24:52.798458+00	\N	\N	En proceso de verificación	517	3	16666666-6	7	26666666-6	\N	2025-11-18 03:24:52.798458+00	2025-12-08 03:24:52.798458+00	9	\N	\N	\N
2025-12-07 03:24:52.798458+00	\N	\N	\N	518	3	17777777-7	8	27777777-7	\N	2025-11-17 03:24:52.798458+00	2025-12-07 03:24:52.798458+00	10	\N	\N	\N
2025-12-06 03:24:52.798458+00	\N	\N	Esperando revisión de documentación	519	3	26666666-6	9	28888888-8	\N	2025-11-16 03:24:52.798458+00	2025-12-06 03:24:52.798458+00	11	\N	\N	\N
2025-12-05 03:24:52.798458+00	\N	\N	Pendiente de aprobación	520	3	27777777-7	10	29999999-9	\N	2025-11-15 03:24:52.798458+00	2025-12-05 03:24:52.798458+00	12	\N	\N	\N
2025-12-04 03:24:52.798458+00	\N	\N	En proceso de verificación	521	3	28888888-8	11	30101010-0	\N	2025-11-14 03:24:52.798458+00	2025-12-04 03:24:52.798458+00	13	\N	\N	\N
2025-12-03 03:24:52.798458+00	\N	\N	\N	522	3	29999999-9	12	31111111-1	\N	2025-11-13 03:24:52.798458+00	2025-12-03 03:24:52.798458+00	14	\N	\N	\N
2025-12-02 03:24:52.798458+00	\N	\N	Esperando revisión de documentación	523	3	30101010-0	1	32222222-2	\N	2025-11-12 03:24:52.798458+00	2025-12-02 03:24:52.798458+00	15	\N	\N	\N
2025-12-01 03:24:52.798458+00	\N	\N	Pendiente de aprobación	524	3	11111111-1	2	33333333-3	\N	2025-11-11 03:24:52.798458+00	2025-12-01 03:24:52.798458+00	16	\N	\N	\N
2025-11-30 03:24:52.798458+00	\N	\N	En proceso de verificación	525	3	19999999-9	3	34444444-4	\N	2025-11-10 03:24:52.798458+00	2025-11-30 03:24:52.798458+00	17	\N	\N	\N
2025-11-29 03:24:52.798458+00	\N	\N	\N	526	3	20101010-0	4	35555555-5	\N	2025-11-09 03:24:52.798458+00	2025-11-29 03:24:52.798458+00	18	\N	\N	\N
2025-11-28 03:24:52.798458+00	\N	\N	Esperando revisión de documentación	527	3	21111111-1	5	36666666-6	\N	2025-11-08 03:24:52.798458+00	2025-11-28 03:24:52.798458+00	19	\N	\N	\N
2025-11-27 03:24:52.798458+00	\N	\N	Pendiente de aprobación	528	3	22222222-2	6	37777777-7	\N	2025-11-07 03:24:52.798458+00	2025-11-27 03:24:52.798458+00	20	\N	\N	\N
2025-11-26 03:24:52.798458+00	\N	\N	En proceso de verificación	529	3	23333333-3	7	38888888-8	\N	2025-11-06 03:24:52.798458+00	2025-11-26 03:24:52.798458+00	21	\N	\N	\N
2025-11-25 03:24:52.798458+00	\N	\N	\N	530	3	24444444-4	8	21111111-1	\N	2025-11-05 03:24:52.798458+00	2025-11-25 03:24:52.798458+00	22	\N	\N	\N
2025-11-24 03:24:52.798458+00	\N	\N	Esperando revisión de documentación	531	3	25555555-5	9	22222222-2	\N	2025-11-04 03:24:52.798458+00	2025-11-24 03:24:52.798458+00	23	\N	\N	\N
2025-11-23 03:24:52.798458+00	\N	\N	Pendiente de aprobación	532	3	1	10	23333333-3	\N	2025-11-03 03:24:52.798458+00	2025-11-23 03:24:52.798458+00	24	\N	\N	\N
2025-11-22 03:24:52.798458+00	\N	\N	En proceso de verificación	533	3	12222222-2	11	24444444-4	\N	2025-11-02 03:24:52.798458+00	2025-11-22 03:24:52.798458+00	25	\N	\N	\N
2025-11-21 03:24:52.798458+00	\N	\N	\N	534	3	13333333-3	12	25555555-5	\N	2025-11-01 03:24:52.798458+00	2025-11-21 03:24:52.798458+00	26	\N	\N	\N
2025-11-20 03:24:52.798458+00	\N	\N	Esperando revisión de documentación	535	3	14444444-4	1	26666666-6	\N	2025-10-31 03:24:52.798458+00	2025-11-20 03:24:52.798458+00	27	\N	\N	\N
2025-11-19 03:24:52.798458+00	\N	\N	Pendiente de aprobación	536	3	15555555-5	2	27777777-7	\N	2025-10-30 03:24:52.798458+00	2025-11-19 03:24:52.798458+00	28	\N	\N	\N
2025-11-18 03:24:52.798458+00	\N	\N	En proceso de verificación	537	3	16666666-6	3	28888888-8	\N	2025-10-29 03:24:52.798458+00	2025-11-18 03:24:52.798458+00	29	\N	\N	\N
2025-11-17 03:24:52.798458+00	\N	\N	\N	538	3	17777777-7	4	29999999-9	\N	2025-10-28 03:24:52.798458+00	2025-11-17 03:24:52.798458+00	30	\N	\N	\N
2025-11-16 03:24:52.798458+00	\N	\N	Esperando revisión de documentación	539	3	26666666-6	5	30101010-0	\N	2025-10-27 03:24:52.798458+00	2025-11-16 03:24:52.798458+00	31	\N	\N	\N
2025-11-15 03:24:52.798458+00	\N	\N	Pendiente de aprobación	540	3	27777777-7	6	31111111-1	\N	2025-10-26 03:24:52.798458+00	2025-11-15 03:24:52.798458+00	32	\N	\N	\N
2025-12-14 03:24:52.798458+00	\N	\N	En proceso de verificación	541	3	28888888-8	7	32222222-2	\N	2025-11-24 03:24:52.798458+00	2025-12-14 03:24:52.798458+00	33	\N	\N	\N
2025-12-13 03:24:52.798458+00	\N	\N	\N	542	3	29999999-9	8	33333333-3	\N	2025-11-23 03:24:52.798458+00	2025-12-13 03:24:52.798458+00	34	\N	\N	\N
2025-12-12 03:24:52.798458+00	\N	\N	Esperando revisión de documentación	543	3	30101010-0	9	34444444-4	\N	2025-11-22 03:24:52.798458+00	2025-12-12 03:24:52.798458+00	35	\N	\N	\N
2025-12-11 03:24:52.798458+00	\N	\N	Pendiente de aprobación	544	3	11111111-1	10	35555555-5	\N	2025-11-21 03:24:52.798458+00	2025-12-11 03:24:52.798458+00	36	\N	\N	\N
2025-12-10 03:24:52.798458+00	\N	\N	En proceso de verificación	545	3	19999999-9	11	36666666-6	\N	2025-11-20 03:24:52.798458+00	2025-12-10 03:24:52.798458+00	37	\N	\N	\N
2025-12-09 03:24:52.798458+00	\N	\N	\N	546	3	20101010-0	12	37777777-7	\N	2025-11-19 03:24:52.798458+00	2025-12-09 03:24:52.798458+00	38	\N	\N	\N
2025-12-08 03:24:52.798458+00	\N	\N	Esperando revisión de documentación	547	3	21111111-1	1	38888888-8	\N	2025-11-18 03:24:52.798458+00	2025-12-08 03:24:52.798458+00	39	\N	\N	\N
2025-12-07 03:24:52.798458+00	\N	\N	Pendiente de aprobación	548	3	22222222-2	2	21111111-1	\N	2025-11-17 03:24:52.798458+00	2025-12-07 03:24:52.798458+00	40	\N	\N	\N
2025-12-06 03:24:52.798458+00	\N	\N	En proceso de verificación	549	3	23333333-3	3	22222222-2	\N	2025-11-16 03:24:52.798458+00	2025-12-06 03:24:52.798458+00	41	\N	\N	\N
2025-12-05 03:24:52.798458+00	\N	\N	\N	550	3	24444444-4	4	23333333-3	\N	2025-11-15 03:24:52.798458+00	2025-12-05 03:24:52.798458+00	42	\N	\N	\N
2025-12-04 03:24:52.798458+00	\N	\N	Esperando revisión de documentación	551	3	25555555-5	5	24444444-4	\N	2025-11-14 03:24:52.798458+00	2025-12-04 03:24:52.798458+00	43	\N	\N	\N
2025-12-03 03:24:52.798458+00	\N	\N	Pendiente de aprobación	552	3	1	6	25555555-5	\N	2025-11-13 03:24:52.798458+00	2025-12-03 03:24:52.798458+00	44	\N	\N	\N
2025-12-02 03:24:52.798458+00	\N	\N	En proceso de verificación	553	3	12222222-2	7	26666666-6	\N	2025-11-12 03:24:52.798458+00	2025-12-02 03:24:52.798458+00	45	\N	\N	\N
2025-12-01 03:24:52.798458+00	\N	\N	\N	554	3	13333333-3	8	27777777-7	\N	2025-11-11 03:24:52.798458+00	2025-12-01 03:24:52.798458+00	46	\N	\N	\N
2025-11-30 03:24:52.798458+00	\N	\N	Esperando revisión de documentación	555	3	14444444-4	9	28888888-8	\N	2025-11-10 03:24:52.798458+00	2025-11-30 03:24:52.798458+00	47	\N	\N	\N
2025-11-29 03:24:52.798458+00	\N	\N	Pendiente de aprobación	556	3	15555555-5	10	29999999-9	\N	2025-11-09 03:24:52.798458+00	2025-11-29 03:24:52.798458+00	48	\N	\N	\N
2025-11-28 03:24:52.798458+00	\N	\N	En proceso de verificación	557	3	16666666-6	11	30101010-0	\N	2025-11-08 03:24:52.798458+00	2025-11-28 03:24:52.798458+00	49	\N	\N	\N
2025-11-27 03:24:52.798458+00	\N	\N	\N	558	3	17777777-7	12	31111111-1	\N	2025-11-07 03:24:52.798458+00	2025-11-27 03:24:52.798458+00	3	\N	\N	\N
2025-11-26 03:24:52.798458+00	\N	\N	Esperando revisión de documentación	559	3	26666666-6	1	32222222-2	\N	2025-11-06 03:24:52.798458+00	2025-11-26 03:24:52.798458+00	4	\N	\N	\N
2025-11-25 03:24:52.798458+00	\N	\N	Pendiente de aprobación	560	3	27777777-7	2	33333333-3	\N	2025-11-05 03:24:52.798458+00	2025-11-25 03:24:52.798458+00	5	\N	\N	\N
2025-11-24 03:24:52.798458+00	\N	\N	En proceso de verificación	561	3	28888888-8	3	34444444-4	\N	2025-11-04 03:24:52.798458+00	2025-11-24 03:24:52.798458+00	6	\N	\N	\N
\.


--
-- TOC entry 3561 (class 0 OID 16443)
-- Dependencies: 243
-- Data for Name: rol; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.rol (id_rol, nombre_rol) FROM stdin;
1	profesor
2	director
3	admin
4	Super admin
\.


--
-- TOC entry 3563 (class 0 OID 16449)
-- Dependencies: 245
-- Data for Name: subcategoria; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.subcategoria (id_subcategoria, subcategoria, id_categoria) FROM stdin;
1	academico	1
2	I+D	1
3	varios	1
4	varios	2
\.


--
-- TOC entry 3591 (class 0 OID 0)
-- Dependencies: 218
-- Name: actividad_id_actividad_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.actividad_id_actividad_seq', 12, true);


--
-- TOC entry 3592 (class 0 OID 0)
-- Dependencies: 219
-- Name: actividad_id_subcategoria_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.actividad_id_subcategoria_seq', 1, false);


--
-- TOC entry 3593 (class 0 OID 0)
-- Dependencies: 221
-- Name: alumno_id_carrera_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.alumno_id_carrera_seq', 1, false);


--
-- TOC entry 3594 (class 0 OID 0)
-- Dependencies: 222
-- Name: alumno_rut_alumno_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.alumno_rut_alumno_seq', 1, false);


--
-- TOC entry 3595 (class 0 OID 0)
-- Dependencies: 224
-- Name: carrera_id_carrera_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.carrera_id_carrera_seq', 1, false);


--
-- TOC entry 3596 (class 0 OID 0)
-- Dependencies: 226
-- Name: categoria_id_categoria_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categoria_id_categoria_seq', 1, false);


--
-- TOC entry 3597 (class 0 OID 0)
-- Dependencies: 228
-- Name: estado_id_estado_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.estado_id_estado_seq', 1, false);


--
-- TOC entry 3598 (class 0 OID 0)
-- Dependencies: 231
-- Name: instituto_id_instituto_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.instituto_id_instituto_seq', 1, false);


--
-- TOC entry 3599 (class 0 OID 0)
-- Dependencies: 233
-- Name: periodos_id_periodos_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.periodos_id_periodos_seq', 1, false);


--
-- TOC entry 3600 (class 0 OID 0)
-- Dependencies: 235
-- Name: profesor_id_instituto_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.profesor_id_instituto_seq', 1, false);


--
-- TOC entry 3601 (class 0 OID 0)
-- Dependencies: 236
-- Name: profesor_id_profesor_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.profesor_id_profesor_seq', 1, true);


--
-- TOC entry 3602 (class 0 OID 0)
-- Dependencies: 237
-- Name: profesor_id_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.profesor_id_rol_seq', 1, false);


--
-- TOC entry 3603 (class 0 OID 0)
-- Dependencies: 239
-- Name: registro_id_actividad_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.registro_id_actividad_seq', 1, false);


--
-- TOC entry 3604 (class 0 OID 0)
-- Dependencies: 240
-- Name: registro_id_alumno_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.registro_id_alumno_seq', 1, false);


--
-- TOC entry 3605 (class 0 OID 0)
-- Dependencies: 241
-- Name: registro_id_profesor_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.registro_id_profesor_seq', 1, false);


--
-- TOC entry 3606 (class 0 OID 0)
-- Dependencies: 242
-- Name: registro_id_registro_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.registro_id_registro_seq', 561, true);


--
-- TOC entry 3607 (class 0 OID 0)
-- Dependencies: 244
-- Name: rol_id_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rol_id_rol_seq', 1, false);


--
-- TOC entry 3608 (class 0 OID 0)
-- Dependencies: 246
-- Name: subcategoria_id_categoria_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.subcategoria_id_categoria_seq', 1, false);


--
-- TOC entry 3609 (class 0 OID 0)
-- Dependencies: 247
-- Name: subcategoria_id_subcategoria_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.subcategoria_id_subcategoria_seq', 4, true);


--
-- TOC entry 3355 (class 2606 OID 16473)
-- Name: actividad id_actividad; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actividad
    ADD CONSTRAINT id_actividad PRIMARY KEY (id_actividad);


--
-- TOC entry 3359 (class 2606 OID 16475)
-- Name: carrera id_carrera; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carrera
    ADD CONSTRAINT id_carrera PRIMARY KEY (id_carrera);


--
-- TOC entry 3361 (class 2606 OID 16477)
-- Name: categoria id_categoria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT id_categoria PRIMARY KEY (id_categoria);


--
-- TOC entry 3363 (class 2606 OID 16479)
-- Name: estado id_estado; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estado
    ADD CONSTRAINT id_estado PRIMARY KEY (id_estado);


--
-- TOC entry 3365 (class 2606 OID 16481)
-- Name: instituto id_instituto; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instituto
    ADD CONSTRAINT id_instituto PRIMARY KEY (id_instituto);


--
-- TOC entry 3369 (class 2606 OID 16483)
-- Name: periodos id_periodos; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.periodos
    ADD CONSTRAINT id_periodos PRIMARY KEY (id_periodos);


--
-- TOC entry 3371 (class 2606 OID 16485)
-- Name: profesor id_profesor; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profesor
    ADD CONSTRAINT id_profesor PRIMARY KEY (id_profesor);


--
-- TOC entry 3373 (class 2606 OID 16487)
-- Name: registro id_registro; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registro
    ADD CONSTRAINT id_registro PRIMARY KEY (id_registro);


--
-- TOC entry 3375 (class 2606 OID 16489)
-- Name: rol id_rol; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rol
    ADD CONSTRAINT id_rol PRIMARY KEY (id_rol);


--
-- TOC entry 3377 (class 2606 OID 16491)
-- Name: subcategoria id_subcategoria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subcategoria
    ADD CONSTRAINT id_subcategoria PRIMARY KEY (id_subcategoria);


--
-- TOC entry 3367 (class 2606 OID 16493)
-- Name: instituto-carrera instituto_carrera_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."instituto-carrera"
    ADD CONSTRAINT instituto_carrera_pk PRIMARY KEY (id_instituto_carrera);


--
-- TOC entry 3357 (class 2606 OID 16495)
-- Name: alumno pk_alumno; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alumno
    ADD CONSTRAINT pk_alumno PRIMARY KEY (rut_alumno);


--
-- TOC entry 3385 (class 2606 OID 16496)
-- Name: registro fk_alumno; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registro
    ADD CONSTRAINT fk_alumno FOREIGN KEY (id_alumno) REFERENCES public.alumno(rut_alumno);


--
-- TOC entry 3386 (class 2606 OID 16501)
-- Name: registro fkey_actividad; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registro
    ADD CONSTRAINT fkey_actividad FOREIGN KEY (id_actividad) REFERENCES public.actividad(id_actividad);


--
-- TOC entry 3379 (class 2606 OID 16506)
-- Name: alumno fkey_carrera; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alumno
    ADD CONSTRAINT fkey_carrera FOREIGN KEY (id_carrera) REFERENCES public.carrera(id_carrera);


--
-- TOC entry 3389 (class 2606 OID 16511)
-- Name: subcategoria fkey_categoria; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subcategoria
    ADD CONSTRAINT fkey_categoria FOREIGN KEY (id_categoria) REFERENCES public.categoria(id_categoria);


--
-- TOC entry 3387 (class 2606 OID 16516)
-- Name: registro fkey_estado; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registro
    ADD CONSTRAINT fkey_estado FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado);


--
-- TOC entry 3383 (class 2606 OID 16521)
-- Name: profesor fkey_instituto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profesor
    ADD CONSTRAINT fkey_instituto FOREIGN KEY (id_instituto) REFERENCES public.instituto(id_instituto);


--
-- TOC entry 3388 (class 2606 OID 16526)
-- Name: registro fkey_profesor; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registro
    ADD CONSTRAINT fkey_profesor FOREIGN KEY (id_profesor) REFERENCES public.profesor(id_profesor);


--
-- TOC entry 3382 (class 2606 OID 16531)
-- Name: periodos fkey_profesor; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.periodos
    ADD CONSTRAINT fkey_profesor FOREIGN KEY (id_profesor) REFERENCES public.profesor(id_profesor);


--
-- TOC entry 3384 (class 2606 OID 16536)
-- Name: profesor fkey_rol; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profesor
    ADD CONSTRAINT fkey_rol FOREIGN KEY (id_rol) REFERENCES public.rol(id_rol);


--
-- TOC entry 3378 (class 2606 OID 16541)
-- Name: actividad fkey_subcategoria; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actividad
    ADD CONSTRAINT fkey_subcategoria FOREIGN KEY (id_subcategoria) REFERENCES public.subcategoria(id_subcategoria);


--
-- TOC entry 3380 (class 2606 OID 16546)
-- Name: instituto-carrera instituto_carrera_carrera_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."instituto-carrera"
    ADD CONSTRAINT instituto_carrera_carrera_fk FOREIGN KEY (id_carrera) REFERENCES public.carrera(id_carrera);


--
-- TOC entry 3381 (class 2606 OID 16551)
-- Name: instituto-carrera instituto_carrera_instituto_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."instituto-carrera"
    ADD CONSTRAINT instituto_carrera_instituto_fk FOREIGN KEY (id_instituto) REFERENCES public.instituto(id_instituto);


-- Completed on 2025-12-15 00:28:56

--
-- PostgreSQL database dump complete
--

\unrestrict rA6nugevfdkZHfGuQ3VzdbjVXs2kci6Vmmjod1SVhv5gXH6FJdPLIeUh19nH7e7

