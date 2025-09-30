--
-- PostgreSQL database dump
--

\restrict kScpQXmSLmwAzbdm4l2e4Ib8hoob8bksphIBY8G0v9YTmtTgVQofl1TkJfE1Zb5

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

-- Started on 2025-09-27 17:46:16

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
-- TOC entry 217 (class 1259 OID 16463)
-- Name: actividad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.actividad (
    id_actividad integer NOT NULL,
    nombre_actividad character varying NOT NULL,
    id_subcategoria integer NOT NULL
);




--
-- TOC entry 218 (class 1259 OID 16468)
-- Name: actividad_id_actividad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.actividad_id_actividad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




--
-- TOC entry 4919 (class 0 OID 0)
-- Dependencies: 218
-- Name: actividad_id_actividad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.actividad_id_actividad_seq OWNED BY public.actividad.id_actividad;


--
-- TOC entry 219 (class 1259 OID 16469)
-- Name: actividad_id_subcategoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.actividad_id_subcategoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




--
-- TOC entry 4920 (class 0 OID 0)
-- Dependencies: 219
-- Name: actividad_id_subcategoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.actividad_id_subcategoria_seq OWNED BY public.actividad.id_subcategoria;


--
-- TOC entry 220 (class 1259 OID 16470)
-- Name: alumno; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alumno (
    rut_alumno character varying(10) NOT NULL,
    nombres character varying(50) NOT NULL,
    apellidos character varying(50) NOT NULL,
    correo character varying(30) NOT NULL,
    ano_egreso integer NOT NULL,
    id_carrera integer NOT NULL,
    password_hash text
);




--
-- TOC entry 4921 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN alumno.rut_alumno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.alumno.rut_alumno IS 'Rut sin codigo verificador';


--
-- TOC entry 221 (class 1259 OID 16475)
-- Name: alumno_id_carrera_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.alumno_id_carrera_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




--
-- TOC entry 4922 (class 0 OID 0)
-- Dependencies: 221
-- Name: alumno_id_carrera_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.alumno_id_carrera_seq OWNED BY public.alumno.id_carrera;


--
-- TOC entry 222 (class 1259 OID 16476)
-- Name: alumno_rut_alumno_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.alumno_rut_alumno_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




--
-- TOC entry 4923 (class 0 OID 0)
-- Dependencies: 222
-- Name: alumno_rut_alumno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.alumno_rut_alumno_seq OWNED BY public.alumno.rut_alumno;


--
-- TOC entry 223 (class 1259 OID 16477)
-- Name: carrera; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carrera (
    id_carrera integer NOT NULL,
    nombre_carrera character varying NOT NULL
);




--
-- TOC entry 224 (class 1259 OID 16482)
-- Name: carrera_id_carrera_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carrera_id_carrera_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




--
-- TOC entry 4924 (class 0 OID 0)
-- Dependencies: 224
-- Name: carrera_id_carrera_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carrera_id_carrera_seq OWNED BY public.carrera.id_carrera;


--
-- TOC entry 225 (class 1259 OID 16483)
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria (
    id_categoria integer NOT NULL,
    nombre_categoria character varying(100) NOT NULL
);




--
-- TOC entry 226 (class 1259 OID 16486)
-- Name: categoria_id_categoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categoria_id_categoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




--
-- TOC entry 4925 (class 0 OID 0)
-- Dependencies: 226
-- Name: categoria_id_categoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categoria_id_categoria_seq OWNED BY public.categoria.id_categoria;


--
-- TOC entry 227 (class 1259 OID 16487)
-- Name: estado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estado (
    id_estado integer NOT NULL,
    nombre_estado character varying(25) NOT NULL
);




--
-- TOC entry 228 (class 1259 OID 16490)
-- Name: estado_id_estado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estado_id_estado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




--
-- TOC entry 4926 (class 0 OID 0)
-- Dependencies: 228
-- Name: estado_id_estado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estado_id_estado_seq OWNED BY public.estado.id_estado;


