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
    start_date date,
    end_date date,
    structure_id integer,
    status character varying(255),
    company_id integer,
    inspector_id integer,
    general_summary text,
    term_rating character varying(255),
    sgr_rating character varying(255),
    temperature real,
    humidity real,
    wind real
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
    id character varying(50) NOT NULL,
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
    observation_id character varying(255),
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
-- Name: photo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.photo (
    id integer NOT NULL,
    file character varying(255),
    latitude real,
    longitude real,
    altitude real,
    start_x real,
    start_y real,
    end_x real,
    end_y real,
    created_date date,
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
    date date,
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
    id character varying(50) NOT NULL,
    name character varying(255),
    type character varying(255),
    primary_owner character varying(255),
    caltrans_bridge_no character varying(255),
    postmile real,
    begin_stationing character varying(255),
    end_stationing character varying(255)
);


ALTER TABLE public.structure OWNER TO postgres;

--
-- Name: structure_and_component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.structure_and_component (
    structure_id character varying(50) NOT NULL,
    component_id integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.structure_and_component OWNER TO postgres;

--
-- Name: structure_and_component_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.structure_and_component_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.structure_and_component_id_seq OWNER TO postgres;

--
-- Name: structure_and_component_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.structure_and_component_id_seq OWNED BY public.structure_and_component.id;


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
-- Name: structure_and_component id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.structure_and_component ALTER COLUMN id SET DEFAULT nextval('public.structure_and_component_id_seq'::regclass);


--
-- Name: subcomponent id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcomponent ALTER COLUMN id SET DEFAULT nextval('public.subcomponent_id_seq'::regclass);


--
-- Data for Name: company; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.company (id, name) FROM stdin;
\.


--
-- Data for Name: condition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.condition (id, description, type, defect_id) FROM stdin;
1	None	GOOD	1
2	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	1
3	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	1
4	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	1
5	\N	OTHER	1
6	None	GOOD	2
7	Present without measurable section loss.	FAIR	2
8	Present with measurable section loss, but does not warrant structural review.	POOR	2
9	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	2
10	\N	OTHER	2
11	None	GOOD	3
12	Surface white without build-up or leaching without rust staining.	FAIR	3
13	Heavy build-up with rust staining.	POOR	3
14	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	3
15	\N	OTHER	3
16	None or insignificant cracks.	GOOD	4
17	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	4
18	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	4
19	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	4
20	\N	OTHER	4
21	No abrasion or wearing.	GOOD	5
22	Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.	FAIR	5
23	Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.	POOR	5
24	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	5
25	\N	OTHER	5
26	Not applicable	GOOD	6
27	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	6
28	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	6
29	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	6
30	\N	OTHER	6
31	None	GOOD	7
32	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	7
33	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	7
34	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	7
35	\N	OTHER	7
36	None	GOOD	8
37	Present without measurable section loss.	FAIR	8
38	Present with measurable section loss, but does not warrant structural review.	POOR	8
39	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	8
40	\N	OTHER	8
41	None	GOOD	9
42	Present without section loss.	FAIR	9
43	Present with section loss, but does not warrant structural review.	POOR	9
44	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	9
45	\N	OTHER	9
46	None or insignificant cracks.	GOOD	10
47	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.004 to 0.009 inches wide.	FAIR	10
48	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.009 inches wide.	POOR	10
49	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	10
50	\N	OTHER	10
51	None	GOOD	11
52	Surface white without build-up or leaching without rust staining.	FAIR	11
53	Heavy build-up with rust staining.	POOR	11
54	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	11
55	\N	OTHER	11
56	No abrasion or wearing.	GOOD	12
57	Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.	FAIR	12
58	Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.	POOR	12
59	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	12
60	\N	OTHER	12
61	Not applicable	GOOD	13
62	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	13
63	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	13
64	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	13
65	\N	OTHER	13
66	None	GOOD	14
67	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	14
68	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	14
69	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	14
70	\N	OTHER	14
71	None	GOOD	15
72	Present without measurable section loss.	FAIR	15
73	Present with measurable section loss, but does not warrant structural review.	POOR	15
74	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	15
75	\N	OTHER	15
76	None	GOOD	16
77	Present without section loss.	FAIR	16
78	Present with section loss, but does not warrant structural review.	POOR	16
79	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	16
80	\N	OTHER	16
81	None or insignificant cracks.	GOOD	17
82	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.004 to 0.009 inches wide.	FAIR	17
83	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.009 inches wide.	POOR	17
84	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	17
85	\N	OTHER	17
86	None	GOOD	18
87	Surface white without build-up or leaching without rust staining.	FAIR	18
88	Heavy build-up with rust staining.	POOR	18
89	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	18
90	\N	OTHER	18
91	No abrasion or wearing.	GOOD	19
92	Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.	FAIR	19
93	Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.	POOR	19
94	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	19
95	\N	OTHER	19
96	Not applicable	GOOD	20
97	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	20
98	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	20
99	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	20
100	\N	OTHER	20
101	None	GOOD	21
102	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	21
103	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	21
104	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	21
105	\N	OTHER	21
106	None	GOOD	22
107	Present without measurable section loss.	FAIR	22
108	Present with measurable section loss, but does not warrant structural review.	POOR	22
109	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	22
110	\N	OTHER	22
111	None	GOOD	23
112	Surface white without build-up or leaching without rust staining.	FAIR	23
113	Heavy build-up with rust staining.	POOR	23
114	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	23
115	\N	OTHER	23
116	None or insignificant cracks.	GOOD	24
117	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	24
118	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	24
119	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	24
120	\N	OTHER	24
121	No abrasion or wearing.	GOOD	25
122	Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.	FAIR	25
123	Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.	POOR	25
183	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	37
124	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	25
125	\N	OTHER	25
126	Not applicable	GOOD	26
127	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	26
128	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	26
129	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	26
130	\N	OTHER	26
131	None	GOOD	27
132	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	27
133	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	27
134	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	27
135	\N	OTHER	27
136	None	GOOD	28
137	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	28
138	Identified crack exists that is not arrested but does not warrant structural review.	POOR	28
139	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	28
140	\N	OTHER	28
141	Connection is in place and functioning as intended.	GOOD	29
142	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	29
143	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	29
144	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	29
145	\N	OTHER	29
146	Not applicable	GOOD	30
147	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	30
148	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	30
149	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	30
150	\N	OTHER	30
151	None	GOOD	31
152	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	31
153	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	31
154	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	31
155	\N	OTHER	31
156	None	GOOD	32
157	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	32
158	Identified crack exists that is not arrested but does not warrant structural review.	POOR	32
159	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	32
160	\N	OTHER	32
161	Connection is in place and functioning as intended.	GOOD	33
162	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	33
163	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	33
164	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	33
165	\N	OTHER	33
166	Not applicable	GOOD	34
167	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	34
168	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	34
169	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	34
170	\N	OTHER	34
171	None	GOOD	35
172	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	35
173	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	35
174	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	35
175	\N	OTHER	35
176	None	GOOD	36
177	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	36
178	Identified crack exists that is not arrested but does not warrant structural review.	POOR	36
179	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	36
180	\N	OTHER	36
181	Connection is in place and functioning as intended.	GOOD	37
182	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	37
184	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	37
185	\N	OTHER	37
186	Not applicable	GOOD	38
187	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	38
188	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	38
189	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	38
190	\N	OTHER	38
191	Connection is in place and functioning as intended.	GOOD	39
192	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	39
193	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	39
194	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	39
195	\N	OTHER	39
196	None	GOOD	40
197	Affects less than 10% of the member section.	FAIR	40
198	Affects 10% or more of the member but does not warrant structural review.	POOR	40
199	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	40
200	\N	OTHER	40
201	Surface penetration less than 5% of the member thickness regardless of location.	GOOD	41
202	Penetrates 5% - 50% of the thickness of the member and not in a tension zone.	FAIR	41
203	Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.\nDoes not warrant structural review.	POOR	41
204	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	41
205	\N	OTHER	41
206	None	GOOD	42
207	Crack that has been arrested through effective measures.	FAIR	42
208	Identified crack exists that is not arrested, but does not require structural review	POOR	42
209	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	42
210	\N	OTHER	42
211	None	GOOD	43
212	Length less than the member depth or arrested with effective actions taken to mitigate.	FAIR	43
213	Length equal to or greater than the member depth, but does not require structural review.	POOR	43
214	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	43
215	\N	OTHER	43
216	None or no measurable section loss.	GOOD	44
217	Section loss less than 10% of the member thickness.	FAIR	44
218	Section loss 10% or more of the member thickness, but does not warrant structural review.	POOR	44
219	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	44
220	\N	OTHER	44
221	Not applicable	GOOD	45
222	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	45
223	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	45
224	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	45
225	\N	OTHER	45
226	None	GOOD	46
227	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	46
228	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	46
229	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	46
230	\N	OTHER	46
231	None	GOOD	47
232	Present without measurable section loss.	FAIR	47
233	Present with measurable section loss, but does not warrant structural review.	POOR	47
234	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	47
235	\N	OTHER	47
236	None	GOOD	48
237	Surface white without build-up or leaching without rust staining.	FAIR	48
238	Heavy build-up with rust staining.	POOR	48
239	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	48
240	\N	OTHER	48
241	None or insignificant cracks.	GOOD	49
242	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	49
243	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	49
1045	\N	OTHER	209
244	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	49
245	\N	OTHER	49
246	No abrasion or wearing.	GOOD	50
247	Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.	FAIR	50
248	Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.	POOR	50
249	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	50
250	\N	OTHER	50
251	Not applicable	GOOD	51
252	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	51
253	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	51
254	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	51
255	\N	OTHER	51
256	None	GOOD	52
257	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	52
258	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	52
259	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	52
260	\N	OTHER	52
261	None	GOOD	53
262	Present without measurable section loss.	FAIR	53
263	Present with measurable section loss, but does not warrant structural review.	POOR	53
264	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	53
265	\N	OTHER	53
266	None	GOOD	54
267	Present without section loss.	FAIR	54
268	Present with section loss, but does not warrant structural review.	POOR	54
269	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	54
270	\N	OTHER	54
271	None or insignificant cracks.	GOOD	55
272	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.004 to 0.009 inches wide.	FAIR	55
273	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.009 inches wide.	POOR	55
274	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	55
275	\N	OTHER	55
276	None	GOOD	56
277	Surface white without build-up or leaching without rust staining.	FAIR	56
278	Heavy build-up with rust staining.	POOR	56
279	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	56
280	\N	OTHER	56
281	No abrasion or wearing.	GOOD	57
282	Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.	FAIR	57
283	Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.	POOR	57
284	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	57
285	\N	OTHER	57
286	Not applicable	GOOD	58
287	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	58
288	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	58
289	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	58
290	\N	OTHER	58
291	Connection is in place and functioning as intended.	GOOD	59
292	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	59
293	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	59
294	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	59
295	\N	OTHER	59
296	None	GOOD	60
297	Affects less than 10% of the member section.	FAIR	60
298	Affects 10% or more of the member but does not warrant structural review.	POOR	60
299	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	60
300	\N	OTHER	60
301	Surface penetration less than 5% of the member thickness regardless of location.	GOOD	61
302	Penetrates 5% - 50% of the thickness of the member and not in a tension zone.	FAIR	61
303	Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.\nDoes not warrant structural review.	POOR	61
304	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	61
305	\N	OTHER	61
306	None	GOOD	62
307	Crack that has been arrested through effective measures.	FAIR	62
308	Identified crack exists that is not arrested, but does not require structural review	POOR	62
309	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	62
310	\N	OTHER	62
311	None	GOOD	63
312	Length less than the member depth or arrested with effective actions taken to mitigate.	FAIR	63
313	Length equal to or greater than the member depth, but does not require structural review.	POOR	63
314	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	63
315	\N	OTHER	63
316	None or no measurable section loss.	GOOD	64
317	Section loss less than 10% of the member thickness.	FAIR	64
318	Section loss 10% or more of the member thickness, but does not warrant structural review.	POOR	64
319	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	64
320	\N	OTHER	64
321	Not applicable	GOOD	65
322	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	65
323	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	65
324	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	65
325	\N	OTHER	65
326	None	GOOD	66
327	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	66
328	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	66
329	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	66
330	\N	OTHER	66
331	None	GOOD	67
332	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	67
333	Identified crack exists that is not arrested but does not warrant structural review.	POOR	67
334	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	67
335	\N	OTHER	67
336	Connection is in place and functioning as intended.	GOOD	68
337	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	68
338	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	68
339	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	68
340	\N	OTHER	68
341	None or insignificant cracks.	GOOD	69
342	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	69
343	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	69
344	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	69
345	\N	OTHER	69
346	None	GOOD	70
347	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	70
348	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	70
349	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	70
350	\N	OTHER	70
351	None	GOOD	71
352	Surface white without build-up or leaching without rust staining.	FAIR	71
353	Heavy build-up with rust staining.	POOR	71
354	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	71
355	\N	OTHER	71
356	None	GOOD	72
357	Initiated breakdown or deterioration.	FAIR	72
358	Significant deterioration or breakdown, but does not warrant structural review.	POOR	72
359		SEVERE	72
360	\N	OTHER	72
361	Not applicable	GOOD	73
362	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	73
363	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	73
364	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	73
365	\N	OTHER	73
366	None	GOOD	74
367	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	74
368	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	74
369	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	74
370	\N	OTHER	74
371	None	GOOD	75
372	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	75
373	Identified crack exists that is not arrested but does not warrant structural review.	POOR	75
374	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	75
375	\N	OTHER	75
376	Connection is in place and functioning as intended.	GOOD	76
377	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	76
378	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	76
379	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	76
380	\N	OTHER	76
381	None	GOOD	77
382	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	77
383	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	77
384	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	77
385	\N	OTHER	77
386	None or insignificant cracks.	GOOD	78
387	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	78
388	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	78
389	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	78
390	\N	OTHER	78
391	None	GOOD	79
392	Initiated breakdown or deterioration.	FAIR	79
393	Significant deterioration or breakdown, but does not warrant structural review.	POOR	79
394		SEVERE	79
395	\N	OTHER	79
396	None	GOOD	80
397	Surface white without build-up or leaching without rust staining.	FAIR	80
398	Heavy build-up with rust staining.	POOR	80
399	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	80
400	\N	OTHER	80
401	Not applicable	GOOD	81
402	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	81
403	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	81
404	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	81
405	\N	OTHER	81
406	None	GOOD	82
407	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	82
408	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	82
409	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	82
410	\N	OTHER	82
411	None	GOOD	83
412	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	83
413	Identified crack exists that is not arrested but does not warrant structural review.	POOR	83
414	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	83
415	\N	OTHER	83
416	Connection is in place and functioning as intended.	GOOD	84
417	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	84
418	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	84
419	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	84
420	\N	OTHER	84
421	None	GOOD	85
422	Distortion not requiring mitigation or mitigated distortion.	FAIR	85
423	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	85
424	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	85
425	\N	OTHER	85
426	Not applicable	GOOD	86
427	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	86
552	Surface white without build-up or leaching without rust staining.	FAIR	111
428	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	86
429	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	86
430	\N	OTHER	86
431	None	GOOD	87
432	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	87
433	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	87
434	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	87
435	\N	OTHER	87
436	None	GOOD	88
437	Present without measurable section loss.	FAIR	88
438	Present with measurable section loss, but does not warrant structural review.	POOR	88
439	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	88
440	\N	OTHER	88
441	None	GOOD	89
442	Surface white without build-up or leaching without rust staining.	FAIR	89
443	Heavy build-up with rust staining.	POOR	89
444	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	89
445	\N	OTHER	89
446	None or insignificant cracks.	GOOD	90
447	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	90
448	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	90
449	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	90
450	\N	OTHER	90
451	No abrasion or wearing.	GOOD	91
452	Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.	FAIR	91
453	Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.	POOR	91
454	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	91
455	\N	OTHER	91
456	Not applicable	GOOD	92
457	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	92
458	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	92
459	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	92
460	\N	OTHER	92
461	Connection is in place and functioning as intended.	GOOD	93
462	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	93
463	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	93
464	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	93
465	\N	OTHER	93
466	None	GOOD	94
467	Affects less than 10% of the member section.	FAIR	94
468	Affects 10% or more of the member but does not warrant structural review.	POOR	94
469	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	94
470	\N	OTHER	94
471	Surface penetration less than 5% of the member thickness regardless of location.	GOOD	95
472	Penetrates 5% - 50% of the thickness of the member and not in a tension zone.	FAIR	95
473	Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.\nDoes not warrant structural review.	POOR	95
474	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	95
475	\N	OTHER	95
476	None	GOOD	96
477	Crack that has been arrested through effective measures.	FAIR	96
478	Identified crack exists that is not arrested, but does not require structural review	POOR	96
479	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	96
480	\N	OTHER	96
481	None	GOOD	97
482	Length less than the member depth or arrested with effective actions taken to mitigate.	FAIR	97
483	Length equal to or greater than the member depth, but does not require structural review.	POOR	97
484	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	97
485	\N	OTHER	97
486	None or no measurable section loss.	GOOD	98
487	Section loss less than 10% of the member thickness.	FAIR	98
488	Section loss 10% or more of the member thickness, but does not warrant structural review.	POOR	98
489	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	98
490	\N	OTHER	98
491	Not applicable	GOOD	99
492	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	99
493	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	99
494	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	99
495	\N	OTHER	99
496	None	GOOD	100
497	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	100
498	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	100
499	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	100
500	\N	OTHER	100
501	None	GOOD	101
502	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	101
503	Identified crack exists that is not arrested but does not warrant structural review.	POOR	101
504	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	101
505	\N	OTHER	101
506	Connection is in place and functioning as intended.	GOOD	102
507	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	102
508	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	102
509	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	102
510	\N	OTHER	102
511	None	GOOD	103
512	Surface white without build-up or leaching without rust staining.	FAIR	103
513	Heavy build-up with rust staining.	POOR	103
514	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	103
515	\N	OTHER	103
516	None or insignificant cracks.	GOOD	104
517	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	104
518	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	104
519	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	104
520	\N	OTHER	104
521	No abrasion or wearing.	GOOD	105
522	Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.	FAIR	105
523	Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.	POOR	105
524	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	105
525	\N	OTHER	105
526	None	GOOD	106
527	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	106
528	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	106
529	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	106
530	\N	OTHER	106
531	None	GOOD	107
532	Present without measurable section loss.	FAIR	107
533	Present with measurable section loss, but does not warrant structural review.	POOR	107
534	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	107
535	\N	OTHER	107
536	None	GOOD	108
537	Initiated breakdown or deterioration.	FAIR	108
538	Significant deterioration or breakdown, but does not warrant structural review.	POOR	108
539		SEVERE	108
540	\N	OTHER	108
541	None	GOOD	109
542	Distortion not requiring mitigation or mitigated distortion.	FAIR	109
543	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	109
544	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	109
545	\N	OTHER	109
546	Not applicable	GOOD	110
547	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	110
548	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	110
549	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	110
550	\N	OTHER	110
551	None	GOOD	111
553	Heavy build-up with rust staining.	POOR	111
554	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	111
555	\N	OTHER	111
556	None	GOOD	112
557	Cracking or voids in less than 10% of joints.	FAIR	112
558	Cracking or voids in 10% or more of the of joints	POOR	112
559	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	112
560	\N	OTHER	112
561	None	GOOD	113
562	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	113
563	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	113
564	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	113
565	\N	OTHER	113
566	None	GOOD	114
567	Block or stone has split or spalled with no shifting.	FAIR	114
568	Block or stone has split or spalled with shifting but does not warrant a structural review.	POOR	114
569	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	114
570	\N	OTHER	114
571	None	GOOD	115
572	Sound Patch	FAIR	115
573	Unsound Patch	POOR	115
574	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	115
575	\N	OTHER	115
576	None	GOOD	116
577	Block or stone has shifted slightly out of alignment.	FAIR	116
578	Block or stone has shifted significantly out of alignment or is missing but does not warrant structural review.	POOR	116
579	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	116
580	\N	OTHER	116
581	None	GOOD	117
582	Distortion not requiring mitigation or mitigated distortion.	FAIR	117
583	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	117
584	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	117
585	\N	OTHER	117
586	Not applicable	GOOD	118
587	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	118
588	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	118
589	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	118
590	\N	OTHER	118
591	None	GOOD	119
592	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	119
593	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	119
594	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	119
595	\N	OTHER	119
596	None	GOOD	120
597	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	120
598	Identified crack exists that is not arrested but does not warrant structural review.	POOR	120
599	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	120
600	\N	OTHER	120
601	Connection is in place and functioning as intended.	GOOD	121
602	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	121
603	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	121
604	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	121
605	\N	OTHER	121
606	None	GOOD	122
607	Distortion not requiring mitigation or mitigated distortion.	FAIR	122
608	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	122
609	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	122
610	\N	OTHER	122
611	Not applicable	GOOD	123
612	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	123
613	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	123
982	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	197
614	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	123
615	\N	OTHER	123
616	None	GOOD	124
617	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	124
618	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	124
619	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	124
620	\N	OTHER	124
621	None	GOOD	125
622	Present without measurable section loss.	FAIR	125
623	Present with measurable section loss, but does not warrant structural review.	POOR	125
624	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	125
625	\N	OTHER	125
626	None	GOOD	126
627	Present without section loss.	FAIR	126
628	Present with section loss, but does not warrant structural review.	POOR	126
629	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	126
630	\N	OTHER	126
631	None or insignificant cracks.	GOOD	127
632	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.004 to 0.009 inches wide.	FAIR	127
633	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.009 inches wide.	POOR	127
634	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	127
635	\N	OTHER	127
636	None	GOOD	128
637	Surface white without build-up or leaching without rust staining.	FAIR	128
638	Heavy build-up with rust staining.	POOR	128
639	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	128
640	\N	OTHER	128
641	Not applicable	GOOD	129
642	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	129
643	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	129
644	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	129
645	\N	OTHER	129
646	None	GOOD	130
647	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	130
648	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	130
649	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	130
650	\N	OTHER	130
651	None	GOOD	131
652	Present without measurable section loss.	FAIR	131
653	Present with measurable section loss, but does not warrant structural review.	POOR	131
654	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	131
655	\N	OTHER	131
656	None	GOOD	132
657	Surface white without build-up or leaching without rust staining.	FAIR	132
658	Heavy build-up with rust staining.	POOR	132
659	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	132
660	\N	OTHER	132
661	None or insignificant cracks.	GOOD	133
662	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	133
663	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	133
664	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	133
665	\N	OTHER	133
666	Not applicable	GOOD	134
667	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	134
668	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	134
669	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	134
670	\N	OTHER	134
671	None	GOOD	135
672	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	135
673	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	135
674	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	135
675	\N	OTHER	135
676	None	GOOD	136
677	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	136
678	Identified crack exists that is not arrested but does not warrant structural review.	POOR	136
679	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	136
680	\N	OTHER	136
681	Connection is in place and functioning as intended.	GOOD	137
682	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	137
683	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	137
684	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	137
685	\N	OTHER	137
686	None	GOOD	138
687	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	138
688	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	138
689	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	138
690	\N	OTHER	138
691	None	GOOD	139
692	Surface white without build-up or leaching without rust staining.	FAIR	139
693	Heavy build-up with rust staining.	POOR	139
694	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	139
695	\N	OTHER	139
696	None or insignificant cracks.	GOOD	140
697	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	140
698	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	140
699	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	140
700	\N	OTHER	140
701	None	GOOD	141
702	Initiated breakdown or deterioration.	FAIR	141
703	Significant deterioration or breakdown, but does not warrant structural review.	POOR	141
704		SEVERE	141
705	\N	OTHER	141
706	None	GOOD	142
707	Distortion not requiring mitigation or mitigated distortion.	FAIR	142
708	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	142
709	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	142
710	\N	OTHER	142
711	Not applicable	GOOD	143
712	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	143
713	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	143
714	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	143
715	\N	OTHER	143
716	None	GOOD	144
717	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	144
718	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	144
719	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	144
720	\N	OTHER	144
721	None	GOOD	145
722	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	145
723	Identified crack exists that is not arrested but does not warrant structural review.	POOR	145
724	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	145
725	\N	OTHER	145
726	Connection is in place and functioning as intended.	GOOD	146
727	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	146
728	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	146
729	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	146
730	\N	OTHER	146
731	None	GOOD	147
732	Distortion not requiring mitigation or mitigated distortion.	FAIR	147
733	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	147
734	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	147
735	\N	OTHER	147
736	Not applicable	GOOD	148
737	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	148
1046	Not applicable	GOOD	210
738	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	148
739	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	148
740	\N	OTHER	148
741	None	GOOD	149
742	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	149
743	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	149
744	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	149
745	\N	OTHER	149
746	None	GOOD	150
747	Present without measurable section loss.	FAIR	150
748	Present with measurable section loss, but does not warrant structural review.	POOR	150
749	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	150
750	\N	OTHER	150
751	None	GOOD	151
752	Present without section loss.	FAIR	151
753	Present with section loss, but does not warrant structural review.	POOR	151
754	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	151
755	\N	OTHER	151
756	None or insignificant cracks.	GOOD	152
757	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.004 to 0.009 inches wide.	FAIR	152
758	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.009 inches wide.	POOR	152
759	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	152
760	\N	OTHER	152
761	None	GOOD	153
762	Surface white without build-up or leaching without rust staining.	FAIR	153
763	Heavy build-up with rust staining.	POOR	153
764	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	153
765	\N	OTHER	153
766	Not applicable	GOOD	154
767	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	154
768	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	154
769	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	154
770	\N	OTHER	154
771	None	GOOD	155
772	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	155
773	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	155
774	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	155
775	\N	OTHER	155
776	None	GOOD	156
777	Present without measurable section loss.	FAIR	156
778	Present with measurable section loss, but does not warrant structural review.	POOR	156
779	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	156
780	\N	OTHER	156
781	None	GOOD	157
782	Surface white without build-up or leaching without rust staining.	FAIR	157
783	Heavy build-up with rust staining.	POOR	157
784	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	157
785	\N	OTHER	157
786	None or insignificant cracks.	GOOD	158
787	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	158
788	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	158
789	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	158
790	\N	OTHER	158
791	Not applicable	GOOD	159
792	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	159
793	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	159
794	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	159
795	\N	OTHER	159
796	Connection is in place and functioning as intended.	GOOD	160
797	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	160
798	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	160
1171	None or no measurable section loss.	GOOD	235
799	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	160
800	\N	OTHER	160
801	None	GOOD	161
802	Affects less than 10% of the member section.	FAIR	161
803	Affects 10% or more of the member but does not warrant structural review.	POOR	161
804	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	161
805	\N	OTHER	161
806	Surface penetration less than 5% of the member thickness regardless of location.	GOOD	162
807	Penetrates 5% - 50% of the thickness of the member and not in a tension zone.	FAIR	162
808	Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.\nDoes not warrant structural review.	POOR	162
809	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	162
810	\N	OTHER	162
811	None	GOOD	163
812	Crack that has been arrested through effective measures.	FAIR	163
813	Identified crack exists that is not arrested, but does not require structural review	POOR	163
814	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	163
815	\N	OTHER	163
816	None	GOOD	164
817	Length less than the member depth or arrested with effective actions taken to mitigate.	FAIR	164
818	Length equal to or greater than the member depth, but does not require structural review.	POOR	164
819	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	164
820	\N	OTHER	164
821	None or no measurable section loss.	GOOD	165
822	Section loss less than 10% of the member thickness.	FAIR	165
823	Section loss 10% or more of the member thickness, but does not warrant structural review.	POOR	165
824	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	165
825	\N	OTHER	165
826	Not applicable	GOOD	166
827	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	166
828	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	166
829	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	166
830	\N	OTHER	166
831	None	GOOD	167
832	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	167
833	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	167
834	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	167
835	\N	OTHER	167
836	None	GOOD	168
837	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	168
838	Identified crack exists that is not arrested but does not warrant structural review.	POOR	168
839	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	168
840	\N	OTHER	168
841	Connection is in place and functioning as intended.	GOOD	169
842	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	169
843	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	169
844	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	169
845	\N	OTHER	169
846	None	GOOD	170
847	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	170
848	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	170
849	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	170
850	\N	OTHER	170
851	None	GOOD	171
852	Surface white without build-up or leaching without rust staining.	FAIR	171
853	Heavy build-up with rust staining.	POOR	171
854	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	171
855	\N	OTHER	171
856	None or insignificant cracks.	GOOD	172
857	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	172
858	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	172
1172	Section loss less than 10% of the member thickness.	FAIR	235
859	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	172
860	\N	OTHER	172
861	None	GOOD	173
862	Initiated breakdown or deterioration.	FAIR	173
863	Significant deterioration or breakdown, but does not warrant structural review.	POOR	173
864		SEVERE	173
865	\N	OTHER	173
866	None	GOOD	174
867	Distortion not requiring mitigation or mitigated distortion.	FAIR	174
868	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	174
869	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	174
870	\N	OTHER	174
871	Not applicable	GOOD	175
872	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	175
873	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	175
874	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	175
875	\N	OTHER	175
876	None	GOOD	176
877	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	176
878	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	176
879	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	176
880	\N	OTHER	176
881	None	GOOD	177
882	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	177
883	Identified crack exists that is not arrested but does not warrant structural review.	POOR	177
884	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	177
885	\N	OTHER	177
886	Connection is in place and functioning as intended.	GOOD	178
887	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	178
888	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	178
889	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	178
890	\N	OTHER	178
891	None	GOOD	179
892	Distortion not requiring mitigation or mitigated distortion.	FAIR	179
893	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	179
894	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	179
895	\N	OTHER	179
896	Not applicable	GOOD	180
897	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	180
898	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	180
899	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	180
900	\N	OTHER	180
901	Connection is in place and functioning as intended.	GOOD	181
902	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	181
903	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	181
904	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	181
905	\N	OTHER	181
906	None	GOOD	182
907	Affects less than 10% of the member section.	FAIR	182
908	Affects 10% or more of the member but does not warrant structural review.	POOR	182
909	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	182
910	\N	OTHER	182
911	Surface penetration less than 5% of the member thickness regardless of location.	GOOD	183
912	Penetrates 5% - 50% of the thickness of the member and not in a tension zone.	FAIR	183
913	Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.\nDoes not warrant structural review.	POOR	183
914	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	183
915	\N	OTHER	183
916	None	GOOD	184
917	Crack that has been arrested through effective measures.	FAIR	184
918	Identified crack exists that is not arrested, but does not require structural review	POOR	184
983	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	197
1173	Section loss 10% or more of the member thickness, but does not warrant structural review.	POOR	235
919	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	184
920	\N	OTHER	184
921	None	GOOD	185
922	Length less than the member depth or arrested with effective actions taken to mitigate.	FAIR	185
923	Length equal to or greater than the member depth, but does not require structural review.	POOR	185
924	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	185
925	\N	OTHER	185
926	None or no measurable section loss.	GOOD	186
927	Section loss less than 10% of the member thickness.	FAIR	186
928	Section loss 10% or more of the member thickness, but does not warrant structural review.	POOR	186
929	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	186
930	\N	OTHER	186
931	Not applicable	GOOD	187
932	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	187
933	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	187
934	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	187
935	\N	OTHER	187
936	None	GOOD	188
937	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	188
938	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	188
939	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	188
940	\N	OTHER	188
941	None	GOOD	189
942	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	189
943	Identified crack exists that is not arrested but does not warrant structural review.	POOR	189
944	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	189
945	\N	OTHER	189
946	Connection is in place and functioning as intended.	GOOD	190
947	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	190
948	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	190
949	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	190
950	\N	OTHER	190
951	None	GOOD	191
952	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	191
953	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	191
954	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	191
955	\N	OTHER	191
956	None	GOOD	192
957	Surface white without build-up or leaching without rust staining.	FAIR	192
958	Heavy build-up with rust staining.	POOR	192
959	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	192
960	\N	OTHER	192
961	None or insignificant cracks.	GOOD	193
962	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	193
963	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	193
964	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	193
965	\N	OTHER	193
966	None	GOOD	194
967	Initiated breakdown or deterioration.	FAIR	194
968	Significant deterioration or breakdown, but does not warrant structural review.	POOR	194
969		SEVERE	194
970	\N	OTHER	194
971	None	GOOD	195
972	Distortion not requiring mitigation or mitigated distortion.	FAIR	195
973	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	195
974	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	195
975	\N	OTHER	195
976	Not applicable	GOOD	196
977	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	196
978	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	196
979	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	196
980	\N	OTHER	196
981	None	GOOD	197
984	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	197
985	\N	OTHER	197
986	None	GOOD	198
987	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	198
988	Identified crack exists that is not arrested but does not warrant structural review.	POOR	198
989	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	198
990	\N	OTHER	198
991	Connection is in place and functioning as intended.	GOOD	199
992	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	199
993	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	199
994	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	199
995	\N	OTHER	199
996	None	GOOD	200
997	Distortion not requiring mitigation or mitigated distortion.	FAIR	200
998	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	200
999	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	200
1000	\N	OTHER	200
1001	Not applicable	GOOD	201
1002	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	201
1003	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	201
1004	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	201
1005	\N	OTHER	201
1006	None	GOOD	202
1007	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	202
1008	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	202
1009	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	202
1010	\N	OTHER	202
1011	None	GOOD	203
1012	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	203
1013	Identified crack exists that is not arrested but does not warrant structural review.	POOR	203
1014	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	203
1015	\N	OTHER	203
1016	Connection is in place and functioning as intended.	GOOD	204
1017	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	204
1018	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	204
1019	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	204
1020	\N	OTHER	204
1021	None or insignificant cracks.	GOOD	205
1022	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	205
1023	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	205
1024	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	205
1025	\N	OTHER	205
1026	None	GOOD	206
1027	Initiated breakdown or deterioration.	FAIR	206
1028	Significant deterioration or breakdown, but does not warrant structural review.	POOR	206
1029		SEVERE	206
1030	\N	OTHER	206
1031	None	GOOD	207
1032	Distortion not requiring mitigation or mitigated distortion.	FAIR	207
1033	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	207
1034	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	207
1035	\N	OTHER	207
1036	None	GOOD	208
1037	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	208
1038	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	208
1039	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	208
1040	\N	OTHER	208
1041	None	GOOD	209
1042	Surface white without build-up or leaching without rust staining.	FAIR	209
1043	Heavy build-up with rust staining.	POOR	209
1044	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	209
1047	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	210
1048	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	210
1049	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	210
1050	\N	OTHER	210
1051	None	GOOD	211
1052	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	211
1053	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	211
1054	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	211
1055	\N	OTHER	211
1056	None	GOOD	212
1057	Present without measurable section loss.	FAIR	212
1058	Present with measurable section loss, but does not warrant structural review.	POOR	212
1059	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	212
1060	\N	OTHER	212
1061	None	GOOD	213
1062	Present without section loss.	FAIR	213
1063	Present with section loss, but does not warrant structural review.	POOR	213
1064	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	213
1065	\N	OTHER	213
1066	None or insignificant cracks.	GOOD	214
1067	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.004 to 0.009 inches wide.	FAIR	214
1068	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.009 inches wide.	POOR	214
1069	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	214
1070	\N	OTHER	214
1071	None	GOOD	215
1072	Surface white without build-up or leaching without rust staining.	FAIR	215
1073	Heavy build-up with rust staining.	POOR	215
1074	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	215
1075	\N	OTHER	215
1076	No abrasion or wearing.	GOOD	216
1077	Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.	FAIR	216
1078	Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.	POOR	216
1079	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	216
1080	\N	OTHER	216
1081	Not applicable	GOOD	217
1082	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	217
1083	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	217
1084	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	217
1085	\N	OTHER	217
1086	None	GOOD	218
1087	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	218
1088	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	218
1089	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	218
1090	\N	OTHER	218
1091	None	GOOD	219
1092	Present without measurable section loss.	FAIR	219
1093	Present with measurable section loss, but does not warrant structural review.	POOR	219
1094	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	219
1095	\N	OTHER	219
1096	None	GOOD	220
1097	Surface white without build-up or leaching without rust staining.	FAIR	220
1098	Heavy build-up with rust staining.	POOR	220
1099	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	220
1100	\N	OTHER	220
1101	None or insignificant cracks.	GOOD	221
1102	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	221
1103	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	221
1104	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	221
1105	\N	OTHER	221
1106	No abrasion or wearing.	GOOD	222
1107	Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.	FAIR	222
1108	Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.	POOR	222
1109	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	222
1110	\N	OTHER	222
1111	Not applicable	GOOD	223
1112	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	223
1113	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	223
1114	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	223
1115	\N	OTHER	223
1116	None	GOOD	224
1117	Surface white without build-up or leaching without rust staining.	FAIR	224
1118	Heavy build-up with rust staining.	POOR	224
1119	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	224
1120	\N	OTHER	224
1121	None	GOOD	225
1122	Cracking or voids in less than 10% of joints.	FAIR	225
1123	Cracking or voids in 10% or more of the of joints	POOR	225
1124	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	225
1125	\N	OTHER	225
1126	None	GOOD	226
1127	Block or stone has split or spalled with no shifting.	FAIR	226
1128	Block or stone has split or spalled with shifting but does not warrant a structural review.	POOR	226
1129	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	226
1130	\N	OTHER	226
1131	None	GOOD	227
1132	Sound Patch	FAIR	227
1133	Unsound Patch	POOR	227
1134	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	227
1135	\N	OTHER	227
1136	None	GOOD	228
1137	Block or stone has shifted slightly out of alignment.	FAIR	228
1138	Block or stone has shifted significantly out of alignment or is missing but does not warrant structural review.	POOR	228
1139	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	228
1140	\N	OTHER	228
1141	Not applicable	GOOD	229
1142	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	229
1143	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	229
1144	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	229
1145	\N	OTHER	229
1146	Connection is in place and functioning as intended.	GOOD	230
1147	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	230
1148	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	230
1149	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	230
1150	\N	OTHER	230
1151	None	GOOD	231
1152	Affects less than 10% of the member section.	FAIR	231
1153	Affects 10% or more of the member but does not warrant structural review.	POOR	231
1154	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	231
1155	\N	OTHER	231
1156	Surface penetration less than 5% of the member thickness regardless of location.	GOOD	232
1157	Penetrates 5% - 50% of the thickness of the member and not in a tension zone.	FAIR	232
1158	Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.\nDoes not warrant structural review.	POOR	232
1159	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	232
1160	\N	OTHER	232
1161	None	GOOD	233
1162	Crack that has been arrested through effective measures.	FAIR	233
1163	Identified crack exists that is not arrested, but does not require structural review	POOR	233
1164	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	233
1165	\N	OTHER	233
1166	None	GOOD	234
1167	Length less than the member depth or arrested with effective actions taken to mitigate.	FAIR	234
1168	Length equal to or greater than the member depth, but does not require structural review.	POOR	234
1169	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	234
1170	\N	OTHER	234
1174	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	235
1175	\N	OTHER	235
1176	Not applicable	GOOD	236
1177	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	236
1178	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	236
1179	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	236
1180	\N	OTHER	236
1181	None	GOOD	237
1182	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	237
1183	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	237
1184	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	237
1185	\N	OTHER	237
1186	None	GOOD	238
1187	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	238
1188	Identified crack exists that is not arrested but does not warrant structural review.	POOR	238
1189	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	238
1190	\N	OTHER	238
1191	Connection is in place and functioning as intended.	GOOD	239
1192	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	239
1193	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	239
1194	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	239
1195	\N	OTHER	239
1196	None	GOOD	240
1197	Distortion not requiring mitigation or mitigated distortion.	FAIR	240
1198	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	240
1199	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	240
1200	\N	OTHER	240
1201	Not applicable	GOOD	241
1202	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	241
1203	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	241
1204	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	241
1205	\N	OTHER	241
1206	None	GOOD	242
1207	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	242
1208	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	242
1209	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	242
1210	\N	OTHER	242
1211	None	GOOD	243
1212	Present without measurable section loss.	FAIR	243
1213	Present with measurable section loss, but does not warrant structural review.	POOR	243
1214	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	243
1215	\N	OTHER	243
1216	None	GOOD	244
1217	Present without section loss.	FAIR	244
1218	Present with section loss, but does not warrant structural review.	POOR	244
1219	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	244
1220	\N	OTHER	244
1221	None or insignificant cracks.	GOOD	245
1222	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.004 to 0.009 inches wide.	FAIR	245
1223	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.009 inches wide.	POOR	245
1224	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	245
1225	\N	OTHER	245
1226	None	GOOD	246
1227	Surface white without build-up or leaching without rust staining.	FAIR	246
1228	Heavy build-up with rust staining.	POOR	246
1229	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	246
1230	\N	OTHER	246
1231	Not applicable	GOOD	247
1232	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	247
1233	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	247
1234	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	247
1235	\N	OTHER	247
1236	None	GOOD	248
1237	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	248
1238	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	248
1239	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	248
1240	\N	OTHER	248
1241	None	GOOD	249
1242	Present without measurable section loss.	FAIR	249
1243	Present with measurable section loss, but does not warrant structural review.	POOR	249
1244	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	249
1245	\N	OTHER	249
1246	None	GOOD	250
1247	Surface white without build-up or leaching without rust staining.	FAIR	250
1248	Heavy build-up with rust staining.	POOR	250
1249	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	250
1250	\N	OTHER	250
1251	None or insignificant cracks.	GOOD	251
1252	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	251
1253	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	251
1254	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	251
1255	\N	OTHER	251
1256	Not applicable	GOOD	252
1257	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	252
1258	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	252
1259	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	252
1260	\N	OTHER	252
1261	Connection is in place and functioning as intended.	GOOD	253
1262	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	253
1263	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	253
1264	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	253
1265	\N	OTHER	253
1266	None	GOOD	254
1267	Affects less than 10% of the member section.	FAIR	254
1268	Affects 10% or more of the member but does not warrant structural review.	POOR	254
1269	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	254
1270	\N	OTHER	254
1271	Surface penetration less than 5% of the member thickness regardless of location.	GOOD	255
1272	Penetrates 5% - 50% of the thickness of the member and not in a tension zone.	FAIR	255
1273	Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.\nDoes not warrant structural review.	POOR	255
1274	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	255
1275	\N	OTHER	255
1276	None	GOOD	256
1277	Crack that has been arrested through effective measures.	FAIR	256
1278	Identified crack exists that is not arrested, but does not require structural review	POOR	256
1279	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	256
1280	\N	OTHER	256
1281	None	GOOD	257
1282	Length less than the member depth or arrested with effective actions taken to mitigate.	FAIR	257
1283	Length equal to or greater than the member depth, but does not require structural review.	POOR	257
1284	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	257
1285	\N	OTHER	257
1286	None or no measurable section loss.	GOOD	258
1287	Section loss less than 10% of the member thickness.	FAIR	258
1288	Section loss 10% or more of the member thickness, but does not warrant structural review.	POOR	258
1289	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	258
1290	\N	OTHER	258
1291	Not applicable	GOOD	259
1292	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	259
1293	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	259
1601	Not applicable	GOOD	321
1294	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	259
1295	\N	OTHER	259
1296	None	GOOD	260
1297	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	260
1298	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	260
1299	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	260
1300	\N	OTHER	260
1301	None	GOOD	261
1302	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	261
1303	Identified crack exists that is not arrested but does not warrant structural review.	POOR	261
1304	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	261
1305	\N	OTHER	261
1306	Connection is in place and functioning as intended.	GOOD	262
1307	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	262
1308	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	262
1309	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	262
1310	\N	OTHER	262
1311	None	GOOD	263
1312	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	263
1313	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	263
1314	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	263
1315	\N	OTHER	263
1316	None	GOOD	264
1317	Surface white without build-up or leaching without rust staining.	FAIR	264
1318	Heavy build-up with rust staining.	POOR	264
1319	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	264
1320	\N	OTHER	264
1321	None or insignificant cracks.	GOOD	265
1322	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	265
1323	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	265
1324	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	265
1325	\N	OTHER	265
1326	None	GOOD	266
1327	Initiated breakdown or deterioration.	FAIR	266
1328	Significant deterioration or breakdown, but does not warrant structural review.	POOR	266
1329		SEVERE	266
1330	\N	OTHER	266
1331	None	GOOD	267
1332	Distortion not requiring mitigation or mitigated distortion.	FAIR	267
1333	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	267
1334	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	267
1335	\N	OTHER	267
1336	Not applicable	GOOD	268
1337	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	268
1338	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	268
1339	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	268
1340	\N	OTHER	268
1341	None	GOOD	269
1342	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	269
1343	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	269
1344	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	269
1345	\N	OTHER	269
1346	None	GOOD	270
1347	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	270
1348	Identified crack exists that is not arrested but does not warrant structural review.	POOR	270
1349	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	270
1350	\N	OTHER	270
1351	Connection is in place and functioning as intended.	GOOD	271
1352	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	271
1353	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	271
1354	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	271
1355	\N	OTHER	271
1356	None	GOOD	272
1357	Distortion not requiring mitigation or mitigated distortion.	FAIR	272
1358	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	272
1359	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	272
1360	\N	OTHER	272
1361	Not applicable	GOOD	273
1362	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	273
1363	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	273
1364	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	273
1365	\N	OTHER	273
1366	None	GOOD	274
1367	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	274
1368	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	274
1369	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	274
1370	\N	OTHER	274
1371	None	GOOD	275
1372	Present without measurable section loss.	FAIR	275
1373	Present with measurable section loss, but does not warrant structural review.	POOR	275
1374	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	275
1375	\N	OTHER	275
1376	None	GOOD	276
1377	Present without section loss.	FAIR	276
1378	Present with section loss, but does not warrant structural review.	POOR	276
1379	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	276
1380	\N	OTHER	276
1381	None or insignificant cracks.	GOOD	277
1382	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.004 to 0.009 inches wide.	FAIR	277
1383	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.009 inches wide.	POOR	277
1384	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	277
1385	\N	OTHER	277
1386	None	GOOD	278
1387	Surface white without build-up or leaching without rust staining.	FAIR	278
1388	Heavy build-up with rust staining.	POOR	278
1389	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	278
1390	\N	OTHER	278
1391	Not applicable	GOOD	279
1392	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	279
1393	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	279
1394	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	279
1395	\N	OTHER	279
1396	None	GOOD	280
1397	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	280
1398	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	280
1399	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	280
1400	\N	OTHER	280
1401	None	GOOD	281
1402	Present without measurable section loss.	FAIR	281
1403	Present with measurable section loss, but does not warrant structural review.	POOR	281
1404	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	281
1405	\N	OTHER	281
1406	None	GOOD	282
1407	Surface white without build-up or leaching without rust staining.	FAIR	282
1408	Heavy build-up with rust staining.	POOR	282
1409	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	282
1410	\N	OTHER	282
1411	None or insignificant cracks.	GOOD	283
1412	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	283
1413	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	283
1414	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	283
1415	\N	OTHER	283
1416	Not applicable	GOOD	284
1417	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	284
1966	Connection is in place and functioning as intended.	GOOD	394
1418	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	284
1419	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	284
1420	\N	OTHER	284
1421	Connection is in place and functioning as intended.	GOOD	285
1422	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	285
1423	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	285
1424	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	285
1425	\N	OTHER	285
1426	None	GOOD	286
1427	Affects less than 10% of the member section.	FAIR	286
1428	Affects 10% or more of the member but does not warrant structural review.	POOR	286
1429	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	286
1430	\N	OTHER	286
1431	Surface penetration less than 5% of the member thickness regardless of location.	GOOD	287
1432	Penetrates 5% - 50% of the thickness of the member and not in a tension zone.	FAIR	287
1433	Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.\nDoes not warrant structural review.	POOR	287
1434	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	287
1435	\N	OTHER	287
1436	None	GOOD	288
1437	Crack that has been arrested through effective measures.	FAIR	288
1438	Identified crack exists that is not arrested, but does not require structural review	POOR	288
1439	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	288
1440	\N	OTHER	288
1441	None	GOOD	289
1442	Length less than the member depth or arrested with effective actions taken to mitigate.	FAIR	289
1443	Length equal to or greater than the member depth, but does not require structural review.	POOR	289
1444	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	289
1445	\N	OTHER	289
1446	None or no measurable section loss.	GOOD	290
1447	Section loss less than 10% of the member thickness.	FAIR	290
1448	Section loss 10% or more of the member thickness, but does not warrant structural review.	POOR	290
1449	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	290
1450	\N	OTHER	290
1451	Not applicable	GOOD	291
1452	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	291
1453	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	291
1454	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	291
1455	\N	OTHER	291
1456	None	GOOD	292
1457	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	292
1458	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	292
1459	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	292
1460	\N	OTHER	292
1461	None	GOOD	293
1462	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	293
1463	Identified crack exists that is not arrested but does not warrant structural review.	POOR	293
1464	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	293
1465	\N	OTHER	293
1466	Connection is in place and functioning as intended.	GOOD	294
1467	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	294
1468	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	294
1469	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	294
1470	\N	OTHER	294
1471	None	GOOD	295
1472	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	295
1473	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	295
1474	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	295
1475	\N	OTHER	295
1476	None	GOOD	296
2091	None	GOOD	419
1477	Surface white without build-up or leaching without rust staining.	FAIR	296
1478	Heavy build-up with rust staining.	POOR	296
1479	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	296
1480	\N	OTHER	296
1481	None or insignificant cracks.	GOOD	297
1482	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	297
1483	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	297
1484	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	297
1485	\N	OTHER	297
1486	None	GOOD	298
1487	Initiated breakdown or deterioration.	FAIR	298
1488	Significant deterioration or breakdown, but does not warrant structural review.	POOR	298
1489		SEVERE	298
1490	\N	OTHER	298
1491	None	GOOD	299
1492	Distortion not requiring mitigation or mitigated distortion.	FAIR	299
1493	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	299
1494	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	299
1495	\N	OTHER	299
1496	Not applicable	GOOD	300
1497	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	300
1498	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	300
1499	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	300
1500	\N	OTHER	300
1501	None	GOOD	301
1502	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	301
1503	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	301
1504	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	301
1505	\N	OTHER	301
1506	None	GOOD	302
1507	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	302
1508	Identified crack exists that is not arrested but does not warrant structural review.	POOR	302
1509	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	302
1510	\N	OTHER	302
1511	Connection is in place and functioning as intended.	GOOD	303
1512	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	303
1513	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	303
1514	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	303
1515	\N	OTHER	303
1516	None	GOOD	304
1517	Distortion not requiring mitigation or mitigated distortion.	FAIR	304
1518	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	304
1519	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	304
1520	\N	OTHER	304
1521	Not applicable	GOOD	305
1522	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	305
1523	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	305
1524	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	305
1525	\N	OTHER	305
1526	None	GOOD	306
1527	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	306
1528	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	306
1529	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	306
1530	\N	OTHER	306
1531	None	GOOD	307
1532	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	307
1533	Identified crack exists that is not arrested but does not warrant structural review.	POOR	307
1534	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	307
1535	\N	OTHER	307
1536	Connection is in place and functioning as intended.	GOOD	308
1537	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	308
1538	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	308
2092	Sound Patch	FAIR	419
1539	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	308
1540	\N	OTHER	308
1541	None	GOOD	309
1542	Distortion not requiring mitigation or mitigated distortion.	FAIR	309
1543	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	309
1544	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	309
1545	\N	OTHER	309
1546	Not applicable	GOOD	310
1547	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	310
1548	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	310
1549	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	310
1550	\N	OTHER	310
1551	None	GOOD	311
1552	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	311
1553	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	311
1554	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	311
1555	\N	OTHER	311
1556	None	GOOD	312
1557	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	312
1558	Identified crack exists that is not arrested but does not warrant structural review.	POOR	312
1559	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	312
1560	\N	OTHER	312
1561	Connection is in place and functioning as intended.	GOOD	313
1562	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	313
1563	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	313
1564	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	313
1565	\N	OTHER	313
1566	None	GOOD	314
1567	Initiated breakdown or deterioration.	FAIR	314
1568	Significant deterioration or breakdown, but does not warrant structural review.	POOR	314
1569		SEVERE	314
1570	\N	OTHER	314
1571	None	GOOD	315
1572	Distortion not requiring mitigation or mitigated distortion.	FAIR	315
1573	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	315
1574	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	315
1575	\N	OTHER	315
1576	Not applicable	GOOD	316
1577	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	316
1578	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	316
1579	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	316
1580	\N	OTHER	316
1581	None	GOOD	317
1582	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	317
1583	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	317
1584	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	317
1585	\N	OTHER	317
1586	None	GOOD	318
1587	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	318
1588	Identified crack exists that is not arrested but does not warrant structural review.	POOR	318
1589	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	318
1590	\N	OTHER	318
1591	Connection is in place and functioning as intended.	GOOD	319
1592	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	319
1593	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	319
1594	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	319
1595	\N	OTHER	319
1596	None	GOOD	320
1597	Distortion not requiring mitigation or mitigated distortion.	FAIR	320
1598	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	320
1599	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	320
1600	\N	OTHER	320
1602	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	321
1603	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	321
1604	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	321
1605	\N	OTHER	321
1606	None	GOOD	322
1607	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	322
1608	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	322
1609	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	322
1610	\N	OTHER	322
1611	None	GOOD	323
1612	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	323
1613	Identified crack exists that is not arrested but does not warrant structural review.	POOR	323
1614	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	323
1615	\N	OTHER	323
1616	Connection is in place and functioning as intended.	GOOD	324
1617	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	324
1618	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	324
1619	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	324
1620	\N	OTHER	324
1621	None	GOOD	325
1622	Distortion not requiring mitigation or mitigated distortion.	FAIR	325
1623	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	325
1624	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	325
1625	\N	OTHER	325
1626	Not applicable	GOOD	326
1627	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	326
1628	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	326
1629	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	326
1630	\N	OTHER	326
1631	None	GOOD	327
1632	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	327
1633	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	327
1634	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	327
1635	\N	OTHER	327
1636	None	GOOD	328
1637	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	328
1638	Identified crack exists that is not arrested but does not warrant structural review.	POOR	328
1639	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	328
1640	\N	OTHER	328
1641	Connection is in place and functioning as intended.	GOOD	329
1642	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	329
1643	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	329
1644	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	329
1645	\N	OTHER	329
1646	None	GOOD	330
1647	Distortion not requiring mitigation or mitigated distortion.	FAIR	330
1648	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	330
1649	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	330
1650	\N	OTHER	330
1651	Not applicable	GOOD	331
1652	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	331
1653	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	331
1654	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	331
1655	\N	OTHER	331
1656	None	GOOD	332
1657	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	332
1658	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	332
1659	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	332
1660	\N	OTHER	332
1661	None	GOOD	333
1662	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	333
1663	Identified crack exists that is not arrested but does not warrant structural review.	POOR	333
1664	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	333
1665	\N	OTHER	333
1666	Connection is in place and functioning as intended.	GOOD	334
1667	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	334
1668	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	334
1669	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	334
1670	\N	OTHER	334
1671	None	GOOD	335
1672	Distortion not requiring mitigation or mitigated distortion.	FAIR	335
1673	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	335
1674	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	335
1675	\N	OTHER	335
1676	Not applicable	GOOD	336
1677	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	336
1678	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	336
1679	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	336
1680	\N	OTHER	336
1681	None	GOOD	337
1682	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	337
1683	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	337
1684	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	337
1685	\N	OTHER	337
1686	None	GOOD	338
1687	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	338
1688	Identified crack exists that is not arrested but does not warrant structural review.	POOR	338
1689	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	338
1690	\N	OTHER	338
1691	Connection is in place and functioning as intended.	GOOD	339
1692	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	339
1693	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	339
1694	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	339
1695	\N	OTHER	339
1696	None	GOOD	340
1697	Distortion not requiring mitigation or mitigated distortion.	FAIR	340
1698	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	340
1699	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	340
1700	\N	OTHER	340
1701	Restraint system is functional and installed as designed.	GOOD	341
1702	Less than 20% of the restraint system is set improperly (excessive slack or tightness).	FAIR	341
1703	Between 20% and 50% of the restraint system is set improperly (excessive slack or tightness).	POOR	341
1704	More than 50% of the restraint system is set improperly (excessive slack or tightness).	SEVERE	341
1705	\N	OTHER	341
1706	Not applicable	GOOD	342
1707	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	342
1708	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	342
1709	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	342
1710	\N	OTHER	342
1711	None	GOOD	343
1712	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	343
1713	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	343
1714	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	343
1715	\N	OTHER	343
1716	None	GOOD	344
1717	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	344
1718	Identified crack exists that is not arrested but does not warrant structural review.	POOR	344
1719	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	344
1720	\N	OTHER	344
1721	Connection is in place and functioning as intended.	GOOD	345
1722	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	345
1723	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	345
1724	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	345
1725	\N	OTHER	345
1726	None	GOOD	346
1727	Distortion not requiring mitigation or mitigated distortion.	FAIR	346
1728	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	346
1729	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	346
1730	\N	OTHER	346
1731	Restraint system is functional and installed as designed.	GOOD	347
1732	Less than 20% of the restraint system is set improperly (excessive slack or tightness).	FAIR	347
1733	Between 20% and 50% of the restraint system is set improperly (excessive slack or tightness).	POOR	347
1734	More than 50% of the restraint system is set improperly (excessive slack or tightness).	SEVERE	347
1735	\N	OTHER	347
1736	Not applicable	GOOD	348
1737	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	348
1738	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	348
1739	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	348
1740	\N	OTHER	348
1741	None	GOOD	349
1742	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	349
1743	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	349
1744	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	349
1745	\N	OTHER	349
1746	None	GOOD	350
1747	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	350
1748	Identified crack exists that is not arrested but does not warrant structural review.	POOR	350
1749	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	350
1750	\N	OTHER	350
1751	Connection is in place and functioning as intended.	GOOD	351
1752	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	351
1753	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	351
1754	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	351
1755	\N	OTHER	351
1756	None	GOOD	352
1757	Distortion not requiring mitigation or mitigated distortion.	FAIR	352
1758	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	352
1759	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	352
1760	\N	OTHER	352
1761	Restraint system is functional and installed as designed.	GOOD	353
1762	Less than 20% of the restraint system is set improperly (excessive slack or tightness).	FAIR	353
1763	Between 20% and 50% of the restraint system is set improperly (excessive slack or tightness).	POOR	353
1764	More than 50% of the restraint system is set improperly (excessive slack or tightness).	SEVERE	353
1765	\N	OTHER	353
1766	Not applicable	GOOD	354
1767	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	354
1768	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	354
1769	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	354
1770	\N	OTHER	354
1771	None	GOOD	355
1772	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	355
1773	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	355
1774	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	355
1775	\N	OTHER	355
1776	Connection is in place and functioning as intended.	GOOD	356
1777	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	356
1778	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	356
1779	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	356
1780	\N	OTHER	356
1781	Free to Move.	GOOD	357
1782	Minor Restriction	FAIR	357
1783	Restricted, but not warranting structural review.	POOR	357
1784	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	357
1785	\N	OTHER	357
1786	Lateral and vertical alignment is as expected for the temperature conditions.	GOOD	358
1787	Tolerable lateral or vertical alignment that is inconsistent with the temperature conditions.	FAIR	358
1788	Approaching the limits of lateral or vertical alignment for the bearing, but does not warrant a structural review.	POOR	358
1789	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	358
1790	\N	OTHER	358
1791	None	GOOD	359
1792	Bulging less than 15% of the thickness.	FAIR	359
1793	Bulging 15% or more of the thickness.\nSplitting or tearing.\nBearing's surfaces are not parallel.\nDoes not warrant structural review.	POOR	359
1794	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	359
1795	\N	OTHER	359
1796	None	GOOD	360
1797	Less than 10%	FAIR	360
1798	10% or more, but does not warrant structural review.	POOR	360
1799	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	360
1800	\N	OTHER	360
1801	Not applicable	GOOD	361
1802	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	361
1803	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	361
1804	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	361
1805	\N	OTHER	361
1806	None	GOOD	362
1807	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	362
1808	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	362
1809	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	362
1810	\N	OTHER	362
1811	Connection is in place and functioning as intended.	GOOD	363
1812	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	363
1813	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	363
1814	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	363
1815	\N	OTHER	363
1816	Free to Move.	GOOD	364
1817	Minor Restriction	FAIR	364
1818	Restricted, but not warranting structural review.	POOR	364
1819	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	364
1820	\N	OTHER	364
1821	Lateral and vertical alignment is as expected for the temperature conditions.	GOOD	365
1822	Tolerable lateral or vertical alignment that is inconsistent with the temperature conditions.	FAIR	365
1823	Approaching the limits of lateral or vertical alignment for the bearing, but does not warrant a structural review.	POOR	365
1824	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	365
1825	\N	OTHER	365
1826	None	GOOD	366
1827	Less than 10%	FAIR	366
1828	10% or more, but does not warrant structural review.	POOR	366
1829	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	366
1830	\N	OTHER	366
1831	Not applicable	GOOD	367
1832	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	367
1833	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	367
1834	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	367
1835	\N	OTHER	367
1836	None	GOOD	368
1837	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	368
1838	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	368
1839	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	368
1840	\N	OTHER	368
1841	Connection is in place and functioning as intended.	GOOD	369
1842	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	369
1843	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	369
2093	Unsound Patch	POOR	419
2402	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	481
1844	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	369
1845	\N	OTHER	369
1846	Free to Move.	GOOD	370
1847	Minor Restriction	FAIR	370
1848	Restricted, but not warranting structural review.	POOR	370
1849	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	370
1850	\N	OTHER	370
1851	Lateral and vertical alignment is as expected for the temperature conditions.	GOOD	371
1852	Tolerable lateral or vertical alignment that is inconsistent with the temperature conditions.	FAIR	371
1853	Approaching the limits of lateral or vertical alignment for the bearing, but does not warrant a structural review.	POOR	371
1854	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	371
1855	\N	OTHER	371
1856	None	GOOD	372
1857	Less than 10%	FAIR	372
1858	10% or more, but does not warrant structural review.	POOR	372
1859	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	372
1860	\N	OTHER	372
1861	Not applicable	GOOD	373
1862	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	373
1863	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	373
1864	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	373
1865	\N	OTHER	373
1866	None	GOOD	374
1867	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	374
1868	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	374
1869	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	374
1870	\N	OTHER	374
1871	Connection is in place and functioning as intended.	GOOD	375
1872	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	375
1873	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	375
1874	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	375
1875	\N	OTHER	375
1876	Free to Move.	GOOD	376
1877	Minor Restriction	FAIR	376
1878	Restricted, but not warranting structural review.	POOR	376
1879	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	376
1880	\N	OTHER	376
1881	Lateral and vertical alignment is as expected for the temperature conditions.	GOOD	377
1882	Tolerable lateral or vertical alignment that is inconsistent with the temperature conditions.	FAIR	377
1883	Approaching the limits of lateral or vertical alignment for the bearing, but does not warrant a structural review.	POOR	377
1884	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	377
1885	\N	OTHER	377
1886	None	GOOD	378
1887	Less than 10%	FAIR	378
1888	10% or more, but does not warrant structural review.	POOR	378
1889	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	378
1890	\N	OTHER	378
1891	Not applicable	GOOD	379
1892	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	379
1893	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	379
1894	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	379
1895	\N	OTHER	379
1896	None	GOOD	380
1897	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	380
1898	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	380
1899	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	380
1900	\N	OTHER	380
1901	Connection is in place and functioning as intended.	GOOD	381
1902	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	381
1903	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	381
1967	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	394
2400	\N	OTHER	480
2401	None	GOOD	481
1904	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	381
1905	\N	OTHER	381
1906	Free to Move.	GOOD	382
1907	Minor Restriction	FAIR	382
1908	Restricted, but not warranting structural review.	POOR	382
1909	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	382
1910	\N	OTHER	382
1911	Lateral and vertical alignment is as expected for the temperature conditions.	GOOD	383
1912	Tolerable lateral or vertical alignment that is inconsistent with the temperature conditions.	FAIR	383
1913	Approaching the limits of lateral or vertical alignment for the bearing, but does not warrant a structural review.	POOR	383
1914	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	383
1915	\N	OTHER	383
1916	None	GOOD	384
1917	Bulging less than 15% of the thickness.	FAIR	384
1918	Bulging 15% or more of the thickness.\nSplitting or tearing.\nBearing's surfaces are not parallel.\nDoes not warrant structural review.	POOR	384
1919	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	384
1920	\N	OTHER	384
1921	None	GOOD	385
1922	Less than 10%	FAIR	385
1923	10% or more, but does not warrant structural review.	POOR	385
1924	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	385
1925	\N	OTHER	385
1926	Not applicable	GOOD	386
1927	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	386
1928	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	386
1929	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	386
1930	\N	OTHER	386
1931	None	GOOD	387
1932	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	387
1933	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	387
1934	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	387
1935	\N	OTHER	387
1936	Connection is in place and functioning as intended.	GOOD	388
1937	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	388
1938	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	388
1939	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	388
1940	\N	OTHER	388
1941	Free to Move.	GOOD	389
1942	Minor Restriction	FAIR	389
1943	Restricted, but not warranting structural review.	POOR	389
1944	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	389
1945	\N	OTHER	389
1946	Lateral and vertical alignment is as expected for the temperature conditions.	GOOD	390
1947	Tolerable lateral or vertical alignment that is inconsistent with the temperature conditions.	FAIR	390
1948	Approaching the limits of lateral or vertical alignment for the bearing, but does not warrant a structural review.	POOR	390
1949	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	390
1950	\N	OTHER	390
1951	None	GOOD	391
1952	Less than 10%	FAIR	391
1953	10% or more, but does not warrant structural review.	POOR	391
1954	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	391
1955	\N	OTHER	391
1956	Not applicable	GOOD	392
1957	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	392
1958	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	392
1959	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	392
1960	\N	OTHER	392
1961	None	GOOD	393
1962	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	393
1963	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	393
1964	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	393
1965	\N	OTHER	393
1968	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	394
1969	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	394
1970	\N	OTHER	394
1971	Free to Move.	GOOD	395
1972	Minor Restriction	FAIR	395
1973	Restricted, but not warranting structural review.	POOR	395
1974	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	395
1975	\N	OTHER	395
1976	Lateral and vertical alignment is as expected for the temperature conditions.	GOOD	396
1977	Tolerable lateral or vertical alignment that is inconsistent with the temperature conditions.	FAIR	396
1978	Approaching the limits of lateral or vertical alignment for the bearing, but does not warrant a structural review.	POOR	396
1979	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	396
1980	\N	OTHER	396
1981	None	GOOD	397
1982	Less than 10%	FAIR	397
1983	10% or more, but does not warrant structural review.	POOR	397
1984	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	397
1985	\N	OTHER	397
1986	Not applicable	GOOD	398
1987	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	398
1988	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	398
1989	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	398
1990	\N	OTHER	398
1991	None	GOOD	399
1992	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	399
1993	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	399
1994	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	399
1995	\N	OTHER	399
1996	None	GOOD	400
1997	Present without measurable section loss.	FAIR	400
1998	Present with measurable section loss, but does not warrant structural review.	POOR	400
1999	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	400
2000	\N	OTHER	400
2001	None	GOOD	401
2002	Surface white without build-up or leaching without rust staining.	FAIR	401
2003	Heavy build-up with rust staining.	POOR	401
2004	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	401
2005	\N	OTHER	401
2006	None or insignificant cracks.	GOOD	402
2007	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	402
2008	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	402
2009	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	402
2010	\N	OTHER	402
2011	No abrasion or wearing.	GOOD	403
2012	Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.	FAIR	403
2013	Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.	POOR	403
2014	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	403
2015	\N	OTHER	403
2016	None	GOOD	404
2017	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	404
2018	Exceeds tolerable limits, but does not warrant structural review.	POOR	404
2019	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	404
2020	\N	OTHER	404
2021	None	GOOD	405
2022	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	405
2023	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	405
2024	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	405
2025	\N	OTHER	405
2026	Not applicable	GOOD	406
2027	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	406
2028	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	406
2029	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	406
2030	\N	OTHER	406
2031	Connection is in place and functioning as intended.	GOOD	407
2032	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	407
2033	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	407
2034	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	407
2035	\N	OTHER	407
2036	None	GOOD	408
2037	Affects less than 10% of the member section.	FAIR	408
2038	Affects 10% or more of the member but does not warrant structural review.	POOR	408
2039	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	408
2040	\N	OTHER	408
2041	Surface penetration less than 5% of the member thickness regardless of location.	GOOD	409
2042	Penetrates 5% - 50% of the thickness of the member and not in a tension zone.	FAIR	409
2043	Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.\nDoes not warrant structural review.	POOR	409
2044	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	409
2045	\N	OTHER	409
2046	None	GOOD	410
2047	Crack that has been arrested through effective measures.	FAIR	410
2048	Identified crack exists that is not arrested, but does not require structural review	POOR	410
2049	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	410
2050	\N	OTHER	410
2051	None	GOOD	411
2052	Length less than the member depth or arrested with effective actions taken to mitigate.	FAIR	411
2053	Length equal to or greater than the member depth, but does not require structural review.	POOR	411
2054	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	411
2055	\N	OTHER	411
2056	None or no measurable section loss.	GOOD	412
2057	Section loss less than 10% of the member thickness.	FAIR	412
2058	Section loss 10% or more of the member thickness, but does not warrant structural review.	POOR	412
2059	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	412
2060	\N	OTHER	412
2061	None	GOOD	413
2062	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	413
2063	Exceeds tolerable limits, but does not warrant structural review.	POOR	413
2064	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	413
2065	\N	OTHER	413
2066	None	GOOD	414
2067	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	414
2068	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	414
2069	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	414
2070	\N	OTHER	414
2071	Not applicable	GOOD	415
2072	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	415
2073	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	415
2074	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	415
2075	\N	OTHER	415
2076	None	GOOD	416
2077	Surface white without build-up or leaching without rust staining.	FAIR	416
2078	Heavy build-up with rust staining.	POOR	416
2079	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	416
2080	\N	OTHER	416
2081	None	GOOD	417
2082	Cracking or voids in less than 10% of joints.	FAIR	417
2083	Cracking or voids in 10% or more of the of joints	POOR	417
2084	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	417
2085	\N	OTHER	417
2086	None	GOOD	418
2087	Block or stone has split or spalled with no shifting.	FAIR	418
2088	Block or stone has split or spalled with shifting but does not warrant a structural review.	POOR	418
2089	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	418
2090	\N	OTHER	418
2094	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	419
2095	\N	OTHER	419
2096	None	GOOD	420
2097	Block or stone has shifted slightly out of alignment.	FAIR	420
2098	Block or stone has shifted significantly out of alignment or is missing but does not warrant structural review.	POOR	420
2099	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	420
2100	\N	OTHER	420
2101	None	GOOD	421
2102	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	421
2103	Exceeds tolerable limits, but does not warrant structural review.	POOR	421
2104	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	421
2105	\N	OTHER	421
2106	None	GOOD	422
2107	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	422
2108	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	422
2109	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	422
2110	\N	OTHER	422
2111	Not applicable	GOOD	423
2112	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	423
2113	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	423
2114	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	423
2115	\N	OTHER	423
2116	None	GOOD	424
2117	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	424
2118	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	424
2119	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	424
2120	\N	OTHER	424
2121	None	GOOD	425
2122	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	425
2123	Identified crack exists that is not arrested but does not warrant structural review.	POOR	425
2124	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	425
2125	\N	OTHER	425
2126	Connection is in place and functioning as intended.	GOOD	426
2127	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	426
2128	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	426
2129	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	426
2130	\N	OTHER	426
2131	None or insignificant cracks.	GOOD	427
2132	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	427
2133	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	427
2134	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	427
2135	\N	OTHER	427
2136	None	GOOD	428
2137	Initiated breakdown or deterioration.	FAIR	428
2138	Significant deterioration or breakdown, but does not warrant structural review.	POOR	428
2139		SEVERE	428
2140	\N	OTHER	428
2141	None	GOOD	429
2142	Distortion not requiring mitigation or mitigated distortion.	FAIR	429
2143	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	429
2144	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	429
2145	\N	OTHER	429
2146	None	GOOD	430
2147	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	430
2148	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	430
2149	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	430
2150	\N	OTHER	430
2151	None	GOOD	431
2152	Surface white without build-up or leaching without rust staining.	FAIR	431
2153	Heavy build-up with rust staining.	POOR	431
2154	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	431
2155	\N	OTHER	431
2156	None	GOOD	432
2157	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	432
2158	Exceeds tolerable limits, but does not warrant structural review.	POOR	432
2159	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	432
2160	\N	OTHER	432
2161	None	GOOD	433
2162	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	433
2163	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	433
2164	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	433
2165	\N	OTHER	433
2166	Not applicable	GOOD	434
2167	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	434
2168	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	434
2169	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	434
2170	\N	OTHER	434
2171	None	GOOD	435
2172	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	435
2173	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	435
2174	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	435
2175	\N	OTHER	435
2176	None	GOOD	436
2177	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	436
2178	Identified crack exists that is not arrested but does not warrant structural review.	POOR	436
2179	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	436
2180	\N	OTHER	436
2181	Connection is in place and functioning as intended.	GOOD	437
2182	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	437
2183	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	437
2184	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	437
2185	\N	OTHER	437
2186	None	GOOD	438
2187	Distortion not requiring mitigation or mitigated distortion.	FAIR	438
2188	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	438
2189	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	438
2190	\N	OTHER	438
2191	None	GOOD	439
2192	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	439
2193	Exceeds tolerable limits, but does not warrant structural review.	POOR	439
2194	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	439
2195	\N	OTHER	439
2196	None	GOOD	440
2197	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	440
2198	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	440
2199	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	440
2200	\N	OTHER	440
2201	Not applicable	GOOD	441
2202	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	441
2203	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	441
2204	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	441
2205	\N	OTHER	441
2206	None	GOOD	442
2207	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	442
2208	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	442
2209	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	442
2210	\N	OTHER	442
2211	None	GOOD	443
2212	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	443
2213	Identified crack exists that is not arrested but does not warrant structural review.	POOR	443
2214	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	443
2215	\N	OTHER	443
2216	Connection is in place and functioning as intended.	GOOD	444
2217	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	444
2218	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	444
2219	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	444
2220	\N	OTHER	444
2221	None	GOOD	445
2222	Distortion not requiring mitigation or mitigated distortion.	FAIR	445
2223	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	445
2224	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	445
2225	\N	OTHER	445
2226	Not applicable	GOOD	446
2227	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	446
2228	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	446
2229	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	446
2230	\N	OTHER	446
2231	None	GOOD	447
2232	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	447
2233	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	447
2234	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	447
2235	\N	OTHER	447
2236	None	GOOD	448
2237	Present without measurable section loss.	FAIR	448
2238	Present with measurable section loss, but does not warrant structural review.	POOR	448
2239	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	448
2240	\N	OTHER	448
2241	None	GOOD	449
2242	Present without section loss.	FAIR	449
2243	Present with section loss, but does not warrant structural review.	POOR	449
2244	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	449
2245	\N	OTHER	449
2246	None or insignificant cracks.	GOOD	450
2247	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.004 to 0.009 inches wide.	FAIR	450
2248	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.009 inches wide.	POOR	450
2249	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	450
2250	\N	OTHER	450
2251	None	GOOD	451
2252	Surface white without build-up or leaching without rust staining.	FAIR	451
2253	Heavy build-up with rust staining.	POOR	451
2254	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	451
2255	\N	OTHER	451
2256	Not applicable	GOOD	452
2257	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	452
2258	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	452
2259	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	452
2260	\N	OTHER	452
2261	None	GOOD	453
2262	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	453
2263	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	453
2264	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	453
2265	\N	OTHER	453
2266	None	GOOD	454
2267	Present without measurable section loss.	FAIR	454
2268	Present with measurable section loss, but does not warrant structural review.	POOR	454
2269	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	454
2270	\N	OTHER	454
2271	None	GOOD	455
2272	Surface white without build-up or leaching without rust staining.	FAIR	455
2273	Heavy build-up with rust staining.	POOR	455
2274	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	455
2275	\N	OTHER	455
2276	None or insignificant cracks.	GOOD	456
2277	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	456
2278	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	456
2279	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	456
2280	\N	OTHER	456
2281	Not applicable	GOOD	457
2282	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	457
2283	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	457
2284	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	457
2285	\N	OTHER	457
2286	Connection is in place and functioning as intended.	GOOD	458
2287	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	458
2288	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	458
2289	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	458
2290	\N	OTHER	458
2291	None	GOOD	459
2292	Affects less than 10% of the member section.	FAIR	459
2293	Affects 10% or more of the member but does not warrant structural review.	POOR	459
2294	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	459
2295	\N	OTHER	459
2296	Surface penetration less than 5% of the member thickness regardless of location.	GOOD	460
2297	Penetrates 5% - 50% of the thickness of the member and not in a tension zone.	FAIR	460
2298	Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.\nDoes not warrant structural review.	POOR	460
2299	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	460
2300	\N	OTHER	460
2301	None	GOOD	461
2302	Crack that has been arrested through effective measures.	FAIR	461
2303	Identified crack exists that is not arrested, but does not require structural review	POOR	461
2304	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	461
2305	\N	OTHER	461
2306	None	GOOD	462
2307	Length less than the member depth or arrested with effective actions taken to mitigate.	FAIR	462
2308	Length equal to or greater than the member depth, but does not require structural review.	POOR	462
2309	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	462
2310	\N	OTHER	462
2311	None or no measurable section loss.	GOOD	463
2312	Section loss less than 10% of the member thickness.	FAIR	463
2313	Section loss 10% or more of the member thickness, but does not warrant structural review.	POOR	463
2314	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	463
2315	\N	OTHER	463
2316	Not applicable	GOOD	464
2317	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	464
2318	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	464
2319	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	464
2320	\N	OTHER	464
2321	None	GOOD	465
2322	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	465
2323	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	465
2324	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	465
2325	\N	OTHER	465
2326	None	GOOD	466
2327	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	466
2328	Identified crack exists that is not arrested but does not warrant structural review.	POOR	466
2329	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	466
2330	\N	OTHER	466
2331	Connection is in place and functioning as intended.	GOOD	467
2332	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	467
2333	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	467
2334	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	467
2335	\N	OTHER	467
2336	None or insignificant cracks.	GOOD	468
2337	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	468
2338	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	468
2339	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	468
2340	\N	OTHER	468
2341	None	GOOD	469
2342	Initiated breakdown or deterioration.	FAIR	469
2343	Significant deterioration or breakdown, but does not warrant structural review.	POOR	469
2344		SEVERE	469
2345	\N	OTHER	469
2346	None	GOOD	470
2347	Distortion not requiring mitigation or mitigated distortion.	FAIR	470
2348	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	470
2349	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	470
2350	\N	OTHER	470
2351	None	GOOD	471
2352	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	471
2353	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	471
2354	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	471
2355	\N	OTHER	471
2356	None	GOOD	472
2357	Surface white without build-up or leaching without rust staining.	FAIR	472
2358	Heavy build-up with rust staining.	POOR	472
2359	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	472
2360	\N	OTHER	472
2361	Not applicable	GOOD	473
2362	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	473
2363	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	473
2364	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	473
2365	\N	OTHER	473
2366	None	GOOD	474
2367	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	474
2368	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	474
2369	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	474
2370	\N	OTHER	474
2371	None	GOOD	475
2372	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	475
2373	Identified crack exists that is not arrested but does not warrant structural review.	POOR	475
2374	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	475
2375	\N	OTHER	475
2376	Connection is in place and functioning as intended.	GOOD	476
2377	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	476
2378	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	476
2379	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	476
2380	\N	OTHER	476
2381	None	GOOD	477
2382	Distortion not requiring mitigation or mitigated distortion.	FAIR	477
2383	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	477
2384	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	477
2385	\N	OTHER	477
2386	None	GOOD	478
2387	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	478
2388	Exceeds tolerable limits, but does not warrant structural review.	POOR	478
2389	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	478
2390	\N	OTHER	478
2391	None	GOOD	479
2392	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	479
2393	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	479
2394	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	479
2395	\N	OTHER	479
2396	Not applicable	GOOD	480
2397	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	480
2398	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	480
2399	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	480
2403	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	481
2404	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	481
2405	\N	OTHER	481
2406	None	GOOD	482
2407	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	482
2408	Identified crack exists that is not arrested but does not warrant structural review.	POOR	482
2409	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	482
2410	\N	OTHER	482
2411	Connection is in place and functioning as intended.	GOOD	483
2412	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	483
2413	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	483
2414	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	483
2415	\N	OTHER	483
2416	None or insignificant cracks.	GOOD	484
2417	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	484
2418	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	484
2419	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	484
2420	\N	OTHER	484
2421	None	GOOD	485
2422	Initiated breakdown or deterioration.	FAIR	485
2423	Significant deterioration or breakdown, but does not warrant structural review.	POOR	485
2424		SEVERE	485
2425	\N	OTHER	485
2426	None	GOOD	486
2427	Distortion not requiring mitigation or mitigated distortion.	FAIR	486
2428	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	486
2429	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	486
2430	\N	OTHER	486
2431	None	GOOD	487
2432	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	487
2433	Exceeds tolerable limits, but does not warrant structural review.	POOR	487
2434	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	487
2435	\N	OTHER	487
2436	None	GOOD	488
2437	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	488
2438	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	488
2439	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	488
2440	\N	OTHER	488
2441	None	GOOD	489
2442	Surface white without build-up or leaching without rust staining.	FAIR	489
2443	Heavy build-up with rust staining.	POOR	489
2444	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	489
2445	\N	OTHER	489
2446	None	GOOD	490
2447	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	490
2448	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	490
2449	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	490
2450	\N	OTHER	490
2451	Not applicable	GOOD	491
2452	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	491
2453	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	491
2454	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	491
2455	\N	OTHER	491
2456	None	GOOD	492
2457	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	492
2458	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	492
2459	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	492
2460	\N	OTHER	492
2461	None	GOOD	493
2462	Present without measurable section loss.	FAIR	493
2463	Present with measurable section loss, but does not warrant structural review.	POOR	493
2525	\N	OTHER	505
2526	None	GOOD	506
2527	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	506
2464	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	493
2465	\N	OTHER	493
2466	None	GOOD	494
2467	Present without section loss.	FAIR	494
2468	Present with section loss, but does not warrant structural review.	POOR	494
2469	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	494
2470	\N	OTHER	494
2471	None or insignificant cracks.	GOOD	495
2472	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.004 to 0.009 inches wide.	FAIR	495
2473	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.009 inches wide.	POOR	495
2474	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	495
2475	\N	OTHER	495
2476	None	GOOD	496
2477	Surface white without build-up or leaching without rust staining.	FAIR	496
2478	Heavy build-up with rust staining.	POOR	496
2479	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	496
2480	\N	OTHER	496
2481	No abrasion or wearing.	GOOD	497
2482	Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.	FAIR	497
2483	Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.	POOR	497
2484	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	497
2485	\N	OTHER	497
2486	None	GOOD	498
2487	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	498
2488	Exceeds tolerable limits, but does not warrant structural review.	POOR	498
2489	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	498
2490	\N	OTHER	498
2491	None	GOOD	499
2492	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	499
2493	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	499
2494	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	499
2495	\N	OTHER	499
2496	Not applicable	GOOD	500
2497	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	500
2498	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	500
2499	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	500
2500	\N	OTHER	500
2501	None	GOOD	501
2502	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	501
2503	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	501
2504	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	501
2505	\N	OTHER	501
2506	None	GOOD	502
2507	Present without measurable section loss.	FAIR	502
2508	Present with measurable section loss, but does not warrant structural review.	POOR	502
2509	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	502
2510	\N	OTHER	502
2511	None	GOOD	503
2512	Surface white without build-up or leaching without rust staining.	FAIR	503
2513	Heavy build-up with rust staining.	POOR	503
2514	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	503
2515	\N	OTHER	503
2516	None or insignificant cracks.	GOOD	504
2517	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	504
2518	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	504
2519	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	504
2520	\N	OTHER	504
2521	No abrasion or wearing.	GOOD	505
2522	Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.	FAIR	505
2523	Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.	POOR	505
2524	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	505
2528	Exceeds tolerable limits, but does not warrant structural review.	POOR	506
2529	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	506
2530	\N	OTHER	506
2531	None	GOOD	507
2532	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	507
2533	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	507
2534	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	507
2535	\N	OTHER	507
2536	Not applicable	GOOD	508
2537	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	508
2538	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	508
2539	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	508
2540	\N	OTHER	508
2541	Connection is in place and functioning as intended.	GOOD	509
2542	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	509
2543	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	509
2544	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	509
2545	\N	OTHER	509
2546	None	GOOD	510
2547	Affects less than 10% of the member section.	FAIR	510
2548	Affects 10% or more of the member but does not warrant structural review.	POOR	510
2549	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	510
2550	\N	OTHER	510
2551	Surface penetration less than 5% of the member thickness regardless of location.	GOOD	511
2552	Penetrates 5% - 50% of the thickness of the member and not in a tension zone.	FAIR	511
2553	Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.\nDoes not warrant structural review.	POOR	511
2554	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	511
2555	\N	OTHER	511
2556	None	GOOD	512
2557	Crack that has been arrested through effective measures.	FAIR	512
2558	Identified crack exists that is not arrested, but does not require structural review	POOR	512
2559	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	512
2560	\N	OTHER	512
2561	None	GOOD	513
2562	Length less than the member depth or arrested with effective actions taken to mitigate.	FAIR	513
2563	Length equal to or greater than the member depth, but does not require structural review.	POOR	513
2564	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	513
2565	\N	OTHER	513
2566	None or no measurable section loss.	GOOD	514
2567	Section loss less than 10% of the member thickness.	FAIR	514
2568	Section loss 10% or more of the member thickness, but does not warrant structural review.	POOR	514
2569	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	514
2570	\N	OTHER	514
2571	None	GOOD	515
2572	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	515
2573	Exceeds tolerable limits, but does not warrant structural review.	POOR	515
2574	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	515
2575	\N	OTHER	515
2576	None	GOOD	516
2577	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	516
2578	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	516
2579	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	516
2580	\N	OTHER	516
2581	Not applicable	GOOD	517
2582	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	517
2583	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	517
2584	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	517
2585	\N	OTHER	517
2586	None	GOOD	518
2587	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	518
2588	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	518
2589	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	518
2590	\N	OTHER	518
2591	None	GOOD	519
2592	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	519
2593	Identified crack exists that is not arrested but does not warrant structural review.	POOR	519
2594	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	519
2595	\N	OTHER	519
2596	Connection is in place and functioning as intended.	GOOD	520
2597	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	520
2598	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	520
2599	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	520
2600	\N	OTHER	520
2601	None	GOOD	521
2602	Distortion not requiring mitigation or mitigated distortion.	FAIR	521
2603	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	521
2604	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	521
2605	\N	OTHER	521
2606	None	GOOD	522
2607	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	522
2608	Exceeds tolerable limits, but does not warrant structural review.	POOR	522
2609	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	522
2610	\N	OTHER	522
2611	None	GOOD	523
2612	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	523
2613	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	523
2614	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	523
2615	\N	OTHER	523
2616	Not applicable	GOOD	524
2617	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	524
2618	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	524
2619	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	524
2620	\N	OTHER	524
2621	Connection is in place and functioning as intended.	GOOD	525
2622	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	525
2623	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	525
2624	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	525
2625	\N	OTHER	525
2626	None	GOOD	526
2627	Affects less than 10% of the member section.	FAIR	526
2628	Affects 10% or more of the member but does not warrant structural review.	POOR	526
2629	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	526
2630	\N	OTHER	526
2631	Surface penetration less than 5% of the member thickness regardless of location.	GOOD	527
2632	Penetrates 5% - 50% of the thickness of the member and not in a tension zone.	FAIR	527
2633	Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.\nDoes not warrant structural review.	POOR	527
2634	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	527
2635	\N	OTHER	527
2636	None	GOOD	528
2637	Crack that has been arrested through effective measures.	FAIR	528
2638	Identified crack exists that is not arrested, but does not require structural review	POOR	528
2639	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	528
2640	\N	OTHER	528
2641	None	GOOD	529
2642	Length less than the member depth or arrested with effective actions taken to mitigate.	FAIR	529
2643	Length equal to or greater than the member depth, but does not require structural review.	POOR	529
2644	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	529
2645	\N	OTHER	529
2646	None or no measurable section loss.	GOOD	530
3261	None	GOOD	653
2647	Section loss less than 10% of the member thickness.	FAIR	530
2648	Section loss 10% or more of the member thickness, but does not warrant structural review.	POOR	530
2649	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	530
2650	\N	OTHER	530
2651	None	GOOD	531
2652	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	531
2653	Exceeds tolerable limits, but does not warrant structural review.	POOR	531
2654	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	531
2655	\N	OTHER	531
2656	None	GOOD	532
2657	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	532
2658	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	532
2659	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	532
2660	\N	OTHER	532
2661	Not applicable	GOOD	533
2662	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	533
2663	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	533
2664	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	533
2665	\N	OTHER	533
2666	None	GOOD	534
2667	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	534
2668	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	534
2669	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	534
2670	\N	OTHER	534
2671	None	GOOD	535
2672	Present without measurable section loss.	FAIR	535
2673	Present with measurable section loss, but does not warrant structural review.	POOR	535
2674	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	535
2675	\N	OTHER	535
2676	None	GOOD	536
2677	Surface white without build-up or leaching without rust staining.	FAIR	536
2678	Heavy build-up with rust staining.	POOR	536
2679	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	536
2680	\N	OTHER	536
2681	None or insignificant cracks.	GOOD	537
2682	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	537
2683	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	537
2684	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	537
2685	\N	OTHER	537
2686	No abrasion or wearing.	GOOD	538
2687	Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.	FAIR	538
2688	Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.	POOR	538
2689	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	538
2690	\N	OTHER	538
2691	None	GOOD	539
2692	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	539
2693	Exceeds tolerable limits, but does not warrant structural review.	POOR	539
2694	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	539
2695	\N	OTHER	539
2696	None	GOOD	540
2697	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	540
2698	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	540
2699	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	540
2700	\N	OTHER	540
2701	Not applicable	GOOD	541
2702	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	541
2703	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	541
2704	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	541
2705	\N	OTHER	541
2706	None	GOOD	542
2707	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	542
3447	Cracking or voids in less than 10% of joints.	FAIR	690
2708	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	542
2709	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	542
2710	\N	OTHER	542
2711	None	GOOD	543
2712	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	543
2713	Identified crack exists that is not arrested but does not warrant structural review.	POOR	543
2714	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	543
2715	\N	OTHER	543
2716	Connection is in place and functioning as intended.	GOOD	544
2717	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	544
2718	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	544
2719	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	544
2720	\N	OTHER	544
2721	None or insignificant cracks.	GOOD	545
2722	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	545
2723	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	545
2724	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	545
2725	\N	OTHER	545
2726	None	GOOD	546
2727	Initiated breakdown or deterioration.	FAIR	546
2728	Significant deterioration or breakdown, but does not warrant structural review.	POOR	546
2729		SEVERE	546
2730	\N	OTHER	546
2731	None	GOOD	547
2732	Distortion not requiring mitigation or mitigated distortion.	FAIR	547
2733	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	547
2734	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	547
2735	\N	OTHER	547
2736	None	GOOD	548
2737	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	548
2738	Exceeds tolerable limits, but does not warrant structural review.	POOR	548
2739	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	548
2740	\N	OTHER	548
2741	None	GOOD	549
2742	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	549
2743	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	549
2744	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	549
2745	\N	OTHER	549
2746	None	GOOD	550
2747	Surface white without build-up or leaching without rust staining.	FAIR	550
2748	Heavy build-up with rust staining.	POOR	550
2749	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	550
2750	\N	OTHER	550
2751	None	GOOD	551
2752	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	551
2753	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	551
2754	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	551
2755	\N	OTHER	551
2756	Not applicable	GOOD	552
2757	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	552
2758	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	552
2759	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	552
2760	\N	OTHER	552
2761	Connection is in place and functioning as intended.	GOOD	553
2762	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	553
2763	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	553
2764	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	553
2765	\N	OTHER	553
2766	None	GOOD	554
2767	Affects less than 10% of the member section.	FAIR	554
2768	Affects 10% or more of the member but does not warrant structural review.	POOR	554
2832	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	567
3590	\N	OTHER	718
3591	None	GOOD	719
2769	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	554
2770	\N	OTHER	554
2771	Surface penetration less than 5% of the member thickness regardless of location.	GOOD	555
2772	Penetrates 5% - 50% of the thickness of the member and not in a tension zone.	FAIR	555
2773	Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.\nDoes not warrant structural review.	POOR	555
2774	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	555
2775	\N	OTHER	555
2776	None	GOOD	556
2777	Crack that has been arrested through effective measures.	FAIR	556
2778	Identified crack exists that is not arrested, but does not require structural review	POOR	556
2779	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	556
2780	\N	OTHER	556
2781	None	GOOD	557
2782	Length less than the member depth or arrested with effective actions taken to mitigate.	FAIR	557
2783	Length equal to or greater than the member depth, but does not require structural review.	POOR	557
2784	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	557
2785	\N	OTHER	557
2786	None or no measurable section loss.	GOOD	558
2787	Section loss less than 10% of the member thickness.	FAIR	558
2788	Section loss 10% or more of the member thickness, but does not warrant structural review.	POOR	558
2789	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	558
2790	\N	OTHER	558
2791	None	GOOD	559
2792	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	559
2793	Exceeds tolerable limits, but does not warrant structural review.	POOR	559
2794	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	559
2795	\N	OTHER	559
2796	None	GOOD	560
2797	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	560
2798	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	560
2799	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	560
2800	\N	OTHER	560
2801	Not applicable	GOOD	561
2802	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	561
2803	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	561
2804	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	561
2805	\N	OTHER	561
2806	None	GOOD	562
2807	Surface white without build-up or leaching without rust staining.	FAIR	562
2808	Heavy build-up with rust staining.	POOR	562
2809	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	562
2810	\N	OTHER	562
2811	None	GOOD	563
2812	Cracking or voids in less than 10% of joints.	FAIR	563
2813	Cracking or voids in 10% or more of the of joints	POOR	563
2814	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	563
2815	\N	OTHER	563
2816	None	GOOD	564
2817	Block or stone has split or spalled with no shifting.	FAIR	564
2818	Block or stone has split or spalled with shifting but does not warrant a structural review.	POOR	564
2819	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	564
2820	\N	OTHER	564
2821	None	GOOD	565
2822	Sound Patch	FAIR	565
2823	Unsound Patch	POOR	565
2824	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	565
2825	\N	OTHER	565
2826	None	GOOD	566
2827	Block or stone has shifted slightly out of alignment.	FAIR	566
2828	Block or stone has shifted significantly out of alignment or is missing but does not warrant structural review.	POOR	566
2829	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	566
2830	\N	OTHER	566
2831	None	GOOD	567
3075	\N	OTHER	615
3076	None	GOOD	616
2833	Exceeds tolerable limits, but does not warrant structural review.	POOR	567
2834	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	567
2835	\N	OTHER	567
2836	None	GOOD	568
2837	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	568
2838	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	568
2839	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	568
2840	\N	OTHER	568
2841	Not applicable	GOOD	569
2842	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	569
2843	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	569
2844	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	569
2845	\N	OTHER	569
2846	None	GOOD	570
2847	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	570
2848	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	570
2849	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	570
2850	\N	OTHER	570
2851	None	GOOD	571
2852	Present without measurable section loss.	FAIR	571
2853	Present with measurable section loss, but does not warrant structural review.	POOR	571
2854	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	571
2855	\N	OTHER	571
2856	None	GOOD	572
2857	Surface white without build-up or leaching without rust staining.	FAIR	572
2858	Heavy build-up with rust staining.	POOR	572
2859	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	572
2860	\N	OTHER	572
2861	None or insignificant cracks.	GOOD	573
2862	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	573
2863	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	573
2864	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	573
2865	\N	OTHER	573
2866	No abrasion or wearing.	GOOD	574
2867	Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.	FAIR	574
2868	Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.	POOR	574
2869	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	574
2870	\N	OTHER	574
2871	None	GOOD	575
2872	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	575
2873	Exceeds tolerable limits, but does not warrant structural review.	POOR	575
2874	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	575
2875	\N	OTHER	575
2876	None	GOOD	576
2877	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	576
2878	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	576
2879	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	576
2880	\N	OTHER	576
2881	Not applicable	GOOD	577
2882	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	577
2883	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	577
2884	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	577
2885	\N	OTHER	577
2886	None	GOOD	578
2887	Distortion not requiring mitigation or mitigated distortion.	FAIR	578
2888	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	578
2889	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	578
2890	\N	OTHER	578
2891	None	GOOD	579
2892	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	579
2893	Exceeds tolerable limits, but does not warrant structural review.	POOR	579
3592	Surface crack	FAIR	719
2894	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	579
2895	\N	OTHER	579
2896	None	GOOD	580
2897	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	580
2898	Identified crack exists that is not arrested but does not warrant structural review.	POOR	580
2899	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	580
2900	\N	OTHER	580
2901	None	GOOD	581
2902	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	581
2903	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	581
2904	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	581
2905	\N	OTHER	581
2906	None	GOOD	582
2907	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	582
2908	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	582
2909	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	582
2910	\N	OTHER	582
2911	Connection is in place and functioning as intended.	GOOD	583
2912	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	583
2913	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	583
2914	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	583
2915	\N	OTHER	583
2916	Not applicable	GOOD	584
2917	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	584
2918	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	584
2919	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	584
2920	\N	OTHER	584
2921	None	GOOD	585
2922	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	585
2923	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	585
2924	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	585
2925	\N	OTHER	585
2926	None	GOOD	586
2927	Present without measurable section loss.	FAIR	586
2928	Present with measurable section loss, but does not warrant structural review.	POOR	586
2929	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	586
2930	\N	OTHER	586
2931	None	GOOD	587
2932	Present without section loss.	FAIR	587
2933	Present with section loss, but does not warrant structural review.	POOR	587
2934	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	587
2935	\N	OTHER	587
2936	No abrasion or wearing.	GOOD	588
2937	Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.	FAIR	588
2938	Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.	POOR	588
2939	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	588
2940	\N	OTHER	588
2941	None	GOOD	589
2942	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	589
2943	Exceeds tolerable limits, but does not warrant structural review.	POOR	589
2944	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	589
2945	\N	OTHER	589
2946	None or insignificant cracks.	GOOD	590
2947	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.004 to 0.009 inches wide.	FAIR	590
2948	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.009 inches wide.	POOR	590
2949	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	590
2950	\N	OTHER	590
2951	None	GOOD	591
2952	Surface white without build-up or leaching without rust staining.	FAIR	591
2953	Heavy build-up with rust staining.	POOR	591
3077	Distortion not requiring mitigation or mitigated distortion.	FAIR	616
3448	Cracking or voids in 10% or more of the of joints	POOR	690
2954	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	591
2955	\N	OTHER	591
2956	None	GOOD	592
2957	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	592
2958	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	592
2959	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	592
2960	\N	OTHER	592
2961	Not applicable	GOOD	593
2962	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	593
2963	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	593
2964	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	593
2965	\N	OTHER	593
2966	None	GOOD	594
2967	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	594
2968	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	594
2969	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	594
2970	\N	OTHER	594
2971	None	GOOD	595
2972	Present without measurable section loss.	FAIR	595
2973	Present with measurable section loss, but does not warrant structural review.	POOR	595
2974	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	595
2975	\N	OTHER	595
2976	None	GOOD	596
2977	Surface white without build-up or leaching without rust staining.	FAIR	596
2978	Heavy build-up with rust staining.	POOR	596
2979	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	596
2980	\N	OTHER	596
2981	None or insignificant cracks.	GOOD	597
2982	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	597
2983	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	597
2984	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	597
2985	\N	OTHER	597
2986	No abrasion or wearing.	GOOD	598
2987	Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.	FAIR	598
2988	Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.	POOR	598
2989	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	598
2990	\N	OTHER	598
2991	None	GOOD	599
2992	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	599
2993	Exceeds tolerable limits, but does not warrant structural review.	POOR	599
2994	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	599
2995	\N	OTHER	599
2996	None	GOOD	600
2997	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	600
2998	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	600
2999	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	600
3000	\N	OTHER	600
3001	Not applicable	GOOD	601
3002	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	601
3003	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	601
3004	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	601
3005	\N	OTHER	601
3006	Connection is in place and functioning as intended.	GOOD	602
3007	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	602
3008	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	602
3009	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	602
3010	\N	OTHER	602
3011	None	GOOD	603
3012	Affects less than 10% of the member section.	FAIR	603
3013	Affects 10% or more of the member but does not warrant structural review.	POOR	603
3260	\N	OTHER	652
3014	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	603
3015	\N	OTHER	603
3016	Surface penetration less than 5% of the member thickness regardless of location.	GOOD	604
3017	Penetrates 5% - 50% of the thickness of the member and not in a tension zone.	FAIR	604
3018	Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.\nDoes not warrant structural review.	POOR	604
3019	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	604
3020	\N	OTHER	604
3021	None	GOOD	605
3022	Crack that has been arrested through effective measures.	FAIR	605
3023	Identified crack exists that is not arrested, but does not require structural review	POOR	605
3024	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	605
3025	\N	OTHER	605
3026	None	GOOD	606
3027	Length less than the member depth or arrested with effective actions taken to mitigate.	FAIR	606
3028	Length equal to or greater than the member depth, but does not require structural review.	POOR	606
3029	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	606
3030	\N	OTHER	606
3031	None or no measurable section loss.	GOOD	607
3032	Section loss less than 10% of the member thickness.	FAIR	607
3033	Section loss 10% or more of the member thickness, but does not warrant structural review.	POOR	607
3034	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	607
3035	\N	OTHER	607
3036	None	GOOD	608
3037	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	608
3038	Exceeds tolerable limits, but does not warrant structural review.	POOR	608
3039	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	608
3040	\N	OTHER	608
3041	None	GOOD	609
3042	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	609
3043	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	609
3044	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	609
3045	\N	OTHER	609
3046	Not applicable	GOOD	610
3047	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	610
3048	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	610
3049	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	610
3050	\N	OTHER	610
3051	None	GOOD	611
3052	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	611
3053	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	611
3054	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	611
3055	\N	OTHER	611
3056	None	GOOD	612
3057	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	612
3058	Identified crack exists that is not arrested but does not warrant structural review.	POOR	612
3059	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	612
3060	\N	OTHER	612
3061	Connection is in place and functioning as intended.	GOOD	613
3062	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	613
3063	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	613
3064	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	613
3065	\N	OTHER	613
3066	None or insignificant cracks.	GOOD	614
3067	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	614
3068	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	614
3069	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	614
3070	\N	OTHER	614
3071	None	GOOD	615
3072	Initiated breakdown or deterioration.	FAIR	615
3073	Significant deterioration or breakdown, but does not warrant structural review.	POOR	615
3074		SEVERE	615
3078	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	616
3079	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	616
3080	\N	OTHER	616
3081	None	GOOD	617
3082	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	617
3083	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	617
3084	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	617
3085	\N	OTHER	617
3086	None	GOOD	618
3087	Surface white without build-up or leaching without rust staining.	FAIR	618
3088	Heavy build-up with rust staining.	POOR	618
3089	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	618
3090	\N	OTHER	618
3091	None	GOOD	619
3092	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	619
3093	Exceeds tolerable limits, but does not warrant structural review.	POOR	619
3094	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	619
3095	\N	OTHER	619
3096	None	GOOD	620
3097	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	620
3098	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	620
3099	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	620
3100	\N	OTHER	620
3101	Not applicable	GOOD	621
3102	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	621
3103	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	621
3104	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	621
3105	\N	OTHER	621
3106	None	GOOD	622
3107	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	622
3108	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	622
3109	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	622
3110	\N	OTHER	622
3111	None	GOOD	623
3112	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	623
3113	Identified crack exists that is not arrested but does not warrant structural review.	POOR	623
3114	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	623
3115	\N	OTHER	623
3116	Connection is in place and functioning as intended.	GOOD	624
3117	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	624
3118	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	624
3119	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	624
3120	\N	OTHER	624
3121	None	GOOD	625
3122	Distortion not requiring mitigation or mitigated distortion.	FAIR	625
3123	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	625
3124	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	625
3125	\N	OTHER	625
3126	None	GOOD	626
3127	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	626
3128	Exceeds tolerable limits, but does not warrant structural review.	POOR	626
3129	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	626
3130	\N	OTHER	626
3131	None	GOOD	627
3132	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	627
3133	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	627
3134	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	627
3135	\N	OTHER	627
3136	Not applicable	GOOD	628
3137	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	628
3138	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	628
3139	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	628
3140	\N	OTHER	628
3141	None	GOOD	629
3142	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	629
3143	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	629
3144	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	629
3145	\N	OTHER	629
3146	None or insignificant cracks.	GOOD	630
3147	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	630
3148	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	630
3149	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	630
3150	\N	OTHER	630
3151	None	GOOD	631
3152	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	631
3153	Exceeds tolerable limits, but does not warrant structural review.	POOR	631
3154	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	631
3155	\N	OTHER	631
3156	None	GOOD	632
3157	Distortion not requiring mitigation or mitigated distortion.	FAIR	632
3158	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	632
3159	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	632
3160	\N	OTHER	632
3161	None	GOOD	633
3162	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	633
3163	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	633
3164	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	633
3165	\N	OTHER	633
3166	Not applicable	GOOD	634
3167	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	634
3168	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	634
3169	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	634
3170	\N	OTHER	634
3171	None	GOOD	635
3172	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	635
3173	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	635
3174	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	635
3175	\N	OTHER	635
3176	None	GOOD	636
3177	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	636
3178	Identified crack exists that is not arrested but does not warrant structural review.	POOR	636
3179	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	636
3180	\N	OTHER	636
3181	Connection is in place and functioning as intended.	GOOD	637
3182	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	637
3183	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	637
3184	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	637
3185	\N	OTHER	637
3186	None	GOOD	638
3187	Distortion not requiring mitigation or mitigated distortion.	FAIR	638
3188	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	638
3189	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	638
3190	\N	OTHER	638
3191	Not applicable	GOOD	639
3192	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	639
3193	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	639
3194	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	639
3195	\N	OTHER	639
3196	None	GOOD	640
3197	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	640
3198	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	640
3199	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	640
3200	\N	OTHER	640
3201	None	GOOD	641
3202	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	641
3203	Identified crack exists that is not arrested but does not warrant structural review.	POOR	641
3204	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	641
3205	\N	OTHER	641
3206	Connection is in place and functioning as intended.	GOOD	642
3207	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	642
3208	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	642
3209	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	642
3210	\N	OTHER	642
3211	None	GOOD	643
3212	Distortion not requiring mitigation or mitigated distortion.	FAIR	643
3213	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	643
3214	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	643
3215	\N	OTHER	643
3216	Not applicable	GOOD	644
3217	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	644
3218	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	644
3219	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	644
3220	\N	OTHER	644
3221	None	GOOD	645
3222	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	645
3223	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	645
3224	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	645
3225	\N	OTHER	645
3226	None	GOOD	646
3227	Present without measurable section loss.	FAIR	646
3228	Present with measurable section loss, but does not warrant structural review.	POOR	646
3229	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	646
3230	\N	OTHER	646
3231	None	GOOD	647
3232	Initiated breakdown or deterioration.	FAIR	647
3233	Significant deterioration or breakdown, but does not warrant structural review.	POOR	647
3234		SEVERE	647
3235	\N	OTHER	647
3236	None or insignificant cracks.	GOOD	648
3237	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	648
3238	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	648
3239	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	648
3240	\N	OTHER	648
3241	None	GOOD	649
3242	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	649
3243	Exceeds tolerable limits, but does not warrant structural review.	POOR	649
3244	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	649
3245	\N	OTHER	649
3246	None	GOOD	650
3247	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	650
3248	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	650
3249	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	650
3250	\N	OTHER	650
3251	Not applicable	GOOD	651
3252	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	651
3253	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	651
3254	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	651
3255	\N	OTHER	651
3256	None	GOOD	652
3257	Distortion not requiring mitigation or mitigated distortion.	FAIR	652
3258	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	652
3259	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	652
3262	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	653
3263	Exceeds tolerable limits, but does not warrant structural review.	POOR	653
3264	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	653
3265	\N	OTHER	653
3266	None	GOOD	654
3267	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	654
3268	Identified crack exists that is not arrested but does not warrant structural review.	POOR	654
3269	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	654
3270	\N	OTHER	654
3271	None	GOOD	655
3272	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	655
3273	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	655
3274	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	655
3275	\N	OTHER	655
3276	None	GOOD	656
3277	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	656
3278	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	656
3279	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	656
3280	\N	OTHER	656
3281	Connection is in place and functioning as intended.	GOOD	657
3282	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	657
3283	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	657
3284	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	657
3285	\N	OTHER	657
3286	Not applicable	GOOD	658
3287	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	658
3288	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	658
3289	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	658
3290	\N	OTHER	658
3291	None	GOOD	659
3292	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	659
3293	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	659
3294	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	659
3295	\N	OTHER	659
3296	None	GOOD	660
3297	Present without measurable section loss.	FAIR	660
3298	Present with measurable section loss, but does not warrant structural review.	POOR	660
3299	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	660
3300	\N	OTHER	660
3301	None	GOOD	661
3302	Surface white without build-up or leaching without rust staining.	FAIR	661
3303	Heavy build-up with rust staining.	POOR	661
3304	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	661
3305	\N	OTHER	661
3306	None or insignificant cracks.	GOOD	662
3307	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	662
3308	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	662
3309	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	662
3310	\N	OTHER	662
3311	No abrasion or wearing.	GOOD	663
3312	Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.	FAIR	663
3313	Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.	POOR	663
3314	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	663
3315	\N	OTHER	663
3316	None	GOOD	664
3317	Distortion not requiring mitigation or mitigated distortion.	FAIR	664
3318	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	664
3319	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	664
3320	\N	OTHER	664
3321	None	GOOD	665
3322	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	665
3323	Exceeds tolerable limits, but does not warrant structural review.	POOR	665
3324	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	665
3325	\N	OTHER	665
3326	None	GOOD	666
3327	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	666
3328	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	666
3329	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	666
3330	\N	OTHER	666
3331	Not applicable	GOOD	667
3332	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	667
3333	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	667
3334	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	667
3335	\N	OTHER	667
3336	Connection is in place and functioning as intended.	GOOD	668
3337	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	668
3338	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	668
3339	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	668
3340	\N	OTHER	668
3341	None	GOOD	669
3342	Affects less than 10% of the member section.	FAIR	669
3343	Affects 10% or more of the member but does not warrant structural review.	POOR	669
3344	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	669
3345	\N	OTHER	669
3346	Surface penetration less than 5% of the member thickness regardless of location.	GOOD	670
3347	Penetrates 5% - 50% of the thickness of the member and not in a tension zone.	FAIR	670
3348	Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.\nDoes not warrant structural review.	POOR	670
3349	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	670
3350	\N	OTHER	670
3351	None	GOOD	671
3352	Crack that has been arrested through effective measures.	FAIR	671
3353	Identified crack exists that is not arrested, but does not require structural review	POOR	671
3354	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	671
3355	\N	OTHER	671
3356	None	GOOD	672
3357	Length less than the member depth or arrested with effective actions taken to mitigate.	FAIR	672
3358	Length equal to or greater than the member depth, but does not require structural review.	POOR	672
3359	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	672
3360	\N	OTHER	672
3361	None or no measurable section loss.	GOOD	673
3362	Section loss less than 10% of the member thickness.	FAIR	673
3363	Section loss 10% or more of the member thickness, but does not warrant structural review.	POOR	673
3364	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	673
3365	\N	OTHER	673
3366	None	GOOD	674
3367	Distortion not requiring mitigation or mitigated distortion.	FAIR	674
3368	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	674
3369	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	674
3370	\N	OTHER	674
3371	None	GOOD	675
3372	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	675
3373	Exceeds tolerable limits, but does not warrant structural review.	POOR	675
3374	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	675
3375	\N	OTHER	675
3376	None	GOOD	676
3377	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	676
3378	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	676
3379	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	676
3380	\N	OTHER	676
3381	Not applicable	GOOD	677
3382	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	677
3383	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	677
3384	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	677
3385	\N	OTHER	677
3386	None	GOOD	678
3387	Freckled Rust.\nCorrosion of the steel has initiated.	FAIR	678
3388	Section loss is evident or pack rust is present but does not warrant structural review.	POOR	678
3389	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	678
3390	\N	OTHER	678
3391	None	GOOD	679
3392	Crack that has self- arrested or has been arrested with effective arrest holes, doubling plates, or similar.	FAIR	679
3393	Identified crack exists that is not arrested but does not warrant structural review.	POOR	679
3394	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	679
3395	\N	OTHER	679
3396	Connection is in place and functioning as intended.	GOOD	680
3397	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	680
3398	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	680
3399	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	680
3400	\N	OTHER	680
3401	None	GOOD	681
3402	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	681
3403	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	681
3404	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	681
3405	\N	OTHER	681
3406	None	GOOD	682
3407	Surface white without build-up or leaching without rust staining.	FAIR	682
3408	Heavy build-up with rust staining.	POOR	682
3409	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	682
3410	\N	OTHER	682
3411	None or insignificant cracks.	GOOD	683
3412	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	683
3413	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	683
3414	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	683
3415	\N	OTHER	683
3416	None	GOOD	684
3417	Initiated breakdown or deterioration.	FAIR	684
3418	Significant deterioration or breakdown, but does not warrant structural review.	POOR	684
3419		SEVERE	684
3420	\N	OTHER	684
3421	None	GOOD	685
3422	Distortion not requiring mitigation or mitigated distortion.	FAIR	685
3423	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	685
3424	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	685
3425	\N	OTHER	685
3426	None	GOOD	686
3427	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	686
3428	Exceeds tolerable limits, but does not warrant structural review.	POOR	686
3429	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	686
3430	\N	OTHER	686
3431	None	GOOD	687
3432	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	687
3433	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	687
3434	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	687
3435	\N	OTHER	687
3436	Not applicable	GOOD	688
3437	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	688
3438	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	688
3439	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	688
3440	\N	OTHER	688
3441	None	GOOD	689
3442	Surface white without build-up or leaching without rust staining.	FAIR	689
3443	Heavy build-up with rust staining.	POOR	689
3444	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	689
3445	\N	OTHER	689
3446	None	GOOD	690
3449	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	690
3450	\N	OTHER	690
3451	None	GOOD	691
3452	Block or stone has split or spalled with no shifting.	FAIR	691
3453	Block or stone has split or spalled with shifting but does not warrant a structural review.	POOR	691
3454	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	691
3455	\N	OTHER	691
3456	None	GOOD	692
3457	Sound Patch	FAIR	692
3458	Unsound Patch	POOR	692
3459	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	692
3460	\N	OTHER	692
3461	None	GOOD	693
3462	Block or stone has shifted slightly out of alignment.	FAIR	693
3463	Block or stone has shifted significantly out of alignment or is missing but does not warrant structural review.	POOR	693
3464	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	693
3465	\N	OTHER	693
3466	None	GOOD	694
3467	Distortion not requiring mitigation or mitigated distortion.	FAIR	694
3468	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	694
3469	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	694
3470	\N	OTHER	694
3471	None	GOOD	695
3472	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	695
3473	Exceeds tolerable limits, but does not warrant structural review.	POOR	695
3474	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	695
3475	\N	OTHER	695
3476	None	GOOD	696
3477	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	696
3478	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	696
3479	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	696
3480	\N	OTHER	696
3481	Not applicable	GOOD	697
3482	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	697
3483	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	697
3484	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	697
3485	\N	OTHER	697
3486	None	GOOD	698
3487	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	698
3488	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	698
3489	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	698
3490	\N	OTHER	698
3491	None	GOOD	699
3492	Present without measurable section loss.	FAIR	699
3493	Present with measurable section loss, but does not warrant structural review.	POOR	699
3494	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	699
3495	\N	OTHER	699
3496	None	GOOD	700
3497	Present without section loss.	FAIR	700
3498	Present with section loss, but does not warrant structural review.	POOR	700
3499	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	700
3500	\N	OTHER	700
3501	None or insignificant cracks.	GOOD	701
3502	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.004 to 0.009 inches wide.	FAIR	701
3503	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.009 inches wide.	POOR	701
3504	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	701
3505	\N	OTHER	701
3506	None	GOOD	702
3507	Surface white without build-up or leaching without rust staining.	FAIR	702
3508	Heavy build-up with rust staining.	POOR	702
3509	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	702
3510	\N	OTHER	702
3511	No abrasion or wearing.	GOOD	703
3589	Punctured completely through, pulled out, or missing.	SEVERE	718
3512	Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.	FAIR	703
3513	Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.	POOR	703
3514	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	703
3515	\N	OTHER	703
3516	None	GOOD	704
3517	Distortion not requiring mitigation or mitigated distortion.	FAIR	704
3518	Distortion that requires mitigation that has not been addressed, but does not warrant structural review.	POOR	704
3519	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	704
3520	\N	OTHER	704
3521	None	GOOD	705
3522	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	705
3523	Exceeds tolerable limits, but does not warrant structural review.	POOR	705
3524	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	705
3525	\N	OTHER	705
3526	None	GOOD	706
3527	Exists within tolerable limits or has been arrested with effective countermeasures.	FAIR	706
3528	Exceeds tolerable limits, but is less than the critical limits determined by scour evaluation and does not warrant structural review.	POOR	706
3529	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	706
3530	\N	OTHER	706
3531	Not applicable	GOOD	707
3532	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	707
3533	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	707
3534	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	707
3535	\N	OTHER	707
3536	None	GOOD	708
3537	Minimal.\nMinor dripping through the joint.	FAIR	708
3538	Moderate.\nMore than a drip and less than free flow of water.	POOR	708
3539	Free flow of water through the joint.	SEVERE	708
3540	\N	OTHER	708
3541	Fully Adhered	GOOD	709
3542	Adhered for more than 50% of the joint height.	FAIR	709
3543	Adhered 50% or less of joint height but still some adhesion	POOR	709
3544	Complete loss of adhesion	SEVERE	709
3545	\N	OTHER	709
3546	None	GOOD	710
3547	Seal abrasion without punctures.	FAIR	710
3548	Punctured or ripped or partially pulled out.	POOR	710
3549	Punctured completely through, pulled out, or missing.	SEVERE	710
3550	\N	OTHER	710
3551	None	GOOD	711
3552	Surface crack	FAIR	711
3553	Crack that partially penetrates the seal.	POOR	711
3554	Crack that fully penetrates the seal.	SEVERE	711
3555	\N	OTHER	711
3556	No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.	GOOD	712
3557	Partially filled with hard- packed material, but still allowing free movement.	FAIR	712
3558	Completely filled and impacts joint movement.	POOR	712
3559	Completely filled and prevents joint movement.	SEVERE	712
3560	\N	OTHER	712
3561	Sound.\nNo spall, delamination or unsound patch.	GOOD	713
3562	Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.\nNo exposed rebar.\nPatched area that is sound.	FAIR	713
3563	Spall greater than 1 in. deep or greater than 6 in. diameter.\nExposed rebar.\nDelamination or unsound patched area that makes the joint loose.	POOR	713
3564	Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.	SEVERE	713
3565	\N	OTHER	713
3566	None	GOOD	714
3567	Freckled rust, metal has no cracks or impact damage.\nConnection may be loose but functioning as intended.	FAIR	714
3568	Section loss, missing or broken fasteners, cracking of the metal or impact damage but joint still functioning	POOR	714
3569	Metal cracking, section loss, damage or connection failure that prevents the joint from functioning as intended.	SEVERE	714
3570	\N	OTHER	714
3571	Not applicable	GOOD	715
3572	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	715
3573	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	715
3574	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	715
3575	\N	OTHER	715
3576	None	GOOD	716
3577	Minimal.\nMinor dripping through the joint.	FAIR	716
3578	Moderate.\nMore than a drip and less than free flow of water.	POOR	716
3579	Free flow of water through the joint.	SEVERE	716
3580	\N	OTHER	716
3581	Fully Adhered	GOOD	717
3582	Adhered for more than 50% of the joint height.	FAIR	717
3583	Adhered 50% or less of joint height but still some adhesion	POOR	717
3584	Complete loss of adhesion	SEVERE	717
3585	\N	OTHER	717
3586	None	GOOD	718
3587	Seal abrasion without punctures.	FAIR	718
3588	Punctured or ripped or partially pulled out.	POOR	718
3593	Crack that partially penetrates the seal.	POOR	719
3594	Crack that fully penetrates the seal.	SEVERE	719
3595	\N	OTHER	719
3596	No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.	GOOD	720
3597	Partially filled with hard- packed material, but still allowing free movement.	FAIR	720
3598	Completely filled and impacts joint movement.	POOR	720
3599	Completely filled and prevents joint movement.	SEVERE	720
3600	\N	OTHER	720
3601	Sound.\nNo spall, delamination or unsound patch.	GOOD	721
3602	Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.\nNo exposed rebar.\nPatched area that is sound.	FAIR	721
3603	Spall greater than 1 in. deep or greater than 6 in. diameter.\nExposed rebar.\nDelamination or unsound patched area that makes the joint loose.	POOR	721
3604	Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.	SEVERE	721
3605	\N	OTHER	721
3606	Not applicable	GOOD	722
3607	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	722
3608	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	722
3609	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	722
3610	\N	OTHER	722
3611	None	GOOD	723
3612	Minimal.\nMinor dripping through the joint.	FAIR	723
3613	Moderate.\nMore than a drip and less than free flow of water.	POOR	723
3614	Free flow of water through the joint.	SEVERE	723
3615	\N	OTHER	723
3616	Fully Adhered	GOOD	724
3617	Adhered for more than 50% of the joint height.	FAIR	724
3618	Adhered 50% or less of joint height but still some adhesion	POOR	724
3619	Complete loss of adhesion	SEVERE	724
3620	\N	OTHER	724
3621	None	GOOD	725
3622	Seal abrasion without punctures.	FAIR	725
3623	Punctured or ripped or partially pulled out.	POOR	725
3624	Punctured completely through, pulled out, or missing.	SEVERE	725
3625	\N	OTHER	725
3626	None	GOOD	726
3627	Surface crack	FAIR	726
3628	Crack that partially penetrates the seal.	POOR	726
3629	Crack that fully penetrates the seal.	SEVERE	726
3630	\N	OTHER	726
3631	No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.	GOOD	727
3632	Partially filled with hard- packed material, but still allowing free movement.	FAIR	727
3633	Completely filled and impacts joint movement.	POOR	727
3634	Completely filled and prevents joint movement.	SEVERE	727
3635	\N	OTHER	727
3636	Sound.\nNo spall, delamination or unsound patch.	GOOD	728
3637	Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.\nNo exposed rebar.\nPatched area that is sound.	FAIR	728
3638	Spall greater than 1 in. deep or greater than 6 in. diameter.\nExposed rebar.\nDelamination or unsound patched area that makes the joint loose.	POOR	728
3639	Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.	SEVERE	728
3640	\N	OTHER	728
3641	Not applicable	GOOD	729
3642	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	729
3643	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	729
3644	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	729
3645	\N	OTHER	729
3646	None	GOOD	730
3647	Minimal.\nMinor dripping through the joint.	FAIR	730
3648	Moderate.\nMore than a drip and less than free flow of water.	POOR	730
3649	Free flow of water through the joint.	SEVERE	730
3650	\N	OTHER	730
3651	Fully Adhered	GOOD	731
3652	Adhered for more than 50% of the joint height.	FAIR	731
3653	Adhered 50% or less of joint height but still some adhesion	POOR	731
3654	Complete loss of adhesion	SEVERE	731
3655	\N	OTHER	731
3656	None	GOOD	732
3657	Seal abrasion without punctures.	FAIR	732
3658	Punctured or ripped or partially pulled out.	POOR	732
3659	Punctured completely through, pulled out, or missing.	SEVERE	732
3660	\N	OTHER	732
3661	None	GOOD	733
3662	Surface crack	FAIR	733
3663	Crack that partially penetrates the seal.	POOR	733
3664	Crack that fully penetrates the seal.	SEVERE	733
3665	\N	OTHER	733
3666	No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.	GOOD	734
3667	Partially filled with hard- packed material, but still allowing free movement.	FAIR	734
3668	Completely filled and impacts joint movement.	POOR	734
3669	Completely filled and prevents joint movement.	SEVERE	734
3670	\N	OTHER	734
3671	Sound.\nNo spall, delamination or unsound patch.	GOOD	735
3672	Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.\nNo exposed rebar.\nPatched area that is sound.	FAIR	735
3673	Spall greater than 1 in. deep or greater than 6 in. diameter.\nExposed rebar.\nDelamination or unsound patched area that makes the joint loose.	POOR	735
3674	Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.	SEVERE	735
3675	\N	OTHER	735
3676	None	GOOD	736
3877	Crack width 0.25â0.5 inches wide.	FAIR	776
3677	Freckled rust, metal has no cracks or impact damage.\nConnection may be loose but functioning as intended.	FAIR	736
3678	Section loss, missing or broken fasteners, cracking of the metal or impact damage but joint still functioning	POOR	736
3679	Metal cracking, section loss, damage or connection failure that prevents the joint from functioning as intended.	SEVERE	736
3680	\N	OTHER	736
3681	Not applicable	GOOD	737
3682	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	737
3683	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	737
3684	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	737
3685	\N	OTHER	737
3686	No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.	GOOD	738
3687	Partially filled with hard- packed material, but still allowing free movement.	FAIR	738
3688	Completely filled and impacts joint movement.	POOR	738
3689	Completely filled and prevents joint movement.	SEVERE	738
3690	\N	OTHER	738
3691	Sound.\nNo spall, delamination or unsound patch.	GOOD	739
3692	Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.\nNo exposed rebar.\nPatched area that is sound.	FAIR	739
3693	Spall greater than 1 in. deep or greater than 6 in. diameter.\nExposed rebar.\nDelamination or unsound patched area that makes the joint loose.	POOR	739
3694	Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.	SEVERE	739
3695	\N	OTHER	739
3696	Not applicable	GOOD	740
3697	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	740
3698	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	740
3699	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	740
3700	\N	OTHER	740
3701	No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.	GOOD	741
3702	Partially filled with hard- packed material, but still allowing free movement.	FAIR	741
3703	Completely filled and impacts joint movement.	POOR	741
3704	Completely filled and prevents joint movement.	SEVERE	741
3705	\N	OTHER	741
3706	Sound.\nNo spall, delamination or unsound patch.	GOOD	742
3707	Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.\nNo exposed rebar.\nPatched area that is sound.	FAIR	742
3708	Spall greater than 1 in. deep or greater than 6 in. diameter.\nExposed rebar.\nDelamination or unsound patched area that makes the joint loose.	POOR	742
3709	Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.	SEVERE	742
3710	\N	OTHER	742
3711	None	GOOD	743
3712	Freckled rust, metal has no cracks or impact damage.\nConnection may be loose but functioning as intended.	FAIR	743
3713	Section loss, missing or broken fasteners, cracking of the metal or impact damage but joint still functioning	POOR	743
3714	Metal cracking, section loss, damage or connection failure that prevents the joint from functioning as intended.	SEVERE	743
3715	\N	OTHER	743
3716	Not applicable	GOOD	744
3717	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	744
3718	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	744
3719	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	744
3720	\N	OTHER	744
3721	None	GOOD	745
3722	Minimal.\nMinor dripping through the joint.	FAIR	745
3723	Moderate.\nMore than a drip and less than free flow of water.	POOR	745
3724	Free flow of water through the joint.	SEVERE	745
3725	\N	OTHER	745
3726	No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.	GOOD	746
3727	Partially filled with hard- packed material, but still allowing free movement.	FAIR	746
3728	Completely filled and impacts joint movement.	POOR	746
3729	Completely filled and prevents joint movement.	SEVERE	746
3730	\N	OTHER	746
3731	Sound.\nNo spall, delamination or unsound patch.	GOOD	747
3732	Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.\nNo exposed rebar.\nPatched area that is sound.	FAIR	747
3733	Spall greater than 1 in. deep or greater than 6 in. diameter.\nExposed rebar.\nDelamination or unsound patched area that makes the joint loose.	POOR	747
3734	Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.	SEVERE	747
3735	\N	OTHER	747
3736	None	GOOD	748
3737	Freckled rust, metal has no cracks or impact damage.\nConnection may be loose but functioning as intended.	FAIR	748
3738	Section loss, missing or broken fasteners, cracking of the metal or impact damage but joint still functioning	POOR	748
3739	Metal cracking, section loss, damage or connection failure that prevents the joint from functioning as intended.	SEVERE	748
3740	\N	OTHER	748
3741	Not applicable	GOOD	749
3742	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	749
3743	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	749
3744	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	749
3745	\N	OTHER	749
3746	None	GOOD	750
3747	Minimal.\nMinor dripping through the joint.	FAIR	750
3748	Moderate.\nMore than a drip and less than free flow of water.	POOR	750
3749	Free flow of water through the joint.	SEVERE	750
3750	\N	OTHER	750
3751	Fully Adhered	GOOD	751
3752	Adhered for more than 50% of the joint height.	FAIR	751
3753	Adhered 50% or less of joint height but still some adhesion	POOR	751
3754	Complete loss of adhesion	SEVERE	751
3755	\N	OTHER	751
3756	Fully Adhered	GOOD	752
3757	Adhered for more than 50% of the joint height.	FAIR	752
3758	Adhered 50% or less of joint height but still some adhesion	POOR	752
3759	Complete loss of adhesion	SEVERE	752
3760	\N	OTHER	752
3761	Not applicable	GOOD	753
3762	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	753
3763	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	753
3764	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	753
3765	\N	OTHER	753
3766	No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.	GOOD	754
3767	Partially filled with hard- packed material, but still allowing free movement.	FAIR	754
3768	Completely filled and impacts joint movement.	POOR	754
3769	Completely filled and prevents joint movement.	SEVERE	754
3770	\N	OTHER	754
3771	Sound.\nNo spall, delamination or unsound patch.	GOOD	755
3772	Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.\nNo exposed rebar.\nPatched area that is sound.	FAIR	755
3773	Spall greater than 1 in. deep or greater than 6 in. diameter.\nExposed rebar.\nDelamination or unsound patched area that makes the joint loose.	POOR	755
3774	Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.	SEVERE	755
3775	\N	OTHER	755
3776	None	GOOD	756
3777	Freckled rust, metal has no cracks or impact damage.\nConnection may be loose but functioning as intended.	FAIR	756
3778	Section loss, missing or broken fasteners, cracking of the metal or impact damage but joint still functioning	POOR	756
3779	Metal cracking, section loss, damage or connection failure that prevents the joint from functioning as intended.	SEVERE	756
3780	\N	OTHER	756
3781	Not applicable	GOOD	757
3782	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	757
3783	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	757
3784	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	757
3785	\N	OTHER	757
3786	No debris to a shallow cover of loose debris may be evident but does not affect the performance of the joint.	GOOD	758
3787	Partially filled with hard- packed material, but still allowing free movement.	FAIR	758
3788	Completely filled and impacts joint movement.	POOR	758
3789	Completely filled and prevents joint movement.	SEVERE	758
3790	\N	OTHER	758
3791	Sound.\nNo spall, delamination or unsound patch.	GOOD	759
3792	Edge delamination or spall 1 in. or less deep or 6 in. or less in diameter.\nNo exposed rebar.\nPatched area that is sound.	FAIR	759
3793	Spall greater than 1 in. deep or greater than 6 in. diameter.\nExposed rebar.\nDelamination or unsound patched area that makes the joint loose.	POOR	759
3794	Spall, delamination, unsound patched area or loose joint anchor that prevents the joint from functioning as intended.	SEVERE	759
3795	\N	OTHER	759
3796	None	GOOD	760
3797	Freckled rust, metal has no cracks or impact damage.\nConnection may be loose but functioning as intended.	FAIR	760
3798	Section loss, missing or broken fasteners, cracking of the metal or impact damage but joint still functioning	POOR	760
3799	Metal cracking, section loss, damage or connection failure that prevents the joint from functioning as intended.	SEVERE	760
3800	\N	OTHER	760
3801	Not applicable	GOOD	761
3802	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	761
3803	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	761
3804	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	761
3805	\N	OTHER	761
3806	None	GOOD	762
3807	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	762
3808	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	762
3809	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	762
3810	\N	OTHER	762
3811	None	GOOD	763
3812	Present without measurable section loss.	FAIR	763
3813	Present with measurable section loss, but does not warrant structural review.	POOR	763
3878	Width of more than 0.5 in. wide	POOR	776
3879	The wearing surface is no longer effective.	SEVERE	776
3880	\N	OTHER	776
3814	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	763
3815	\N	OTHER	763
3816	None	GOOD	764
3817	Present without section loss.	FAIR	764
3818	Present with section loss, but does not warrant structural review.	POOR	764
3819	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	764
3820	\N	OTHER	764
3821	None or insignificant cracks.	GOOD	765
3822	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.004 to 0.009 inches wide.	FAIR	765
3823	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.009 inches wide.	POOR	765
3824	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	765
3825	\N	OTHER	765
3826	No abrasion or wearing.	GOOD	766
3827	Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.	FAIR	766
3828	Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.	POOR	766
3829	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	766
3830	\N	OTHER	766
3831	None	GOOD	767
3832	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	767
3833	Exceeds tolerable limits, but does not warrant structural review.	POOR	767
3834	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	767
3835	\N	OTHER	767
3836	Not applicable	GOOD	768
3837	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	768
3838	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	768
3839	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	768
3840	\N	OTHER	768
3841	None	GOOD	769
3842	Delaminated.\nSpall 1 in. or less deep or 6 in. or less in diameter.\nPatched area that is sound.	FAIR	769
3843	Spall greater than 1 in. deep or greater than 6 in. diameter.\nPatched area that is unsound or showing distress.\nDoes not warrant structural review.	POOR	769
3844	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	769
3845	\N	OTHER	769
3846	None	GOOD	770
3847	Present without measurable section loss.	FAIR	770
3848	Present with measurable section loss, but does not warrant structural review.	POOR	770
3849	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	770
3850	\N	OTHER	770
3851	None or insignificant cracks.	GOOD	771
3852	Unsealed moderate width cracks or unsealed moderate pattern (map) cracking.\nCracks from 0.012 to 0.05 inches wide.	FAIR	771
3853	Wide cracks or heavy pattern (map) cracking.\nCracks greater than 0.05 inches wide.	POOR	771
3854	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	771
3855	\N	OTHER	771
3856	No abrasion or wearing.	GOOD	772
3857	Abrasion or wearing has exposed coarse aggregate but the aggregate remains secure in the concrete.	FAIR	772
3858	Coarse aggregate is loose or has popped out of the concrete matrix due to abrasion or wear.	POOR	772
3859	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	772
3860	\N	OTHER	772
3861	None	GOOD	773
3862	Exists within tolerable limits or arrested with no observed structural distress.	FAIR	773
3863	Exceeds tolerable limits, but does not warrant structural review.	POOR	773
3864	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	773
3865	\N	OTHER	773
3866	Not applicable	GOOD	774
3867	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	774
3868	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	774
3869	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	774
3870	\N	OTHER	774
3871	None	GOOD	775
3872	Patched area that is sound.\nPartial depth pothole.	FAIR	775
3873	Patched area that is unsound or showing distress.\nFull depth pothole.	POOR	775
3874	The wearing surface is no longer effective.	SEVERE	775
3875	\N	OTHER	775
3876	Sealed Cracks	GOOD	776
3881	Fully effective.\nNo evidence of leakage or further deterioration of the protected element.	GOOD	777
3882	Substantially effective.\nDeterioration of the protected element has slowed.	FAIR	777
3883	Limited effectiveness.\nDeterioration of the protected element has progressed.	POOR	777
3884	The wearing surface is no longer effective.	SEVERE	777
3885	\N	OTHER	777
3886	Not applicable	GOOD	778
3887	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	778
3888	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	778
3889	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	778
3890	\N	OTHER	778
3891	None	GOOD	779
3892	Patched area that is sound.\nPartial depth pothole.	FAIR	779
3893	Patched area that is unsound or showing distress.\nFull depth pothole.	POOR	779
3894	The wearing surface is no longer effective.	SEVERE	779
3895	\N	OTHER	779
3896	Sealed Cracks	GOOD	780
3897	Crack width 0.25â0.5 inches wide.	FAIR	780
3898	Width of more than 0.5 in. wide	POOR	780
3899	The wearing surface is no longer effective.	SEVERE	780
3900	\N	OTHER	780
3901	Fully effective.\nNo evidence of leakage or further deterioration of the protected element.	GOOD	781
3902	Substantially effective.\nDeterioration of the protected element has slowed.	FAIR	781
3903	Limited effectiveness.\nDeterioration of the protected element has progressed.	POOR	781
3904	The wearing surface is no longer effective.	SEVERE	781
3905	\N	OTHER	781
3906	Not applicable	GOOD	782
3907	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	782
3908	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	782
3909	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	782
3910	\N	OTHER	782
3911	None	GOOD	783
3912	Patched area that is sound.\nPartial depth pothole.	FAIR	783
3913	Patched area that is unsound or showing distress.\nFull depth pothole.	POOR	783
3914	The wearing surface is no longer effective.	SEVERE	783
3915	\N	OTHER	783
3916	Sealed Cracks	GOOD	784
3917	Crack width 0.25â0.5 inches wide.	FAIR	784
3918	Width of more than 0.5 in. wide	POOR	784
3919	The wearing surface is no longer effective.	SEVERE	784
3920	\N	OTHER	784
3921	Fully effective.\nNo evidence of leakage or further deterioration of the protected element.	GOOD	785
3922	Substantially effective.\nDeterioration of the protected element has slowed.	FAIR	785
3923	Limited effectiveness.\nDeterioration of the protected element has progressed.	POOR	785
3924	The wearing surface is no longer effective.	SEVERE	785
3925	\N	OTHER	785
3926	Not applicable	GOOD	786
3927	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	786
3928	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	786
3929	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	786
3930	\N	OTHER	786
3931	Connection is in place and functioning as intended.	GOOD	787
3932	Loose fasteners or pack rust without distortion is present, but the connection is in place and functioning as intended.	FAIR	787
3933	Missing bolts, rivets, broken welds, fasteners or pack rust with distortion, but does not warrant a structural review.	POOR	787
3934	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	787
3935	\N	OTHER	787
3936	None	GOOD	788
3937	Affects less than 10% of the member section.	FAIR	788
3938	Affects 10% or more of the member but does not warrant structural review.	POOR	788
3939	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	788
3940	\N	OTHER	788
3941	Surface penetration less than 5% of the member thickness regardless of location.	GOOD	789
3942	Penetrates 5% - 50% of the thickness of the member and not in a tension zone.	FAIR	789
3943	Penetrates more than 50% of the thickness of the member or more than 5% of the member thickness in a tension zone.\nDoes not warrant structural review.	POOR	789
3944	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	789
3945	\N	OTHER	789
3946	None	GOOD	790
3947	Crack that has been arrested through effective measures.	FAIR	790
3948	Identified crack exists that is not arrested, but does not require structural review	POOR	790
3949	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	790
3950	\N	OTHER	790
3951	None	GOOD	791
3952	Length less than the member depth or arrested with effective actions taken to mitigate.	FAIR	791
3953	Length equal to or greater than the member depth, but does not require structural review.	POOR	791
3954	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	791
3955	\N	OTHER	791
3956	None or no measurable section loss.	GOOD	792
3957	Section loss less than 10% of the member thickness.	FAIR	792
3958	Section loss 10% or more of the member thickness, but does not warrant structural review.	POOR	792
3959	The condition warrants a structural review to determine the effect on strength or serviceability of the element or bridge.\nOR\nA structural review has been completed and the defects impact strength or serviceability of the element or bridge.	SEVERE	792
3960	\N	OTHER	792
3961	Not applicable	GOOD	793
3962	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	793
3963	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	793
3964	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	793
3965	\N	OTHER	793
3966	None	GOOD	794
3967	Surface Dulling	FAIR	794
3968	Loss of Pigment	POOR	794
3969	Not Applicable	SEVERE	794
3970	\N	OTHER	794
3971	None	GOOD	795
3972	Finish coats only.	FAIR	795
3973	Finish and primer coats	POOR	795
3974	Exposure of bare metal	SEVERE	795
3975	\N	OTHER	795
3976	Fully effective	GOOD	796
3977	Substantially effective	FAIR	796
3978	Limited effectiveness	POOR	796
3979	Failed, no protection of the underlying metal	SEVERE	796
3980	\N	OTHER	796
3981	Not applicable	GOOD	797
3982	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	797
3983	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	797
3984	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	797
3985	\N	OTHER	797
3986	None	GOOD	798
3987	Finish coats only.	FAIR	798
3988	Finish and primer coats	POOR	798
3989	Exposure of bare metal	SEVERE	798
3990	\N	OTHER	798
3991	Yellow-orange or light brown for early development.\nChocolate-brown to purple-brown for fully developed.	GOOD	799
3992	Granular texture.	FAIR	799
3993	Small flakes, less than 1/2 in. diameter.	POOR	799
3994	Dark black color.	SEVERE	799
3995	\N	OTHER	799
3996	Fully effective	GOOD	800
3997	Substantially effective	FAIR	800
3998	Limited effectiveness	POOR	800
3999	Failed, no protection of the underlying metal	SEVERE	800
4000	\N	OTHER	800
4001	Not applicable	GOOD	801
4002	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	801
4003	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	801
4004	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	801
4005	\N	OTHER	801
4006	None	GOOD	802
4007	Finish coats only.	FAIR	802
4008	Finish and primer coats	POOR	802
4009	Exposure of bare metal	SEVERE	802
4010	\N	OTHER	802
4011	Yellow-orange or light brown for early development.\nChocolate-brown to purple-brown for fully developed.	GOOD	803
4012	Granular texture.	FAIR	803
4013	Small flakes, less than 1/2 in. diameter.	POOR	803
4014	Dark black color.	SEVERE	803
4015	\N	OTHER	803
4016	Fully effective	GOOD	804
4017	Substantially effective	FAIR	804
4018	Limited effectiveness	POOR	804
4019	Failed, no protection of the underlying metal	SEVERE	804
4020	\N	OTHER	804
4021	Not applicable	GOOD	805
4022	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	805
4023	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	805
4024	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	805
4025	\N	OTHER	805
4026	Fully effective	GOOD	806
4027	Substantially effective	FAIR	806
4028	Limited effectiveness	POOR	806
4029	The protective system has failed or is no longer effective.	SEVERE	806
4030	\N	OTHER	806
4031	Not applicable	GOOD	807
4032	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	807
4033	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	807
4034	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	807
4035	\N	OTHER	807
4036	None	GOOD	808
4037	Underlying concrete not exposed.\nCoating showing wear from UV exposure.\nFriction course missing	FAIR	808
4038	Underlying concrete is not exposed.\nThickness of the coating is reduced.	POOR	808
4039	Underlying concrete exposed.\nProtective coating no longer effective	SEVERE	808
4040	\N	OTHER	808
4041	Fully effective	GOOD	809
4042	Substantially effective	FAIR	809
4043	Limited effectiveness	POOR	809
4044	The protective system has failed or is no longer effective.	SEVERE	809
4045	\N	OTHER	809
4046	Not applicable	GOOD	810
4047	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	810
4048	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	810
4049	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	810
4050	\N	OTHER	810
4051	None	GOOD	811
4052	Underlying concrete not exposed.\nCoating showing wear from UV exposure.\nFriction course missing	FAIR	811
4053	Underlying concrete is not exposed.\nThickness of the coating is reduced.	POOR	811
4054	Underlying concrete exposed.\nProtective coating no longer effective	SEVERE	811
4055	\N	OTHER	811
4056	Fully effective	GOOD	812
4057	Substantially effective	FAIR	812
4058	Limited effectiveness	POOR	812
4059	The protective system has failed or is no longer effective.	SEVERE	812
4060	\N	OTHER	812
4061	Not applicable	GOOD	813
4062	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 2 under the appropriate material defect entry.	FAIR	813
4063	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 3 under the appropriate material defect entry.	POOR	813
4064	The element has impact damage.\nThe specific damage caused by the impact has been captured in Condition State 4 under the appropriate material defect entry.	SEVERE	813
4065	\N	OTHER	813
\.


--
-- Data for Name: defect; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.defect (id, name, number, material_id) FROM stdin;
1	Delamination/ Spall/ Patched Area	1080	1
2	Exposed Rebar	1090	1
3	Efflorescence/ Rust Staining	1120	1
4	Cracking (RC and Other)	1130	1
5	Abrasion/Wear (PSC/RC)	1190	1
6	Damage	7000	1
7	Delamination/ Spall/ Patched Area	1080	2
8	Exposed Rebar	1090	2
9	Exposed Prestressing	1100	2
10	Cracking (PSC)	1110	2
11	Efflorescence/ Rust Staining	1120	2
12	Abrasion/Wear (PSC/RC)	1190	2
13	Damage	7000	2
14	Delamination/ Spall/ Patched Area	1080	3
15	Exposed Rebar	1090	3
16	Exposed Prestressing	1100	3
17	Cracking (PSC)	1110	3
18	Efflorescence/ Rust Staining	1120	3
19	Abrasion/Wear (PSC/RC)	1190	3
20	Damage	7000	3
21	Delamination/ Spall/ Patched Area	1080	4
22	Exposed Rebar	1090	4
23	Efflorescence/ Rust Staining	1120	4
24	Cracking (RC and Other)	1130	4
25	Abrasion/Wear (PSC/RC)	1190	4
26	Damage	7000	4
27	Corrosion	1000	5
28	Fatigue Crack (Steel/Other)	1010	5
29	Connection	1020	5
30	Damage	7000	5
31	Corrosion	1000	6
32	Fatigue Crack (Steel/Other)	1010	6
33	Connection	1020	6
34	Damage	7000	6
35	Corrosion	1000	7
36	Fatigue Crack (Steel/Other)	1010	7
37	Connection	1020	7
38	Damage	7000	7
39	Connection	1020	8
40	Decay/Section Loss	1140	8
41	Check/Shake	1150	8
42	Crack (Timber)	1160	8
43	Split/Delamination (Timber)	1170	8
44	Abrasion/Wear (Timber)	1180	8
45	Damage	7000	8
46	Delamination/ Spall/ Patched Area	1080	9
47	Exposed Rebar	1090	9
48	Efflorescence/ Rust Staining	1120	9
49	Cracking (RC and Other)	1130	9
50	Abrasion/Wear (PSC/RC)	1190	9
51	Damage	7000	9
52	Delamination/ Spall/ Patched Area	1080	10
53	Exposed Rebar	1090	10
54	Exposed Prestressing	1100	10
55	Cracking (PSC)	1110	10
56	Efflorescence/ Rust Staining	1120	10
57	Abrasion/Wear (PSC/RC)	1190	10
58	Damage	7000	10
59	Connection	1020	11
60	Decay/Section Loss	1140	11
61	Check/Shake	1150	11
62	Crack (Timber)	1160	11
63	Split/Delamination (Timber)	1170	11
64	Abrasion/Wear (Timber)	1180	11
65	Damage	7000	11
66	Corrosion	1000	12
67	Fatigue Crack (Steel/Other)	1010	12
68	Connection	1020	12
69	Cracking (RC and Other)	1130	12
70	Delamination/ Spall/ Patched Area	1080	12
71	Efflorescence/ Rust Staining	1120	12
72	Deterioration (Other)	1220	12
73	Damage	7000	12
74	Corrosion	1000	13
75	Fatigue Crack (Steel/Other)	1010	13
76	Connection	1020	13
77	Delamination/ Spall/ Patched Area	1080	13
78	Cracking (RC and Other)	1130	13
79	Deterioration (Other)	1220	13
80	Efflorescence/ Rust Staining	1120	13
81	Damage	7000	13
82	Corrosion	1000	14
83	Fatigue Crack (Steel/Other)	1010	14
84	Connection	1020	14
85	Distortion	1900	14
86	Damage	7000	14
87	Delamination/ Spall/ Patched Area	1080	15
88	Exposed Rebar	1090	15
89	Efflorescence/ Rust Staining	1120	15
90	Cracking (RC and Other)	1130	15
91	Abrasion/Wear (PSC/RC)	1190	15
92	Damage	7000	15
93	Connection	1020	16
94	Decay/Section Loss	1140	16
95	Check/Shake	1150	16
96	Crack (Timber)	1160	16
97	Split/Delamination (Timber)	1170	16
98	Abrasion/Wear (Timber)	1180	16
99	Damage	7000	16
100	Corrosion	1000	17
101	Fatigue Crack (Steel/Other)	1010	17
102	Connection	1020	17
103	Efflorescence/ Rust Staining	1120	17
104	Cracking (RC and Other)	1130	17
105	Abrasion/Wear (PSC/RC)	1190	17
106	Delamination/ Spall/ Patched Area	1080	17
107	Exposed Rebar	1090	17
108	Deterioration (Other)	1220	17
109	Distortion	1900	17
110	Damage	7000	17
111	Efflorescence/ Rust Staining	1120	18
112	Mortar Breakdown (Masonry)	1610	18
113	Delamination/ Spall/ Patched Area	1080	18
114	Split/Spall (Masonry)	1620	18
115	Patched Area (Masonry)	1630	18
116	Masonry Displacement	1640	18
117	Distortion	1900	18
118	Damage	7000	18
119	Corrosion	1000	19
120	Fatigue Crack (Steel/Other)	1010	19
121	Connection	1020	19
122	Distortion	1900	19
123	Damage	7000	19
124	Delamination/ Spall/ Patched Area	1080	20
125	Exposed Rebar	1090	20
126	Exposed Prestressing	1100	20
127	Cracking (PSC)	1110	20
128	Efflorescence/ Rust Staining	1120	20
129	Damage	7000	20
130	Delamination/ Spall/ Patched Area	1080	21
131	Exposed Rebar	1090	21
132	Efflorescence/ Rust Staining	1120	21
133	Cracking (RC and Other)	1130	21
134	Damage	7000	21
135	Corrosion	1000	22
136	Fatigue Crack (Steel/Other)	1010	22
137	Connection	1020	22
138	Delamination/ Spall/ Patched Area	1080	22
139	Efflorescence/ Rust Staining	1120	22
140	Cracking (RC and Other)	1130	22
141	Deterioration (Other)	1220	22
142	Distortion	1900	22
143	Damage	7000	22
144	Corrosion	1000	23
145	Fatigue Crack (Steel/Other)	1010	23
146	Connection	1020	23
147	Distortion	1900	23
148	Damage	7000	23
149	Delamination/ Spall/ Patched Area	1080	24
150	Exposed Rebar	1090	24
151	Exposed Prestressing	1100	24
152	Cracking (PSC)	1110	24
153	Efflorescence/ Rust Staining	1120	24
154	Damage	7000	24
155	Delamination/ Spall/ Patched Area	1080	25
156	Exposed Rebar	1090	25
157	Efflorescence/ Rust Staining	1120	25
158	Cracking (RC and Other)	1130	25
159	Damage	7000	25
160	Connection	1020	26
161	Decay/Section Loss	1140	26
162	Check/Shake	1150	26
163	Crack (Timber)	1160	26
164	Split/Delamination (Timber)	1170	26
165	Abrasion/Wear (Timber)	1180	26
166	Damage	7000	26
167	Corrosion	1000	27
168	Fatigue Crack (Steel/Other)	1010	27
169	Connection	1020	27
170	Delamination/ Spall/ Patched Area	1080	27
171	Efflorescence/ Rust Staining	1120	27
172	Cracking (RC and Other)	1130	27
173	Deterioration (Other)	1220	27
174	Distortion	1900	27
175	Damage	7000	27
176	Corrosion	1000	28
177	Fatigue Crack (Steel/Other)	1010	28
178	Connection	1020	28
179	Distortion	1900	28
180	Damage	7000	28
181	Connection	1020	29
182	Decay/Section Loss	1140	29
183	Check/Shake	1150	29
184	Crack (Timber)	1160	29
185	Split/Delamination (Timber)	1170	29
186	Abrasion/Wear (Timber)	1180	29
187	Damage	7000	29
188	Corrosion	1000	30
189	Fatigue Crack (Steel/Other)	1010	30
190	Connection	1020	30
191	Delamination/ Spall/ Patched Area	1080	30
192	Efflorescence/ Rust Staining	1120	30
193	Cracking (RC and Other)	1130	30
194	Deterioration (Other)	1220	30
195	Distortion	1900	30
196	Damage	7000	30
197	Corrosion	1000	31
198	Fatigue Crack (Steel/Other)	1010	31
199	Connection	1020	31
200	Distortion	1900	31
201	Damage	7000	31
202	Corrosion	1000	32
203	Fatigue Crack (Steel/Other)	1010	32
204	Connection	1020	32
205	Cracking (RC and Other)	1130	32
206	Deterioration (Other)	1220	32
207	Distortion	1900	32
208	Delamination/ Spall/ Patched Area	1080	32
209	Efflorescence/ Rust Staining	1120	32
210	Damage	7000	32
211	Delamination/ Spall/ Patched Area	1080	33
212	Exposed Rebar	1090	33
213	Exposed Prestressing	1100	33
214	Cracking (PSC)	1110	33
215	Efflorescence/ Rust Staining	1120	33
216	Abrasion/Wear (PSC/RC)	1190	33
217	Damage	7000	33
218	Delamination/ Spall/ Patched Area	1080	34
219	Exposed Rebar	1090	34
220	Efflorescence/ Rust Staining	1120	34
221	Cracking (RC and Other)	1130	34
222	Abrasion/Wear (PSC/RC)	1190	34
223	Damage	7000	34
224	Efflorescence/ Rust Staining	1120	35
225	Mortar Breakdown (Masonry)	1610	35
226	Split/Spall (Masonry)	1620	35
227	Patched Area (Masonry)	1630	35
228	Masonry Displacement	1640	35
229	Damage	7000	35
230	Connection	1020	36
231	Decay/Section Loss	1140	36
232	Check/Shake	1150	36
233	Crack (Timber)	1160	36
234	Split/Delamination (Timber)	1170	36
235	Abrasion/Wear (Timber)	1180	36
236	Damage	7000	36
237	Corrosion	1000	37
238	Fatigue Crack (Steel/Other)	1010	37
239	Connection	1020	37
240	Distortion	1900	37
241	Damage	7000	37
242	Delamination/ Spall/ Patched Area	1080	38
243	Exposed Rebar	1090	38
244	Exposed Prestressing	1100	38
245	Cracking (PSC)	1110	38
246	Efflorescence/ Rust Staining	1120	38
247	Damage	7000	38
248	Delamination/ Spall/ Patched Area	1080	39
249	Exposed Rebar	1090	39
250	Efflorescence/ Rust Staining	1120	39
251	Cracking (RC and Other)	1130	39
252	Damage	7000	39
253	Connection	1020	40
254	Decay/Section Loss	1140	40
255	Check/Shake	1150	40
256	Crack (Timber)	1160	40
257	Split/Delamination (Timber)	1170	40
258	Abrasion/Wear (Timber)	1180	40
259	Damage	7000	40
260	Corrosion	1000	41
261	Fatigue Crack (Steel/Other)	1010	41
262	Connection	1020	41
263	Delamination/ Spall/ Patched Area	1080	41
264	Efflorescence/ Rust Staining	1120	41
265	Cracking (RC and Other)	1130	41
266	Deterioration (Other)	1220	41
267	Distortion	1900	41
268	Damage	7000	41
269	Corrosion	1000	42
270	Fatigue Crack (Steel/Other)	1010	42
271	Connection	1020	42
272	Distortion	1900	42
273	Damage	7000	42
274	Delamination/ Spall/ Patched Area	1080	43
275	Exposed Rebar	1090	43
276	Exposed Prestressing	1100	43
277	Cracking (PSC)	1110	43
278	Efflorescence/ Rust Staining	1120	43
279	Damage	7000	43
280	Delamination/ Spall/ Patched Area	1080	44
281	Exposed Rebar	1090	44
282	Efflorescence/ Rust Staining	1120	44
283	Cracking (RC and Other)	1130	44
284	Damage	7000	44
285	Connection	1020	45
286	Decay/Section Loss	1140	45
287	Check/Shake	1150	45
288	Crack (Timber)	1160	45
289	Split/Delamination (Timber)	1170	45
290	Abrasion/Wear (Timber)	1180	45
291	Damage	7000	45
292	Corrosion	1000	46
293	Fatigue Crack (Steel/Other)	1010	46
294	Connection	1020	46
295	Delamination/ Spall/ Patched Area	1080	46
296	Efflorescence/ Rust Staining	1120	46
297	Cracking (RC and Other)	1130	46
298	Deterioration (Other)	1220	46
299	Distortion	1900	46
300	Damage	7000	46
301	Corrosion	1000	47
302	Fatigue Crack (Steel/Other)	1010	47
303	Connection	1020	47
304	Distortion	1900	47
305	Damage	7000	47
306	Corrosion	1000	48
307	Fatigue Crack (Steel/Other)	1010	48
308	Connection	1020	48
309	Distortion	1900	48
310	Damage	7000	48
311	Corrosion	1000	49
312	Fatigue Crack (Steel/Other)	1010	49
313	Connection	1020	49
314	Deterioration (Other)	1220	49
315	Distortion	1900	49
316	Damage	7000	49
317	Corrosion	1000	50
318	Fatigue Crack (Steel/Other)	1010	50
319	Connection	1020	50
320	Distortion	1900	50
321	Damage	7000	50
322	Corrosion	1000	51
323	Fatigue Crack (Steel/Other)	1010	51
324	Connection	1020	51
325	Distortion	1900	51
326	Damage	7000	51
327	Corrosion	1000	52
328	Fatigue Crack (Steel/Other)	1010	52
329	Connection	1020	52
330	Distortion	1900	52
331	Damage	7000	52
332	Corrosion	1000	53
333	Fatigue Crack (Steel/Other)	1010	53
334	Connection	1020	53
335	Distortion	1900	53
336	Damage	7000	53
337	Corrosion	1000	54
338	Fatigue Crack (Steel/Other)	1010	54
339	Connection	1020	54
340	Distortion	1900	54
341	Cable Slack	1025	54
342	Damage	7000	54
343	Corrosion	1000	55
344	Fatigue Crack (Steel/Other)	1010	55
345	Connection	1020	55
346	Distortion	1900	55
347	Cable Slack	1025	55
348	Damage	7000	55
349	Corrosion	1000	56
350	Fatigue Crack (Steel/Other)	1010	56
351	Connection	1020	56
352	Distortion	1900	56
353	Cable Slack	1025	56
354	Damage	7000	56
355	Corrosion	1000	57
356	Connection	1020	57
357	Movement	2210	57
358	Alignment	2220	57
359	Bulging, Splitting or Tearing	2230	57
360	Loss of Bearing Area	2240	57
361	Damage	7000	57
362	Corrosion	1000	58
363	Connection	1020	58
364	Movement	2210	58
365	Alignment	2220	58
366	Loss of Bearing Area	2240	58
367	Damage	7000	58
368	Corrosion	1000	59
369	Connection	1020	59
370	Movement	2210	59
371	Alignment	2220	59
372	Loss of Bearing Area	2240	59
373	Damage	7000	59
374	Corrosion	1000	60
375	Connection	1020	60
376	Movement	2210	60
377	Alignment	2220	60
378	Loss of Bearing Area	2240	60
379	Damage	7000	60
380	Corrosion	1000	61
381	Connection	1020	61
382	Movement	2210	61
383	Alignment	2220	61
384	Bulging, Splitting or Tearing	2230	61
385	Loss of Bearing Area	2240	61
386	Damage	7000	61
387	Corrosion	1000	62
388	Connection	1020	62
389	Movement	2210	62
390	Alignment	2220	62
391	Loss of Bearing Area	2240	62
392	Damage	7000	62
393	Corrosion	1000	63
394	Connection	1020	63
395	Movement	2210	63
396	Alignment	2220	63
397	Loss of Bearing Area	2240	63
398	Damage	7000	63
399	Delamination/ Spall/ Patched Area	1080	64
400	Exposed Rebar	1090	64
401	Efflorescence/ Rust Staining	1120	64
402	Cracking (RC and Other)	1130	64
403	Abrasion/Wear (PSC/RC)	1190	64
404	Settlement	4000	64
405	Scour	6000	64
406	Damage	7000	64
407	Connection	1020	65
408	Decay/Section Loss	1140	65
409	Check/Shake	1150	65
410	Crack (Timber)	1160	65
411	Split/Delamination (Timber)	1170	65
412	Abrasion/Wear (Timber)	1180	65
413	Settlement	4000	65
414	Scour	6000	65
415	Damage	7000	65
416	Efflorescence/ Rust Staining	1120	66
417	Mortar Breakdown (Masonry)	1610	66
418	Split/Spall (Masonry)	1620	66
419	Patched Area (Masonry)	1630	66
420	Masonry Displacement	1640	66
421	Settlement	4000	66
422	Scour	6000	66
423	Damage	7000	66
424	Corrosion	1000	67
425	Fatigue Crack (Steel/Other)	1010	67
426	Connection	1020	67
427	Cracking (RC and Other)	1130	67
428	Deterioration (Other)	1220	67
429	Distortion	1900	67
430	Delamination/ Spall/ Patched Area	1080	67
431	Efflorescence/ Rust Staining	1120	67
432	Settlement	4000	67
433	Scour	6000	67
434	Damage	7000	67
435	Corrosion	1000	68
436	Fatigue Crack (Steel/Other)	1010	68
437	Connection	1020	68
438	Distortion	1900	68
439	Settlement	4000	68
440	Scour	6000	68
441	Damage	7000	68
442	Corrosion	1000	69
443	Fatigue Crack (Steel/Other)	1010	69
444	Connection	1020	69
445	Distortion	1900	69
446	Damage	7000	69
447	Delamination/ Spall/ Patched Area	1080	70
448	Exposed Rebar	1090	70
449	Exposed Prestressing	1100	70
450	Cracking (PSC)	1110	70
451	Efflorescence/ Rust Staining	1120	70
452	Damage	7000	70
453	Delamination/ Spall/ Patched Area	1080	71
454	Exposed Rebar	1090	71
455	Efflorescence/ Rust Staining	1120	71
456	Cracking (RC and Other)	1130	71
457	Damage	7000	71
458	Connection	1020	72
459	Decay/Section Loss	1140	72
460	Check/Shake	1150	72
461	Crack (Timber)	1160	72
462	Split/Delamination (Timber)	1170	72
463	Abrasion/Wear (Timber)	1180	72
464	Damage	7000	72
465	Corrosion	1000	73
466	Fatigue Crack (Steel/Other)	1010	73
467	Connection	1020	73
468	Cracking (RC and Other)	1130	73
469	Deterioration (Other)	1220	73
470	Distortion	1900	73
471	Delamination/ Spall/ Patched Area	1080	73
472	Efflorescence/ Rust Staining	1120	73
473	Damage	7000	73
474	Corrosion	1000	74
475	Fatigue Crack (Steel/Other)	1010	74
476	Connection	1020	74
477	Distortion	1900	74
478	Settlement	4000	74
479	Scour	6000	74
480	Damage	7000	74
481	Corrosion	1000	75
482	Fatigue Crack (Steel/Other)	1010	75
483	Connection	1020	75
484	Cracking (RC and Other)	1130	75
485	Deterioration (Other)	1220	75
486	Distortion	1900	75
487	Settlement	4000	75
488	Delamination/ Spall/ Patched Area	1080	75
489	Efflorescence/ Rust Staining	1120	75
490	Scour	6000	75
491	Damage	7000	75
492	Delamination/ Spall/ Patched Area	1080	76
493	Exposed Rebar	1090	76
494	Exposed Prestressing	1100	76
495	Cracking (PSC)	1110	76
496	Efflorescence/ Rust Staining	1120	76
497	Abrasion/Wear (PSC/RC)	1190	76
498	Settlement	4000	76
499	Scour	6000	76
500	Damage	7000	76
501	Delamination/ Spall/ Patched Area	1080	77
502	Exposed Rebar	1090	77
503	Efflorescence/ Rust Staining	1120	77
504	Cracking (RC and Other)	1130	77
505	Abrasion/Wear (PSC/RC)	1190	77
506	Settlement	4000	77
507	Scour	6000	77
508	Damage	7000	77
509	Connection	1020	78
510	Decay/Section Loss	1140	78
511	Check/Shake	1150	78
512	Crack (Timber)	1160	78
513	Split/Delamination (Timber)	1170	78
514	Abrasion/Wear (Timber)	1180	78
515	Settlement	4000	78
516	Scour	6000	78
517	Damage	7000	78
518	Corrosion	1000	79
519	Fatigue Crack (Steel/Other)	1010	79
520	Connection	1020	79
521	Distortion	1900	79
522	Settlement	4000	79
523	Scour	6000	79
524	Damage	7000	79
525	Connection	1020	80
526	Decay/Section Loss	1140	80
527	Check/Shake	1150	80
528	Crack (Timber)	1160	80
529	Split/Delamination (Timber)	1170	80
530	Abrasion/Wear (Timber)	1180	80
531	Settlement	4000	80
532	Scour	6000	80
533	Damage	7000	80
534	Delamination/ Spall/ Patched Area	1080	81
535	Exposed Rebar	1090	81
536	Efflorescence/ Rust Staining	1120	81
537	Cracking (RC and Other)	1130	81
538	Abrasion/Wear (PSC/RC)	1190	81
539	Settlement	4000	81
540	Scour	6000	81
541	Damage	7000	81
542	Corrosion	1000	82
543	Fatigue Crack (Steel/Other)	1010	82
544	Connection	1020	82
545	Cracking (RC and Other)	1130	82
546	Deterioration (Other)	1220	82
547	Distortion	1900	82
548	Settlement	4000	82
549	Delamination/ Spall/ Patched Area	1080	82
550	Efflorescence/ Rust Staining	1120	82
551	Scour	6000	82
552	Damage	7000	82
553	Connection	1020	83
554	Decay/Section Loss	1140	83
555	Check/Shake	1150	83
556	Crack (Timber)	1160	83
557	Split/Delamination (Timber)	1170	83
558	Abrasion/Wear (Timber)	1180	83
559	Settlement	4000	83
560	Scour	6000	83
561	Damage	7000	83
562	Efflorescence/ Rust Staining	1120	84
563	Mortar Breakdown (Masonry)	1610	84
564	Split/Spall (Masonry)	1620	84
565	Patched Area (Masonry)	1630	84
566	Masonry Displacement	1640	84
567	Settlement	4000	84
568	Scour	6000	84
569	Damage	7000	84
570	Delamination/ Spall/ Patched Area	1080	85
571	Exposed Rebar	1090	85
572	Efflorescence/ Rust Staining	1120	85
573	Cracking (RC and Other)	1130	85
574	Abrasion/Wear (PSC/RC)	1190	85
575	Settlement	4000	85
576	Scour	6000	85
577	Damage	7000	85
578	Distortion	1900	86
579	Settlement	4000	86
580	Fatigue Crack (Steel/Other)	1010	86
581	Scour	6000	86
582	Corrosion	1000	86
583	Connection	1020	86
584	Damage	7000	86
585	Delamination/ Spall/ Patched Area	1080	87
586	Exposed Rebar	1090	87
587	Exposed Prestressing	1100	87
588	Abrasion/Wear (PSC/RC)	1190	87
589	Settlement	4000	87
590	Cracking (PSC)	1110	87
591	Efflorescence/ Rust Staining	1120	87
592	Scour	6000	87
593	Damage	7000	87
594	Delamination/ Spall/ Patched Area	1080	88
595	Exposed Rebar	1090	88
596	Efflorescence/ Rust Staining	1120	88
597	Cracking (RC and Other)	1130	88
598	Abrasion/Wear (PSC/RC)	1190	88
599	Settlement	4000	88
600	Scour	6000	88
601	Damage	7000	88
602	Connection	1020	89
603	Decay/Section Loss	1140	89
604	Check/Shake	1150	89
605	Crack (Timber)	1160	89
606	Split/Delamination (Timber)	1170	89
607	Abrasion/Wear (Timber)	1180	89
608	Settlement	4000	89
609	Scour	6000	89
610	Damage	7000	89
611	Corrosion	1000	90
612	Fatigue Crack (Steel/Other)	1010	90
613	Connection	1020	90
614	Cracking (RC and Other)	1130	90
615	Deterioration (Other)	1220	90
616	Distortion	1900	90
617	Delamination/ Spall/ Patched Area	1080	90
618	Efflorescence/ Rust Staining	1120	90
619	Settlement	4000	90
620	Scour	6000	90
621	Damage	7000	90
622	Corrosion	1000	91
623	Fatigue Crack (Steel/Other)	1010	91
624	Connection	1020	91
625	Distortion	1900	91
626	Settlement	4000	91
627	Scour	6000	91
628	Damage	7000	91
629	Corrosion	1000	92
630	Cracking (RC and Other)	1130	92
631	Settlement	4000	92
632	Distortion	1900	92
633	Scour	6000	92
634	Damage	7000	92
635	Corrosion	1000	93
636	Fatigue Crack (Steel/Other)	1010	93
637	Connection	1020	93
638	Distortion	1900	93
639	Damage	7000	93
640	Corrosion	1000	94
641	Fatigue Crack (Steel/Other)	1010	94
642	Connection	1020	94
643	Distortion	1900	94
644	Damage	7000	94
645	Delamination/ Spall/ Patched Area	1080	95
646	Exposed Rebar	1090	95
647	Deterioration (Other)	1220	95
648	Cracking (RC and Other)	1130	95
649	Settlement	4000	95
650	Scour	6000	95
651	Damage	7000	95
652	Distortion	1900	96
653	Settlement	4000	96
654	Fatigue Crack (Steel/Other)	1010	96
655	Scour	6000	96
656	Corrosion	1000	96
657	Connection	1020	96
658	Damage	7000	96
659	Delamination/ Spall/ Patched Area	1080	97
660	Exposed Rebar	1090	97
661	Efflorescence/ Rust Staining	1120	97
662	Cracking (RC and Other)	1130	97
663	Abrasion/Wear (PSC/RC)	1190	97
664	Distortion	1900	97
665	Settlement	4000	97
666	Scour	6000	97
667	Damage	7000	97
668	Connection	1020	98
669	Decay/Section Loss	1140	98
670	Check/Shake	1150	98
671	Crack (Timber)	1160	98
672	Split/Delamination (Timber)	1170	98
673	Abrasion/Wear (Timber)	1180	98
674	Distortion	1900	98
675	Settlement	4000	98
676	Scour	6000	98
677	Damage	7000	98
678	Corrosion	1000	99
679	Fatigue Crack (Steel/Other)	1010	99
680	Connection	1020	99
681	Delamination/ Spall/ Patched Area	1080	99
682	Efflorescence/ Rust Staining	1120	99
683	Cracking (RC and Other)	1130	99
684	Deterioration (Other)	1220	99
685	Distortion	1900	99
686	Settlement	4000	99
687	Scour	6000	99
688	Damage	7000	99
689	Efflorescence/ Rust Staining	1120	100
690	Mortar Breakdown (Masonry)	1610	100
691	Split/Spall (Masonry)	1620	100
692	Patched Area (Masonry)	1630	100
693	Masonry Displacement	1640	100
694	Distortion	1900	100
695	Settlement	4000	100
696	Scour	6000	100
697	Damage	7000	100
698	Delamination/ Spall/ Patched Area	1080	101
699	Exposed Rebar	1090	101
700	Exposed Prestressing	1100	101
701	Cracking (PSC)	1110	101
702	Efflorescence/ Rust Staining	1120	101
703	Abrasion/Wear (PSC/RC)	1190	101
704	Distortion	1900	101
705	Settlement	4000	101
706	Scour	6000	101
707	Damage	7000	101
708	Leakage	2310	102
709	Seal Adhesion	2320	102
710	Seal Damage	2330	102
711	Seal Cracking	2340	102
712	Debris Impaction	2350	102
713	Adjacent Deck or Header	2360	102
714	Metal Deterioration or Damage	2370	102
715	Damage	7000	102
716	Leakage	2310	103
717	Seal Adhesion	2320	103
718	Seal Damage	2330	103
719	Seal Cracking	2340	103
720	Debris Impaction	2350	103
721	Adjacent Deck or Header	2360	103
722	Damage	7000	103
723	Leakage	2310	104
724	Seal Adhesion	2320	104
725	Seal Damage	2330	104
726	Seal Cracking	2340	104
727	Debris Impaction	2350	104
728	Adjacent Deck or Header	2360	104
729	Damage	7000	104
730	Leakage	2310	105
731	Seal Adhesion	2320	105
732	Seal Damage	2330	105
733	Seal Cracking	2340	105
734	Debris Impaction	2350	105
735	Adjacent Deck or Header	2360	105
736	Metal Deterioration or Damage	2370	105
737	Damage	7000	105
738	Debris Impaction	2350	106
739	Adjacent Deck or Header	2360	106
740	Damage	7000	106
741	Debris Impaction	2350	107
742	Adjacent Deck or Header	2360	107
743	Metal Deterioration or Damage	2370	107
744	Damage	7000	107
745	Leakage	2310	108
746	Debris Impaction	2350	108
747	Adjacent Deck or Header	2360	108
748	Metal Deterioration or Damage	2370	108
749	Damage	7000	108
750	Leakage	2310	109
751	Seal Adhesion	2320	109
752	Seal Adhesion	2320	109
753	Damage	7000	109
754	Debris Impaction	2350	110
755	Adjacent Deck or Header	2360	110
756	Metal Deterioration or Damage	2370	110
757	Damage	7000	110
758	Debris Impaction	2350	111
759	Adjacent Deck or Header	2360	111
760	Metal Deterioration or Damage	2370	111
761	Damage	7000	111
762	Delamination/ Spall/ Patched Area	1080	112
763	Exposed Rebar	1090	112
764	Exposed Prestressing	1100	112
765	Cracking (PSC)	1110	112
766	Abrasion/Wear (PSC/RC)	1190	112
767	Settlement	4000	112
768	Damage	7000	112
769	Delamination/ Spall/ Patched Area	1080	113
770	Exposed Rebar	1090	113
771	Cracking (RC and Other)	1130	113
772	Abrasion/Wear (PSC/RC)	1190	113
773	Settlement	4000	113
774	Damage	7000	113
775	Delamination/ Patched Area/ Pothole (Wearing Surfaces)	3210	114
776	Crack (Wearing Surface)	3220	114
777	Effectiveness (Wearing Surface)	3230	114
778	Damage	7000	114
779	Delamination/ Patched Area/ Pothole (Wearing Surfaces)	3210	115
780	Crack (Wearing Surface)	3220	115
781	Effectiveness (Wearing Surface)	3230	115
782	Damage	7000	115
783	Delamination/ Patched Area/ Pothole (Wearing Surfaces)	3210	116
784	Crack (Wearing Surface)	3220	116
785	Effectiveness (Wearing Surface)	3230	116
786	Damage	7000	116
787	Connection	1020	117
788	Decay/Section Loss	1140	117
789	Check/Shake	1150	117
790	Crack (Timber)	1160	117
791	Split/Delamination (Timber)	1170	117
792	Abrasion/Wear (Timber)	1180	117
793	Damage	7000	117
794	Chalking\n(Steel Protective Coatings)	3410	118
795	Peeling/Bubbling/Cracking (Steel Protective Coatings)	3420	118
796	Effectiveness\n(Steel Protective Coatings)	3440	118
797	Damage	7000	118
798	Peeling/Bubbling/Cracking (Steel Protective Coatings)	3420	119
799	Oxide Film Degradation Color/ Texture Adherence (Steel Protective Coatings)	3430	119
800	Effectiveness\n(Steel Protective Coatings)	3440	119
801	Damage	7000	119
802	Peeling/Bubbling/Cracking (Steel Protective Coatings)	3420	120
803	Oxide Film Degradation Color/ Texture Adherence (Steel Protective Coatings)	3430	120
804	Effectiveness\n(Steel Protective Coatings)	3440	120
805	Damage	7000	120
806	Effectiveness (Rebar Protective System- Coating/Cathodic)	3600	121
807	Damage	7000	121
808	Wear\n(Concrete Protective Coatings)	3510	122
809	Effectiveness (Concrete Protective Coatings)	3540	122
810	Damage	7000	122
811	Wear\n(Concrete Protective Coatings)	3510	123
812	Effectiveness (Concrete Protective Coatings)	3540	123
813	Damage	7000	123
\.


--
-- Data for Name: inspection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inspection (id, start_date, end_date, structure_id, status, company_id, inspector_id, general_summary, term_rating, sgr_rating, temperature, humidity, wind) FROM stdin;
\.


--
-- Data for Name: inspector; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inspector (id, first_name, last_name, email, "position") FROM stdin;
1	Dusty	Birge	dusty@uav-recon.com	President UAV Recon, VOLT manager, entrepreneur
2	Wesley	Alexander	walexander@tmisolutionsllc.com	\N
3	VOLT	User	sales@voltinspections.com	\N
4	Mark	Vonleffern	mark@vonleffern.com	\N
5	Carolina	Burgan	cburgan@altavistasolutions.com	\N
6	Edward	Leach	eleach@altavistasolutions.com	\N
7	Mohamed	Abdelbarr	mabdelbarr@altavistasolutions.com	\N
\.


--
-- Data for Name: material; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.material (id, name, description, measure_unit, subcomponent_id) FROM stdin;
1	Deck - Reinforced Concrete	All reinforced concrete bridge decks regardless of the wearing surface or protection systems used.	sq.ft.	1
2	Deck â Prestressed Concrete	All prestressed concrete bridge decks regardless of the wearing surface or protection systems used.	sq.ft.	1
3	Top Flange - Prestressed Concrete	All prestressed bridge girder top flanges where traffic rides directly on the structural element\nregardless of the wearing surface or protection systems used. These bridge types include only\nconcrete bulb-tees, box girders, and girders that require traffic to ride on the top flange. Use in\nconjunction with the appropriate girder element.	sq.ft.	1
4	Top Flange - Reinforced Concrete	All reinforced concrete bridge girder top flanges where traffic rides directly on the structural element\nregardless of the wearing surface or protection systems used. These bridge types include only\nconcrete tee-beams, box girders, and girders that require traffic to ride on the top flange. Use in\nconjunction with the appropriate girder element.	sq.ft.	1
5	Steel Deck - Open Grid	All open grid steel bridge decks with no fill.	sq.ft.	1
6	Steel Deck - Concrete Filled Grid	Steel bridge decks with concrete fill either in all of the openings or within the wheel tracks.	sq.ft.	1
7	Steel Deck - Corrugated/Orthotropic/Etc.	Those bridge decks constructed of corrugated metal filled with portland cement, asphaltic concrete,\nor other riding surfaces. Orthotropic steel decks are also included.	sq.ft.	1
8	Deck - Timber	All timber bridge decks regardless of the wearing surface or protection systems used.	sq.ft.	1
9	Slab - Reinforced Concrete	All reinforced concrete bridge slabs regardless of the wearing surface or protection systems used.	sq.ft.	1
10	Slab - Prestressed Concrete	All prestressed concrete bridge slabs regardless of the wearing surface or protection systems used.	sq.ft.	1
11	Slab - Timber	All timber bridge slabs regardless of the wearing surface or protection systems used.	sq.ft.	1
12	Deck - Other	All bridge decks constructed of other materials not otherwise defined regardless of the wearing\nsurface or protection systems used.	sq.ft.	1
13	Slab - Other	All slabs constructed of other materials not otherwise defined regardless of the wearing surface or\nprotection systems used.	sq.ft.	1
14	Bridge Railing - Metal	All types and shapes of metal bridge railing. Steel, aluminum, metal beam, rolled shapes, etc. will all\nbe considered part of this element. Included in this element are the posts of metal, timber or\nconcrete, blocking, and curb.	ft.	2
15	Bridge Railing - Reinforced Concrete	All types and shapes of reinforced concrete bridge railing. All elements of the railing must be concrete.	ft.	2
16	Bridge Railing - Timber	All types and shapes of timber bridge railing. Included in this element are posts of timber, metal, or\nconcrete, blocking, and curb.	ft.	2
17	Bridge Railing - Other	All types and shapes of bridge railing except those defined as metal, concrete, timber, or masonry.\nUse this element for combination rails that have concrete parapets and metal top sections attached.	ft.	2
18	Bridge Railing - Masonry	All types and shapes of masonry block or stone bridge railing. All elements of the railing must be\nmasonry block or stone.	ft.	2
19	Closed Web/Box Girder - Steel	All steel box girders or closed web girders. For all box girders regardless of protective system.	ft.	3
20	Closed Web/Box Girder - Prestressed Concrete	All pretensioned or post-tensioned concrete closed web girders or box girders. For all box girders\nregardless of protective system.	ft.	3
21	Closed Web/Box Girder - Reinforced Concrete	All reinforced concrete box girders or closed web girders. For all box girders regardless of protective\nsystem.	ft.	3
22	Closed Web/Box Girder - Other	All other material box girders or closed web girders. For all other material box girders regardless of\nprotective system.	ft.	3
23	Open Girder/Beam - Steel	All steel open girders regardless of protective system.	ft.	3
24	Open Girder/Beam - Prestressed Concrete	Pretensioned or post-tensioned concrete open web girders regardless of protective system.	ft.	3
25	Open Girder/Beam - Reinforced Concrete	Mild steel reinforced concrete open web girders regardless of protective system.	ft.	3
26	Open Girder/Beam - Timber	All timber open girders regardless of protection system.	ft.	3
27	Open Girder/Beam - Other	All other material girders regardless of protection system.	ft.	3
28	Truss - Steel	All steel truss elements, including all tension and compression members for through and deck trusses.\nIt is for all trusses regardless of protective system.	ft.	4
29	Truss - Timber	All timber truss elements, including all tension and compression members for through and deck\ntrusses. It is for all trusses regardless of protective system.	ft.	4
30	Truss - Other	All other material truss elements, including all tension and compression members, and through and\ndeck trusses. It is for all other material trusses regardless of protective system.	ft.	4
31	Arch - Steel	Steel arches regardless of type or protective system.	ft.	4
32	Arch - Other	Other material arches regardless of type or protective system.	ft.	4
33	Arch - Prestressed Concrete	Only pretensioned or post-tensioned concrete arches regardless of protective system.	ft.	4
34	Arch - Reinforced Concrete	Only mild steel reinforced concrete arches regardless of protective system.	ft.	4
35	Arch - Masonry	Masonry or stacked stone arches regardless of protective system.	ft.	4
36	Arch - Timber	Only timber arches regardless of protective system.	ft.	4
37	Stringer - Steel	Steel members that support the deck in a stringer floor beam system regardless of protective system.	ft.	5
38	Stringer - Prestressed Concrete	Pretensioned or post-tensioned concrete members that support the deck in a stringer floor beam\nsystem regardless of protective system.	ft.	5
39	Stringer - Reinforced Concrete	Mild steel reinforced concrete members that support the deck in a stringer floor beam system\nregardless of protective system.	ft.	5
40	Stringer - Timber	Timber members that support the deck in a stringer floor beam system regardless of protective\nsystem.	ft.	5
41	Stringer - Other	All other material stringers regardless of protection system.	ft.	5
42	Floor Beam - Steel	Steel floor beams that typically support stringers regardless of protective system.	ft.	6
43	Floor Beam - Prestressed Concrete	Prestressed concrete floor beams that typically support stringers regardless of protective system.	ft.	6
44	Floor Beam - Reinforced Concrete	Mild steel reinforced concrete floor beams that typically support stringers regardless of protective\nsystem.	ft.	6
45	Floor Beam - Timber	Timber floor beams that typically support stringers regardless of protective system.	ft.	6
46	Floor Beam - Other	Other material floor beams that typically support stringers regardless of protective system.	ft.	6
47	Cables - Main Steel	All steel main suspension or cable stay cables not embedded in concrete.\nFor all cable groups regardless of protective systems.	ft.	7
48	Cables - Secondary Steel	All steel suspender cables not embedded in concrete.\nFor all individual or cable groups regardless of protective system.	Each	7
49	Cables - Secondary Other	All other material cables not embedded in concrete.\nFor all individual other material cables or cable groups regardless of protective systems.	Each	7
50	Steel Pin and Pin & Hanger Assembly	Steel pins and pin and hanger assemblies regardless of protective system.	Each	7
51	Steel Gusset Plate	Only those steel gusset plate(s) connections that are on the main truss/arch panel(s).\nThese connections can be constructed with one or more plates that may be bolted, riveted, or\nwelded. For all gusset plates regardless of protective system.	Each	7
52	Railroad Car Frame	This member defines all superstructures composed of railroad car frames.	ft.	7
53	Miscellaneous Steel Superstructures	This member is intended to be used for all other miscellaneous steel superstructure elements that\nwere not previously defined.\nExamples of such structures includes army steel tread way, boat hatch cover, army steel pontoon, etc.\nThe entire superstructure area (equivalent deck area) composed of these miscellaneous elements will\nbe treated as an each regardless of the number of spans.	Each	7
54	EQ Restrainer Cables â Type II	This member defines seismic restrainer cables used for hinges with long hinge seats (>9 inches) and\noccasionally in combination with pipe seat extenders. The standard length varies from fifteen to forty\nfeet and the restrainer system at a hinge may consist of six to twelve cables.	Each Unit	7
55	EQ Restrainer Cables â C1	This member defines seismic restrainer cables used for hinges with short hinge seats (<9 inches).\nThe current standard number of cables per drum is five. The original systems consisted of seven\ncables per drum.	Each Unit	7
56	EQ Restrainer Cables - Other	This element defines Seismic restrainer cables systems that are not Type II or C-1 restrainer cable\nsystems.	Each Unit	7
57	Bearing - Elastomeric	Only those bridge bearings that are constructed primarily of elastomers, with or without fabric or\nmetal reinforcement.	Each	8
58	Bearing - Movable	Only those bridge bearings which provide for both rotation and longitudinal movement by means of\nroller, rocker, or sliding mechanisms.	Each	8
59	Bearing - Enclosed/Concealed	Only those bridge bearings that are enclosed so that they are not open for detailed inspection.	Each	8
60	Bearing - Fixed	Only those bridge bearings that provide for rotation only (no longitudinal movement.	Each	8
61	Bearing - Pot	Those high load bearings with confined elastomer. The bearing may be fixed against horizontal\nmovement, guided to allow sliding in one direction, or floating to allow sliding in any direction.	Each	8
62	Bearing - Disk	Those high load bearings with a hard plastic disk. This bearing may be fixed against horizontal\nmovement, guided to allow movement in one direction, or floating to allow sliding in any direction.	Each	8
63	Bearing - Other	All other material bridge bearings regardless of translation or rotation constraints.	Each	8
64	Abutment - Reinforced Concrete	Reinforced concrete abutments. This includes the material retaining the embankment and monolithic\nwingwalls and abutment extensions. For all reinforced concrete abutments regardless of protective\nsystems.	ft.	9
65	Abutment - Timber	Timber abutments, including the sheet material retaining the embankment, integral wingwalls, and\nabutment extensions. For all abutments regardless of protective systems.	ft.	9
66	Abutment - Masonry	Those abutments constructed of block or stone, including integral wingwalls and abutment\nextensions. The block or stone may be placed with or without mortar. For all abutments regardless of\nprotective systems.	ft.	9
67	Abutment - Other	Other material abutment systems, including the sheet material retaining the embankment, and\nintegral wingwalls and abutment extensions. For all abutments regardless of protective systems.	ft.	9
68	Abutment - Steel	Steel abutments, including the sheet material retaining the embankment, and integral wingwalls and\nabutment extensions. For all abutments regardless of protective systems.	ft.	9
69	Pier Cap - Steel	Those steel pier caps that support girders and transfer load into piles or columns. For all steel pier\ncaps regardless of protective system.	ft.	10
70	Pier Cap - Prestressed Concrete	Those prestressed concrete pier caps that support girders and transfer load into piles or columns. For\nall caps regardless of protective system.	ft.	10
71	Pier Cap - Reinforced Concrete	Those reinforced concrete pier caps that support girders and transfer load into piles or columns. For\nall pier caps regardless of protective system.	ft.	10
72	Pier Cap - Timber	Those timber pier caps that support girders that transfer load into piles, or columns. For all timber\npier caps regardless of protective system.	ft.	10
73	Pier Cap - Other	Other material pier caps that support girders that transfer load into piles or columns. For all other\nmaterial pier caps regardless of protective system.	ft.	10
74	Column - Steel	All steel columns regardless of protective system.	Each	11
75	Column - Other	All other material columns regardless of protective system.	Each	11
76	Column - Prestressed Concrete	All prestressed concrete columns regardless of protective system.	Each	11
77	Column - Reinforced Concrete	All reinforced concrete columns regardless of protective system.	Each	11
78	Column - Timber	All timber columns regardless of protective system.	Each	11
79	Tower - Steel	Steel built up or framed tower supports regardless of protective system.	ft.	11
80	Trestle - Timber	Framed timber supports. For all timber trestle/towers regardless of protective system.	ft.	11
81	Pier Wall - Reinforced Concrete	Reinforced concrete pier walls regardless of protective systems.	ft.	11
82	Pier Wall - Other	Those pier walls constructed of other materials regardless of protective systems.	ft.	11
83	Pier Wall - Timber	Those timber pier walls that include pile, timber sheet material, and filler. For all pier walls regardless\nof protective systems.	ft.	11
84	Pier Wall - Masonry	Those pier walls constructed of block or stone. The block or stone may be placed with or without\nmortar. For all pier walls regardless of protective systems.	ft.	11
85	Pile Cap/Footing - Reinforced Concrete	Reinforced concrete pile caps/footings that are visible for inspection, including pile caps/footings\nexposed from erosion or scour or visible during an underwater inspection. The exposure may be\nintentional or caused by erosion or scour.	ft.	12
86	Pile - Steel	Steel piles that are visible for inspection, including piles exposed from erosion or scour and piles\nvisible during an underwater inspection. For all steel piles regardless of protective system.	Each	12
87	Pile - Prestressed Concrete	Prestressed concrete piles that are visible for inspection, including piles exposed from erosion or scour\nand piles visible during an underwater inspection. For all prestressed concrete piles regardless of\nprotective system.	Each	12
88	Pile - Reinforced Concrete	Reinforced concrete piles that are visible for inspection, including piles exposed from erosion or scour\nand piles visible during an underwater inspection are included. For all reinforced concrete piles\nregardless of protective system.	Each	12
89	Pile - Timber	Timber piles that are visible for inspection, including piles exposed from erosion or scour and piles\nvisible during an underwater inspection. For all timber piles regardless of protective system.	Each	12
90	Pile - Other	Other material piles that are visible for inspection, including piles exposed from erosion or scour and\npiles visible during an underwater inspection. For all other material piles regardless of protective\nsystem.	Each	12
91	Pile - Cast in Steel Shell	Steel piles filled with concrete. Not for use with steel forms for fully reinforced columns/piles.	Each	12
92	Pile - Cast-In-Drilled-Hole (CIDH)	Reinforced concrete piles that are visible for inspection. The exposure may be intentional or caused\nby scour.	Each	12
93	Steel Seismic Column Shells (Full Height)	Seismic steel confinement shells that are full height.	Each	13
94	Steel Seismic Column Shells (Partial Height)	Seismic steel confinement shells that are partial height.	Each	13
95	Slope/Scour Protection	All types of erosion/scour protection for the supports; including grouted or ungrouted riprap and\nconcrete paving under the bridge.	EA	13
96	Culvert - Steel	Steel culverts, including arched, round, or elliptical pipes.	ft.	14
97	Culvert - Reinforced Concrete	Reinforced concrete culverts, including box, arched, round, or elliptical shapes.	ft.	14
98	Culvert - Timber	All timber culverts.	ft.	14
99	Culvert - Other	Other material type culverts, including arches, round, or elliptical pipes. These culverts are not\nincluded in steel, concrete, or timber material types.	ft.	14
100	Culvert - Masonry	Masonry block or stone culverts.	ft.	14
101	Culvert - Prestressed Concrete	All prestressed concrete culverts.	ft.	14
102	Joint - Strip Seal Expansion	Those expansion joint devices which utilize a neoprene type waterproof gland with some type of\nmetal extrusion or other system to anchor the gland.	ft.	15
103	Joint - Pourable Seal	Those joints filled with a pourable seal with or without a backer.	ft.	15
104	Joint - Compression Seal	Only those joints filled with a preformed compression type seal. This joint may or may not have an\nanchor system to confine the seal.	ft.	15
105	Joint - Assembly with Seal	Only those joints filled with an assembly mechanism that has a seal.	ft.	15
106	Joint - Open Expansion	Only those joints that are open and not sealed.	ft.	15
107	Joint - Assembly Without Seal	Only those assembly joints that are open and not sealed, excluding steel finger and sliding plate joints.	ft.	15
108	Joint - Other	Only those other joints that are not defined by any other joint element.	ft.	15
109	Joint - Asphaltic Plug	Only those joints with a standard asphaltic plug and shall not be used for joints paved over.	ft.	15
110	Joint - Steel Sliding Plates	Only those joints that are open and constructed as sliding plate type joints.	ft.	15
111	Joint - Steel Fingers	Only those joints that are steel finger joints.	ft.	15
112	Approach Slab - Prestressed Concrete	Those structural sections, between the abutment and the approach pavement that are constructed of\nprestressed (post-tensioned) reinforced concrete.	sq.ft.	16
113	Approach Slab - Reinforced Concrete	Those structural sections between the abutment and the approach pavement that are constructed of\nmild steel reinforced concrete.	sq.ft.	16
114	Deck Wearing Surface â Asphaltic Concrete	All decks/slabs that have overlays made with flexible (asphaltic concrete).	sq. ft.	17
115	Deck Wearing Surface â Concrete (Polyester)	This element is for all decks/slabs that have overlays made with rigid (portland cement) materials or\npolyester concrete.	sq. ft.	17
116	Deck Wearing Surface - Epoxy	This element is for all decks/slabs that have overlays made with epoxy materials.	sq. ft.	17
117	Deck Wearing Surface - Timber	All timber wearing surfaces	sq. ft.	17
118	Steel Protective Coating - Paint	Steel elements that have a protective coating such as paint, or other top coat steel corrosion inhibitor.	sq. ft. (surface)	17
119	Steel Protective Coating - Galvanization	The element is for steel elements that have a protective galvanized coating system.	sq ft. (surface)	17
120	Steel Protective Coating - Weathering Steel	Steel elements that have a protective weathering steel coating.	sq.ft. (surface)	17
121	Reinforcing Steel Protective System\n(Rebar Coating/Cathodic)	All types of protective systems used to protect reinforcing steel in concrete elements from corrosion.	sq.ft.	17
122	Concrete Protective Coating (Methacrylate/Sealer)	Concrete elements that have a penetrating sealer applied to them. These coatings include\nsilane/siloxane water proofers, crack sealers such as High Molecular Weight Methacrylate (HMWM),\nor any top coat barrier that protects concrete from deterioration and reinforcing steel from corrosion.	sq.ft. (surface)	17
123	Deck Membrane	Concrete elements that have a protective membrane applied to the member. The typical\nconfiguration is a waterproofing membrane under the AC overlay that protects the concrete from\ndeterioration and reinforcing steel from corrosion.	sq.ft. (surface)	17
\.


--
-- Data for Name: observation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.observation (id, inspection_id, drawing_number, room_number, span_number, location_description, structural_component_id, subcomponent_id) FROM stdin;
\.


--
-- Data for Name: observation_defect; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.observation_defect (id, defect_id, condition_id, observation_id, description, material_id, critical_findings, size) FROM stdin;
\.


--
-- Data for Name: photo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.photo (id, file, latitude, longitude, altitude, start_x, start_y, end_x, end_y, created_date, observation_defect_id) FROM stdin;
\.


--
-- Data for Name: report; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.report (id, date, file, inspection_id) FROM stdin;
\.


--
-- Data for Name: structural_component; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.structural_component (id, name) FROM stdin;
1	Deck & Slabs (sq. ft.)
2	Railings (ft.)
3	Superstructure
4	Bearings (Ea.)
5	Substructure
6	Culverts (ft.)
7	Joints (ft.)
8	Approach Slabs (sq. ft.)
9	Protective Systems
10	Walkways
11	Soil Condtion
\.


--
-- Data for Name: structure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.structure (id, name, type, primary_owner, caltrans_bridge_no, postmile, begin_stationing, end_stationing) FROM stdin;
BR-L01	Slauson Avenue	BRIDGES_AND_AERIAL_STRUCTURE	Los Angeles Metropoliten	53C1924R	5.19999981	160+31\n(L1 155+29)\n(L2 155+52)	185+59\n(190+60)
BR-L02L BR-L02R	Firestone Blvd Bridge	BRIDGES_AND_AERIAL_STRUCTURE	Los Angeles Metropoliten	\N	7.19999981	272+10\n(L1 263+20)	276+19\n(L1 286+70)
BR-L03	Rosecrans Viaduct	BRIDGES_AND_AERIAL_STRUCTURE	Los Angeles Metropoliten	\N	11.3400002	473+61\n(L1 472+60)\n(L2 469+12)	494+39\n(L2 498+88)
BR-L04	Compton Creek Bridge	BRIDGES_AND_AERIAL_STRUCTURE	Los Angeles Metropoliten	\N	\N	578+15\n(L1 574+20)	579+47\n(L1 584+90)
BR-L05	Dominguez Viaduct	BRIDGES_AND_AERIAL_STRUCTURE	Los Angeles Metropoliten	\N	14.3000002	637+41\n(L1 632+78)\n(L2 634+28)	654+31\n(L1 657+85)\n(L2 659+24)
BR-L06	Del Amo Flyover	BRIDGES_AND_AERIAL_STRUCTURE	Los Angeles Metropoliten	\N	15.3999996	698+55\n(L1 692+60)\n(L2 690+62)	711+67\n(L1 713+75)\n(L2 716+95)
BR-L07	Cota Viaduct	BRIDGES_AND_AERIAL_STRUCTURE	Los Angeles Metropoliten	53 2731	15.8999996	725+94\n(L1 720+00)\n(L2 722+15)	744+87\n(L1 750+30)
BR-L08	Cota Viaduct	BRIDGES_AND_AERIAL_STRUCTURE	Los Angeles Metropoliten	\N	16.5	751+85	760+35
BR-L09	Bixby Creek Culvert	BRIDGES_AND_AERIAL_STRUCTURE	Los Angeles Metropoliten	\N	\N	871+15	871+45
BR-L10	Culvert South of Bixby Creek	BRIDGES_AND_AERIAL_STRUCTURE	Los Angeles Metropoliten	\N	\N	880+75	\N
\.


--
-- Data for Name: structure_and_component; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.structure_and_component (structure_id, component_id, id) FROM stdin;
BR-L01	1	1
BR-L01	2	2
BR-L01	3	3
BR-L01	4	4
BR-L01	5	5
BR-L01	6	6
BR-L01	7	7
BR-L01	8	8
BR-L01	9	9
BR-L01	10	10
BR-L01	11	11
BR-L02L BR-L02R	1	12
BR-L02L BR-L02R	2	13
BR-L02L BR-L02R	3	14
BR-L02L BR-L02R	4	15
BR-L02L BR-L02R	5	16
BR-L02L BR-L02R	6	17
BR-L02L BR-L02R	7	18
BR-L02L BR-L02R	8	19
BR-L02L BR-L02R	9	20
BR-L02L BR-L02R	10	21
BR-L02L BR-L02R	11	22
BR-L03	1	23
BR-L03	2	24
BR-L03	3	25
BR-L03	4	26
BR-L03	5	27
BR-L03	6	28
BR-L03	7	29
BR-L03	8	30
BR-L03	9	31
BR-L03	10	32
BR-L03	11	33
BR-L04	1	34
BR-L04	2	35
BR-L04	3	36
BR-L04	4	37
BR-L04	5	38
BR-L04	6	39
BR-L04	7	40
BR-L04	8	41
BR-L04	9	42
BR-L04	10	43
BR-L04	11	44
BR-L05	1	45
BR-L05	2	46
BR-L05	3	47
BR-L05	4	48
BR-L05	5	49
BR-L05	6	50
BR-L05	7	51
BR-L05	8	52
BR-L05	9	53
BR-L05	10	54
BR-L05	11	55
BR-L06	1	56
BR-L06	2	57
BR-L06	3	58
BR-L06	4	59
BR-L06	5	60
BR-L06	6	61
BR-L06	7	62
BR-L06	8	63
BR-L06	9	64
BR-L06	10	65
BR-L06	11	66
BR-L07	1	67
BR-L07	2	68
BR-L07	3	69
BR-L07	4	70
BR-L07	5	71
BR-L07	6	72
BR-L07	7	73
BR-L07	8	74
BR-L07	9	75
BR-L07	10	76
BR-L07	11	77
BR-L08	1	78
BR-L08	2	79
BR-L08	3	80
BR-L08	4	81
BR-L08	5	82
BR-L08	6	83
BR-L08	7	84
BR-L08	8	85
BR-L08	9	86
BR-L08	10	87
BR-L08	11	88
BR-L09	1	89
BR-L09	2	90
BR-L09	3	91
BR-L09	4	92
BR-L09	5	93
BR-L09	6	94
BR-L09	7	95
BR-L09	8	96
BR-L09	9	97
BR-L09	10	98
BR-L09	11	99
BR-L10	1	100
BR-L10	2	101
BR-L10	3	102
BR-L10	4	103
BR-L10	5	104
BR-L10	6	105
BR-L10	7	106
BR-L10	8	107
BR-L10	9	108
BR-L10	10	109
BR-L10	11	110
\.


--
-- Data for Name: subcomponent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subcomponent (id, name, structural_id) FROM stdin;
1	N/A	1
2	N/A	2
3	Girders (ft.)	3
4	Trusses / Arches (ft.)	3
5	Stringers (ft.)	3
6	Floor Beams (ft.)	3
7	Miscellaneous Superstructure Elements	3
8	N/A	4
9	Abutments (ft.)	5
10	Pier Caps (ft.)	5
11	Columns (Ea.) / Pier Walls (ft.)	5
12	Pile Caps (ft.) / Footings (ft.) / Piles (Ea.)	5
13	Seismic Shells / Slope & Scour Protection (Ea.)	5
14	N/A	6
15	N/A	7
16	N/A	8
17	N/A	9
18	N/A	10
19	N/A	11
\.


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
-- Name: photo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.photo_id_seq', 1, false);


--
-- Name: report_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.report_id_seq', 1, false);


--
-- Name: structural_component_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.structural_component_id_seq', 1, false);


--
-- Name: structure_and_component_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.structure_and_component_id_seq', 110, true);


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
-- Name: structure_and_component structure_and_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.structure_and_component
    ADD CONSTRAINT structure_and_component_pk PRIMARY KEY (id);


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
-- Name: observation_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX observation_id_uindex ON public.observation USING btree (id);


--
-- Name: photo_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX photo_id_uindex ON public.photo USING btree (id);


--
-- Name: structural_component_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX structural_component_id_uindex ON public.structural_component USING btree (id);


--
-- Name: structure_and_component_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX structure_and_component_id_uindex ON public.structure_and_component USING btree (id);


--
-- PostgreSQL database dump complete
--

