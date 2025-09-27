-- Script de inicialización completo de RAECDB
-- Deshabilitar verificaciones de claves foráneas temporalmente
SET session_replication_role = replica;
--
-- PostgreSQL database dump
--

\restrict 0iqkgg6c0P9qQfb4sVGLc0Zu0gFvmlEa95P14tg319CURRpvPcWUTn6TI7xAHCt

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

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
-- Name: actividad; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.actividad (
    id_actividad integer NOT NULL,
    nombre_actividad character varying NOT NULL,
    id_subcategoria integer NOT NULL
);


--
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
-- Name: actividad_id_actividad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.actividad_id_actividad_seq OWNED BY public.actividad.id_actividad;


--
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
-- Name: actividad_id_subcategoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.actividad_id_subcategoria_seq OWNED BY public.actividad.id_subcategoria;


--
-- Name: alumno; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alumno (
    rut_alumno character varying(10) NOT NULL,
    nombres character varying(50) NOT NULL,
    apellidos character varying(50) NOT NULL,
    correo character varying(30) NOT NULL,
    ano_egreso integer NOT NULL,
    id_carrera integer NOT NULL
);


--
-- Name: COLUMN alumno.rut_alumno; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.alumno.rut_alumno IS 'Rut sin codigo verificador';


--
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
-- Name: alumno_id_carrera_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.alumno_id_carrera_seq OWNED BY public.alumno.id_carrera;


--
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
-- Name: alumno_rut_alumno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.alumno_rut_alumno_seq OWNED BY public.alumno.rut_alumno;


--
-- Name: carrera; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.carrera (
    id_carrera integer NOT NULL,
    nombre_carrera character varying NOT NULL
);


--
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
-- Name: carrera_id_carrera_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.carrera_id_carrera_seq OWNED BY public.carrera.id_carrera;


--
-- Name: categoria; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categoria (
    id_categoria integer NOT NULL,
    nombre_categoria character varying(100) NOT NULL
);


--
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
-- Name: categoria_id_categoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categoria_id_categoria_seq OWNED BY public.categoria.id_categoria;


--
-- Name: estado; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.estado (
    id_estado integer NOT NULL,
    nombre_estado character varying(25) NOT NULL
);


--
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
-- Name: estado_id_estado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.estado_id_estado_seq OWNED BY public.estado.id_estado;


--
-- Name: instituto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.instituto (
    id_instituto integer NOT NULL,
    nombre_instituto character varying NOT NULL
);


--
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
-- Name: instituto_id_instituto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.instituto_id_instituto_seq OWNED BY public.instituto.id_instituto;


--
-- Name: profesor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.profesor (
    id_profesor integer NOT NULL,
    nombres character varying(50) NOT NULL,
    apellidos character varying(50) NOT NULL,
    correo character varying(30) NOT NULL,
    id_instituto integer NOT NULL,
    id_rol integer NOT NULL,
    password_hash text
);


--
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
-- Name: profesor_id_instituto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.profesor_id_instituto_seq OWNED BY public.profesor.id_instituto;


--
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
-- Name: profesor_id_profesor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.profesor_id_profesor_seq OWNED BY public.profesor.id_profesor;


--
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
-- Name: profesor_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.profesor_id_rol_seq OWNED BY public.profesor.id_rol;


--
-- Name: registro; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.registro (
    fecha_creacion timestamp with time zone NOT NULL,
    fecha_emision timestamp with time zone,
    archivo_data bytea,
    comentario character varying(400),
    id_registro integer NOT NULL,
    id_estado integer,
    id_profesor integer NOT NULL,
    id_actividad integer NOT NULL,
    id_alumno character varying(10) NOT NULL,
    archivo_nombre character varying(255)
);


--
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
-- Name: registro_id_actividad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.registro_id_actividad_seq OWNED BY public.registro.id_actividad;


--
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
-- Name: registro_id_alumno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.registro_id_alumno_seq OWNED BY public.registro.id_alumno;


--
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
-- Name: registro_id_profesor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.registro_id_profesor_seq OWNED BY public.registro.id_profesor;


--
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
-- Name: registro_id_registro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.registro_id_registro_seq OWNED BY public.registro.id_registro;


--
-- Name: rol; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rol (
    id_rol integer NOT NULL,
    nombre_rol character varying NOT NULL
);


