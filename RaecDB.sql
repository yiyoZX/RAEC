--
-- PostgreSQL database dump
--

\restrict ZIHMFRck4ufbV7xYZvJTNdlUeWbKa9b8Rxn3CRpELvDeg8usaUBzlib6W4JjCbI

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

-- Started on 2025-09-16 16:28:06

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
-- TOC entry 228 (class 1259 OID 16451)
-- Name: actividad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.actividad (
    id_actividad integer NOT NULL,
    nombre_actividad character varying NOT NULL,
    id_subcategoria integer NOT NULL
);


ALTER TABLE public.actividad OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16449)
-- Name: actividad_id_actividad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.actividad_id_actividad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.actividad_id_actividad_seq OWNER TO postgres;

--
-- TOC entry 4919 (class 0 OID 0)
-- Dependencies: 226
-- Name: actividad_id_actividad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.actividad_id_actividad_seq OWNED BY public.actividad.id_actividad;


--
-- TOC entry 227 (class 1259 OID 16450)
-- Name: actividad_id_subcategoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.actividad_id_subcategoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.actividad_id_subcategoria_seq OWNER TO postgres;

--
-- TOC entry 4920 (class 0 OID 0)
-- Dependencies: 227
-- Name: actividad_id_subcategoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.actividad_id_subcategoria_seq OWNED BY public.actividad.id_subcategoria;


--
-- TOC entry 233 (class 1259 OID 16476)
-- Name: alumno; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alumno (
    rut_alumno integer NOT NULL,
    verificador character varying NOT NULL,
    nombres character varying(50) NOT NULL,
    apellidos character varying(50) NOT NULL,
    correo character varying(30) NOT NULL,
    ano_egreso integer NOT NULL,
    id_carrera integer NOT NULL
);


ALTER TABLE public.alumno OWNER TO postgres;

--
-- TOC entry 4921 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN alumno.rut_alumno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.alumno.rut_alumno IS 'Rut sin codigo verificador';


--
-- TOC entry 4922 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN alumno.verificador; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.alumno.verificador IS 'Codigo verificador del rut';


--
-- TOC entry 232 (class 1259 OID 16475)
-- Name: alumno_id_carrera_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.alumno_id_carrera_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.alumno_id_carrera_seq OWNER TO postgres;

--
-- TOC entry 4923 (class 0 OID 0)
-- Dependencies: 232
-- Name: alumno_id_carrera_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.alumno_id_carrera_seq OWNED BY public.alumno.id_carrera;


--
-- TOC entry 231 (class 1259 OID 16474)
-- Name: alumno_rut_alumno_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.alumno_rut_alumno_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.alumno_rut_alumno_seq OWNER TO postgres;

--
-- TOC entry 4924 (class 0 OID 0)
-- Dependencies: 231
-- Name: alumno_rut_alumno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.alumno_rut_alumno_seq OWNED BY public.alumno.rut_alumno;


--
-- TOC entry 230 (class 1259 OID 16466)
-- Name: carrera; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carrera (
    id_carrera integer NOT NULL,
    nombre_carrera character varying NOT NULL
);


ALTER TABLE public.carrera OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16465)
-- Name: carrera_id_carrera_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carrera_id_carrera_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.carrera_id_carrera_seq OWNER TO postgres;

--
-- TOC entry 4925 (class 0 OID 0)
-- Dependencies: 229
-- Name: carrera_id_carrera_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carrera_id_carrera_seq OWNED BY public.carrera.id_carrera;


--
-- TOC entry 222 (class 1259 OID 16422)
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria (
    id_categoria integer NOT NULL,
    nombre_categoria character varying(100) NOT NULL
);


ALTER TABLE public.categoria OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16421)
-- Name: categoria_id_categoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categoria_id_categoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categoria_id_categoria_seq OWNER TO postgres;

--
-- TOC entry 4926 (class 0 OID 0)
-- Dependencies: 221
-- Name: categoria_id_categoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categoria_id_categoria_seq OWNED BY public.categoria.id_categoria;