--
-- TOC entry 229 (class 1259 OID 16491)
-- Name: instituto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instituto (
    id_instituto integer NOT NULL,
    nombre_instituto character varying NOT NULL
);




--
-- TOC entry 230 (class 1259 OID 16496)
-- Name: instituto_id_instituto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.instituto_id_instituto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




--
-- TOC entry 4927 (class 0 OID 0)
-- Dependencies: 230
-- Name: instituto_id_instituto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.instituto_id_instituto_seq OWNED BY public.instituto.id_instituto;


--
-- TOC entry 231 (class 1259 OID 16497)
-- Name: profesor; Type: TABLE; Schema: public; Owner: postgres
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
-- TOC entry 232 (class 1259 OID 16500)
-- Name: profesor_id_instituto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.profesor_id_instituto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




--
-- TOC entry 4928 (class 0 OID 0)
-- Dependencies: 232
-- Name: profesor_id_instituto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.profesor_id_instituto_seq OWNED BY public.profesor.id_instituto;


--
-- TOC entry 233 (class 1259 OID 16501)
-- Name: profesor_id_profesor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.profesor_id_profesor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




--
-- TOC entry 4929 (class 0 OID 0)
-- Dependencies: 233
-- Name: profesor_id_profesor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.profesor_id_profesor_seq OWNED BY public.profesor.id_profesor;


--
-- TOC entry 234 (class 1259 OID 16502)
-- Name: profesor_id_rol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.profesor_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




--
-- TOC entry 4930 (class 0 OID 0)
-- Dependencies: 234
-- Name: profesor_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.profesor_id_rol_seq OWNED BY public.profesor.id_rol;


--
-- TOC entry 235 (class 1259 OID 16503)
-- Name: registro; Type: TABLE; Schema: public; Owner: postgres
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
    horas_totales integer
);




--
-- TOC entry 236 (class 1259 OID 16508)
-- Name: registro_id_actividad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.registro_id_actividad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




--
-- TOC entry 4931 (class 0 OID 0)
-- Dependencies: 236
-- Name: registro_id_actividad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.registro_id_actividad_seq OWNED BY public.registro.id_actividad;


--
-- TOC entry 237 (class 1259 OID 16509)
-- Name: registro_id_alumno_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.registro_id_alumno_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




--
-- TOC entry 4932 (class 0 OID 0)
-- Dependencies: 237
-- Name: registro_id_alumno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.registro_id_alumno_seq OWNED BY public.registro.id_alumno;


--
-- TOC entry 238 (class 1259 OID 16510)
-- Name: registro_id_profesor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.registro_id_profesor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




--
-- TOC entry 4933 (class 0 OID 0)
-- Dependencies: 238
-- Name: registro_id_profesor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.registro_id_profesor_seq OWNED BY public.registro.id_profesor;


--
-- TOC entry 239 (class 1259 OID 16511)
-- Name: registro_id_registro_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.registro_id_registro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




--
-- TOC entry 4934 (class 0 OID 0)
-- Dependencies: 239
-- Name: registro_id_registro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.registro_id_registro_seq OWNED BY public.registro.id_registro;


--
-- TOC entry 240 (class 1259 OID 16512)
-- Name: rol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rol (
    id_rol integer NOT NULL,
    nombre_rol character varying NOT NULL
);




--
-- TOC entry 241 (class 1259 OID 16517)
-- Name: rol_id_rol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rol_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




--
-- TOC entry 4935 (class 0 OID 0)
-- Dependencies: 241
-- Name: rol_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rol_id_rol_seq OWNED BY public.rol.id_rol;


--
-- TOC entry 242 (class 1259 OID 16518)
-- Name: subcategoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subcategoria (
    id_subcategoria integer NOT NULL,
    subcategoria character varying(100) NOT NULL,
    id_categoria integer NOT NULL
);




--
-- TOC entry 243 (class 1259 OID 16521)
-- Name: subcategoria_id_categoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subcategoria_id_categoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




--
-- TOC entry 4936 (class 0 OID 0)
-- Dependencies: 243
-- Name: subcategoria_id_categoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subcategoria_id_categoria_seq OWNED BY public.subcategoria.id_categoria;