--
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
-- Name: rol_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rol_id_rol_seq OWNED BY public.rol.id_rol;


--
-- Name: subcategoria; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.subcategoria (
    id_subcategoria integer NOT NULL,
    subcategoria character varying(100) NOT NULL,
    id_categoria integer NOT NULL
);


--
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
-- Name: subcategoria_id_categoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.subcategoria_id_categoria_seq OWNED BY public.subcategoria.id_categoria;


--
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
-- Name: subcategoria_id_subcategoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.subcategoria_id_subcategoria_seq OWNED BY public.subcategoria.id_subcategoria;


--
-- Name: actividad id_actividad; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actividad ALTER COLUMN id_actividad SET DEFAULT nextval('public.actividad_id_actividad_seq'::regclass);


--
-- Name: actividad id_subcategoria; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actividad ALTER COLUMN id_subcategoria SET DEFAULT nextval('public.actividad_id_subcategoria_seq'::regclass);


--
-- Name: alumno rut_alumno; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alumno ALTER COLUMN rut_alumno SET DEFAULT nextval('public.alumno_rut_alumno_seq'::regclass);


--
-- Name: alumno id_carrera; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alumno ALTER COLUMN id_carrera SET DEFAULT nextval('public.alumno_id_carrera_seq'::regclass);


--
-- Name: carrera id_carrera; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carrera ALTER COLUMN id_carrera SET DEFAULT nextval('public.carrera_id_carrera_seq'::regclass);


--
-- Name: categoria id_categoria; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categoria ALTER COLUMN id_categoria SET DEFAULT nextval('public.categoria_id_categoria_seq'::regclass);


--
-- Name: estado id_estado; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estado ALTER COLUMN id_estado SET DEFAULT nextval('public.estado_id_estado_seq'::regclass);


--
-- Name: instituto id_instituto; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instituto ALTER COLUMN id_instituto SET DEFAULT nextval('public.instituto_id_instituto_seq'::regclass);


--
-- Name: profesor id_profesor; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profesor ALTER COLUMN id_profesor SET DEFAULT nextval('public.profesor_id_profesor_seq'::regclass);


--
-- Name: profesor id_instituto; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profesor ALTER COLUMN id_instituto SET DEFAULT nextval('public.profesor_id_instituto_seq'::regclass);


--
-- Name: profesor id_rol; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profesor ALTER COLUMN id_rol SET DEFAULT nextval('public.profesor_id_rol_seq'::regclass);


--
-- Name: registro id_registro; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registro ALTER COLUMN id_registro SET DEFAULT nextval('public.registro_id_registro_seq'::regclass);


--
-- Name: registro id_profesor; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registro ALTER COLUMN id_profesor SET DEFAULT nextval('public.registro_id_profesor_seq'::regclass);


--
-- Name: registro id_actividad; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registro ALTER COLUMN id_actividad SET DEFAULT nextval('public.registro_id_actividad_seq'::regclass);


--
-- Name: registro id_alumno; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registro ALTER COLUMN id_alumno SET DEFAULT nextval('public.registro_id_alumno_seq'::regclass);


--
-- Name: rol id_rol; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rol ALTER COLUMN id_rol SET DEFAULT nextval('public.rol_id_rol_seq'::regclass);


--
-- Name: subcategoria id_subcategoria; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subcategoria ALTER COLUMN id_subcategoria SET DEFAULT nextval('public.subcategoria_id_subcategoria_seq'::regclass);


--
-- Name: subcategoria id_categoria; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subcategoria ALTER COLUMN id_categoria SET DEFAULT nextval('public.subcategoria_id_categoria_seq'::regclass);


--
-- Name: actividad id_actividad; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actividad
    ADD CONSTRAINT id_actividad PRIMARY KEY (id_actividad);


--
-- Name: carrera id_carrera; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carrera
    ADD CONSTRAINT id_carrera PRIMARY KEY (id_carrera);


--
-- Name: categoria id_categoria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT id_categoria PRIMARY KEY (id_categoria);


--
-- Name: estado id_estado; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estado
    ADD CONSTRAINT id_estado PRIMARY KEY (id_estado);


--
-- Name: instituto id_instituto; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instituto
    ADD CONSTRAINT id_instituto PRIMARY KEY (id_instituto);