--
-- TOC entry 220 (class 1259 OID 16410)
-- Name: estado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estado (
    id_estado integer NOT NULL,
    nombre_estado character varying(25) NOT NULL
);


ALTER TABLE public.estado OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16409)
-- Name: estado_id_estado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estado_id_estado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.estado_id_estado_seq OWNER TO postgres;

--
-- TOC entry 4927 (class 0 OID 0)
-- Dependencies: 219
-- Name: estado_id_estado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estado_id_estado_seq OWNED BY public.estado.id_estado;


--
-- TOC entry 237 (class 1259 OID 16500)
-- Name: instituto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instituto (
    id_instituto integer NOT NULL,
    nombre_instituto character varying NOT NULL
);


ALTER TABLE public.instituto OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16499)
-- Name: instituto_id_instituto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.instituto_id_instituto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.instituto_id_instituto_seq OWNER TO postgres;

--
-- TOC entry 4928 (class 0 OID 0)
-- Dependencies: 236
-- Name: instituto_id_instituto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.instituto_id_instituto_seq OWNED BY public.instituto.id_instituto;


--
-- TOC entry 241 (class 1259 OID 16511)
-- Name: profesor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profesor (
    id_profesor integer NOT NULL,
    nombres character varying(50) NOT NULL,
    apellidos character varying(50) NOT NULL,
    correo character varying(30) NOT NULL,
    id_instituto integer NOT NULL,
    id_rol integer NOT NULL
);


ALTER TABLE public.profesor OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16509)
-- Name: profesor_id_instituto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.profesor_id_instituto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.profesor_id_instituto_seq OWNER TO postgres;

--
-- TOC entry 4929 (class 0 OID 0)
-- Dependencies: 239
-- Name: profesor_id_instituto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.profesor_id_instituto_seq OWNED BY public.profesor.id_instituto;


--
-- TOC entry 238 (class 1259 OID 16508)
-- Name: profesor_id_profesor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.profesor_id_profesor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.profesor_id_profesor_seq OWNER TO postgres;

--
-- TOC entry 4930 (class 0 OID 0)
-- Dependencies: 238
-- Name: profesor_id_profesor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.profesor_id_profesor_seq OWNED BY public.profesor.id_profesor;


--
-- TOC entry 240 (class 1259 OID 16510)
-- Name: profesor_id_rol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.profesor_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.profesor_id_rol_seq OWNER TO postgres;

--
-- TOC entry 4931 (class 0 OID 0)
-- Dependencies: 240
-- Name: profesor_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.profesor_id_rol_seq OWNED BY public.profesor.id_rol;


--
-- TOC entry 217 (class 1259 OID 16392)
-- Name: registro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.registro (
    fecha_creacion timestamp with time zone NOT NULL,
    fecha_emision timestamp with time zone,
    evidencia bytea,
    comentario character varying(400),
    id_registro integer NOT NULL,
    id_estado integer,
    id_profesor integer NOT NULL,
    id_actividad integer NOT NULL,
    id_alumno integer NOT NULL,
    verificador character varying NOT NULL
);


ALTER TABLE public.registro OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16565)
-- Name: registro_id_actividad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.registro_id_actividad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.registro_id_actividad_seq OWNER TO postgres;

--
-- TOC entry 4932 (class 0 OID 0)
-- Dependencies: 243
-- Name: registro_id_actividad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.registro_id_actividad_seq OWNED BY public.registro.id_actividad;


--
-- TOC entry 244 (class 1259 OID 16588)
-- Name: registro_id_alumno_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.registro_id_alumno_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.registro_id_alumno_seq OWNER TO postgres;

--
-- TOC entry 4933 (class 0 OID 0)
-- Dependencies: 244
-- Name: registro_id_alumno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.registro_id_alumno_seq OWNED BY public.registro.id_alumno;


--
-- TOC entry 242 (class 1259 OID 16552)
-- Name: registro_id_profesor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.registro_id_profesor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.registro_id_profesor_seq OWNER TO postgres;