--
-- TOC entry 244 (class 1259 OID 16522)
-- Name: subcategoria_id_subcategoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subcategoria_id_subcategoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




--
-- TOC entry 4937 (class 0 OID 0)
-- Dependencies: 244
-- Name: subcategoria_id_subcategoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subcategoria_id_subcategoria_seq OWNED BY public.subcategoria.id_subcategoria;


--
-- TOC entry 4694 (class 2604 OID 16523)
-- Name: actividad id_actividad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actividad ALTER COLUMN id_actividad SET DEFAULT nextval('public.actividad_id_actividad_seq'::regclass);


--
-- TOC entry 4695 (class 2604 OID 16524)
-- Name: actividad id_subcategoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actividad ALTER COLUMN id_subcategoria SET DEFAULT nextval('public.actividad_id_subcategoria_seq'::regclass);


--
-- TOC entry 4696 (class 2604 OID 16624)
-- Name: alumno rut_alumno; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumno ALTER COLUMN rut_alumno SET DEFAULT nextval('public.alumno_rut_alumno_seq'::regclass);


--
-- TOC entry 4697 (class 2604 OID 16526)
-- Name: alumno id_carrera; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumno ALTER COLUMN id_carrera SET DEFAULT nextval('public.alumno_id_carrera_seq'::regclass);


--
-- TOC entry 4698 (class 2604 OID 16527)
-- Name: carrera id_carrera; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrera ALTER COLUMN id_carrera SET DEFAULT nextval('public.carrera_id_carrera_seq'::regclass);


--
-- TOC entry 4699 (class 2604 OID 16528)
-- Name: categoria id_categoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria ALTER COLUMN id_categoria SET DEFAULT nextval('public.categoria_id_categoria_seq'::regclass);


--
-- TOC entry 4700 (class 2604 OID 16529)
-- Name: estado id_estado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado ALTER COLUMN id_estado SET DEFAULT nextval('public.estado_id_estado_seq'::regclass);


--
-- TOC entry 4701 (class 2604 OID 16530)
-- Name: instituto id_instituto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instituto ALTER COLUMN id_instituto SET DEFAULT nextval('public.instituto_id_instituto_seq'::regclass);


--
-- TOC entry 4702 (class 2604 OID 16664)
-- Name: profesor id_profesor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesor ALTER COLUMN id_profesor SET DEFAULT nextval('public.profesor_id_profesor_seq'::regclass);


--
-- TOC entry 4703 (class 2604 OID 16532)
-- Name: profesor id_instituto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesor ALTER COLUMN id_instituto SET DEFAULT nextval('public.profesor_id_instituto_seq'::regclass);


--
-- TOC entry 4704 (class 2604 OID 16533)
-- Name: profesor id_rol; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesor ALTER COLUMN id_rol SET DEFAULT nextval('public.profesor_id_rol_seq'::regclass);


--
-- TOC entry 4705 (class 2604 OID 16534)
-- Name: registro id_registro; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro ALTER COLUMN id_registro SET DEFAULT nextval('public.registro_id_registro_seq'::regclass);


--
-- TOC entry 4706 (class 2604 OID 16657)
-- Name: registro id_profesor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro ALTER COLUMN id_profesor SET DEFAULT nextval('public.registro_id_profesor_seq'::regclass);


--
-- TOC entry 4707 (class 2604 OID 16536)
-- Name: registro id_actividad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro ALTER COLUMN id_actividad SET DEFAULT nextval('public.registro_id_actividad_seq'::regclass);


--
-- TOC entry 4708 (class 2604 OID 16633)
-- Name: registro id_alumno; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro ALTER COLUMN id_alumno SET DEFAULT nextval('public.registro_id_alumno_seq'::regclass);


--
-- TOC entry 4709 (class 2604 OID 16538)
-- Name: rol id_rol; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rol ALTER COLUMN id_rol SET DEFAULT nextval('public.rol_id_rol_seq'::regclass);