--
-- Name: profesor id_profesor; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profesor
    ADD CONSTRAINT id_profesor PRIMARY KEY (id_profesor);


--
-- Name: registro id_registro; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registro
    ADD CONSTRAINT id_registro PRIMARY KEY (id_registro);


--
-- Name: rol id_rol; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rol
    ADD CONSTRAINT id_rol PRIMARY KEY (id_rol);


--
-- Name: subcategoria id_subcategoria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subcategoria
    ADD CONSTRAINT id_subcategoria PRIMARY KEY (id_subcategoria);


--
-- Name: alumno pk_alumno; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alumno
    ADD CONSTRAINT pk_alumno PRIMARY KEY (rut_alumno);


--
-- Name: registro fk_alumno; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registro
    ADD CONSTRAINT fk_alumno FOREIGN KEY (id_alumno) REFERENCES public.alumno(rut_alumno);


--
-- Name: registro fkey_actividad; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registro
    ADD CONSTRAINT fkey_actividad FOREIGN KEY (id_actividad) REFERENCES public.actividad(id_actividad);


--
-- Name: alumno fkey_carrera; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alumno
    ADD CONSTRAINT fkey_carrera FOREIGN KEY (id_carrera) REFERENCES public.carrera(id_carrera);


--
-- Name: subcategoria fkey_categoria; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subcategoria
    ADD CONSTRAINT fkey_categoria FOREIGN KEY (id_categoria) REFERENCES public.categoria(id_categoria);


--
-- Name: registro fkey_estado; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registro
    ADD CONSTRAINT fkey_estado FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado);


--
-- Name: profesor fkey_instituto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profesor
    ADD CONSTRAINT fkey_instituto FOREIGN KEY (id_instituto) REFERENCES public.instituto(id_instituto);


--
-- Name: registro fkey_profesor; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registro
    ADD CONSTRAINT fkey_profesor FOREIGN KEY (id_profesor) REFERENCES public.profesor(id_profesor);


--
-- Name: profesor fkey_rol; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profesor
    ADD CONSTRAINT fkey_rol FOREIGN KEY (id_rol) REFERENCES public.rol(id_rol);


--
-- Name: actividad fkey_subcategoria; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actividad
    ADD CONSTRAINT fkey_subcategoria FOREIGN KEY (id_subcategoria) REFERENCES public.subcategoria(id_subcategoria);


--
-- PostgreSQL database dump complete
--

\unrestrict 0iqkgg6c0P9qQfb4sVGLc0Zu0gFvmlEa95P14tg319CURRpvPcWUTn6TI7xAHCt

--
-- PostgreSQL database dump
--

\restrict u7tsUlLbmzWoD01whSakFeuyal2pXf0kaPnlqAz8fXUMufyC6R7eRvTbDzS1glc

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

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

--
-- Data for Name: actividad; Type: TABLE DATA; Schema: public; Owner: -
--

SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.actividad DISABLE TRIGGER ALL;

COPY public.actividad (id_actividad, nombre_actividad, id_subcategoria) FROM stdin;
1	Docencia	1
2	Investigación	1
3	Extensión	1
4	Dirigencias	1
5	Deportivos	1
6	Social	1
\.


ALTER TABLE public.actividad ENABLE TRIGGER ALL;

--
-- Data for Name: alumno; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.alumno DISABLE TRIGGER ALL;

COPY public.alumno (rut_alumno, nombres, apellidos, correo, ano_egreso, id_carrera) FROM stdin;
12345678-9	Juan P	Smith A	juansmith@alumnos.uach.cl	2024	1
\.


ALTER TABLE public.alumno ENABLE TRIGGER ALL;

--
-- Data for Name: carrera; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.carrera DISABLE TRIGGER ALL;

COPY public.carrera (id_carrera, nombre_carrera) FROM stdin;
1	informatica
\.


ALTER TABLE public.carrera ENABLE TRIGGER ALL;

--
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.categoria DISABLE TRIGGER ALL;

COPY public.categoria (id_categoria, nombre_categoria) FROM stdin;
2	No academica
1	Academica
\.


ALTER TABLE public.categoria ENABLE TRIGGER ALL;

--
-- Data for Name: estado; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.estado DISABLE TRIGGER ALL;