--
-- TOC entry 4934 (class 0 OID 0)
-- Dependencies: 242
-- Name: registro_id_profesor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.registro_id_profesor_seq OWNED BY public.registro.id_profesor;


--
-- TOC entry 218 (class 1259 OID 16400)
-- Name: registro_id_registro_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.registro_id_registro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.registro_id_registro_seq OWNER TO postgres;

--
-- TOC entry 4935 (class 0 OID 0)
-- Dependencies: 218
-- Name: registro_id_registro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.registro_id_registro_seq OWNED BY public.registro.id_registro;


--
-- TOC entry 235 (class 1259 OID 16491)
-- Name: rol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rol (
    id_rol integer NOT NULL,
    nombre_rol character varying NOT NULL
);


ALTER TABLE public.rol OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16490)
-- Name: rol_id_rol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rol_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rol_id_rol_seq OWNER TO postgres;

--
-- TOC entry 4936 (class 0 OID 0)
-- Dependencies: 234
-- Name: rol_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rol_id_rol_seq OWNED BY public.rol.id_rol;


--
-- TOC entry 225 (class 1259 OID 16437)
-- Name: subcategoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subcategoria (
    id_subcategoria integer NOT NULL,
    subcategoria character varying(100) NOT NULL,
    id_categoria integer NOT NULL
);


ALTER TABLE public.subcategoria OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16436)
-- Name: subcategoria_id_categoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subcategoria_id_categoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subcategoria_id_categoria_seq OWNER TO postgres;

--
-- TOC entry 4937 (class 0 OID 0)
-- Dependencies: 224
-- Name: subcategoria_id_categoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subcategoria_id_categoria_seq OWNED BY public.subcategoria.id_categoria;


--
-- TOC entry 223 (class 1259 OID 16435)
-- Name: subcategoria_id_subcategoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subcategoria_id_subcategoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subcategoria_id_subcategoria_seq OWNER TO postgres;

--
-- TOC entry 4938 (class 0 OID 0)
-- Dependencies: 223
-- Name: subcategoria_id_subcategoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subcategoria_id_subcategoria_seq OWNED BY public.subcategoria.id_subcategoria;


--
-- TOC entry 4702 (class 2604 OID 16454)
-- Name: actividad id_actividad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actividad ALTER COLUMN id_actividad SET DEFAULT nextval('public.actividad_id_actividad_seq'::regclass);


--
-- TOC entry 4703 (class 2604 OID 16455)
-- Name: actividad id_subcategoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actividad ALTER COLUMN id_subcategoria SET DEFAULT nextval('public.actividad_id_subcategoria_seq'::regclass);


--
-- TOC entry 4705 (class 2604 OID 16479)
-- Name: alumno rut_alumno; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumno ALTER COLUMN rut_alumno SET DEFAULT nextval('public.alumno_rut_alumno_seq'::regclass);


--
-- TOC entry 4706 (class 2604 OID 16480)
-- Name: alumno id_carrera; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumno ALTER COLUMN id_carrera SET DEFAULT nextval('public.alumno_id_carrera_seq'::regclass);


--
-- TOC entry 4704 (class 2604 OID 16469)
-- Name: carrera id_carrera; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrera ALTER COLUMN id_carrera SET DEFAULT nextval('public.carrera_id_carrera_seq'::regclass);


--
-- TOC entry 4699 (class 2604 OID 16425)
-- Name: categoria id_categoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria ALTER COLUMN id_categoria SET DEFAULT nextval('public.categoria_id_categoria_seq'::regclass);


--
-- TOC entry 4698 (class 2604 OID 16413)
-- Name: estado id_estado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado ALTER COLUMN id_estado SET DEFAULT nextval('public.estado_id_estado_seq'::regclass);


--
-- TOC entry 4708 (class 2604 OID 16503)
-- Name: instituto id_instituto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instituto ALTER COLUMN id_instituto SET DEFAULT nextval('public.instituto_id_instituto_seq'::regclass);


--
-- TOC entry 4709 (class 2604 OID 16514)
-- Name: profesor id_profesor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesor ALTER COLUMN id_profesor SET DEFAULT nextval('public.profesor_id_profesor_seq'::regclass);