--
-- TOC entry 4710 (class 2604 OID 16539)
-- Name: subcategoria id_subcategoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcategoria ALTER COLUMN id_subcategoria SET DEFAULT nextval('public.subcategoria_id_subcategoria_seq'::regclass);


--
-- TOC entry 4711 (class 2604 OID 16540)
-- Name: subcategoria id_categoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcategoria ALTER COLUMN id_categoria SET DEFAULT nextval('public.subcategoria_id_categoria_seq'::regclass);


--
-- TOC entry 4886 (class 0 OID 16463)
-- Dependencies: 217
-- Data for Name: actividad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.actividad (id_actividad, nombre_actividad, id_subcategoria) FROM stdin;
1	Docencia	1
2	Investigación	1
3	Extensión	1
4	Dirigencias	1
5	Deportivos	1
6	Social	1
\.


--
-- TOC entry 4889 (class 0 OID 16470)
-- Dependencies: 220
-- Data for Name: alumno; Type: TABLE DATA; Schema: public; Owner: postgres
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
\.


--
-- TOC entry 4892 (class 0 OID 16477)
-- Dependencies: 223
-- Data for Name: carrera; Type: TABLE DATA; Schema: public; Owner: postgres
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
-- TOC entry 4894 (class 0 OID 16483)
-- Dependencies: 225
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categoria (id_categoria, nombre_categoria) FROM stdin;
2	No academica
1	Academica
\.


--
-- TOC entry 4896 (class 0 OID 16487)
-- Dependencies: 227
-- Data for Name: estado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estado (id_estado, nombre_estado) FROM stdin;
1	pendiente
\.