COPY public.estado (id_estado, nombre_estado) FROM stdin;
1	pendiente
\.


ALTER TABLE public.estado ENABLE TRIGGER ALL;

--
-- Data for Name: instituto; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.instituto DISABLE TRIGGER ALL;

COPY public.instituto (id_instituto, nombre_instituto) FROM stdin;
1	informatica
\.


ALTER TABLE public.instituto ENABLE TRIGGER ALL;

--
-- Data for Name: profesor; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.profesor DISABLE TRIGGER ALL;

COPY public.profesor (id_profesor, nombres, apellidos, correo, id_instituto, id_rol, password_hash) FROM stdin;
1	Luis	Veas	lveas@example.com	1	1	$2b$12$UTt1hNZDukYMzFbq2O8L0OMbLATqO7SyN8kU9KKZA92zbKiMHVQRO
\.


ALTER TABLE public.profesor ENABLE TRIGGER ALL;

--
-- Data for Name: registro; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.registro DISABLE TRIGGER ALL;

COPY public.registro (fecha_creacion, fecha_emision, archivo_data, comentario, id_registro, id_estado, id_profesor, id_actividad, id_alumno, archivo_nombre) FROM stdin;
2025-09-20 02:05:10.157143-03	2025-09-20 02:05:10.213807-03	\N		1	1	1	1	12345678-9	\N
2025-09-20 02:56:42.35172-03	2025-09-20 02:56:42.353725-03	\N		2	1	1	2	12345678-9	\N
2025-09-20 03:10:29.28957-03	2025-09-20 03:10:29.290585-03	\N		3	1	1	4	12345678-9	\N
\.


ALTER TABLE public.registro ENABLE TRIGGER ALL;

--
-- Data for Name: rol; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.rol DISABLE TRIGGER ALL;

COPY public.rol (id_rol, nombre_rol) FROM stdin;
1	profesor
\.


ALTER TABLE public.rol ENABLE TRIGGER ALL;

--
-- Data for Name: subcategoria; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.subcategoria DISABLE TRIGGER ALL;

COPY public.subcategoria (id_subcategoria, subcategoria, id_categoria) FROM stdin;
1	To_expande	1
\.


ALTER TABLE public.subcategoria ENABLE TRIGGER ALL;

--
-- Name: actividad_id_actividad_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.actividad_id_actividad_seq', 1, false);


--
-- Name: actividad_id_subcategoria_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.actividad_id_subcategoria_seq', 1, false);


--
-- Name: alumno_id_carrera_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.alumno_id_carrera_seq', 1, false);


--
-- Name: alumno_rut_alumno_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.alumno_rut_alumno_seq', 1, false);


--
-- Name: carrera_id_carrera_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.carrera_id_carrera_seq', 1, false);


--
-- Name: categoria_id_categoria_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categoria_id_categoria_seq', 1, false);


--
-- Name: estado_id_estado_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.estado_id_estado_seq', 1, false);


--
-- Name: instituto_id_instituto_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.instituto_id_instituto_seq', 1, false);


--
-- Name: profesor_id_instituto_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.profesor_id_instituto_seq', 1, false);


--
-- Name: profesor_id_profesor_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.profesor_id_profesor_seq', 1, true);


--
-- Name: profesor_id_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.profesor_id_rol_seq', 1, false);


--
-- Name: registro_id_actividad_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.registro_id_actividad_seq', 1, false);


--
-- Name: registro_id_alumno_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.registro_id_alumno_seq', 1, false);


--
-- Name: registro_id_profesor_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.registro_id_profesor_seq', 1, false);


--
-- Name: registro_id_registro_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.registro_id_registro_seq', 3, true);


--
-- Name: rol_id_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rol_id_rol_seq', 1, false);


--
-- Name: subcategoria_id_categoria_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.subcategoria_id_categoria_seq', 1, false);


--
-- Name: subcategoria_id_subcategoria_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.subcategoria_id_subcategoria_seq', 1, false);


--
-- PostgreSQL database dump complete
--

\unrestrict u7tsUlLbmzWoD01whSakFeuyal2pXf0kaPnlqAz8fXUMufyC6R7eRvTbDzS1glc


-- Rehabilitar verificaciones de claves for�neas
SET session_replication_role = DEFAULT;