--
-- TOC entry 4710 (class 2604 OID 16515)
-- Name: profesor id_instituto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesor ALTER COLUMN id_instituto SET DEFAULT nextval('public.profesor_id_instituto_seq'::regclass);


--
-- TOC entry 4711 (class 2604 OID 16516)
-- Name: profesor id_rol; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesor ALTER COLUMN id_rol SET DEFAULT nextval('public.profesor_id_rol_seq'::regclass);


--
-- TOC entry 4694 (class 2604 OID 16401)
-- Name: registro id_registro; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro ALTER COLUMN id_registro SET DEFAULT nextval('public.registro_id_registro_seq'::regclass);


--
-- TOC entry 4695 (class 2604 OID 16553)
-- Name: registro id_profesor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro ALTER COLUMN id_profesor SET DEFAULT nextval('public.registro_id_profesor_seq'::regclass);


--
-- TOC entry 4696 (class 2604 OID 16566)
-- Name: registro id_actividad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro ALTER COLUMN id_actividad SET DEFAULT nextval('public.registro_id_actividad_seq'::regclass);


--
-- TOC entry 4697 (class 2604 OID 16589)
-- Name: registro id_alumno; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro ALTER COLUMN id_alumno SET DEFAULT nextval('public.registro_id_alumno_seq'::regclass);


--
-- TOC entry 4707 (class 2604 OID 16494)
-- Name: rol id_rol; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rol ALTER COLUMN id_rol SET DEFAULT nextval('public.rol_id_rol_seq'::regclass);


--
-- TOC entry 4700 (class 2604 OID 16440)
-- Name: subcategoria id_subcategoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcategoria ALTER COLUMN id_subcategoria SET DEFAULT nextval('public.subcategoria_id_subcategoria_seq'::regclass);


--
-- TOC entry 4701 (class 2604 OID 16441)
-- Name: subcategoria id_categoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcategoria ALTER COLUMN id_categoria SET DEFAULT nextval('public.subcategoria_id_categoria_seq'::regclass);


--
-- TOC entry 4897 (class 0 OID 16451)
-- Dependencies: 228
-- Data for Name: actividad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.actividad (id_actividad, nombre_actividad, id_subcategoria) FROM stdin;
1	proyectos	1
\.


--
-- TOC entry 4902 (class 0 OID 16476)
-- Dependencies: 233
-- Data for Name: alumno; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alumno (rut_alumno, verificador, nombres, apellidos, correo, ano_egreso, id_carrera) FROM stdin;
12345678	9	Juan P	Smith A	juansmith@alumnos.uach.cl	2024	1
\.


--
-- TOC entry 4899 (class 0 OID 16466)
-- Dependencies: 230
-- Data for Name: carrera; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carrera (id_carrera, nombre_carrera) FROM stdin;
1	informatica
\.


--
-- TOC entry 4891 (class 0 OID 16422)
-- Dependencies: 222
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categoria (id_categoria, nombre_categoria) FROM stdin;
1	creacion de software
\.


--
-- TOC entry 4889 (class 0 OID 16410)
-- Dependencies: 220
-- Data for Name: estado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estado (id_estado, nombre_estado) FROM stdin;
1	pendiente
\.


--
-- TOC entry 4906 (class 0 OID 16500)
-- Dependencies: 237
-- Data for Name: instituto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instituto (id_instituto, nombre_instituto) FROM stdin;
1	informatica
\.


--
-- TOC entry 4910 (class 0 OID 16511)
-- Dependencies: 241
-- Data for Name: profesor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profesor (id_profesor, nombres, apellidos, correo, id_instituto, id_rol) FROM stdin;
87654321	Mauricio	Ruiz-Tagle	mtagle@uach.cl	1	1
\.


--
-- TOC entry 4886 (class 0 OID 16392)
-- Dependencies: 217
-- Data for Name: registro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.registro (fecha_creacion, fecha_emision, evidencia, comentario, id_registro, id_estado, id_profesor, id_actividad, id_alumno, verificador) FROM stdin;
\.