--
-- TOC entry 4898 (class 0 OID 16491)
-- Dependencies: 229
-- Data for Name: instituto; Type: TABLE DATA; Schema: public; Owner: postgres
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
-- TOC entry 4900 (class 0 OID 16497)
-- Dependencies: 231
-- Data for Name: profesor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profesor (id_profesor, nombres, apellidos, correo, id_instituto, id_rol, password_hash) FROM stdin;
1	Luis	Veas	lveas@example.com	1	1	$2b$12$UTt1hNZDukYMzFbq2O8L0OMbLATqO7SyN8kU9KKZA92zbKiMHVQRO
11111111-1	Carlos	Pérez	carlos.perez@instituto1.cl	1	1	$2b$12$jlt2uRgLE0MzDMY753N86ucpwkL.ddALF20Yv5dvqEcYE6Rj.2rAi
12222222-2	Marta	González	marta.gonzalez@instituto2.cl	2	1	$2b$12$1hPTu1W5O2PgDmSWcqyN3uiPuvBGr9HqhvBh0GDE2OMidEbHpZQiy
13333333-3	Juan	Ramírez	juan.ramirez@instituto3.cl	3	1	$2b$12$pIPWvC4tbCDyjw7XSg8GV.hPfEhkuXrg3vO10FgxlrhioD9DDoCZG
14444444-4	Ana	Fernández	ana.fernandez@instituto4.cl	4	1	$2b$12$16w73NBOsWBiMl0gHGn6I.7FG6EoxlXNnXGaVFqhOJdihUNE1yvcO
15555555-5	Luis	Torres	luis.torres@instituto5.cl	5	1	$2b$12$/YrE.Lpy92Qi783MMNA9NezwxA2vKWOzf5BGoVMFSyhszP15K5ARq
16666666-6	Claudia	Vargas	claudia.vargas@instituto6.cl	6	1	$2b$12$8WN1fHDDTrx5Q/mmbwxKHur13XSvBCMYc0qqPeSNhBwS4f.3PZwuC
17777777-7	Pedro	Morales	pedro.morales@instituto7.cl	7	1	$2b$12$K8Kn9DbICTHDgXyni1sRsOQMhoH3D5UYl4WViQICXR8.EaZS6/ytO
18888888-8	María	Rojas	maria.rojas@instituto1.cl	1	1	$2b$12$lRHhWuMTq8gEotFxG8zQU.ZUUANjme9xOJaxT2ttT4GfMKXa9fjkC
19999999-9	Ricardo	Castro	ricardo.castro@instituto2.cl	2	1	$2b$12$G0/36HguJP4exVHIaavm3ewiIPlBk/zQv9Df/TK6gtrsBAgTDbWjm
20101010-0	Verónica	Silva	veronica.silva@instituto3.cl	3	1	$2b$12$NN1mVCh99KFAu6F/M34LjO/OV783X4mjUDlTie6gsVkTeURUVidFi
21111111-1	Sebastián	López	sebastian.lopez@instituto4.cl	4	1	$2b$12$h04zyTyhzhDvDbzB2GGZe.3G3erEm2YulgApPtfZazEMlkFPl2L8S
22222222-2	Patricia	Martínez	patricia.martinez@instituto5.cl	5	1	$2b$12$iAlZXqajafODNNJFvq.XCOtcYRJ6.4fvHSrayGQJB9aBwZwFAY/NG
23333333-3	Andrés	Contreras	andres.contreras@instituto6.cl	6	1	$2b$12$qTE7vSysdGhcXYRsOyQLIuDswxtdrdCdVN12vixiFI.smHn9fuQ7q
24444444-4	Daniela	Gutiérrez	daniela.gutierrez@instituto7.cl	7	1	$2b$12$W5IgFBqlaVHKB9lZudxXD.vHREMDV9iJTyc5G9AimiVPnF7DbVczy
25555555-5	Diego	Fuentes	diego.fuentes@instituto1.cl	1	1	$2b$12$saYyW8hlfVbf/ghmbhp3YuH2ga43RNKiel/FHy.6HVOtWHo2kCCW6
26666666-6	Francisca	Herrera	francisca.herrera@instituto2.cl	2	1	$2b$12$0ZAGb5q8RqGRzx5bcrTkEejovmNQhz/KMRogd7oWKqnA1xhTHgSQq
27777777-7	Tomás	Reyes	tomas.reyes@instituto3.cl	3	1	$2b$12$gN91Jg3WwZ5LW09vFviAOeO44MTnbM7zqLGGWkw.RXh6ZGSxhj9E.
28888888-8	Javiera	Navarro	javiera.navarro@instituto4.cl	4	1	$2b$12$KDSSzL/aWeOrQhx6JKF1b.XwC8PFKq2h3KFX3RTSEcPDzLd9dHP2u
29999999-9	José	Ortega	jose.ortega@instituto5.cl	5	1	$2b$12$ZBKo9ItfGDDPgD2ARrt0v.273O6/WozRLHoDm8CFsys.gsfLocwJK
30101010-0	Carolina	Sánchez	carolina.sanchez@instituto6.cl	6	1	$2b$12$6yMP7vjTa0rEQk6dDWt.Vu1MWe2YL2PxBZHJ/w9AHdqCzfqXJlXFi
\.


--
-- TOC entry 4904 (class 0 OID 16503)
-- Dependencies: 235
-- Data for Name: registro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.registro (fecha_creacion, fecha_emision, archivo_data, comentario, id_registro, id_estado, id_profesor, id_actividad, id_alumno, archivo_nombre, fecha_inicio_actividad, fecha_termino_actividad, horas_totales) FROM stdin;
2025-09-20 02:05:10.157143-03	2025-09-20 02:05:10.213807-03	\N		1	1	1	1	12345678-9	\N	\N	\N	\N
2025-09-20 02:56:42.35172-03	2025-09-20 02:56:42.353725-03	\N		2	1	1	2	12345678-9	\N	\N	\N	\N
2025-09-20 03:10:29.28957-03	2025-09-20 03:10:29.290585-03	\N		3	1	1	4	12345678-9	\N	\N	\N	\N
2025-09-21 20:07:38.414756-03	2025-09-21 20:07:38.416502-03	\N		4	1	1	3	12345678-9	\N	\N	\N	\N
2025-09-26 15:47:11.01809-03	2025-09-26 15:47:11.01909-03	\N		5	1	1	1	12345678-9	\N	2025-06-03 00:00:00-04	2025-09-26 00:00:00-03	70
\.


