--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2
-- Dumped by pg_dump version 11.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS uav_recon;
--
-- Name: uav_recon; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE uav_recon WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE uav_recon OWNER TO postgres;

\connect uav_recon

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: company; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.company (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.company OWNER TO postgres;

--
-- Name: company_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.company_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.company_id_seq OWNER TO postgres;

--
-- Name: company_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.company_id_seq OWNED BY public.company.id;


--
-- Name: condition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.condition (
    id integer NOT NULL,
    description text,
    type character varying(255),
    defect_id integer
);


ALTER TABLE public.condition OWNER TO postgres;

--
-- Name: condition_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.condition_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.condition_id_seq OWNER TO postgres;

--
-- Name: condition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.condition_id_seq OWNED BY public.condition.id;


--
-- Name: defect; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.defect (
    id integer NOT NULL,
    name character varying(255),
    number integer,
    material_id integer
);


ALTER TABLE public.defect OWNER TO postgres;

--
-- Name: defect_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.defect_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.defect_id_seq OWNER TO postgres;

--
-- Name: defect_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.defect_id_seq OWNED BY public.defect.id;


--
-- Name: inspection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inspection (
    id integer NOT NULL,
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    structure_id integer,
    status character varying(255),
    company_id integer,
    inspector_id integer,
    general_summary text,
    term_rating character varying(255),
    sgr_rating character varying(255),
    temperature double precision,
    humidity double precision,
    wind double precision
);


ALTER TABLE public.inspection OWNER TO postgres;

--
-- Name: inspection_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inspection_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inspection_id_seq OWNER TO postgres;

--
-- Name: inspection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inspection_id_seq OWNED BY public.inspection.id;


--
-- Name: inspector; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inspector (
    id integer NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    email character varying(255),
    "position" character varying(255)
);


ALTER TABLE public.inspector OWNER TO postgres;

--
-- Name: inspector_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inspector_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inspector_id_seq OWNER TO postgres;

--
-- Name: inspector_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inspector_id_seq OWNED BY public.inspector.id;


--
-- Name: material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.material (
    id integer NOT NULL,
    name character varying(255),
    description text,
    measure_unit character varying(50),
    subcomponent_id integer
);


ALTER TABLE public.material OWNER TO postgres;

--
-- Name: material_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.material_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.material_id_seq OWNER TO postgres;

--
-- Name: material_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.material_id_seq OWNED BY public.material.id;


--
-- Name: observation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.observation (
    id integer NOT NULL,
    code character varying(50),
    inspection_id integer,
    drawing_number character varying(255),
    room_number character varying(255),
    span_number character varying(255),
    location_description text,
    structural_component_id integer,
    subcomponent_id integer
);


ALTER TABLE public.observation OWNER TO postgres;

--
-- Name: observation_defect; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.observation_defect (
    id integer NOT NULL,
    defect_id integer,
    condition_id integer,
    observation_id integer,
    description text,
    material_id integer,
    critical_findings text,
    size character varying(255)
);


ALTER TABLE public.observation_defect OWNER TO postgres;

--
-- Name: observation_defect_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.observation_defect_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.observation_defect_id_seq OWNER TO postgres;

--
-- Name: observation_defect_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.observation_defect_id_seq OWNED BY public.observation_defect.id;


--
-- Name: observation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.observation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.observation_id_seq OWNER TO postgres;

--
-- Name: observation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.observation_id_seq OWNED BY public.observation.id;


--
-- Name: photo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.photo (
    id integer NOT NULL,
    file character varying(255),
    latitude double precision,
    longitude double precision,
    altitude double precision,
    start_x double precision,
    start_y double precision,
    end_x double precision,
    end_y double precision,
    created_date timestamp without time zone,
    observation_defect_id integer
);


ALTER TABLE public.photo OWNER TO postgres;

--
-- Name: photo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.photo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.photo_id_seq OWNER TO postgres;

--
-- Name: photo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.photo_id_seq OWNED BY public.photo.id;


--
-- Name: report; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.report (
    id integer NOT NULL,
    date timestamp without time zone,
    file character varying(255),
    inspection_id integer
);


ALTER TABLE public.report OWNER TO postgres;

--
-- Name: report_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.report_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.report_id_seq OWNER TO postgres;

--
-- Name: report_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.report_id_seq OWNED BY public.report.id;


--
-- Name: structural_component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.structural_component (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.structural_component OWNER TO postgres;

--
-- Name: structural_component_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.structural_component_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.structural_component_id_seq OWNER TO postgres;

--
-- Name: structural_component_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.structural_component_id_seq OWNED BY public.structural_component.id;


--
-- Name: structure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.structure (
    id integer NOT NULL,
    code character varying(50),
    name character varying(255),
    type character varying(255),
    primary_owner character varying(255),
    caltrans_bridge_no character varying(255),
    postmile double precision,
    begin_stationing character varying(255),
    end_stationing character varying(255)
);


ALTER TABLE public.structure OWNER TO postgres;

--
-- Name: structure_component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.structure_component (
    id integer NOT NULL,
    component_id integer,
    structure_id integer
);


ALTER TABLE public.structure_component OWNER TO postgres;

--
-- Name: structure_component_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.structure_component_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.structure_component_id_seq OWNER TO postgres;

--
-- Name: structure_component_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.structure_component_id_seq OWNED BY public.structure_component.id;


--
-- Name: structure_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.structure_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.structure_id_seq OWNER TO postgres;

--
-- Name: structure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.structure_id_seq OWNED BY public.structure.id;


--
-- Name: subcomponent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subcomponent (
    id integer NOT NULL,
    name character varying(255),
    structural_id integer
);


ALTER TABLE public.subcomponent OWNER TO postgres;

--
-- Name: subcomponent_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subcomponent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subcomponent_id_seq OWNER TO postgres;

--
-- Name: subcomponent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subcomponent_id_seq OWNED BY public.subcomponent.id;


--
-- Name: company id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company ALTER COLUMN id SET DEFAULT nextval('public.company_id_seq'::regclass);


--
-- Name: condition id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.condition ALTER COLUMN id SET DEFAULT nextval('public.condition_id_seq'::regclass);


--
-- Name: defect id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect ALTER COLUMN id SET DEFAULT nextval('public.defect_id_seq'::regclass);


--
-- Name: inspection id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inspection ALTER COLUMN id SET DEFAULT nextval('public.inspection_id_seq'::regclass);


--
-- Name: inspector id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inspector ALTER COLUMN id SET DEFAULT nextval('public.inspector_id_seq'::regclass);


--
-- Name: material id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material ALTER COLUMN id SET DEFAULT nextval('public.material_id_seq'::regclass);


--
-- Name: observation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.observation ALTER COLUMN id SET DEFAULT nextval('public.observation_id_seq'::regclass);


--
-- Name: observation_defect id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.observation_defect ALTER COLUMN id SET DEFAULT nextval('public.observation_defect_id_seq'::regclass);


--
-- Name: photo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photo ALTER COLUMN id SET DEFAULT nextval('public.photo_id_seq'::regclass);


--
-- Name: report id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.report ALTER COLUMN id SET DEFAULT nextval('public.report_id_seq'::regclass);


--
-- Name: structural_component id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.structural_component ALTER COLUMN id SET DEFAULT nextval('public.structural_component_id_seq'::regclass);


--
-- Name: structure id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.structure ALTER COLUMN id SET DEFAULT nextval('public.structure_id_seq'::regclass);


--
-- Name: structure_component id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.structure_component ALTER COLUMN id SET DEFAULT nextval('public.structure_component_id_seq'::regclass);


--
-- Name: subcomponent id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcomponent ALTER COLUMN id SET DEFAULT nextval('public.subcomponent_id_seq'::regclass);


--
-- Data for Name: company; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: condition; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.condition VALUES (1, 'None', 'GOOD', 1);
INSERT INTO public.condition VALUES (2, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 1);
INSERT INTO public.condition VALUES (3, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 1);
INSERT INTO public.condition VALUES (4, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 1);
INSERT INTO public.condition VALUES (5, NULL, 'OTHER', 1);
INSERT INTO public.condition VALUES (6, 'None', 'GOOD', 2);
INSERT INTO public.condition VALUES (7, 'Present without measurable section loss.', 'FAIR', 2);
INSERT INTO public.condition VALUES (8, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 2);
INSERT INTO public.condition VALUES (9, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 2);
INSERT INTO public.condition VALUES (10, NULL, 'OTHER', 2);
INSERT INTO public.condition VALUES (11, 'None', 'GOOD', 3);
INSERT INTO public.condition VALUES (12, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 3);
INSERT INTO public.condition VALUES (13, 'Heavy build-up with rust staining.', 'POOR', 3);
INSERT INTO public.condition VALUES (14, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 3);
INSERT INTO public.condition VALUES (15, NULL, 'OTHER', 3);
INSERT INTO public.condition VALUES (16, 'None or insignificant cracks.', 'GOOD', 4);
INSERT INTO public.condition VALUES (17, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 4);
INSERT INTO public.condition VALUES (18, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 4);
INSERT INTO public.condition VALUES (19, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 4);
INSERT INTO public.condition VALUES (20, NULL, 'OTHER', 4);
INSERT INTO public.condition VALUES (21, 'No abrasion or wearing.', 'GOOD', 5);
INSERT INTO public.condition VALUES (22, 'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.', 'FAIR', 5);
INSERT INTO public.condition VALUES (23, 'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.', 'POOR', 5);
INSERT INTO public.condition VALUES (24, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 5);
INSERT INTO public.condition VALUES (25, NULL, 'OTHER', 5);
INSERT INTO public.condition VALUES (26, 'Not applicable', 'GOOD', 6);
INSERT INTO public.condition VALUES (27, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 6);
INSERT INTO public.condition VALUES (28, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 6);
INSERT INTO public.condition VALUES (29, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 6);
INSERT INTO public.condition VALUES (30, NULL, 'OTHER', 6);
INSERT INTO public.condition VALUES (31, 'None', 'GOOD', 7);
INSERT INTO public.condition VALUES (32, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 7);
INSERT INTO public.condition VALUES (33, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 7);
INSERT INTO public.condition VALUES (34, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 7);
INSERT INTO public.condition VALUES (35, NULL, 'OTHER', 7);
INSERT INTO public.condition VALUES (36, 'None', 'GOOD', 8);
INSERT INTO public.condition VALUES (37, 'Present without measurable section loss.', 'FAIR', 8);
INSERT INTO public.condition VALUES (38, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 8);
INSERT INTO public.condition VALUES (39, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 8);
INSERT INTO public.condition VALUES (40, NULL, 'OTHER', 8);
INSERT INTO public.condition VALUES (41, 'None', 'GOOD', 9);
INSERT INTO public.condition VALUES (42, 'Present without section loss.', 'FAIR', 9);
INSERT INTO public.condition VALUES (43, 'Present with section loss, but does not warrant structural review.', 'POOR', 9);
INSERT INTO public.condition VALUES (44, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 9);
INSERT INTO public.condition VALUES (45, NULL, 'OTHER', 9);
INSERT INTO public.condition VALUES (46, 'None or insignificant cracks.', 'GOOD', 10);
INSERT INTO public.condition VALUES (47, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.', 'FAIR', 10);
INSERT INTO public.condition VALUES (48, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.', 'POOR', 10);
INSERT INTO public.condition VALUES (49, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 10);
INSERT INTO public.condition VALUES (50, NULL, 'OTHER', 10);
INSERT INTO public.condition VALUES (51, 'None', 'GOOD', 11);
INSERT INTO public.condition VALUES (52, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 11);
INSERT INTO public.condition VALUES (53, 'Heavy build-up with rust staining.', 'POOR', 11);
INSERT INTO public.condition VALUES (54, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 11);
INSERT INTO public.condition VALUES (55, NULL, 'OTHER', 11);
INSERT INTO public.condition VALUES (56, 'No abrasion or wearing.', 'GOOD', 12);
INSERT INTO public.condition VALUES (57, 'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.', 'FAIR', 12);
INSERT INTO public.condition VALUES (58, 'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.', 'POOR', 12);
INSERT INTO public.condition VALUES (59, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 12);
INSERT INTO public.condition VALUES (60, NULL, 'OTHER', 12);
INSERT INTO public.condition VALUES (61, 'Not applicable', 'GOOD', 13);
INSERT INTO public.condition VALUES (62, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 13);
INSERT INTO public.condition VALUES (63, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 13);
INSERT INTO public.condition VALUES (64, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 13);
INSERT INTO public.condition VALUES (65, NULL, 'OTHER', 13);
INSERT INTO public.condition VALUES (66, 'None', 'GOOD', 14);
INSERT INTO public.condition VALUES (67, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 14);
INSERT INTO public.condition VALUES (68, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 14);
INSERT INTO public.condition VALUES (69, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 14);
INSERT INTO public.condition VALUES (70, NULL, 'OTHER', 14);
INSERT INTO public.condition VALUES (71, 'None', 'GOOD', 15);
INSERT INTO public.condition VALUES (72, 'Present without measurable section loss.', 'FAIR', 15);
INSERT INTO public.condition VALUES (73, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 15);
INSERT INTO public.condition VALUES (74, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 15);
INSERT INTO public.condition VALUES (75, NULL, 'OTHER', 15);
INSERT INTO public.condition VALUES (76, 'None', 'GOOD', 16);
INSERT INTO public.condition VALUES (77, 'Present without section loss.', 'FAIR', 16);
INSERT INTO public.condition VALUES (78, 'Present with section loss, but does not warrant structural review.', 'POOR', 16);
INSERT INTO public.condition VALUES (79, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 16);
INSERT INTO public.condition VALUES (80, NULL, 'OTHER', 16);
INSERT INTO public.condition VALUES (81, 'None or insignificant cracks.', 'GOOD', 17);
INSERT INTO public.condition VALUES (82, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.', 'FAIR', 17);
INSERT INTO public.condition VALUES (83, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.', 'POOR', 17);
INSERT INTO public.condition VALUES (84, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 17);
INSERT INTO public.condition VALUES (85, NULL, 'OTHER', 17);
INSERT INTO public.condition VALUES (86, 'None', 'GOOD', 18);
INSERT INTO public.condition VALUES (87, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 18);
INSERT INTO public.condition VALUES (88, 'Heavy build-up with rust staining.', 'POOR', 18);
INSERT INTO public.condition VALUES (89, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 18);
INSERT INTO public.condition VALUES (90, NULL, 'OTHER', 18);
INSERT INTO public.condition VALUES (91, 'No abrasion or wearing.', 'GOOD', 19);
INSERT INTO public.condition VALUES (92, 'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.', 'FAIR', 19);
INSERT INTO public.condition VALUES (93, 'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.', 'POOR', 19);
INSERT INTO public.condition VALUES (94, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 19);
INSERT INTO public.condition VALUES (95, NULL, 'OTHER', 19);
INSERT INTO public.condition VALUES (96, 'Not applicable', 'GOOD', 20);
INSERT INTO public.condition VALUES (97, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 20);
INSERT INTO public.condition VALUES (98, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 20);
INSERT INTO public.condition VALUES (99, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 20);
INSERT INTO public.condition VALUES (100, NULL, 'OTHER', 20);
INSERT INTO public.condition VALUES (101, 'None', 'GOOD', 21);
INSERT INTO public.condition VALUES (102, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 21);
INSERT INTO public.condition VALUES (103, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 21);
INSERT INTO public.condition VALUES (104, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 21);
INSERT INTO public.condition VALUES (105, NULL, 'OTHER', 21);
INSERT INTO public.condition VALUES (106, 'None', 'GOOD', 22);
INSERT INTO public.condition VALUES (107, 'Present without measurable section loss.', 'FAIR', 22);
INSERT INTO public.condition VALUES (108, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 22);
INSERT INTO public.condition VALUES (109, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 22);
INSERT INTO public.condition VALUES (110, NULL, 'OTHER', 22);
INSERT INTO public.condition VALUES (111, 'None', 'GOOD', 23);
INSERT INTO public.condition VALUES (112, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 23);
INSERT INTO public.condition VALUES (113, 'Heavy build-up with rust staining.', 'POOR', 23);
INSERT INTO public.condition VALUES (114, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 23);
INSERT INTO public.condition VALUES (115, NULL, 'OTHER', 23);
INSERT INTO public.condition VALUES (116, 'None or insignificant cracks.', 'GOOD', 24);
INSERT INTO public.condition VALUES (117, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 24);
INSERT INTO public.condition VALUES (118, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 24);
INSERT INTO public.condition VALUES (119, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 24);
INSERT INTO public.condition VALUES (120, NULL, 'OTHER', 24);
INSERT INTO public.condition VALUES (121, 'No abrasion or wearing.', 'GOOD', 25);
INSERT INTO public.condition VALUES (122, 'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.', 'FAIR', 25);
INSERT INTO public.condition VALUES (123, 'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.', 'POOR', 25);
INSERT INTO public.condition VALUES (183, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 37);
INSERT INTO public.condition VALUES (124, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 25);
INSERT INTO public.condition VALUES (125, NULL, 'OTHER', 25);
INSERT INTO public.condition VALUES (126, 'Not applicable', 'GOOD', 26);
INSERT INTO public.condition VALUES (127, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 26);
INSERT INTO public.condition VALUES (128, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 26);
INSERT INTO public.condition VALUES (129, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 26);
INSERT INTO public.condition VALUES (130, NULL, 'OTHER', 26);
INSERT INTO public.condition VALUES (131, 'None', 'GOOD', 27);
INSERT INTO public.condition VALUES (132, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 27);
INSERT INTO public.condition VALUES (133, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 27);
INSERT INTO public.condition VALUES (134, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 27);
INSERT INTO public.condition VALUES (135, NULL, 'OTHER', 27);
INSERT INTO public.condition VALUES (136, 'None', 'GOOD', 28);
INSERT INTO public.condition VALUES (137, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 28);
INSERT INTO public.condition VALUES (138, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 28);
INSERT INTO public.condition VALUES (139, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 28);
INSERT INTO public.condition VALUES (140, NULL, 'OTHER', 28);
INSERT INTO public.condition VALUES (141, 'Connection is in place and functioning as intended.', 'GOOD', 29);
INSERT INTO public.condition VALUES (142, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 29);
INSERT INTO public.condition VALUES (143, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 29);
INSERT INTO public.condition VALUES (144, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 29);
INSERT INTO public.condition VALUES (145, NULL, 'OTHER', 29);
INSERT INTO public.condition VALUES (146, 'Not applicable', 'GOOD', 30);
INSERT INTO public.condition VALUES (147, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 30);
INSERT INTO public.condition VALUES (148, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 30);
INSERT INTO public.condition VALUES (149, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 30);
INSERT INTO public.condition VALUES (150, NULL, 'OTHER', 30);
INSERT INTO public.condition VALUES (151, 'None', 'GOOD', 31);
INSERT INTO public.condition VALUES (152, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 31);
INSERT INTO public.condition VALUES (153, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 31);
INSERT INTO public.condition VALUES (154, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 31);
INSERT INTO public.condition VALUES (155, NULL, 'OTHER', 31);
INSERT INTO public.condition VALUES (156, 'None', 'GOOD', 32);
INSERT INTO public.condition VALUES (157, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 32);
INSERT INTO public.condition VALUES (158, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 32);
INSERT INTO public.condition VALUES (159, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 32);
INSERT INTO public.condition VALUES (160, NULL, 'OTHER', 32);
INSERT INTO public.condition VALUES (161, 'Connection is in place and functioning as intended.', 'GOOD', 33);
INSERT INTO public.condition VALUES (162, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 33);
INSERT INTO public.condition VALUES (163, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 33);
INSERT INTO public.condition VALUES (164, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 33);
INSERT INTO public.condition VALUES (165, NULL, 'OTHER', 33);
INSERT INTO public.condition VALUES (166, 'Not applicable', 'GOOD', 34);
INSERT INTO public.condition VALUES (167, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 34);
INSERT INTO public.condition VALUES (168, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 34);
INSERT INTO public.condition VALUES (169, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 34);
INSERT INTO public.condition VALUES (170, NULL, 'OTHER', 34);
INSERT INTO public.condition VALUES (171, 'None', 'GOOD', 35);
INSERT INTO public.condition VALUES (172, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 35);
INSERT INTO public.condition VALUES (173, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 35);
INSERT INTO public.condition VALUES (174, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 35);
INSERT INTO public.condition VALUES (175, NULL, 'OTHER', 35);
INSERT INTO public.condition VALUES (176, 'None', 'GOOD', 36);
INSERT INTO public.condition VALUES (177, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 36);
INSERT INTO public.condition VALUES (178, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 36);
INSERT INTO public.condition VALUES (179, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 36);
INSERT INTO public.condition VALUES (180, NULL, 'OTHER', 36);
INSERT INTO public.condition VALUES (181, 'Connection is in place and functioning as intended.', 'GOOD', 37);
INSERT INTO public.condition VALUES (182, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 37);
INSERT INTO public.condition VALUES (184, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 37);
INSERT INTO public.condition VALUES (185, NULL, 'OTHER', 37);
INSERT INTO public.condition VALUES (186, 'Not applicable', 'GOOD', 38);
INSERT INTO public.condition VALUES (187, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 38);
INSERT INTO public.condition VALUES (188, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 38);
INSERT INTO public.condition VALUES (189, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 38);
INSERT INTO public.condition VALUES (190, NULL, 'OTHER', 38);
INSERT INTO public.condition VALUES (191, 'Connection is in place and functioning as intended.', 'GOOD', 39);
INSERT INTO public.condition VALUES (192, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 39);
INSERT INTO public.condition VALUES (193, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 39);
INSERT INTO public.condition VALUES (194, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 39);
INSERT INTO public.condition VALUES (195, NULL, 'OTHER', 39);
INSERT INTO public.condition VALUES (196, 'None', 'GOOD', 40);
INSERT INTO public.condition VALUES (197, 'Affects less than 10% of the member section.', 'FAIR', 40);
INSERT INTO public.condition VALUES (198, 'Affects 10% or more of the member but does not warrant structural review.', 'POOR', 40);
INSERT INTO public.condition VALUES (199, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 40);
INSERT INTO public.condition VALUES (200, NULL, 'OTHER', 40);
INSERT INTO public.condition VALUES (201, 'Surface penetration less than 5% of the member thickness regardless of location.', 'GOOD', 41);
INSERT INTO public.condition VALUES (202, 'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.', 'FAIR', 41);
INSERT INTO public.condition VALUES (203, 'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.', 'POOR', 41);
INSERT INTO public.condition VALUES (204, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 41);
INSERT INTO public.condition VALUES (205, NULL, 'OTHER', 41);
INSERT INTO public.condition VALUES (206, 'None', 'GOOD', 42);
INSERT INTO public.condition VALUES (207, 'Crack that has been arrested through effective measures.', 'FAIR', 42);
INSERT INTO public.condition VALUES (208, 'Identified crack exists that is not arrested, but does not require structural review', 'POOR', 42);
INSERT INTO public.condition VALUES (209, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 42);
INSERT INTO public.condition VALUES (210, NULL, 'OTHER', 42);
INSERT INTO public.condition VALUES (211, 'None', 'GOOD', 43);
INSERT INTO public.condition VALUES (212, 'Length less than the member depth or arrested with effective actions taken to mitigate.', 'FAIR', 43);
INSERT INTO public.condition VALUES (213, 'Length equal to or greater than the member depth, but does not require structural review.', 'POOR', 43);
INSERT INTO public.condition VALUES (214, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 43);
INSERT INTO public.condition VALUES (215, NULL, 'OTHER', 43);
INSERT INTO public.condition VALUES (216, 'None or no measurable section loss.', 'GOOD', 44);
INSERT INTO public.condition VALUES (217, 'Section loss less than 10% of the member thickness.', 'FAIR', 44);
INSERT INTO public.condition VALUES (218, 'Section loss 10% or more of the member thickness, but does not warrant structural review.', 'POOR', 44);
INSERT INTO public.condition VALUES (219, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 44);
INSERT INTO public.condition VALUES (220, NULL, 'OTHER', 44);
INSERT INTO public.condition VALUES (221, 'Not applicable', 'GOOD', 45);
INSERT INTO public.condition VALUES (222, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 45);
INSERT INTO public.condition VALUES (223, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 45);
INSERT INTO public.condition VALUES (224, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 45);
INSERT INTO public.condition VALUES (225, NULL, 'OTHER', 45);
INSERT INTO public.condition VALUES (226, 'None', 'GOOD', 46);
INSERT INTO public.condition VALUES (227, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 46);
INSERT INTO public.condition VALUES (228, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 46);
INSERT INTO public.condition VALUES (229, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 46);
INSERT INTO public.condition VALUES (230, NULL, 'OTHER', 46);
INSERT INTO public.condition VALUES (231, 'None', 'GOOD', 47);
INSERT INTO public.condition VALUES (232, 'Present without measurable section loss.', 'FAIR', 47);
INSERT INTO public.condition VALUES (233, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 47);
INSERT INTO public.condition VALUES (234, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 47);
INSERT INTO public.condition VALUES (235, NULL, 'OTHER', 47);
INSERT INTO public.condition VALUES (236, 'None', 'GOOD', 48);
INSERT INTO public.condition VALUES (237, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 48);
INSERT INTO public.condition VALUES (238, 'Heavy build-up with rust staining.', 'POOR', 48);
INSERT INTO public.condition VALUES (239, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 48);
INSERT INTO public.condition VALUES (240, NULL, 'OTHER', 48);
INSERT INTO public.condition VALUES (241, 'None or insignificant cracks.', 'GOOD', 49);
INSERT INTO public.condition VALUES (242, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 49);
INSERT INTO public.condition VALUES (243, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 49);
INSERT INTO public.condition VALUES (1045, NULL, 'OTHER', 209);
INSERT INTO public.condition VALUES (244, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 49);
INSERT INTO public.condition VALUES (245, NULL, 'OTHER', 49);
INSERT INTO public.condition VALUES (246, 'No abrasion or wearing.', 'GOOD', 50);
INSERT INTO public.condition VALUES (247, 'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.', 'FAIR', 50);
INSERT INTO public.condition VALUES (248, 'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.', 'POOR', 50);
INSERT INTO public.condition VALUES (249, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 50);
INSERT INTO public.condition VALUES (250, NULL, 'OTHER', 50);
INSERT INTO public.condition VALUES (251, 'Not applicable', 'GOOD', 51);
INSERT INTO public.condition VALUES (252, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 51);
INSERT INTO public.condition VALUES (253, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 51);
INSERT INTO public.condition VALUES (254, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 51);
INSERT INTO public.condition VALUES (255, NULL, 'OTHER', 51);
INSERT INTO public.condition VALUES (256, 'None', 'GOOD', 52);
INSERT INTO public.condition VALUES (257, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 52);
INSERT INTO public.condition VALUES (258, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 52);
INSERT INTO public.condition VALUES (259, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 52);
INSERT INTO public.condition VALUES (260, NULL, 'OTHER', 52);
INSERT INTO public.condition VALUES (261, 'None', 'GOOD', 53);
INSERT INTO public.condition VALUES (262, 'Present without measurable section loss.', 'FAIR', 53);
INSERT INTO public.condition VALUES (263, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 53);
INSERT INTO public.condition VALUES (264, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 53);
INSERT INTO public.condition VALUES (265, NULL, 'OTHER', 53);
INSERT INTO public.condition VALUES (266, 'None', 'GOOD', 54);
INSERT INTO public.condition VALUES (267, 'Present without section loss.', 'FAIR', 54);
INSERT INTO public.condition VALUES (268, 'Present with section loss, but does not warrant structural review.', 'POOR', 54);
INSERT INTO public.condition VALUES (269, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 54);
INSERT INTO public.condition VALUES (270, NULL, 'OTHER', 54);
INSERT INTO public.condition VALUES (271, 'None or insignificant cracks.', 'GOOD', 55);
INSERT INTO public.condition VALUES (272, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.', 'FAIR', 55);
INSERT INTO public.condition VALUES (273, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.', 'POOR', 55);
INSERT INTO public.condition VALUES (274, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 55);
INSERT INTO public.condition VALUES (275, NULL, 'OTHER', 55);
INSERT INTO public.condition VALUES (276, 'None', 'GOOD', 56);
INSERT INTO public.condition VALUES (277, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 56);
INSERT INTO public.condition VALUES (278, 'Heavy build-up with rust staining.', 'POOR', 56);
INSERT INTO public.condition VALUES (279, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 56);
INSERT INTO public.condition VALUES (280, NULL, 'OTHER', 56);
INSERT INTO public.condition VALUES (281, 'No abrasion or wearing.', 'GOOD', 57);
INSERT INTO public.condition VALUES (282, 'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.', 'FAIR', 57);
INSERT INTO public.condition VALUES (283, 'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.', 'POOR', 57);
INSERT INTO public.condition VALUES (284, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 57);
INSERT INTO public.condition VALUES (285, NULL, 'OTHER', 57);
INSERT INTO public.condition VALUES (286, 'Not applicable', 'GOOD', 58);
INSERT INTO public.condition VALUES (287, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 58);
INSERT INTO public.condition VALUES (288, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 58);
INSERT INTO public.condition VALUES (289, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 58);
INSERT INTO public.condition VALUES (290, NULL, 'OTHER', 58);
INSERT INTO public.condition VALUES (291, 'Connection is in place and functioning as intended.', 'GOOD', 59);
INSERT INTO public.condition VALUES (292, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 59);
INSERT INTO public.condition VALUES (293, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 59);
INSERT INTO public.condition VALUES (294, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 59);
INSERT INTO public.condition VALUES (295, NULL, 'OTHER', 59);
INSERT INTO public.condition VALUES (296, 'None', 'GOOD', 60);
INSERT INTO public.condition VALUES (297, 'Affects less than 10% of the member section.', 'FAIR', 60);
INSERT INTO public.condition VALUES (298, 'Affects 10% or more of the member but does not warrant structural review.', 'POOR', 60);
INSERT INTO public.condition VALUES (299, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 60);
INSERT INTO public.condition VALUES (300, NULL, 'OTHER', 60);
INSERT INTO public.condition VALUES (301, 'Surface penetration less than 5% of the member thickness regardless of location.', 'GOOD', 61);
INSERT INTO public.condition VALUES (302, 'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.', 'FAIR', 61);
INSERT INTO public.condition VALUES (303, 'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.', 'POOR', 61);
INSERT INTO public.condition VALUES (304, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 61);
INSERT INTO public.condition VALUES (305, NULL, 'OTHER', 61);
INSERT INTO public.condition VALUES (306, 'None', 'GOOD', 62);
INSERT INTO public.condition VALUES (307, 'Crack that has been arrested through effective measures.', 'FAIR', 62);
INSERT INTO public.condition VALUES (308, 'Identified crack exists that is not arrested, but does not require structural review', 'POOR', 62);
INSERT INTO public.condition VALUES (309, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 62);
INSERT INTO public.condition VALUES (310, NULL, 'OTHER', 62);
INSERT INTO public.condition VALUES (311, 'None', 'GOOD', 63);
INSERT INTO public.condition VALUES (312, 'Length less than the member depth or arrested with effective actions taken to mitigate.', 'FAIR', 63);
INSERT INTO public.condition VALUES (313, 'Length equal to or greater than the member depth, but does not require structural review.', 'POOR', 63);
INSERT INTO public.condition VALUES (314, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 63);
INSERT INTO public.condition VALUES (315, NULL, 'OTHER', 63);
INSERT INTO public.condition VALUES (316, 'None or no measurable section loss.', 'GOOD', 64);
INSERT INTO public.condition VALUES (317, 'Section loss less than 10% of the member thickness.', 'FAIR', 64);
INSERT INTO public.condition VALUES (318, 'Section loss 10% or more of the member thickness, but does not warrant structural review.', 'POOR', 64);
INSERT INTO public.condition VALUES (319, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 64);
INSERT INTO public.condition VALUES (320, NULL, 'OTHER', 64);
INSERT INTO public.condition VALUES (321, 'Not applicable', 'GOOD', 65);
INSERT INTO public.condition VALUES (322, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 65);
INSERT INTO public.condition VALUES (323, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 65);
INSERT INTO public.condition VALUES (324, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 65);
INSERT INTO public.condition VALUES (325, NULL, 'OTHER', 65);
INSERT INTO public.condition VALUES (326, 'None', 'GOOD', 66);
INSERT INTO public.condition VALUES (327, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 66);
INSERT INTO public.condition VALUES (328, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 66);
INSERT INTO public.condition VALUES (329, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 66);
INSERT INTO public.condition VALUES (330, NULL, 'OTHER', 66);
INSERT INTO public.condition VALUES (331, 'None', 'GOOD', 67);
INSERT INTO public.condition VALUES (332, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 67);
INSERT INTO public.condition VALUES (333, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 67);
INSERT INTO public.condition VALUES (334, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 67);
INSERT INTO public.condition VALUES (335, NULL, 'OTHER', 67);
INSERT INTO public.condition VALUES (336, 'Connection is in place and functioning as intended.', 'GOOD', 68);
INSERT INTO public.condition VALUES (337, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 68);
INSERT INTO public.condition VALUES (338, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 68);
INSERT INTO public.condition VALUES (339, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 68);
INSERT INTO public.condition VALUES (340, NULL, 'OTHER', 68);
INSERT INTO public.condition VALUES (341, 'None or insignificant cracks.', 'GOOD', 69);
INSERT INTO public.condition VALUES (342, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 69);
INSERT INTO public.condition VALUES (343, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 69);
INSERT INTO public.condition VALUES (344, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 69);
INSERT INTO public.condition VALUES (345, NULL, 'OTHER', 69);
INSERT INTO public.condition VALUES (346, 'None', 'GOOD', 70);
INSERT INTO public.condition VALUES (347, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 70);
INSERT INTO public.condition VALUES (348, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 70);
INSERT INTO public.condition VALUES (349, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 70);
INSERT INTO public.condition VALUES (350, NULL, 'OTHER', 70);
INSERT INTO public.condition VALUES (351, 'None', 'GOOD', 71);
INSERT INTO public.condition VALUES (352, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 71);
INSERT INTO public.condition VALUES (353, 'Heavy build-up with rust staining.', 'POOR', 71);
INSERT INTO public.condition VALUES (354, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 71);
INSERT INTO public.condition VALUES (355, NULL, 'OTHER', 71);
INSERT INTO public.condition VALUES (356, 'None', 'GOOD', 72);
INSERT INTO public.condition VALUES (357, 'Initiated breakdown or deterioration.', 'FAIR', 72);
INSERT INTO public.condition VALUES (358, 'Significant deterioration or breakdown, but does not warrant structural review.', 'POOR', 72);
INSERT INTO public.condition VALUES (359, '', 'SEVERE', 72);
INSERT INTO public.condition VALUES (360, NULL, 'OTHER', 72);
INSERT INTO public.condition VALUES (361, 'Not applicable', 'GOOD', 73);
INSERT INTO public.condition VALUES (362, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 73);
INSERT INTO public.condition VALUES (363, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 73);
INSERT INTO public.condition VALUES (364, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 73);
INSERT INTO public.condition VALUES (365, NULL, 'OTHER', 73);
INSERT INTO public.condition VALUES (366, 'None', 'GOOD', 74);
INSERT INTO public.condition VALUES (367, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 74);
INSERT INTO public.condition VALUES (368, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 74);
INSERT INTO public.condition VALUES (369, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 74);
INSERT INTO public.condition VALUES (370, NULL, 'OTHER', 74);
INSERT INTO public.condition VALUES (371, 'None', 'GOOD', 75);
INSERT INTO public.condition VALUES (372, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 75);
INSERT INTO public.condition VALUES (373, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 75);
INSERT INTO public.condition VALUES (374, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 75);
INSERT INTO public.condition VALUES (375, NULL, 'OTHER', 75);
INSERT INTO public.condition VALUES (376, 'Connection is in place and functioning as intended.', 'GOOD', 76);
INSERT INTO public.condition VALUES (377, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 76);
INSERT INTO public.condition VALUES (378, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 76);
INSERT INTO public.condition VALUES (379, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 76);
INSERT INTO public.condition VALUES (380, NULL, 'OTHER', 76);
INSERT INTO public.condition VALUES (381, 'None', 'GOOD', 77);
INSERT INTO public.condition VALUES (382, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 77);
INSERT INTO public.condition VALUES (383, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 77);
INSERT INTO public.condition VALUES (384, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 77);
INSERT INTO public.condition VALUES (385, NULL, 'OTHER', 77);
INSERT INTO public.condition VALUES (386, 'None or insignificant cracks.', 'GOOD', 78);
INSERT INTO public.condition VALUES (387, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 78);
INSERT INTO public.condition VALUES (388, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 78);
INSERT INTO public.condition VALUES (389, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 78);
INSERT INTO public.condition VALUES (390, NULL, 'OTHER', 78);
INSERT INTO public.condition VALUES (391, 'None', 'GOOD', 79);
INSERT INTO public.condition VALUES (392, 'Initiated breakdown or deterioration.', 'FAIR', 79);
INSERT INTO public.condition VALUES (393, 'Significant deterioration or breakdown, but does not warrant structural review.', 'POOR', 79);
INSERT INTO public.condition VALUES (394, '', 'SEVERE', 79);
INSERT INTO public.condition VALUES (395, NULL, 'OTHER', 79);
INSERT INTO public.condition VALUES (396, 'None', 'GOOD', 80);
INSERT INTO public.condition VALUES (397, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 80);
INSERT INTO public.condition VALUES (398, 'Heavy build-up with rust staining.', 'POOR', 80);
INSERT INTO public.condition VALUES (399, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 80);
INSERT INTO public.condition VALUES (400, NULL, 'OTHER', 80);
INSERT INTO public.condition VALUES (401, 'Not applicable', 'GOOD', 81);
INSERT INTO public.condition VALUES (402, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 81);
INSERT INTO public.condition VALUES (403, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 81);
INSERT INTO public.condition VALUES (404, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 81);
INSERT INTO public.condition VALUES (405, NULL, 'OTHER', 81);
INSERT INTO public.condition VALUES (406, 'None', 'GOOD', 82);
INSERT INTO public.condition VALUES (407, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 82);
INSERT INTO public.condition VALUES (408, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 82);
INSERT INTO public.condition VALUES (409, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 82);
INSERT INTO public.condition VALUES (410, NULL, 'OTHER', 82);
INSERT INTO public.condition VALUES (411, 'None', 'GOOD', 83);
INSERT INTO public.condition VALUES (412, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 83);
INSERT INTO public.condition VALUES (413, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 83);
INSERT INTO public.condition VALUES (414, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 83);
INSERT INTO public.condition VALUES (415, NULL, 'OTHER', 83);
INSERT INTO public.condition VALUES (416, 'Connection is in place and functioning as intended.', 'GOOD', 84);
INSERT INTO public.condition VALUES (417, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 84);
INSERT INTO public.condition VALUES (418, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 84);
INSERT INTO public.condition VALUES (419, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 84);
INSERT INTO public.condition VALUES (420, NULL, 'OTHER', 84);
INSERT INTO public.condition VALUES (421, 'None', 'GOOD', 85);
INSERT INTO public.condition VALUES (422, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 85);
INSERT INTO public.condition VALUES (423, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 85);
INSERT INTO public.condition VALUES (424, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 85);
INSERT INTO public.condition VALUES (425, NULL, 'OTHER', 85);
INSERT INTO public.condition VALUES (426, 'Not applicable', 'GOOD', 86);
INSERT INTO public.condition VALUES (427, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 86);
INSERT INTO public.condition VALUES (552, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 111);
INSERT INTO public.condition VALUES (428, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 86);
INSERT INTO public.condition VALUES (429, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 86);
INSERT INTO public.condition VALUES (430, NULL, 'OTHER', 86);
INSERT INTO public.condition VALUES (431, 'None', 'GOOD', 87);
INSERT INTO public.condition VALUES (432, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 87);
INSERT INTO public.condition VALUES (433, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 87);
INSERT INTO public.condition VALUES (434, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 87);
INSERT INTO public.condition VALUES (435, NULL, 'OTHER', 87);
INSERT INTO public.condition VALUES (436, 'None', 'GOOD', 88);
INSERT INTO public.condition VALUES (437, 'Present without measurable section loss.', 'FAIR', 88);
INSERT INTO public.condition VALUES (438, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 88);
INSERT INTO public.condition VALUES (439, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 88);
INSERT INTO public.condition VALUES (440, NULL, 'OTHER', 88);
INSERT INTO public.condition VALUES (441, 'None', 'GOOD', 89);
INSERT INTO public.condition VALUES (442, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 89);
INSERT INTO public.condition VALUES (443, 'Heavy build-up with rust staining.', 'POOR', 89);
INSERT INTO public.condition VALUES (444, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 89);
INSERT INTO public.condition VALUES (445, NULL, 'OTHER', 89);
INSERT INTO public.condition VALUES (446, 'None or insignificant cracks.', 'GOOD', 90);
INSERT INTO public.condition VALUES (447, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 90);
INSERT INTO public.condition VALUES (448, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 90);
INSERT INTO public.condition VALUES (449, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 90);
INSERT INTO public.condition VALUES (450, NULL, 'OTHER', 90);
INSERT INTO public.condition VALUES (451, 'No abrasion or wearing.', 'GOOD', 91);
INSERT INTO public.condition VALUES (452, 'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.', 'FAIR', 91);
INSERT INTO public.condition VALUES (453, 'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.', 'POOR', 91);
INSERT INTO public.condition VALUES (454, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 91);
INSERT INTO public.condition VALUES (455, NULL, 'OTHER', 91);
INSERT INTO public.condition VALUES (456, 'Not applicable', 'GOOD', 92);
INSERT INTO public.condition VALUES (457, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 92);
INSERT INTO public.condition VALUES (458, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 92);
INSERT INTO public.condition VALUES (459, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 92);
INSERT INTO public.condition VALUES (460, NULL, 'OTHER', 92);
INSERT INTO public.condition VALUES (461, 'Connection is in place and functioning as intended.', 'GOOD', 93);
INSERT INTO public.condition VALUES (462, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 93);
INSERT INTO public.condition VALUES (463, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 93);
INSERT INTO public.condition VALUES (464, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 93);
INSERT INTO public.condition VALUES (465, NULL, 'OTHER', 93);
INSERT INTO public.condition VALUES (466, 'None', 'GOOD', 94);
INSERT INTO public.condition VALUES (467, 'Affects less than 10% of the member section.', 'FAIR', 94);
INSERT INTO public.condition VALUES (468, 'Affects 10% or more of the member but does not warrant structural review.', 'POOR', 94);
INSERT INTO public.condition VALUES (469, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 94);
INSERT INTO public.condition VALUES (470, NULL, 'OTHER', 94);
INSERT INTO public.condition VALUES (471, 'Surface penetration less than 5% of the member thickness regardless of location.', 'GOOD', 95);
INSERT INTO public.condition VALUES (472, 'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.', 'FAIR', 95);
INSERT INTO public.condition VALUES (473, 'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.', 'POOR', 95);
INSERT INTO public.condition VALUES (474, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 95);
INSERT INTO public.condition VALUES (475, NULL, 'OTHER', 95);
INSERT INTO public.condition VALUES (476, 'None', 'GOOD', 96);
INSERT INTO public.condition VALUES (477, 'Crack that has been arrested through effective measures.', 'FAIR', 96);
INSERT INTO public.condition VALUES (478, 'Identified crack exists that is not arrested, but does not require structural review', 'POOR', 96);
INSERT INTO public.condition VALUES (479, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 96);
INSERT INTO public.condition VALUES (480, NULL, 'OTHER', 96);
INSERT INTO public.condition VALUES (481, 'None', 'GOOD', 97);
INSERT INTO public.condition VALUES (482, 'Length less than the member depth or arrested with effective actions taken to mitigate.', 'FAIR', 97);
INSERT INTO public.condition VALUES (483, 'Length equal to or greater than the member depth, but does not require structural review.', 'POOR', 97);
INSERT INTO public.condition VALUES (484, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 97);
INSERT INTO public.condition VALUES (485, NULL, 'OTHER', 97);
INSERT INTO public.condition VALUES (486, 'None or no measurable section loss.', 'GOOD', 98);
INSERT INTO public.condition VALUES (487, 'Section loss less than 10% of the member thickness.', 'FAIR', 98);
INSERT INTO public.condition VALUES (488, 'Section loss 10% or more of the member thickness, but does not warrant structural review.', 'POOR', 98);
INSERT INTO public.condition VALUES (489, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 98);
INSERT INTO public.condition VALUES (490, NULL, 'OTHER', 98);
INSERT INTO public.condition VALUES (491, 'Not applicable', 'GOOD', 99);
INSERT INTO public.condition VALUES (492, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 99);
INSERT INTO public.condition VALUES (493, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 99);
INSERT INTO public.condition VALUES (494, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 99);
INSERT INTO public.condition VALUES (495, NULL, 'OTHER', 99);
INSERT INTO public.condition VALUES (496, 'None', 'GOOD', 100);
INSERT INTO public.condition VALUES (497, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 100);
INSERT INTO public.condition VALUES (498, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 100);
INSERT INTO public.condition VALUES (499, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 100);
INSERT INTO public.condition VALUES (500, NULL, 'OTHER', 100);
INSERT INTO public.condition VALUES (501, 'None', 'GOOD', 101);
INSERT INTO public.condition VALUES (502, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 101);
INSERT INTO public.condition VALUES (503, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 101);
INSERT INTO public.condition VALUES (504, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 101);
INSERT INTO public.condition VALUES (505, NULL, 'OTHER', 101);
INSERT INTO public.condition VALUES (506, 'Connection is in place and functioning as intended.', 'GOOD', 102);
INSERT INTO public.condition VALUES (507, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 102);
INSERT INTO public.condition VALUES (508, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 102);
INSERT INTO public.condition VALUES (509, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 102);
INSERT INTO public.condition VALUES (510, NULL, 'OTHER', 102);
INSERT INTO public.condition VALUES (511, 'None', 'GOOD', 103);
INSERT INTO public.condition VALUES (512, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 103);
INSERT INTO public.condition VALUES (513, 'Heavy build-up with rust staining.', 'POOR', 103);
INSERT INTO public.condition VALUES (514, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 103);
INSERT INTO public.condition VALUES (515, NULL, 'OTHER', 103);
INSERT INTO public.condition VALUES (516, 'None or insignificant cracks.', 'GOOD', 104);
INSERT INTO public.condition VALUES (517, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 104);
INSERT INTO public.condition VALUES (518, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 104);
INSERT INTO public.condition VALUES (519, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 104);
INSERT INTO public.condition VALUES (520, NULL, 'OTHER', 104);
INSERT INTO public.condition VALUES (521, 'No abrasion or wearing.', 'GOOD', 105);
INSERT INTO public.condition VALUES (522, 'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.', 'FAIR', 105);
INSERT INTO public.condition VALUES (523, 'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.', 'POOR', 105);
INSERT INTO public.condition VALUES (524, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 105);
INSERT INTO public.condition VALUES (525, NULL, 'OTHER', 105);
INSERT INTO public.condition VALUES (526, 'None', 'GOOD', 106);
INSERT INTO public.condition VALUES (527, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 106);
INSERT INTO public.condition VALUES (528, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 106);
INSERT INTO public.condition VALUES (529, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 106);
INSERT INTO public.condition VALUES (530, NULL, 'OTHER', 106);
INSERT INTO public.condition VALUES (531, 'None', 'GOOD', 107);
INSERT INTO public.condition VALUES (532, 'Present without measurable section loss.', 'FAIR', 107);
INSERT INTO public.condition VALUES (533, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 107);
INSERT INTO public.condition VALUES (534, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 107);
INSERT INTO public.condition VALUES (535, NULL, 'OTHER', 107);
INSERT INTO public.condition VALUES (536, 'None', 'GOOD', 108);
INSERT INTO public.condition VALUES (537, 'Initiated breakdown or deterioration.', 'FAIR', 108);
INSERT INTO public.condition VALUES (538, 'Significant deterioration or breakdown, but does not warrant structural review.', 'POOR', 108);
INSERT INTO public.condition VALUES (539, '', 'SEVERE', 108);
INSERT INTO public.condition VALUES (540, NULL, 'OTHER', 108);
INSERT INTO public.condition VALUES (541, 'None', 'GOOD', 109);
INSERT INTO public.condition VALUES (542, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 109);
INSERT INTO public.condition VALUES (543, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 109);
INSERT INTO public.condition VALUES (544, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 109);
INSERT INTO public.condition VALUES (545, NULL, 'OTHER', 109);
INSERT INTO public.condition VALUES (546, 'Not applicable', 'GOOD', 110);
INSERT INTO public.condition VALUES (547, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 110);
INSERT INTO public.condition VALUES (548, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 110);
INSERT INTO public.condition VALUES (549, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 110);
INSERT INTO public.condition VALUES (550, NULL, 'OTHER', 110);
INSERT INTO public.condition VALUES (551, 'None', 'GOOD', 111);
INSERT INTO public.condition VALUES (553, 'Heavy build-up with rust staining.', 'POOR', 111);
INSERT INTO public.condition VALUES (554, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 111);
INSERT INTO public.condition VALUES (555, NULL, 'OTHER', 111);
INSERT INTO public.condition VALUES (556, 'None', 'GOOD', 112);
INSERT INTO public.condition VALUES (557, 'Cracking or voids in less than 10% of joints.', 'FAIR', 112);
INSERT INTO public.condition VALUES (558, 'Cracking or voids in 10% or more of the of joints', 'POOR', 112);
INSERT INTO public.condition VALUES (559, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 112);
INSERT INTO public.condition VALUES (560, NULL, 'OTHER', 112);
INSERT INTO public.condition VALUES (561, 'None', 'GOOD', 113);
INSERT INTO public.condition VALUES (562, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 113);
INSERT INTO public.condition VALUES (563, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 113);
INSERT INTO public.condition VALUES (564, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 113);
INSERT INTO public.condition VALUES (565, NULL, 'OTHER', 113);
INSERT INTO public.condition VALUES (566, 'None', 'GOOD', 114);
INSERT INTO public.condition VALUES (567, 'Block or stone has split or spalled with no shifting.', 'FAIR', 114);
INSERT INTO public.condition VALUES (568, 'Block or stone has split or spalled with shifting but does not warrant a structural review.', 'POOR', 114);
INSERT INTO public.condition VALUES (569, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 114);
INSERT INTO public.condition VALUES (570, NULL, 'OTHER', 114);
INSERT INTO public.condition VALUES (571, 'None', 'GOOD', 115);
INSERT INTO public.condition VALUES (572, 'Sound Patch', 'FAIR', 115);
INSERT INTO public.condition VALUES (573, 'Unsound Patch', 'POOR', 115);
INSERT INTO public.condition VALUES (574, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 115);
INSERT INTO public.condition VALUES (575, NULL, 'OTHER', 115);
INSERT INTO public.condition VALUES (576, 'None', 'GOOD', 116);
INSERT INTO public.condition VALUES (577, 'Block or stone has shifted slightly out of alignment.', 'FAIR', 116);
INSERT INTO public.condition VALUES (578, 'Block or stone has shifted significantly out of alignment or is missing but does not warrant structural review.', 'POOR', 116);
INSERT INTO public.condition VALUES (579, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 116);
INSERT INTO public.condition VALUES (580, NULL, 'OTHER', 116);
INSERT INTO public.condition VALUES (581, 'None', 'GOOD', 117);
INSERT INTO public.condition VALUES (582, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 117);
INSERT INTO public.condition VALUES (583, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 117);
INSERT INTO public.condition VALUES (584, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 117);
INSERT INTO public.condition VALUES (585, NULL, 'OTHER', 117);
INSERT INTO public.condition VALUES (586, 'Not applicable', 'GOOD', 118);
INSERT INTO public.condition VALUES (587, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 118);
INSERT INTO public.condition VALUES (588, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 118);
INSERT INTO public.condition VALUES (589, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 118);
INSERT INTO public.condition VALUES (590, NULL, 'OTHER', 118);
INSERT INTO public.condition VALUES (591, 'None', 'GOOD', 119);
INSERT INTO public.condition VALUES (592, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 119);
INSERT INTO public.condition VALUES (593, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 119);
INSERT INTO public.condition VALUES (594, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 119);
INSERT INTO public.condition VALUES (595, NULL, 'OTHER', 119);
INSERT INTO public.condition VALUES (596, 'None', 'GOOD', 120);
INSERT INTO public.condition VALUES (597, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 120);
INSERT INTO public.condition VALUES (598, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 120);
INSERT INTO public.condition VALUES (599, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 120);
INSERT INTO public.condition VALUES (600, NULL, 'OTHER', 120);
INSERT INTO public.condition VALUES (601, 'Connection is in place and functioning as intended.', 'GOOD', 121);
INSERT INTO public.condition VALUES (602, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 121);
INSERT INTO public.condition VALUES (603, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 121);
INSERT INTO public.condition VALUES (604, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 121);
INSERT INTO public.condition VALUES (605, NULL, 'OTHER', 121);
INSERT INTO public.condition VALUES (606, 'None', 'GOOD', 122);
INSERT INTO public.condition VALUES (607, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 122);
INSERT INTO public.condition VALUES (608, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 122);
INSERT INTO public.condition VALUES (609, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 122);
INSERT INTO public.condition VALUES (610, NULL, 'OTHER', 122);
INSERT INTO public.condition VALUES (611, 'Not applicable', 'GOOD', 123);
INSERT INTO public.condition VALUES (612, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 123);
INSERT INTO public.condition VALUES (613, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 123);
INSERT INTO public.condition VALUES (982, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 197);
INSERT INTO public.condition VALUES (614, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 123);
INSERT INTO public.condition VALUES (615, NULL, 'OTHER', 123);
INSERT INTO public.condition VALUES (616, 'None', 'GOOD', 124);
INSERT INTO public.condition VALUES (617, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 124);
INSERT INTO public.condition VALUES (618, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 124);
INSERT INTO public.condition VALUES (619, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 124);
INSERT INTO public.condition VALUES (620, NULL, 'OTHER', 124);
INSERT INTO public.condition VALUES (621, 'None', 'GOOD', 125);
INSERT INTO public.condition VALUES (622, 'Present without measurable section loss.', 'FAIR', 125);
INSERT INTO public.condition VALUES (623, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 125);
INSERT INTO public.condition VALUES (624, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 125);
INSERT INTO public.condition VALUES (625, NULL, 'OTHER', 125);
INSERT INTO public.condition VALUES (626, 'None', 'GOOD', 126);
INSERT INTO public.condition VALUES (627, 'Present without section loss.', 'FAIR', 126);
INSERT INTO public.condition VALUES (628, 'Present with section loss, but does not warrant structural review.', 'POOR', 126);
INSERT INTO public.condition VALUES (629, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 126);
INSERT INTO public.condition VALUES (630, NULL, 'OTHER', 126);
INSERT INTO public.condition VALUES (631, 'None or insignificant cracks.', 'GOOD', 127);
INSERT INTO public.condition VALUES (632, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.', 'FAIR', 127);
INSERT INTO public.condition VALUES (633, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.', 'POOR', 127);
INSERT INTO public.condition VALUES (634, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 127);
INSERT INTO public.condition VALUES (635, NULL, 'OTHER', 127);
INSERT INTO public.condition VALUES (636, 'None', 'GOOD', 128);
INSERT INTO public.condition VALUES (637, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 128);
INSERT INTO public.condition VALUES (638, 'Heavy build-up with rust staining.', 'POOR', 128);
INSERT INTO public.condition VALUES (639, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 128);
INSERT INTO public.condition VALUES (640, NULL, 'OTHER', 128);
INSERT INTO public.condition VALUES (641, 'Not applicable', 'GOOD', 129);
INSERT INTO public.condition VALUES (642, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 129);
INSERT INTO public.condition VALUES (643, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 129);
INSERT INTO public.condition VALUES (644, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 129);
INSERT INTO public.condition VALUES (645, NULL, 'OTHER', 129);
INSERT INTO public.condition VALUES (646, 'None', 'GOOD', 130);
INSERT INTO public.condition VALUES (647, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 130);
INSERT INTO public.condition VALUES (648, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 130);
INSERT INTO public.condition VALUES (649, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 130);
INSERT INTO public.condition VALUES (650, NULL, 'OTHER', 130);
INSERT INTO public.condition VALUES (651, 'None', 'GOOD', 131);
INSERT INTO public.condition VALUES (652, 'Present without measurable section loss.', 'FAIR', 131);
INSERT INTO public.condition VALUES (653, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 131);
INSERT INTO public.condition VALUES (654, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 131);
INSERT INTO public.condition VALUES (655, NULL, 'OTHER', 131);
INSERT INTO public.condition VALUES (656, 'None', 'GOOD', 132);
INSERT INTO public.condition VALUES (657, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 132);
INSERT INTO public.condition VALUES (658, 'Heavy build-up with rust staining.', 'POOR', 132);
INSERT INTO public.condition VALUES (659, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 132);
INSERT INTO public.condition VALUES (660, NULL, 'OTHER', 132);
INSERT INTO public.condition VALUES (661, 'None or insignificant cracks.', 'GOOD', 133);
INSERT INTO public.condition VALUES (662, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 133);
INSERT INTO public.condition VALUES (663, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 133);
INSERT INTO public.condition VALUES (664, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 133);
INSERT INTO public.condition VALUES (665, NULL, 'OTHER', 133);
INSERT INTO public.condition VALUES (666, 'Not applicable', 'GOOD', 134);
INSERT INTO public.condition VALUES (667, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 134);
INSERT INTO public.condition VALUES (668, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 134);
INSERT INTO public.condition VALUES (669, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 134);
INSERT INTO public.condition VALUES (670, NULL, 'OTHER', 134);
INSERT INTO public.condition VALUES (671, 'None', 'GOOD', 135);
INSERT INTO public.condition VALUES (672, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 135);
INSERT INTO public.condition VALUES (673, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 135);
INSERT INTO public.condition VALUES (674, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 135);
INSERT INTO public.condition VALUES (675, NULL, 'OTHER', 135);
INSERT INTO public.condition VALUES (676, 'None', 'GOOD', 136);
INSERT INTO public.condition VALUES (677, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 136);
INSERT INTO public.condition VALUES (678, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 136);
INSERT INTO public.condition VALUES (679, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 136);
INSERT INTO public.condition VALUES (680, NULL, 'OTHER', 136);
INSERT INTO public.condition VALUES (681, 'Connection is in place and functioning as intended.', 'GOOD', 137);
INSERT INTO public.condition VALUES (682, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 137);
INSERT INTO public.condition VALUES (683, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 137);
INSERT INTO public.condition VALUES (684, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 137);
INSERT INTO public.condition VALUES (685, NULL, 'OTHER', 137);
INSERT INTO public.condition VALUES (686, 'None', 'GOOD', 138);
INSERT INTO public.condition VALUES (687, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 138);
INSERT INTO public.condition VALUES (688, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 138);
INSERT INTO public.condition VALUES (689, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 138);
INSERT INTO public.condition VALUES (690, NULL, 'OTHER', 138);
INSERT INTO public.condition VALUES (691, 'None', 'GOOD', 139);
INSERT INTO public.condition VALUES (692, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 139);
INSERT INTO public.condition VALUES (693, 'Heavy build-up with rust staining.', 'POOR', 139);
INSERT INTO public.condition VALUES (694, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 139);
INSERT INTO public.condition VALUES (695, NULL, 'OTHER', 139);
INSERT INTO public.condition VALUES (696, 'None or insignificant cracks.', 'GOOD', 140);
INSERT INTO public.condition VALUES (697, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 140);
INSERT INTO public.condition VALUES (698, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 140);
INSERT INTO public.condition VALUES (699, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 140);
INSERT INTO public.condition VALUES (700, NULL, 'OTHER', 140);
INSERT INTO public.condition VALUES (701, 'None', 'GOOD', 141);
INSERT INTO public.condition VALUES (702, 'Initiated breakdown or deterioration.', 'FAIR', 141);
INSERT INTO public.condition VALUES (703, 'Significant deterioration or breakdown, but does not warrant structural review.', 'POOR', 141);
INSERT INTO public.condition VALUES (704, '', 'SEVERE', 141);
INSERT INTO public.condition VALUES (705, NULL, 'OTHER', 141);
INSERT INTO public.condition VALUES (706, 'None', 'GOOD', 142);
INSERT INTO public.condition VALUES (707, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 142);
INSERT INTO public.condition VALUES (708, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 142);
INSERT INTO public.condition VALUES (709, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 142);
INSERT INTO public.condition VALUES (710, NULL, 'OTHER', 142);
INSERT INTO public.condition VALUES (711, 'Not applicable', 'GOOD', 143);
INSERT INTO public.condition VALUES (712, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 143);
INSERT INTO public.condition VALUES (713, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 143);
INSERT INTO public.condition VALUES (714, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 143);
INSERT INTO public.condition VALUES (715, NULL, 'OTHER', 143);
INSERT INTO public.condition VALUES (716, 'None', 'GOOD', 144);
INSERT INTO public.condition VALUES (717, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 144);
INSERT INTO public.condition VALUES (718, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 144);
INSERT INTO public.condition VALUES (719, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 144);
INSERT INTO public.condition VALUES (720, NULL, 'OTHER', 144);
INSERT INTO public.condition VALUES (721, 'None', 'GOOD', 145);
INSERT INTO public.condition VALUES (722, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 145);
INSERT INTO public.condition VALUES (723, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 145);
INSERT INTO public.condition VALUES (724, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 145);
INSERT INTO public.condition VALUES (725, NULL, 'OTHER', 145);
INSERT INTO public.condition VALUES (726, 'Connection is in place and functioning as intended.', 'GOOD', 146);
INSERT INTO public.condition VALUES (727, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 146);
INSERT INTO public.condition VALUES (728, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 146);
INSERT INTO public.condition VALUES (729, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 146);
INSERT INTO public.condition VALUES (730, NULL, 'OTHER', 146);
INSERT INTO public.condition VALUES (731, 'None', 'GOOD', 147);
INSERT INTO public.condition VALUES (732, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 147);
INSERT INTO public.condition VALUES (733, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 147);
INSERT INTO public.condition VALUES (734, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 147);
INSERT INTO public.condition VALUES (735, NULL, 'OTHER', 147);
INSERT INTO public.condition VALUES (736, 'Not applicable', 'GOOD', 148);
INSERT INTO public.condition VALUES (737, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 148);
INSERT INTO public.condition VALUES (1046, 'Not applicable', 'GOOD', 210);
INSERT INTO public.condition VALUES (738, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 148);
INSERT INTO public.condition VALUES (739, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 148);
INSERT INTO public.condition VALUES (740, NULL, 'OTHER', 148);
INSERT INTO public.condition VALUES (741, 'None', 'GOOD', 149);
INSERT INTO public.condition VALUES (742, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 149);
INSERT INTO public.condition VALUES (743, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 149);
INSERT INTO public.condition VALUES (744, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 149);
INSERT INTO public.condition VALUES (745, NULL, 'OTHER', 149);
INSERT INTO public.condition VALUES (746, 'None', 'GOOD', 150);
INSERT INTO public.condition VALUES (747, 'Present without measurable section loss.', 'FAIR', 150);
INSERT INTO public.condition VALUES (748, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 150);
INSERT INTO public.condition VALUES (749, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 150);
INSERT INTO public.condition VALUES (750, NULL, 'OTHER', 150);
INSERT INTO public.condition VALUES (751, 'None', 'GOOD', 151);
INSERT INTO public.condition VALUES (752, 'Present without section loss.', 'FAIR', 151);
INSERT INTO public.condition VALUES (753, 'Present with section loss, but does not warrant structural review.', 'POOR', 151);
INSERT INTO public.condition VALUES (754, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 151);
INSERT INTO public.condition VALUES (755, NULL, 'OTHER', 151);
INSERT INTO public.condition VALUES (756, 'None or insignificant cracks.', 'GOOD', 152);
INSERT INTO public.condition VALUES (757, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.', 'FAIR', 152);
INSERT INTO public.condition VALUES (758, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.', 'POOR', 152);
INSERT INTO public.condition VALUES (759, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 152);
INSERT INTO public.condition VALUES (760, NULL, 'OTHER', 152);
INSERT INTO public.condition VALUES (761, 'None', 'GOOD', 153);
INSERT INTO public.condition VALUES (762, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 153);
INSERT INTO public.condition VALUES (763, 'Heavy build-up with rust staining.', 'POOR', 153);
INSERT INTO public.condition VALUES (764, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 153);
INSERT INTO public.condition VALUES (765, NULL, 'OTHER', 153);
INSERT INTO public.condition VALUES (766, 'Not applicable', 'GOOD', 154);
INSERT INTO public.condition VALUES (767, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 154);
INSERT INTO public.condition VALUES (768, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 154);
INSERT INTO public.condition VALUES (769, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 154);
INSERT INTO public.condition VALUES (770, NULL, 'OTHER', 154);
INSERT INTO public.condition VALUES (771, 'None', 'GOOD', 155);
INSERT INTO public.condition VALUES (772, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 155);
INSERT INTO public.condition VALUES (773, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 155);
INSERT INTO public.condition VALUES (774, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 155);
INSERT INTO public.condition VALUES (775, NULL, 'OTHER', 155);
INSERT INTO public.condition VALUES (776, 'None', 'GOOD', 156);
INSERT INTO public.condition VALUES (777, 'Present without measurable section loss.', 'FAIR', 156);
INSERT INTO public.condition VALUES (778, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 156);
INSERT INTO public.condition VALUES (779, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 156);
INSERT INTO public.condition VALUES (780, NULL, 'OTHER', 156);
INSERT INTO public.condition VALUES (781, 'None', 'GOOD', 157);
INSERT INTO public.condition VALUES (782, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 157);
INSERT INTO public.condition VALUES (783, 'Heavy build-up with rust staining.', 'POOR', 157);
INSERT INTO public.condition VALUES (784, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 157);
INSERT INTO public.condition VALUES (785, NULL, 'OTHER', 157);
INSERT INTO public.condition VALUES (786, 'None or insignificant cracks.', 'GOOD', 158);
INSERT INTO public.condition VALUES (787, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 158);
INSERT INTO public.condition VALUES (788, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 158);
INSERT INTO public.condition VALUES (789, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 158);
INSERT INTO public.condition VALUES (790, NULL, 'OTHER', 158);
INSERT INTO public.condition VALUES (791, 'Not applicable', 'GOOD', 159);
INSERT INTO public.condition VALUES (792, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 159);
INSERT INTO public.condition VALUES (793, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 159);
INSERT INTO public.condition VALUES (794, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 159);
INSERT INTO public.condition VALUES (795, NULL, 'OTHER', 159);
INSERT INTO public.condition VALUES (796, 'Connection is in place and functioning as intended.', 'GOOD', 160);
INSERT INTO public.condition VALUES (797, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 160);
INSERT INTO public.condition VALUES (798, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 160);
INSERT INTO public.condition VALUES (1171, 'None or no measurable section loss.', 'GOOD', 235);
INSERT INTO public.condition VALUES (799, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 160);
INSERT INTO public.condition VALUES (800, NULL, 'OTHER', 160);
INSERT INTO public.condition VALUES (801, 'None', 'GOOD', 161);
INSERT INTO public.condition VALUES (802, 'Affects less than 10% of the member section.', 'FAIR', 161);
INSERT INTO public.condition VALUES (803, 'Affects 10% or more of the member but does not warrant structural review.', 'POOR', 161);
INSERT INTO public.condition VALUES (804, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 161);
INSERT INTO public.condition VALUES (805, NULL, 'OTHER', 161);
INSERT INTO public.condition VALUES (806, 'Surface penetration less than 5% of the member thickness regardless of location.', 'GOOD', 162);
INSERT INTO public.condition VALUES (807, 'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.', 'FAIR', 162);
INSERT INTO public.condition VALUES (808, 'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.', 'POOR', 162);
INSERT INTO public.condition VALUES (809, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 162);
INSERT INTO public.condition VALUES (810, NULL, 'OTHER', 162);
INSERT INTO public.condition VALUES (811, 'None', 'GOOD', 163);
INSERT INTO public.condition VALUES (812, 'Crack that has been arrested through effective measures.', 'FAIR', 163);
INSERT INTO public.condition VALUES (813, 'Identified crack exists that is not arrested, but does not require structural review', 'POOR', 163);
INSERT INTO public.condition VALUES (814, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 163);
INSERT INTO public.condition VALUES (815, NULL, 'OTHER', 163);
INSERT INTO public.condition VALUES (816, 'None', 'GOOD', 164);
INSERT INTO public.condition VALUES (817, 'Length less than the member depth or arrested with effective actions taken to mitigate.', 'FAIR', 164);
INSERT INTO public.condition VALUES (818, 'Length equal to or greater than the member depth, but does not require structural review.', 'POOR', 164);
INSERT INTO public.condition VALUES (819, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 164);
INSERT INTO public.condition VALUES (820, NULL, 'OTHER', 164);
INSERT INTO public.condition VALUES (821, 'None or no measurable section loss.', 'GOOD', 165);
INSERT INTO public.condition VALUES (822, 'Section loss less than 10% of the member thickness.', 'FAIR', 165);
INSERT INTO public.condition VALUES (823, 'Section loss 10% or more of the member thickness, but does not warrant structural review.', 'POOR', 165);
INSERT INTO public.condition VALUES (824, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 165);
INSERT INTO public.condition VALUES (825, NULL, 'OTHER', 165);
INSERT INTO public.condition VALUES (826, 'Not applicable', 'GOOD', 166);
INSERT INTO public.condition VALUES (827, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 166);
INSERT INTO public.condition VALUES (828, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 166);
INSERT INTO public.condition VALUES (829, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 166);
INSERT INTO public.condition VALUES (830, NULL, 'OTHER', 166);
INSERT INTO public.condition VALUES (831, 'None', 'GOOD', 167);
INSERT INTO public.condition VALUES (832, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 167);
INSERT INTO public.condition VALUES (833, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 167);
INSERT INTO public.condition VALUES (834, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 167);
INSERT INTO public.condition VALUES (835, NULL, 'OTHER', 167);
INSERT INTO public.condition VALUES (836, 'None', 'GOOD', 168);
INSERT INTO public.condition VALUES (837, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 168);
INSERT INTO public.condition VALUES (838, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 168);
INSERT INTO public.condition VALUES (839, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 168);
INSERT INTO public.condition VALUES (840, NULL, 'OTHER', 168);
INSERT INTO public.condition VALUES (841, 'Connection is in place and functioning as intended.', 'GOOD', 169);
INSERT INTO public.condition VALUES (842, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 169);
INSERT INTO public.condition VALUES (843, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 169);
INSERT INTO public.condition VALUES (844, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 169);
INSERT INTO public.condition VALUES (845, NULL, 'OTHER', 169);
INSERT INTO public.condition VALUES (846, 'None', 'GOOD', 170);
INSERT INTO public.condition VALUES (847, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 170);
INSERT INTO public.condition VALUES (848, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 170);
INSERT INTO public.condition VALUES (849, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 170);
INSERT INTO public.condition VALUES (850, NULL, 'OTHER', 170);
INSERT INTO public.condition VALUES (851, 'None', 'GOOD', 171);
INSERT INTO public.condition VALUES (852, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 171);
INSERT INTO public.condition VALUES (853, 'Heavy build-up with rust staining.', 'POOR', 171);
INSERT INTO public.condition VALUES (854, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 171);
INSERT INTO public.condition VALUES (855, NULL, 'OTHER', 171);
INSERT INTO public.condition VALUES (856, 'None or insignificant cracks.', 'GOOD', 172);
INSERT INTO public.condition VALUES (857, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 172);
INSERT INTO public.condition VALUES (858, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 172);
INSERT INTO public.condition VALUES (1172, 'Section loss less than 10% of the member thickness.', 'FAIR', 235);
INSERT INTO public.condition VALUES (859, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 172);
INSERT INTO public.condition VALUES (860, NULL, 'OTHER', 172);
INSERT INTO public.condition VALUES (861, 'None', 'GOOD', 173);
INSERT INTO public.condition VALUES (862, 'Initiated breakdown or deterioration.', 'FAIR', 173);
INSERT INTO public.condition VALUES (863, 'Significant deterioration or breakdown, but does not warrant structural review.', 'POOR', 173);
INSERT INTO public.condition VALUES (864, '', 'SEVERE', 173);
INSERT INTO public.condition VALUES (865, NULL, 'OTHER', 173);
INSERT INTO public.condition VALUES (866, 'None', 'GOOD', 174);
INSERT INTO public.condition VALUES (867, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 174);
INSERT INTO public.condition VALUES (868, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 174);
INSERT INTO public.condition VALUES (869, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 174);
INSERT INTO public.condition VALUES (870, NULL, 'OTHER', 174);
INSERT INTO public.condition VALUES (871, 'Not applicable', 'GOOD', 175);
INSERT INTO public.condition VALUES (872, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 175);
INSERT INTO public.condition VALUES (873, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 175);
INSERT INTO public.condition VALUES (874, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 175);
INSERT INTO public.condition VALUES (875, NULL, 'OTHER', 175);
INSERT INTO public.condition VALUES (876, 'None', 'GOOD', 176);
INSERT INTO public.condition VALUES (877, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 176);
INSERT INTO public.condition VALUES (878, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 176);
INSERT INTO public.condition VALUES (879, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 176);
INSERT INTO public.condition VALUES (880, NULL, 'OTHER', 176);
INSERT INTO public.condition VALUES (881, 'None', 'GOOD', 177);
INSERT INTO public.condition VALUES (882, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 177);
INSERT INTO public.condition VALUES (883, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 177);
INSERT INTO public.condition VALUES (884, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 177);
INSERT INTO public.condition VALUES (885, NULL, 'OTHER', 177);
INSERT INTO public.condition VALUES (886, 'Connection is in place and functioning as intended.', 'GOOD', 178);
INSERT INTO public.condition VALUES (887, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 178);
INSERT INTO public.condition VALUES (888, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 178);
INSERT INTO public.condition VALUES (889, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 178);
INSERT INTO public.condition VALUES (890, NULL, 'OTHER', 178);
INSERT INTO public.condition VALUES (891, 'None', 'GOOD', 179);
INSERT INTO public.condition VALUES (892, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 179);
INSERT INTO public.condition VALUES (893, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 179);
INSERT INTO public.condition VALUES (894, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 179);
INSERT INTO public.condition VALUES (895, NULL, 'OTHER', 179);
INSERT INTO public.condition VALUES (896, 'Not applicable', 'GOOD', 180);
INSERT INTO public.condition VALUES (897, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 180);
INSERT INTO public.condition VALUES (898, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 180);
INSERT INTO public.condition VALUES (899, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 180);
INSERT INTO public.condition VALUES (900, NULL, 'OTHER', 180);
INSERT INTO public.condition VALUES (901, 'Connection is in place and functioning as intended.', 'GOOD', 181);
INSERT INTO public.condition VALUES (902, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 181);
INSERT INTO public.condition VALUES (903, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 181);
INSERT INTO public.condition VALUES (904, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 181);
INSERT INTO public.condition VALUES (905, NULL, 'OTHER', 181);
INSERT INTO public.condition VALUES (906, 'None', 'GOOD', 182);
INSERT INTO public.condition VALUES (907, 'Affects less than 10% of the member section.', 'FAIR', 182);
INSERT INTO public.condition VALUES (908, 'Affects 10% or more of the member but does not warrant structural review.', 'POOR', 182);
INSERT INTO public.condition VALUES (909, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 182);
INSERT INTO public.condition VALUES (910, NULL, 'OTHER', 182);
INSERT INTO public.condition VALUES (911, 'Surface penetration less than 5% of the member thickness regardless of location.', 'GOOD', 183);
INSERT INTO public.condition VALUES (912, 'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.', 'FAIR', 183);
INSERT INTO public.condition VALUES (913, 'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.', 'POOR', 183);
INSERT INTO public.condition VALUES (914, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 183);
INSERT INTO public.condition VALUES (915, NULL, 'OTHER', 183);
INSERT INTO public.condition VALUES (916, 'None', 'GOOD', 184);
INSERT INTO public.condition VALUES (917, 'Crack that has been arrested through effective measures.', 'FAIR', 184);
INSERT INTO public.condition VALUES (918, 'Identified crack exists that is not arrested, but does not require structural review', 'POOR', 184);
INSERT INTO public.condition VALUES (983, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 197);
INSERT INTO public.condition VALUES (1173, 'Section loss 10% or more of the member thickness, but does not warrant structural review.', 'POOR', 235);
INSERT INTO public.condition VALUES (919, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 184);
INSERT INTO public.condition VALUES (920, NULL, 'OTHER', 184);
INSERT INTO public.condition VALUES (921, 'None', 'GOOD', 185);
INSERT INTO public.condition VALUES (922, 'Length less than the member depth or arrested with effective actions taken to mitigate.', 'FAIR', 185);
INSERT INTO public.condition VALUES (923, 'Length equal to or greater than the member depth, but does not require structural review.', 'POOR', 185);
INSERT INTO public.condition VALUES (924, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 185);
INSERT INTO public.condition VALUES (925, NULL, 'OTHER', 185);
INSERT INTO public.condition VALUES (926, 'None or no measurable section loss.', 'GOOD', 186);
INSERT INTO public.condition VALUES (927, 'Section loss less than 10% of the member thickness.', 'FAIR', 186);
INSERT INTO public.condition VALUES (928, 'Section loss 10% or more of the member thickness, but does not warrant structural review.', 'POOR', 186);
INSERT INTO public.condition VALUES (929, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 186);
INSERT INTO public.condition VALUES (930, NULL, 'OTHER', 186);
INSERT INTO public.condition VALUES (931, 'Not applicable', 'GOOD', 187);
INSERT INTO public.condition VALUES (932, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 187);
INSERT INTO public.condition VALUES (933, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 187);
INSERT INTO public.condition VALUES (934, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 187);
INSERT INTO public.condition VALUES (935, NULL, 'OTHER', 187);
INSERT INTO public.condition VALUES (936, 'None', 'GOOD', 188);
INSERT INTO public.condition VALUES (937, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 188);
INSERT INTO public.condition VALUES (938, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 188);
INSERT INTO public.condition VALUES (939, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 188);
INSERT INTO public.condition VALUES (940, NULL, 'OTHER', 188);
INSERT INTO public.condition VALUES (941, 'None', 'GOOD', 189);
INSERT INTO public.condition VALUES (942, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 189);
INSERT INTO public.condition VALUES (943, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 189);
INSERT INTO public.condition VALUES (944, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 189);
INSERT INTO public.condition VALUES (945, NULL, 'OTHER', 189);
INSERT INTO public.condition VALUES (946, 'Connection is in place and functioning as intended.', 'GOOD', 190);
INSERT INTO public.condition VALUES (947, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 190);
INSERT INTO public.condition VALUES (948, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 190);
INSERT INTO public.condition VALUES (949, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 190);
INSERT INTO public.condition VALUES (950, NULL, 'OTHER', 190);
INSERT INTO public.condition VALUES (951, 'None', 'GOOD', 191);
INSERT INTO public.condition VALUES (952, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 191);
INSERT INTO public.condition VALUES (953, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 191);
INSERT INTO public.condition VALUES (954, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 191);
INSERT INTO public.condition VALUES (955, NULL, 'OTHER', 191);
INSERT INTO public.condition VALUES (956, 'None', 'GOOD', 192);
INSERT INTO public.condition VALUES (957, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 192);
INSERT INTO public.condition VALUES (958, 'Heavy build-up with rust staining.', 'POOR', 192);
INSERT INTO public.condition VALUES (959, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 192);
INSERT INTO public.condition VALUES (960, NULL, 'OTHER', 192);
INSERT INTO public.condition VALUES (961, 'None or insignificant cracks.', 'GOOD', 193);
INSERT INTO public.condition VALUES (962, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 193);
INSERT INTO public.condition VALUES (963, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 193);
INSERT INTO public.condition VALUES (964, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 193);
INSERT INTO public.condition VALUES (965, NULL, 'OTHER', 193);
INSERT INTO public.condition VALUES (966, 'None', 'GOOD', 194);
INSERT INTO public.condition VALUES (967, 'Initiated breakdown or deterioration.', 'FAIR', 194);
INSERT INTO public.condition VALUES (968, 'Significant deterioration or breakdown, but does not warrant structural review.', 'POOR', 194);
INSERT INTO public.condition VALUES (969, '', 'SEVERE', 194);
INSERT INTO public.condition VALUES (970, NULL, 'OTHER', 194);
INSERT INTO public.condition VALUES (971, 'None', 'GOOD', 195);
INSERT INTO public.condition VALUES (972, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 195);
INSERT INTO public.condition VALUES (973, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 195);
INSERT INTO public.condition VALUES (974, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 195);
INSERT INTO public.condition VALUES (975, NULL, 'OTHER', 195);
INSERT INTO public.condition VALUES (976, 'Not applicable', 'GOOD', 196);
INSERT INTO public.condition VALUES (977, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 196);
INSERT INTO public.condition VALUES (978, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 196);
INSERT INTO public.condition VALUES (979, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 196);
INSERT INTO public.condition VALUES (980, NULL, 'OTHER', 196);
INSERT INTO public.condition VALUES (981, 'None', 'GOOD', 197);
INSERT INTO public.condition VALUES (984, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 197);
INSERT INTO public.condition VALUES (985, NULL, 'OTHER', 197);
INSERT INTO public.condition VALUES (986, 'None', 'GOOD', 198);
INSERT INTO public.condition VALUES (987, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 198);
INSERT INTO public.condition VALUES (988, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 198);
INSERT INTO public.condition VALUES (989, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 198);
INSERT INTO public.condition VALUES (990, NULL, 'OTHER', 198);
INSERT INTO public.condition VALUES (991, 'Connection is in place and functioning as intended.', 'GOOD', 199);
INSERT INTO public.condition VALUES (992, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 199);
INSERT INTO public.condition VALUES (993, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 199);
INSERT INTO public.condition VALUES (994, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 199);
INSERT INTO public.condition VALUES (995, NULL, 'OTHER', 199);
INSERT INTO public.condition VALUES (996, 'None', 'GOOD', 200);
INSERT INTO public.condition VALUES (997, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 200);
INSERT INTO public.condition VALUES (998, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 200);
INSERT INTO public.condition VALUES (999, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 200);
INSERT INTO public.condition VALUES (1000, NULL, 'OTHER', 200);
INSERT INTO public.condition VALUES (1001, 'Not applicable', 'GOOD', 201);
INSERT INTO public.condition VALUES (1002, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 201);
INSERT INTO public.condition VALUES (1003, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 201);
INSERT INTO public.condition VALUES (1004, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 201);
INSERT INTO public.condition VALUES (1005, NULL, 'OTHER', 201);
INSERT INTO public.condition VALUES (1006, 'None', 'GOOD', 202);
INSERT INTO public.condition VALUES (1007, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 202);
INSERT INTO public.condition VALUES (1008, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 202);
INSERT INTO public.condition VALUES (1009, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 202);
INSERT INTO public.condition VALUES (1010, NULL, 'OTHER', 202);
INSERT INTO public.condition VALUES (1011, 'None', 'GOOD', 203);
INSERT INTO public.condition VALUES (1012, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 203);
INSERT INTO public.condition VALUES (1013, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 203);
INSERT INTO public.condition VALUES (1014, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 203);
INSERT INTO public.condition VALUES (1015, NULL, 'OTHER', 203);
INSERT INTO public.condition VALUES (1016, 'Connection is in place and functioning as intended.', 'GOOD', 204);
INSERT INTO public.condition VALUES (1017, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 204);
INSERT INTO public.condition VALUES (1018, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 204);
INSERT INTO public.condition VALUES (1019, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 204);
INSERT INTO public.condition VALUES (1020, NULL, 'OTHER', 204);
INSERT INTO public.condition VALUES (1021, 'None or insignificant cracks.', 'GOOD', 205);
INSERT INTO public.condition VALUES (1022, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 205);
INSERT INTO public.condition VALUES (1023, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 205);
INSERT INTO public.condition VALUES (1024, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 205);
INSERT INTO public.condition VALUES (1025, NULL, 'OTHER', 205);
INSERT INTO public.condition VALUES (1026, 'None', 'GOOD', 206);
INSERT INTO public.condition VALUES (1027, 'Initiated breakdown or deterioration.', 'FAIR', 206);
INSERT INTO public.condition VALUES (1028, 'Significant deterioration or breakdown, but does not warrant structural review.', 'POOR', 206);
INSERT INTO public.condition VALUES (1029, '', 'SEVERE', 206);
INSERT INTO public.condition VALUES (1030, NULL, 'OTHER', 206);
INSERT INTO public.condition VALUES (1031, 'None', 'GOOD', 207);
INSERT INTO public.condition VALUES (1032, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 207);
INSERT INTO public.condition VALUES (1033, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 207);
INSERT INTO public.condition VALUES (1034, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 207);
INSERT INTO public.condition VALUES (1035, NULL, 'OTHER', 207);
INSERT INTO public.condition VALUES (1036, 'None', 'GOOD', 208);
INSERT INTO public.condition VALUES (1037, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 208);
INSERT INTO public.condition VALUES (1038, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 208);
INSERT INTO public.condition VALUES (1039, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 208);
INSERT INTO public.condition VALUES (1040, NULL, 'OTHER', 208);
INSERT INTO public.condition VALUES (1041, 'None', 'GOOD', 209);
INSERT INTO public.condition VALUES (1042, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 209);
INSERT INTO public.condition VALUES (1043, 'Heavy build-up with rust staining.', 'POOR', 209);
INSERT INTO public.condition VALUES (1044, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 209);
INSERT INTO public.condition VALUES (1047, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 210);
INSERT INTO public.condition VALUES (1048, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 210);
INSERT INTO public.condition VALUES (1049, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 210);
INSERT INTO public.condition VALUES (1050, NULL, 'OTHER', 210);
INSERT INTO public.condition VALUES (1051, 'None', 'GOOD', 211);
INSERT INTO public.condition VALUES (1052, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 211);
INSERT INTO public.condition VALUES (1053, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 211);
INSERT INTO public.condition VALUES (1054, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 211);
INSERT INTO public.condition VALUES (1055, NULL, 'OTHER', 211);
INSERT INTO public.condition VALUES (1056, 'None', 'GOOD', 212);
INSERT INTO public.condition VALUES (1057, 'Present without measurable section loss.', 'FAIR', 212);
INSERT INTO public.condition VALUES (1058, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 212);
INSERT INTO public.condition VALUES (1059, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 212);
INSERT INTO public.condition VALUES (1060, NULL, 'OTHER', 212);
INSERT INTO public.condition VALUES (1061, 'None', 'GOOD', 213);
INSERT INTO public.condition VALUES (1062, 'Present without section loss.', 'FAIR', 213);
INSERT INTO public.condition VALUES (1063, 'Present with section loss, but does not warrant structural review.', 'POOR', 213);
INSERT INTO public.condition VALUES (1064, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 213);
INSERT INTO public.condition VALUES (1065, NULL, 'OTHER', 213);
INSERT INTO public.condition VALUES (1066, 'None or insignificant cracks.', 'GOOD', 214);
INSERT INTO public.condition VALUES (1067, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.', 'FAIR', 214);
INSERT INTO public.condition VALUES (1068, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.', 'POOR', 214);
INSERT INTO public.condition VALUES (1069, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 214);
INSERT INTO public.condition VALUES (1070, NULL, 'OTHER', 214);
INSERT INTO public.condition VALUES (1071, 'None', 'GOOD', 215);
INSERT INTO public.condition VALUES (1072, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 215);
INSERT INTO public.condition VALUES (1073, 'Heavy build-up with rust staining.', 'POOR', 215);
INSERT INTO public.condition VALUES (1074, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 215);
INSERT INTO public.condition VALUES (1075, NULL, 'OTHER', 215);
INSERT INTO public.condition VALUES (1076, 'No abrasion or wearing.', 'GOOD', 216);
INSERT INTO public.condition VALUES (1077, 'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.', 'FAIR', 216);
INSERT INTO public.condition VALUES (1078, 'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.', 'POOR', 216);
INSERT INTO public.condition VALUES (1079, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 216);
INSERT INTO public.condition VALUES (1080, NULL, 'OTHER', 216);
INSERT INTO public.condition VALUES (1081, 'Not applicable', 'GOOD', 217);
INSERT INTO public.condition VALUES (1082, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 217);
INSERT INTO public.condition VALUES (1083, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 217);
INSERT INTO public.condition VALUES (1084, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 217);
INSERT INTO public.condition VALUES (1085, NULL, 'OTHER', 217);
INSERT INTO public.condition VALUES (1086, 'None', 'GOOD', 218);
INSERT INTO public.condition VALUES (1087, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 218);
INSERT INTO public.condition VALUES (1088, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 218);
INSERT INTO public.condition VALUES (1089, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 218);
INSERT INTO public.condition VALUES (1090, NULL, 'OTHER', 218);
INSERT INTO public.condition VALUES (1091, 'None', 'GOOD', 219);
INSERT INTO public.condition VALUES (1092, 'Present without measurable section loss.', 'FAIR', 219);
INSERT INTO public.condition VALUES (1093, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 219);
INSERT INTO public.condition VALUES (1094, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 219);
INSERT INTO public.condition VALUES (1095, NULL, 'OTHER', 219);
INSERT INTO public.condition VALUES (1096, 'None', 'GOOD', 220);
INSERT INTO public.condition VALUES (1097, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 220);
INSERT INTO public.condition VALUES (1098, 'Heavy build-up with rust staining.', 'POOR', 220);
INSERT INTO public.condition VALUES (1099, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 220);
INSERT INTO public.condition VALUES (1100, NULL, 'OTHER', 220);
INSERT INTO public.condition VALUES (1101, 'None or insignificant cracks.', 'GOOD', 221);
INSERT INTO public.condition VALUES (1102, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 221);
INSERT INTO public.condition VALUES (1103, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 221);
INSERT INTO public.condition VALUES (1104, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 221);
INSERT INTO public.condition VALUES (1105, NULL, 'OTHER', 221);
INSERT INTO public.condition VALUES (1106, 'No abrasion or wearing.', 'GOOD', 222);
INSERT INTO public.condition VALUES (1107, 'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.', 'FAIR', 222);
INSERT INTO public.condition VALUES (1108, 'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.', 'POOR', 222);
INSERT INTO public.condition VALUES (1109, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 222);
INSERT INTO public.condition VALUES (1110, NULL, 'OTHER', 222);
INSERT INTO public.condition VALUES (1111, 'Not applicable', 'GOOD', 223);
INSERT INTO public.condition VALUES (1112, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 223);
INSERT INTO public.condition VALUES (1113, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 223);
INSERT INTO public.condition VALUES (1114, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 223);
INSERT INTO public.condition VALUES (1115, NULL, 'OTHER', 223);
INSERT INTO public.condition VALUES (1116, 'None', 'GOOD', 224);
INSERT INTO public.condition VALUES (1117, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 224);
INSERT INTO public.condition VALUES (1118, 'Heavy build-up with rust staining.', 'POOR', 224);
INSERT INTO public.condition VALUES (1119, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 224);
INSERT INTO public.condition VALUES (1120, NULL, 'OTHER', 224);
INSERT INTO public.condition VALUES (1121, 'None', 'GOOD', 225);
INSERT INTO public.condition VALUES (1122, 'Cracking or voids in less than 10% of joints.', 'FAIR', 225);
INSERT INTO public.condition VALUES (1123, 'Cracking or voids in 10% or more of the of joints', 'POOR', 225);
INSERT INTO public.condition VALUES (1124, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 225);
INSERT INTO public.condition VALUES (1125, NULL, 'OTHER', 225);
INSERT INTO public.condition VALUES (1126, 'None', 'GOOD', 226);
INSERT INTO public.condition VALUES (1127, 'Block or stone has split or spalled with no shifting.', 'FAIR', 226);
INSERT INTO public.condition VALUES (1128, 'Block or stone has split or spalled with shifting but does not warrant a structural review.', 'POOR', 226);
INSERT INTO public.condition VALUES (1129, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 226);
INSERT INTO public.condition VALUES (1130, NULL, 'OTHER', 226);
INSERT INTO public.condition VALUES (1131, 'None', 'GOOD', 227);
INSERT INTO public.condition VALUES (1132, 'Sound Patch', 'FAIR', 227);
INSERT INTO public.condition VALUES (1133, 'Unsound Patch', 'POOR', 227);
INSERT INTO public.condition VALUES (1134, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 227);
INSERT INTO public.condition VALUES (1135, NULL, 'OTHER', 227);
INSERT INTO public.condition VALUES (1136, 'None', 'GOOD', 228);
INSERT INTO public.condition VALUES (1137, 'Block or stone has shifted slightly out of alignment.', 'FAIR', 228);
INSERT INTO public.condition VALUES (1138, 'Block or stone has shifted significantly out of alignment or is missing but does not warrant structural review.', 'POOR', 228);
INSERT INTO public.condition VALUES (1139, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 228);
INSERT INTO public.condition VALUES (1140, NULL, 'OTHER', 228);
INSERT INTO public.condition VALUES (1141, 'Not applicable', 'GOOD', 229);
INSERT INTO public.condition VALUES (1142, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 229);
INSERT INTO public.condition VALUES (1143, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 229);
INSERT INTO public.condition VALUES (1144, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 229);
INSERT INTO public.condition VALUES (1145, NULL, 'OTHER', 229);
INSERT INTO public.condition VALUES (1146, 'Connection is in place and functioning as intended.', 'GOOD', 230);
INSERT INTO public.condition VALUES (1147, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 230);
INSERT INTO public.condition VALUES (1148, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 230);
INSERT INTO public.condition VALUES (1149, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 230);
INSERT INTO public.condition VALUES (1150, NULL, 'OTHER', 230);
INSERT INTO public.condition VALUES (1151, 'None', 'GOOD', 231);
INSERT INTO public.condition VALUES (1152, 'Affects less than 10% of the member section.', 'FAIR', 231);
INSERT INTO public.condition VALUES (1153, 'Affects 10% or more of the member but does not warrant structural review.', 'POOR', 231);
INSERT INTO public.condition VALUES (1154, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 231);
INSERT INTO public.condition VALUES (1155, NULL, 'OTHER', 231);
INSERT INTO public.condition VALUES (1156, 'Surface penetration less than 5% of the member thickness regardless of location.', 'GOOD', 232);
INSERT INTO public.condition VALUES (1157, 'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.', 'FAIR', 232);
INSERT INTO public.condition VALUES (1158, 'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.', 'POOR', 232);
INSERT INTO public.condition VALUES (1159, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 232);
INSERT INTO public.condition VALUES (1160, NULL, 'OTHER', 232);
INSERT INTO public.condition VALUES (1161, 'None', 'GOOD', 233);
INSERT INTO public.condition VALUES (1162, 'Crack that has been arrested through effective measures.', 'FAIR', 233);
INSERT INTO public.condition VALUES (1163, 'Identified crack exists that is not arrested, but does not require structural review', 'POOR', 233);
INSERT INTO public.condition VALUES (1164, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 233);
INSERT INTO public.condition VALUES (1165, NULL, 'OTHER', 233);
INSERT INTO public.condition VALUES (1166, 'None', 'GOOD', 234);
INSERT INTO public.condition VALUES (1167, 'Length less than the member depth or arrested with effective actions taken to mitigate.', 'FAIR', 234);
INSERT INTO public.condition VALUES (1168, 'Length equal to or greater than the member depth, but does not require structural review.', 'POOR', 234);
INSERT INTO public.condition VALUES (1169, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 234);
INSERT INTO public.condition VALUES (1170, NULL, 'OTHER', 234);
INSERT INTO public.condition VALUES (1174, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 235);
INSERT INTO public.condition VALUES (1175, NULL, 'OTHER', 235);
INSERT INTO public.condition VALUES (1176, 'Not applicable', 'GOOD', 236);
INSERT INTO public.condition VALUES (1177, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 236);
INSERT INTO public.condition VALUES (1178, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 236);
INSERT INTO public.condition VALUES (1179, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 236);
INSERT INTO public.condition VALUES (1180, NULL, 'OTHER', 236);
INSERT INTO public.condition VALUES (1181, 'None', 'GOOD', 237);
INSERT INTO public.condition VALUES (1182, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 237);
INSERT INTO public.condition VALUES (1183, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 237);
INSERT INTO public.condition VALUES (1184, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 237);
INSERT INTO public.condition VALUES (1185, NULL, 'OTHER', 237);
INSERT INTO public.condition VALUES (1186, 'None', 'GOOD', 238);
INSERT INTO public.condition VALUES (1187, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 238);
INSERT INTO public.condition VALUES (1188, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 238);
INSERT INTO public.condition VALUES (1189, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 238);
INSERT INTO public.condition VALUES (1190, NULL, 'OTHER', 238);
INSERT INTO public.condition VALUES (1191, 'Connection is in place and functioning as intended.', 'GOOD', 239);
INSERT INTO public.condition VALUES (1192, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 239);
INSERT INTO public.condition VALUES (1193, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 239);
INSERT INTO public.condition VALUES (1194, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 239);
INSERT INTO public.condition VALUES (1195, NULL, 'OTHER', 239);
INSERT INTO public.condition VALUES (1196, 'None', 'GOOD', 240);
INSERT INTO public.condition VALUES (1197, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 240);
INSERT INTO public.condition VALUES (1198, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 240);
INSERT INTO public.condition VALUES (1199, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 240);
INSERT INTO public.condition VALUES (1200, NULL, 'OTHER', 240);
INSERT INTO public.condition VALUES (1201, 'Not applicable', 'GOOD', 241);
INSERT INTO public.condition VALUES (1202, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 241);
INSERT INTO public.condition VALUES (1203, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 241);
INSERT INTO public.condition VALUES (1204, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 241);
INSERT INTO public.condition VALUES (1205, NULL, 'OTHER', 241);
INSERT INTO public.condition VALUES (1206, 'None', 'GOOD', 242);
INSERT INTO public.condition VALUES (1207, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 242);
INSERT INTO public.condition VALUES (1208, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 242);
INSERT INTO public.condition VALUES (1209, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 242);
INSERT INTO public.condition VALUES (1210, NULL, 'OTHER', 242);
INSERT INTO public.condition VALUES (1211, 'None', 'GOOD', 243);
INSERT INTO public.condition VALUES (1212, 'Present without measurable section loss.', 'FAIR', 243);
INSERT INTO public.condition VALUES (1213, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 243);
INSERT INTO public.condition VALUES (1214, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 243);
INSERT INTO public.condition VALUES (1215, NULL, 'OTHER', 243);
INSERT INTO public.condition VALUES (1216, 'None', 'GOOD', 244);
INSERT INTO public.condition VALUES (1217, 'Present without section loss.', 'FAIR', 244);
INSERT INTO public.condition VALUES (1218, 'Present with section loss, but does not warrant structural review.', 'POOR', 244);
INSERT INTO public.condition VALUES (1219, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 244);
INSERT INTO public.condition VALUES (1220, NULL, 'OTHER', 244);
INSERT INTO public.condition VALUES (1221, 'None or insignificant cracks.', 'GOOD', 245);
INSERT INTO public.condition VALUES (1222, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.', 'FAIR', 245);
INSERT INTO public.condition VALUES (1223, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.', 'POOR', 245);
INSERT INTO public.condition VALUES (1224, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 245);
INSERT INTO public.condition VALUES (1225, NULL, 'OTHER', 245);
INSERT INTO public.condition VALUES (1226, 'None', 'GOOD', 246);
INSERT INTO public.condition VALUES (1227, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 246);
INSERT INTO public.condition VALUES (1228, 'Heavy build-up with rust staining.', 'POOR', 246);
INSERT INTO public.condition VALUES (1229, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 246);
INSERT INTO public.condition VALUES (1230, NULL, 'OTHER', 246);
INSERT INTO public.condition VALUES (1231, 'Not applicable', 'GOOD', 247);
INSERT INTO public.condition VALUES (1232, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 247);
INSERT INTO public.condition VALUES (1233, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 247);
INSERT INTO public.condition VALUES (1234, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 247);
INSERT INTO public.condition VALUES (1235, NULL, 'OTHER', 247);
INSERT INTO public.condition VALUES (1236, 'None', 'GOOD', 248);
INSERT INTO public.condition VALUES (1237, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 248);
INSERT INTO public.condition VALUES (1238, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 248);
INSERT INTO public.condition VALUES (1239, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 248);
INSERT INTO public.condition VALUES (1240, NULL, 'OTHER', 248);
INSERT INTO public.condition VALUES (1241, 'None', 'GOOD', 249);
INSERT INTO public.condition VALUES (1242, 'Present without measurable section loss.', 'FAIR', 249);
INSERT INTO public.condition VALUES (1243, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 249);
INSERT INTO public.condition VALUES (1244, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 249);
INSERT INTO public.condition VALUES (1245, NULL, 'OTHER', 249);
INSERT INTO public.condition VALUES (1246, 'None', 'GOOD', 250);
INSERT INTO public.condition VALUES (1247, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 250);
INSERT INTO public.condition VALUES (1248, 'Heavy build-up with rust staining.', 'POOR', 250);
INSERT INTO public.condition VALUES (1249, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 250);
INSERT INTO public.condition VALUES (1250, NULL, 'OTHER', 250);
INSERT INTO public.condition VALUES (1251, 'None or insignificant cracks.', 'GOOD', 251);
INSERT INTO public.condition VALUES (1252, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 251);
INSERT INTO public.condition VALUES (1253, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 251);
INSERT INTO public.condition VALUES (1254, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 251);
INSERT INTO public.condition VALUES (1255, NULL, 'OTHER', 251);
INSERT INTO public.condition VALUES (1256, 'Not applicable', 'GOOD', 252);
INSERT INTO public.condition VALUES (1257, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 252);
INSERT INTO public.condition VALUES (1258, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 252);
INSERT INTO public.condition VALUES (1259, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 252);
INSERT INTO public.condition VALUES (1260, NULL, 'OTHER', 252);
INSERT INTO public.condition VALUES (1261, 'Connection is in place and functioning as intended.', 'GOOD', 253);
INSERT INTO public.condition VALUES (1262, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 253);
INSERT INTO public.condition VALUES (1263, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 253);
INSERT INTO public.condition VALUES (1264, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 253);
INSERT INTO public.condition VALUES (1265, NULL, 'OTHER', 253);
INSERT INTO public.condition VALUES (1266, 'None', 'GOOD', 254);
INSERT INTO public.condition VALUES (1267, 'Affects less than 10% of the member section.', 'FAIR', 254);
INSERT INTO public.condition VALUES (1268, 'Affects 10% or more of the member but does not warrant structural review.', 'POOR', 254);
INSERT INTO public.condition VALUES (1269, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 254);
INSERT INTO public.condition VALUES (1270, NULL, 'OTHER', 254);
INSERT INTO public.condition VALUES (1271, 'Surface penetration less than 5% of the member thickness regardless of location.', 'GOOD', 255);
INSERT INTO public.condition VALUES (1272, 'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.', 'FAIR', 255);
INSERT INTO public.condition VALUES (1273, 'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.', 'POOR', 255);
INSERT INTO public.condition VALUES (1274, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 255);
INSERT INTO public.condition VALUES (1275, NULL, 'OTHER', 255);
INSERT INTO public.condition VALUES (1276, 'None', 'GOOD', 256);
INSERT INTO public.condition VALUES (1277, 'Crack that has been arrested through effective measures.', 'FAIR', 256);
INSERT INTO public.condition VALUES (1278, 'Identified crack exists that is not arrested, but does not require structural review', 'POOR', 256);
INSERT INTO public.condition VALUES (1279, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 256);
INSERT INTO public.condition VALUES (1280, NULL, 'OTHER', 256);
INSERT INTO public.condition VALUES (1281, 'None', 'GOOD', 257);
INSERT INTO public.condition VALUES (1282, 'Length less than the member depth or arrested with effective actions taken to mitigate.', 'FAIR', 257);
INSERT INTO public.condition VALUES (1283, 'Length equal to or greater than the member depth, but does not require structural review.', 'POOR', 257);
INSERT INTO public.condition VALUES (1284, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 257);
INSERT INTO public.condition VALUES (1285, NULL, 'OTHER', 257);
INSERT INTO public.condition VALUES (1286, 'None or no measurable section loss.', 'GOOD', 258);
INSERT INTO public.condition VALUES (1287, 'Section loss less than 10% of the member thickness.', 'FAIR', 258);
INSERT INTO public.condition VALUES (1288, 'Section loss 10% or more of the member thickness, but does not warrant structural review.', 'POOR', 258);
INSERT INTO public.condition VALUES (1289, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 258);
INSERT INTO public.condition VALUES (1290, NULL, 'OTHER', 258);
INSERT INTO public.condition VALUES (1291, 'Not applicable', 'GOOD', 259);
INSERT INTO public.condition VALUES (1292, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 259);
INSERT INTO public.condition VALUES (1293, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 259);
INSERT INTO public.condition VALUES (1601, 'Not applicable', 'GOOD', 321);
INSERT INTO public.condition VALUES (1294, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 259);
INSERT INTO public.condition VALUES (1295, NULL, 'OTHER', 259);
INSERT INTO public.condition VALUES (1296, 'None', 'GOOD', 260);
INSERT INTO public.condition VALUES (1297, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 260);
INSERT INTO public.condition VALUES (1298, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 260);
INSERT INTO public.condition VALUES (1299, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 260);
INSERT INTO public.condition VALUES (1300, NULL, 'OTHER', 260);
INSERT INTO public.condition VALUES (1301, 'None', 'GOOD', 261);
INSERT INTO public.condition VALUES (1302, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 261);
INSERT INTO public.condition VALUES (1303, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 261);
INSERT INTO public.condition VALUES (1304, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 261);
INSERT INTO public.condition VALUES (1305, NULL, 'OTHER', 261);
INSERT INTO public.condition VALUES (1306, 'Connection is in place and functioning as intended.', 'GOOD', 262);
INSERT INTO public.condition VALUES (1307, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 262);
INSERT INTO public.condition VALUES (1308, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 262);
INSERT INTO public.condition VALUES (1309, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 262);
INSERT INTO public.condition VALUES (1310, NULL, 'OTHER', 262);
INSERT INTO public.condition VALUES (1311, 'None', 'GOOD', 263);
INSERT INTO public.condition VALUES (1312, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 263);
INSERT INTO public.condition VALUES (1313, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 263);
INSERT INTO public.condition VALUES (1314, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 263);
INSERT INTO public.condition VALUES (1315, NULL, 'OTHER', 263);
INSERT INTO public.condition VALUES (1316, 'None', 'GOOD', 264);
INSERT INTO public.condition VALUES (1317, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 264);
INSERT INTO public.condition VALUES (1318, 'Heavy build-up with rust staining.', 'POOR', 264);
INSERT INTO public.condition VALUES (1319, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 264);
INSERT INTO public.condition VALUES (1320, NULL, 'OTHER', 264);
INSERT INTO public.condition VALUES (1321, 'None or insignificant cracks.', 'GOOD', 265);
INSERT INTO public.condition VALUES (1322, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 265);
INSERT INTO public.condition VALUES (1323, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 265);
INSERT INTO public.condition VALUES (1324, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 265);
INSERT INTO public.condition VALUES (1325, NULL, 'OTHER', 265);
INSERT INTO public.condition VALUES (1326, 'None', 'GOOD', 266);
INSERT INTO public.condition VALUES (1327, 'Initiated breakdown or deterioration.', 'FAIR', 266);
INSERT INTO public.condition VALUES (1328, 'Significant deterioration or breakdown, but does not warrant structural review.', 'POOR', 266);
INSERT INTO public.condition VALUES (1329, '', 'SEVERE', 266);
INSERT INTO public.condition VALUES (1330, NULL, 'OTHER', 266);
INSERT INTO public.condition VALUES (1331, 'None', 'GOOD', 267);
INSERT INTO public.condition VALUES (1332, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 267);
INSERT INTO public.condition VALUES (1333, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 267);
INSERT INTO public.condition VALUES (1334, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 267);
INSERT INTO public.condition VALUES (1335, NULL, 'OTHER', 267);
INSERT INTO public.condition VALUES (1336, 'Not applicable', 'GOOD', 268);
INSERT INTO public.condition VALUES (1337, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 268);
INSERT INTO public.condition VALUES (1338, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 268);
INSERT INTO public.condition VALUES (1339, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 268);
INSERT INTO public.condition VALUES (1340, NULL, 'OTHER', 268);
INSERT INTO public.condition VALUES (1341, 'None', 'GOOD', 269);
INSERT INTO public.condition VALUES (1342, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 269);
INSERT INTO public.condition VALUES (1343, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 269);
INSERT INTO public.condition VALUES (1344, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 269);
INSERT INTO public.condition VALUES (1345, NULL, 'OTHER', 269);
INSERT INTO public.condition VALUES (1346, 'None', 'GOOD', 270);
INSERT INTO public.condition VALUES (1347, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 270);
INSERT INTO public.condition VALUES (1348, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 270);
INSERT INTO public.condition VALUES (1349, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 270);
INSERT INTO public.condition VALUES (1350, NULL, 'OTHER', 270);
INSERT INTO public.condition VALUES (1351, 'Connection is in place and functioning as intended.', 'GOOD', 271);
INSERT INTO public.condition VALUES (1352, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 271);
INSERT INTO public.condition VALUES (1353, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 271);
INSERT INTO public.condition VALUES (1354, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 271);
INSERT INTO public.condition VALUES (1355, NULL, 'OTHER', 271);
INSERT INTO public.condition VALUES (1356, 'None', 'GOOD', 272);
INSERT INTO public.condition VALUES (1357, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 272);
INSERT INTO public.condition VALUES (1358, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 272);
INSERT INTO public.condition VALUES (1359, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 272);
INSERT INTO public.condition VALUES (1360, NULL, 'OTHER', 272);
INSERT INTO public.condition VALUES (1361, 'Not applicable', 'GOOD', 273);
INSERT INTO public.condition VALUES (1362, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 273);
INSERT INTO public.condition VALUES (1363, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 273);
INSERT INTO public.condition VALUES (1364, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 273);
INSERT INTO public.condition VALUES (1365, NULL, 'OTHER', 273);
INSERT INTO public.condition VALUES (1366, 'None', 'GOOD', 274);
INSERT INTO public.condition VALUES (1367, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 274);
INSERT INTO public.condition VALUES (1368, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 274);
INSERT INTO public.condition VALUES (1369, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 274);
INSERT INTO public.condition VALUES (1370, NULL, 'OTHER', 274);
INSERT INTO public.condition VALUES (1371, 'None', 'GOOD', 275);
INSERT INTO public.condition VALUES (1372, 'Present without measurable section loss.', 'FAIR', 275);
INSERT INTO public.condition VALUES (1373, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 275);
INSERT INTO public.condition VALUES (1374, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 275);
INSERT INTO public.condition VALUES (1375, NULL, 'OTHER', 275);
INSERT INTO public.condition VALUES (1376, 'None', 'GOOD', 276);
INSERT INTO public.condition VALUES (1377, 'Present without section loss.', 'FAIR', 276);
INSERT INTO public.condition VALUES (1378, 'Present with section loss, but does not warrant structural review.', 'POOR', 276);
INSERT INTO public.condition VALUES (1379, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 276);
INSERT INTO public.condition VALUES (1380, NULL, 'OTHER', 276);
INSERT INTO public.condition VALUES (1381, 'None or insignificant cracks.', 'GOOD', 277);
INSERT INTO public.condition VALUES (1382, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.', 'FAIR', 277);
INSERT INTO public.condition VALUES (1383, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.', 'POOR', 277);
INSERT INTO public.condition VALUES (1384, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 277);
INSERT INTO public.condition VALUES (1385, NULL, 'OTHER', 277);
INSERT INTO public.condition VALUES (1386, 'None', 'GOOD', 278);
INSERT INTO public.condition VALUES (1387, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 278);
INSERT INTO public.condition VALUES (1388, 'Heavy build-up with rust staining.', 'POOR', 278);
INSERT INTO public.condition VALUES (1389, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 278);
INSERT INTO public.condition VALUES (1390, NULL, 'OTHER', 278);
INSERT INTO public.condition VALUES (1391, 'Not applicable', 'GOOD', 279);
INSERT INTO public.condition VALUES (1392, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 279);
INSERT INTO public.condition VALUES (1393, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 279);
INSERT INTO public.condition VALUES (1394, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 279);
INSERT INTO public.condition VALUES (1395, NULL, 'OTHER', 279);
INSERT INTO public.condition VALUES (1396, 'None', 'GOOD', 280);
INSERT INTO public.condition VALUES (1397, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 280);
INSERT INTO public.condition VALUES (1398, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 280);
INSERT INTO public.condition VALUES (1399, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 280);
INSERT INTO public.condition VALUES (1400, NULL, 'OTHER', 280);
INSERT INTO public.condition VALUES (1401, 'None', 'GOOD', 281);
INSERT INTO public.condition VALUES (1402, 'Present without measurable section loss.', 'FAIR', 281);
INSERT INTO public.condition VALUES (1403, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 281);
INSERT INTO public.condition VALUES (1404, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 281);
INSERT INTO public.condition VALUES (1405, NULL, 'OTHER', 281);
INSERT INTO public.condition VALUES (1406, 'None', 'GOOD', 282);
INSERT INTO public.condition VALUES (1407, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 282);
INSERT INTO public.condition VALUES (1408, 'Heavy build-up with rust staining.', 'POOR', 282);
INSERT INTO public.condition VALUES (1409, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 282);
INSERT INTO public.condition VALUES (1410, NULL, 'OTHER', 282);
INSERT INTO public.condition VALUES (1411, 'None or insignificant cracks.', 'GOOD', 283);
INSERT INTO public.condition VALUES (1412, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 283);
INSERT INTO public.condition VALUES (1413, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 283);
INSERT INTO public.condition VALUES (1414, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 283);
INSERT INTO public.condition VALUES (1415, NULL, 'OTHER', 283);
INSERT INTO public.condition VALUES (1416, 'Not applicable', 'GOOD', 284);
INSERT INTO public.condition VALUES (1417, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 284);
INSERT INTO public.condition VALUES (1966, 'Connection is in place and functioning as intended.', 'GOOD', 394);
INSERT INTO public.condition VALUES (1418, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 284);
INSERT INTO public.condition VALUES (1419, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 284);
INSERT INTO public.condition VALUES (1420, NULL, 'OTHER', 284);
INSERT INTO public.condition VALUES (1421, 'Connection is in place and functioning as intended.', 'GOOD', 285);
INSERT INTO public.condition VALUES (1422, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 285);
INSERT INTO public.condition VALUES (1423, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 285);
INSERT INTO public.condition VALUES (1424, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 285);
INSERT INTO public.condition VALUES (1425, NULL, 'OTHER', 285);
INSERT INTO public.condition VALUES (1426, 'None', 'GOOD', 286);
INSERT INTO public.condition VALUES (1427, 'Affects less than 10% of the member section.', 'FAIR', 286);
INSERT INTO public.condition VALUES (1428, 'Affects 10% or more of the member but does not warrant structural review.', 'POOR', 286);
INSERT INTO public.condition VALUES (1429, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 286);
INSERT INTO public.condition VALUES (1430, NULL, 'OTHER', 286);
INSERT INTO public.condition VALUES (1431, 'Surface penetration less than 5% of the member thickness regardless of location.', 'GOOD', 287);
INSERT INTO public.condition VALUES (1432, 'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.', 'FAIR', 287);
INSERT INTO public.condition VALUES (1433, 'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.', 'POOR', 287);
INSERT INTO public.condition VALUES (1434, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 287);
INSERT INTO public.condition VALUES (1435, NULL, 'OTHER', 287);
INSERT INTO public.condition VALUES (1436, 'None', 'GOOD', 288);
INSERT INTO public.condition VALUES (1437, 'Crack that has been arrested through effective measures.', 'FAIR', 288);
INSERT INTO public.condition VALUES (1438, 'Identified crack exists that is not arrested, but does not require structural review', 'POOR', 288);
INSERT INTO public.condition VALUES (1439, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 288);
INSERT INTO public.condition VALUES (1440, NULL, 'OTHER', 288);
INSERT INTO public.condition VALUES (1441, 'None', 'GOOD', 289);
INSERT INTO public.condition VALUES (1442, 'Length less than the member depth or arrested with effective actions taken to mitigate.', 'FAIR', 289);
INSERT INTO public.condition VALUES (1443, 'Length equal to or greater than the member depth, but does not require structural review.', 'POOR', 289);
INSERT INTO public.condition VALUES (1444, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 289);
INSERT INTO public.condition VALUES (1445, NULL, 'OTHER', 289);
INSERT INTO public.condition VALUES (1446, 'None or no measurable section loss.', 'GOOD', 290);
INSERT INTO public.condition VALUES (1447, 'Section loss less than 10% of the member thickness.', 'FAIR', 290);
INSERT INTO public.condition VALUES (1448, 'Section loss 10% or more of the member thickness, but does not warrant structural review.', 'POOR', 290);
INSERT INTO public.condition VALUES (1449, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 290);
INSERT INTO public.condition VALUES (1450, NULL, 'OTHER', 290);
INSERT INTO public.condition VALUES (1451, 'Not applicable', 'GOOD', 291);
INSERT INTO public.condition VALUES (1452, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 291);
INSERT INTO public.condition VALUES (1453, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 291);
INSERT INTO public.condition VALUES (1454, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 291);
INSERT INTO public.condition VALUES (1455, NULL, 'OTHER', 291);
INSERT INTO public.condition VALUES (1456, 'None', 'GOOD', 292);
INSERT INTO public.condition VALUES (1457, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 292);
INSERT INTO public.condition VALUES (1458, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 292);
INSERT INTO public.condition VALUES (1459, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 292);
INSERT INTO public.condition VALUES (1460, NULL, 'OTHER', 292);
INSERT INTO public.condition VALUES (1461, 'None', 'GOOD', 293);
INSERT INTO public.condition VALUES (1462, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 293);
INSERT INTO public.condition VALUES (1463, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 293);
INSERT INTO public.condition VALUES (1464, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 293);
INSERT INTO public.condition VALUES (1465, NULL, 'OTHER', 293);
INSERT INTO public.condition VALUES (1466, 'Connection is in place and functioning as intended.', 'GOOD', 294);
INSERT INTO public.condition VALUES (1467, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 294);
INSERT INTO public.condition VALUES (1468, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 294);
INSERT INTO public.condition VALUES (1469, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 294);
INSERT INTO public.condition VALUES (1470, NULL, 'OTHER', 294);
INSERT INTO public.condition VALUES (1471, 'None', 'GOOD', 295);
INSERT INTO public.condition VALUES (1472, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 295);
INSERT INTO public.condition VALUES (1473, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 295);
INSERT INTO public.condition VALUES (1474, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 295);
INSERT INTO public.condition VALUES (1475, NULL, 'OTHER', 295);
INSERT INTO public.condition VALUES (1476, 'None', 'GOOD', 296);
INSERT INTO public.condition VALUES (2091, 'None', 'GOOD', 419);
INSERT INTO public.condition VALUES (1477, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 296);
INSERT INTO public.condition VALUES (1478, 'Heavy build-up with rust staining.', 'POOR', 296);
INSERT INTO public.condition VALUES (1479, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 296);
INSERT INTO public.condition VALUES (1480, NULL, 'OTHER', 296);
INSERT INTO public.condition VALUES (1481, 'None or insignificant cracks.', 'GOOD', 297);
INSERT INTO public.condition VALUES (1482, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 297);
INSERT INTO public.condition VALUES (1483, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 297);
INSERT INTO public.condition VALUES (1484, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 297);
INSERT INTO public.condition VALUES (1485, NULL, 'OTHER', 297);
INSERT INTO public.condition VALUES (1486, 'None', 'GOOD', 298);
INSERT INTO public.condition VALUES (1487, 'Initiated breakdown or deterioration.', 'FAIR', 298);
INSERT INTO public.condition VALUES (1488, 'Significant deterioration or breakdown, but does not warrant structural review.', 'POOR', 298);
INSERT INTO public.condition VALUES (1489, '', 'SEVERE', 298);
INSERT INTO public.condition VALUES (1490, NULL, 'OTHER', 298);
INSERT INTO public.condition VALUES (1491, 'None', 'GOOD', 299);
INSERT INTO public.condition VALUES (1492, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 299);
INSERT INTO public.condition VALUES (1493, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 299);
INSERT INTO public.condition VALUES (1494, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 299);
INSERT INTO public.condition VALUES (1495, NULL, 'OTHER', 299);
INSERT INTO public.condition VALUES (1496, 'Not applicable', 'GOOD', 300);
INSERT INTO public.condition VALUES (1497, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 300);
INSERT INTO public.condition VALUES (1498, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 300);
INSERT INTO public.condition VALUES (1499, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 300);
INSERT INTO public.condition VALUES (1500, NULL, 'OTHER', 300);
INSERT INTO public.condition VALUES (1501, 'None', 'GOOD', 301);
INSERT INTO public.condition VALUES (1502, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 301);
INSERT INTO public.condition VALUES (1503, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 301);
INSERT INTO public.condition VALUES (1504, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 301);
INSERT INTO public.condition VALUES (1505, NULL, 'OTHER', 301);
INSERT INTO public.condition VALUES (1506, 'None', 'GOOD', 302);
INSERT INTO public.condition VALUES (1507, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 302);
INSERT INTO public.condition VALUES (1508, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 302);
INSERT INTO public.condition VALUES (1509, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 302);
INSERT INTO public.condition VALUES (1510, NULL, 'OTHER', 302);
INSERT INTO public.condition VALUES (1511, 'Connection is in place and functioning as intended.', 'GOOD', 303);
INSERT INTO public.condition VALUES (1512, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 303);
INSERT INTO public.condition VALUES (1513, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 303);
INSERT INTO public.condition VALUES (1514, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 303);
INSERT INTO public.condition VALUES (1515, NULL, 'OTHER', 303);
INSERT INTO public.condition VALUES (1516, 'None', 'GOOD', 304);
INSERT INTO public.condition VALUES (1517, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 304);
INSERT INTO public.condition VALUES (1518, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 304);
INSERT INTO public.condition VALUES (1519, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 304);
INSERT INTO public.condition VALUES (1520, NULL, 'OTHER', 304);
INSERT INTO public.condition VALUES (1521, 'Not applicable', 'GOOD', 305);
INSERT INTO public.condition VALUES (1522, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 305);
INSERT INTO public.condition VALUES (1523, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 305);
INSERT INTO public.condition VALUES (1524, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 305);
INSERT INTO public.condition VALUES (1525, NULL, 'OTHER', 305);
INSERT INTO public.condition VALUES (1526, 'None', 'GOOD', 306);
INSERT INTO public.condition VALUES (1527, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 306);
INSERT INTO public.condition VALUES (1528, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 306);
INSERT INTO public.condition VALUES (1529, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 306);
INSERT INTO public.condition VALUES (1530, NULL, 'OTHER', 306);
INSERT INTO public.condition VALUES (1531, 'None', 'GOOD', 307);
INSERT INTO public.condition VALUES (1532, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 307);
INSERT INTO public.condition VALUES (1533, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 307);
INSERT INTO public.condition VALUES (1534, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 307);
INSERT INTO public.condition VALUES (1535, NULL, 'OTHER', 307);
INSERT INTO public.condition VALUES (1536, 'Connection is in place and functioning as intended.', 'GOOD', 308);
INSERT INTO public.condition VALUES (1537, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 308);
INSERT INTO public.condition VALUES (1538, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 308);
INSERT INTO public.condition VALUES (2092, 'Sound Patch', 'FAIR', 419);
INSERT INTO public.condition VALUES (1539, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 308);
INSERT INTO public.condition VALUES (1540, NULL, 'OTHER', 308);
INSERT INTO public.condition VALUES (1541, 'None', 'GOOD', 309);
INSERT INTO public.condition VALUES (1542, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 309);
INSERT INTO public.condition VALUES (1543, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 309);
INSERT INTO public.condition VALUES (1544, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 309);
INSERT INTO public.condition VALUES (1545, NULL, 'OTHER', 309);
INSERT INTO public.condition VALUES (1546, 'Not applicable', 'GOOD', 310);
INSERT INTO public.condition VALUES (1547, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 310);
INSERT INTO public.condition VALUES (1548, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 310);
INSERT INTO public.condition VALUES (1549, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 310);
INSERT INTO public.condition VALUES (1550, NULL, 'OTHER', 310);
INSERT INTO public.condition VALUES (1551, 'None', 'GOOD', 311);
INSERT INTO public.condition VALUES (1552, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 311);
INSERT INTO public.condition VALUES (1553, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 311);
INSERT INTO public.condition VALUES (1554, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 311);
INSERT INTO public.condition VALUES (1555, NULL, 'OTHER', 311);
INSERT INTO public.condition VALUES (1556, 'None', 'GOOD', 312);
INSERT INTO public.condition VALUES (1557, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 312);
INSERT INTO public.condition VALUES (1558, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 312);
INSERT INTO public.condition VALUES (1559, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 312);
INSERT INTO public.condition VALUES (1560, NULL, 'OTHER', 312);
INSERT INTO public.condition VALUES (1561, 'Connection is in place and functioning as intended.', 'GOOD', 313);
INSERT INTO public.condition VALUES (1562, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 313);
INSERT INTO public.condition VALUES (1563, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 313);
INSERT INTO public.condition VALUES (1564, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 313);
INSERT INTO public.condition VALUES (1565, NULL, 'OTHER', 313);
INSERT INTO public.condition VALUES (1566, 'None', 'GOOD', 314);
INSERT INTO public.condition VALUES (1567, 'Initiated breakdown or deterioration.', 'FAIR', 314);
INSERT INTO public.condition VALUES (1568, 'Significant deterioration or breakdown, but does not warrant structural review.', 'POOR', 314);
INSERT INTO public.condition VALUES (1569, '', 'SEVERE', 314);
INSERT INTO public.condition VALUES (1570, NULL, 'OTHER', 314);
INSERT INTO public.condition VALUES (1571, 'None', 'GOOD', 315);
INSERT INTO public.condition VALUES (1572, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 315);
INSERT INTO public.condition VALUES (1573, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 315);
INSERT INTO public.condition VALUES (1574, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 315);
INSERT INTO public.condition VALUES (1575, NULL, 'OTHER', 315);
INSERT INTO public.condition VALUES (1576, 'Not applicable', 'GOOD', 316);
INSERT INTO public.condition VALUES (1577, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 316);
INSERT INTO public.condition VALUES (1578, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 316);
INSERT INTO public.condition VALUES (1579, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 316);
INSERT INTO public.condition VALUES (1580, NULL, 'OTHER', 316);
INSERT INTO public.condition VALUES (1581, 'None', 'GOOD', 317);
INSERT INTO public.condition VALUES (1582, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 317);
INSERT INTO public.condition VALUES (1583, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 317);
INSERT INTO public.condition VALUES (1584, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 317);
INSERT INTO public.condition VALUES (1585, NULL, 'OTHER', 317);
INSERT INTO public.condition VALUES (1586, 'None', 'GOOD', 318);
INSERT INTO public.condition VALUES (1587, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 318);
INSERT INTO public.condition VALUES (1588, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 318);
INSERT INTO public.condition VALUES (1589, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 318);
INSERT INTO public.condition VALUES (1590, NULL, 'OTHER', 318);
INSERT INTO public.condition VALUES (1591, 'Connection is in place and functioning as intended.', 'GOOD', 319);
INSERT INTO public.condition VALUES (1592, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 319);
INSERT INTO public.condition VALUES (1593, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 319);
INSERT INTO public.condition VALUES (1594, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 319);
INSERT INTO public.condition VALUES (1595, NULL, 'OTHER', 319);
INSERT INTO public.condition VALUES (1596, 'None', 'GOOD', 320);
INSERT INTO public.condition VALUES (1597, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 320);
INSERT INTO public.condition VALUES (1598, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 320);
INSERT INTO public.condition VALUES (1599, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 320);
INSERT INTO public.condition VALUES (1600, NULL, 'OTHER', 320);
INSERT INTO public.condition VALUES (1602, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 321);
INSERT INTO public.condition VALUES (1603, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 321);
INSERT INTO public.condition VALUES (1604, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 321);
INSERT INTO public.condition VALUES (1605, NULL, 'OTHER', 321);
INSERT INTO public.condition VALUES (1606, 'None', 'GOOD', 322);
INSERT INTO public.condition VALUES (1607, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 322);
INSERT INTO public.condition VALUES (1608, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 322);
INSERT INTO public.condition VALUES (1609, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 322);
INSERT INTO public.condition VALUES (1610, NULL, 'OTHER', 322);
INSERT INTO public.condition VALUES (1611, 'None', 'GOOD', 323);
INSERT INTO public.condition VALUES (1612, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 323);
INSERT INTO public.condition VALUES (1613, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 323);
INSERT INTO public.condition VALUES (1614, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 323);
INSERT INTO public.condition VALUES (1615, NULL, 'OTHER', 323);
INSERT INTO public.condition VALUES (1616, 'Connection is in place and functioning as intended.', 'GOOD', 324);
INSERT INTO public.condition VALUES (1617, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 324);
INSERT INTO public.condition VALUES (1618, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 324);
INSERT INTO public.condition VALUES (1619, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 324);
INSERT INTO public.condition VALUES (1620, NULL, 'OTHER', 324);
INSERT INTO public.condition VALUES (1621, 'None', 'GOOD', 325);
INSERT INTO public.condition VALUES (1622, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 325);
INSERT INTO public.condition VALUES (1623, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 325);
INSERT INTO public.condition VALUES (1624, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 325);
INSERT INTO public.condition VALUES (1625, NULL, 'OTHER', 325);
INSERT INTO public.condition VALUES (1626, 'Not applicable', 'GOOD', 326);
INSERT INTO public.condition VALUES (1627, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 326);
INSERT INTO public.condition VALUES (1628, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 326);
INSERT INTO public.condition VALUES (1629, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 326);
INSERT INTO public.condition VALUES (1630, NULL, 'OTHER', 326);
INSERT INTO public.condition VALUES (1631, 'None', 'GOOD', 327);
INSERT INTO public.condition VALUES (1632, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 327);
INSERT INTO public.condition VALUES (1633, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 327);
INSERT INTO public.condition VALUES (1634, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 327);
INSERT INTO public.condition VALUES (1635, NULL, 'OTHER', 327);
INSERT INTO public.condition VALUES (1636, 'None', 'GOOD', 328);
INSERT INTO public.condition VALUES (1637, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 328);
INSERT INTO public.condition VALUES (1638, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 328);
INSERT INTO public.condition VALUES (1639, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 328);
INSERT INTO public.condition VALUES (1640, NULL, 'OTHER', 328);
INSERT INTO public.condition VALUES (1641, 'Connection is in place and functioning as intended.', 'GOOD', 329);
INSERT INTO public.condition VALUES (1642, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 329);
INSERT INTO public.condition VALUES (1643, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 329);
INSERT INTO public.condition VALUES (1644, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 329);
INSERT INTO public.condition VALUES (1645, NULL, 'OTHER', 329);
INSERT INTO public.condition VALUES (1646, 'None', 'GOOD', 330);
INSERT INTO public.condition VALUES (1647, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 330);
INSERT INTO public.condition VALUES (1648, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 330);
INSERT INTO public.condition VALUES (1649, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 330);
INSERT INTO public.condition VALUES (1650, NULL, 'OTHER', 330);
INSERT INTO public.condition VALUES (1651, 'Not applicable', 'GOOD', 331);
INSERT INTO public.condition VALUES (1652, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 331);
INSERT INTO public.condition VALUES (1653, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 331);
INSERT INTO public.condition VALUES (1654, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 331);
INSERT INTO public.condition VALUES (1655, NULL, 'OTHER', 331);
INSERT INTO public.condition VALUES (1656, 'None', 'GOOD', 332);
INSERT INTO public.condition VALUES (1657, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 332);
INSERT INTO public.condition VALUES (1658, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 332);
INSERT INTO public.condition VALUES (1659, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 332);
INSERT INTO public.condition VALUES (1660, NULL, 'OTHER', 332);
INSERT INTO public.condition VALUES (1661, 'None', 'GOOD', 333);
INSERT INTO public.condition VALUES (1662, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 333);
INSERT INTO public.condition VALUES (1663, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 333);
INSERT INTO public.condition VALUES (1664, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 333);
INSERT INTO public.condition VALUES (1665, NULL, 'OTHER', 333);
INSERT INTO public.condition VALUES (1666, 'Connection is in place and functioning as intended.', 'GOOD', 334);
INSERT INTO public.condition VALUES (1667, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 334);
INSERT INTO public.condition VALUES (1668, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 334);
INSERT INTO public.condition VALUES (1669, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 334);
INSERT INTO public.condition VALUES (1670, NULL, 'OTHER', 334);
INSERT INTO public.condition VALUES (1671, 'None', 'GOOD', 335);
INSERT INTO public.condition VALUES (1672, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 335);
INSERT INTO public.condition VALUES (1673, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 335);
INSERT INTO public.condition VALUES (1674, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 335);
INSERT INTO public.condition VALUES (1675, NULL, 'OTHER', 335);
INSERT INTO public.condition VALUES (1676, 'Not applicable', 'GOOD', 336);
INSERT INTO public.condition VALUES (1677, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 336);
INSERT INTO public.condition VALUES (1678, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 336);
INSERT INTO public.condition VALUES (1679, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 336);
INSERT INTO public.condition VALUES (1680, NULL, 'OTHER', 336);
INSERT INTO public.condition VALUES (1681, 'None', 'GOOD', 337);
INSERT INTO public.condition VALUES (1682, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 337);
INSERT INTO public.condition VALUES (1683, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 337);
INSERT INTO public.condition VALUES (1684, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 337);
INSERT INTO public.condition VALUES (1685, NULL, 'OTHER', 337);
INSERT INTO public.condition VALUES (1686, 'None', 'GOOD', 338);
INSERT INTO public.condition VALUES (1687, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 338);
INSERT INTO public.condition VALUES (1688, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 338);
INSERT INTO public.condition VALUES (1689, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 338);
INSERT INTO public.condition VALUES (1690, NULL, 'OTHER', 338);
INSERT INTO public.condition VALUES (1691, 'Connection is in place and functioning as intended.', 'GOOD', 339);
INSERT INTO public.condition VALUES (1692, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 339);
INSERT INTO public.condition VALUES (1693, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 339);
INSERT INTO public.condition VALUES (1694, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 339);
INSERT INTO public.condition VALUES (1695, NULL, 'OTHER', 339);
INSERT INTO public.condition VALUES (1696, 'None', 'GOOD', 340);
INSERT INTO public.condition VALUES (1697, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 340);
INSERT INTO public.condition VALUES (1698, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 340);
INSERT INTO public.condition VALUES (1699, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 340);
INSERT INTO public.condition VALUES (1700, NULL, 'OTHER', 340);
INSERT INTO public.condition VALUES (1701, 'Restraint system is functional and installed as designed.', 'GOOD', 341);
INSERT INTO public.condition VALUES (1702, 'Less than 20% of the restraint system is set improperly (excessive slack or tightness).', 'FAIR', 341);
INSERT INTO public.condition VALUES (1703, 'Between 20% and 50% of the restraint system is set improperly (excessive slack or tightness).', 'POOR', 341);
INSERT INTO public.condition VALUES (1704, 'More than 50% of the restraint system is set improperly (excessive slack or tightness).', 'SEVERE', 341);
INSERT INTO public.condition VALUES (1705, NULL, 'OTHER', 341);
INSERT INTO public.condition VALUES (1706, 'Not applicable', 'GOOD', 342);
INSERT INTO public.condition VALUES (1707, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 342);
INSERT INTO public.condition VALUES (1708, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 342);
INSERT INTO public.condition VALUES (1709, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 342);
INSERT INTO public.condition VALUES (1710, NULL, 'OTHER', 342);
INSERT INTO public.condition VALUES (1711, 'None', 'GOOD', 343);
INSERT INTO public.condition VALUES (1712, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 343);
INSERT INTO public.condition VALUES (1713, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 343);
INSERT INTO public.condition VALUES (1714, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 343);
INSERT INTO public.condition VALUES (1715, NULL, 'OTHER', 343);
INSERT INTO public.condition VALUES (1716, 'None', 'GOOD', 344);
INSERT INTO public.condition VALUES (1717, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 344);
INSERT INTO public.condition VALUES (1718, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 344);
INSERT INTO public.condition VALUES (1719, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 344);
INSERT INTO public.condition VALUES (1720, NULL, 'OTHER', 344);
INSERT INTO public.condition VALUES (1721, 'Connection is in place and functioning as intended.', 'GOOD', 345);
INSERT INTO public.condition VALUES (1722, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 345);
INSERT INTO public.condition VALUES (1723, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 345);
INSERT INTO public.condition VALUES (1724, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 345);
INSERT INTO public.condition VALUES (1725, NULL, 'OTHER', 345);
INSERT INTO public.condition VALUES (1726, 'None', 'GOOD', 346);
INSERT INTO public.condition VALUES (1727, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 346);
INSERT INTO public.condition VALUES (1728, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 346);
INSERT INTO public.condition VALUES (1729, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 346);
INSERT INTO public.condition VALUES (1730, NULL, 'OTHER', 346);
INSERT INTO public.condition VALUES (1731, 'Restraint system is functional and installed as designed.', 'GOOD', 347);
INSERT INTO public.condition VALUES (1732, 'Less than 20% of the restraint system is set improperly (excessive slack or tightness).', 'FAIR', 347);
INSERT INTO public.condition VALUES (1733, 'Between 20% and 50% of the restraint system is set improperly (excessive slack or tightness).', 'POOR', 347);
INSERT INTO public.condition VALUES (1734, 'More than 50% of the restraint system is set improperly (excessive slack or tightness).', 'SEVERE', 347);
INSERT INTO public.condition VALUES (1735, NULL, 'OTHER', 347);
INSERT INTO public.condition VALUES (1736, 'Not applicable', 'GOOD', 348);
INSERT INTO public.condition VALUES (1737, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 348);
INSERT INTO public.condition VALUES (1738, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 348);
INSERT INTO public.condition VALUES (1739, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 348);
INSERT INTO public.condition VALUES (1740, NULL, 'OTHER', 348);
INSERT INTO public.condition VALUES (1741, 'None', 'GOOD', 349);
INSERT INTO public.condition VALUES (1742, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 349);
INSERT INTO public.condition VALUES (1743, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 349);
INSERT INTO public.condition VALUES (1744, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 349);
INSERT INTO public.condition VALUES (1745, NULL, 'OTHER', 349);
INSERT INTO public.condition VALUES (1746, 'None', 'GOOD', 350);
INSERT INTO public.condition VALUES (1747, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 350);
INSERT INTO public.condition VALUES (1748, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 350);
INSERT INTO public.condition VALUES (1749, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 350);
INSERT INTO public.condition VALUES (1750, NULL, 'OTHER', 350);
INSERT INTO public.condition VALUES (1751, 'Connection is in place and functioning as intended.', 'GOOD', 351);
INSERT INTO public.condition VALUES (1752, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 351);
INSERT INTO public.condition VALUES (1753, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 351);
INSERT INTO public.condition VALUES (1754, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 351);
INSERT INTO public.condition VALUES (1755, NULL, 'OTHER', 351);
INSERT INTO public.condition VALUES (1756, 'None', 'GOOD', 352);
INSERT INTO public.condition VALUES (1757, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 352);
INSERT INTO public.condition VALUES (1758, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 352);
INSERT INTO public.condition VALUES (1759, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 352);
INSERT INTO public.condition VALUES (1760, NULL, 'OTHER', 352);
INSERT INTO public.condition VALUES (1761, 'Restraint system is functional and installed as designed.', 'GOOD', 353);
INSERT INTO public.condition VALUES (1762, 'Less than 20% of the restraint system is set improperly (excessive slack or tightness).', 'FAIR', 353);
INSERT INTO public.condition VALUES (1763, 'Between 20% and 50% of the restraint system is set improperly (excessive slack or tightness).', 'POOR', 353);
INSERT INTO public.condition VALUES (1764, 'More than 50% of the restraint system is set improperly (excessive slack or tightness).', 'SEVERE', 353);
INSERT INTO public.condition VALUES (1765, NULL, 'OTHER', 353);
INSERT INTO public.condition VALUES (1766, 'Not applicable', 'GOOD', 354);
INSERT INTO public.condition VALUES (1767, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 354);
INSERT INTO public.condition VALUES (1768, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 354);
INSERT INTO public.condition VALUES (1769, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 354);
INSERT INTO public.condition VALUES (1770, NULL, 'OTHER', 354);
INSERT INTO public.condition VALUES (1771, 'None', 'GOOD', 355);
INSERT INTO public.condition VALUES (1772, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 355);
INSERT INTO public.condition VALUES (1773, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 355);
INSERT INTO public.condition VALUES (1774, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 355);
INSERT INTO public.condition VALUES (1775, NULL, 'OTHER', 355);
INSERT INTO public.condition VALUES (1776, 'Connection is in place and functioning as intended.', 'GOOD', 356);
INSERT INTO public.condition VALUES (1777, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 356);
INSERT INTO public.condition VALUES (1778, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 356);
INSERT INTO public.condition VALUES (1779, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 356);
INSERT INTO public.condition VALUES (1780, NULL, 'OTHER', 356);
INSERT INTO public.condition VALUES (1781, 'Free to Move.', 'GOOD', 357);
INSERT INTO public.condition VALUES (1782, 'Minor Restriction', 'FAIR', 357);
INSERT INTO public.condition VALUES (1783, 'Restricted, but not warranting structural review.', 'POOR', 357);
INSERT INTO public.condition VALUES (1784, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 357);
INSERT INTO public.condition VALUES (1785, NULL, 'OTHER', 357);
INSERT INTO public.condition VALUES (1786, 'Lateral and vertical alignment is as expected for the temperature conditions.', 'GOOD', 358);
INSERT INTO public.condition VALUES (1787, 'Tolerable lateral or vertical alignment that is inconsistent with the temperature conditions.', 'FAIR', 358);
INSERT INTO public.condition VALUES (1788, 'Approaching the limits of lateral or vertical alignment for the bearing, but does not warrant a structural review.', 'POOR', 358);
INSERT INTO public.condition VALUES (1789, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 358);
INSERT INTO public.condition VALUES (1790, NULL, 'OTHER', 358);
INSERT INTO public.condition VALUES (1791, 'None', 'GOOD', 359);
INSERT INTO public.condition VALUES (1792, 'Bulging less than 15% of the thickness.', 'FAIR', 359);
INSERT INTO public.condition VALUES (1793, 'Bulging 15% or more of the thickness.
Splitting or tearing.
Bearing''s surfaces are not parallel.
Does not warrant structural review.', 'POOR', 359);
INSERT INTO public.condition VALUES (1794, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 359);
INSERT INTO public.condition VALUES (1795, NULL, 'OTHER', 359);
INSERT INTO public.condition VALUES (1796, 'None', 'GOOD', 360);
INSERT INTO public.condition VALUES (1797, 'Less than 10%', 'FAIR', 360);
INSERT INTO public.condition VALUES (1798, '10% or more, but does not warrant structural review.', 'POOR', 360);
INSERT INTO public.condition VALUES (1799, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 360);
INSERT INTO public.condition VALUES (1800, NULL, 'OTHER', 360);
INSERT INTO public.condition VALUES (1801, 'Not applicable', 'GOOD', 361);
INSERT INTO public.condition VALUES (1802, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 361);
INSERT INTO public.condition VALUES (1803, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 361);
INSERT INTO public.condition VALUES (1804, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 361);
INSERT INTO public.condition VALUES (1805, NULL, 'OTHER', 361);
INSERT INTO public.condition VALUES (1806, 'None', 'GOOD', 362);
INSERT INTO public.condition VALUES (1807, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 362);
INSERT INTO public.condition VALUES (1808, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 362);
INSERT INTO public.condition VALUES (1809, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 362);
INSERT INTO public.condition VALUES (1810, NULL, 'OTHER', 362);
INSERT INTO public.condition VALUES (1811, 'Connection is in place and functioning as intended.', 'GOOD', 363);
INSERT INTO public.condition VALUES (1812, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 363);
INSERT INTO public.condition VALUES (1813, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 363);
INSERT INTO public.condition VALUES (1814, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 363);
INSERT INTO public.condition VALUES (1815, NULL, 'OTHER', 363);
INSERT INTO public.condition VALUES (1816, 'Free to Move.', 'GOOD', 364);
INSERT INTO public.condition VALUES (1817, 'Minor Restriction', 'FAIR', 364);
INSERT INTO public.condition VALUES (1818, 'Restricted, but not warranting structural review.', 'POOR', 364);
INSERT INTO public.condition VALUES (1819, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 364);
INSERT INTO public.condition VALUES (1820, NULL, 'OTHER', 364);
INSERT INTO public.condition VALUES (1821, 'Lateral and vertical alignment is as expected for the temperature conditions.', 'GOOD', 365);
INSERT INTO public.condition VALUES (1822, 'Tolerable lateral or vertical alignment that is inconsistent with the temperature conditions.', 'FAIR', 365);
INSERT INTO public.condition VALUES (1823, 'Approaching the limits of lateral or vertical alignment for the bearing, but does not warrant a structural review.', 'POOR', 365);
INSERT INTO public.condition VALUES (1824, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 365);
INSERT INTO public.condition VALUES (1825, NULL, 'OTHER', 365);
INSERT INTO public.condition VALUES (1826, 'None', 'GOOD', 366);
INSERT INTO public.condition VALUES (1827, 'Less than 10%', 'FAIR', 366);
INSERT INTO public.condition VALUES (1828, '10% or more, but does not warrant structural review.', 'POOR', 366);
INSERT INTO public.condition VALUES (1829, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 366);
INSERT INTO public.condition VALUES (1830, NULL, 'OTHER', 366);
INSERT INTO public.condition VALUES (1831, 'Not applicable', 'GOOD', 367);
INSERT INTO public.condition VALUES (1832, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 367);
INSERT INTO public.condition VALUES (1833, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 367);
INSERT INTO public.condition VALUES (1834, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 367);
INSERT INTO public.condition VALUES (1835, NULL, 'OTHER', 367);
INSERT INTO public.condition VALUES (1836, 'None', 'GOOD', 368);
INSERT INTO public.condition VALUES (1837, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 368);
INSERT INTO public.condition VALUES (1838, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 368);
INSERT INTO public.condition VALUES (1839, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 368);
INSERT INTO public.condition VALUES (1840, NULL, 'OTHER', 368);
INSERT INTO public.condition VALUES (1841, 'Connection is in place and functioning as intended.', 'GOOD', 369);
INSERT INTO public.condition VALUES (1842, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 369);
INSERT INTO public.condition VALUES (1843, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 369);
INSERT INTO public.condition VALUES (2093, 'Unsound Patch', 'POOR', 419);
INSERT INTO public.condition VALUES (2402, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 481);
INSERT INTO public.condition VALUES (1844, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 369);
INSERT INTO public.condition VALUES (1845, NULL, 'OTHER', 369);
INSERT INTO public.condition VALUES (1846, 'Free to Move.', 'GOOD', 370);
INSERT INTO public.condition VALUES (1847, 'Minor Restriction', 'FAIR', 370);
INSERT INTO public.condition VALUES (1848, 'Restricted, but not warranting structural review.', 'POOR', 370);
INSERT INTO public.condition VALUES (1849, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 370);
INSERT INTO public.condition VALUES (1850, NULL, 'OTHER', 370);
INSERT INTO public.condition VALUES (1851, 'Lateral and vertical alignment is as expected for the temperature conditions.', 'GOOD', 371);
INSERT INTO public.condition VALUES (1852, 'Tolerable lateral or vertical alignment that is inconsistent with the temperature conditions.', 'FAIR', 371);
INSERT INTO public.condition VALUES (1853, 'Approaching the limits of lateral or vertical alignment for the bearing, but does not warrant a structural review.', 'POOR', 371);
INSERT INTO public.condition VALUES (1854, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 371);
INSERT INTO public.condition VALUES (1855, NULL, 'OTHER', 371);
INSERT INTO public.condition VALUES (1856, 'None', 'GOOD', 372);
INSERT INTO public.condition VALUES (1857, 'Less than 10%', 'FAIR', 372);
INSERT INTO public.condition VALUES (1858, '10% or more, but does not warrant structural review.', 'POOR', 372);
INSERT INTO public.condition VALUES (1859, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 372);
INSERT INTO public.condition VALUES (1860, NULL, 'OTHER', 372);
INSERT INTO public.condition VALUES (1861, 'Not applicable', 'GOOD', 373);
INSERT INTO public.condition VALUES (1862, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 373);
INSERT INTO public.condition VALUES (1863, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 373);
INSERT INTO public.condition VALUES (1864, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 373);
INSERT INTO public.condition VALUES (1865, NULL, 'OTHER', 373);
INSERT INTO public.condition VALUES (1866, 'None', 'GOOD', 374);
INSERT INTO public.condition VALUES (1867, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 374);
INSERT INTO public.condition VALUES (1868, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 374);
INSERT INTO public.condition VALUES (1869, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 374);
INSERT INTO public.condition VALUES (1870, NULL, 'OTHER', 374);
INSERT INTO public.condition VALUES (1871, 'Connection is in place and functioning as intended.', 'GOOD', 375);
INSERT INTO public.condition VALUES (1872, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 375);
INSERT INTO public.condition VALUES (1873, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 375);
INSERT INTO public.condition VALUES (1874, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 375);
INSERT INTO public.condition VALUES (1875, NULL, 'OTHER', 375);
INSERT INTO public.condition VALUES (1876, 'Free to Move.', 'GOOD', 376);
INSERT INTO public.condition VALUES (1877, 'Minor Restriction', 'FAIR', 376);
INSERT INTO public.condition VALUES (1878, 'Restricted, but not warranting structural review.', 'POOR', 376);
INSERT INTO public.condition VALUES (1879, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 376);
INSERT INTO public.condition VALUES (1880, NULL, 'OTHER', 376);
INSERT INTO public.condition VALUES (1881, 'Lateral and vertical alignment is as expected for the temperature conditions.', 'GOOD', 377);
INSERT INTO public.condition VALUES (1882, 'Tolerable lateral or vertical alignment that is inconsistent with the temperature conditions.', 'FAIR', 377);
INSERT INTO public.condition VALUES (1883, 'Approaching the limits of lateral or vertical alignment for the bearing, but does not warrant a structural review.', 'POOR', 377);
INSERT INTO public.condition VALUES (1884, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 377);
INSERT INTO public.condition VALUES (1885, NULL, 'OTHER', 377);
INSERT INTO public.condition VALUES (1886, 'None', 'GOOD', 378);
INSERT INTO public.condition VALUES (1887, 'Less than 10%', 'FAIR', 378);
INSERT INTO public.condition VALUES (1888, '10% or more, but does not warrant structural review.', 'POOR', 378);
INSERT INTO public.condition VALUES (1889, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 378);
INSERT INTO public.condition VALUES (1890, NULL, 'OTHER', 378);
INSERT INTO public.condition VALUES (1891, 'Not applicable', 'GOOD', 379);
INSERT INTO public.condition VALUES (1892, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 379);
INSERT INTO public.condition VALUES (1893, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 379);
INSERT INTO public.condition VALUES (1894, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 379);
INSERT INTO public.condition VALUES (1895, NULL, 'OTHER', 379);
INSERT INTO public.condition VALUES (1896, 'None', 'GOOD', 380);
INSERT INTO public.condition VALUES (1897, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 380);
INSERT INTO public.condition VALUES (1898, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 380);
INSERT INTO public.condition VALUES (1899, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 380);
INSERT INTO public.condition VALUES (1900, NULL, 'OTHER', 380);
INSERT INTO public.condition VALUES (1901, 'Connection is in place and functioning as intended.', 'GOOD', 381);
INSERT INTO public.condition VALUES (1902, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 381);
INSERT INTO public.condition VALUES (1903, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 381);
INSERT INTO public.condition VALUES (1967, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 394);
INSERT INTO public.condition VALUES (2400, NULL, 'OTHER', 480);
INSERT INTO public.condition VALUES (2401, 'None', 'GOOD', 481);
INSERT INTO public.condition VALUES (1904, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 381);
INSERT INTO public.condition VALUES (1905, NULL, 'OTHER', 381);
INSERT INTO public.condition VALUES (1906, 'Free to Move.', 'GOOD', 382);
INSERT INTO public.condition VALUES (1907, 'Minor Restriction', 'FAIR', 382);
INSERT INTO public.condition VALUES (1908, 'Restricted, but not warranting structural review.', 'POOR', 382);
INSERT INTO public.condition VALUES (1909, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 382);
INSERT INTO public.condition VALUES (1910, NULL, 'OTHER', 382);
INSERT INTO public.condition VALUES (1911, 'Lateral and vertical alignment is as expected for the temperature conditions.', 'GOOD', 383);
INSERT INTO public.condition VALUES (1912, 'Tolerable lateral or vertical alignment that is inconsistent with the temperature conditions.', 'FAIR', 383);
INSERT INTO public.condition VALUES (1913, 'Approaching the limits of lateral or vertical alignment for the bearing, but does not warrant a structural review.', 'POOR', 383);
INSERT INTO public.condition VALUES (1914, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 383);
INSERT INTO public.condition VALUES (1915, NULL, 'OTHER', 383);
INSERT INTO public.condition VALUES (1916, 'None', 'GOOD', 384);
INSERT INTO public.condition VALUES (1917, 'Bulging less than 15% of the thickness.', 'FAIR', 384);
INSERT INTO public.condition VALUES (1918, 'Bulging 15% or more of the thickness.
Splitting or tearing.
Bearing''s surfaces are not parallel.
Does not warrant structural review.', 'POOR', 384);
INSERT INTO public.condition VALUES (1919, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 384);
INSERT INTO public.condition VALUES (1920, NULL, 'OTHER', 384);
INSERT INTO public.condition VALUES (1921, 'None', 'GOOD', 385);
INSERT INTO public.condition VALUES (1922, 'Less than 10%', 'FAIR', 385);
INSERT INTO public.condition VALUES (1923, '10% or more, but does not warrant structural review.', 'POOR', 385);
INSERT INTO public.condition VALUES (1924, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 385);
INSERT INTO public.condition VALUES (1925, NULL, 'OTHER', 385);
INSERT INTO public.condition VALUES (1926, 'Not applicable', 'GOOD', 386);
INSERT INTO public.condition VALUES (1927, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 386);
INSERT INTO public.condition VALUES (1928, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 386);
INSERT INTO public.condition VALUES (1929, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 386);
INSERT INTO public.condition VALUES (1930, NULL, 'OTHER', 386);
INSERT INTO public.condition VALUES (1931, 'None', 'GOOD', 387);
INSERT INTO public.condition VALUES (1932, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 387);
INSERT INTO public.condition VALUES (1933, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 387);
INSERT INTO public.condition VALUES (1934, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 387);
INSERT INTO public.condition VALUES (1935, NULL, 'OTHER', 387);
INSERT INTO public.condition VALUES (1936, 'Connection is in place and functioning as intended.', 'GOOD', 388);
INSERT INTO public.condition VALUES (1937, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 388);
INSERT INTO public.condition VALUES (1938, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 388);
INSERT INTO public.condition VALUES (1939, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 388);
INSERT INTO public.condition VALUES (1940, NULL, 'OTHER', 388);
INSERT INTO public.condition VALUES (1941, 'Free to Move.', 'GOOD', 389);
INSERT INTO public.condition VALUES (1942, 'Minor Restriction', 'FAIR', 389);
INSERT INTO public.condition VALUES (1943, 'Restricted, but not warranting structural review.', 'POOR', 389);
INSERT INTO public.condition VALUES (1944, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 389);
INSERT INTO public.condition VALUES (1945, NULL, 'OTHER', 389);
INSERT INTO public.condition VALUES (1946, 'Lateral and vertical alignment is as expected for the temperature conditions.', 'GOOD', 390);
INSERT INTO public.condition VALUES (1947, 'Tolerable lateral or vertical alignment that is inconsistent with the temperature conditions.', 'FAIR', 390);
INSERT INTO public.condition VALUES (1948, 'Approaching the limits of lateral or vertical alignment for the bearing, but does not warrant a structural review.', 'POOR', 390);
INSERT INTO public.condition VALUES (1949, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 390);
INSERT INTO public.condition VALUES (1950, NULL, 'OTHER', 390);
INSERT INTO public.condition VALUES (1951, 'None', 'GOOD', 391);
INSERT INTO public.condition VALUES (1952, 'Less than 10%', 'FAIR', 391);
INSERT INTO public.condition VALUES (1953, '10% or more, but does not warrant structural review.', 'POOR', 391);
INSERT INTO public.condition VALUES (1954, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 391);
INSERT INTO public.condition VALUES (1955, NULL, 'OTHER', 391);
INSERT INTO public.condition VALUES (1956, 'Not applicable', 'GOOD', 392);
INSERT INTO public.condition VALUES (1957, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 392);
INSERT INTO public.condition VALUES (1958, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 392);
INSERT INTO public.condition VALUES (1959, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 392);
INSERT INTO public.condition VALUES (1960, NULL, 'OTHER', 392);
INSERT INTO public.condition VALUES (1961, 'None', 'GOOD', 393);
INSERT INTO public.condition VALUES (1962, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 393);
INSERT INTO public.condition VALUES (1963, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 393);
INSERT INTO public.condition VALUES (1964, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 393);
INSERT INTO public.condition VALUES (1965, NULL, 'OTHER', 393);
INSERT INTO public.condition VALUES (1968, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 394);
INSERT INTO public.condition VALUES (1969, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 394);
INSERT INTO public.condition VALUES (1970, NULL, 'OTHER', 394);
INSERT INTO public.condition VALUES (1971, 'Free to Move.', 'GOOD', 395);
INSERT INTO public.condition VALUES (1972, 'Minor Restriction', 'FAIR', 395);
INSERT INTO public.condition VALUES (1973, 'Restricted, but not warranting structural review.', 'POOR', 395);
INSERT INTO public.condition VALUES (1974, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 395);
INSERT INTO public.condition VALUES (1975, NULL, 'OTHER', 395);
INSERT INTO public.condition VALUES (1976, 'Lateral and vertical alignment is as expected for the temperature conditions.', 'GOOD', 396);
INSERT INTO public.condition VALUES (1977, 'Tolerable lateral or vertical alignment that is inconsistent with the temperature conditions.', 'FAIR', 396);
INSERT INTO public.condition VALUES (1978, 'Approaching the limits of lateral or vertical alignment for the bearing, but does not warrant a structural review.', 'POOR', 396);
INSERT INTO public.condition VALUES (1979, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 396);
INSERT INTO public.condition VALUES (1980, NULL, 'OTHER', 396);
INSERT INTO public.condition VALUES (1981, 'None', 'GOOD', 397);
INSERT INTO public.condition VALUES (1982, 'Less than 10%', 'FAIR', 397);
INSERT INTO public.condition VALUES (1983, '10% or more, but does not warrant structural review.', 'POOR', 397);
INSERT INTO public.condition VALUES (1984, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 397);
INSERT INTO public.condition VALUES (1985, NULL, 'OTHER', 397);
INSERT INTO public.condition VALUES (1986, 'Not applicable', 'GOOD', 398);
INSERT INTO public.condition VALUES (1987, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 398);
INSERT INTO public.condition VALUES (1988, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 398);
INSERT INTO public.condition VALUES (1989, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 398);
INSERT INTO public.condition VALUES (1990, NULL, 'OTHER', 398);
INSERT INTO public.condition VALUES (1991, 'None', 'GOOD', 399);
INSERT INTO public.condition VALUES (1992, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 399);
INSERT INTO public.condition VALUES (1993, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 399);
INSERT INTO public.condition VALUES (1994, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 399);
INSERT INTO public.condition VALUES (1995, NULL, 'OTHER', 399);
INSERT INTO public.condition VALUES (1996, 'None', 'GOOD', 400);
INSERT INTO public.condition VALUES (1997, 'Present without measurable section loss.', 'FAIR', 400);
INSERT INTO public.condition VALUES (1998, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 400);
INSERT INTO public.condition VALUES (1999, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 400);
INSERT INTO public.condition VALUES (2000, NULL, 'OTHER', 400);
INSERT INTO public.condition VALUES (2001, 'None', 'GOOD', 401);
INSERT INTO public.condition VALUES (2002, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 401);
INSERT INTO public.condition VALUES (2003, 'Heavy build-up with rust staining.', 'POOR', 401);
INSERT INTO public.condition VALUES (2004, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 401);
INSERT INTO public.condition VALUES (2005, NULL, 'OTHER', 401);
INSERT INTO public.condition VALUES (2006, 'None or insignificant cracks.', 'GOOD', 402);
INSERT INTO public.condition VALUES (2007, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 402);
INSERT INTO public.condition VALUES (2008, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 402);
INSERT INTO public.condition VALUES (2009, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 402);
INSERT INTO public.condition VALUES (2010, NULL, 'OTHER', 402);
INSERT INTO public.condition VALUES (2011, 'No abrasion or wearing.', 'GOOD', 403);
INSERT INTO public.condition VALUES (2012, 'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.', 'FAIR', 403);
INSERT INTO public.condition VALUES (2013, 'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.', 'POOR', 403);
INSERT INTO public.condition VALUES (2014, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 403);
INSERT INTO public.condition VALUES (2015, NULL, 'OTHER', 403);
INSERT INTO public.condition VALUES (2016, 'None', 'GOOD', 404);
INSERT INTO public.condition VALUES (2017, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 404);
INSERT INTO public.condition VALUES (2018, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 404);
INSERT INTO public.condition VALUES (2019, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 404);
INSERT INTO public.condition VALUES (2020, NULL, 'OTHER', 404);
INSERT INTO public.condition VALUES (2021, 'None', 'GOOD', 405);
INSERT INTO public.condition VALUES (2022, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 405);
INSERT INTO public.condition VALUES (2023, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 405);
INSERT INTO public.condition VALUES (2024, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 405);
INSERT INTO public.condition VALUES (2025, NULL, 'OTHER', 405);
INSERT INTO public.condition VALUES (2026, 'Not applicable', 'GOOD', 406);
INSERT INTO public.condition VALUES (2027, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 406);
INSERT INTO public.condition VALUES (2028, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 406);
INSERT INTO public.condition VALUES (2029, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 406);
INSERT INTO public.condition VALUES (2030, NULL, 'OTHER', 406);
INSERT INTO public.condition VALUES (2031, 'Connection is in place and functioning as intended.', 'GOOD', 407);
INSERT INTO public.condition VALUES (2032, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 407);
INSERT INTO public.condition VALUES (2033, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 407);
INSERT INTO public.condition VALUES (2034, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 407);
INSERT INTO public.condition VALUES (2035, NULL, 'OTHER', 407);
INSERT INTO public.condition VALUES (2036, 'None', 'GOOD', 408);
INSERT INTO public.condition VALUES (2037, 'Affects less than 10% of the member section.', 'FAIR', 408);
INSERT INTO public.condition VALUES (2038, 'Affects 10% or more of the member but does not warrant structural review.', 'POOR', 408);
INSERT INTO public.condition VALUES (2039, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 408);
INSERT INTO public.condition VALUES (2040, NULL, 'OTHER', 408);
INSERT INTO public.condition VALUES (2041, 'Surface penetration less than 5% of the member thickness regardless of location.', 'GOOD', 409);
INSERT INTO public.condition VALUES (2042, 'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.', 'FAIR', 409);
INSERT INTO public.condition VALUES (2043, 'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.', 'POOR', 409);
INSERT INTO public.condition VALUES (2044, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 409);
INSERT INTO public.condition VALUES (2045, NULL, 'OTHER', 409);
INSERT INTO public.condition VALUES (2046, 'None', 'GOOD', 410);
INSERT INTO public.condition VALUES (2047, 'Crack that has been arrested through effective measures.', 'FAIR', 410);
INSERT INTO public.condition VALUES (2048, 'Identified crack exists that is not arrested, but does not require structural review', 'POOR', 410);
INSERT INTO public.condition VALUES (2049, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 410);
INSERT INTO public.condition VALUES (2050, NULL, 'OTHER', 410);
INSERT INTO public.condition VALUES (2051, 'None', 'GOOD', 411);
INSERT INTO public.condition VALUES (2052, 'Length less than the member depth or arrested with effective actions taken to mitigate.', 'FAIR', 411);
INSERT INTO public.condition VALUES (2053, 'Length equal to or greater than the member depth, but does not require structural review.', 'POOR', 411);
INSERT INTO public.condition VALUES (2054, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 411);
INSERT INTO public.condition VALUES (2055, NULL, 'OTHER', 411);
INSERT INTO public.condition VALUES (2056, 'None or no measurable section loss.', 'GOOD', 412);
INSERT INTO public.condition VALUES (2057, 'Section loss less than 10% of the member thickness.', 'FAIR', 412);
INSERT INTO public.condition VALUES (2058, 'Section loss 10% or more of the member thickness, but does not warrant structural review.', 'POOR', 412);
INSERT INTO public.condition VALUES (2059, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 412);
INSERT INTO public.condition VALUES (2060, NULL, 'OTHER', 412);
INSERT INTO public.condition VALUES (2061, 'None', 'GOOD', 413);
INSERT INTO public.condition VALUES (2062, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 413);
INSERT INTO public.condition VALUES (2063, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 413);
INSERT INTO public.condition VALUES (2064, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 413);
INSERT INTO public.condition VALUES (2065, NULL, 'OTHER', 413);
INSERT INTO public.condition VALUES (2066, 'None', 'GOOD', 414);
INSERT INTO public.condition VALUES (2067, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 414);
INSERT INTO public.condition VALUES (2068, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 414);
INSERT INTO public.condition VALUES (2069, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 414);
INSERT INTO public.condition VALUES (2070, NULL, 'OTHER', 414);
INSERT INTO public.condition VALUES (2071, 'Not applicable', 'GOOD', 415);
INSERT INTO public.condition VALUES (2072, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 415);
INSERT INTO public.condition VALUES (2073, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 415);
INSERT INTO public.condition VALUES (2074, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 415);
INSERT INTO public.condition VALUES (2075, NULL, 'OTHER', 415);
INSERT INTO public.condition VALUES (2076, 'None', 'GOOD', 416);
INSERT INTO public.condition VALUES (2077, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 416);
INSERT INTO public.condition VALUES (2078, 'Heavy build-up with rust staining.', 'POOR', 416);
INSERT INTO public.condition VALUES (2079, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 416);
INSERT INTO public.condition VALUES (2080, NULL, 'OTHER', 416);
INSERT INTO public.condition VALUES (2081, 'None', 'GOOD', 417);
INSERT INTO public.condition VALUES (2082, 'Cracking or voids in less than 10% of joints.', 'FAIR', 417);
INSERT INTO public.condition VALUES (2083, 'Cracking or voids in 10% or more of the of joints', 'POOR', 417);
INSERT INTO public.condition VALUES (2084, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 417);
INSERT INTO public.condition VALUES (2085, NULL, 'OTHER', 417);
INSERT INTO public.condition VALUES (2086, 'None', 'GOOD', 418);
INSERT INTO public.condition VALUES (2087, 'Block or stone has split or spalled with no shifting.', 'FAIR', 418);
INSERT INTO public.condition VALUES (2088, 'Block or stone has split or spalled with shifting but does not warrant a structural review.', 'POOR', 418);
INSERT INTO public.condition VALUES (2089, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 418);
INSERT INTO public.condition VALUES (2090, NULL, 'OTHER', 418);
INSERT INTO public.condition VALUES (2094, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 419);
INSERT INTO public.condition VALUES (2095, NULL, 'OTHER', 419);
INSERT INTO public.condition VALUES (2096, 'None', 'GOOD', 420);
INSERT INTO public.condition VALUES (2097, 'Block or stone has shifted slightly out of alignment.', 'FAIR', 420);
INSERT INTO public.condition VALUES (2098, 'Block or stone has shifted significantly out of alignment or is missing but does not warrant structural review.', 'POOR', 420);
INSERT INTO public.condition VALUES (2099, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 420);
INSERT INTO public.condition VALUES (2100, NULL, 'OTHER', 420);
INSERT INTO public.condition VALUES (2101, 'None', 'GOOD', 421);
INSERT INTO public.condition VALUES (2102, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 421);
INSERT INTO public.condition VALUES (2103, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 421);
INSERT INTO public.condition VALUES (2104, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 421);
INSERT INTO public.condition VALUES (2105, NULL, 'OTHER', 421);
INSERT INTO public.condition VALUES (2106, 'None', 'GOOD', 422);
INSERT INTO public.condition VALUES (2107, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 422);
INSERT INTO public.condition VALUES (2108, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 422);
INSERT INTO public.condition VALUES (2109, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 422);
INSERT INTO public.condition VALUES (2110, NULL, 'OTHER', 422);
INSERT INTO public.condition VALUES (2111, 'Not applicable', 'GOOD', 423);
INSERT INTO public.condition VALUES (2112, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 423);
INSERT INTO public.condition VALUES (2113, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 423);
INSERT INTO public.condition VALUES (2114, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 423);
INSERT INTO public.condition VALUES (2115, NULL, 'OTHER', 423);
INSERT INTO public.condition VALUES (2116, 'None', 'GOOD', 424);
INSERT INTO public.condition VALUES (2117, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 424);
INSERT INTO public.condition VALUES (2118, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 424);
INSERT INTO public.condition VALUES (2119, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 424);
INSERT INTO public.condition VALUES (2120, NULL, 'OTHER', 424);
INSERT INTO public.condition VALUES (2121, 'None', 'GOOD', 425);
INSERT INTO public.condition VALUES (2122, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 425);
INSERT INTO public.condition VALUES (2123, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 425);
INSERT INTO public.condition VALUES (2124, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 425);
INSERT INTO public.condition VALUES (2125, NULL, 'OTHER', 425);
INSERT INTO public.condition VALUES (2126, 'Connection is in place and functioning as intended.', 'GOOD', 426);
INSERT INTO public.condition VALUES (2127, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 426);
INSERT INTO public.condition VALUES (2128, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 426);
INSERT INTO public.condition VALUES (2129, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 426);
INSERT INTO public.condition VALUES (2130, NULL, 'OTHER', 426);
INSERT INTO public.condition VALUES (2131, 'None or insignificant cracks.', 'GOOD', 427);
INSERT INTO public.condition VALUES (2132, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 427);
INSERT INTO public.condition VALUES (2133, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 427);
INSERT INTO public.condition VALUES (2134, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 427);
INSERT INTO public.condition VALUES (2135, NULL, 'OTHER', 427);
INSERT INTO public.condition VALUES (2136, 'None', 'GOOD', 428);
INSERT INTO public.condition VALUES (2137, 'Initiated breakdown or deterioration.', 'FAIR', 428);
INSERT INTO public.condition VALUES (2138, 'Significant deterioration or breakdown, but does not warrant structural review.', 'POOR', 428);
INSERT INTO public.condition VALUES (2139, '', 'SEVERE', 428);
INSERT INTO public.condition VALUES (2140, NULL, 'OTHER', 428);
INSERT INTO public.condition VALUES (2141, 'None', 'GOOD', 429);
INSERT INTO public.condition VALUES (2142, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 429);
INSERT INTO public.condition VALUES (2143, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 429);
INSERT INTO public.condition VALUES (2144, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 429);
INSERT INTO public.condition VALUES (2145, NULL, 'OTHER', 429);
INSERT INTO public.condition VALUES (2146, 'None', 'GOOD', 430);
INSERT INTO public.condition VALUES (2147, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 430);
INSERT INTO public.condition VALUES (2148, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 430);
INSERT INTO public.condition VALUES (2149, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 430);
INSERT INTO public.condition VALUES (2150, NULL, 'OTHER', 430);
INSERT INTO public.condition VALUES (2151, 'None', 'GOOD', 431);
INSERT INTO public.condition VALUES (2152, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 431);
INSERT INTO public.condition VALUES (2153, 'Heavy build-up with rust staining.', 'POOR', 431);
INSERT INTO public.condition VALUES (2154, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 431);
INSERT INTO public.condition VALUES (2155, NULL, 'OTHER', 431);
INSERT INTO public.condition VALUES (2156, 'None', 'GOOD', 432);
INSERT INTO public.condition VALUES (2157, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 432);
INSERT INTO public.condition VALUES (2158, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 432);
INSERT INTO public.condition VALUES (2159, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 432);
INSERT INTO public.condition VALUES (2160, NULL, 'OTHER', 432);
INSERT INTO public.condition VALUES (2161, 'None', 'GOOD', 433);
INSERT INTO public.condition VALUES (2162, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 433);
INSERT INTO public.condition VALUES (2163, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 433);
INSERT INTO public.condition VALUES (2164, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 433);
INSERT INTO public.condition VALUES (2165, NULL, 'OTHER', 433);
INSERT INTO public.condition VALUES (2166, 'Not applicable', 'GOOD', 434);
INSERT INTO public.condition VALUES (2167, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 434);
INSERT INTO public.condition VALUES (2168, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 434);
INSERT INTO public.condition VALUES (2169, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 434);
INSERT INTO public.condition VALUES (2170, NULL, 'OTHER', 434);
INSERT INTO public.condition VALUES (2171, 'None', 'GOOD', 435);
INSERT INTO public.condition VALUES (2172, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 435);
INSERT INTO public.condition VALUES (2173, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 435);
INSERT INTO public.condition VALUES (2174, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 435);
INSERT INTO public.condition VALUES (2175, NULL, 'OTHER', 435);
INSERT INTO public.condition VALUES (2176, 'None', 'GOOD', 436);
INSERT INTO public.condition VALUES (2177, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 436);
INSERT INTO public.condition VALUES (2178, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 436);
INSERT INTO public.condition VALUES (2179, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 436);
INSERT INTO public.condition VALUES (2180, NULL, 'OTHER', 436);
INSERT INTO public.condition VALUES (2181, 'Connection is in place and functioning as intended.', 'GOOD', 437);
INSERT INTO public.condition VALUES (2182, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 437);
INSERT INTO public.condition VALUES (2183, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 437);
INSERT INTO public.condition VALUES (2184, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 437);
INSERT INTO public.condition VALUES (2185, NULL, 'OTHER', 437);
INSERT INTO public.condition VALUES (2186, 'None', 'GOOD', 438);
INSERT INTO public.condition VALUES (2187, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 438);
INSERT INTO public.condition VALUES (2188, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 438);
INSERT INTO public.condition VALUES (2189, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 438);
INSERT INTO public.condition VALUES (2190, NULL, 'OTHER', 438);
INSERT INTO public.condition VALUES (2191, 'None', 'GOOD', 439);
INSERT INTO public.condition VALUES (2192, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 439);
INSERT INTO public.condition VALUES (2193, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 439);
INSERT INTO public.condition VALUES (2194, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 439);
INSERT INTO public.condition VALUES (2195, NULL, 'OTHER', 439);
INSERT INTO public.condition VALUES (2196, 'None', 'GOOD', 440);
INSERT INTO public.condition VALUES (2197, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 440);
INSERT INTO public.condition VALUES (2198, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 440);
INSERT INTO public.condition VALUES (2199, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 440);
INSERT INTO public.condition VALUES (2200, NULL, 'OTHER', 440);
INSERT INTO public.condition VALUES (2201, 'Not applicable', 'GOOD', 441);
INSERT INTO public.condition VALUES (2202, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 441);
INSERT INTO public.condition VALUES (2203, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 441);
INSERT INTO public.condition VALUES (2204, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 441);
INSERT INTO public.condition VALUES (2205, NULL, 'OTHER', 441);
INSERT INTO public.condition VALUES (2206, 'None', 'GOOD', 442);
INSERT INTO public.condition VALUES (2207, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 442);
INSERT INTO public.condition VALUES (2208, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 442);
INSERT INTO public.condition VALUES (2209, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 442);
INSERT INTO public.condition VALUES (2210, NULL, 'OTHER', 442);
INSERT INTO public.condition VALUES (2211, 'None', 'GOOD', 443);
INSERT INTO public.condition VALUES (2212, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 443);
INSERT INTO public.condition VALUES (2213, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 443);
INSERT INTO public.condition VALUES (2214, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 443);
INSERT INTO public.condition VALUES (2215, NULL, 'OTHER', 443);
INSERT INTO public.condition VALUES (2216, 'Connection is in place and functioning as intended.', 'GOOD', 444);
INSERT INTO public.condition VALUES (2217, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 444);
INSERT INTO public.condition VALUES (2218, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 444);
INSERT INTO public.condition VALUES (2219, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 444);
INSERT INTO public.condition VALUES (2220, NULL, 'OTHER', 444);
INSERT INTO public.condition VALUES (2221, 'None', 'GOOD', 445);
INSERT INTO public.condition VALUES (2222, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 445);
INSERT INTO public.condition VALUES (2223, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 445);
INSERT INTO public.condition VALUES (2224, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 445);
INSERT INTO public.condition VALUES (2225, NULL, 'OTHER', 445);
INSERT INTO public.condition VALUES (2226, 'Not applicable', 'GOOD', 446);
INSERT INTO public.condition VALUES (2227, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 446);
INSERT INTO public.condition VALUES (2228, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 446);
INSERT INTO public.condition VALUES (2229, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 446);
INSERT INTO public.condition VALUES (2230, NULL, 'OTHER', 446);
INSERT INTO public.condition VALUES (2231, 'None', 'GOOD', 447);
INSERT INTO public.condition VALUES (2232, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 447);
INSERT INTO public.condition VALUES (2233, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 447);
INSERT INTO public.condition VALUES (2234, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 447);
INSERT INTO public.condition VALUES (2235, NULL, 'OTHER', 447);
INSERT INTO public.condition VALUES (2236, 'None', 'GOOD', 448);
INSERT INTO public.condition VALUES (2237, 'Present without measurable section loss.', 'FAIR', 448);
INSERT INTO public.condition VALUES (2238, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 448);
INSERT INTO public.condition VALUES (2239, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 448);
INSERT INTO public.condition VALUES (2240, NULL, 'OTHER', 448);
INSERT INTO public.condition VALUES (2241, 'None', 'GOOD', 449);
INSERT INTO public.condition VALUES (2242, 'Present without section loss.', 'FAIR', 449);
INSERT INTO public.condition VALUES (2243, 'Present with section loss, but does not warrant structural review.', 'POOR', 449);
INSERT INTO public.condition VALUES (2244, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 449);
INSERT INTO public.condition VALUES (2245, NULL, 'OTHER', 449);
INSERT INTO public.condition VALUES (2246, 'None or insignificant cracks.', 'GOOD', 450);
INSERT INTO public.condition VALUES (2247, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.', 'FAIR', 450);
INSERT INTO public.condition VALUES (2248, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.', 'POOR', 450);
INSERT INTO public.condition VALUES (2249, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 450);
INSERT INTO public.condition VALUES (2250, NULL, 'OTHER', 450);
INSERT INTO public.condition VALUES (2251, 'None', 'GOOD', 451);
INSERT INTO public.condition VALUES (2252, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 451);
INSERT INTO public.condition VALUES (2253, 'Heavy build-up with rust staining.', 'POOR', 451);
INSERT INTO public.condition VALUES (2254, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 451);
INSERT INTO public.condition VALUES (2255, NULL, 'OTHER', 451);
INSERT INTO public.condition VALUES (2256, 'Not applicable', 'GOOD', 452);
INSERT INTO public.condition VALUES (2257, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 452);
INSERT INTO public.condition VALUES (2258, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 452);
INSERT INTO public.condition VALUES (2259, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 452);
INSERT INTO public.condition VALUES (2260, NULL, 'OTHER', 452);
INSERT INTO public.condition VALUES (2261, 'None', 'GOOD', 453);
INSERT INTO public.condition VALUES (2262, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 453);
INSERT INTO public.condition VALUES (2263, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 453);
INSERT INTO public.condition VALUES (2264, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 453);
INSERT INTO public.condition VALUES (2265, NULL, 'OTHER', 453);
INSERT INTO public.condition VALUES (2266, 'None', 'GOOD', 454);
INSERT INTO public.condition VALUES (2267, 'Present without measurable section loss.', 'FAIR', 454);
INSERT INTO public.condition VALUES (2268, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 454);
INSERT INTO public.condition VALUES (2269, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 454);
INSERT INTO public.condition VALUES (2270, NULL, 'OTHER', 454);
INSERT INTO public.condition VALUES (2271, 'None', 'GOOD', 455);
INSERT INTO public.condition VALUES (2272, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 455);
INSERT INTO public.condition VALUES (2273, 'Heavy build-up with rust staining.', 'POOR', 455);
INSERT INTO public.condition VALUES (2274, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 455);
INSERT INTO public.condition VALUES (2275, NULL, 'OTHER', 455);
INSERT INTO public.condition VALUES (2276, 'None or insignificant cracks.', 'GOOD', 456);
INSERT INTO public.condition VALUES (2277, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 456);
INSERT INTO public.condition VALUES (2278, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 456);
INSERT INTO public.condition VALUES (2279, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 456);
INSERT INTO public.condition VALUES (2280, NULL, 'OTHER', 456);
INSERT INTO public.condition VALUES (2281, 'Not applicable', 'GOOD', 457);
INSERT INTO public.condition VALUES (2282, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 457);
INSERT INTO public.condition VALUES (2283, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 457);
INSERT INTO public.condition VALUES (2284, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 457);
INSERT INTO public.condition VALUES (2285, NULL, 'OTHER', 457);
INSERT INTO public.condition VALUES (2286, 'Connection is in place and functioning as intended.', 'GOOD', 458);
INSERT INTO public.condition VALUES (2287, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 458);
INSERT INTO public.condition VALUES (2288, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 458);
INSERT INTO public.condition VALUES (2289, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 458);
INSERT INTO public.condition VALUES (2290, NULL, 'OTHER', 458);
INSERT INTO public.condition VALUES (2291, 'None', 'GOOD', 459);
INSERT INTO public.condition VALUES (2292, 'Affects less than 10% of the member section.', 'FAIR', 459);
INSERT INTO public.condition VALUES (2293, 'Affects 10% or more of the member but does not warrant structural review.', 'POOR', 459);
INSERT INTO public.condition VALUES (2294, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 459);
INSERT INTO public.condition VALUES (2295, NULL, 'OTHER', 459);
INSERT INTO public.condition VALUES (2296, 'Surface penetration less than 5% of the member thickness regardless of location.', 'GOOD', 460);
INSERT INTO public.condition VALUES (2297, 'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.', 'FAIR', 460);
INSERT INTO public.condition VALUES (2298, 'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.', 'POOR', 460);
INSERT INTO public.condition VALUES (2299, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 460);
INSERT INTO public.condition VALUES (2300, NULL, 'OTHER', 460);
INSERT INTO public.condition VALUES (2301, 'None', 'GOOD', 461);
INSERT INTO public.condition VALUES (2302, 'Crack that has been arrested through effective measures.', 'FAIR', 461);
INSERT INTO public.condition VALUES (2303, 'Identified crack exists that is not arrested, but does not require structural review', 'POOR', 461);
INSERT INTO public.condition VALUES (2304, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 461);
INSERT INTO public.condition VALUES (2305, NULL, 'OTHER', 461);
INSERT INTO public.condition VALUES (2306, 'None', 'GOOD', 462);
INSERT INTO public.condition VALUES (2307, 'Length less than the member depth or arrested with effective actions taken to mitigate.', 'FAIR', 462);
INSERT INTO public.condition VALUES (2308, 'Length equal to or greater than the member depth, but does not require structural review.', 'POOR', 462);
INSERT INTO public.condition VALUES (2309, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 462);
INSERT INTO public.condition VALUES (2310, NULL, 'OTHER', 462);
INSERT INTO public.condition VALUES (2311, 'None or no measurable section loss.', 'GOOD', 463);
INSERT INTO public.condition VALUES (2312, 'Section loss less than 10% of the member thickness.', 'FAIR', 463);
INSERT INTO public.condition VALUES (2313, 'Section loss 10% or more of the member thickness, but does not warrant structural review.', 'POOR', 463);
INSERT INTO public.condition VALUES (2314, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 463);
INSERT INTO public.condition VALUES (2315, NULL, 'OTHER', 463);
INSERT INTO public.condition VALUES (2316, 'Not applicable', 'GOOD', 464);
INSERT INTO public.condition VALUES (2317, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 464);
INSERT INTO public.condition VALUES (2318, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 464);
INSERT INTO public.condition VALUES (2319, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 464);
INSERT INTO public.condition VALUES (2320, NULL, 'OTHER', 464);
INSERT INTO public.condition VALUES (2321, 'None', 'GOOD', 465);
INSERT INTO public.condition VALUES (2322, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 465);
INSERT INTO public.condition VALUES (2323, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 465);
INSERT INTO public.condition VALUES (2324, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 465);
INSERT INTO public.condition VALUES (2325, NULL, 'OTHER', 465);
INSERT INTO public.condition VALUES (2326, 'None', 'GOOD', 466);
INSERT INTO public.condition VALUES (2327, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 466);
INSERT INTO public.condition VALUES (2328, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 466);
INSERT INTO public.condition VALUES (2329, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 466);
INSERT INTO public.condition VALUES (2330, NULL, 'OTHER', 466);
INSERT INTO public.condition VALUES (2331, 'Connection is in place and functioning as intended.', 'GOOD', 467);
INSERT INTO public.condition VALUES (2332, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 467);
INSERT INTO public.condition VALUES (2333, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 467);
INSERT INTO public.condition VALUES (2334, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 467);
INSERT INTO public.condition VALUES (2335, NULL, 'OTHER', 467);
INSERT INTO public.condition VALUES (2336, 'None or insignificant cracks.', 'GOOD', 468);
INSERT INTO public.condition VALUES (2337, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 468);
INSERT INTO public.condition VALUES (2338, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 468);
INSERT INTO public.condition VALUES (2339, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 468);
INSERT INTO public.condition VALUES (2340, NULL, 'OTHER', 468);
INSERT INTO public.condition VALUES (2341, 'None', 'GOOD', 469);
INSERT INTO public.condition VALUES (2342, 'Initiated breakdown or deterioration.', 'FAIR', 469);
INSERT INTO public.condition VALUES (2343, 'Significant deterioration or breakdown, but does not warrant structural review.', 'POOR', 469);
INSERT INTO public.condition VALUES (2344, '', 'SEVERE', 469);
INSERT INTO public.condition VALUES (2345, NULL, 'OTHER', 469);
INSERT INTO public.condition VALUES (2346, 'None', 'GOOD', 470);
INSERT INTO public.condition VALUES (2347, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 470);
INSERT INTO public.condition VALUES (2348, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 470);
INSERT INTO public.condition VALUES (2349, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 470);
INSERT INTO public.condition VALUES (2350, NULL, 'OTHER', 470);
INSERT INTO public.condition VALUES (2351, 'None', 'GOOD', 471);
INSERT INTO public.condition VALUES (2352, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 471);
INSERT INTO public.condition VALUES (2353, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 471);
INSERT INTO public.condition VALUES (2354, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 471);
INSERT INTO public.condition VALUES (2355, NULL, 'OTHER', 471);
INSERT INTO public.condition VALUES (2356, 'None', 'GOOD', 472);
INSERT INTO public.condition VALUES (2357, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 472);
INSERT INTO public.condition VALUES (2358, 'Heavy build-up with rust staining.', 'POOR', 472);
INSERT INTO public.condition VALUES (2359, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 472);
INSERT INTO public.condition VALUES (2360, NULL, 'OTHER', 472);
INSERT INTO public.condition VALUES (2361, 'Not applicable', 'GOOD', 473);
INSERT INTO public.condition VALUES (2362, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 473);
INSERT INTO public.condition VALUES (2363, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 473);
INSERT INTO public.condition VALUES (2364, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 473);
INSERT INTO public.condition VALUES (2365, NULL, 'OTHER', 473);
INSERT INTO public.condition VALUES (2366, 'None', 'GOOD', 474);
INSERT INTO public.condition VALUES (2367, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 474);
INSERT INTO public.condition VALUES (2368, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 474);
INSERT INTO public.condition VALUES (2369, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 474);
INSERT INTO public.condition VALUES (2370, NULL, 'OTHER', 474);
INSERT INTO public.condition VALUES (2371, 'None', 'GOOD', 475);
INSERT INTO public.condition VALUES (2372, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 475);
INSERT INTO public.condition VALUES (2373, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 475);
INSERT INTO public.condition VALUES (2374, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 475);
INSERT INTO public.condition VALUES (2375, NULL, 'OTHER', 475);
INSERT INTO public.condition VALUES (2376, 'Connection is in place and functioning as intended.', 'GOOD', 476);
INSERT INTO public.condition VALUES (2377, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 476);
INSERT INTO public.condition VALUES (2378, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 476);
INSERT INTO public.condition VALUES (2379, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 476);
INSERT INTO public.condition VALUES (2380, NULL, 'OTHER', 476);
INSERT INTO public.condition VALUES (2381, 'None', 'GOOD', 477);
INSERT INTO public.condition VALUES (2382, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 477);
INSERT INTO public.condition VALUES (2383, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 477);
INSERT INTO public.condition VALUES (2384, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 477);
INSERT INTO public.condition VALUES (2385, NULL, 'OTHER', 477);
INSERT INTO public.condition VALUES (2386, 'None', 'GOOD', 478);
INSERT INTO public.condition VALUES (2387, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 478);
INSERT INTO public.condition VALUES (2388, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 478);
INSERT INTO public.condition VALUES (2389, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 478);
INSERT INTO public.condition VALUES (2390, NULL, 'OTHER', 478);
INSERT INTO public.condition VALUES (2391, 'None', 'GOOD', 479);
INSERT INTO public.condition VALUES (2392, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 479);
INSERT INTO public.condition VALUES (2393, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 479);
INSERT INTO public.condition VALUES (2394, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 479);
INSERT INTO public.condition VALUES (2395, NULL, 'OTHER', 479);
INSERT INTO public.condition VALUES (2396, 'Not applicable', 'GOOD', 480);
INSERT INTO public.condition VALUES (2397, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 480);
INSERT INTO public.condition VALUES (2398, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 480);
INSERT INTO public.condition VALUES (2399, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 480);
INSERT INTO public.condition VALUES (2403, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 481);
INSERT INTO public.condition VALUES (2404, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 481);
INSERT INTO public.condition VALUES (2405, NULL, 'OTHER', 481);
INSERT INTO public.condition VALUES (2406, 'None', 'GOOD', 482);
INSERT INTO public.condition VALUES (2407, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 482);
INSERT INTO public.condition VALUES (2408, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 482);
INSERT INTO public.condition VALUES (2409, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 482);
INSERT INTO public.condition VALUES (2410, NULL, 'OTHER', 482);
INSERT INTO public.condition VALUES (2411, 'Connection is in place and functioning as intended.', 'GOOD', 483);
INSERT INTO public.condition VALUES (2412, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 483);
INSERT INTO public.condition VALUES (2413, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 483);
INSERT INTO public.condition VALUES (2414, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 483);
INSERT INTO public.condition VALUES (2415, NULL, 'OTHER', 483);
INSERT INTO public.condition VALUES (2416, 'None or insignificant cracks.', 'GOOD', 484);
INSERT INTO public.condition VALUES (2417, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 484);
INSERT INTO public.condition VALUES (2418, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 484);
INSERT INTO public.condition VALUES (2419, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 484);
INSERT INTO public.condition VALUES (2420, NULL, 'OTHER', 484);
INSERT INTO public.condition VALUES (2421, 'None', 'GOOD', 485);
INSERT INTO public.condition VALUES (2422, 'Initiated breakdown or deterioration.', 'FAIR', 485);
INSERT INTO public.condition VALUES (2423, 'Significant deterioration or breakdown, but does not warrant structural review.', 'POOR', 485);
INSERT INTO public.condition VALUES (2424, '', 'SEVERE', 485);
INSERT INTO public.condition VALUES (2425, NULL, 'OTHER', 485);
INSERT INTO public.condition VALUES (2426, 'None', 'GOOD', 486);
INSERT INTO public.condition VALUES (2427, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 486);
INSERT INTO public.condition VALUES (2428, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 486);
INSERT INTO public.condition VALUES (2429, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 486);
INSERT INTO public.condition VALUES (2430, NULL, 'OTHER', 486);
INSERT INTO public.condition VALUES (2431, 'None', 'GOOD', 487);
INSERT INTO public.condition VALUES (2432, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 487);
INSERT INTO public.condition VALUES (2433, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 487);
INSERT INTO public.condition VALUES (2434, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 487);
INSERT INTO public.condition VALUES (2435, NULL, 'OTHER', 487);
INSERT INTO public.condition VALUES (2436, 'None', 'GOOD', 488);
INSERT INTO public.condition VALUES (2437, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 488);
INSERT INTO public.condition VALUES (2438, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 488);
INSERT INTO public.condition VALUES (2439, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 488);
INSERT INTO public.condition VALUES (2440, NULL, 'OTHER', 488);
INSERT INTO public.condition VALUES (2441, 'None', 'GOOD', 489);
INSERT INTO public.condition VALUES (2442, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 489);
INSERT INTO public.condition VALUES (2443, 'Heavy build-up with rust staining.', 'POOR', 489);
INSERT INTO public.condition VALUES (2444, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 489);
INSERT INTO public.condition VALUES (2445, NULL, 'OTHER', 489);
INSERT INTO public.condition VALUES (2446, 'None', 'GOOD', 490);
INSERT INTO public.condition VALUES (2447, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 490);
INSERT INTO public.condition VALUES (2448, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 490);
INSERT INTO public.condition VALUES (2449, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 490);
INSERT INTO public.condition VALUES (2450, NULL, 'OTHER', 490);
INSERT INTO public.condition VALUES (2451, 'Not applicable', 'GOOD', 491);
INSERT INTO public.condition VALUES (2452, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 491);
INSERT INTO public.condition VALUES (2453, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 491);
INSERT INTO public.condition VALUES (2454, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 491);
INSERT INTO public.condition VALUES (2455, NULL, 'OTHER', 491);
INSERT INTO public.condition VALUES (2456, 'None', 'GOOD', 492);
INSERT INTO public.condition VALUES (2457, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 492);
INSERT INTO public.condition VALUES (2458, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 492);
INSERT INTO public.condition VALUES (2459, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 492);
INSERT INTO public.condition VALUES (2460, NULL, 'OTHER', 492);
INSERT INTO public.condition VALUES (2461, 'None', 'GOOD', 493);
INSERT INTO public.condition VALUES (2462, 'Present without measurable section loss.', 'FAIR', 493);
INSERT INTO public.condition VALUES (2463, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 493);
INSERT INTO public.condition VALUES (2525, NULL, 'OTHER', 505);
INSERT INTO public.condition VALUES (2526, 'None', 'GOOD', 506);
INSERT INTO public.condition VALUES (2527, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 506);
INSERT INTO public.condition VALUES (2464, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 493);
INSERT INTO public.condition VALUES (2465, NULL, 'OTHER', 493);
INSERT INTO public.condition VALUES (2466, 'None', 'GOOD', 494);
INSERT INTO public.condition VALUES (2467, 'Present without section loss.', 'FAIR', 494);
INSERT INTO public.condition VALUES (2468, 'Present with section loss, but does not warrant structural review.', 'POOR', 494);
INSERT INTO public.condition VALUES (2469, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 494);
INSERT INTO public.condition VALUES (2470, NULL, 'OTHER', 494);
INSERT INTO public.condition VALUES (2471, 'None or insignificant cracks.', 'GOOD', 495);
INSERT INTO public.condition VALUES (2472, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.', 'FAIR', 495);
INSERT INTO public.condition VALUES (2473, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.', 'POOR', 495);
INSERT INTO public.condition VALUES (2474, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 495);
INSERT INTO public.condition VALUES (2475, NULL, 'OTHER', 495);
INSERT INTO public.condition VALUES (2476, 'None', 'GOOD', 496);
INSERT INTO public.condition VALUES (2477, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 496);
INSERT INTO public.condition VALUES (2478, 'Heavy build-up with rust staining.', 'POOR', 496);
INSERT INTO public.condition VALUES (2479, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 496);
INSERT INTO public.condition VALUES (2480, NULL, 'OTHER', 496);
INSERT INTO public.condition VALUES (2481, 'No abrasion or wearing.', 'GOOD', 497);
INSERT INTO public.condition VALUES (2482, 'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.', 'FAIR', 497);
INSERT INTO public.condition VALUES (2483, 'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.', 'POOR', 497);
INSERT INTO public.condition VALUES (2484, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 497);
INSERT INTO public.condition VALUES (2485, NULL, 'OTHER', 497);
INSERT INTO public.condition VALUES (2486, 'None', 'GOOD', 498);
INSERT INTO public.condition VALUES (2487, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 498);
INSERT INTO public.condition VALUES (2488, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 498);
INSERT INTO public.condition VALUES (2489, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 498);
INSERT INTO public.condition VALUES (2490, NULL, 'OTHER', 498);
INSERT INTO public.condition VALUES (2491, 'None', 'GOOD', 499);
INSERT INTO public.condition VALUES (2492, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 499);
INSERT INTO public.condition VALUES (2493, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 499);
INSERT INTO public.condition VALUES (2494, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 499);
INSERT INTO public.condition VALUES (2495, NULL, 'OTHER', 499);
INSERT INTO public.condition VALUES (2496, 'Not applicable', 'GOOD', 500);
INSERT INTO public.condition VALUES (2497, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 500);
INSERT INTO public.condition VALUES (2498, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 500);
INSERT INTO public.condition VALUES (2499, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 500);
INSERT INTO public.condition VALUES (2500, NULL, 'OTHER', 500);
INSERT INTO public.condition VALUES (2501, 'None', 'GOOD', 501);
INSERT INTO public.condition VALUES (2502, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 501);
INSERT INTO public.condition VALUES (2503, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 501);
INSERT INTO public.condition VALUES (2504, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 501);
INSERT INTO public.condition VALUES (2505, NULL, 'OTHER', 501);
INSERT INTO public.condition VALUES (2506, 'None', 'GOOD', 502);
INSERT INTO public.condition VALUES (2507, 'Present without measurable section loss.', 'FAIR', 502);
INSERT INTO public.condition VALUES (2508, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 502);
INSERT INTO public.condition VALUES (2509, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 502);
INSERT INTO public.condition VALUES (2510, NULL, 'OTHER', 502);
INSERT INTO public.condition VALUES (2511, 'None', 'GOOD', 503);
INSERT INTO public.condition VALUES (2512, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 503);
INSERT INTO public.condition VALUES (2513, 'Heavy build-up with rust staining.', 'POOR', 503);
INSERT INTO public.condition VALUES (2514, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 503);
INSERT INTO public.condition VALUES (2515, NULL, 'OTHER', 503);
INSERT INTO public.condition VALUES (2516, 'None or insignificant cracks.', 'GOOD', 504);
INSERT INTO public.condition VALUES (2517, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 504);
INSERT INTO public.condition VALUES (2518, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 504);
INSERT INTO public.condition VALUES (2519, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 504);
INSERT INTO public.condition VALUES (2520, NULL, 'OTHER', 504);
INSERT INTO public.condition VALUES (2521, 'No abrasion or wearing.', 'GOOD', 505);
INSERT INTO public.condition VALUES (2522, 'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.', 'FAIR', 505);
INSERT INTO public.condition VALUES (2523, 'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.', 'POOR', 505);
INSERT INTO public.condition VALUES (2524, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 505);
INSERT INTO public.condition VALUES (2528, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 506);
INSERT INTO public.condition VALUES (2529, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 506);
INSERT INTO public.condition VALUES (2530, NULL, 'OTHER', 506);
INSERT INTO public.condition VALUES (2531, 'None', 'GOOD', 507);
INSERT INTO public.condition VALUES (2532, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 507);
INSERT INTO public.condition VALUES (2533, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 507);
INSERT INTO public.condition VALUES (2534, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 507);
INSERT INTO public.condition VALUES (2535, NULL, 'OTHER', 507);
INSERT INTO public.condition VALUES (2536, 'Not applicable', 'GOOD', 508);
INSERT INTO public.condition VALUES (2537, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 508);
INSERT INTO public.condition VALUES (2538, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 508);
INSERT INTO public.condition VALUES (2539, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 508);
INSERT INTO public.condition VALUES (2540, NULL, 'OTHER', 508);
INSERT INTO public.condition VALUES (2541, 'Connection is in place and functioning as intended.', 'GOOD', 509);
INSERT INTO public.condition VALUES (2542, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 509);
INSERT INTO public.condition VALUES (2543, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 509);
INSERT INTO public.condition VALUES (2544, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 509);
INSERT INTO public.condition VALUES (2545, NULL, 'OTHER', 509);
INSERT INTO public.condition VALUES (2546, 'None', 'GOOD', 510);
INSERT INTO public.condition VALUES (2547, 'Affects less than 10% of the member section.', 'FAIR', 510);
INSERT INTO public.condition VALUES (2548, 'Affects 10% or more of the member but does not warrant structural review.', 'POOR', 510);
INSERT INTO public.condition VALUES (2549, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 510);
INSERT INTO public.condition VALUES (2550, NULL, 'OTHER', 510);
INSERT INTO public.condition VALUES (2551, 'Surface penetration less than 5% of the member thickness regardless of location.', 'GOOD', 511);
INSERT INTO public.condition VALUES (2552, 'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.', 'FAIR', 511);
INSERT INTO public.condition VALUES (2553, 'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.', 'POOR', 511);
INSERT INTO public.condition VALUES (2554, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 511);
INSERT INTO public.condition VALUES (2555, NULL, 'OTHER', 511);
INSERT INTO public.condition VALUES (2556, 'None', 'GOOD', 512);
INSERT INTO public.condition VALUES (2557, 'Crack that has been arrested through effective measures.', 'FAIR', 512);
INSERT INTO public.condition VALUES (2558, 'Identified crack exists that is not arrested, but does not require structural review', 'POOR', 512);
INSERT INTO public.condition VALUES (2559, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 512);
INSERT INTO public.condition VALUES (2560, NULL, 'OTHER', 512);
INSERT INTO public.condition VALUES (2561, 'None', 'GOOD', 513);
INSERT INTO public.condition VALUES (2562, 'Length less than the member depth or arrested with effective actions taken to mitigate.', 'FAIR', 513);
INSERT INTO public.condition VALUES (2563, 'Length equal to or greater than the member depth, but does not require structural review.', 'POOR', 513);
INSERT INTO public.condition VALUES (2564, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 513);
INSERT INTO public.condition VALUES (2565, NULL, 'OTHER', 513);
INSERT INTO public.condition VALUES (2566, 'None or no measurable section loss.', 'GOOD', 514);
INSERT INTO public.condition VALUES (2567, 'Section loss less than 10% of the member thickness.', 'FAIR', 514);
INSERT INTO public.condition VALUES (2568, 'Section loss 10% or more of the member thickness, but does not warrant structural review.', 'POOR', 514);
INSERT INTO public.condition VALUES (2569, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 514);
INSERT INTO public.condition VALUES (2570, NULL, 'OTHER', 514);
INSERT INTO public.condition VALUES (2571, 'None', 'GOOD', 515);
INSERT INTO public.condition VALUES (2572, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 515);
INSERT INTO public.condition VALUES (2573, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 515);
INSERT INTO public.condition VALUES (2574, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 515);
INSERT INTO public.condition VALUES (2575, NULL, 'OTHER', 515);
INSERT INTO public.condition VALUES (2576, 'None', 'GOOD', 516);
INSERT INTO public.condition VALUES (2577, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 516);
INSERT INTO public.condition VALUES (2578, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 516);
INSERT INTO public.condition VALUES (2579, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 516);
INSERT INTO public.condition VALUES (2580, NULL, 'OTHER', 516);
INSERT INTO public.condition VALUES (2581, 'Not applicable', 'GOOD', 517);
INSERT INTO public.condition VALUES (2582, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 517);
INSERT INTO public.condition VALUES (2583, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 517);
INSERT INTO public.condition VALUES (2584, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 517);
INSERT INTO public.condition VALUES (2585, NULL, 'OTHER', 517);
INSERT INTO public.condition VALUES (2586, 'None', 'GOOD', 518);
INSERT INTO public.condition VALUES (2587, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 518);
INSERT INTO public.condition VALUES (2588, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 518);
INSERT INTO public.condition VALUES (2589, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 518);
INSERT INTO public.condition VALUES (2590, NULL, 'OTHER', 518);
INSERT INTO public.condition VALUES (2591, 'None', 'GOOD', 519);
INSERT INTO public.condition VALUES (2592, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 519);
INSERT INTO public.condition VALUES (2593, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 519);
INSERT INTO public.condition VALUES (2594, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 519);
INSERT INTO public.condition VALUES (2595, NULL, 'OTHER', 519);
INSERT INTO public.condition VALUES (2596, 'Connection is in place and functioning as intended.', 'GOOD', 520);
INSERT INTO public.condition VALUES (2597, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 520);
INSERT INTO public.condition VALUES (2598, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 520);
INSERT INTO public.condition VALUES (2599, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 520);
INSERT INTO public.condition VALUES (2600, NULL, 'OTHER', 520);
INSERT INTO public.condition VALUES (2601, 'None', 'GOOD', 521);
INSERT INTO public.condition VALUES (2602, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 521);
INSERT INTO public.condition VALUES (2603, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 521);
INSERT INTO public.condition VALUES (2604, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 521);
INSERT INTO public.condition VALUES (2605, NULL, 'OTHER', 521);
INSERT INTO public.condition VALUES (2606, 'None', 'GOOD', 522);
INSERT INTO public.condition VALUES (2607, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 522);
INSERT INTO public.condition VALUES (2608, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 522);
INSERT INTO public.condition VALUES (2609, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 522);
INSERT INTO public.condition VALUES (2610, NULL, 'OTHER', 522);
INSERT INTO public.condition VALUES (2611, 'None', 'GOOD', 523);
INSERT INTO public.condition VALUES (2612, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 523);
INSERT INTO public.condition VALUES (2613, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 523);
INSERT INTO public.condition VALUES (2614, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 523);
INSERT INTO public.condition VALUES (2615, NULL, 'OTHER', 523);
INSERT INTO public.condition VALUES (2616, 'Not applicable', 'GOOD', 524);
INSERT INTO public.condition VALUES (2617, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 524);
INSERT INTO public.condition VALUES (2618, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 524);
INSERT INTO public.condition VALUES (2619, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 524);
INSERT INTO public.condition VALUES (2620, NULL, 'OTHER', 524);
INSERT INTO public.condition VALUES (2621, 'Connection is in place and functioning as intended.', 'GOOD', 525);
INSERT INTO public.condition VALUES (2622, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 525);
INSERT INTO public.condition VALUES (2623, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 525);
INSERT INTO public.condition VALUES (2624, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 525);
INSERT INTO public.condition VALUES (2625, NULL, 'OTHER', 525);
INSERT INTO public.condition VALUES (2626, 'None', 'GOOD', 526);
INSERT INTO public.condition VALUES (2627, 'Affects less than 10% of the member section.', 'FAIR', 526);
INSERT INTO public.condition VALUES (2628, 'Affects 10% or more of the member but does not warrant structural review.', 'POOR', 526);
INSERT INTO public.condition VALUES (2629, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 526);
INSERT INTO public.condition VALUES (2630, NULL, 'OTHER', 526);
INSERT INTO public.condition VALUES (2631, 'Surface penetration less than 5% of the member thickness regardless of location.', 'GOOD', 527);
INSERT INTO public.condition VALUES (2632, 'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.', 'FAIR', 527);
INSERT INTO public.condition VALUES (2633, 'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.', 'POOR', 527);
INSERT INTO public.condition VALUES (2634, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 527);
INSERT INTO public.condition VALUES (2635, NULL, 'OTHER', 527);
INSERT INTO public.condition VALUES (2636, 'None', 'GOOD', 528);
INSERT INTO public.condition VALUES (2637, 'Crack that has been arrested through effective measures.', 'FAIR', 528);
INSERT INTO public.condition VALUES (2638, 'Identified crack exists that is not arrested, but does not require structural review', 'POOR', 528);
INSERT INTO public.condition VALUES (2639, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 528);
INSERT INTO public.condition VALUES (2640, NULL, 'OTHER', 528);
INSERT INTO public.condition VALUES (2641, 'None', 'GOOD', 529);
INSERT INTO public.condition VALUES (2642, 'Length less than the member depth or arrested with effective actions taken to mitigate.', 'FAIR', 529);
INSERT INTO public.condition VALUES (2643, 'Length equal to or greater than the member depth, but does not require structural review.', 'POOR', 529);
INSERT INTO public.condition VALUES (2644, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 529);
INSERT INTO public.condition VALUES (2645, NULL, 'OTHER', 529);
INSERT INTO public.condition VALUES (2646, 'None or no measurable section loss.', 'GOOD', 530);
INSERT INTO public.condition VALUES (3261, 'None', 'GOOD', 653);
INSERT INTO public.condition VALUES (2647, 'Section loss less than 10% of the member thickness.', 'FAIR', 530);
INSERT INTO public.condition VALUES (2648, 'Section loss 10% or more of the member thickness, but does not warrant structural review.', 'POOR', 530);
INSERT INTO public.condition VALUES (2649, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 530);
INSERT INTO public.condition VALUES (2650, NULL, 'OTHER', 530);
INSERT INTO public.condition VALUES (2651, 'None', 'GOOD', 531);
INSERT INTO public.condition VALUES (2652, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 531);
INSERT INTO public.condition VALUES (2653, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 531);
INSERT INTO public.condition VALUES (2654, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 531);
INSERT INTO public.condition VALUES (2655, NULL, 'OTHER', 531);
INSERT INTO public.condition VALUES (2656, 'None', 'GOOD', 532);
INSERT INTO public.condition VALUES (2657, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 532);
INSERT INTO public.condition VALUES (2658, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 532);
INSERT INTO public.condition VALUES (2659, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 532);
INSERT INTO public.condition VALUES (2660, NULL, 'OTHER', 532);
INSERT INTO public.condition VALUES (2661, 'Not applicable', 'GOOD', 533);
INSERT INTO public.condition VALUES (2662, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 533);
INSERT INTO public.condition VALUES (2663, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 533);
INSERT INTO public.condition VALUES (2664, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 533);
INSERT INTO public.condition VALUES (2665, NULL, 'OTHER', 533);
INSERT INTO public.condition VALUES (2666, 'None', 'GOOD', 534);
INSERT INTO public.condition VALUES (2667, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 534);
INSERT INTO public.condition VALUES (2668, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 534);
INSERT INTO public.condition VALUES (2669, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 534);
INSERT INTO public.condition VALUES (2670, NULL, 'OTHER', 534);
INSERT INTO public.condition VALUES (2671, 'None', 'GOOD', 535);
INSERT INTO public.condition VALUES (2672, 'Present without measurable section loss.', 'FAIR', 535);
INSERT INTO public.condition VALUES (2673, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 535);
INSERT INTO public.condition VALUES (2674, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 535);
INSERT INTO public.condition VALUES (2675, NULL, 'OTHER', 535);
INSERT INTO public.condition VALUES (2676, 'None', 'GOOD', 536);
INSERT INTO public.condition VALUES (2677, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 536);
INSERT INTO public.condition VALUES (2678, 'Heavy build-up with rust staining.', 'POOR', 536);
INSERT INTO public.condition VALUES (2679, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 536);
INSERT INTO public.condition VALUES (2680, NULL, 'OTHER', 536);
INSERT INTO public.condition VALUES (2681, 'None or insignificant cracks.', 'GOOD', 537);
INSERT INTO public.condition VALUES (2682, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 537);
INSERT INTO public.condition VALUES (2683, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 537);
INSERT INTO public.condition VALUES (2684, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 537);
INSERT INTO public.condition VALUES (2685, NULL, 'OTHER', 537);
INSERT INTO public.condition VALUES (2686, 'No abrasion or wearing.', 'GOOD', 538);
INSERT INTO public.condition VALUES (2687, 'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.', 'FAIR', 538);
INSERT INTO public.condition VALUES (2688, 'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.', 'POOR', 538);
INSERT INTO public.condition VALUES (2689, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 538);
INSERT INTO public.condition VALUES (2690, NULL, 'OTHER', 538);
INSERT INTO public.condition VALUES (2691, 'None', 'GOOD', 539);
INSERT INTO public.condition VALUES (2692, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 539);
INSERT INTO public.condition VALUES (2693, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 539);
INSERT INTO public.condition VALUES (2694, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 539);
INSERT INTO public.condition VALUES (2695, NULL, 'OTHER', 539);
INSERT INTO public.condition VALUES (2696, 'None', 'GOOD', 540);
INSERT INTO public.condition VALUES (2697, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 540);
INSERT INTO public.condition VALUES (2698, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 540);
INSERT INTO public.condition VALUES (2699, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 540);
INSERT INTO public.condition VALUES (2700, NULL, 'OTHER', 540);
INSERT INTO public.condition VALUES (2701, 'Not applicable', 'GOOD', 541);
INSERT INTO public.condition VALUES (2702, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 541);
INSERT INTO public.condition VALUES (2703, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 541);
INSERT INTO public.condition VALUES (2704, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 541);
INSERT INTO public.condition VALUES (2705, NULL, 'OTHER', 541);
INSERT INTO public.condition VALUES (2706, 'None', 'GOOD', 542);
INSERT INTO public.condition VALUES (2707, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 542);
INSERT INTO public.condition VALUES (3447, 'Cracking or voids in less than 10% of joints.', 'FAIR', 690);
INSERT INTO public.condition VALUES (2708, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 542);
INSERT INTO public.condition VALUES (2709, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 542);
INSERT INTO public.condition VALUES (2710, NULL, 'OTHER', 542);
INSERT INTO public.condition VALUES (2711, 'None', 'GOOD', 543);
INSERT INTO public.condition VALUES (2712, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 543);
INSERT INTO public.condition VALUES (2713, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 543);
INSERT INTO public.condition VALUES (2714, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 543);
INSERT INTO public.condition VALUES (2715, NULL, 'OTHER', 543);
INSERT INTO public.condition VALUES (2716, 'Connection is in place and functioning as intended.', 'GOOD', 544);
INSERT INTO public.condition VALUES (2717, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 544);
INSERT INTO public.condition VALUES (2718, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 544);
INSERT INTO public.condition VALUES (2719, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 544);
INSERT INTO public.condition VALUES (2720, NULL, 'OTHER', 544);
INSERT INTO public.condition VALUES (2721, 'None or insignificant cracks.', 'GOOD', 545);
INSERT INTO public.condition VALUES (2722, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 545);
INSERT INTO public.condition VALUES (2723, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 545);
INSERT INTO public.condition VALUES (2724, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 545);
INSERT INTO public.condition VALUES (2725, NULL, 'OTHER', 545);
INSERT INTO public.condition VALUES (2726, 'None', 'GOOD', 546);
INSERT INTO public.condition VALUES (2727, 'Initiated breakdown or deterioration.', 'FAIR', 546);
INSERT INTO public.condition VALUES (2728, 'Significant deterioration or breakdown, but does not warrant structural review.', 'POOR', 546);
INSERT INTO public.condition VALUES (2729, '', 'SEVERE', 546);
INSERT INTO public.condition VALUES (2730, NULL, 'OTHER', 546);
INSERT INTO public.condition VALUES (2731, 'None', 'GOOD', 547);
INSERT INTO public.condition VALUES (2732, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 547);
INSERT INTO public.condition VALUES (2733, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 547);
INSERT INTO public.condition VALUES (2734, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 547);
INSERT INTO public.condition VALUES (2735, NULL, 'OTHER', 547);
INSERT INTO public.condition VALUES (2736, 'None', 'GOOD', 548);
INSERT INTO public.condition VALUES (2737, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 548);
INSERT INTO public.condition VALUES (2738, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 548);
INSERT INTO public.condition VALUES (2739, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 548);
INSERT INTO public.condition VALUES (2740, NULL, 'OTHER', 548);
INSERT INTO public.condition VALUES (2741, 'None', 'GOOD', 549);
INSERT INTO public.condition VALUES (2742, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 549);
INSERT INTO public.condition VALUES (2743, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 549);
INSERT INTO public.condition VALUES (2744, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 549);
INSERT INTO public.condition VALUES (2745, NULL, 'OTHER', 549);
INSERT INTO public.condition VALUES (2746, 'None', 'GOOD', 550);
INSERT INTO public.condition VALUES (2747, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 550);
INSERT INTO public.condition VALUES (2748, 'Heavy build-up with rust staining.', 'POOR', 550);
INSERT INTO public.condition VALUES (2749, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 550);
INSERT INTO public.condition VALUES (2750, NULL, 'OTHER', 550);
INSERT INTO public.condition VALUES (2751, 'None', 'GOOD', 551);
INSERT INTO public.condition VALUES (2752, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 551);
INSERT INTO public.condition VALUES (2753, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 551);
INSERT INTO public.condition VALUES (2754, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 551);
INSERT INTO public.condition VALUES (2755, NULL, 'OTHER', 551);
INSERT INTO public.condition VALUES (2756, 'Not applicable', 'GOOD', 552);
INSERT INTO public.condition VALUES (2757, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 552);
INSERT INTO public.condition VALUES (2758, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 552);
INSERT INTO public.condition VALUES (2759, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 552);
INSERT INTO public.condition VALUES (2760, NULL, 'OTHER', 552);
INSERT INTO public.condition VALUES (2761, 'Connection is in place and functioning as intended.', 'GOOD', 553);
INSERT INTO public.condition VALUES (2762, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 553);
INSERT INTO public.condition VALUES (2763, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 553);
INSERT INTO public.condition VALUES (2764, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 553);
INSERT INTO public.condition VALUES (2765, NULL, 'OTHER', 553);
INSERT INTO public.condition VALUES (2766, 'None', 'GOOD', 554);
INSERT INTO public.condition VALUES (2767, 'Affects less than 10% of the member section.', 'FAIR', 554);
INSERT INTO public.condition VALUES (2768, 'Affects 10% or more of the member but does not warrant structural review.', 'POOR', 554);
INSERT INTO public.condition VALUES (2832, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 567);
INSERT INTO public.condition VALUES (3590, NULL, 'OTHER', 718);
INSERT INTO public.condition VALUES (3591, 'None', 'GOOD', 719);
INSERT INTO public.condition VALUES (2769, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 554);
INSERT INTO public.condition VALUES (2770, NULL, 'OTHER', 554);
INSERT INTO public.condition VALUES (2771, 'Surface penetration less than 5% of the member thickness regardless of location.', 'GOOD', 555);
INSERT INTO public.condition VALUES (2772, 'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.', 'FAIR', 555);
INSERT INTO public.condition VALUES (2773, 'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.', 'POOR', 555);
INSERT INTO public.condition VALUES (2774, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 555);
INSERT INTO public.condition VALUES (2775, NULL, 'OTHER', 555);
INSERT INTO public.condition VALUES (2776, 'None', 'GOOD', 556);
INSERT INTO public.condition VALUES (2777, 'Crack that has been arrested through effective measures.', 'FAIR', 556);
INSERT INTO public.condition VALUES (2778, 'Identified crack exists that is not arrested, but does not require structural review', 'POOR', 556);
INSERT INTO public.condition VALUES (2779, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 556);
INSERT INTO public.condition VALUES (2780, NULL, 'OTHER', 556);
INSERT INTO public.condition VALUES (2781, 'None', 'GOOD', 557);
INSERT INTO public.condition VALUES (2782, 'Length less than the member depth or arrested with effective actions taken to mitigate.', 'FAIR', 557);
INSERT INTO public.condition VALUES (2783, 'Length equal to or greater than the member depth, but does not require structural review.', 'POOR', 557);
INSERT INTO public.condition VALUES (2784, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 557);
INSERT INTO public.condition VALUES (2785, NULL, 'OTHER', 557);
INSERT INTO public.condition VALUES (2786, 'None or no measurable section loss.', 'GOOD', 558);
INSERT INTO public.condition VALUES (2787, 'Section loss less than 10% of the member thickness.', 'FAIR', 558);
INSERT INTO public.condition VALUES (2788, 'Section loss 10% or more of the member thickness, but does not warrant structural review.', 'POOR', 558);
INSERT INTO public.condition VALUES (2789, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 558);
INSERT INTO public.condition VALUES (2790, NULL, 'OTHER', 558);
INSERT INTO public.condition VALUES (2791, 'None', 'GOOD', 559);
INSERT INTO public.condition VALUES (2792, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 559);
INSERT INTO public.condition VALUES (2793, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 559);
INSERT INTO public.condition VALUES (2794, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 559);
INSERT INTO public.condition VALUES (2795, NULL, 'OTHER', 559);
INSERT INTO public.condition VALUES (2796, 'None', 'GOOD', 560);
INSERT INTO public.condition VALUES (2797, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 560);
INSERT INTO public.condition VALUES (2798, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 560);
INSERT INTO public.condition VALUES (2799, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 560);
INSERT INTO public.condition VALUES (2800, NULL, 'OTHER', 560);
INSERT INTO public.condition VALUES (2801, 'Not applicable', 'GOOD', 561);
INSERT INTO public.condition VALUES (2802, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 561);
INSERT INTO public.condition VALUES (2803, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 561);
INSERT INTO public.condition VALUES (2804, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 561);
INSERT INTO public.condition VALUES (2805, NULL, 'OTHER', 561);
INSERT INTO public.condition VALUES (2806, 'None', 'GOOD', 562);
INSERT INTO public.condition VALUES (2807, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 562);
INSERT INTO public.condition VALUES (2808, 'Heavy build-up with rust staining.', 'POOR', 562);
INSERT INTO public.condition VALUES (2809, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 562);
INSERT INTO public.condition VALUES (2810, NULL, 'OTHER', 562);
INSERT INTO public.condition VALUES (2811, 'None', 'GOOD', 563);
INSERT INTO public.condition VALUES (2812, 'Cracking or voids in less than 10% of joints.', 'FAIR', 563);
INSERT INTO public.condition VALUES (2813, 'Cracking or voids in 10% or more of the of joints', 'POOR', 563);
INSERT INTO public.condition VALUES (2814, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 563);
INSERT INTO public.condition VALUES (2815, NULL, 'OTHER', 563);
INSERT INTO public.condition VALUES (2816, 'None', 'GOOD', 564);
INSERT INTO public.condition VALUES (2817, 'Block or stone has split or spalled with no shifting.', 'FAIR', 564);
INSERT INTO public.condition VALUES (2818, 'Block or stone has split or spalled with shifting but does not warrant a structural review.', 'POOR', 564);
INSERT INTO public.condition VALUES (2819, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 564);
INSERT INTO public.condition VALUES (2820, NULL, 'OTHER', 564);
INSERT INTO public.condition VALUES (2821, 'None', 'GOOD', 565);
INSERT INTO public.condition VALUES (2822, 'Sound Patch', 'FAIR', 565);
INSERT INTO public.condition VALUES (2823, 'Unsound Patch', 'POOR', 565);
INSERT INTO public.condition VALUES (2824, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 565);
INSERT INTO public.condition VALUES (2825, NULL, 'OTHER', 565);
INSERT INTO public.condition VALUES (2826, 'None', 'GOOD', 566);
INSERT INTO public.condition VALUES (2827, 'Block or stone has shifted slightly out of alignment.', 'FAIR', 566);
INSERT INTO public.condition VALUES (2828, 'Block or stone has shifted significantly out of alignment or is missing but does not warrant structural review.', 'POOR', 566);
INSERT INTO public.condition VALUES (2829, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 566);
INSERT INTO public.condition VALUES (2830, NULL, 'OTHER', 566);
INSERT INTO public.condition VALUES (2831, 'None', 'GOOD', 567);
INSERT INTO public.condition VALUES (3075, NULL, 'OTHER', 615);
INSERT INTO public.condition VALUES (3076, 'None', 'GOOD', 616);
INSERT INTO public.condition VALUES (2833, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 567);
INSERT INTO public.condition VALUES (2834, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 567);
INSERT INTO public.condition VALUES (2835, NULL, 'OTHER', 567);
INSERT INTO public.condition VALUES (2836, 'None', 'GOOD', 568);
INSERT INTO public.condition VALUES (2837, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 568);
INSERT INTO public.condition VALUES (2838, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 568);
INSERT INTO public.condition VALUES (2839, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 568);
INSERT INTO public.condition VALUES (2840, NULL, 'OTHER', 568);
INSERT INTO public.condition VALUES (2841, 'Not applicable', 'GOOD', 569);
INSERT INTO public.condition VALUES (2842, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 569);
INSERT INTO public.condition VALUES (2843, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 569);
INSERT INTO public.condition VALUES (2844, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 569);
INSERT INTO public.condition VALUES (2845, NULL, 'OTHER', 569);
INSERT INTO public.condition VALUES (2846, 'None', 'GOOD', 570);
INSERT INTO public.condition VALUES (2847, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 570);
INSERT INTO public.condition VALUES (2848, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 570);
INSERT INTO public.condition VALUES (2849, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 570);
INSERT INTO public.condition VALUES (2850, NULL, 'OTHER', 570);
INSERT INTO public.condition VALUES (2851, 'None', 'GOOD', 571);
INSERT INTO public.condition VALUES (2852, 'Present without measurable section loss.', 'FAIR', 571);
INSERT INTO public.condition VALUES (2853, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 571);
INSERT INTO public.condition VALUES (2854, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 571);
INSERT INTO public.condition VALUES (2855, NULL, 'OTHER', 571);
INSERT INTO public.condition VALUES (2856, 'None', 'GOOD', 572);
INSERT INTO public.condition VALUES (2857, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 572);
INSERT INTO public.condition VALUES (2858, 'Heavy build-up with rust staining.', 'POOR', 572);
INSERT INTO public.condition VALUES (2859, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 572);
INSERT INTO public.condition VALUES (2860, NULL, 'OTHER', 572);
INSERT INTO public.condition VALUES (2861, 'None or insignificant cracks.', 'GOOD', 573);
INSERT INTO public.condition VALUES (2862, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 573);
INSERT INTO public.condition VALUES (2863, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 573);
INSERT INTO public.condition VALUES (2864, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 573);
INSERT INTO public.condition VALUES (2865, NULL, 'OTHER', 573);
INSERT INTO public.condition VALUES (2866, 'No abrasion or wearing.', 'GOOD', 574);
INSERT INTO public.condition VALUES (2867, 'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.', 'FAIR', 574);
INSERT INTO public.condition VALUES (2868, 'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.', 'POOR', 574);
INSERT INTO public.condition VALUES (2869, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 574);
INSERT INTO public.condition VALUES (2870, NULL, 'OTHER', 574);
INSERT INTO public.condition VALUES (2871, 'None', 'GOOD', 575);
INSERT INTO public.condition VALUES (2872, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 575);
INSERT INTO public.condition VALUES (2873, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 575);
INSERT INTO public.condition VALUES (2874, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 575);
INSERT INTO public.condition VALUES (2875, NULL, 'OTHER', 575);
INSERT INTO public.condition VALUES (2876, 'None', 'GOOD', 576);
INSERT INTO public.condition VALUES (2877, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 576);
INSERT INTO public.condition VALUES (2878, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 576);
INSERT INTO public.condition VALUES (2879, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 576);
INSERT INTO public.condition VALUES (2880, NULL, 'OTHER', 576);
INSERT INTO public.condition VALUES (2881, 'Not applicable', 'GOOD', 577);
INSERT INTO public.condition VALUES (2882, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 577);
INSERT INTO public.condition VALUES (2883, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 577);
INSERT INTO public.condition VALUES (2884, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 577);
INSERT INTO public.condition VALUES (2885, NULL, 'OTHER', 577);
INSERT INTO public.condition VALUES (2886, 'None', 'GOOD', 578);
INSERT INTO public.condition VALUES (2887, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 578);
INSERT INTO public.condition VALUES (2888, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 578);
INSERT INTO public.condition VALUES (2889, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 578);
INSERT INTO public.condition VALUES (2890, NULL, 'OTHER', 578);
INSERT INTO public.condition VALUES (2891, 'None', 'GOOD', 579);
INSERT INTO public.condition VALUES (2892, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 579);
INSERT INTO public.condition VALUES (2893, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 579);
INSERT INTO public.condition VALUES (3592, 'Surface crack', 'FAIR', 719);
INSERT INTO public.condition VALUES (2894, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 579);
INSERT INTO public.condition VALUES (2895, NULL, 'OTHER', 579);
INSERT INTO public.condition VALUES (2896, 'None', 'GOOD', 580);
INSERT INTO public.condition VALUES (2897, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 580);
INSERT INTO public.condition VALUES (2898, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 580);
INSERT INTO public.condition VALUES (2899, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 580);
INSERT INTO public.condition VALUES (2900, NULL, 'OTHER', 580);
INSERT INTO public.condition VALUES (2901, 'None', 'GOOD', 581);
INSERT INTO public.condition VALUES (2902, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 581);
INSERT INTO public.condition VALUES (2903, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 581);
INSERT INTO public.condition VALUES (2904, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 581);
INSERT INTO public.condition VALUES (2905, NULL, 'OTHER', 581);
INSERT INTO public.condition VALUES (2906, 'None', 'GOOD', 582);
INSERT INTO public.condition VALUES (2907, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 582);
INSERT INTO public.condition VALUES (2908, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 582);
INSERT INTO public.condition VALUES (2909, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 582);
INSERT INTO public.condition VALUES (2910, NULL, 'OTHER', 582);
INSERT INTO public.condition VALUES (2911, 'Connection is in place and functioning as intended.', 'GOOD', 583);
INSERT INTO public.condition VALUES (2912, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 583);
INSERT INTO public.condition VALUES (2913, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 583);
INSERT INTO public.condition VALUES (2914, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 583);
INSERT INTO public.condition VALUES (2915, NULL, 'OTHER', 583);
INSERT INTO public.condition VALUES (2916, 'Not applicable', 'GOOD', 584);
INSERT INTO public.condition VALUES (2917, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 584);
INSERT INTO public.condition VALUES (2918, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 584);
INSERT INTO public.condition VALUES (2919, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 584);
INSERT INTO public.condition VALUES (2920, NULL, 'OTHER', 584);
INSERT INTO public.condition VALUES (2921, 'None', 'GOOD', 585);
INSERT INTO public.condition VALUES (2922, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 585);
INSERT INTO public.condition VALUES (2923, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 585);
INSERT INTO public.condition VALUES (2924, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 585);
INSERT INTO public.condition VALUES (2925, NULL, 'OTHER', 585);
INSERT INTO public.condition VALUES (2926, 'None', 'GOOD', 586);
INSERT INTO public.condition VALUES (2927, 'Present without measurable section loss.', 'FAIR', 586);
INSERT INTO public.condition VALUES (2928, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 586);
INSERT INTO public.condition VALUES (2929, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 586);
INSERT INTO public.condition VALUES (2930, NULL, 'OTHER', 586);
INSERT INTO public.condition VALUES (2931, 'None', 'GOOD', 587);
INSERT INTO public.condition VALUES (2932, 'Present without section loss.', 'FAIR', 587);
INSERT INTO public.condition VALUES (2933, 'Present with section loss, but does not warrant structural review.', 'POOR', 587);
INSERT INTO public.condition VALUES (2934, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 587);
INSERT INTO public.condition VALUES (2935, NULL, 'OTHER', 587);
INSERT INTO public.condition VALUES (2936, 'No abrasion or wearing.', 'GOOD', 588);
INSERT INTO public.condition VALUES (2937, 'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.', 'FAIR', 588);
INSERT INTO public.condition VALUES (2938, 'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.', 'POOR', 588);
INSERT INTO public.condition VALUES (2939, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 588);
INSERT INTO public.condition VALUES (2940, NULL, 'OTHER', 588);
INSERT INTO public.condition VALUES (2941, 'None', 'GOOD', 589);
INSERT INTO public.condition VALUES (2942, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 589);
INSERT INTO public.condition VALUES (2943, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 589);
INSERT INTO public.condition VALUES (2944, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 589);
INSERT INTO public.condition VALUES (2945, NULL, 'OTHER', 589);
INSERT INTO public.condition VALUES (2946, 'None or insignificant cracks.', 'GOOD', 590);
INSERT INTO public.condition VALUES (2947, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.', 'FAIR', 590);
INSERT INTO public.condition VALUES (2948, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.', 'POOR', 590);
INSERT INTO public.condition VALUES (2949, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 590);
INSERT INTO public.condition VALUES (2950, NULL, 'OTHER', 590);
INSERT INTO public.condition VALUES (2951, 'None', 'GOOD', 591);
INSERT INTO public.condition VALUES (2952, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 591);
INSERT INTO public.condition VALUES (2953, 'Heavy build-up with rust staining.', 'POOR', 591);
INSERT INTO public.condition VALUES (3077, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 616);
INSERT INTO public.condition VALUES (3448, 'Cracking or voids in 10% or more of the of joints', 'POOR', 690);
INSERT INTO public.condition VALUES (2954, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 591);
INSERT INTO public.condition VALUES (2955, NULL, 'OTHER', 591);
INSERT INTO public.condition VALUES (2956, 'None', 'GOOD', 592);
INSERT INTO public.condition VALUES (2957, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 592);
INSERT INTO public.condition VALUES (2958, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 592);
INSERT INTO public.condition VALUES (2959, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 592);
INSERT INTO public.condition VALUES (2960, NULL, 'OTHER', 592);
INSERT INTO public.condition VALUES (2961, 'Not applicable', 'GOOD', 593);
INSERT INTO public.condition VALUES (2962, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 593);
INSERT INTO public.condition VALUES (2963, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 593);
INSERT INTO public.condition VALUES (2964, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 593);
INSERT INTO public.condition VALUES (2965, NULL, 'OTHER', 593);
INSERT INTO public.condition VALUES (2966, 'None', 'GOOD', 594);
INSERT INTO public.condition VALUES (2967, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 594);
INSERT INTO public.condition VALUES (2968, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 594);
INSERT INTO public.condition VALUES (2969, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 594);
INSERT INTO public.condition VALUES (2970, NULL, 'OTHER', 594);
INSERT INTO public.condition VALUES (2971, 'None', 'GOOD', 595);
INSERT INTO public.condition VALUES (2972, 'Present without measurable section loss.', 'FAIR', 595);
INSERT INTO public.condition VALUES (2973, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 595);
INSERT INTO public.condition VALUES (2974, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 595);
INSERT INTO public.condition VALUES (2975, NULL, 'OTHER', 595);
INSERT INTO public.condition VALUES (2976, 'None', 'GOOD', 596);
INSERT INTO public.condition VALUES (2977, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 596);
INSERT INTO public.condition VALUES (2978, 'Heavy build-up with rust staining.', 'POOR', 596);
INSERT INTO public.condition VALUES (2979, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 596);
INSERT INTO public.condition VALUES (2980, NULL, 'OTHER', 596);
INSERT INTO public.condition VALUES (2981, 'None or insignificant cracks.', 'GOOD', 597);
INSERT INTO public.condition VALUES (2982, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 597);
INSERT INTO public.condition VALUES (2983, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 597);
INSERT INTO public.condition VALUES (2984, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 597);
INSERT INTO public.condition VALUES (2985, NULL, 'OTHER', 597);
INSERT INTO public.condition VALUES (2986, 'No abrasion or wearing.', 'GOOD', 598);
INSERT INTO public.condition VALUES (2987, 'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.', 'FAIR', 598);
INSERT INTO public.condition VALUES (2988, 'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.', 'POOR', 598);
INSERT INTO public.condition VALUES (2989, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 598);
INSERT INTO public.condition VALUES (2990, NULL, 'OTHER', 598);
INSERT INTO public.condition VALUES (2991, 'None', 'GOOD', 599);
INSERT INTO public.condition VALUES (2992, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 599);
INSERT INTO public.condition VALUES (2993, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 599);
INSERT INTO public.condition VALUES (2994, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 599);
INSERT INTO public.condition VALUES (2995, NULL, 'OTHER', 599);
INSERT INTO public.condition VALUES (2996, 'None', 'GOOD', 600);
INSERT INTO public.condition VALUES (2997, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 600);
INSERT INTO public.condition VALUES (2998, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 600);
INSERT INTO public.condition VALUES (2999, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 600);
INSERT INTO public.condition VALUES (3000, NULL, 'OTHER', 600);
INSERT INTO public.condition VALUES (3001, 'Not applicable', 'GOOD', 601);
INSERT INTO public.condition VALUES (3002, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 601);
INSERT INTO public.condition VALUES (3003, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 601);
INSERT INTO public.condition VALUES (3004, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 601);
INSERT INTO public.condition VALUES (3005, NULL, 'OTHER', 601);
INSERT INTO public.condition VALUES (3006, 'Connection is in place and functioning as intended.', 'GOOD', 602);
INSERT INTO public.condition VALUES (3007, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 602);
INSERT INTO public.condition VALUES (3008, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 602);
INSERT INTO public.condition VALUES (3009, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 602);
INSERT INTO public.condition VALUES (3010, NULL, 'OTHER', 602);
INSERT INTO public.condition VALUES (3011, 'None', 'GOOD', 603);
INSERT INTO public.condition VALUES (3012, 'Affects less than 10% of the member section.', 'FAIR', 603);
INSERT INTO public.condition VALUES (3013, 'Affects 10% or more of the member but does not warrant structural review.', 'POOR', 603);
INSERT INTO public.condition VALUES (3260, NULL, 'OTHER', 652);
INSERT INTO public.condition VALUES (3014, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 603);
INSERT INTO public.condition VALUES (3015, NULL, 'OTHER', 603);
INSERT INTO public.condition VALUES (3016, 'Surface penetration less than 5% of the member thickness regardless of location.', 'GOOD', 604);
INSERT INTO public.condition VALUES (3017, 'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.', 'FAIR', 604);
INSERT INTO public.condition VALUES (3018, 'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.', 'POOR', 604);
INSERT INTO public.condition VALUES (3019, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 604);
INSERT INTO public.condition VALUES (3020, NULL, 'OTHER', 604);
INSERT INTO public.condition VALUES (3021, 'None', 'GOOD', 605);
INSERT INTO public.condition VALUES (3022, 'Crack that has been arrested through effective measures.', 'FAIR', 605);
INSERT INTO public.condition VALUES (3023, 'Identified crack exists that is not arrested, but does not require structural review', 'POOR', 605);
INSERT INTO public.condition VALUES (3024, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 605);
INSERT INTO public.condition VALUES (3025, NULL, 'OTHER', 605);
INSERT INTO public.condition VALUES (3026, 'None', 'GOOD', 606);
INSERT INTO public.condition VALUES (3027, 'Length less than the member depth or arrested with effective actions taken to mitigate.', 'FAIR', 606);
INSERT INTO public.condition VALUES (3028, 'Length equal to or greater than the member depth, but does not require structural review.', 'POOR', 606);
INSERT INTO public.condition VALUES (3029, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 606);
INSERT INTO public.condition VALUES (3030, NULL, 'OTHER', 606);
INSERT INTO public.condition VALUES (3031, 'None or no measurable section loss.', 'GOOD', 607);
INSERT INTO public.condition VALUES (3032, 'Section loss less than 10% of the member thickness.', 'FAIR', 607);
INSERT INTO public.condition VALUES (3033, 'Section loss 10% or more of the member thickness, but does not warrant structural review.', 'POOR', 607);
INSERT INTO public.condition VALUES (3034, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 607);
INSERT INTO public.condition VALUES (3035, NULL, 'OTHER', 607);
INSERT INTO public.condition VALUES (3036, 'None', 'GOOD', 608);
INSERT INTO public.condition VALUES (3037, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 608);
INSERT INTO public.condition VALUES (3038, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 608);
INSERT INTO public.condition VALUES (3039, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 608);
INSERT INTO public.condition VALUES (3040, NULL, 'OTHER', 608);
INSERT INTO public.condition VALUES (3041, 'None', 'GOOD', 609);
INSERT INTO public.condition VALUES (3042, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 609);
INSERT INTO public.condition VALUES (3043, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 609);
INSERT INTO public.condition VALUES (3044, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 609);
INSERT INTO public.condition VALUES (3045, NULL, 'OTHER', 609);
INSERT INTO public.condition VALUES (3046, 'Not applicable', 'GOOD', 610);
INSERT INTO public.condition VALUES (3047, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 610);
INSERT INTO public.condition VALUES (3048, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 610);
INSERT INTO public.condition VALUES (3049, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 610);
INSERT INTO public.condition VALUES (3050, NULL, 'OTHER', 610);
INSERT INTO public.condition VALUES (3051, 'None', 'GOOD', 611);
INSERT INTO public.condition VALUES (3052, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 611);
INSERT INTO public.condition VALUES (3053, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 611);
INSERT INTO public.condition VALUES (3054, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 611);
INSERT INTO public.condition VALUES (3055, NULL, 'OTHER', 611);
INSERT INTO public.condition VALUES (3056, 'None', 'GOOD', 612);
INSERT INTO public.condition VALUES (3057, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 612);
INSERT INTO public.condition VALUES (3058, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 612);
INSERT INTO public.condition VALUES (3059, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 612);
INSERT INTO public.condition VALUES (3060, NULL, 'OTHER', 612);
INSERT INTO public.condition VALUES (3061, 'Connection is in place and functioning as intended.', 'GOOD', 613);
INSERT INTO public.condition VALUES (3062, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 613);
INSERT INTO public.condition VALUES (3063, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 613);
INSERT INTO public.condition VALUES (3064, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 613);
INSERT INTO public.condition VALUES (3065, NULL, 'OTHER', 613);
INSERT INTO public.condition VALUES (3066, 'None or insignificant cracks.', 'GOOD', 614);
INSERT INTO public.condition VALUES (3067, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 614);
INSERT INTO public.condition VALUES (3068, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 614);
INSERT INTO public.condition VALUES (3069, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 614);
INSERT INTO public.condition VALUES (3070, NULL, 'OTHER', 614);
INSERT INTO public.condition VALUES (3071, 'None', 'GOOD', 615);
INSERT INTO public.condition VALUES (3072, 'Initiated breakdown or deterioration.', 'FAIR', 615);
INSERT INTO public.condition VALUES (3073, 'Significant deterioration or breakdown, but does not warrant structural review.', 'POOR', 615);
INSERT INTO public.condition VALUES (3074, '', 'SEVERE', 615);
INSERT INTO public.condition VALUES (3078, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 616);
INSERT INTO public.condition VALUES (3079, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 616);
INSERT INTO public.condition VALUES (3080, NULL, 'OTHER', 616);
INSERT INTO public.condition VALUES (3081, 'None', 'GOOD', 617);
INSERT INTO public.condition VALUES (3082, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 617);
INSERT INTO public.condition VALUES (3083, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 617);
INSERT INTO public.condition VALUES (3084, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 617);
INSERT INTO public.condition VALUES (3085, NULL, 'OTHER', 617);
INSERT INTO public.condition VALUES (3086, 'None', 'GOOD', 618);
INSERT INTO public.condition VALUES (3087, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 618);
INSERT INTO public.condition VALUES (3088, 'Heavy build-up with rust staining.', 'POOR', 618);
INSERT INTO public.condition VALUES (3089, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 618);
INSERT INTO public.condition VALUES (3090, NULL, 'OTHER', 618);
INSERT INTO public.condition VALUES (3091, 'None', 'GOOD', 619);
INSERT INTO public.condition VALUES (3092, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 619);
INSERT INTO public.condition VALUES (3093, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 619);
INSERT INTO public.condition VALUES (3094, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 619);
INSERT INTO public.condition VALUES (3095, NULL, 'OTHER', 619);
INSERT INTO public.condition VALUES (3096, 'None', 'GOOD', 620);
INSERT INTO public.condition VALUES (3097, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 620);
INSERT INTO public.condition VALUES (3098, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 620);
INSERT INTO public.condition VALUES (3099, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 620);
INSERT INTO public.condition VALUES (3100, NULL, 'OTHER', 620);
INSERT INTO public.condition VALUES (3101, 'Not applicable', 'GOOD', 621);
INSERT INTO public.condition VALUES (3102, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 621);
INSERT INTO public.condition VALUES (3103, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 621);
INSERT INTO public.condition VALUES (3104, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 621);
INSERT INTO public.condition VALUES (3105, NULL, 'OTHER', 621);
INSERT INTO public.condition VALUES (3106, 'None', 'GOOD', 622);
INSERT INTO public.condition VALUES (3107, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 622);
INSERT INTO public.condition VALUES (3108, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 622);
INSERT INTO public.condition VALUES (3109, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 622);
INSERT INTO public.condition VALUES (3110, NULL, 'OTHER', 622);
INSERT INTO public.condition VALUES (3111, 'None', 'GOOD', 623);
INSERT INTO public.condition VALUES (3112, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 623);
INSERT INTO public.condition VALUES (3113, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 623);
INSERT INTO public.condition VALUES (3114, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 623);
INSERT INTO public.condition VALUES (3115, NULL, 'OTHER', 623);
INSERT INTO public.condition VALUES (3116, 'Connection is in place and functioning as intended.', 'GOOD', 624);
INSERT INTO public.condition VALUES (3117, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 624);
INSERT INTO public.condition VALUES (3118, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 624);
INSERT INTO public.condition VALUES (3119, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 624);
INSERT INTO public.condition VALUES (3120, NULL, 'OTHER', 624);
INSERT INTO public.condition VALUES (3121, 'None', 'GOOD', 625);
INSERT INTO public.condition VALUES (3122, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 625);
INSERT INTO public.condition VALUES (3123, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 625);
INSERT INTO public.condition VALUES (3124, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 625);
INSERT INTO public.condition VALUES (3125, NULL, 'OTHER', 625);
INSERT INTO public.condition VALUES (3126, 'None', 'GOOD', 626);
INSERT INTO public.condition VALUES (3127, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 626);
INSERT INTO public.condition VALUES (3128, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 626);
INSERT INTO public.condition VALUES (3129, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 626);
INSERT INTO public.condition VALUES (3130, NULL, 'OTHER', 626);
INSERT INTO public.condition VALUES (3131, 'None', 'GOOD', 627);
INSERT INTO public.condition VALUES (3132, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 627);
INSERT INTO public.condition VALUES (3133, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 627);
INSERT INTO public.condition VALUES (3134, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 627);
INSERT INTO public.condition VALUES (3135, NULL, 'OTHER', 627);
INSERT INTO public.condition VALUES (3136, 'Not applicable', 'GOOD', 628);
INSERT INTO public.condition VALUES (3137, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 628);
INSERT INTO public.condition VALUES (3138, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 628);
INSERT INTO public.condition VALUES (3139, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 628);
INSERT INTO public.condition VALUES (3140, NULL, 'OTHER', 628);
INSERT INTO public.condition VALUES (3141, 'None', 'GOOD', 629);
INSERT INTO public.condition VALUES (3142, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 629);
INSERT INTO public.condition VALUES (3143, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 629);
INSERT INTO public.condition VALUES (3144, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 629);
INSERT INTO public.condition VALUES (3145, NULL, 'OTHER', 629);
INSERT INTO public.condition VALUES (3146, 'None or insignificant cracks.', 'GOOD', 630);
INSERT INTO public.condition VALUES (3147, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 630);
INSERT INTO public.condition VALUES (3148, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 630);
INSERT INTO public.condition VALUES (3149, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 630);
INSERT INTO public.condition VALUES (3150, NULL, 'OTHER', 630);
INSERT INTO public.condition VALUES (3151, 'None', 'GOOD', 631);
INSERT INTO public.condition VALUES (3152, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 631);
INSERT INTO public.condition VALUES (3153, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 631);
INSERT INTO public.condition VALUES (3154, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 631);
INSERT INTO public.condition VALUES (3155, NULL, 'OTHER', 631);
INSERT INTO public.condition VALUES (3156, 'None', 'GOOD', 632);
INSERT INTO public.condition VALUES (3157, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 632);
INSERT INTO public.condition VALUES (3158, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 632);
INSERT INTO public.condition VALUES (3159, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 632);
INSERT INTO public.condition VALUES (3160, NULL, 'OTHER', 632);
INSERT INTO public.condition VALUES (3161, 'None', 'GOOD', 633);
INSERT INTO public.condition VALUES (3162, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 633);
INSERT INTO public.condition VALUES (3163, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 633);
INSERT INTO public.condition VALUES (3164, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 633);
INSERT INTO public.condition VALUES (3165, NULL, 'OTHER', 633);
INSERT INTO public.condition VALUES (3166, 'Not applicable', 'GOOD', 634);
INSERT INTO public.condition VALUES (3167, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 634);
INSERT INTO public.condition VALUES (3168, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 634);
INSERT INTO public.condition VALUES (3169, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 634);
INSERT INTO public.condition VALUES (3170, NULL, 'OTHER', 634);
INSERT INTO public.condition VALUES (3171, 'None', 'GOOD', 635);
INSERT INTO public.condition VALUES (3172, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 635);
INSERT INTO public.condition VALUES (3173, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 635);
INSERT INTO public.condition VALUES (3174, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 635);
INSERT INTO public.condition VALUES (3175, NULL, 'OTHER', 635);
INSERT INTO public.condition VALUES (3176, 'None', 'GOOD', 636);
INSERT INTO public.condition VALUES (3177, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 636);
INSERT INTO public.condition VALUES (3178, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 636);
INSERT INTO public.condition VALUES (3179, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 636);
INSERT INTO public.condition VALUES (3180, NULL, 'OTHER', 636);
INSERT INTO public.condition VALUES (3181, 'Connection is in place and functioning as intended.', 'GOOD', 637);
INSERT INTO public.condition VALUES (3182, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 637);
INSERT INTO public.condition VALUES (3183, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 637);
INSERT INTO public.condition VALUES (3184, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 637);
INSERT INTO public.condition VALUES (3185, NULL, 'OTHER', 637);
INSERT INTO public.condition VALUES (3186, 'None', 'GOOD', 638);
INSERT INTO public.condition VALUES (3187, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 638);
INSERT INTO public.condition VALUES (3188, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 638);
INSERT INTO public.condition VALUES (3189, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 638);
INSERT INTO public.condition VALUES (3190, NULL, 'OTHER', 638);
INSERT INTO public.condition VALUES (3191, 'Not applicable', 'GOOD', 639);
INSERT INTO public.condition VALUES (3192, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 639);
INSERT INTO public.condition VALUES (3193, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 639);
INSERT INTO public.condition VALUES (3194, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 639);
INSERT INTO public.condition VALUES (3195, NULL, 'OTHER', 639);
INSERT INTO public.condition VALUES (3196, 'None', 'GOOD', 640);
INSERT INTO public.condition VALUES (3197, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 640);
INSERT INTO public.condition VALUES (3198, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 640);
INSERT INTO public.condition VALUES (3199, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 640);
INSERT INTO public.condition VALUES (3200, NULL, 'OTHER', 640);
INSERT INTO public.condition VALUES (3201, 'None', 'GOOD', 641);
INSERT INTO public.condition VALUES (3202, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 641);
INSERT INTO public.condition VALUES (3203, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 641);
INSERT INTO public.condition VALUES (3204, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 641);
INSERT INTO public.condition VALUES (3205, NULL, 'OTHER', 641);
INSERT INTO public.condition VALUES (3206, 'Connection is in place and functioning as intended.', 'GOOD', 642);
INSERT INTO public.condition VALUES (3207, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 642);
INSERT INTO public.condition VALUES (3208, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 642);
INSERT INTO public.condition VALUES (3209, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 642);
INSERT INTO public.condition VALUES (3210, NULL, 'OTHER', 642);
INSERT INTO public.condition VALUES (3211, 'None', 'GOOD', 643);
INSERT INTO public.condition VALUES (3212, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 643);
INSERT INTO public.condition VALUES (3213, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 643);
INSERT INTO public.condition VALUES (3214, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 643);
INSERT INTO public.condition VALUES (3215, NULL, 'OTHER', 643);
INSERT INTO public.condition VALUES (3216, 'Not applicable', 'GOOD', 644);
INSERT INTO public.condition VALUES (3217, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 644);
INSERT INTO public.condition VALUES (3218, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 644);
INSERT INTO public.condition VALUES (3219, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 644);
INSERT INTO public.condition VALUES (3220, NULL, 'OTHER', 644);
INSERT INTO public.condition VALUES (3221, 'None', 'GOOD', 645);
INSERT INTO public.condition VALUES (3222, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 645);
INSERT INTO public.condition VALUES (3223, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 645);
INSERT INTO public.condition VALUES (3224, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 645);
INSERT INTO public.condition VALUES (3225, NULL, 'OTHER', 645);
INSERT INTO public.condition VALUES (3226, 'None', 'GOOD', 646);
INSERT INTO public.condition VALUES (3227, 'Present without measurable section loss.', 'FAIR', 646);
INSERT INTO public.condition VALUES (3228, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 646);
INSERT INTO public.condition VALUES (3229, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 646);
INSERT INTO public.condition VALUES (3230, NULL, 'OTHER', 646);
INSERT INTO public.condition VALUES (3231, 'None', 'GOOD', 647);
INSERT INTO public.condition VALUES (3232, 'Initiated breakdown or deterioration.', 'FAIR', 647);
INSERT INTO public.condition VALUES (3233, 'Significant deterioration or breakdown, but does not warrant structural review.', 'POOR', 647);
INSERT INTO public.condition VALUES (3234, '', 'SEVERE', 647);
INSERT INTO public.condition VALUES (3235, NULL, 'OTHER', 647);
INSERT INTO public.condition VALUES (3236, 'None or insignificant cracks.', 'GOOD', 648);
INSERT INTO public.condition VALUES (3237, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 648);
INSERT INTO public.condition VALUES (3238, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 648);
INSERT INTO public.condition VALUES (3239, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 648);
INSERT INTO public.condition VALUES (3240, NULL, 'OTHER', 648);
INSERT INTO public.condition VALUES (3241, 'None', 'GOOD', 649);
INSERT INTO public.condition VALUES (3242, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 649);
INSERT INTO public.condition VALUES (3243, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 649);
INSERT INTO public.condition VALUES (3244, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 649);
INSERT INTO public.condition VALUES (3245, NULL, 'OTHER', 649);
INSERT INTO public.condition VALUES (3246, 'None', 'GOOD', 650);
INSERT INTO public.condition VALUES (3247, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 650);
INSERT INTO public.condition VALUES (3248, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 650);
INSERT INTO public.condition VALUES (3249, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 650);
INSERT INTO public.condition VALUES (3250, NULL, 'OTHER', 650);
INSERT INTO public.condition VALUES (3251, 'Not applicable', 'GOOD', 651);
INSERT INTO public.condition VALUES (3252, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 651);
INSERT INTO public.condition VALUES (3253, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 651);
INSERT INTO public.condition VALUES (3254, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 651);
INSERT INTO public.condition VALUES (3255, NULL, 'OTHER', 651);
INSERT INTO public.condition VALUES (3256, 'None', 'GOOD', 652);
INSERT INTO public.condition VALUES (3257, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 652);
INSERT INTO public.condition VALUES (3258, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 652);
INSERT INTO public.condition VALUES (3259, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 652);
INSERT INTO public.condition VALUES (3262, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 653);
INSERT INTO public.condition VALUES (3263, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 653);
INSERT INTO public.condition VALUES (3264, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 653);
INSERT INTO public.condition VALUES (3265, NULL, 'OTHER', 653);
INSERT INTO public.condition VALUES (3266, 'None', 'GOOD', 654);
INSERT INTO public.condition VALUES (3267, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 654);
INSERT INTO public.condition VALUES (3268, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 654);
INSERT INTO public.condition VALUES (3269, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 654);
INSERT INTO public.condition VALUES (3270, NULL, 'OTHER', 654);
INSERT INTO public.condition VALUES (3271, 'None', 'GOOD', 655);
INSERT INTO public.condition VALUES (3272, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 655);
INSERT INTO public.condition VALUES (3273, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 655);
INSERT INTO public.condition VALUES (3274, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 655);
INSERT INTO public.condition VALUES (3275, NULL, 'OTHER', 655);
INSERT INTO public.condition VALUES (3276, 'None', 'GOOD', 656);
INSERT INTO public.condition VALUES (3277, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 656);
INSERT INTO public.condition VALUES (3278, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 656);
INSERT INTO public.condition VALUES (3279, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 656);
INSERT INTO public.condition VALUES (3280, NULL, 'OTHER', 656);
INSERT INTO public.condition VALUES (3281, 'Connection is in place and functioning as intended.', 'GOOD', 657);
INSERT INTO public.condition VALUES (3282, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 657);
INSERT INTO public.condition VALUES (3283, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 657);
INSERT INTO public.condition VALUES (3284, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 657);
INSERT INTO public.condition VALUES (3285, NULL, 'OTHER', 657);
INSERT INTO public.condition VALUES (3286, 'Not applicable', 'GOOD', 658);
INSERT INTO public.condition VALUES (3287, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 658);
INSERT INTO public.condition VALUES (3288, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 658);
INSERT INTO public.condition VALUES (3289, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 658);
INSERT INTO public.condition VALUES (3290, NULL, 'OTHER', 658);
INSERT INTO public.condition VALUES (3291, 'None', 'GOOD', 659);
INSERT INTO public.condition VALUES (3292, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 659);
INSERT INTO public.condition VALUES (3293, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 659);
INSERT INTO public.condition VALUES (3294, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 659);
INSERT INTO public.condition VALUES (3295, NULL, 'OTHER', 659);
INSERT INTO public.condition VALUES (3296, 'None', 'GOOD', 660);
INSERT INTO public.condition VALUES (3297, 'Present without measurable section loss.', 'FAIR', 660);
INSERT INTO public.condition VALUES (3298, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 660);
INSERT INTO public.condition VALUES (3299, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 660);
INSERT INTO public.condition VALUES (3300, NULL, 'OTHER', 660);
INSERT INTO public.condition VALUES (3301, 'None', 'GOOD', 661);
INSERT INTO public.condition VALUES (3302, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 661);
INSERT INTO public.condition VALUES (3303, 'Heavy build-up with rust staining.', 'POOR', 661);
INSERT INTO public.condition VALUES (3304, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 661);
INSERT INTO public.condition VALUES (3305, NULL, 'OTHER', 661);
INSERT INTO public.condition VALUES (3306, 'None or insignificant cracks.', 'GOOD', 662);
INSERT INTO public.condition VALUES (3307, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 662);
INSERT INTO public.condition VALUES (3308, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 662);
INSERT INTO public.condition VALUES (3309, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 662);
INSERT INTO public.condition VALUES (3310, NULL, 'OTHER', 662);
INSERT INTO public.condition VALUES (3311, 'No abrasion or wearing.', 'GOOD', 663);
INSERT INTO public.condition VALUES (3312, 'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.', 'FAIR', 663);
INSERT INTO public.condition VALUES (3313, 'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.', 'POOR', 663);
INSERT INTO public.condition VALUES (3314, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 663);
INSERT INTO public.condition VALUES (3315, NULL, 'OTHER', 663);
INSERT INTO public.condition VALUES (3316, 'None', 'GOOD', 664);
INSERT INTO public.condition VALUES (3317, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 664);
INSERT INTO public.condition VALUES (3318, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 664);
INSERT INTO public.condition VALUES (3319, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 664);
INSERT INTO public.condition VALUES (3320, NULL, 'OTHER', 664);
INSERT INTO public.condition VALUES (3321, 'None', 'GOOD', 665);
INSERT INTO public.condition VALUES (3322, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 665);
INSERT INTO public.condition VALUES (3323, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 665);
INSERT INTO public.condition VALUES (3324, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 665);
INSERT INTO public.condition VALUES (3325, NULL, 'OTHER', 665);
INSERT INTO public.condition VALUES (3326, 'None', 'GOOD', 666);
INSERT INTO public.condition VALUES (3327, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 666);
INSERT INTO public.condition VALUES (3328, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 666);
INSERT INTO public.condition VALUES (3329, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 666);
INSERT INTO public.condition VALUES (3330, NULL, 'OTHER', 666);
INSERT INTO public.condition VALUES (3331, 'Not applicable', 'GOOD', 667);
INSERT INTO public.condition VALUES (3332, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 667);
INSERT INTO public.condition VALUES (3333, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 667);
INSERT INTO public.condition VALUES (3334, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 667);
INSERT INTO public.condition VALUES (3335, NULL, 'OTHER', 667);
INSERT INTO public.condition VALUES (3336, 'Connection is in place and functioning as intended.', 'GOOD', 668);
INSERT INTO public.condition VALUES (3337, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 668);
INSERT INTO public.condition VALUES (3338, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 668);
INSERT INTO public.condition VALUES (3339, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 668);
INSERT INTO public.condition VALUES (3340, NULL, 'OTHER', 668);
INSERT INTO public.condition VALUES (3341, 'None', 'GOOD', 669);
INSERT INTO public.condition VALUES (3342, 'Affects less than 10% of the member section.', 'FAIR', 669);
INSERT INTO public.condition VALUES (3343, 'Affects 10% or more of the member but does not warrant structural review.', 'POOR', 669);
INSERT INTO public.condition VALUES (3344, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 669);
INSERT INTO public.condition VALUES (3345, NULL, 'OTHER', 669);
INSERT INTO public.condition VALUES (3346, 'Surface penetration less than 5% of the member thickness regardless of location.', 'GOOD', 670);
INSERT INTO public.condition VALUES (3347, 'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.', 'FAIR', 670);
INSERT INTO public.condition VALUES (3348, 'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.', 'POOR', 670);
INSERT INTO public.condition VALUES (3349, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 670);
INSERT INTO public.condition VALUES (3350, NULL, 'OTHER', 670);
INSERT INTO public.condition VALUES (3351, 'None', 'GOOD', 671);
INSERT INTO public.condition VALUES (3352, 'Crack that has been arrested through effective measures.', 'FAIR', 671);
INSERT INTO public.condition VALUES (3353, 'Identified crack exists that is not arrested, but does not require structural review', 'POOR', 671);
INSERT INTO public.condition VALUES (3354, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 671);
INSERT INTO public.condition VALUES (3355, NULL, 'OTHER', 671);
INSERT INTO public.condition VALUES (3356, 'None', 'GOOD', 672);
INSERT INTO public.condition VALUES (3357, 'Length less than the member depth or arrested with effective actions taken to mitigate.', 'FAIR', 672);
INSERT INTO public.condition VALUES (3358, 'Length equal to or greater than the member depth, but does not require structural review.', 'POOR', 672);
INSERT INTO public.condition VALUES (3359, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 672);
INSERT INTO public.condition VALUES (3360, NULL, 'OTHER', 672);
INSERT INTO public.condition VALUES (3361, 'None or no measurable section loss.', 'GOOD', 673);
INSERT INTO public.condition VALUES (3362, 'Section loss less than 10% of the member thickness.', 'FAIR', 673);
INSERT INTO public.condition VALUES (3363, 'Section loss 10% or more of the member thickness, but does not warrant structural review.', 'POOR', 673);
INSERT INTO public.condition VALUES (3364, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 673);
INSERT INTO public.condition VALUES (3365, NULL, 'OTHER', 673);
INSERT INTO public.condition VALUES (3366, 'None', 'GOOD', 674);
INSERT INTO public.condition VALUES (3367, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 674);
INSERT INTO public.condition VALUES (3368, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 674);
INSERT INTO public.condition VALUES (3369, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 674);
INSERT INTO public.condition VALUES (3370, NULL, 'OTHER', 674);
INSERT INTO public.condition VALUES (3371, 'None', 'GOOD', 675);
INSERT INTO public.condition VALUES (3372, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 675);
INSERT INTO public.condition VALUES (3373, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 675);
INSERT INTO public.condition VALUES (3374, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 675);
INSERT INTO public.condition VALUES (3375, NULL, 'OTHER', 675);
INSERT INTO public.condition VALUES (3376, 'None', 'GOOD', 676);
INSERT INTO public.condition VALUES (3377, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 676);
INSERT INTO public.condition VALUES (3378, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 676);
INSERT INTO public.condition VALUES (3379, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 676);
INSERT INTO public.condition VALUES (3380, NULL, 'OTHER', 676);
INSERT INTO public.condition VALUES (3381, 'Not applicable', 'GOOD', 677);
INSERT INTO public.condition VALUES (3382, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 677);
INSERT INTO public.condition VALUES (3383, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 677);
INSERT INTO public.condition VALUES (3384, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 677);
INSERT INTO public.condition VALUES (3385, NULL, 'OTHER', 677);
INSERT INTO public.condition VALUES (3386, 'None', 'GOOD', 678);
INSERT INTO public.condition VALUES (3387, 'Freckled Rust.
Corrosion of the steel has initiated.', 'FAIR', 678);
INSERT INTO public.condition VALUES (3388, 'Section loss is evident or pack rust is present but does not warrant structural review.', 'POOR', 678);
INSERT INTO public.condition VALUES (3389, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 678);
INSERT INTO public.condition VALUES (3390, NULL, 'OTHER', 678);
INSERT INTO public.condition VALUES (3391, 'None', 'GOOD', 679);
INSERT INTO public.condition VALUES (3392, 'Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.', 'FAIR', 679);
INSERT INTO public.condition VALUES (3393, 'Identified crack exists that is not arrested but does not warrant structural review.', 'POOR', 679);
INSERT INTO public.condition VALUES (3394, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 679);
INSERT INTO public.condition VALUES (3395, NULL, 'OTHER', 679);
INSERT INTO public.condition VALUES (3396, 'Connection is in place and functioning as intended.', 'GOOD', 680);
INSERT INTO public.condition VALUES (3397, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 680);
INSERT INTO public.condition VALUES (3398, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 680);
INSERT INTO public.condition VALUES (3399, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 680);
INSERT INTO public.condition VALUES (3400, NULL, 'OTHER', 680);
INSERT INTO public.condition VALUES (3401, 'None', 'GOOD', 681);
INSERT INTO public.condition VALUES (3402, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 681);
INSERT INTO public.condition VALUES (3403, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 681);
INSERT INTO public.condition VALUES (3404, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 681);
INSERT INTO public.condition VALUES (3405, NULL, 'OTHER', 681);
INSERT INTO public.condition VALUES (3406, 'None', 'GOOD', 682);
INSERT INTO public.condition VALUES (3407, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 682);
INSERT INTO public.condition VALUES (3408, 'Heavy build-up with rust staining.', 'POOR', 682);
INSERT INTO public.condition VALUES (3409, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 682);
INSERT INTO public.condition VALUES (3410, NULL, 'OTHER', 682);
INSERT INTO public.condition VALUES (3411, 'None or insignificant cracks.', 'GOOD', 683);
INSERT INTO public.condition VALUES (3412, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 683);
INSERT INTO public.condition VALUES (3413, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 683);
INSERT INTO public.condition VALUES (3414, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 683);
INSERT INTO public.condition VALUES (3415, NULL, 'OTHER', 683);
INSERT INTO public.condition VALUES (3416, 'None', 'GOOD', 684);
INSERT INTO public.condition VALUES (3417, 'Initiated breakdown or deterioration.', 'FAIR', 684);
INSERT INTO public.condition VALUES (3418, 'Significant deterioration or breakdown, but does not warrant structural review.', 'POOR', 684);
INSERT INTO public.condition VALUES (3419, '', 'SEVERE', 684);
INSERT INTO public.condition VALUES (3420, NULL, 'OTHER', 684);
INSERT INTO public.condition VALUES (3421, 'None', 'GOOD', 685);
INSERT INTO public.condition VALUES (3422, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 685);
INSERT INTO public.condition VALUES (3423, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 685);
INSERT INTO public.condition VALUES (3424, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 685);
INSERT INTO public.condition VALUES (3425, NULL, 'OTHER', 685);
INSERT INTO public.condition VALUES (3426, 'None', 'GOOD', 686);
INSERT INTO public.condition VALUES (3427, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 686);
INSERT INTO public.condition VALUES (3428, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 686);
INSERT INTO public.condition VALUES (3429, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 686);
INSERT INTO public.condition VALUES (3430, NULL, 'OTHER', 686);
INSERT INTO public.condition VALUES (3431, 'None', 'GOOD', 687);
INSERT INTO public.condition VALUES (3432, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 687);
INSERT INTO public.condition VALUES (3433, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 687);
INSERT INTO public.condition VALUES (3434, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 687);
INSERT INTO public.condition VALUES (3435, NULL, 'OTHER', 687);
INSERT INTO public.condition VALUES (3436, 'Not applicable', 'GOOD', 688);
INSERT INTO public.condition VALUES (3437, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 688);
INSERT INTO public.condition VALUES (3438, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 688);
INSERT INTO public.condition VALUES (3439, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 688);
INSERT INTO public.condition VALUES (3440, NULL, 'OTHER', 688);
INSERT INTO public.condition VALUES (3441, 'None', 'GOOD', 689);
INSERT INTO public.condition VALUES (3442, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 689);
INSERT INTO public.condition VALUES (3443, 'Heavy build-up with rust staining.', 'POOR', 689);
INSERT INTO public.condition VALUES (3444, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 689);
INSERT INTO public.condition VALUES (3445, NULL, 'OTHER', 689);
INSERT INTO public.condition VALUES (3446, 'None', 'GOOD', 690);
INSERT INTO public.condition VALUES (3449, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 690);
INSERT INTO public.condition VALUES (3450, NULL, 'OTHER', 690);
INSERT INTO public.condition VALUES (3451, 'None', 'GOOD', 691);
INSERT INTO public.condition VALUES (3452, 'Block or stone has split or spalled with no shifting.', 'FAIR', 691);
INSERT INTO public.condition VALUES (3453, 'Block or stone has split or spalled with shifting but does not warrant a structural review.', 'POOR', 691);
INSERT INTO public.condition VALUES (3454, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 691);
INSERT INTO public.condition VALUES (3455, NULL, 'OTHER', 691);
INSERT INTO public.condition VALUES (3456, 'None', 'GOOD', 692);
INSERT INTO public.condition VALUES (3457, 'Sound Patch', 'FAIR', 692);
INSERT INTO public.condition VALUES (3458, 'Unsound Patch', 'POOR', 692);
INSERT INTO public.condition VALUES (3459, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 692);
INSERT INTO public.condition VALUES (3460, NULL, 'OTHER', 692);
INSERT INTO public.condition VALUES (3461, 'None', 'GOOD', 693);
INSERT INTO public.condition VALUES (3462, 'Block or stone has shifted slightly out of alignment.', 'FAIR', 693);
INSERT INTO public.condition VALUES (3463, 'Block or stone has shifted significantly out of alignment or is missing but does not warrant structural review.', 'POOR', 693);
INSERT INTO public.condition VALUES (3464, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 693);
INSERT INTO public.condition VALUES (3465, NULL, 'OTHER', 693);
INSERT INTO public.condition VALUES (3466, 'None', 'GOOD', 694);
INSERT INTO public.condition VALUES (3467, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 694);
INSERT INTO public.condition VALUES (3468, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 694);
INSERT INTO public.condition VALUES (3469, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 694);
INSERT INTO public.condition VALUES (3470, NULL, 'OTHER', 694);
INSERT INTO public.condition VALUES (3471, 'None', 'GOOD', 695);
INSERT INTO public.condition VALUES (3472, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 695);
INSERT INTO public.condition VALUES (3473, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 695);
INSERT INTO public.condition VALUES (3474, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 695);
INSERT INTO public.condition VALUES (3475, NULL, 'OTHER', 695);
INSERT INTO public.condition VALUES (3476, 'None', 'GOOD', 696);
INSERT INTO public.condition VALUES (3477, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 696);
INSERT INTO public.condition VALUES (3478, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 696);
INSERT INTO public.condition VALUES (3479, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 696);
INSERT INTO public.condition VALUES (3480, NULL, 'OTHER', 696);
INSERT INTO public.condition VALUES (3481, 'Not applicable', 'GOOD', 697);
INSERT INTO public.condition VALUES (3482, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 697);
INSERT INTO public.condition VALUES (3483, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 697);
INSERT INTO public.condition VALUES (3484, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 697);
INSERT INTO public.condition VALUES (3485, NULL, 'OTHER', 697);
INSERT INTO public.condition VALUES (3486, 'None', 'GOOD', 698);
INSERT INTO public.condition VALUES (3487, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 698);
INSERT INTO public.condition VALUES (3488, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 698);
INSERT INTO public.condition VALUES (3489, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 698);
INSERT INTO public.condition VALUES (3490, NULL, 'OTHER', 698);
INSERT INTO public.condition VALUES (3491, 'None', 'GOOD', 699);
INSERT INTO public.condition VALUES (3492, 'Present without measurable section loss.', 'FAIR', 699);
INSERT INTO public.condition VALUES (3493, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 699);
INSERT INTO public.condition VALUES (3494, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 699);
INSERT INTO public.condition VALUES (3495, NULL, 'OTHER', 699);
INSERT INTO public.condition VALUES (3496, 'None', 'GOOD', 700);
INSERT INTO public.condition VALUES (3497, 'Present without section loss.', 'FAIR', 700);
INSERT INTO public.condition VALUES (3498, 'Present with section loss, but does not warrant structural review.', 'POOR', 700);
INSERT INTO public.condition VALUES (3499, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 700);
INSERT INTO public.condition VALUES (3500, NULL, 'OTHER', 700);
INSERT INTO public.condition VALUES (3501, 'None or insignificant cracks.', 'GOOD', 701);
INSERT INTO public.condition VALUES (3502, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.', 'FAIR', 701);
INSERT INTO public.condition VALUES (3503, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.', 'POOR', 701);
INSERT INTO public.condition VALUES (3504, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 701);
INSERT INTO public.condition VALUES (3505, NULL, 'OTHER', 701);
INSERT INTO public.condition VALUES (3506, 'None', 'GOOD', 702);
INSERT INTO public.condition VALUES (3507, 'Surface white without build-up or leaching without rust staining.', 'FAIR', 702);
INSERT INTO public.condition VALUES (3508, 'Heavy build-up with rust staining.', 'POOR', 702);
INSERT INTO public.condition VALUES (3509, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 702);
INSERT INTO public.condition VALUES (3510, NULL, 'OTHER', 702);
INSERT INTO public.condition VALUES (3511, 'No abrasion or wearing.', 'GOOD', 703);
INSERT INTO public.condition VALUES (3589, 'Punctured completely through, pulled out, or missing.', 'SEVERE', 718);
INSERT INTO public.condition VALUES (3512, 'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.', 'FAIR', 703);
INSERT INTO public.condition VALUES (3513, 'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.', 'POOR', 703);
INSERT INTO public.condition VALUES (3514, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 703);
INSERT INTO public.condition VALUES (3515, NULL, 'OTHER', 703);
INSERT INTO public.condition VALUES (3516, 'None', 'GOOD', 704);
INSERT INTO public.condition VALUES (3517, 'Distortion not requiring mitigation or mitigated distortion.', 'FAIR', 704);
INSERT INTO public.condition VALUES (3518, 'Distortion that requires mitigation that has not been addressed, but does not warrant structural review.', 'POOR', 704);
INSERT INTO public.condition VALUES (3519, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 704);
INSERT INTO public.condition VALUES (3520, NULL, 'OTHER', 704);
INSERT INTO public.condition VALUES (3521, 'None', 'GOOD', 705);
INSERT INTO public.condition VALUES (3522, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 705);
INSERT INTO public.condition VALUES (3523, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 705);
INSERT INTO public.condition VALUES (3524, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 705);
INSERT INTO public.condition VALUES (3525, NULL, 'OTHER', 705);
INSERT INTO public.condition VALUES (3526, 'None', 'GOOD', 706);
INSERT INTO public.condition VALUES (3527, 'Exists within tolerable limits or has been arrested with effective countermeasures.', 'FAIR', 706);
INSERT INTO public.condition VALUES (3528, 'Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.', 'POOR', 706);
INSERT INTO public.condition VALUES (3529, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 706);
INSERT INTO public.condition VALUES (3530, NULL, 'OTHER', 706);
INSERT INTO public.condition VALUES (3531, 'Not applicable', 'GOOD', 707);
INSERT INTO public.condition VALUES (3532, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 707);
INSERT INTO public.condition VALUES (3533, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 707);
INSERT INTO public.condition VALUES (3534, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 707);
INSERT INTO public.condition VALUES (3535, NULL, 'OTHER', 707);
INSERT INTO public.condition VALUES (3536, 'None', 'GOOD', 708);
INSERT INTO public.condition VALUES (3537, 'Minimal.
Minor dripping through the joint.', 'FAIR', 708);
INSERT INTO public.condition VALUES (3538, 'Moderate.
More than a drip and less than free flow of water.', 'POOR', 708);
INSERT INTO public.condition VALUES (3539, 'Free flow of water through the joint.', 'SEVERE', 708);
INSERT INTO public.condition VALUES (3540, NULL, 'OTHER', 708);
INSERT INTO public.condition VALUES (3541, 'Fully Adhered', 'GOOD', 709);
INSERT INTO public.condition VALUES (3542, 'Adhered for more than 50% of the joint height.', 'FAIR', 709);
INSERT INTO public.condition VALUES (3543, 'Adhered 50% or less of joint height but still some adhesion', 'POOR', 709);
INSERT INTO public.condition VALUES (3544, 'Complete loss of adhesion', 'SEVERE', 709);
INSERT INTO public.condition VALUES (3545, NULL, 'OTHER', 709);
INSERT INTO public.condition VALUES (3546, 'None', 'GOOD', 710);
INSERT INTO public.condition VALUES (3547, 'Seal abrasion without punctures.', 'FAIR', 710);
INSERT INTO public.condition VALUES (3548, 'Punctured or ripped or partially pulled out.', 'POOR', 710);
INSERT INTO public.condition VALUES (3549, 'Punctured completely through, pulled out, or missing.', 'SEVERE', 710);
INSERT INTO public.condition VALUES (3550, NULL, 'OTHER', 710);
INSERT INTO public.condition VALUES (3551, 'None', 'GOOD', 711);
INSERT INTO public.condition VALUES (3552, 'Surface crack', 'FAIR', 711);
INSERT INTO public.condition VALUES (3553, 'Crack that partially penetrates the seal.', 'POOR', 711);
INSERT INTO public.condition VALUES (3554, 'Crack that fully penetrates the seal.', 'SEVERE', 711);
INSERT INTO public.condition VALUES (3555, NULL, 'OTHER', 711);
INSERT INTO public.condition VALUES (3556, 'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.', 'GOOD', 712);
INSERT INTO public.condition VALUES (3557, 'Partially filled with hard- packed material, but still allowing free movement.', 'FAIR', 712);
INSERT INTO public.condition VALUES (3558, 'Completely filled and impacts joint movement.', 'POOR', 712);
INSERT INTO public.condition VALUES (3559, 'Completely filled and prevents joint movement.', 'SEVERE', 712);
INSERT INTO public.condition VALUES (3560, NULL, 'OTHER', 712);
INSERT INTO public.condition VALUES (3561, 'Sound.
No spall, delamination or unsound patch.', 'GOOD', 713);
INSERT INTO public.condition VALUES (3562, 'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.
No exposed rebar.
Patched area that is sound.', 'FAIR', 713);
INSERT INTO public.condition VALUES (3563, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Exposed rebar.
Delamination or unsound patched area that makes the joint loose.', 'POOR', 713);
INSERT INTO public.condition VALUES (3564, 'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.', 'SEVERE', 713);
INSERT INTO public.condition VALUES (3565, NULL, 'OTHER', 713);
INSERT INTO public.condition VALUES (3566, 'None', 'GOOD', 714);
INSERT INTO public.condition VALUES (3567, 'Freckled rust, metal has no cracks or impact damage.
Connection may be loose but functioning as intended.', 'FAIR', 714);
INSERT INTO public.condition VALUES (3568, 'Section loss, missing or broken fasteners, cracking of the metal or impact damage but joint still functioning', 'POOR', 714);
INSERT INTO public.condition VALUES (3569, 'Metal cracking, section loss, damage or connection failure that prevents the joint from functioning as intended.', 'SEVERE', 714);
INSERT INTO public.condition VALUES (3570, NULL, 'OTHER', 714);
INSERT INTO public.condition VALUES (3571, 'Not applicable', 'GOOD', 715);
INSERT INTO public.condition VALUES (3572, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 715);
INSERT INTO public.condition VALUES (3573, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 715);
INSERT INTO public.condition VALUES (3574, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 715);
INSERT INTO public.condition VALUES (3575, NULL, 'OTHER', 715);
INSERT INTO public.condition VALUES (3576, 'None', 'GOOD', 716);
INSERT INTO public.condition VALUES (3577, 'Minimal.
Minor dripping through the joint.', 'FAIR', 716);
INSERT INTO public.condition VALUES (3578, 'Moderate.
More than a drip and less than free flow of water.', 'POOR', 716);
INSERT INTO public.condition VALUES (3579, 'Free flow of water through the joint.', 'SEVERE', 716);
INSERT INTO public.condition VALUES (3580, NULL, 'OTHER', 716);
INSERT INTO public.condition VALUES (3581, 'Fully Adhered', 'GOOD', 717);
INSERT INTO public.condition VALUES (3582, 'Adhered for more than 50% of the joint height.', 'FAIR', 717);
INSERT INTO public.condition VALUES (3583, 'Adhered 50% or less of joint height but still some adhesion', 'POOR', 717);
INSERT INTO public.condition VALUES (3584, 'Complete loss of adhesion', 'SEVERE', 717);
INSERT INTO public.condition VALUES (3585, NULL, 'OTHER', 717);
INSERT INTO public.condition VALUES (3586, 'None', 'GOOD', 718);
INSERT INTO public.condition VALUES (3587, 'Seal abrasion without punctures.', 'FAIR', 718);
INSERT INTO public.condition VALUES (3588, 'Punctured or ripped or partially pulled out.', 'POOR', 718);
INSERT INTO public.condition VALUES (3593, 'Crack that partially penetrates the seal.', 'POOR', 719);
INSERT INTO public.condition VALUES (3594, 'Crack that fully penetrates the seal.', 'SEVERE', 719);
INSERT INTO public.condition VALUES (3595, NULL, 'OTHER', 719);
INSERT INTO public.condition VALUES (3596, 'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.', 'GOOD', 720);
INSERT INTO public.condition VALUES (3597, 'Partially filled with hard- packed material, but still allowing free movement.', 'FAIR', 720);
INSERT INTO public.condition VALUES (3598, 'Completely filled and impacts joint movement.', 'POOR', 720);
INSERT INTO public.condition VALUES (3599, 'Completely filled and prevents joint movement.', 'SEVERE', 720);
INSERT INTO public.condition VALUES (3600, NULL, 'OTHER', 720);
INSERT INTO public.condition VALUES (3601, 'Sound.
No spall, delamination or unsound patch.', 'GOOD', 721);
INSERT INTO public.condition VALUES (3602, 'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.
No exposed rebar.
Patched area that is sound.', 'FAIR', 721);
INSERT INTO public.condition VALUES (3603, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Exposed rebar.
Delamination or unsound patched area that makes the joint loose.', 'POOR', 721);
INSERT INTO public.condition VALUES (3604, 'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.', 'SEVERE', 721);
INSERT INTO public.condition VALUES (3605, NULL, 'OTHER', 721);
INSERT INTO public.condition VALUES (3606, 'Not applicable', 'GOOD', 722);
INSERT INTO public.condition VALUES (3607, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 722);
INSERT INTO public.condition VALUES (3608, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 722);
INSERT INTO public.condition VALUES (3609, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 722);
INSERT INTO public.condition VALUES (3610, NULL, 'OTHER', 722);
INSERT INTO public.condition VALUES (3611, 'None', 'GOOD', 723);
INSERT INTO public.condition VALUES (3612, 'Minimal.
Minor dripping through the joint.', 'FAIR', 723);
INSERT INTO public.condition VALUES (3613, 'Moderate.
More than a drip and less than free flow of water.', 'POOR', 723);
INSERT INTO public.condition VALUES (3614, 'Free flow of water through the joint.', 'SEVERE', 723);
INSERT INTO public.condition VALUES (3615, NULL, 'OTHER', 723);
INSERT INTO public.condition VALUES (3616, 'Fully Adhered', 'GOOD', 724);
INSERT INTO public.condition VALUES (3617, 'Adhered for more than 50% of the joint height.', 'FAIR', 724);
INSERT INTO public.condition VALUES (3618, 'Adhered 50% or less of joint height but still some adhesion', 'POOR', 724);
INSERT INTO public.condition VALUES (3619, 'Complete loss of adhesion', 'SEVERE', 724);
INSERT INTO public.condition VALUES (3620, NULL, 'OTHER', 724);
INSERT INTO public.condition VALUES (3621, 'None', 'GOOD', 725);
INSERT INTO public.condition VALUES (3622, 'Seal abrasion without punctures.', 'FAIR', 725);
INSERT INTO public.condition VALUES (3623, 'Punctured or ripped or partially pulled out.', 'POOR', 725);
INSERT INTO public.condition VALUES (3624, 'Punctured completely through, pulled out, or missing.', 'SEVERE', 725);
INSERT INTO public.condition VALUES (3625, NULL, 'OTHER', 725);
INSERT INTO public.condition VALUES (3626, 'None', 'GOOD', 726);
INSERT INTO public.condition VALUES (3627, 'Surface crack', 'FAIR', 726);
INSERT INTO public.condition VALUES (3628, 'Crack that partially penetrates the seal.', 'POOR', 726);
INSERT INTO public.condition VALUES (3629, 'Crack that fully penetrates the seal.', 'SEVERE', 726);
INSERT INTO public.condition VALUES (3630, NULL, 'OTHER', 726);
INSERT INTO public.condition VALUES (3631, 'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.', 'GOOD', 727);
INSERT INTO public.condition VALUES (3632, 'Partially filled with hard- packed material, but still allowing free movement.', 'FAIR', 727);
INSERT INTO public.condition VALUES (3633, 'Completely filled and impacts joint movement.', 'POOR', 727);
INSERT INTO public.condition VALUES (3634, 'Completely filled and prevents joint movement.', 'SEVERE', 727);
INSERT INTO public.condition VALUES (3635, NULL, 'OTHER', 727);
INSERT INTO public.condition VALUES (3636, 'Sound.
No spall, delamination or unsound patch.', 'GOOD', 728);
INSERT INTO public.condition VALUES (3637, 'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.
No exposed rebar.
Patched area that is sound.', 'FAIR', 728);
INSERT INTO public.condition VALUES (3638, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Exposed rebar.
Delamination or unsound patched area that makes the joint loose.', 'POOR', 728);
INSERT INTO public.condition VALUES (3639, 'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.', 'SEVERE', 728);
INSERT INTO public.condition VALUES (3640, NULL, 'OTHER', 728);
INSERT INTO public.condition VALUES (3641, 'Not applicable', 'GOOD', 729);
INSERT INTO public.condition VALUES (3642, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 729);
INSERT INTO public.condition VALUES (3643, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 729);
INSERT INTO public.condition VALUES (3644, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 729);
INSERT INTO public.condition VALUES (3645, NULL, 'OTHER', 729);
INSERT INTO public.condition VALUES (3646, 'None', 'GOOD', 730);
INSERT INTO public.condition VALUES (3647, 'Minimal.
Minor dripping through the joint.', 'FAIR', 730);
INSERT INTO public.condition VALUES (3648, 'Moderate.
More than a drip and less than free flow of water.', 'POOR', 730);
INSERT INTO public.condition VALUES (3649, 'Free flow of water through the joint.', 'SEVERE', 730);
INSERT INTO public.condition VALUES (3650, NULL, 'OTHER', 730);
INSERT INTO public.condition VALUES (3651, 'Fully Adhered', 'GOOD', 731);
INSERT INTO public.condition VALUES (3652, 'Adhered for more than 50% of the joint height.', 'FAIR', 731);
INSERT INTO public.condition VALUES (3653, 'Adhered 50% or less of joint height but still some adhesion', 'POOR', 731);
INSERT INTO public.condition VALUES (3654, 'Complete loss of adhesion', 'SEVERE', 731);
INSERT INTO public.condition VALUES (3655, NULL, 'OTHER', 731);
INSERT INTO public.condition VALUES (3656, 'None', 'GOOD', 732);
INSERT INTO public.condition VALUES (3657, 'Seal abrasion without punctures.', 'FAIR', 732);
INSERT INTO public.condition VALUES (3658, 'Punctured or ripped or partially pulled out.', 'POOR', 732);
INSERT INTO public.condition VALUES (3659, 'Punctured completely through, pulled out, or missing.', 'SEVERE', 732);
INSERT INTO public.condition VALUES (3660, NULL, 'OTHER', 732);
INSERT INTO public.condition VALUES (3661, 'None', 'GOOD', 733);
INSERT INTO public.condition VALUES (3662, 'Surface crack', 'FAIR', 733);
INSERT INTO public.condition VALUES (3663, 'Crack that partially penetrates the seal.', 'POOR', 733);
INSERT INTO public.condition VALUES (3664, 'Crack that fully penetrates the seal.', 'SEVERE', 733);
INSERT INTO public.condition VALUES (3665, NULL, 'OTHER', 733);
INSERT INTO public.condition VALUES (3666, 'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.', 'GOOD', 734);
INSERT INTO public.condition VALUES (3667, 'Partially filled with hard- packed material, but still allowing free movement.', 'FAIR', 734);
INSERT INTO public.condition VALUES (3668, 'Completely filled and impacts joint movement.', 'POOR', 734);
INSERT INTO public.condition VALUES (3669, 'Completely filled and prevents joint movement.', 'SEVERE', 734);
INSERT INTO public.condition VALUES (3670, NULL, 'OTHER', 734);
INSERT INTO public.condition VALUES (3671, 'Sound.
No spall, delamination or unsound patch.', 'GOOD', 735);
INSERT INTO public.condition VALUES (3672, 'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.
No exposed rebar.
Patched area that is sound.', 'FAIR', 735);
INSERT INTO public.condition VALUES (3673, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Exposed rebar.
Delamination or unsound patched area that makes the joint loose.', 'POOR', 735);
INSERT INTO public.condition VALUES (3674, 'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.', 'SEVERE', 735);
INSERT INTO public.condition VALUES (3675, NULL, 'OTHER', 735);
INSERT INTO public.condition VALUES (3676, 'None', 'GOOD', 736);
INSERT INTO public.condition VALUES (3877, 'Crack width 0.25â0.5 inches wide.', 'FAIR', 776);
INSERT INTO public.condition VALUES (3677, 'Freckled rust, metal has no cracks or impact damage.
Connection may be loose but functioning as intended.', 'FAIR', 736);
INSERT INTO public.condition VALUES (3678, 'Section loss, missing or broken fasteners, cracking of the metal or impact damage but joint still functioning', 'POOR', 736);
INSERT INTO public.condition VALUES (3679, 'Metal cracking, section loss, damage or connection failure that prevents the joint from functioning as intended.', 'SEVERE', 736);
INSERT INTO public.condition VALUES (3680, NULL, 'OTHER', 736);
INSERT INTO public.condition VALUES (3681, 'Not applicable', 'GOOD', 737);
INSERT INTO public.condition VALUES (3682, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 737);
INSERT INTO public.condition VALUES (3683, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 737);
INSERT INTO public.condition VALUES (3684, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 737);
INSERT INTO public.condition VALUES (3685, NULL, 'OTHER', 737);
INSERT INTO public.condition VALUES (3686, 'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.', 'GOOD', 738);
INSERT INTO public.condition VALUES (3687, 'Partially filled with hard- packed material, but still allowing free movement.', 'FAIR', 738);
INSERT INTO public.condition VALUES (3688, 'Completely filled and impacts joint movement.', 'POOR', 738);
INSERT INTO public.condition VALUES (3689, 'Completely filled and prevents joint movement.', 'SEVERE', 738);
INSERT INTO public.condition VALUES (3690, NULL, 'OTHER', 738);
INSERT INTO public.condition VALUES (3691, 'Sound.
No spall, delamination or unsound patch.', 'GOOD', 739);
INSERT INTO public.condition VALUES (3692, 'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.
No exposed rebar.
Patched area that is sound.', 'FAIR', 739);
INSERT INTO public.condition VALUES (3693, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Exposed rebar.
Delamination or unsound patched area that makes the joint loose.', 'POOR', 739);
INSERT INTO public.condition VALUES (3694, 'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.', 'SEVERE', 739);
INSERT INTO public.condition VALUES (3695, NULL, 'OTHER', 739);
INSERT INTO public.condition VALUES (3696, 'Not applicable', 'GOOD', 740);
INSERT INTO public.condition VALUES (3697, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 740);
INSERT INTO public.condition VALUES (3698, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 740);
INSERT INTO public.condition VALUES (3699, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 740);
INSERT INTO public.condition VALUES (3700, NULL, 'OTHER', 740);
INSERT INTO public.condition VALUES (3701, 'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.', 'GOOD', 741);
INSERT INTO public.condition VALUES (3702, 'Partially filled with hard- packed material, but still allowing free movement.', 'FAIR', 741);
INSERT INTO public.condition VALUES (3703, 'Completely filled and impacts joint movement.', 'POOR', 741);
INSERT INTO public.condition VALUES (3704, 'Completely filled and prevents joint movement.', 'SEVERE', 741);
INSERT INTO public.condition VALUES (3705, NULL, 'OTHER', 741);
INSERT INTO public.condition VALUES (3706, 'Sound.
No spall, delamination or unsound patch.', 'GOOD', 742);
INSERT INTO public.condition VALUES (3707, 'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.
No exposed rebar.
Patched area that is sound.', 'FAIR', 742);
INSERT INTO public.condition VALUES (3708, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Exposed rebar.
Delamination or unsound patched area that makes the joint loose.', 'POOR', 742);
INSERT INTO public.condition VALUES (3709, 'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.', 'SEVERE', 742);
INSERT INTO public.condition VALUES (3710, NULL, 'OTHER', 742);
INSERT INTO public.condition VALUES (3711, 'None', 'GOOD', 743);
INSERT INTO public.condition VALUES (3712, 'Freckled rust, metal has no cracks or impact damage.
Connection may be loose but functioning as intended.', 'FAIR', 743);
INSERT INTO public.condition VALUES (3713, 'Section loss, missing or broken fasteners, cracking of the metal or impact damage but joint still functioning', 'POOR', 743);
INSERT INTO public.condition VALUES (3714, 'Metal cracking, section loss, damage or connection failure that prevents the joint from functioning as intended.', 'SEVERE', 743);
INSERT INTO public.condition VALUES (3715, NULL, 'OTHER', 743);
INSERT INTO public.condition VALUES (3716, 'Not applicable', 'GOOD', 744);
INSERT INTO public.condition VALUES (3717, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 744);
INSERT INTO public.condition VALUES (3718, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 744);
INSERT INTO public.condition VALUES (3719, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 744);
INSERT INTO public.condition VALUES (3720, NULL, 'OTHER', 744);
INSERT INTO public.condition VALUES (3721, 'None', 'GOOD', 745);
INSERT INTO public.condition VALUES (3722, 'Minimal.
Minor dripping through the joint.', 'FAIR', 745);
INSERT INTO public.condition VALUES (3723, 'Moderate.
More than a drip and less than free flow of water.', 'POOR', 745);
INSERT INTO public.condition VALUES (3724, 'Free flow of water through the joint.', 'SEVERE', 745);
INSERT INTO public.condition VALUES (3725, NULL, 'OTHER', 745);
INSERT INTO public.condition VALUES (3726, 'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.', 'GOOD', 746);
INSERT INTO public.condition VALUES (3727, 'Partially filled with hard- packed material, but still allowing free movement.', 'FAIR', 746);
INSERT INTO public.condition VALUES (3728, 'Completely filled and impacts joint movement.', 'POOR', 746);
INSERT INTO public.condition VALUES (3729, 'Completely filled and prevents joint movement.', 'SEVERE', 746);
INSERT INTO public.condition VALUES (3730, NULL, 'OTHER', 746);
INSERT INTO public.condition VALUES (3731, 'Sound.
No spall, delamination or unsound patch.', 'GOOD', 747);
INSERT INTO public.condition VALUES (3732, 'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.
No exposed rebar.
Patched area that is sound.', 'FAIR', 747);
INSERT INTO public.condition VALUES (3733, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Exposed rebar.
Delamination or unsound patched area that makes the joint loose.', 'POOR', 747);
INSERT INTO public.condition VALUES (3734, 'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.', 'SEVERE', 747);
INSERT INTO public.condition VALUES (3735, NULL, 'OTHER', 747);
INSERT INTO public.condition VALUES (3736, 'None', 'GOOD', 748);
INSERT INTO public.condition VALUES (3737, 'Freckled rust, metal has no cracks or impact damage.
Connection may be loose but functioning as intended.', 'FAIR', 748);
INSERT INTO public.condition VALUES (3738, 'Section loss, missing or broken fasteners, cracking of the metal or impact damage but joint still functioning', 'POOR', 748);
INSERT INTO public.condition VALUES (3739, 'Metal cracking, section loss, damage or connection failure that prevents the joint from functioning as intended.', 'SEVERE', 748);
INSERT INTO public.condition VALUES (3740, NULL, 'OTHER', 748);
INSERT INTO public.condition VALUES (3741, 'Not applicable', 'GOOD', 749);
INSERT INTO public.condition VALUES (3742, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 749);
INSERT INTO public.condition VALUES (3743, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 749);
INSERT INTO public.condition VALUES (3744, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 749);
INSERT INTO public.condition VALUES (3745, NULL, 'OTHER', 749);
INSERT INTO public.condition VALUES (3746, 'None', 'GOOD', 750);
INSERT INTO public.condition VALUES (3747, 'Minimal.
Minor dripping through the joint.', 'FAIR', 750);
INSERT INTO public.condition VALUES (3748, 'Moderate.
More than a drip and less than free flow of water.', 'POOR', 750);
INSERT INTO public.condition VALUES (3749, 'Free flow of water through the joint.', 'SEVERE', 750);
INSERT INTO public.condition VALUES (3750, NULL, 'OTHER', 750);
INSERT INTO public.condition VALUES (3751, 'Fully Adhered', 'GOOD', 751);
INSERT INTO public.condition VALUES (3752, 'Adhered for more than 50% of the joint height.', 'FAIR', 751);
INSERT INTO public.condition VALUES (3753, 'Adhered 50% or less of joint height but still some adhesion', 'POOR', 751);
INSERT INTO public.condition VALUES (3754, 'Complete loss of adhesion', 'SEVERE', 751);
INSERT INTO public.condition VALUES (3755, NULL, 'OTHER', 751);
INSERT INTO public.condition VALUES (3756, 'Fully Adhered', 'GOOD', 752);
INSERT INTO public.condition VALUES (3757, 'Adhered for more than 50% of the joint height.', 'FAIR', 752);
INSERT INTO public.condition VALUES (3758, 'Adhered 50% or less of joint height but still some adhesion', 'POOR', 752);
INSERT INTO public.condition VALUES (3759, 'Complete loss of adhesion', 'SEVERE', 752);
INSERT INTO public.condition VALUES (3760, NULL, 'OTHER', 752);
INSERT INTO public.condition VALUES (3761, 'Not applicable', 'GOOD', 753);
INSERT INTO public.condition VALUES (3762, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 753);
INSERT INTO public.condition VALUES (3763, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 753);
INSERT INTO public.condition VALUES (3764, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 753);
INSERT INTO public.condition VALUES (3765, NULL, 'OTHER', 753);
INSERT INTO public.condition VALUES (3766, 'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.', 'GOOD', 754);
INSERT INTO public.condition VALUES (3767, 'Partially filled with hard- packed material, but still allowing free movement.', 'FAIR', 754);
INSERT INTO public.condition VALUES (3768, 'Completely filled and impacts joint movement.', 'POOR', 754);
INSERT INTO public.condition VALUES (3769, 'Completely filled and prevents joint movement.', 'SEVERE', 754);
INSERT INTO public.condition VALUES (3770, NULL, 'OTHER', 754);
INSERT INTO public.condition VALUES (3771, 'Sound.
No spall, delamination or unsound patch.', 'GOOD', 755);
INSERT INTO public.condition VALUES (3772, 'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.
No exposed rebar.
Patched area that is sound.', 'FAIR', 755);
INSERT INTO public.condition VALUES (3773, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Exposed rebar.
Delamination or unsound patched area that makes the joint loose.', 'POOR', 755);
INSERT INTO public.condition VALUES (3774, 'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.', 'SEVERE', 755);
INSERT INTO public.condition VALUES (3775, NULL, 'OTHER', 755);
INSERT INTO public.condition VALUES (3776, 'None', 'GOOD', 756);
INSERT INTO public.condition VALUES (3777, 'Freckled rust, metal has no cracks or impact damage.
Connection may be loose but functioning as intended.', 'FAIR', 756);
INSERT INTO public.condition VALUES (3778, 'Section loss, missing or broken fasteners, cracking of the metal or impact damage but joint still functioning', 'POOR', 756);
INSERT INTO public.condition VALUES (3779, 'Metal cracking, section loss, damage or connection failure that prevents the joint from functioning as intended.', 'SEVERE', 756);
INSERT INTO public.condition VALUES (3780, NULL, 'OTHER', 756);
INSERT INTO public.condition VALUES (3781, 'Not applicable', 'GOOD', 757);
INSERT INTO public.condition VALUES (3782, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 757);
INSERT INTO public.condition VALUES (3783, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 757);
INSERT INTO public.condition VALUES (3784, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 757);
INSERT INTO public.condition VALUES (3785, NULL, 'OTHER', 757);
INSERT INTO public.condition VALUES (3786, 'No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.', 'GOOD', 758);
INSERT INTO public.condition VALUES (3787, 'Partially filled with hard- packed material, but still allowing free movement.', 'FAIR', 758);
INSERT INTO public.condition VALUES (3788, 'Completely filled and impacts joint movement.', 'POOR', 758);
INSERT INTO public.condition VALUES (3789, 'Completely filled and prevents joint movement.', 'SEVERE', 758);
INSERT INTO public.condition VALUES (3790, NULL, 'OTHER', 758);
INSERT INTO public.condition VALUES (3791, 'Sound.
No spall, delamination or unsound patch.', 'GOOD', 759);
INSERT INTO public.condition VALUES (3792, 'Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.
No exposed rebar.
Patched area that is sound.', 'FAIR', 759);
INSERT INTO public.condition VALUES (3793, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Exposed rebar.
Delamination or unsound patched area that makes the joint loose.', 'POOR', 759);
INSERT INTO public.condition VALUES (3794, 'Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.', 'SEVERE', 759);
INSERT INTO public.condition VALUES (3795, NULL, 'OTHER', 759);
INSERT INTO public.condition VALUES (3796, 'None', 'GOOD', 760);
INSERT INTO public.condition VALUES (3797, 'Freckled rust, metal has no cracks or impact damage.
Connection may be loose but functioning as intended.', 'FAIR', 760);
INSERT INTO public.condition VALUES (3798, 'Section loss, missing or broken fasteners, cracking of the metal or impact damage but joint still functioning', 'POOR', 760);
INSERT INTO public.condition VALUES (3799, 'Metal cracking, section loss, damage or connection failure that prevents the joint from functioning as intended.', 'SEVERE', 760);
INSERT INTO public.condition VALUES (3800, NULL, 'OTHER', 760);
INSERT INTO public.condition VALUES (3801, 'Not applicable', 'GOOD', 761);
INSERT INTO public.condition VALUES (3802, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 761);
INSERT INTO public.condition VALUES (3803, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 761);
INSERT INTO public.condition VALUES (3804, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 761);
INSERT INTO public.condition VALUES (3805, NULL, 'OTHER', 761);
INSERT INTO public.condition VALUES (3806, 'None', 'GOOD', 762);
INSERT INTO public.condition VALUES (3807, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 762);
INSERT INTO public.condition VALUES (3808, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 762);
INSERT INTO public.condition VALUES (3809, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 762);
INSERT INTO public.condition VALUES (3810, NULL, 'OTHER', 762);
INSERT INTO public.condition VALUES (3811, 'None', 'GOOD', 763);
INSERT INTO public.condition VALUES (3812, 'Present without measurable section loss.', 'FAIR', 763);
INSERT INTO public.condition VALUES (3813, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 763);
INSERT INTO public.condition VALUES (3878, 'Width of more than 0.5 in. wide', 'POOR', 776);
INSERT INTO public.condition VALUES (3879, 'The wearing surface is no longer effective.', 'SEVERE', 776);
INSERT INTO public.condition VALUES (3880, NULL, 'OTHER', 776);
INSERT INTO public.condition VALUES (3814, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 763);
INSERT INTO public.condition VALUES (3815, NULL, 'OTHER', 763);
INSERT INTO public.condition VALUES (3816, 'None', 'GOOD', 764);
INSERT INTO public.condition VALUES (3817, 'Present without section loss.', 'FAIR', 764);
INSERT INTO public.condition VALUES (3818, 'Present with section loss, but does not warrant structural review.', 'POOR', 764);
INSERT INTO public.condition VALUES (3819, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 764);
INSERT INTO public.condition VALUES (3820, NULL, 'OTHER', 764);
INSERT INTO public.condition VALUES (3821, 'None or insignificant cracks.', 'GOOD', 765);
INSERT INTO public.condition VALUES (3822, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.004 to 0.009 inches wide.', 'FAIR', 765);
INSERT INTO public.condition VALUES (3823, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.009 inches wide.', 'POOR', 765);
INSERT INTO public.condition VALUES (3824, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 765);
INSERT INTO public.condition VALUES (3825, NULL, 'OTHER', 765);
INSERT INTO public.condition VALUES (3826, 'No abrasion or wearing.', 'GOOD', 766);
INSERT INTO public.condition VALUES (3827, 'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.', 'FAIR', 766);
INSERT INTO public.condition VALUES (3828, 'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.', 'POOR', 766);
INSERT INTO public.condition VALUES (3829, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 766);
INSERT INTO public.condition VALUES (3830, NULL, 'OTHER', 766);
INSERT INTO public.condition VALUES (3831, 'None', 'GOOD', 767);
INSERT INTO public.condition VALUES (3832, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 767);
INSERT INTO public.condition VALUES (3833, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 767);
INSERT INTO public.condition VALUES (3834, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 767);
INSERT INTO public.condition VALUES (3835, NULL, 'OTHER', 767);
INSERT INTO public.condition VALUES (3836, 'Not applicable', 'GOOD', 768);
INSERT INTO public.condition VALUES (3837, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 768);
INSERT INTO public.condition VALUES (3838, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 768);
INSERT INTO public.condition VALUES (3839, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 768);
INSERT INTO public.condition VALUES (3840, NULL, 'OTHER', 768);
INSERT INTO public.condition VALUES (3841, 'None', 'GOOD', 769);
INSERT INTO public.condition VALUES (3842, 'Delaminated.
Spall 1 in. or less deep or 6 in. or less in diameter.
Patched area that is sound.', 'FAIR', 769);
INSERT INTO public.condition VALUES (3843, 'Spall greater than 1 in. deep or greater than 6 in. diameter.
Patched area that is unsound or showing distress.
Does not warrant structural review.', 'POOR', 769);
INSERT INTO public.condition VALUES (3844, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 769);
INSERT INTO public.condition VALUES (3845, NULL, 'OTHER', 769);
INSERT INTO public.condition VALUES (3846, 'None', 'GOOD', 770);
INSERT INTO public.condition VALUES (3847, 'Present without measurable section loss.', 'FAIR', 770);
INSERT INTO public.condition VALUES (3848, 'Present with measurable section loss, but does not warrant structural review.', 'POOR', 770);
INSERT INTO public.condition VALUES (3849, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 770);
INSERT INTO public.condition VALUES (3850, NULL, 'OTHER', 770);
INSERT INTO public.condition VALUES (3851, 'None or insignificant cracks.', 'GOOD', 771);
INSERT INTO public.condition VALUES (3852, 'Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.
Cracks from 0.012 to 0.05 inches wide.', 'FAIR', 771);
INSERT INTO public.condition VALUES (3853, 'Wide cracks or heavy pattern (map) cracking.
Cracks greater than 0.05 inches wide.', 'POOR', 771);
INSERT INTO public.condition VALUES (3854, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 771);
INSERT INTO public.condition VALUES (3855, NULL, 'OTHER', 771);
INSERT INTO public.condition VALUES (3856, 'No abrasion or wearing.', 'GOOD', 772);
INSERT INTO public.condition VALUES (3857, 'Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.', 'FAIR', 772);
INSERT INTO public.condition VALUES (3858, 'Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.', 'POOR', 772);
INSERT INTO public.condition VALUES (3859, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 772);
INSERT INTO public.condition VALUES (3860, NULL, 'OTHER', 772);
INSERT INTO public.condition VALUES (3861, 'None', 'GOOD', 773);
INSERT INTO public.condition VALUES (3862, 'Exists within tolerable limits or arrested with no observed structural distress.', 'FAIR', 773);
INSERT INTO public.condition VALUES (3863, 'Exceeds tolerable limits, but does not warrant structural review.', 'POOR', 773);
INSERT INTO public.condition VALUES (3864, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 773);
INSERT INTO public.condition VALUES (3865, NULL, 'OTHER', 773);
INSERT INTO public.condition VALUES (3866, 'Not applicable', 'GOOD', 774);
INSERT INTO public.condition VALUES (3867, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 774);
INSERT INTO public.condition VALUES (3868, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 774);
INSERT INTO public.condition VALUES (3869, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 774);
INSERT INTO public.condition VALUES (3870, NULL, 'OTHER', 774);
INSERT INTO public.condition VALUES (3871, 'None', 'GOOD', 775);
INSERT INTO public.condition VALUES (3872, 'Patched area that is sound.
Partial depth pothole.', 'FAIR', 775);
INSERT INTO public.condition VALUES (3873, 'Patched area that is unsound or showing distress.
Full depth pothole.', 'POOR', 775);
INSERT INTO public.condition VALUES (3874, 'The wearing surface is no longer effective.', 'SEVERE', 775);
INSERT INTO public.condition VALUES (3875, NULL, 'OTHER', 775);
INSERT INTO public.condition VALUES (3876, 'Sealed Cracks', 'GOOD', 776);
INSERT INTO public.condition VALUES (3881, 'Fully effective.
No evidence of leakage or further deterioration of the protected element.', 'GOOD', 777);
INSERT INTO public.condition VALUES (3882, 'Substantially effective.
Deterioration of the protected element has slowed.', 'FAIR', 777);
INSERT INTO public.condition VALUES (3883, 'Limited effectiveness.
Deterioration of the protected element has progressed.', 'POOR', 777);
INSERT INTO public.condition VALUES (3884, 'The wearing surface is no longer effective.', 'SEVERE', 777);
INSERT INTO public.condition VALUES (3885, NULL, 'OTHER', 777);
INSERT INTO public.condition VALUES (3886, 'Not applicable', 'GOOD', 778);
INSERT INTO public.condition VALUES (3887, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 778);
INSERT INTO public.condition VALUES (3888, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 778);
INSERT INTO public.condition VALUES (3889, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 778);
INSERT INTO public.condition VALUES (3890, NULL, 'OTHER', 778);
INSERT INTO public.condition VALUES (3891, 'None', 'GOOD', 779);
INSERT INTO public.condition VALUES (3892, 'Patched area that is sound.
Partial depth pothole.', 'FAIR', 779);
INSERT INTO public.condition VALUES (3893, 'Patched area that is unsound or showing distress.
Full depth pothole.', 'POOR', 779);
INSERT INTO public.condition VALUES (3894, 'The wearing surface is no longer effective.', 'SEVERE', 779);
INSERT INTO public.condition VALUES (3895, NULL, 'OTHER', 779);
INSERT INTO public.condition VALUES (3896, 'Sealed Cracks', 'GOOD', 780);
INSERT INTO public.condition VALUES (3897, 'Crack width 0.25â0.5 inches wide.', 'FAIR', 780);
INSERT INTO public.condition VALUES (3898, 'Width of more than 0.5 in. wide', 'POOR', 780);
INSERT INTO public.condition VALUES (3899, 'The wearing surface is no longer effective.', 'SEVERE', 780);
INSERT INTO public.condition VALUES (3900, NULL, 'OTHER', 780);
INSERT INTO public.condition VALUES (3901, 'Fully effective.
No evidence of leakage or further deterioration of the protected element.', 'GOOD', 781);
INSERT INTO public.condition VALUES (3902, 'Substantially effective.
Deterioration of the protected element has slowed.', 'FAIR', 781);
INSERT INTO public.condition VALUES (3903, 'Limited effectiveness.
Deterioration of the protected element has progressed.', 'POOR', 781);
INSERT INTO public.condition VALUES (3904, 'The wearing surface is no longer effective.', 'SEVERE', 781);
INSERT INTO public.condition VALUES (3905, NULL, 'OTHER', 781);
INSERT INTO public.condition VALUES (3906, 'Not applicable', 'GOOD', 782);
INSERT INTO public.condition VALUES (3907, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 782);
INSERT INTO public.condition VALUES (3908, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 782);
INSERT INTO public.condition VALUES (3909, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 782);
INSERT INTO public.condition VALUES (3910, NULL, 'OTHER', 782);
INSERT INTO public.condition VALUES (3911, 'None', 'GOOD', 783);
INSERT INTO public.condition VALUES (3912, 'Patched area that is sound.
Partial depth pothole.', 'FAIR', 783);
INSERT INTO public.condition VALUES (3913, 'Patched area that is unsound or showing distress.
Full depth pothole.', 'POOR', 783);
INSERT INTO public.condition VALUES (3914, 'The wearing surface is no longer effective.', 'SEVERE', 783);
INSERT INTO public.condition VALUES (3915, NULL, 'OTHER', 783);
INSERT INTO public.condition VALUES (3916, 'Sealed Cracks', 'GOOD', 784);
INSERT INTO public.condition VALUES (3917, 'Crack width 0.25â0.5 inches wide.', 'FAIR', 784);
INSERT INTO public.condition VALUES (3918, 'Width of more than 0.5 in. wide', 'POOR', 784);
INSERT INTO public.condition VALUES (3919, 'The wearing surface is no longer effective.', 'SEVERE', 784);
INSERT INTO public.condition VALUES (3920, NULL, 'OTHER', 784);
INSERT INTO public.condition VALUES (3921, 'Fully effective.
No evidence of leakage or further deterioration of the protected element.', 'GOOD', 785);
INSERT INTO public.condition VALUES (3922, 'Substantially effective.
Deterioration of the protected element has slowed.', 'FAIR', 785);
INSERT INTO public.condition VALUES (3923, 'Limited effectiveness.
Deterioration of the protected element has progressed.', 'POOR', 785);
INSERT INTO public.condition VALUES (3924, 'The wearing surface is no longer effective.', 'SEVERE', 785);
INSERT INTO public.condition VALUES (3925, NULL, 'OTHER', 785);
INSERT INTO public.condition VALUES (3926, 'Not applicable', 'GOOD', 786);
INSERT INTO public.condition VALUES (3927, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 786);
INSERT INTO public.condition VALUES (3928, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 786);
INSERT INTO public.condition VALUES (3929, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 786);
INSERT INTO public.condition VALUES (3930, NULL, 'OTHER', 786);
INSERT INTO public.condition VALUES (3931, 'Connection is in place and functioning as intended.', 'GOOD', 787);
INSERT INTO public.condition VALUES (3932, 'Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.', 'FAIR', 787);
INSERT INTO public.condition VALUES (3933, 'Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.', 'POOR', 787);
INSERT INTO public.condition VALUES (3934, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 787);
INSERT INTO public.condition VALUES (3935, NULL, 'OTHER', 787);
INSERT INTO public.condition VALUES (3936, 'None', 'GOOD', 788);
INSERT INTO public.condition VALUES (3937, 'Affects less than 10% of the member section.', 'FAIR', 788);
INSERT INTO public.condition VALUES (3938, 'Affects 10% or more of the member but does not warrant structural review.', 'POOR', 788);
INSERT INTO public.condition VALUES (3939, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 788);
INSERT INTO public.condition VALUES (3940, NULL, 'OTHER', 788);
INSERT INTO public.condition VALUES (3941, 'Surface penetration less than 5% of the member thickness regardless of location.', 'GOOD', 789);
INSERT INTO public.condition VALUES (3942, 'Penetrates 5% - 50% of the thickness of the member and not in a tension zone.', 'FAIR', 789);
INSERT INTO public.condition VALUES (3943, 'Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.
Does not warrant structural review.', 'POOR', 789);
INSERT INTO public.condition VALUES (3944, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 789);
INSERT INTO public.condition VALUES (3945, NULL, 'OTHER', 789);
INSERT INTO public.condition VALUES (3946, 'None', 'GOOD', 790);
INSERT INTO public.condition VALUES (3947, 'Crack that has been arrested through effective measures.', 'FAIR', 790);
INSERT INTO public.condition VALUES (3948, 'Identified crack exists that is not arrested, but does not require structural review', 'POOR', 790);
INSERT INTO public.condition VALUES (3949, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 790);
INSERT INTO public.condition VALUES (3950, NULL, 'OTHER', 790);
INSERT INTO public.condition VALUES (3951, 'None', 'GOOD', 791);
INSERT INTO public.condition VALUES (3952, 'Length less than the member depth or arrested with effective actions taken to mitigate.', 'FAIR', 791);
INSERT INTO public.condition VALUES (3953, 'Length equal to or greater than the member depth, but does not require structural review.', 'POOR', 791);
INSERT INTO public.condition VALUES (3954, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 791);
INSERT INTO public.condition VALUES (3955, NULL, 'OTHER', 791);
INSERT INTO public.condition VALUES (3956, 'None or no measurable section loss.', 'GOOD', 792);
INSERT INTO public.condition VALUES (3957, 'Section loss less than 10% of the member thickness.', 'FAIR', 792);
INSERT INTO public.condition VALUES (3958, 'Section loss 10% or more of the member thickness, but does not warrant structural review.', 'POOR', 792);
INSERT INTO public.condition VALUES (3959, 'The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.
OR
A structural review has been completed and the defects impact strength or serviceability of the element or bridge.', 'SEVERE', 792);
INSERT INTO public.condition VALUES (3960, NULL, 'OTHER', 792);
INSERT INTO public.condition VALUES (3961, 'Not applicable', 'GOOD', 793);
INSERT INTO public.condition VALUES (3962, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 793);
INSERT INTO public.condition VALUES (3963, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 793);
INSERT INTO public.condition VALUES (3964, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 793);
INSERT INTO public.condition VALUES (3965, NULL, 'OTHER', 793);
INSERT INTO public.condition VALUES (3966, 'None', 'GOOD', 794);
INSERT INTO public.condition VALUES (3967, 'Surface Dulling', 'FAIR', 794);
INSERT INTO public.condition VALUES (3968, 'Loss of Pigment', 'POOR', 794);
INSERT INTO public.condition VALUES (3969, 'Not Applicable', 'SEVERE', 794);
INSERT INTO public.condition VALUES (3970, NULL, 'OTHER', 794);
INSERT INTO public.condition VALUES (3971, 'None', 'GOOD', 795);
INSERT INTO public.condition VALUES (3972, 'Finish coats only.', 'FAIR', 795);
INSERT INTO public.condition VALUES (3973, 'Finish and primer coats', 'POOR', 795);
INSERT INTO public.condition VALUES (3974, 'Exposure of bare metal', 'SEVERE', 795);
INSERT INTO public.condition VALUES (3975, NULL, 'OTHER', 795);
INSERT INTO public.condition VALUES (3976, 'Fully effective', 'GOOD', 796);
INSERT INTO public.condition VALUES (3977, 'Substantially effective', 'FAIR', 796);
INSERT INTO public.condition VALUES (3978, 'Limited effectiveness', 'POOR', 796);
INSERT INTO public.condition VALUES (3979, 'Failed, no protection of the underlying metal', 'SEVERE', 796);
INSERT INTO public.condition VALUES (3980, NULL, 'OTHER', 796);
INSERT INTO public.condition VALUES (3981, 'Not applicable', 'GOOD', 797);
INSERT INTO public.condition VALUES (3982, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 797);
INSERT INTO public.condition VALUES (3983, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 797);
INSERT INTO public.condition VALUES (3984, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 797);
INSERT INTO public.condition VALUES (3985, NULL, 'OTHER', 797);
INSERT INTO public.condition VALUES (3986, 'None', 'GOOD', 798);
INSERT INTO public.condition VALUES (3987, 'Finish coats only.', 'FAIR', 798);
INSERT INTO public.condition VALUES (3988, 'Finish and primer coats', 'POOR', 798);
INSERT INTO public.condition VALUES (3989, 'Exposure of bare metal', 'SEVERE', 798);
INSERT INTO public.condition VALUES (3990, NULL, 'OTHER', 798);
INSERT INTO public.condition VALUES (3991, 'Yellow-orange or light brown for early development.
Chocolate-brown to purple-brown for fully developed.', 'GOOD', 799);
INSERT INTO public.condition VALUES (3992, 'Granular texture.', 'FAIR', 799);
INSERT INTO public.condition VALUES (3993, 'Small flakes, less than 1/2 in. diameter.', 'POOR', 799);
INSERT INTO public.condition VALUES (3994, 'Dark black color.', 'SEVERE', 799);
INSERT INTO public.condition VALUES (3995, NULL, 'OTHER', 799);
INSERT INTO public.condition VALUES (3996, 'Fully effective', 'GOOD', 800);
INSERT INTO public.condition VALUES (3997, 'Substantially effective', 'FAIR', 800);
INSERT INTO public.condition VALUES (3998, 'Limited effectiveness', 'POOR', 800);
INSERT INTO public.condition VALUES (3999, 'Failed, no protection of the underlying metal', 'SEVERE', 800);
INSERT INTO public.condition VALUES (4000, NULL, 'OTHER', 800);
INSERT INTO public.condition VALUES (4001, 'Not applicable', 'GOOD', 801);
INSERT INTO public.condition VALUES (4002, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 801);
INSERT INTO public.condition VALUES (4003, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 801);
INSERT INTO public.condition VALUES (4004, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 801);
INSERT INTO public.condition VALUES (4005, NULL, 'OTHER', 801);
INSERT INTO public.condition VALUES (4006, 'None', 'GOOD', 802);
INSERT INTO public.condition VALUES (4007, 'Finish coats only.', 'FAIR', 802);
INSERT INTO public.condition VALUES (4008, 'Finish and primer coats', 'POOR', 802);
INSERT INTO public.condition VALUES (4009, 'Exposure of bare metal', 'SEVERE', 802);
INSERT INTO public.condition VALUES (4010, NULL, 'OTHER', 802);
INSERT INTO public.condition VALUES (4011, 'Yellow-orange or light brown for early development.
Chocolate-brown to purple-brown for fully developed.', 'GOOD', 803);
INSERT INTO public.condition VALUES (4012, 'Granular texture.', 'FAIR', 803);
INSERT INTO public.condition VALUES (4013, 'Small flakes, less than 1/2 in. diameter.', 'POOR', 803);
INSERT INTO public.condition VALUES (4014, 'Dark black color.', 'SEVERE', 803);
INSERT INTO public.condition VALUES (4015, NULL, 'OTHER', 803);
INSERT INTO public.condition VALUES (4016, 'Fully effective', 'GOOD', 804);
INSERT INTO public.condition VALUES (4017, 'Substantially effective', 'FAIR', 804);
INSERT INTO public.condition VALUES (4018, 'Limited effectiveness', 'POOR', 804);
INSERT INTO public.condition VALUES (4019, 'Failed, no protection of the underlying metal', 'SEVERE', 804);
INSERT INTO public.condition VALUES (4020, NULL, 'OTHER', 804);
INSERT INTO public.condition VALUES (4021, 'Not applicable', 'GOOD', 805);
INSERT INTO public.condition VALUES (4022, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 805);
INSERT INTO public.condition VALUES (4023, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 805);
INSERT INTO public.condition VALUES (4024, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 805);
INSERT INTO public.condition VALUES (4025, NULL, 'OTHER', 805);
INSERT INTO public.condition VALUES (4026, 'Fully effective', 'GOOD', 806);
INSERT INTO public.condition VALUES (4027, 'Substantially effective', 'FAIR', 806);
INSERT INTO public.condition VALUES (4028, 'Limited effectiveness', 'POOR', 806);
INSERT INTO public.condition VALUES (4029, 'The protective system has failed or is no longer effective.', 'SEVERE', 806);
INSERT INTO public.condition VALUES (4030, NULL, 'OTHER', 806);
INSERT INTO public.condition VALUES (4031, 'Not applicable', 'GOOD', 807);
INSERT INTO public.condition VALUES (4032, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 807);
INSERT INTO public.condition VALUES (4033, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 807);
INSERT INTO public.condition VALUES (4034, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 807);
INSERT INTO public.condition VALUES (4035, NULL, 'OTHER', 807);
INSERT INTO public.condition VALUES (4036, 'None', 'GOOD', 808);
INSERT INTO public.condition VALUES (4037, 'Underlying concrete not exposed.
Coating showing wear from UV exposure.
Friction course missing', 'FAIR', 808);
INSERT INTO public.condition VALUES (4038, 'Underlying concrete is not exposed.
Thickness of the coating is reduced.', 'POOR', 808);
INSERT INTO public.condition VALUES (4039, 'Underlying concrete exposed.
Protective coating no longer effective', 'SEVERE', 808);
INSERT INTO public.condition VALUES (4040, NULL, 'OTHER', 808);
INSERT INTO public.condition VALUES (4041, 'Fully effective', 'GOOD', 809);
INSERT INTO public.condition VALUES (4042, 'Substantially effective', 'FAIR', 809);
INSERT INTO public.condition VALUES (4043, 'Limited effectiveness', 'POOR', 809);
INSERT INTO public.condition VALUES (4044, 'The protective system has failed or is no longer effective.', 'SEVERE', 809);
INSERT INTO public.condition VALUES (4045, NULL, 'OTHER', 809);
INSERT INTO public.condition VALUES (4046, 'Not applicable', 'GOOD', 810);
INSERT INTO public.condition VALUES (4047, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 810);
INSERT INTO public.condition VALUES (4048, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 810);
INSERT INTO public.condition VALUES (4049, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 810);
INSERT INTO public.condition VALUES (4050, NULL, 'OTHER', 810);
INSERT INTO public.condition VALUES (4051, 'None', 'GOOD', 811);
INSERT INTO public.condition VALUES (4052, 'Underlying concrete not exposed.
Coating showing wear from UV exposure.
Friction course missing', 'FAIR', 811);
INSERT INTO public.condition VALUES (4053, 'Underlying concrete is not exposed.
Thickness of the coating is reduced.', 'POOR', 811);
INSERT INTO public.condition VALUES (4054, 'Underlying concrete exposed.
Protective coating no longer effective', 'SEVERE', 811);
INSERT INTO public.condition VALUES (4055, NULL, 'OTHER', 811);
INSERT INTO public.condition VALUES (4056, 'Fully effective', 'GOOD', 812);
INSERT INTO public.condition VALUES (4057, 'Substantially effective', 'FAIR', 812);
INSERT INTO public.condition VALUES (4058, 'Limited effectiveness', 'POOR', 812);
INSERT INTO public.condition VALUES (4059, 'The protective system has failed or is no longer effective.', 'SEVERE', 812);
INSERT INTO public.condition VALUES (4060, NULL, 'OTHER', 812);
INSERT INTO public.condition VALUES (4061, 'Not applicable', 'GOOD', 813);
INSERT INTO public.condition VALUES (4062, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.', 'FAIR', 813);
INSERT INTO public.condition VALUES (4063, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.', 'POOR', 813);
INSERT INTO public.condition VALUES (4064, 'The element has impact damage.
The specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.', 'SEVERE', 813);
INSERT INTO public.condition VALUES (4065, NULL, 'OTHER', 813);


--
-- Data for Name: defect; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.defect VALUES (1, 'Delamination/ Spall/ Patched Area', 1080, 1);
INSERT INTO public.defect VALUES (2, 'Exposed Rebar', 1090, 1);
INSERT INTO public.defect VALUES (3, 'Efflorescence/ Rust Staining', 1120, 1);
INSERT INTO public.defect VALUES (4, 'Cracking (RC and Other)', 1130, 1);
INSERT INTO public.defect VALUES (5, 'Abrasion/Wear (PSC/RC)', 1190, 1);
INSERT INTO public.defect VALUES (6, 'Damage', 7000, 1);
INSERT INTO public.defect VALUES (7, 'Delamination/ Spall/ Patched Area', 1080, 2);
INSERT INTO public.defect VALUES (8, 'Exposed Rebar', 1090, 2);
INSERT INTO public.defect VALUES (9, 'Exposed Prestressing', 1100, 2);
INSERT INTO public.defect VALUES (10, 'Cracking (PSC)', 1110, 2);
INSERT INTO public.defect VALUES (11, 'Efflorescence/ Rust Staining', 1120, 2);
INSERT INTO public.defect VALUES (12, 'Abrasion/Wear (PSC/RC)', 1190, 2);
INSERT INTO public.defect VALUES (13, 'Damage', 7000, 2);
INSERT INTO public.defect VALUES (14, 'Delamination/ Spall/ Patched Area', 1080, 3);
INSERT INTO public.defect VALUES (15, 'Exposed Rebar', 1090, 3);
INSERT INTO public.defect VALUES (16, 'Exposed Prestressing', 1100, 3);
INSERT INTO public.defect VALUES (17, 'Cracking (PSC)', 1110, 3);
INSERT INTO public.defect VALUES (18, 'Efflorescence/ Rust Staining', 1120, 3);
INSERT INTO public.defect VALUES (19, 'Abrasion/Wear (PSC/RC)', 1190, 3);
INSERT INTO public.defect VALUES (20, 'Damage', 7000, 3);
INSERT INTO public.defect VALUES (21, 'Delamination/ Spall/ Patched Area', 1080, 4);
INSERT INTO public.defect VALUES (22, 'Exposed Rebar', 1090, 4);
INSERT INTO public.defect VALUES (23, 'Efflorescence/ Rust Staining', 1120, 4);
INSERT INTO public.defect VALUES (24, 'Cracking (RC and Other)', 1130, 4);
INSERT INTO public.defect VALUES (25, 'Abrasion/Wear (PSC/RC)', 1190, 4);
INSERT INTO public.defect VALUES (26, 'Damage', 7000, 4);
INSERT INTO public.defect VALUES (27, 'Corrosion', 1000, 5);
INSERT INTO public.defect VALUES (28, 'Fatigue Crack (Steel/Other)', 1010, 5);
INSERT INTO public.defect VALUES (29, 'Connection', 1020, 5);
INSERT INTO public.defect VALUES (30, 'Damage', 7000, 5);
INSERT INTO public.defect VALUES (31, 'Corrosion', 1000, 6);
INSERT INTO public.defect VALUES (32, 'Fatigue Crack (Steel/Other)', 1010, 6);
INSERT INTO public.defect VALUES (33, 'Connection', 1020, 6);
INSERT INTO public.defect VALUES (34, 'Damage', 7000, 6);
INSERT INTO public.defect VALUES (35, 'Corrosion', 1000, 7);
INSERT INTO public.defect VALUES (36, 'Fatigue Crack (Steel/Other)', 1010, 7);
INSERT INTO public.defect VALUES (37, 'Connection', 1020, 7);
INSERT INTO public.defect VALUES (38, 'Damage', 7000, 7);
INSERT INTO public.defect VALUES (39, 'Connection', 1020, 8);
INSERT INTO public.defect VALUES (40, 'Decay/Section Loss', 1140, 8);
INSERT INTO public.defect VALUES (41, 'Check/Shake', 1150, 8);
INSERT INTO public.defect VALUES (42, 'Crack (Timber)', 1160, 8);
INSERT INTO public.defect VALUES (43, 'Split/Delamination (Timber)', 1170, 8);
INSERT INTO public.defect VALUES (44, 'Abrasion/Wear (Timber)', 1180, 8);
INSERT INTO public.defect VALUES (45, 'Damage', 7000, 8);
INSERT INTO public.defect VALUES (46, 'Delamination/ Spall/ Patched Area', 1080, 9);
INSERT INTO public.defect VALUES (47, 'Exposed Rebar', 1090, 9);
INSERT INTO public.defect VALUES (48, 'Efflorescence/ Rust Staining', 1120, 9);
INSERT INTO public.defect VALUES (49, 'Cracking (RC and Other)', 1130, 9);
INSERT INTO public.defect VALUES (50, 'Abrasion/Wear (PSC/RC)', 1190, 9);
INSERT INTO public.defect VALUES (51, 'Damage', 7000, 9);
INSERT INTO public.defect VALUES (52, 'Delamination/ Spall/ Patched Area', 1080, 10);
INSERT INTO public.defect VALUES (53, 'Exposed Rebar', 1090, 10);
INSERT INTO public.defect VALUES (54, 'Exposed Prestressing', 1100, 10);
INSERT INTO public.defect VALUES (55, 'Cracking (PSC)', 1110, 10);
INSERT INTO public.defect VALUES (56, 'Efflorescence/ Rust Staining', 1120, 10);
INSERT INTO public.defect VALUES (57, 'Abrasion/Wear (PSC/RC)', 1190, 10);
INSERT INTO public.defect VALUES (58, 'Damage', 7000, 10);
INSERT INTO public.defect VALUES (59, 'Connection', 1020, 11);
INSERT INTO public.defect VALUES (60, 'Decay/Section Loss', 1140, 11);
INSERT INTO public.defect VALUES (61, 'Check/Shake', 1150, 11);
INSERT INTO public.defect VALUES (62, 'Crack (Timber)', 1160, 11);
INSERT INTO public.defect VALUES (63, 'Split/Delamination (Timber)', 1170, 11);
INSERT INTO public.defect VALUES (64, 'Abrasion/Wear (Timber)', 1180, 11);
INSERT INTO public.defect VALUES (65, 'Damage', 7000, 11);
INSERT INTO public.defect VALUES (66, 'Corrosion', 1000, 12);
INSERT INTO public.defect VALUES (67, 'Fatigue Crack (Steel/Other)', 1010, 12);
INSERT INTO public.defect VALUES (68, 'Connection', 1020, 12);
INSERT INTO public.defect VALUES (69, 'Cracking (RC and Other)', 1130, 12);
INSERT INTO public.defect VALUES (70, 'Delamination/ Spall/ Patched Area', 1080, 12);
INSERT INTO public.defect VALUES (71, 'Efflorescence/ Rust Staining', 1120, 12);
INSERT INTO public.defect VALUES (72, 'Deterioration (Other)', 1220, 12);
INSERT INTO public.defect VALUES (73, 'Damage', 7000, 12);
INSERT INTO public.defect VALUES (74, 'Corrosion', 1000, 13);
INSERT INTO public.defect VALUES (75, 'Fatigue Crack (Steel/Other)', 1010, 13);
INSERT INTO public.defect VALUES (76, 'Connection', 1020, 13);
INSERT INTO public.defect VALUES (77, 'Delamination/ Spall/ Patched Area', 1080, 13);
INSERT INTO public.defect VALUES (78, 'Cracking (RC and Other)', 1130, 13);
INSERT INTO public.defect VALUES (79, 'Deterioration (Other)', 1220, 13);
INSERT INTO public.defect VALUES (80, 'Efflorescence/ Rust Staining', 1120, 13);
INSERT INTO public.defect VALUES (81, 'Damage', 7000, 13);
INSERT INTO public.defect VALUES (82, 'Corrosion', 1000, 14);
INSERT INTO public.defect VALUES (83, 'Fatigue Crack (Steel/Other)', 1010, 14);
INSERT INTO public.defect VALUES (84, 'Connection', 1020, 14);
INSERT INTO public.defect VALUES (85, 'Distortion', 1900, 14);
INSERT INTO public.defect VALUES (86, 'Damage', 7000, 14);
INSERT INTO public.defect VALUES (87, 'Delamination/ Spall/ Patched Area', 1080, 15);
INSERT INTO public.defect VALUES (88, 'Exposed Rebar', 1090, 15);
INSERT INTO public.defect VALUES (89, 'Efflorescence/ Rust Staining', 1120, 15);
INSERT INTO public.defect VALUES (90, 'Cracking (RC and Other)', 1130, 15);
INSERT INTO public.defect VALUES (91, 'Abrasion/Wear (PSC/RC)', 1190, 15);
INSERT INTO public.defect VALUES (92, 'Damage', 7000, 15);
INSERT INTO public.defect VALUES (93, 'Connection', 1020, 16);
INSERT INTO public.defect VALUES (94, 'Decay/Section Loss', 1140, 16);
INSERT INTO public.defect VALUES (95, 'Check/Shake', 1150, 16);
INSERT INTO public.defect VALUES (96, 'Crack (Timber)', 1160, 16);
INSERT INTO public.defect VALUES (97, 'Split/Delamination (Timber)', 1170, 16);
INSERT INTO public.defect VALUES (98, 'Abrasion/Wear (Timber)', 1180, 16);
INSERT INTO public.defect VALUES (99, 'Damage', 7000, 16);
INSERT INTO public.defect VALUES (100, 'Corrosion', 1000, 17);
INSERT INTO public.defect VALUES (101, 'Fatigue Crack (Steel/Other)', 1010, 17);
INSERT INTO public.defect VALUES (102, 'Connection', 1020, 17);
INSERT INTO public.defect VALUES (103, 'Efflorescence/ Rust Staining', 1120, 17);
INSERT INTO public.defect VALUES (104, 'Cracking (RC and Other)', 1130, 17);
INSERT INTO public.defect VALUES (105, 'Abrasion/Wear (PSC/RC)', 1190, 17);
INSERT INTO public.defect VALUES (106, 'Delamination/ Spall/ Patched Area', 1080, 17);
INSERT INTO public.defect VALUES (107, 'Exposed Rebar', 1090, 17);
INSERT INTO public.defect VALUES (108, 'Deterioration (Other)', 1220, 17);
INSERT INTO public.defect VALUES (109, 'Distortion', 1900, 17);
INSERT INTO public.defect VALUES (110, 'Damage', 7000, 17);
INSERT INTO public.defect VALUES (111, 'Efflorescence/ Rust Staining', 1120, 18);
INSERT INTO public.defect VALUES (112, 'Mortar Breakdown (Masonry)', 1610, 18);
INSERT INTO public.defect VALUES (113, 'Delamination/ Spall/ Patched Area', 1080, 18);
INSERT INTO public.defect VALUES (114, 'Split/Spall (Masonry)', 1620, 18);
INSERT INTO public.defect VALUES (115, 'Patched Area (Masonry)', 1630, 18);
INSERT INTO public.defect VALUES (116, 'Masonry Displacement', 1640, 18);
INSERT INTO public.defect VALUES (117, 'Distortion', 1900, 18);
INSERT INTO public.defect VALUES (118, 'Damage', 7000, 18);
INSERT INTO public.defect VALUES (119, 'Corrosion', 1000, 19);
INSERT INTO public.defect VALUES (120, 'Fatigue Crack (Steel/Other)', 1010, 19);
INSERT INTO public.defect VALUES (121, 'Connection', 1020, 19);
INSERT INTO public.defect VALUES (122, 'Distortion', 1900, 19);
INSERT INTO public.defect VALUES (123, 'Damage', 7000, 19);
INSERT INTO public.defect VALUES (124, 'Delamination/ Spall/ Patched Area', 1080, 20);
INSERT INTO public.defect VALUES (125, 'Exposed Rebar', 1090, 20);
INSERT INTO public.defect VALUES (126, 'Exposed Prestressing', 1100, 20);
INSERT INTO public.defect VALUES (127, 'Cracking (PSC)', 1110, 20);
INSERT INTO public.defect VALUES (128, 'Efflorescence/ Rust Staining', 1120, 20);
INSERT INTO public.defect VALUES (129, 'Damage', 7000, 20);
INSERT INTO public.defect VALUES (130, 'Delamination/ Spall/ Patched Area', 1080, 21);
INSERT INTO public.defect VALUES (131, 'Exposed Rebar', 1090, 21);
INSERT INTO public.defect VALUES (132, 'Efflorescence/ Rust Staining', 1120, 21);
INSERT INTO public.defect VALUES (133, 'Cracking (RC and Other)', 1130, 21);
INSERT INTO public.defect VALUES (134, 'Damage', 7000, 21);
INSERT INTO public.defect VALUES (135, 'Corrosion', 1000, 22);
INSERT INTO public.defect VALUES (136, 'Fatigue Crack (Steel/Other)', 1010, 22);
INSERT INTO public.defect VALUES (137, 'Connection', 1020, 22);
INSERT INTO public.defect VALUES (138, 'Delamination/ Spall/ Patched Area', 1080, 22);
INSERT INTO public.defect VALUES (139, 'Efflorescence/ Rust Staining', 1120, 22);
INSERT INTO public.defect VALUES (140, 'Cracking (RC and Other)', 1130, 22);
INSERT INTO public.defect VALUES (141, 'Deterioration (Other)', 1220, 22);
INSERT INTO public.defect VALUES (142, 'Distortion', 1900, 22);
INSERT INTO public.defect VALUES (143, 'Damage', 7000, 22);
INSERT INTO public.defect VALUES (144, 'Corrosion', 1000, 23);
INSERT INTO public.defect VALUES (145, 'Fatigue Crack (Steel/Other)', 1010, 23);
INSERT INTO public.defect VALUES (146, 'Connection', 1020, 23);
INSERT INTO public.defect VALUES (147, 'Distortion', 1900, 23);
INSERT INTO public.defect VALUES (148, 'Damage', 7000, 23);
INSERT INTO public.defect VALUES (149, 'Delamination/ Spall/ Patched Area', 1080, 24);
INSERT INTO public.defect VALUES (150, 'Exposed Rebar', 1090, 24);
INSERT INTO public.defect VALUES (151, 'Exposed Prestressing', 1100, 24);
INSERT INTO public.defect VALUES (152, 'Cracking (PSC)', 1110, 24);
INSERT INTO public.defect VALUES (153, 'Efflorescence/ Rust Staining', 1120, 24);
INSERT INTO public.defect VALUES (154, 'Damage', 7000, 24);
INSERT INTO public.defect VALUES (155, 'Delamination/ Spall/ Patched Area', 1080, 25);
INSERT INTO public.defect VALUES (156, 'Exposed Rebar', 1090, 25);
INSERT INTO public.defect VALUES (157, 'Efflorescence/ Rust Staining', 1120, 25);
INSERT INTO public.defect VALUES (158, 'Cracking (RC and Other)', 1130, 25);
INSERT INTO public.defect VALUES (159, 'Damage', 7000, 25);
INSERT INTO public.defect VALUES (160, 'Connection', 1020, 26);
INSERT INTO public.defect VALUES (161, 'Decay/Section Loss', 1140, 26);
INSERT INTO public.defect VALUES (162, 'Check/Shake', 1150, 26);
INSERT INTO public.defect VALUES (163, 'Crack (Timber)', 1160, 26);
INSERT INTO public.defect VALUES (164, 'Split/Delamination (Timber)', 1170, 26);
INSERT INTO public.defect VALUES (165, 'Abrasion/Wear (Timber)', 1180, 26);
INSERT INTO public.defect VALUES (166, 'Damage', 7000, 26);
INSERT INTO public.defect VALUES (167, 'Corrosion', 1000, 27);
INSERT INTO public.defect VALUES (168, 'Fatigue Crack (Steel/Other)', 1010, 27);
INSERT INTO public.defect VALUES (169, 'Connection', 1020, 27);
INSERT INTO public.defect VALUES (170, 'Delamination/ Spall/ Patched Area', 1080, 27);
INSERT INTO public.defect VALUES (171, 'Efflorescence/ Rust Staining', 1120, 27);
INSERT INTO public.defect VALUES (172, 'Cracking (RC and Other)', 1130, 27);
INSERT INTO public.defect VALUES (173, 'Deterioration (Other)', 1220, 27);
INSERT INTO public.defect VALUES (174, 'Distortion', 1900, 27);
INSERT INTO public.defect VALUES (175, 'Damage', 7000, 27);
INSERT INTO public.defect VALUES (176, 'Corrosion', 1000, 28);
INSERT INTO public.defect VALUES (177, 'Fatigue Crack (Steel/Other)', 1010, 28);
INSERT INTO public.defect VALUES (178, 'Connection', 1020, 28);
INSERT INTO public.defect VALUES (179, 'Distortion', 1900, 28);
INSERT INTO public.defect VALUES (180, 'Damage', 7000, 28);
INSERT INTO public.defect VALUES (181, 'Connection', 1020, 29);
INSERT INTO public.defect VALUES (182, 'Decay/Section Loss', 1140, 29);
INSERT INTO public.defect VALUES (183, 'Check/Shake', 1150, 29);
INSERT INTO public.defect VALUES (184, 'Crack (Timber)', 1160, 29);
INSERT INTO public.defect VALUES (185, 'Split/Delamination (Timber)', 1170, 29);
INSERT INTO public.defect VALUES (186, 'Abrasion/Wear (Timber)', 1180, 29);
INSERT INTO public.defect VALUES (187, 'Damage', 7000, 29);
INSERT INTO public.defect VALUES (188, 'Corrosion', 1000, 30);
INSERT INTO public.defect VALUES (189, 'Fatigue Crack (Steel/Other)', 1010, 30);
INSERT INTO public.defect VALUES (190, 'Connection', 1020, 30);
INSERT INTO public.defect VALUES (191, 'Delamination/ Spall/ Patched Area', 1080, 30);
INSERT INTO public.defect VALUES (192, 'Efflorescence/ Rust Staining', 1120, 30);
INSERT INTO public.defect VALUES (193, 'Cracking (RC and Other)', 1130, 30);
INSERT INTO public.defect VALUES (194, 'Deterioration (Other)', 1220, 30);
INSERT INTO public.defect VALUES (195, 'Distortion', 1900, 30);
INSERT INTO public.defect VALUES (196, 'Damage', 7000, 30);
INSERT INTO public.defect VALUES (197, 'Corrosion', 1000, 31);
INSERT INTO public.defect VALUES (198, 'Fatigue Crack (Steel/Other)', 1010, 31);
INSERT INTO public.defect VALUES (199, 'Connection', 1020, 31);
INSERT INTO public.defect VALUES (200, 'Distortion', 1900, 31);
INSERT INTO public.defect VALUES (201, 'Damage', 7000, 31);
INSERT INTO public.defect VALUES (202, 'Corrosion', 1000, 32);
INSERT INTO public.defect VALUES (203, 'Fatigue Crack (Steel/Other)', 1010, 32);
INSERT INTO public.defect VALUES (204, 'Connection', 1020, 32);
INSERT INTO public.defect VALUES (205, 'Cracking (RC and Other)', 1130, 32);
INSERT INTO public.defect VALUES (206, 'Deterioration (Other)', 1220, 32);
INSERT INTO public.defect VALUES (207, 'Distortion', 1900, 32);
INSERT INTO public.defect VALUES (208, 'Delamination/ Spall/ Patched Area', 1080, 32);
INSERT INTO public.defect VALUES (209, 'Efflorescence/ Rust Staining', 1120, 32);
INSERT INTO public.defect VALUES (210, 'Damage', 7000, 32);
INSERT INTO public.defect VALUES (211, 'Delamination/ Spall/ Patched Area', 1080, 33);
INSERT INTO public.defect VALUES (212, 'Exposed Rebar', 1090, 33);
INSERT INTO public.defect VALUES (213, 'Exposed Prestressing', 1100, 33);
INSERT INTO public.defect VALUES (214, 'Cracking (PSC)', 1110, 33);
INSERT INTO public.defect VALUES (215, 'Efflorescence/ Rust Staining', 1120, 33);
INSERT INTO public.defect VALUES (216, 'Abrasion/Wear (PSC/RC)', 1190, 33);
INSERT INTO public.defect VALUES (217, 'Damage', 7000, 33);
INSERT INTO public.defect VALUES (218, 'Delamination/ Spall/ Patched Area', 1080, 34);
INSERT INTO public.defect VALUES (219, 'Exposed Rebar', 1090, 34);
INSERT INTO public.defect VALUES (220, 'Efflorescence/ Rust Staining', 1120, 34);
INSERT INTO public.defect VALUES (221, 'Cracking (RC and Other)', 1130, 34);
INSERT INTO public.defect VALUES (222, 'Abrasion/Wear (PSC/RC)', 1190, 34);
INSERT INTO public.defect VALUES (223, 'Damage', 7000, 34);
INSERT INTO public.defect VALUES (224, 'Efflorescence/ Rust Staining', 1120, 35);
INSERT INTO public.defect VALUES (225, 'Mortar Breakdown (Masonry)', 1610, 35);
INSERT INTO public.defect VALUES (226, 'Split/Spall (Masonry)', 1620, 35);
INSERT INTO public.defect VALUES (227, 'Patched Area (Masonry)', 1630, 35);
INSERT INTO public.defect VALUES (228, 'Masonry Displacement', 1640, 35);
INSERT INTO public.defect VALUES (229, 'Damage', 7000, 35);
INSERT INTO public.defect VALUES (230, 'Connection', 1020, 36);
INSERT INTO public.defect VALUES (231, 'Decay/Section Loss', 1140, 36);
INSERT INTO public.defect VALUES (232, 'Check/Shake', 1150, 36);
INSERT INTO public.defect VALUES (233, 'Crack (Timber)', 1160, 36);
INSERT INTO public.defect VALUES (234, 'Split/Delamination (Timber)', 1170, 36);
INSERT INTO public.defect VALUES (235, 'Abrasion/Wear (Timber)', 1180, 36);
INSERT INTO public.defect VALUES (236, 'Damage', 7000, 36);
INSERT INTO public.defect VALUES (237, 'Corrosion', 1000, 37);
INSERT INTO public.defect VALUES (238, 'Fatigue Crack (Steel/Other)', 1010, 37);
INSERT INTO public.defect VALUES (239, 'Connection', 1020, 37);
INSERT INTO public.defect VALUES (240, 'Distortion', 1900, 37);
INSERT INTO public.defect VALUES (241, 'Damage', 7000, 37);
INSERT INTO public.defect VALUES (242, 'Delamination/ Spall/ Patched Area', 1080, 38);
INSERT INTO public.defect VALUES (243, 'Exposed Rebar', 1090, 38);
INSERT INTO public.defect VALUES (244, 'Exposed Prestressing', 1100, 38);
INSERT INTO public.defect VALUES (245, 'Cracking (PSC)', 1110, 38);
INSERT INTO public.defect VALUES (246, 'Efflorescence/ Rust Staining', 1120, 38);
INSERT INTO public.defect VALUES (247, 'Damage', 7000, 38);
INSERT INTO public.defect VALUES (248, 'Delamination/ Spall/ Patched Area', 1080, 39);
INSERT INTO public.defect VALUES (249, 'Exposed Rebar', 1090, 39);
INSERT INTO public.defect VALUES (250, 'Efflorescence/ Rust Staining', 1120, 39);
INSERT INTO public.defect VALUES (251, 'Cracking (RC and Other)', 1130, 39);
INSERT INTO public.defect VALUES (252, 'Damage', 7000, 39);
INSERT INTO public.defect VALUES (253, 'Connection', 1020, 40);
INSERT INTO public.defect VALUES (254, 'Decay/Section Loss', 1140, 40);
INSERT INTO public.defect VALUES (255, 'Check/Shake', 1150, 40);
INSERT INTO public.defect VALUES (256, 'Crack (Timber)', 1160, 40);
INSERT INTO public.defect VALUES (257, 'Split/Delamination (Timber)', 1170, 40);
INSERT INTO public.defect VALUES (258, 'Abrasion/Wear (Timber)', 1180, 40);
INSERT INTO public.defect VALUES (259, 'Damage', 7000, 40);
INSERT INTO public.defect VALUES (260, 'Corrosion', 1000, 41);
INSERT INTO public.defect VALUES (261, 'Fatigue Crack (Steel/Other)', 1010, 41);
INSERT INTO public.defect VALUES (262, 'Connection', 1020, 41);
INSERT INTO public.defect VALUES (263, 'Delamination/ Spall/ Patched Area', 1080, 41);
INSERT INTO public.defect VALUES (264, 'Efflorescence/ Rust Staining', 1120, 41);
INSERT INTO public.defect VALUES (265, 'Cracking (RC and Other)', 1130, 41);
INSERT INTO public.defect VALUES (266, 'Deterioration (Other)', 1220, 41);
INSERT INTO public.defect VALUES (267, 'Distortion', 1900, 41);
INSERT INTO public.defect VALUES (268, 'Damage', 7000, 41);
INSERT INTO public.defect VALUES (269, 'Corrosion', 1000, 42);
INSERT INTO public.defect VALUES (270, 'Fatigue Crack (Steel/Other)', 1010, 42);
INSERT INTO public.defect VALUES (271, 'Connection', 1020, 42);
INSERT INTO public.defect VALUES (272, 'Distortion', 1900, 42);
INSERT INTO public.defect VALUES (273, 'Damage', 7000, 42);
INSERT INTO public.defect VALUES (274, 'Delamination/ Spall/ Patched Area', 1080, 43);
INSERT INTO public.defect VALUES (275, 'Exposed Rebar', 1090, 43);
INSERT INTO public.defect VALUES (276, 'Exposed Prestressing', 1100, 43);
INSERT INTO public.defect VALUES (277, 'Cracking (PSC)', 1110, 43);
INSERT INTO public.defect VALUES (278, 'Efflorescence/ Rust Staining', 1120, 43);
INSERT INTO public.defect VALUES (279, 'Damage', 7000, 43);
INSERT INTO public.defect VALUES (280, 'Delamination/ Spall/ Patched Area', 1080, 44);
INSERT INTO public.defect VALUES (281, 'Exposed Rebar', 1090, 44);
INSERT INTO public.defect VALUES (282, 'Efflorescence/ Rust Staining', 1120, 44);
INSERT INTO public.defect VALUES (283, 'Cracking (RC and Other)', 1130, 44);
INSERT INTO public.defect VALUES (284, 'Damage', 7000, 44);
INSERT INTO public.defect VALUES (285, 'Connection', 1020, 45);
INSERT INTO public.defect VALUES (286, 'Decay/Section Loss', 1140, 45);
INSERT INTO public.defect VALUES (287, 'Check/Shake', 1150, 45);
INSERT INTO public.defect VALUES (288, 'Crack (Timber)', 1160, 45);
INSERT INTO public.defect VALUES (289, 'Split/Delamination (Timber)', 1170, 45);
INSERT INTO public.defect VALUES (290, 'Abrasion/Wear (Timber)', 1180, 45);
INSERT INTO public.defect VALUES (291, 'Damage', 7000, 45);
INSERT INTO public.defect VALUES (292, 'Corrosion', 1000, 46);
INSERT INTO public.defect VALUES (293, 'Fatigue Crack (Steel/Other)', 1010, 46);
INSERT INTO public.defect VALUES (294, 'Connection', 1020, 46);
INSERT INTO public.defect VALUES (295, 'Delamination/ Spall/ Patched Area', 1080, 46);
INSERT INTO public.defect VALUES (296, 'Efflorescence/ Rust Staining', 1120, 46);
INSERT INTO public.defect VALUES (297, 'Cracking (RC and Other)', 1130, 46);
INSERT INTO public.defect VALUES (298, 'Deterioration (Other)', 1220, 46);
INSERT INTO public.defect VALUES (299, 'Distortion', 1900, 46);
INSERT INTO public.defect VALUES (300, 'Damage', 7000, 46);
INSERT INTO public.defect VALUES (301, 'Corrosion', 1000, 47);
INSERT INTO public.defect VALUES (302, 'Fatigue Crack (Steel/Other)', 1010, 47);
INSERT INTO public.defect VALUES (303, 'Connection', 1020, 47);
INSERT INTO public.defect VALUES (304, 'Distortion', 1900, 47);
INSERT INTO public.defect VALUES (305, 'Damage', 7000, 47);
INSERT INTO public.defect VALUES (306, 'Corrosion', 1000, 48);
INSERT INTO public.defect VALUES (307, 'Fatigue Crack (Steel/Other)', 1010, 48);
INSERT INTO public.defect VALUES (308, 'Connection', 1020, 48);
INSERT INTO public.defect VALUES (309, 'Distortion', 1900, 48);
INSERT INTO public.defect VALUES (310, 'Damage', 7000, 48);
INSERT INTO public.defect VALUES (311, 'Corrosion', 1000, 49);
INSERT INTO public.defect VALUES (312, 'Fatigue Crack (Steel/Other)', 1010, 49);
INSERT INTO public.defect VALUES (313, 'Connection', 1020, 49);
INSERT INTO public.defect VALUES (314, 'Deterioration (Other)', 1220, 49);
INSERT INTO public.defect VALUES (315, 'Distortion', 1900, 49);
INSERT INTO public.defect VALUES (316, 'Damage', 7000, 49);
INSERT INTO public.defect VALUES (317, 'Corrosion', 1000, 50);
INSERT INTO public.defect VALUES (318, 'Fatigue Crack (Steel/Other)', 1010, 50);
INSERT INTO public.defect VALUES (319, 'Connection', 1020, 50);
INSERT INTO public.defect VALUES (320, 'Distortion', 1900, 50);
INSERT INTO public.defect VALUES (321, 'Damage', 7000, 50);
INSERT INTO public.defect VALUES (322, 'Corrosion', 1000, 51);
INSERT INTO public.defect VALUES (323, 'Fatigue Crack (Steel/Other)', 1010, 51);
INSERT INTO public.defect VALUES (324, 'Connection', 1020, 51);
INSERT INTO public.defect VALUES (325, 'Distortion', 1900, 51);
INSERT INTO public.defect VALUES (326, 'Damage', 7000, 51);
INSERT INTO public.defect VALUES (327, 'Corrosion', 1000, 52);
INSERT INTO public.defect VALUES (328, 'Fatigue Crack (Steel/Other)', 1010, 52);
INSERT INTO public.defect VALUES (329, 'Connection', 1020, 52);
INSERT INTO public.defect VALUES (330, 'Distortion', 1900, 52);
INSERT INTO public.defect VALUES (331, 'Damage', 7000, 52);
INSERT INTO public.defect VALUES (332, 'Corrosion', 1000, 53);
INSERT INTO public.defect VALUES (333, 'Fatigue Crack (Steel/Other)', 1010, 53);
INSERT INTO public.defect VALUES (334, 'Connection', 1020, 53);
INSERT INTO public.defect VALUES (335, 'Distortion', 1900, 53);
INSERT INTO public.defect VALUES (336, 'Damage', 7000, 53);
INSERT INTO public.defect VALUES (337, 'Corrosion', 1000, 54);
INSERT INTO public.defect VALUES (338, 'Fatigue Crack (Steel/Other)', 1010, 54);
INSERT INTO public.defect VALUES (339, 'Connection', 1020, 54);
INSERT INTO public.defect VALUES (340, 'Distortion', 1900, 54);
INSERT INTO public.defect VALUES (341, 'Cable Slack', 1025, 54);
INSERT INTO public.defect VALUES (342, 'Damage', 7000, 54);
INSERT INTO public.defect VALUES (343, 'Corrosion', 1000, 55);
INSERT INTO public.defect VALUES (344, 'Fatigue Crack (Steel/Other)', 1010, 55);
INSERT INTO public.defect VALUES (345, 'Connection', 1020, 55);
INSERT INTO public.defect VALUES (346, 'Distortion', 1900, 55);
INSERT INTO public.defect VALUES (347, 'Cable Slack', 1025, 55);
INSERT INTO public.defect VALUES (348, 'Damage', 7000, 55);
INSERT INTO public.defect VALUES (349, 'Corrosion', 1000, 56);
INSERT INTO public.defect VALUES (350, 'Fatigue Crack (Steel/Other)', 1010, 56);
INSERT INTO public.defect VALUES (351, 'Connection', 1020, 56);
INSERT INTO public.defect VALUES (352, 'Distortion', 1900, 56);
INSERT INTO public.defect VALUES (353, 'Cable Slack', 1025, 56);
INSERT INTO public.defect VALUES (354, 'Damage', 7000, 56);
INSERT INTO public.defect VALUES (355, 'Corrosion', 1000, 57);
INSERT INTO public.defect VALUES (356, 'Connection', 1020, 57);
INSERT INTO public.defect VALUES (357, 'Movement', 2210, 57);
INSERT INTO public.defect VALUES (358, 'Alignment', 2220, 57);
INSERT INTO public.defect VALUES (359, 'Bulging, Splitting or Tearing', 2230, 57);
INSERT INTO public.defect VALUES (360, 'Loss of Bearing Area', 2240, 57);
INSERT INTO public.defect VALUES (361, 'Damage', 7000, 57);
INSERT INTO public.defect VALUES (362, 'Corrosion', 1000, 58);
INSERT INTO public.defect VALUES (363, 'Connection', 1020, 58);
INSERT INTO public.defect VALUES (364, 'Movement', 2210, 58);
INSERT INTO public.defect VALUES (365, 'Alignment', 2220, 58);
INSERT INTO public.defect VALUES (366, 'Loss of Bearing Area', 2240, 58);
INSERT INTO public.defect VALUES (367, 'Damage', 7000, 58);
INSERT INTO public.defect VALUES (368, 'Corrosion', 1000, 59);
INSERT INTO public.defect VALUES (369, 'Connection', 1020, 59);
INSERT INTO public.defect VALUES (370, 'Movement', 2210, 59);
INSERT INTO public.defect VALUES (371, 'Alignment', 2220, 59);
INSERT INTO public.defect VALUES (372, 'Loss of Bearing Area', 2240, 59);
INSERT INTO public.defect VALUES (373, 'Damage', 7000, 59);
INSERT INTO public.defect VALUES (374, 'Corrosion', 1000, 60);
INSERT INTO public.defect VALUES (375, 'Connection', 1020, 60);
INSERT INTO public.defect VALUES (376, 'Movement', 2210, 60);
INSERT INTO public.defect VALUES (377, 'Alignment', 2220, 60);
INSERT INTO public.defect VALUES (378, 'Loss of Bearing Area', 2240, 60);
INSERT INTO public.defect VALUES (379, 'Damage', 7000, 60);
INSERT INTO public.defect VALUES (380, 'Corrosion', 1000, 61);
INSERT INTO public.defect VALUES (381, 'Connection', 1020, 61);
INSERT INTO public.defect VALUES (382, 'Movement', 2210, 61);
INSERT INTO public.defect VALUES (383, 'Alignment', 2220, 61);
INSERT INTO public.defect VALUES (384, 'Bulging, Splitting or Tearing', 2230, 61);
INSERT INTO public.defect VALUES (385, 'Loss of Bearing Area', 2240, 61);
INSERT INTO public.defect VALUES (386, 'Damage', 7000, 61);
INSERT INTO public.defect VALUES (387, 'Corrosion', 1000, 62);
INSERT INTO public.defect VALUES (388, 'Connection', 1020, 62);
INSERT INTO public.defect VALUES (389, 'Movement', 2210, 62);
INSERT INTO public.defect VALUES (390, 'Alignment', 2220, 62);
INSERT INTO public.defect VALUES (391, 'Loss of Bearing Area', 2240, 62);
INSERT INTO public.defect VALUES (392, 'Damage', 7000, 62);
INSERT INTO public.defect VALUES (393, 'Corrosion', 1000, 63);
INSERT INTO public.defect VALUES (394, 'Connection', 1020, 63);
INSERT INTO public.defect VALUES (395, 'Movement', 2210, 63);
INSERT INTO public.defect VALUES (396, 'Alignment', 2220, 63);
INSERT INTO public.defect VALUES (397, 'Loss of Bearing Area', 2240, 63);
INSERT INTO public.defect VALUES (398, 'Damage', 7000, 63);
INSERT INTO public.defect VALUES (399, 'Delamination/ Spall/ Patched Area', 1080, 64);
INSERT INTO public.defect VALUES (400, 'Exposed Rebar', 1090, 64);
INSERT INTO public.defect VALUES (401, 'Efflorescence/ Rust Staining', 1120, 64);
INSERT INTO public.defect VALUES (402, 'Cracking (RC and Other)', 1130, 64);
INSERT INTO public.defect VALUES (403, 'Abrasion/Wear (PSC/RC)', 1190, 64);
INSERT INTO public.defect VALUES (404, 'Settlement', 4000, 64);
INSERT INTO public.defect VALUES (405, 'Scour', 6000, 64);
INSERT INTO public.defect VALUES (406, 'Damage', 7000, 64);
INSERT INTO public.defect VALUES (407, 'Connection', 1020, 65);
INSERT INTO public.defect VALUES (408, 'Decay/Section Loss', 1140, 65);
INSERT INTO public.defect VALUES (409, 'Check/Shake', 1150, 65);
INSERT INTO public.defect VALUES (410, 'Crack (Timber)', 1160, 65);
INSERT INTO public.defect VALUES (411, 'Split/Delamination (Timber)', 1170, 65);
INSERT INTO public.defect VALUES (412, 'Abrasion/Wear (Timber)', 1180, 65);
INSERT INTO public.defect VALUES (413, 'Settlement', 4000, 65);
INSERT INTO public.defect VALUES (414, 'Scour', 6000, 65);
INSERT INTO public.defect VALUES (415, 'Damage', 7000, 65);
INSERT INTO public.defect VALUES (416, 'Efflorescence/ Rust Staining', 1120, 66);
INSERT INTO public.defect VALUES (417, 'Mortar Breakdown (Masonry)', 1610, 66);
INSERT INTO public.defect VALUES (418, 'Split/Spall (Masonry)', 1620, 66);
INSERT INTO public.defect VALUES (419, 'Patched Area (Masonry)', 1630, 66);
INSERT INTO public.defect VALUES (420, 'Masonry Displacement', 1640, 66);
INSERT INTO public.defect VALUES (421, 'Settlement', 4000, 66);
INSERT INTO public.defect VALUES (422, 'Scour', 6000, 66);
INSERT INTO public.defect VALUES (423, 'Damage', 7000, 66);
INSERT INTO public.defect VALUES (424, 'Corrosion', 1000, 67);
INSERT INTO public.defect VALUES (425, 'Fatigue Crack (Steel/Other)', 1010, 67);
INSERT INTO public.defect VALUES (426, 'Connection', 1020, 67);
INSERT INTO public.defect VALUES (427, 'Cracking (RC and Other)', 1130, 67);
INSERT INTO public.defect VALUES (428, 'Deterioration (Other)', 1220, 67);
INSERT INTO public.defect VALUES (429, 'Distortion', 1900, 67);
INSERT INTO public.defect VALUES (430, 'Delamination/ Spall/ Patched Area', 1080, 67);
INSERT INTO public.defect VALUES (431, 'Efflorescence/ Rust Staining', 1120, 67);
INSERT INTO public.defect VALUES (432, 'Settlement', 4000, 67);
INSERT INTO public.defect VALUES (433, 'Scour', 6000, 67);
INSERT INTO public.defect VALUES (434, 'Damage', 7000, 67);
INSERT INTO public.defect VALUES (435, 'Corrosion', 1000, 68);
INSERT INTO public.defect VALUES (436, 'Fatigue Crack (Steel/Other)', 1010, 68);
INSERT INTO public.defect VALUES (437, 'Connection', 1020, 68);
INSERT INTO public.defect VALUES (438, 'Distortion', 1900, 68);
INSERT INTO public.defect VALUES (439, 'Settlement', 4000, 68);
INSERT INTO public.defect VALUES (440, 'Scour', 6000, 68);
INSERT INTO public.defect VALUES (441, 'Damage', 7000, 68);
INSERT INTO public.defect VALUES (442, 'Corrosion', 1000, 69);
INSERT INTO public.defect VALUES (443, 'Fatigue Crack (Steel/Other)', 1010, 69);
INSERT INTO public.defect VALUES (444, 'Connection', 1020, 69);
INSERT INTO public.defect VALUES (445, 'Distortion', 1900, 69);
INSERT INTO public.defect VALUES (446, 'Damage', 7000, 69);
INSERT INTO public.defect VALUES (447, 'Delamination/ Spall/ Patched Area', 1080, 70);
INSERT INTO public.defect VALUES (448, 'Exposed Rebar', 1090, 70);
INSERT INTO public.defect VALUES (449, 'Exposed Prestressing', 1100, 70);
INSERT INTO public.defect VALUES (450, 'Cracking (PSC)', 1110, 70);
INSERT INTO public.defect VALUES (451, 'Efflorescence/ Rust Staining', 1120, 70);
INSERT INTO public.defect VALUES (452, 'Damage', 7000, 70);
INSERT INTO public.defect VALUES (453, 'Delamination/ Spall/ Patched Area', 1080, 71);
INSERT INTO public.defect VALUES (454, 'Exposed Rebar', 1090, 71);
INSERT INTO public.defect VALUES (455, 'Efflorescence/ Rust Staining', 1120, 71);
INSERT INTO public.defect VALUES (456, 'Cracking (RC and Other)', 1130, 71);
INSERT INTO public.defect VALUES (457, 'Damage', 7000, 71);
INSERT INTO public.defect VALUES (458, 'Connection', 1020, 72);
INSERT INTO public.defect VALUES (459, 'Decay/Section Loss', 1140, 72);
INSERT INTO public.defect VALUES (460, 'Check/Shake', 1150, 72);
INSERT INTO public.defect VALUES (461, 'Crack (Timber)', 1160, 72);
INSERT INTO public.defect VALUES (462, 'Split/Delamination (Timber)', 1170, 72);
INSERT INTO public.defect VALUES (463, 'Abrasion/Wear (Timber)', 1180, 72);
INSERT INTO public.defect VALUES (464, 'Damage', 7000, 72);
INSERT INTO public.defect VALUES (465, 'Corrosion', 1000, 73);
INSERT INTO public.defect VALUES (466, 'Fatigue Crack (Steel/Other)', 1010, 73);
INSERT INTO public.defect VALUES (467, 'Connection', 1020, 73);
INSERT INTO public.defect VALUES (468, 'Cracking (RC and Other)', 1130, 73);
INSERT INTO public.defect VALUES (469, 'Deterioration (Other)', 1220, 73);
INSERT INTO public.defect VALUES (470, 'Distortion', 1900, 73);
INSERT INTO public.defect VALUES (471, 'Delamination/ Spall/ Patched Area', 1080, 73);
INSERT INTO public.defect VALUES (472, 'Efflorescence/ Rust Staining', 1120, 73);
INSERT INTO public.defect VALUES (473, 'Damage', 7000, 73);
INSERT INTO public.defect VALUES (474, 'Corrosion', 1000, 74);
INSERT INTO public.defect VALUES (475, 'Fatigue Crack (Steel/Other)', 1010, 74);
INSERT INTO public.defect VALUES (476, 'Connection', 1020, 74);
INSERT INTO public.defect VALUES (477, 'Distortion', 1900, 74);
INSERT INTO public.defect VALUES (478, 'Settlement', 4000, 74);
INSERT INTO public.defect VALUES (479, 'Scour', 6000, 74);
INSERT INTO public.defect VALUES (480, 'Damage', 7000, 74);
INSERT INTO public.defect VALUES (481, 'Corrosion', 1000, 75);
INSERT INTO public.defect VALUES (482, 'Fatigue Crack (Steel/Other)', 1010, 75);
INSERT INTO public.defect VALUES (483, 'Connection', 1020, 75);
INSERT INTO public.defect VALUES (484, 'Cracking (RC and Other)', 1130, 75);
INSERT INTO public.defect VALUES (485, 'Deterioration (Other)', 1220, 75);
INSERT INTO public.defect VALUES (486, 'Distortion', 1900, 75);
INSERT INTO public.defect VALUES (487, 'Settlement', 4000, 75);
INSERT INTO public.defect VALUES (488, 'Delamination/ Spall/ Patched Area', 1080, 75);
INSERT INTO public.defect VALUES (489, 'Efflorescence/ Rust Staining', 1120, 75);
INSERT INTO public.defect VALUES (490, 'Scour', 6000, 75);
INSERT INTO public.defect VALUES (491, 'Damage', 7000, 75);
INSERT INTO public.defect VALUES (492, 'Delamination/ Spall/ Patched Area', 1080, 76);
INSERT INTO public.defect VALUES (493, 'Exposed Rebar', 1090, 76);
INSERT INTO public.defect VALUES (494, 'Exposed Prestressing', 1100, 76);
INSERT INTO public.defect VALUES (495, 'Cracking (PSC)', 1110, 76);
INSERT INTO public.defect VALUES (496, 'Efflorescence/ Rust Staining', 1120, 76);
INSERT INTO public.defect VALUES (497, 'Abrasion/Wear (PSC/RC)', 1190, 76);
INSERT INTO public.defect VALUES (498, 'Settlement', 4000, 76);
INSERT INTO public.defect VALUES (499, 'Scour', 6000, 76);
INSERT INTO public.defect VALUES (500, 'Damage', 7000, 76);
INSERT INTO public.defect VALUES (501, 'Delamination/ Spall/ Patched Area', 1080, 77);
INSERT INTO public.defect VALUES (502, 'Exposed Rebar', 1090, 77);
INSERT INTO public.defect VALUES (503, 'Efflorescence/ Rust Staining', 1120, 77);
INSERT INTO public.defect VALUES (504, 'Cracking (RC and Other)', 1130, 77);
INSERT INTO public.defect VALUES (505, 'Abrasion/Wear (PSC/RC)', 1190, 77);
INSERT INTO public.defect VALUES (506, 'Settlement', 4000, 77);
INSERT INTO public.defect VALUES (507, 'Scour', 6000, 77);
INSERT INTO public.defect VALUES (508, 'Damage', 7000, 77);
INSERT INTO public.defect VALUES (509, 'Connection', 1020, 78);
INSERT INTO public.defect VALUES (510, 'Decay/Section Loss', 1140, 78);
INSERT INTO public.defect VALUES (511, 'Check/Shake', 1150, 78);
INSERT INTO public.defect VALUES (512, 'Crack (Timber)', 1160, 78);
INSERT INTO public.defect VALUES (513, 'Split/Delamination (Timber)', 1170, 78);
INSERT INTO public.defect VALUES (514, 'Abrasion/Wear (Timber)', 1180, 78);
INSERT INTO public.defect VALUES (515, 'Settlement', 4000, 78);
INSERT INTO public.defect VALUES (516, 'Scour', 6000, 78);
INSERT INTO public.defect VALUES (517, 'Damage', 7000, 78);
INSERT INTO public.defect VALUES (518, 'Corrosion', 1000, 79);
INSERT INTO public.defect VALUES (519, 'Fatigue Crack (Steel/Other)', 1010, 79);
INSERT INTO public.defect VALUES (520, 'Connection', 1020, 79);
INSERT INTO public.defect VALUES (521, 'Distortion', 1900, 79);
INSERT INTO public.defect VALUES (522, 'Settlement', 4000, 79);
INSERT INTO public.defect VALUES (523, 'Scour', 6000, 79);
INSERT INTO public.defect VALUES (524, 'Damage', 7000, 79);
INSERT INTO public.defect VALUES (525, 'Connection', 1020, 80);
INSERT INTO public.defect VALUES (526, 'Decay/Section Loss', 1140, 80);
INSERT INTO public.defect VALUES (527, 'Check/Shake', 1150, 80);
INSERT INTO public.defect VALUES (528, 'Crack (Timber)', 1160, 80);
INSERT INTO public.defect VALUES (529, 'Split/Delamination (Timber)', 1170, 80);
INSERT INTO public.defect VALUES (530, 'Abrasion/Wear (Timber)', 1180, 80);
INSERT INTO public.defect VALUES (531, 'Settlement', 4000, 80);
INSERT INTO public.defect VALUES (532, 'Scour', 6000, 80);
INSERT INTO public.defect VALUES (533, 'Damage', 7000, 80);
INSERT INTO public.defect VALUES (534, 'Delamination/ Spall/ Patched Area', 1080, 81);
INSERT INTO public.defect VALUES (535, 'Exposed Rebar', 1090, 81);
INSERT INTO public.defect VALUES (536, 'Efflorescence/ Rust Staining', 1120, 81);
INSERT INTO public.defect VALUES (537, 'Cracking (RC and Other)', 1130, 81);
INSERT INTO public.defect VALUES (538, 'Abrasion/Wear (PSC/RC)', 1190, 81);
INSERT INTO public.defect VALUES (539, 'Settlement', 4000, 81);
INSERT INTO public.defect VALUES (540, 'Scour', 6000, 81);
INSERT INTO public.defect VALUES (541, 'Damage', 7000, 81);
INSERT INTO public.defect VALUES (542, 'Corrosion', 1000, 82);
INSERT INTO public.defect VALUES (543, 'Fatigue Crack (Steel/Other)', 1010, 82);
INSERT INTO public.defect VALUES (544, 'Connection', 1020, 82);
INSERT INTO public.defect VALUES (545, 'Cracking (RC and Other)', 1130, 82);
INSERT INTO public.defect VALUES (546, 'Deterioration (Other)', 1220, 82);
INSERT INTO public.defect VALUES (547, 'Distortion', 1900, 82);
INSERT INTO public.defect VALUES (548, 'Settlement', 4000, 82);
INSERT INTO public.defect VALUES (549, 'Delamination/ Spall/ Patched Area', 1080, 82);
INSERT INTO public.defect VALUES (550, 'Efflorescence/ Rust Staining', 1120, 82);
INSERT INTO public.defect VALUES (551, 'Scour', 6000, 82);
INSERT INTO public.defect VALUES (552, 'Damage', 7000, 82);
INSERT INTO public.defect VALUES (553, 'Connection', 1020, 83);
INSERT INTO public.defect VALUES (554, 'Decay/Section Loss', 1140, 83);
INSERT INTO public.defect VALUES (555, 'Check/Shake', 1150, 83);
INSERT INTO public.defect VALUES (556, 'Crack (Timber)', 1160, 83);
INSERT INTO public.defect VALUES (557, 'Split/Delamination (Timber)', 1170, 83);
INSERT INTO public.defect VALUES (558, 'Abrasion/Wear (Timber)', 1180, 83);
INSERT INTO public.defect VALUES (559, 'Settlement', 4000, 83);
INSERT INTO public.defect VALUES (560, 'Scour', 6000, 83);
INSERT INTO public.defect VALUES (561, 'Damage', 7000, 83);
INSERT INTO public.defect VALUES (562, 'Efflorescence/ Rust Staining', 1120, 84);
INSERT INTO public.defect VALUES (563, 'Mortar Breakdown (Masonry)', 1610, 84);
INSERT INTO public.defect VALUES (564, 'Split/Spall (Masonry)', 1620, 84);
INSERT INTO public.defect VALUES (565, 'Patched Area (Masonry)', 1630, 84);
INSERT INTO public.defect VALUES (566, 'Masonry Displacement', 1640, 84);
INSERT INTO public.defect VALUES (567, 'Settlement', 4000, 84);
INSERT INTO public.defect VALUES (568, 'Scour', 6000, 84);
INSERT INTO public.defect VALUES (569, 'Damage', 7000, 84);
INSERT INTO public.defect VALUES (570, 'Delamination/ Spall/ Patched Area', 1080, 85);
INSERT INTO public.defect VALUES (571, 'Exposed Rebar', 1090, 85);
INSERT INTO public.defect VALUES (572, 'Efflorescence/ Rust Staining', 1120, 85);
INSERT INTO public.defect VALUES (573, 'Cracking (RC and Other)', 1130, 85);
INSERT INTO public.defect VALUES (574, 'Abrasion/Wear (PSC/RC)', 1190, 85);
INSERT INTO public.defect VALUES (575, 'Settlement', 4000, 85);
INSERT INTO public.defect VALUES (576, 'Scour', 6000, 85);
INSERT INTO public.defect VALUES (577, 'Damage', 7000, 85);
INSERT INTO public.defect VALUES (578, 'Distortion', 1900, 86);
INSERT INTO public.defect VALUES (579, 'Settlement', 4000, 86);
INSERT INTO public.defect VALUES (580, 'Fatigue Crack (Steel/Other)', 1010, 86);
INSERT INTO public.defect VALUES (581, 'Scour', 6000, 86);
INSERT INTO public.defect VALUES (582, 'Corrosion', 1000, 86);
INSERT INTO public.defect VALUES (583, 'Connection', 1020, 86);
INSERT INTO public.defect VALUES (584, 'Damage', 7000, 86);
INSERT INTO public.defect VALUES (585, 'Delamination/ Spall/ Patched Area', 1080, 87);
INSERT INTO public.defect VALUES (586, 'Exposed Rebar', 1090, 87);
INSERT INTO public.defect VALUES (587, 'Exposed Prestressing', 1100, 87);
INSERT INTO public.defect VALUES (588, 'Abrasion/Wear (PSC/RC)', 1190, 87);
INSERT INTO public.defect VALUES (589, 'Settlement', 4000, 87);
INSERT INTO public.defect VALUES (590, 'Cracking (PSC)', 1110, 87);
INSERT INTO public.defect VALUES (591, 'Efflorescence/ Rust Staining', 1120, 87);
INSERT INTO public.defect VALUES (592, 'Scour', 6000, 87);
INSERT INTO public.defect VALUES (593, 'Damage', 7000, 87);
INSERT INTO public.defect VALUES (594, 'Delamination/ Spall/ Patched Area', 1080, 88);
INSERT INTO public.defect VALUES (595, 'Exposed Rebar', 1090, 88);
INSERT INTO public.defect VALUES (596, 'Efflorescence/ Rust Staining', 1120, 88);
INSERT INTO public.defect VALUES (597, 'Cracking (RC and Other)', 1130, 88);
INSERT INTO public.defect VALUES (598, 'Abrasion/Wear (PSC/RC)', 1190, 88);
INSERT INTO public.defect VALUES (599, 'Settlement', 4000, 88);
INSERT INTO public.defect VALUES (600, 'Scour', 6000, 88);
INSERT INTO public.defect VALUES (601, 'Damage', 7000, 88);
INSERT INTO public.defect VALUES (602, 'Connection', 1020, 89);
INSERT INTO public.defect VALUES (603, 'Decay/Section Loss', 1140, 89);
INSERT INTO public.defect VALUES (604, 'Check/Shake', 1150, 89);
INSERT INTO public.defect VALUES (605, 'Crack (Timber)', 1160, 89);
INSERT INTO public.defect VALUES (606, 'Split/Delamination (Timber)', 1170, 89);
INSERT INTO public.defect VALUES (607, 'Abrasion/Wear (Timber)', 1180, 89);
INSERT INTO public.defect VALUES (608, 'Settlement', 4000, 89);
INSERT INTO public.defect VALUES (609, 'Scour', 6000, 89);
INSERT INTO public.defect VALUES (610, 'Damage', 7000, 89);
INSERT INTO public.defect VALUES (611, 'Corrosion', 1000, 90);
INSERT INTO public.defect VALUES (612, 'Fatigue Crack (Steel/Other)', 1010, 90);
INSERT INTO public.defect VALUES (613, 'Connection', 1020, 90);
INSERT INTO public.defect VALUES (614, 'Cracking (RC and Other)', 1130, 90);
INSERT INTO public.defect VALUES (615, 'Deterioration (Other)', 1220, 90);
INSERT INTO public.defect VALUES (616, 'Distortion', 1900, 90);
INSERT INTO public.defect VALUES (617, 'Delamination/ Spall/ Patched Area', 1080, 90);
INSERT INTO public.defect VALUES (618, 'Efflorescence/ Rust Staining', 1120, 90);
INSERT INTO public.defect VALUES (619, 'Settlement', 4000, 90);
INSERT INTO public.defect VALUES (620, 'Scour', 6000, 90);
INSERT INTO public.defect VALUES (621, 'Damage', 7000, 90);
INSERT INTO public.defect VALUES (622, 'Corrosion', 1000, 91);
INSERT INTO public.defect VALUES (623, 'Fatigue Crack (Steel/Other)', 1010, 91);
INSERT INTO public.defect VALUES (624, 'Connection', 1020, 91);
INSERT INTO public.defect VALUES (625, 'Distortion', 1900, 91);
INSERT INTO public.defect VALUES (626, 'Settlement', 4000, 91);
INSERT INTO public.defect VALUES (627, 'Scour', 6000, 91);
INSERT INTO public.defect VALUES (628, 'Damage', 7000, 91);
INSERT INTO public.defect VALUES (629, 'Corrosion', 1000, 92);
INSERT INTO public.defect VALUES (630, 'Cracking (RC and Other)', 1130, 92);
INSERT INTO public.defect VALUES (631, 'Settlement', 4000, 92);
INSERT INTO public.defect VALUES (632, 'Distortion', 1900, 92);
INSERT INTO public.defect VALUES (633, 'Scour', 6000, 92);
INSERT INTO public.defect VALUES (634, 'Damage', 7000, 92);
INSERT INTO public.defect VALUES (635, 'Corrosion', 1000, 93);
INSERT INTO public.defect VALUES (636, 'Fatigue Crack (Steel/Other)', 1010, 93);
INSERT INTO public.defect VALUES (637, 'Connection', 1020, 93);
INSERT INTO public.defect VALUES (638, 'Distortion', 1900, 93);
INSERT INTO public.defect VALUES (639, 'Damage', 7000, 93);
INSERT INTO public.defect VALUES (640, 'Corrosion', 1000, 94);
INSERT INTO public.defect VALUES (641, 'Fatigue Crack (Steel/Other)', 1010, 94);
INSERT INTO public.defect VALUES (642, 'Connection', 1020, 94);
INSERT INTO public.defect VALUES (643, 'Distortion', 1900, 94);
INSERT INTO public.defect VALUES (644, 'Damage', 7000, 94);
INSERT INTO public.defect VALUES (645, 'Delamination/ Spall/ Patched Area', 1080, 95);
INSERT INTO public.defect VALUES (646, 'Exposed Rebar', 1090, 95);
INSERT INTO public.defect VALUES (647, 'Deterioration (Other)', 1220, 95);
INSERT INTO public.defect VALUES (648, 'Cracking (RC and Other)', 1130, 95);
INSERT INTO public.defect VALUES (649, 'Settlement', 4000, 95);
INSERT INTO public.defect VALUES (650, 'Scour', 6000, 95);
INSERT INTO public.defect VALUES (651, 'Damage', 7000, 95);
INSERT INTO public.defect VALUES (652, 'Distortion', 1900, 96);
INSERT INTO public.defect VALUES (653, 'Settlement', 4000, 96);
INSERT INTO public.defect VALUES (654, 'Fatigue Crack (Steel/Other)', 1010, 96);
INSERT INTO public.defect VALUES (655, 'Scour', 6000, 96);
INSERT INTO public.defect VALUES (656, 'Corrosion', 1000, 96);
INSERT INTO public.defect VALUES (657, 'Connection', 1020, 96);
INSERT INTO public.defect VALUES (658, 'Damage', 7000, 96);
INSERT INTO public.defect VALUES (659, 'Delamination/ Spall/ Patched Area', 1080, 97);
INSERT INTO public.defect VALUES (660, 'Exposed Rebar', 1090, 97);
INSERT INTO public.defect VALUES (661, 'Efflorescence/ Rust Staining', 1120, 97);
INSERT INTO public.defect VALUES (662, 'Cracking (RC and Other)', 1130, 97);
INSERT INTO public.defect VALUES (663, 'Abrasion/Wear (PSC/RC)', 1190, 97);
INSERT INTO public.defect VALUES (664, 'Distortion', 1900, 97);
INSERT INTO public.defect VALUES (665, 'Settlement', 4000, 97);
INSERT INTO public.defect VALUES (666, 'Scour', 6000, 97);
INSERT INTO public.defect VALUES (667, 'Damage', 7000, 97);
INSERT INTO public.defect VALUES (668, 'Connection', 1020, 98);
INSERT INTO public.defect VALUES (669, 'Decay/Section Loss', 1140, 98);
INSERT INTO public.defect VALUES (670, 'Check/Shake', 1150, 98);
INSERT INTO public.defect VALUES (671, 'Crack (Timber)', 1160, 98);
INSERT INTO public.defect VALUES (672, 'Split/Delamination (Timber)', 1170, 98);
INSERT INTO public.defect VALUES (673, 'Abrasion/Wear (Timber)', 1180, 98);
INSERT INTO public.defect VALUES (674, 'Distortion', 1900, 98);
INSERT INTO public.defect VALUES (675, 'Settlement', 4000, 98);
INSERT INTO public.defect VALUES (676, 'Scour', 6000, 98);
INSERT INTO public.defect VALUES (677, 'Damage', 7000, 98);
INSERT INTO public.defect VALUES (678, 'Corrosion', 1000, 99);
INSERT INTO public.defect VALUES (679, 'Fatigue Crack (Steel/Other)', 1010, 99);
INSERT INTO public.defect VALUES (680, 'Connection', 1020, 99);
INSERT INTO public.defect VALUES (681, 'Delamination/ Spall/ Patched Area', 1080, 99);
INSERT INTO public.defect VALUES (682, 'Efflorescence/ Rust Staining', 1120, 99);
INSERT INTO public.defect VALUES (683, 'Cracking (RC and Other)', 1130, 99);
INSERT INTO public.defect VALUES (684, 'Deterioration (Other)', 1220, 99);
INSERT INTO public.defect VALUES (685, 'Distortion', 1900, 99);
INSERT INTO public.defect VALUES (686, 'Settlement', 4000, 99);
INSERT INTO public.defect VALUES (687, 'Scour', 6000, 99);
INSERT INTO public.defect VALUES (688, 'Damage', 7000, 99);
INSERT INTO public.defect VALUES (689, 'Efflorescence/ Rust Staining', 1120, 100);
INSERT INTO public.defect VALUES (690, 'Mortar Breakdown (Masonry)', 1610, 100);
INSERT INTO public.defect VALUES (691, 'Split/Spall (Masonry)', 1620, 100);
INSERT INTO public.defect VALUES (692, 'Patched Area (Masonry)', 1630, 100);
INSERT INTO public.defect VALUES (693, 'Masonry Displacement', 1640, 100);
INSERT INTO public.defect VALUES (694, 'Distortion', 1900, 100);
INSERT INTO public.defect VALUES (695, 'Settlement', 4000, 100);
INSERT INTO public.defect VALUES (696, 'Scour', 6000, 100);
INSERT INTO public.defect VALUES (697, 'Damage', 7000, 100);
INSERT INTO public.defect VALUES (698, 'Delamination/ Spall/ Patched Area', 1080, 101);
INSERT INTO public.defect VALUES (699, 'Exposed Rebar', 1090, 101);
INSERT INTO public.defect VALUES (700, 'Exposed Prestressing', 1100, 101);
INSERT INTO public.defect VALUES (701, 'Cracking (PSC)', 1110, 101);
INSERT INTO public.defect VALUES (702, 'Efflorescence/ Rust Staining', 1120, 101);
INSERT INTO public.defect VALUES (703, 'Abrasion/Wear (PSC/RC)', 1190, 101);
INSERT INTO public.defect VALUES (704, 'Distortion', 1900, 101);
INSERT INTO public.defect VALUES (705, 'Settlement', 4000, 101);
INSERT INTO public.defect VALUES (706, 'Scour', 6000, 101);
INSERT INTO public.defect VALUES (707, 'Damage', 7000, 101);
INSERT INTO public.defect VALUES (708, 'Leakage', 2310, 102);
INSERT INTO public.defect VALUES (709, 'Seal Adhesion', 2320, 102);
INSERT INTO public.defect VALUES (710, 'Seal Damage', 2330, 102);
INSERT INTO public.defect VALUES (711, 'Seal Cracking', 2340, 102);
INSERT INTO public.defect VALUES (712, 'Debris Impaction', 2350, 102);
INSERT INTO public.defect VALUES (713, 'Adjacent Deck or Header', 2360, 102);
INSERT INTO public.defect VALUES (714, 'Metal Deterioration or Damage', 2370, 102);
INSERT INTO public.defect VALUES (715, 'Damage', 7000, 102);
INSERT INTO public.defect VALUES (716, 'Leakage', 2310, 103);
INSERT INTO public.defect VALUES (717, 'Seal Adhesion', 2320, 103);
INSERT INTO public.defect VALUES (718, 'Seal Damage', 2330, 103);
INSERT INTO public.defect VALUES (719, 'Seal Cracking', 2340, 103);
INSERT INTO public.defect VALUES (720, 'Debris Impaction', 2350, 103);
INSERT INTO public.defect VALUES (721, 'Adjacent Deck or Header', 2360, 103);
INSERT INTO public.defect VALUES (722, 'Damage', 7000, 103);
INSERT INTO public.defect VALUES (723, 'Leakage', 2310, 104);
INSERT INTO public.defect VALUES (724, 'Seal Adhesion', 2320, 104);
INSERT INTO public.defect VALUES (725, 'Seal Damage', 2330, 104);
INSERT INTO public.defect VALUES (726, 'Seal Cracking', 2340, 104);
INSERT INTO public.defect VALUES (727, 'Debris Impaction', 2350, 104);
INSERT INTO public.defect VALUES (728, 'Adjacent Deck or Header', 2360, 104);
INSERT INTO public.defect VALUES (729, 'Damage', 7000, 104);
INSERT INTO public.defect VALUES (730, 'Leakage', 2310, 105);
INSERT INTO public.defect VALUES (731, 'Seal Adhesion', 2320, 105);
INSERT INTO public.defect VALUES (732, 'Seal Damage', 2330, 105);
INSERT INTO public.defect VALUES (733, 'Seal Cracking', 2340, 105);
INSERT INTO public.defect VALUES (734, 'Debris Impaction', 2350, 105);
INSERT INTO public.defect VALUES (735, 'Adjacent Deck or Header', 2360, 105);
INSERT INTO public.defect VALUES (736, 'Metal Deterioration or Damage', 2370, 105);
INSERT INTO public.defect VALUES (737, 'Damage', 7000, 105);
INSERT INTO public.defect VALUES (738, 'Debris Impaction', 2350, 106);
INSERT INTO public.defect VALUES (739, 'Adjacent Deck or Header', 2360, 106);
INSERT INTO public.defect VALUES (740, 'Damage', 7000, 106);
INSERT INTO public.defect VALUES (741, 'Debris Impaction', 2350, 107);
INSERT INTO public.defect VALUES (742, 'Adjacent Deck or Header', 2360, 107);
INSERT INTO public.defect VALUES (743, 'Metal Deterioration or Damage', 2370, 107);
INSERT INTO public.defect VALUES (744, 'Damage', 7000, 107);
INSERT INTO public.defect VALUES (745, 'Leakage', 2310, 108);
INSERT INTO public.defect VALUES (746, 'Debris Impaction', 2350, 108);
INSERT INTO public.defect VALUES (747, 'Adjacent Deck or Header', 2360, 108);
INSERT INTO public.defect VALUES (748, 'Metal Deterioration or Damage', 2370, 108);
INSERT INTO public.defect VALUES (749, 'Damage', 7000, 108);
INSERT INTO public.defect VALUES (750, 'Leakage', 2310, 109);
INSERT INTO public.defect VALUES (751, 'Seal Adhesion', 2320, 109);
INSERT INTO public.defect VALUES (752, 'Seal Adhesion', 2320, 109);
INSERT INTO public.defect VALUES (753, 'Damage', 7000, 109);
INSERT INTO public.defect VALUES (754, 'Debris Impaction', 2350, 110);
INSERT INTO public.defect VALUES (755, 'Adjacent Deck or Header', 2360, 110);
INSERT INTO public.defect VALUES (756, 'Metal Deterioration or Damage', 2370, 110);
INSERT INTO public.defect VALUES (757, 'Damage', 7000, 110);
INSERT INTO public.defect VALUES (758, 'Debris Impaction', 2350, 111);
INSERT INTO public.defect VALUES (759, 'Adjacent Deck or Header', 2360, 111);
INSERT INTO public.defect VALUES (760, 'Metal Deterioration or Damage', 2370, 111);
INSERT INTO public.defect VALUES (761, 'Damage', 7000, 111);
INSERT INTO public.defect VALUES (762, 'Delamination/ Spall/ Patched Area', 1080, 112);
INSERT INTO public.defect VALUES (763, 'Exposed Rebar', 1090, 112);
INSERT INTO public.defect VALUES (764, 'Exposed Prestressing', 1100, 112);
INSERT INTO public.defect VALUES (765, 'Cracking (PSC)', 1110, 112);
INSERT INTO public.defect VALUES (766, 'Abrasion/Wear (PSC/RC)', 1190, 112);
INSERT INTO public.defect VALUES (767, 'Settlement', 4000, 112);
INSERT INTO public.defect VALUES (768, 'Damage', 7000, 112);
INSERT INTO public.defect VALUES (769, 'Delamination/ Spall/ Patched Area', 1080, 113);
INSERT INTO public.defect VALUES (770, 'Exposed Rebar', 1090, 113);
INSERT INTO public.defect VALUES (771, 'Cracking (RC and Other)', 1130, 113);
INSERT INTO public.defect VALUES (772, 'Abrasion/Wear (PSC/RC)', 1190, 113);
INSERT INTO public.defect VALUES (773, 'Settlement', 4000, 113);
INSERT INTO public.defect VALUES (774, 'Damage', 7000, 113);
INSERT INTO public.defect VALUES (775, 'Delamination/ Patched Area/ Pothole (Wearing Surfaces)', 3210, 114);
INSERT INTO public.defect VALUES (776, 'Crack (Wearing Surface)', 3220, 114);
INSERT INTO public.defect VALUES (777, 'Effectiveness (Wearing Surface)', 3230, 114);
INSERT INTO public.defect VALUES (778, 'Damage', 7000, 114);
INSERT INTO public.defect VALUES (779, 'Delamination/ Patched Area/ Pothole (Wearing Surfaces)', 3210, 115);
INSERT INTO public.defect VALUES (780, 'Crack (Wearing Surface)', 3220, 115);
INSERT INTO public.defect VALUES (781, 'Effectiveness (Wearing Surface)', 3230, 115);
INSERT INTO public.defect VALUES (782, 'Damage', 7000, 115);
INSERT INTO public.defect VALUES (783, 'Delamination/ Patched Area/ Pothole (Wearing Surfaces)', 3210, 116);
INSERT INTO public.defect VALUES (784, 'Crack (Wearing Surface)', 3220, 116);
INSERT INTO public.defect VALUES (785, 'Effectiveness (Wearing Surface)', 3230, 116);
INSERT INTO public.defect VALUES (786, 'Damage', 7000, 116);
INSERT INTO public.defect VALUES (787, 'Connection', 1020, 117);
INSERT INTO public.defect VALUES (788, 'Decay/Section Loss', 1140, 117);
INSERT INTO public.defect VALUES (789, 'Check/Shake', 1150, 117);
INSERT INTO public.defect VALUES (790, 'Crack (Timber)', 1160, 117);
INSERT INTO public.defect VALUES (791, 'Split/Delamination (Timber)', 1170, 117);
INSERT INTO public.defect VALUES (792, 'Abrasion/Wear (Timber)', 1180, 117);
INSERT INTO public.defect VALUES (793, 'Damage', 7000, 117);
INSERT INTO public.defect VALUES (794, 'Chalking
(Steel Protective Coatings)', 3410, 118);
INSERT INTO public.defect VALUES (795, 'Peeling/Bubbling/Cracking (Steel Protective Coatings)', 3420, 118);
INSERT INTO public.defect VALUES (796, 'Effectiveness
(Steel Protective Coatings)', 3440, 118);
INSERT INTO public.defect VALUES (797, 'Damage', 7000, 118);
INSERT INTO public.defect VALUES (798, 'Peeling/Bubbling/Cracking (Steel Protective Coatings)', 3420, 119);
INSERT INTO public.defect VALUES (799, 'Oxide Film Degradation Color/ Texture Adherence (Steel Protective Coatings)', 3430, 119);
INSERT INTO public.defect VALUES (800, 'Effectiveness
(Steel Protective Coatings)', 3440, 119);
INSERT INTO public.defect VALUES (801, 'Damage', 7000, 119);
INSERT INTO public.defect VALUES (802, 'Peeling/Bubbling/Cracking (Steel Protective Coatings)', 3420, 120);
INSERT INTO public.defect VALUES (803, 'Oxide Film Degradation Color/ Texture Adherence (Steel Protective Coatings)', 3430, 120);
INSERT INTO public.defect VALUES (804, 'Effectiveness
(Steel Protective Coatings)', 3440, 120);
INSERT INTO public.defect VALUES (805, 'Damage', 7000, 120);
INSERT INTO public.defect VALUES (806, 'Effectiveness (Rebar Protective System- Coating/Cathodic)', 3600, 121);
INSERT INTO public.defect VALUES (807, 'Damage', 7000, 121);
INSERT INTO public.defect VALUES (808, 'Wear
(Concrete Protective Coatings)', 3510, 122);
INSERT INTO public.defect VALUES (809, 'Effectiveness (Concrete Protective Coatings)', 3540, 122);
INSERT INTO public.defect VALUES (810, 'Damage', 7000, 122);
INSERT INTO public.defect VALUES (811, 'Wear
(Concrete Protective Coatings)', 3510, 123);
INSERT INTO public.defect VALUES (812, 'Effectiveness (Concrete Protective Coatings)', 3540, 123);
INSERT INTO public.defect VALUES (813, 'Damage', 7000, 123);


--
-- Data for Name: inspection; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: inspector; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.inspector VALUES (1, 'Dusty', 'Birge', 'dusty@uav-recon.com', 'President UAV Recon, VOLT manager, entrepreneur');
INSERT INTO public.inspector VALUES (2, 'Wesley', 'Alexander', 'walexander@tmisolutionsllc.com', NULL);
INSERT INTO public.inspector VALUES (3, 'VOLT', 'User', 'sales@voltinspections.com', NULL);
INSERT INTO public.inspector VALUES (4, 'Mark', 'Vonleffern', 'mark@vonleffern.com', NULL);
INSERT INTO public.inspector VALUES (5, 'Carolina', 'Burgan', 'cburgan@altavistasolutions.com', NULL);
INSERT INTO public.inspector VALUES (6, 'Edward', 'Leach', 'eleach@altavistasolutions.com', NULL);
INSERT INTO public.inspector VALUES (7, 'Mohamed', 'Abdelbarr', 'mabdelbarr@altavistasolutions.com', NULL);


--
-- Data for Name: material; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.material VALUES (1, 'Deck - Reinforced Concrete', 'All reinforced concrete bridge decks regardless of the wearing surface or protection systems used.', 'sq.ft.', 1);
INSERT INTO public.material VALUES (2, 'Deck â Prestressed Concrete', 'All prestressed concrete bridge decks regardless of the wearing surface or protection systems used.', 'sq.ft.', 1);
INSERT INTO public.material VALUES (3, 'Top Flange - Prestressed Concrete', 'All prestressed bridge girder top flanges where traffic rides directly on the structural element
regardless of the wearing surface or protection systems used. These bridge types include only
concrete bulb-tees, box girders, and girders that require traffic to ride on the top flange. Use in
conjunction with the appropriate girder element.', 'sq.ft.', 1);
INSERT INTO public.material VALUES (4, 'Top Flange - Reinforced Concrete', 'All reinforced concrete bridge girder top flanges where traffic rides directly on the structural element
regardless of the wearing surface or protection systems used. These bridge types include only
concrete tee-beams, box girders, and girders that require traffic to ride on the top flange. Use in
conjunction with the appropriate girder element.', 'sq.ft.', 1);
INSERT INTO public.material VALUES (5, 'Steel Deck - Open Grid', 'All open grid steel bridge decks with no fill.', 'sq.ft.', 1);
INSERT INTO public.material VALUES (6, 'Steel Deck - Concrete Filled Grid', 'Steel bridge decks with concrete fill either in all of the openings or within the wheel tracks.', 'sq.ft.', 1);
INSERT INTO public.material VALUES (7, 'Steel Deck - Corrugated/Orthotropic/Etc.', 'Those bridge decks constructed of corrugated metal filled with portland cement, asphaltic concrete,
or other riding surfaces. Orthotropic steel decks are also included.', 'sq.ft.', 1);
INSERT INTO public.material VALUES (8, 'Deck - Timber', 'All timber bridge decks regardless of the wearing surface or protection systems used.', 'sq.ft.', 1);
INSERT INTO public.material VALUES (9, 'Slab - Reinforced Concrete', 'All reinforced concrete bridge slabs regardless of the wearing surface or protection systems used.', 'sq.ft.', 1);
INSERT INTO public.material VALUES (10, 'Slab - Prestressed Concrete', 'All prestressed concrete bridge slabs regardless of the wearing surface or protection systems used.', 'sq.ft.', 1);
INSERT INTO public.material VALUES (11, 'Slab - Timber', 'All timber bridge slabs regardless of the wearing surface or protection systems used.', 'sq.ft.', 1);
INSERT INTO public.material VALUES (12, 'Deck - Other', 'All bridge decks constructed of other materials not otherwise defined regardless of the wearing
surface or protection systems used.', 'sq.ft.', 1);
INSERT INTO public.material VALUES (13, 'Slab - Other', 'All slabs constructed of other materials not otherwise defined regardless of the wearing surface or
protection systems used.', 'sq.ft.', 1);
INSERT INTO public.material VALUES (14, 'Bridge Railing - Metal', 'All types and shapes of metal bridge railing. Steel, aluminum, metal beam, rolled shapes, etc. will all
be considered part of this element. Included in this element are the posts of metal, timber or
concrete, blocking, and curb.', 'ft.', 2);
INSERT INTO public.material VALUES (15, 'Bridge Railing - Reinforced Concrete', 'All types and shapes of reinforced concrete bridge railing. All elements of the railing must be concrete.', 'ft.', 2);
INSERT INTO public.material VALUES (16, 'Bridge Railing - Timber', 'All types and shapes of timber bridge railing. Included in this element are posts of timber, metal, or
concrete, blocking, and curb.', 'ft.', 2);
INSERT INTO public.material VALUES (17, 'Bridge Railing - Other', 'All types and shapes of bridge railing except those defined as metal, concrete, timber, or masonry.
Use this element for combination rails that have concrete parapets and metal top sections attached.', 'ft.', 2);
INSERT INTO public.material VALUES (18, 'Bridge Railing - Masonry', 'All types and shapes of masonry block or stone bridge railing. All elements of the railing must be
masonry block or stone.', 'ft.', 2);
INSERT INTO public.material VALUES (19, 'Closed Web/Box Girder - Steel', 'All steel box girders or closed web girders. For all box girders regardless of protective system.', 'ft.', 3);
INSERT INTO public.material VALUES (20, 'Closed Web/Box Girder - Prestressed Concrete', 'All pretensioned or post-tensioned concrete closed web girders or box girders. For all box girders
regardless of protective system.', 'ft.', 3);
INSERT INTO public.material VALUES (21, 'Closed Web/Box Girder - Reinforced Concrete', 'All reinforced concrete box girders or closed web girders. For all box girders regardless of protective
system.', 'ft.', 3);
INSERT INTO public.material VALUES (22, 'Closed Web/Box Girder - Other', 'All other material box girders or closed web girders. For all other material box girders regardless of
protective system.', 'ft.', 3);
INSERT INTO public.material VALUES (23, 'Open Girder/Beam - Steel', 'All steel open girders regardless of protective system.', 'ft.', 3);
INSERT INTO public.material VALUES (24, 'Open Girder/Beam - Prestressed Concrete', 'Pretensioned or post-tensioned concrete open web girders regardless of protective system.', 'ft.', 3);
INSERT INTO public.material VALUES (25, 'Open Girder/Beam - Reinforced Concrete', 'Mild steel reinforced concrete open web girders regardless of protective system.', 'ft.', 3);
INSERT INTO public.material VALUES (26, 'Open Girder/Beam - Timber', 'All timber open girders regardless of protection system.', 'ft.', 3);
INSERT INTO public.material VALUES (27, 'Open Girder/Beam - Other', 'All other material girders regardless of protection system.', 'ft.', 3);
INSERT INTO public.material VALUES (28, 'Truss - Steel', 'All steel truss elements, including all tension and compression members for through and deck trusses.
It is for all trusses regardless of protective system.', 'ft.', 4);
INSERT INTO public.material VALUES (29, 'Truss - Timber', 'All timber truss elements, including all tension and compression members for through and deck
trusses. It is for all trusses regardless of protective system.', 'ft.', 4);
INSERT INTO public.material VALUES (30, 'Truss - Other', 'All other material truss elements, including all tension and compression members, and through and
deck trusses. It is for all other material trusses regardless of protective system.', 'ft.', 4);
INSERT INTO public.material VALUES (31, 'Arch - Steel', 'Steel arches regardless of type or protective system.', 'ft.', 4);
INSERT INTO public.material VALUES (32, 'Arch - Other', 'Other material arches regardless of type or protective system.', 'ft.', 4);
INSERT INTO public.material VALUES (33, 'Arch - Prestressed Concrete', 'Only pretensioned or post-tensioned concrete arches regardless of protective system.', 'ft.', 4);
INSERT INTO public.material VALUES (34, 'Arch - Reinforced Concrete', 'Only mild steel reinforced concrete arches regardless of protective system.', 'ft.', 4);
INSERT INTO public.material VALUES (35, 'Arch - Masonry', 'Masonry or stacked stone arches regardless of protective system.', 'ft.', 4);
INSERT INTO public.material VALUES (36, 'Arch - Timber', 'Only timber arches regardless of protective system.', 'ft.', 4);
INSERT INTO public.material VALUES (37, 'Stringer - Steel', 'Steel members that support the deck in a stringer floor beam system regardless of protective system.', 'ft.', 5);
INSERT INTO public.material VALUES (38, 'Stringer - Prestressed Concrete', 'Pretensioned or post-tensioned concrete members that support the deck in a stringer floor beam
system regardless of protective system.', 'ft.', 5);
INSERT INTO public.material VALUES (39, 'Stringer - Reinforced Concrete', 'Mild steel reinforced concrete members that support the deck in a stringer floor beam system
regardless of protective system.', 'ft.', 5);
INSERT INTO public.material VALUES (40, 'Stringer - Timber', 'Timber members that support the deck in a stringer floor beam system regardless of protective
system.', 'ft.', 5);
INSERT INTO public.material VALUES (41, 'Stringer - Other', 'All other material stringers regardless of protection system.', 'ft.', 5);
INSERT INTO public.material VALUES (42, 'Floor Beam - Steel', 'Steel floor beams that typically support stringers regardless of protective system.', 'ft.', 6);
INSERT INTO public.material VALUES (43, 'Floor Beam - Prestressed Concrete', 'Prestressed concrete floor beams that typically support stringers regardless of protective system.', 'ft.', 6);
INSERT INTO public.material VALUES (44, 'Floor Beam - Reinforced Concrete', 'Mild steel reinforced concrete floor beams that typically support stringers regardless of protective
system.', 'ft.', 6);
INSERT INTO public.material VALUES (45, 'Floor Beam - Timber', 'Timber floor beams that typically support stringers regardless of protective system.', 'ft.', 6);
INSERT INTO public.material VALUES (46, 'Floor Beam - Other', 'Other material floor beams that typically support stringers regardless of protective system.', 'ft.', 6);
INSERT INTO public.material VALUES (47, 'Cables - Main Steel', 'All steel main suspension or cable stay cables not embedded in concrete.
For all cable groups regardless of protective systems.', 'ft.', 7);
INSERT INTO public.material VALUES (48, 'Cables - Secondary Steel', 'All steel suspender cables not embedded in concrete.
For all individual or cable groups regardless of protective system.', 'Each', 7);
INSERT INTO public.material VALUES (49, 'Cables - Secondary Other', 'All other material cables not embedded in concrete.
For all individual other material cables or cable groups regardless of protective systems.', 'Each', 7);
INSERT INTO public.material VALUES (50, 'Steel Pin and Pin & Hanger Assembly', 'Steel pins and pin and hanger assemblies regardless of protective system.', 'Each', 7);
INSERT INTO public.material VALUES (51, 'Steel Gusset Plate', 'Only those steel gusset plate(s) connections that are on the main truss/arch panel(s).
These connections can be constructed with one or more plates that may be bolted, riveted, or
welded. For all gusset plates regardless of protective system.', 'Each', 7);
INSERT INTO public.material VALUES (52, 'Railroad Car Frame', 'This member defines all superstructures composed of railroad car frames.', 'ft.', 7);
INSERT INTO public.material VALUES (53, 'Miscellaneous Steel Superstructures', 'This member is intended to be used for all other miscellaneous steel superstructure elements that
were not previously defined.
Examples of such structures includes army steel tread way, boat hatch cover, army steel pontoon, etc.
The entire superstructure area (equivalent deck area) composed of these miscellaneous elements will
be treated as an each regardless of the number of spans.', 'Each', 7);
INSERT INTO public.material VALUES (54, 'EQ Restrainer Cables â Type II', 'This member defines seismic restrainer cables used for hinges with long hinge seats (>9 inches) and
occasionally in combination with pipe seat extenders. The standard length varies from fifteen to forty
feet and the restrainer system at a hinge may consist of six to twelve cables.', 'Each Unit', 7);
INSERT INTO public.material VALUES (55, 'EQ Restrainer Cables â C1', 'This member defines seismic restrainer cables used for hinges with short hinge seats (<9 inches).
The current standard number of cables per drum is five. The original systems consisted of seven
cables per drum.', 'Each Unit', 7);
INSERT INTO public.material VALUES (56, 'EQ Restrainer Cables - Other', 'This element defines Seismic restrainer cables systems that are not Type II or C-1 restrainer cable
systems.', 'Each Unit', 7);
INSERT INTO public.material VALUES (57, 'Bearing - Elastomeric', 'Only those bridge bearings that are constructed primarily of elastomers, with or without fabric or
metal reinforcement.', 'Each', 8);
INSERT INTO public.material VALUES (58, 'Bearing - Movable', 'Only those bridge bearings which provide for both rotation and longitudinal movement by means of
roller, rocker, or sliding mechanisms.', 'Each', 8);
INSERT INTO public.material VALUES (59, 'Bearing - Enclosed/Concealed', 'Only those bridge bearings that are enclosed so that they are not open for detailed inspection.', 'Each', 8);
INSERT INTO public.material VALUES (60, 'Bearing - Fixed', 'Only those bridge bearings that provide for rotation only (no longitudinal movement.', 'Each', 8);
INSERT INTO public.material VALUES (61, 'Bearing - Pot', 'Those high load bearings with confined elastomer. The bearing may be fixed against horizontal
movement, guided to allow sliding in one direction, or floating to allow sliding in any direction.', 'Each', 8);
INSERT INTO public.material VALUES (62, 'Bearing - Disk', 'Those high load bearings with a hard plastic disk. This bearing may be fixed against horizontal
movement, guided to allow movement in one direction, or floating to allow sliding in any direction.', 'Each', 8);
INSERT INTO public.material VALUES (63, 'Bearing - Other', 'All other material bridge bearings regardless of translation or rotation constraints.', 'Each', 8);
INSERT INTO public.material VALUES (64, 'Abutment - Reinforced Concrete', 'Reinforced concrete abutments. This includes the material retaining the embankment and monolithic
wingwalls and abutment extensions. For all reinforced concrete abutments regardless of protective
systems.', 'ft.', 9);
INSERT INTO public.material VALUES (65, 'Abutment - Timber', 'Timber abutments, including the sheet material retaining the embankment, integral wingwalls, and
abutment extensions. For all abutments regardless of protective systems.', 'ft.', 9);
INSERT INTO public.material VALUES (66, 'Abutment - Masonry', 'Those abutments constructed of block or stone, including integral wingwalls and abutment
extensions. The block or stone may be placed with or without mortar. For all abutments regardless of
protective systems.', 'ft.', 9);
INSERT INTO public.material VALUES (67, 'Abutment - Other', 'Other material abutment systems, including the sheet material retaining the embankment, and
integral wingwalls and abutment extensions. For all abutments regardless of protective systems.', 'ft.', 9);
INSERT INTO public.material VALUES (68, 'Abutment - Steel', 'Steel abutments, including the sheet material retaining the embankment, and integral wingwalls and
abutment extensions. For all abutments regardless of protective systems.', 'ft.', 9);
INSERT INTO public.material VALUES (69, 'Pier Cap - Steel', 'Those steel pier caps that support girders and transfer load into piles or columns. For all steel pier
caps regardless of protective system.', 'ft.', 10);
INSERT INTO public.material VALUES (70, 'Pier Cap - Prestressed Concrete', 'Those prestressed concrete pier caps that support girders and transfer load into piles or columns. For
all caps regardless of protective system.', 'ft.', 10);
INSERT INTO public.material VALUES (71, 'Pier Cap - Reinforced Concrete', 'Those reinforced concrete pier caps that support girders and transfer load into piles or columns. For
all pier caps regardless of protective system.', 'ft.', 10);
INSERT INTO public.material VALUES (72, 'Pier Cap - Timber', 'Those timber pier caps that support girders that transfer load into piles, or columns. For all timber
pier caps regardless of protective system.', 'ft.', 10);
INSERT INTO public.material VALUES (73, 'Pier Cap - Other', 'Other material pier caps that support girders that transfer load into piles or columns. For all other
material pier caps regardless of protective system.', 'ft.', 10);
INSERT INTO public.material VALUES (74, 'Column - Steel', 'All steel columns regardless of protective system.', 'Each', 11);
INSERT INTO public.material VALUES (75, 'Column - Other', 'All other material columns regardless of protective system.', 'Each', 11);
INSERT INTO public.material VALUES (76, 'Column - Prestressed Concrete', 'All prestressed concrete columns regardless of protective system.', 'Each', 11);
INSERT INTO public.material VALUES (77, 'Column - Reinforced Concrete', 'All reinforced concrete columns regardless of protective system.', 'Each', 11);
INSERT INTO public.material VALUES (78, 'Column - Timber', 'All timber columns regardless of protective system.', 'Each', 11);
INSERT INTO public.material VALUES (79, 'Tower - Steel', 'Steel built up or framed tower supports regardless of protective system.', 'ft.', 11);
INSERT INTO public.material VALUES (80, 'Trestle - Timber', 'Framed timber supports. For all timber trestle/towers regardless of protective system.', 'ft.', 11);
INSERT INTO public.material VALUES (81, 'Pier Wall - Reinforced Concrete', 'Reinforced concrete pier walls regardless of protective systems.', 'ft.', 11);
INSERT INTO public.material VALUES (82, 'Pier Wall - Other', 'Those pier walls constructed of other materials regardless of protective systems.', 'ft.', 11);
INSERT INTO public.material VALUES (83, 'Pier Wall - Timber', 'Those timber pier walls that include pile, timber sheet material, and filler. For all pier walls regardless
of protective systems.', 'ft.', 11);
INSERT INTO public.material VALUES (84, 'Pier Wall - Masonry', 'Those pier walls constructed of block or stone. The block or stone may be placed with or without
mortar. For all pier walls regardless of protective systems.', 'ft.', 11);
INSERT INTO public.material VALUES (85, 'Pile Cap/Footing - Reinforced Concrete', 'Reinforced concrete pile caps/footings that are visible for inspection, including pile caps/footings
exposed from erosion or scour or visible during an underwater inspection. The exposure may be
intentional or caused by erosion or scour.', 'ft.', 12);
INSERT INTO public.material VALUES (86, 'Pile - Steel', 'Steel piles that are visible for inspection, including piles exposed from erosion or scour and piles
visible during an underwater inspection. For all steel piles regardless of protective system.', 'Each', 12);
INSERT INTO public.material VALUES (87, 'Pile - Prestressed Concrete', 'Prestressed concrete piles that are visible for inspection, including piles exposed from erosion or scour
and piles visible during an underwater inspection. For all prestressed concrete piles regardless of
protective system.', 'Each', 12);
INSERT INTO public.material VALUES (88, 'Pile - Reinforced Concrete', 'Reinforced concrete piles that are visible for inspection, including piles exposed from erosion or scour
and piles visible during an underwater inspection are included. For all reinforced concrete piles
regardless of protective system.', 'Each', 12);
INSERT INTO public.material VALUES (89, 'Pile - Timber', 'Timber piles that are visible for inspection, including piles exposed from erosion or scour and piles
visible during an underwater inspection. For all timber piles regardless of protective system.', 'Each', 12);
INSERT INTO public.material VALUES (90, 'Pile - Other', 'Other material piles that are visible for inspection, including piles exposed from erosion or scour and
piles visible during an underwater inspection. For all other material piles regardless of protective
system.', 'Each', 12);
INSERT INTO public.material VALUES (91, 'Pile - Cast in Steel Shell', 'Steel piles filled with concrete. Not for use with steel forms for fully reinforced columns/piles.', 'Each', 12);
INSERT INTO public.material VALUES (92, 'Pile - Cast-In-Drilled-Hole (CIDH)', 'Reinforced concrete piles that are visible for inspection. The exposure may be intentional or caused
by scour.', 'Each', 12);
INSERT INTO public.material VALUES (93, 'Steel Seismic Column Shells (Full Height)', 'Seismic steel confinement shells that are full height.', 'Each', 13);
INSERT INTO public.material VALUES (94, 'Steel Seismic Column Shells (Partial Height)', 'Seismic steel confinement shells that are partial height.', 'Each', 13);
INSERT INTO public.material VALUES (95, 'Slope/Scour Protection', 'All types of erosion/scour protection for the supports; including grouted or ungrouted riprap and
concrete paving under the bridge.', 'EA', 13);
INSERT INTO public.material VALUES (96, 'Culvert - Steel', 'Steel culverts, including arched, round, or elliptical pipes.', 'ft.', 14);
INSERT INTO public.material VALUES (97, 'Culvert - Reinforced Concrete', 'Reinforced concrete culverts, including box, arched, round, or elliptical shapes.', 'ft.', 14);
INSERT INTO public.material VALUES (98, 'Culvert - Timber', 'All timber culverts.', 'ft.', 14);
INSERT INTO public.material VALUES (99, 'Culvert - Other', 'Other material type culverts, including arches, round, or elliptical pipes. These culverts are not
included in steel, concrete, or timber material types.', 'ft.', 14);
INSERT INTO public.material VALUES (100, 'Culvert - Masonry', 'Masonry block or stone culverts.', 'ft.', 14);
INSERT INTO public.material VALUES (101, 'Culvert - Prestressed Concrete', 'All prestressed concrete culverts.', 'ft.', 14);
INSERT INTO public.material VALUES (102, 'Joint - Strip Seal Expansion', 'Those expansion joint devices which utilize a neoprene type waterproof gland with some type of
metal extrusion or other system to anchor the gland.', 'ft.', 15);
INSERT INTO public.material VALUES (103, 'Joint - Pourable Seal', 'Those joints filled with a pourable seal with or without a backer.', 'ft.', 15);
INSERT INTO public.material VALUES (104, 'Joint - Compression Seal', 'Only those joints filled with a preformed compression type seal. This joint may or may not have an
anchor system to confine the seal.', 'ft.', 15);
INSERT INTO public.material VALUES (105, 'Joint - Assembly with Seal', 'Only those joints filled with an assembly mechanism that has a seal.', 'ft.', 15);
INSERT INTO public.material VALUES (106, 'Joint - Open Expansion', 'Only those joints that are open and not sealed.', 'ft.', 15);
INSERT INTO public.material VALUES (107, 'Joint - Assembly Without Seal', 'Only those assembly joints that are open and not sealed, excluding steel finger and sliding plate joints.', 'ft.', 15);
INSERT INTO public.material VALUES (108, 'Joint - Other', 'Only those other joints that are not defined by any other joint element.', 'ft.', 15);
INSERT INTO public.material VALUES (109, 'Joint - Asphaltic Plug', 'Only those joints with a standard asphaltic plug and shall not be used for joints paved over.', 'ft.', 15);
INSERT INTO public.material VALUES (110, 'Joint - Steel Sliding Plates', 'Only those joints that are open and constructed as sliding plate type joints.', 'ft.', 15);
INSERT INTO public.material VALUES (111, 'Joint - Steel Fingers', 'Only those joints that are steel finger joints.', 'ft.', 15);
INSERT INTO public.material VALUES (112, 'Approach Slab - Prestressed Concrete', 'Those structural sections, between the abutment and the approach pavement that are constructed of
prestressed (post-tensioned) reinforced concrete.', 'sq.ft.', 16);
INSERT INTO public.material VALUES (113, 'Approach Slab - Reinforced Concrete', 'Those structural sections between the abutment and the approach pavement that are constructed of
mild steel reinforced concrete.', 'sq.ft.', 16);
INSERT INTO public.material VALUES (114, 'Deck Wearing Surface â Asphaltic Concrete', 'All decks/slabs that have overlays made with flexible (asphaltic concrete).', 'sq. ft.', 17);
INSERT INTO public.material VALUES (115, 'Deck Wearing Surface â Concrete (Polyester)', 'This element is for all decks/slabs that have overlays made with rigid (portland cement) materials or
polyester concrete.', 'sq. ft.', 17);
INSERT INTO public.material VALUES (116, 'Deck Wearing Surface - Epoxy', 'This element is for all decks/slabs that have overlays made with epoxy materials.', 'sq. ft.', 17);
INSERT INTO public.material VALUES (117, 'Deck Wearing Surface - Timber', 'All timber wearing surfaces', 'sq. ft.', 17);
INSERT INTO public.material VALUES (118, 'Steel Protective Coating - Paint', 'Steel elements that have a protective coating such as paint, or other top coat steel corrosion inhibitor.', 'sq. ft. (surface)', 17);
INSERT INTO public.material VALUES (119, 'Steel Protective Coating - Galvanization', 'The element is for steel elements that have a protective galvanized coating system.', 'sq ft. (surface)', 17);
INSERT INTO public.material VALUES (120, 'Steel Protective Coating - Weathering Steel', 'Steel elements that have a protective weathering steel coating.', 'sq.ft. (surface)', 17);
INSERT INTO public.material VALUES (121, 'Reinforcing Steel Protective System
(Rebar Coating/Cathodic)', 'All types of protective systems used to protect reinforcing steel in concrete elements from corrosion.', 'sq.ft.', 17);
INSERT INTO public.material VALUES (122, 'Concrete Protective Coating (Methacrylate/Sealer)', 'Concrete elements that have a penetrating sealer applied to them. These coatings include
silane/siloxane water proofers, crack sealers such as High Molecular Weight Methacrylate (HMWM),
or any top coat barrier that protects concrete from deterioration and reinforcing steel from corrosion.', 'sq.ft. (surface)', 17);
INSERT INTO public.material VALUES (123, 'Deck Membrane', 'Concrete elements that have a protective membrane applied to the member. The typical
configuration is a waterproofing membrane under the AC overlay that protects the concrete from
deterioration and reinforcing steel from corrosion.', 'sq.ft. (surface)', 17);


--
-- Data for Name: observation; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: observation_defect; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: photo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.photo VALUES (1, 'ic_launcher-web.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-10-21 00:00:00', NULL);
INSERT INTO public.photo VALUES (2, 'ic_launcher-web.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-10-22 00:00:00', NULL);
INSERT INTO public.photo VALUES (3, 'ic_launcher-web.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-10-22 00:00:00', NULL);
INSERT INTO public.photo VALUES (4, 'ic_launcher-web.png', 3, 32, 4, 4, 5, 6, 7, '2019-10-22 00:00:00', NULL);
INSERT INTO public.photo VALUES (5, 'AndroidManifest.xml', 2, 2, 2, 2, 2, 2, 2, '2019-10-22 00:00:00', NULL);
INSERT INTO public.photo VALUES (6, 'ic_launcher-web.png', 5, 5, 5, 5, 5, 5, 5, '2019-10-22 00:00:00', NULL);
INSERT INTO public.photo VALUES (7, 'ic_launcher-web.png', 2, 2, 2, 2, 2, 2, 2, '2019-10-22 16:22:59.135', NULL);


--
-- Data for Name: report; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: structural_component; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.structural_component VALUES (1, 'Deck & Slabs (sq. ft.)');
INSERT INTO public.structural_component VALUES (2, 'Railings (ft.)');
INSERT INTO public.structural_component VALUES (3, 'Superstructure');
INSERT INTO public.structural_component VALUES (4, 'Bearings (Ea.)');
INSERT INTO public.structural_component VALUES (5, 'Substructure');
INSERT INTO public.structural_component VALUES (6, 'Culverts (ft.)');
INSERT INTO public.structural_component VALUES (7, 'Joints (ft.)');
INSERT INTO public.structural_component VALUES (8, 'Approach Slabs (sq. ft.)');
INSERT INTO public.structural_component VALUES (9, 'Protective Systems');
INSERT INTO public.structural_component VALUES (10, 'Walkways');
INSERT INTO public.structural_component VALUES (11, 'Soil Condtion');


--
-- Data for Name: structure; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.structure VALUES (1, 'BR-L01', 'Slauson Avenue', 'BRIDGES_AND_AERIAL_STRUCTURE', 'Los Angeles Metropoliten', '53C1924R', 5.20000000000000018, '160+31
(L1 155+29)
(L2 155+52)', '185+59
(190+60)');
INSERT INTO public.structure VALUES (2, 'BR-L02L BR-L02R', 'Firestone Blvd Bridge', 'BRIDGES_AND_AERIAL_STRUCTURE', 'Los Angeles Metropoliten', NULL, 7.20000000000000018, '272+10
(L1 263+20)', '276+19
(L1 286+70)');
INSERT INTO public.structure VALUES (3, 'BR-L03', 'Rosecrans Viaduct', 'BRIDGES_AND_AERIAL_STRUCTURE', 'Los Angeles Metropoliten', NULL, 11.3399999999999999, '473+61
(L1 472+60)
(L2 469+12)', '494+39
(L2 498+88)');
INSERT INTO public.structure VALUES (4, 'BR-L04', 'Compton Creek Bridge', 'BRIDGES_AND_AERIAL_STRUCTURE', 'Los Angeles Metropoliten', NULL, NULL, '578+15
(L1 574+20)', '579+47
(L1 584+90)');
INSERT INTO public.structure VALUES (5, 'BR-L05', 'Dominguez Viaduct', 'BRIDGES_AND_AERIAL_STRUCTURE', 'Los Angeles Metropoliten', NULL, 14.3000000000000007, '637+41
(L1 632+78)
(L2 634+28)', '654+31
(L1 657+85)
(L2 659+24)');
INSERT INTO public.structure VALUES (6, 'BR-L06', 'Del Amo Flyover', 'BRIDGES_AND_AERIAL_STRUCTURE', 'Los Angeles Metropoliten', NULL, 15.4000000000000004, '698+55
(L1 692+60)
(L2 690+62)', '711+67
(L1 713+75)
(L2 716+95)');
INSERT INTO public.structure VALUES (7, 'BR-L07', 'Cota Viaduct', 'BRIDGES_AND_AERIAL_STRUCTURE', 'Los Angeles Metropoliten', '53 2731', 15.9000000000000004, '725+94
(L1 720+00)
(L2 722+15)', '744+87
(L1 750+30)');
INSERT INTO public.structure VALUES (8, 'BR-L08', 'Cota Viaduct', 'BRIDGES_AND_AERIAL_STRUCTURE', 'Los Angeles Metropoliten', NULL, 16.5, '751+85', '760+35');
INSERT INTO public.structure VALUES (9, 'BR-L09', 'Bixby Creek Culvert', 'BRIDGES_AND_AERIAL_STRUCTURE', 'Los Angeles Metropoliten', NULL, NULL, '871+15', '871+45');
INSERT INTO public.structure VALUES (10, 'BR-L10', 'Culvert South of Bixby Creek', 'BRIDGES_AND_AERIAL_STRUCTURE', 'Los Angeles Metropoliten', NULL, NULL, '880+75', NULL);


--
-- Data for Name: structure_component; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.structure_component VALUES (1, 1, 1);
INSERT INTO public.structure_component VALUES (2, 2, 1);
INSERT INTO public.structure_component VALUES (3, 3, 1);
INSERT INTO public.structure_component VALUES (4, 4, 1);
INSERT INTO public.structure_component VALUES (5, 5, 1);
INSERT INTO public.structure_component VALUES (6, 6, 1);
INSERT INTO public.structure_component VALUES (7, 7, 1);
INSERT INTO public.structure_component VALUES (8, 8, 1);
INSERT INTO public.structure_component VALUES (9, 9, 1);
INSERT INTO public.structure_component VALUES (10, 10, 1);
INSERT INTO public.structure_component VALUES (11, 11, 1);
INSERT INTO public.structure_component VALUES (12, 1, 2);
INSERT INTO public.structure_component VALUES (13, 2, 2);
INSERT INTO public.structure_component VALUES (14, 3, 2);
INSERT INTO public.structure_component VALUES (15, 4, 2);
INSERT INTO public.structure_component VALUES (16, 5, 2);
INSERT INTO public.structure_component VALUES (17, 6, 2);
INSERT INTO public.structure_component VALUES (18, 7, 2);
INSERT INTO public.structure_component VALUES (19, 8, 2);
INSERT INTO public.structure_component VALUES (20, 9, 2);
INSERT INTO public.structure_component VALUES (21, 10, 2);
INSERT INTO public.structure_component VALUES (22, 11, 2);
INSERT INTO public.structure_component VALUES (23, 1, 3);
INSERT INTO public.structure_component VALUES (24, 2, 3);
INSERT INTO public.structure_component VALUES (25, 3, 3);
INSERT INTO public.structure_component VALUES (26, 4, 3);
INSERT INTO public.structure_component VALUES (27, 5, 3);
INSERT INTO public.structure_component VALUES (28, 6, 3);
INSERT INTO public.structure_component VALUES (29, 7, 3);
INSERT INTO public.structure_component VALUES (30, 8, 3);
INSERT INTO public.structure_component VALUES (31, 9, 3);
INSERT INTO public.structure_component VALUES (32, 10, 3);
INSERT INTO public.structure_component VALUES (33, 11, 3);
INSERT INTO public.structure_component VALUES (34, 1, 4);
INSERT INTO public.structure_component VALUES (35, 2, 4);
INSERT INTO public.structure_component VALUES (36, 3, 4);
INSERT INTO public.structure_component VALUES (37, 4, 4);
INSERT INTO public.structure_component VALUES (38, 5, 4);
INSERT INTO public.structure_component VALUES (39, 6, 4);
INSERT INTO public.structure_component VALUES (40, 7, 4);
INSERT INTO public.structure_component VALUES (41, 8, 4);
INSERT INTO public.structure_component VALUES (42, 9, 4);
INSERT INTO public.structure_component VALUES (43, 10, 4);
INSERT INTO public.structure_component VALUES (44, 11, 4);
INSERT INTO public.structure_component VALUES (45, 1, 5);
INSERT INTO public.structure_component VALUES (46, 2, 5);
INSERT INTO public.structure_component VALUES (47, 3, 5);
INSERT INTO public.structure_component VALUES (48, 4, 5);
INSERT INTO public.structure_component VALUES (49, 5, 5);
INSERT INTO public.structure_component VALUES (50, 6, 5);
INSERT INTO public.structure_component VALUES (51, 7, 5);
INSERT INTO public.structure_component VALUES (52, 8, 5);
INSERT INTO public.structure_component VALUES (53, 9, 5);
INSERT INTO public.structure_component VALUES (54, 10, 5);
INSERT INTO public.structure_component VALUES (55, 11, 5);
INSERT INTO public.structure_component VALUES (56, 1, 6);
INSERT INTO public.structure_component VALUES (57, 2, 6);
INSERT INTO public.structure_component VALUES (58, 3, 6);
INSERT INTO public.structure_component VALUES (59, 4, 6);
INSERT INTO public.structure_component VALUES (60, 5, 6);
INSERT INTO public.structure_component VALUES (61, 6, 6);
INSERT INTO public.structure_component VALUES (62, 7, 6);
INSERT INTO public.structure_component VALUES (63, 8, 6);
INSERT INTO public.structure_component VALUES (64, 9, 6);
INSERT INTO public.structure_component VALUES (65, 10, 6);
INSERT INTO public.structure_component VALUES (66, 11, 6);
INSERT INTO public.structure_component VALUES (67, 1, 7);
INSERT INTO public.structure_component VALUES (68, 2, 7);
INSERT INTO public.structure_component VALUES (69, 3, 7);
INSERT INTO public.structure_component VALUES (70, 4, 7);
INSERT INTO public.structure_component VALUES (71, 5, 7);
INSERT INTO public.structure_component VALUES (72, 6, 7);
INSERT INTO public.structure_component VALUES (73, 7, 7);
INSERT INTO public.structure_component VALUES (74, 8, 7);
INSERT INTO public.structure_component VALUES (75, 9, 7);
INSERT INTO public.structure_component VALUES (76, 10, 7);
INSERT INTO public.structure_component VALUES (77, 11, 7);
INSERT INTO public.structure_component VALUES (78, 1, 8);
INSERT INTO public.structure_component VALUES (79, 2, 8);
INSERT INTO public.structure_component VALUES (80, 3, 8);
INSERT INTO public.structure_component VALUES (81, 4, 8);
INSERT INTO public.structure_component VALUES (82, 5, 8);
INSERT INTO public.structure_component VALUES (83, 6, 8);
INSERT INTO public.structure_component VALUES (84, 7, 8);
INSERT INTO public.structure_component VALUES (85, 8, 8);
INSERT INTO public.structure_component VALUES (86, 9, 8);
INSERT INTO public.structure_component VALUES (87, 10, 8);
INSERT INTO public.structure_component VALUES (88, 11, 8);
INSERT INTO public.structure_component VALUES (89, 1, 9);
INSERT INTO public.structure_component VALUES (90, 2, 9);
INSERT INTO public.structure_component VALUES (91, 3, 9);
INSERT INTO public.structure_component VALUES (92, 4, 9);
INSERT INTO public.structure_component VALUES (93, 5, 9);
INSERT INTO public.structure_component VALUES (94, 6, 9);
INSERT INTO public.structure_component VALUES (95, 7, 9);
INSERT INTO public.structure_component VALUES (96, 8, 9);
INSERT INTO public.structure_component VALUES (97, 9, 9);
INSERT INTO public.structure_component VALUES (98, 10, 9);
INSERT INTO public.structure_component VALUES (99, 11, 9);
INSERT INTO public.structure_component VALUES (100, 1, 10);
INSERT INTO public.structure_component VALUES (101, 2, 10);
INSERT INTO public.structure_component VALUES (102, 3, 10);
INSERT INTO public.structure_component VALUES (103, 4, 10);
INSERT INTO public.structure_component VALUES (104, 5, 10);
INSERT INTO public.structure_component VALUES (105, 6, 10);
INSERT INTO public.structure_component VALUES (106, 7, 10);
INSERT INTO public.structure_component VALUES (107, 8, 10);
INSERT INTO public.structure_component VALUES (108, 9, 10);
INSERT INTO public.structure_component VALUES (109, 10, 10);
INSERT INTO public.structure_component VALUES (110, 11, 10);


--
-- Data for Name: subcomponent; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.subcomponent VALUES (1, 'N/A', 1);
INSERT INTO public.subcomponent VALUES (2, 'N/A', 2);
INSERT INTO public.subcomponent VALUES (3, 'Girders (ft.)', 3);
INSERT INTO public.subcomponent VALUES (4, 'Trusses / Arches (ft.)', 3);
INSERT INTO public.subcomponent VALUES (5, 'Stringers (ft.)', 3);
INSERT INTO public.subcomponent VALUES (6, 'Floor Beams (ft.)', 3);
INSERT INTO public.subcomponent VALUES (7, 'Miscellaneous Superstructure Elements', 3);
INSERT INTO public.subcomponent VALUES (8, 'N/A', 4);
INSERT INTO public.subcomponent VALUES (9, 'Abutments (ft.)', 5);
INSERT INTO public.subcomponent VALUES (10, 'Pier Caps (ft.)', 5);
INSERT INTO public.subcomponent VALUES (11, 'Columns (Ea.) / Pier Walls (ft.)', 5);
INSERT INTO public.subcomponent VALUES (12, 'Pile Caps (ft.) / Footings (ft.) / Piles (Ea.)', 5);
INSERT INTO public.subcomponent VALUES (13, 'Seismic Shells / Slope & Scour Protection (Ea.)', 5);
INSERT INTO public.subcomponent VALUES (14, 'N/A', 6);
INSERT INTO public.subcomponent VALUES (15, 'N/A', 7);
INSERT INTO public.subcomponent VALUES (16, 'N/A', 8);
INSERT INTO public.subcomponent VALUES (17, 'N/A', 9);
INSERT INTO public.subcomponent VALUES (18, 'N/A', 10);
INSERT INTO public.subcomponent VALUES (19, 'N/A', 11);


--
-- Name: company_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.company_id_seq', 1, false);


--
-- Name: condition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.condition_id_seq', 1, false);


--
-- Name: defect_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.defect_id_seq', 1, false);


--
-- Name: inspection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inspection_id_seq', 1, false);


--
-- Name: inspector_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inspector_id_seq', 1, false);


--
-- Name: material_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.material_id_seq', 1, false);


--
-- Name: observation_defect_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.observation_defect_id_seq', 1, false);


--
-- Name: observation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.observation_id_seq', 1, false);


--
-- Name: photo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.photo_id_seq', 7, true);


--
-- Name: report_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.report_id_seq', 1, false);


--
-- Name: structural_component_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.structural_component_id_seq', 1, false);


--
-- Name: structure_component_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.structure_component_id_seq', 110, true);


--
-- Name: structure_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.structure_id_seq', 1, false);


--
-- Name: subcomponent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subcomponent_id_seq', 1, false);


--
-- Name: company company_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_pk PRIMARY KEY (id);


--
-- Name: condition condition_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.condition
    ADD CONSTRAINT condition_pk PRIMARY KEY (id);


--
-- Name: defect defect_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defect
    ADD CONSTRAINT defect_pk PRIMARY KEY (id);


--
-- Name: inspection inspection_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inspection
    ADD CONSTRAINT inspection_pk PRIMARY KEY (id);


--
-- Name: inspector inspector_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inspector
    ADD CONSTRAINT inspector_pk PRIMARY KEY (id);


--
-- Name: material material_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material
    ADD CONSTRAINT material_pk PRIMARY KEY (id);


--
-- Name: observation_defect observation_defect_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.observation_defect
    ADD CONSTRAINT observation_defect_pk PRIMARY KEY (id);


--
-- Name: observation observation_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.observation
    ADD CONSTRAINT observation_pk PRIMARY KEY (id);


--
-- Name: photo photo_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_pk PRIMARY KEY (id);


--
-- Name: report report_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.report
    ADD CONSTRAINT report_pk PRIMARY KEY (id);


--
-- Name: structural_component structural_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.structural_component
    ADD CONSTRAINT structural_component_pk PRIMARY KEY (id);


--
-- Name: structure_component structure_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.structure_component
    ADD CONSTRAINT structure_component_pk PRIMARY KEY (id);


--
-- Name: structure structure_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.structure
    ADD CONSTRAINT structure_pk PRIMARY KEY (id);


--
-- Name: subcomponent subcomponent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcomponent
    ADD CONSTRAINT subcomponent_pk PRIMARY KEY (id);


--
-- Name: condition_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX condition_id_uindex ON public.condition USING btree (id);


--
-- Name: defect_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX defect_id_uindex ON public.defect USING btree (id);


--
-- Name: inspection_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX inspection_id_uindex ON public.inspection USING btree (id);


--
-- Name: material_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX material_id_uindex ON public.material USING btree (id);


--
-- Name: photo_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX photo_id_uindex ON public.photo USING btree (id);


--
-- Name: structural_component_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX structural_component_id_uindex ON public.structural_component USING btree (id);


--
-- Name: structure_component_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX structure_component_id_uindex ON public.structure_component USING btree (id);


--
-- Name: structure_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX structure_id_uindex ON public.structure USING btree (id);


--
-- PostgreSQL database dump complete
--