--
-- TOC entry 4904 (class 0 OID 16491)
-- Dependencies: 235
-- Data for Name: rol; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rol (id_rol, nombre_rol) FROM stdin;
1	profesor
\.


--
-- TOC entry 4894 (class 0 OID 16437)
-- Dependencies: 225
-- Data for Name: subcategoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subcategoria (id_subcategoria, subcategoria, id_categoria) FROM stdin;
1	backend	1
\.


--
-- TOC entry 4939 (class 0 OID 0)
-- Dependencies: 226
-- Name: actividad_id_actividad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.actividad_id_actividad_seq', 1, false);


--
-- TOC entry 4940 (class 0 OID 0)
-- Dependencies: 227
-- Name: actividad_id_subcategoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.actividad_id_subcategoria_seq', 1, false);


--
-- TOC entry 4941 (class 0 OID 0)
-- Dependencies: 232
-- Name: alumno_id_carrera_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alumno_id_carrera_seq', 1, false);


--
-- TOC entry 4942 (class 0 OID 0)
-- Dependencies: 231
-- Name: alumno_rut_alumno_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alumno_rut_alumno_seq', 1, false);


--
-- TOC entry 4943 (class 0 OID 0)
-- Dependencies: 229
-- Name: carrera_id_carrera_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carrera_id_carrera_seq', 1, false);


--
-- TOC entry 4944 (class 0 OID 0)
-- Dependencies: 221
-- Name: categoria_id_categoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categoria_id_categoria_seq', 1, false);


--
-- TOC entry 4945 (class 0 OID 0)
-- Dependencies: 219
-- Name: estado_id_estado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estado_id_estado_seq', 1, false);


--
-- TOC entry 4946 (class 0 OID 0)
-- Dependencies: 236
-- Name: instituto_id_instituto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instituto_id_instituto_seq', 1, false);


--
-- TOC entry 4947 (class 0 OID 0)
-- Dependencies: 239
-- Name: profesor_id_instituto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.profesor_id_instituto_seq', 1, false);


--
-- TOC entry 4948 (class 0 OID 0)
-- Dependencies: 238
-- Name: profesor_id_profesor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.profesor_id_profesor_seq', 1, false);


--
-- TOC entry 4949 (class 0 OID 0)
-- Dependencies: 240
-- Name: profesor_id_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.profesor_id_rol_seq', 1, false);


--
-- TOC entry 4950 (class 0 OID 0)
-- Dependencies: 243
-- Name: registro_id_actividad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.registro_id_actividad_seq', 1, false);


--
-- TOC entry 4951 (class 0 OID 0)
-- Dependencies: 244
-- Name: registro_id_alumno_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.registro_id_alumno_seq', 1, false);


--
-- TOC entry 4952 (class 0 OID 0)
-- Dependencies: 242
-- Name: registro_id_profesor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.registro_id_profesor_seq', 1, false);


--
-- TOC entry 4953 (class 0 OID 0)
-- Dependencies: 218
-- Name: registro_id_registro_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.registro_id_registro_seq', 1, false);


--
-- TOC entry 4954 (class 0 OID 0)
-- Dependencies: 234
-- Name: rol_id_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rol_id_rol_seq', 1, false);


--
-- TOC entry 4955 (class 0 OID 0)
-- Dependencies: 224
-- Name: subcategoria_id_categoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subcategoria_id_categoria_seq', 1, false);


--
-- TOC entry 4956 (class 0 OID 0)
-- Dependencies: 223
-- Name: subcategoria_id_subcategoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subcategoria_id_subcategoria_seq', 1, false);


--
-- TOC entry 4721 (class 2606 OID 16459)
-- Name: actividad id_actividad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actividad
    ADD CONSTRAINT id_actividad PRIMARY KEY (id_actividad);


--
-- TOC entry 4723 (class 2606 OID 16473)
-- Name: carrera id_carrera; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrera
    ADD CONSTRAINT id_carrera PRIMARY KEY (id_carrera);