--
-- TOC entry 4909 (class 0 OID 16512)
-- Dependencies: 240
-- Data for Name: rol; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rol (id_rol, nombre_rol) FROM stdin;
1	profesor
2	director
\.


--
-- TOC entry 4911 (class 0 OID 16518)
-- Dependencies: 242
-- Data for Name: subcategoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subcategoria (id_subcategoria, subcategoria, id_categoria) FROM stdin;
1	To_expande	1
\.


--
-- TOC entry 4938 (class 0 OID 0)
-- Dependencies: 218
-- Name: actividad_id_actividad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.actividad_id_actividad_seq', 1, false);


--
-- TOC entry 4939 (class 0 OID 0)
-- Dependencies: 219
-- Name: actividad_id_subcategoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.actividad_id_subcategoria_seq', 1, false);


--
-- TOC entry 4940 (class 0 OID 0)
-- Dependencies: 221
-- Name: alumno_id_carrera_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alumno_id_carrera_seq', 1, false);


--
-- TOC entry 4941 (class 0 OID 0)
-- Dependencies: 222
-- Name: alumno_rut_alumno_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alumno_rut_alumno_seq', 1, false);


--
-- TOC entry 4942 (class 0 OID 0)
-- Dependencies: 224
-- Name: carrera_id_carrera_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carrera_id_carrera_seq', 1, false);


--
-- TOC entry 4943 (class 0 OID 0)
-- Dependencies: 226
-- Name: categoria_id_categoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categoria_id_categoria_seq', 1, false);


--
-- TOC entry 4944 (class 0 OID 0)
-- Dependencies: 228
-- Name: estado_id_estado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estado_id_estado_seq', 1, false);


--
-- TOC entry 4945 (class 0 OID 0)
-- Dependencies: 230
-- Name: instituto_id_instituto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instituto_id_instituto_seq', 1, false);


--
-- TOC entry 4946 (class 0 OID 0)
-- Dependencies: 232
-- Name: profesor_id_instituto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.profesor_id_instituto_seq', 1, false);


--
-- TOC entry 4947 (class 0 OID 0)
-- Dependencies: 233
-- Name: profesor_id_profesor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.profesor_id_profesor_seq', 1, true);


--
-- TOC entry 4948 (class 0 OID 0)
-- Dependencies: 234
-- Name: profesor_id_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.profesor_id_rol_seq', 1, false);


--
-- TOC entry 4949 (class 0 OID 0)
-- Dependencies: 236
-- Name: registro_id_actividad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.registro_id_actividad_seq', 1, false);


--
-- TOC entry 4950 (class 0 OID 0)
-- Dependencies: 237
-- Name: registro_id_alumno_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.registro_id_alumno_seq', 1, false);


--
-- TOC entry 4951 (class 0 OID 0)
-- Dependencies: 238
-- Name: registro_id_profesor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.registro_id_profesor_seq', 1, false);


--
-- TOC entry 4952 (class 0 OID 0)
-- Dependencies: 239
-- Name: registro_id_registro_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.registro_id_registro_seq', 5, true);


--
-- TOC entry 4953 (class 0 OID 0)
-- Dependencies: 241
-- Name: rol_id_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rol_id_rol_seq', 1, false);


--
-- TOC entry 4954 (class 0 OID 0)
-- Dependencies: 243
-- Name: subcategoria_id_categoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subcategoria_id_categoria_seq', 1, false);


--
-- TOC entry 4955 (class 0 OID 0)
-- Dependencies: 244
-- Name: subcategoria_id_subcategoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subcategoria_id_subcategoria_seq', 1, false);


--
-- TOC entry 4713 (class 2606 OID 16542)
-- Name: actividad id_actividad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actividad
    ADD CONSTRAINT id_actividad PRIMARY KEY (id_actividad);


--
-- TOC entry 4717 (class 2606 OID 16544)
-- Name: carrera id_carrera; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrera
    ADD CONSTRAINT id_carrera PRIMARY KEY (id_carrera);