--
-- TOC entry 4717 (class 2606 OID 16427)
-- Name: categoria id_categoria; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT id_categoria PRIMARY KEY (id_categoria);


--
-- TOC entry 4715 (class 2606 OID 16415)
-- Name: estado id_estado; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado
    ADD CONSTRAINT id_estado PRIMARY KEY (id_estado);


--
-- TOC entry 4729 (class 2606 OID 16507)
-- Name: instituto id_instituto; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instituto
    ADD CONSTRAINT id_instituto PRIMARY KEY (id_instituto);


--
-- TOC entry 4731 (class 2606 OID 16518)
-- Name: profesor id_profesor; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesor
    ADD CONSTRAINT id_profesor PRIMARY KEY (id_profesor);


--
-- TOC entry 4713 (class 2606 OID 16408)
-- Name: registro id_registro; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro
    ADD CONSTRAINT id_registro PRIMARY KEY (id_registro);


--
-- TOC entry 4727 (class 2606 OID 16498)
-- Name: rol id_rol; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rol
    ADD CONSTRAINT id_rol PRIMARY KEY (id_rol);


--
-- TOC entry 4719 (class 2606 OID 16443)
-- Name: subcategoria id_subcategoria; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcategoria
    ADD CONSTRAINT id_subcategoria PRIMARY KEY (id_subcategoria);


--
-- TOC entry 4725 (class 2606 OID 16484)
-- Name: alumno rut_alumno; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumno
    ADD CONSTRAINT rut_alumno PRIMARY KEY (rut_alumno, verificador);


--
-- TOC entry 4732 (class 2606 OID 16596)
-- Name: registro fk_alumno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro
    ADD CONSTRAINT fk_alumno FOREIGN KEY (id_alumno, verificador) REFERENCES public.alumno(rut_alumno, verificador);


--
-- TOC entry 4733 (class 2606 OID 16567)
-- Name: registro fkey_actividad; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro
    ADD CONSTRAINT fkey_actividad FOREIGN KEY (id_actividad) REFERENCES public.actividad(id_actividad);


--
-- TOC entry 4738 (class 2606 OID 16485)
-- Name: alumno fkey_carrera; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumno
    ADD CONSTRAINT fkey_carrera FOREIGN KEY (id_carrera) REFERENCES public.carrera(id_carrera);


--
-- TOC entry 4736 (class 2606 OID 16444)
-- Name: subcategoria fkey_categoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcategoria
    ADD CONSTRAINT fkey_categoria FOREIGN KEY (id_categoria) REFERENCES public.categoria(id_categoria);


--
-- TOC entry 4734 (class 2606 OID 16416)
-- Name: registro fkey_estado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro
    ADD CONSTRAINT fkey_estado FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado);


--
-- TOC entry 4739 (class 2606 OID 16524)
-- Name: profesor fkey_instituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesor
    ADD CONSTRAINT fkey_instituto FOREIGN KEY (id_instituto) REFERENCES public.instituto(id_instituto);


--
-- TOC entry 4735 (class 2606 OID 16554)
-- Name: registro fkey_profesor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro
    ADD CONSTRAINT fkey_profesor FOREIGN KEY (id_profesor) REFERENCES public.profesor(id_profesor);


--
-- TOC entry 4740 (class 2606 OID 16519)
-- Name: profesor fkey_rol; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesor
    ADD CONSTRAINT fkey_rol FOREIGN KEY (id_rol) REFERENCES public.rol(id_rol);


--
-- TOC entry 4737 (class 2606 OID 16460)
-- Name: actividad fkey_subcategoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actividad
    ADD CONSTRAINT fkey_subcategoria FOREIGN KEY (id_subcategoria) REFERENCES public.subcategoria(id_subcategoria);


-- Completed on 2025-09-16 16:28:07

--
-- PostgreSQL database dump complete
--

\unrestrict ZIHMFRck4ufbV7xYZvJTNdlUeWbKa9b8Rxn3CRpELvDeg8usaUBzlib6W4JjCbI