--
-- TOC entry 4719 (class 2606 OID 16546)
-- Name: categoria id_categoria; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT id_categoria PRIMARY KEY (id_categoria);


--
-- TOC entry 4721 (class 2606 OID 16548)
-- Name: estado id_estado; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado
    ADD CONSTRAINT id_estado PRIMARY KEY (id_estado);


--
-- TOC entry 4723 (class 2606 OID 16550)
-- Name: instituto id_instituto; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instituto
    ADD CONSTRAINT id_instituto PRIMARY KEY (id_instituto);


--
-- TOC entry 4725 (class 2606 OID 16666)
-- Name: profesor id_profesor; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesor
    ADD CONSTRAINT id_profesor PRIMARY KEY (id_profesor);


--
-- TOC entry 4727 (class 2606 OID 16554)
-- Name: registro id_registro; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro
    ADD CONSTRAINT id_registro PRIMARY KEY (id_registro);


--
-- TOC entry 4729 (class 2606 OID 16556)
-- Name: rol id_rol; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rol
    ADD CONSTRAINT id_rol PRIMARY KEY (id_rol);


--
-- TOC entry 4731 (class 2606 OID 16558)
-- Name: subcategoria id_subcategoria; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcategoria
    ADD CONSTRAINT id_subcategoria PRIMARY KEY (id_subcategoria);


--
-- TOC entry 4715 (class 2606 OID 16641)
-- Name: alumno pk_alumno; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumno
    ADD CONSTRAINT pk_alumno PRIMARY KEY (rut_alumno);


--
-- TOC entry 4736 (class 2606 OID 16642)
-- Name: registro fk_alumno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro
    ADD CONSTRAINT fk_alumno FOREIGN KEY (id_alumno) REFERENCES public.alumno(rut_alumno);


--
-- TOC entry 4737 (class 2606 OID 16566)
-- Name: registro fkey_actividad; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro
    ADD CONSTRAINT fkey_actividad FOREIGN KEY (id_actividad) REFERENCES public.actividad(id_actividad);


--
-- TOC entry 4733 (class 2606 OID 16571)
-- Name: alumno fkey_carrera; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumno
    ADD CONSTRAINT fkey_carrera FOREIGN KEY (id_carrera) REFERENCES public.carrera(id_carrera);


--
-- TOC entry 4740 (class 2606 OID 16576)
-- Name: subcategoria fkey_categoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcategoria
    ADD CONSTRAINT fkey_categoria FOREIGN KEY (id_categoria) REFERENCES public.categoria(id_categoria);


--
-- TOC entry 4738 (class 2606 OID 16581)
-- Name: registro fkey_estado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro
    ADD CONSTRAINT fkey_estado FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado);


--
-- TOC entry 4734 (class 2606 OID 16586)
-- Name: profesor fkey_instituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesor
    ADD CONSTRAINT fkey_instituto FOREIGN KEY (id_instituto) REFERENCES public.instituto(id_instituto);


--
-- TOC entry 4739 (class 2606 OID 16673)
-- Name: registro fkey_profesor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro
    ADD CONSTRAINT fkey_profesor FOREIGN KEY (id_profesor) REFERENCES public.profesor(id_profesor);


--
-- TOC entry 4735 (class 2606 OID 16596)
-- Name: profesor fkey_rol; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesor
    ADD CONSTRAINT fkey_rol FOREIGN KEY (id_rol) REFERENCES public.rol(id_rol);


--
-- TOC entry 4732 (class 2606 OID 16601)
-- Name: actividad fkey_subcategoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actividad
    ADD CONSTRAINT fkey_subcategoria FOREIGN KEY (id_subcategoria) REFERENCES public.subcategoria(id_subcategoria);


-- Completed on 2025-09-27 17:46:16

--
-- PostgreSQL database dump complete
--

\unrestrict kScpQXmSLmwAzbdm4l2e4Ib8hoob8bksphIBY8G0v9YTmtTgVQofl1TkJfE1Zb5

