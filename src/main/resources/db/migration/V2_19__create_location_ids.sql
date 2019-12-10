CREATE TABLE "location_ids" (
	"id"	VARCHAR(50) PRIMARY KEY NOT NULL,
	"structure_type"	VARCHAR(50) NOT NULL,
	"major_ids"	TEXT,
	"sub_component_ids"	TEXT,
	"always_shown_spans"	TEXT,
	"iterated_span_patterns"	TEXT,
	"is_deleted" BOOLEAN default false
);
INSERT INTO "location_ids" ("id","structure_type","major_ids","sub_component_ids","always_shown_spans","iterated_span_patterns") VALUES
('location_id_bridges_1','BRIDGES_AND_AERIAL_STRUCTURE','BridgeMajor_1,BridgeMajor_2,BridgeMajor_3,BridgeMajor_9',NULL,NULL,'Span %d,Span %d A,Span %d B,Span %d C,Span %d D,Span %d E'),
 ('location_id_bridges_2','BRIDGES_AND_AERIAL_STRUCTURE','BridgeMajor_4,BridgeMajor_5,BridgeMajor_7',NULL,'Abutment 1,Abutment 1 - A,Abutment 1 - B,Abutment 2,Abutment 2 - A,Abutment 2 - B,Abutment 1 - Bearing A,Abutment 1 - Bearing B,Abutment 1 - Bearing C,Abutment 1 - Bearing D,Abutment 1 - Bearing E,Abutment 1 - Bearing F,Abutment 1 - Bearing G,Abutment 1 - Bearing H,Abutment 2 - Bearing A,Abutment 2 - Bearing B,Abutment 2 - Bearing C,Abutment 2 - Bearing D,Abutment 2 - Bearing E,Abutment 2 - Bearing F,Abutment 2 - Bearing G,Abutment 2 - Bearing H,Hinge A,Hinge B,Hinge C,Hinge D,Hinge E,Hinge F,Hinge G,Hinge H,Hinge I,Hinge J,Hinge K,Hinge L,Hinge M,Hinge N,Hinge O,Hinge P,Hinge Q,Hinge R,Hinge S,Hinge T,Hinge U,Hinge V,Hinge X,Hinge Y,Hinge Z','Bent %d,Bent %d A,Bent %d B,Bent %d C,Bent %d D,Bent %d E'),
 ('location_id_tunnels_1','SUBWAY_TUNNELS_USECTION',NULL,'TunnelSubComponent_1,TunnelSubComponent_2,TunnelSubComponent_3,TunnelSubComponent_4,TunnelSubComponent_5,TunnelSubComponent_6,TunnelSubComponent_7,TunnelSubComponent_8,TunnelSubComponent_9,TunnelSubComponent_10,TunnelSubComponent_11,TunnelSubComponent_12,TunnelSubComponent_13,TunnelSubComponent_24,TunnelSubComponent_25,TunnelSubComponent_26,TunnelSubComponent_27,TunnelSubComponent_28,TunnelSubComponent_29,TunnelSubComponent_30,TunnelSubComponent_31,TunnelSubComponent_32,TunnelSubComponent_33,TunnelSubComponent_34,TunnelSubComponent_35,TunnelSubComponent_36,TunnelSubComponent_37,TunnelSubComponent_38,TunnelSubComponent_39,TunnelSubComponent_40,TunnelSubComponent_41,TunnelSubComponent_42,TunnelSubComponent_43,TunnelSubComponent_44,TunnelSubComponent_45,TunnelSubComponent_46,TunnelSubComponent_47,TunnelSubComponent_55',NULL,NULL),
 ('location_id_tunnels_2','SUBWAY_TUNNELS_USECTION',NULL,'TunnelSubComponent_48,TunnelSubComponent_49,TunnelSubComponent_50,TunnelSubComponent_51,TunnelSubComponent_52,TunnelSubComponent_53,TunnelSubComponent_54','Hinge A,Hinge B,Hinge C,Hinge D,Hinge E,Hinge F,Hinge G,Hinge H,Hinge I,Hinge J,Hinge K,Hinge L,Hinge M,Hinge N,Hinge O,Hinge P,Hinge Q,Hinge R,Hinge S,Hinge T,Hinge U,Hinge V,Hinge X,Hinge Y,Hinge Z',NULL),
 ('location_id_tunnels_3','SUBWAY_TUNNELS_USECTION',NULL,'TunnelSubComponent_17,TunnelSubComponent_18,TunnelSubComponent_19,TunnelSubComponent_20,TunnelSubComponent_21,TunnelSubComponent_22,TunnelSubComponent_23','CP-1,CP-2,CP-3,CP-4,CP-5,CP-6,CP-7,CP-8,CP-9,CP-10,CP-11,CP-12,CP-13,CP-14,CP-15,CP-16,CP-17,CP-18,CP-19,CP-20,CP-21,CP-22,CP-23,CP-24,CP-25,CP-26,CP-27,CP-28,CP-29,CP-30,CP-31,CP-32,CP-33,CP-34,CP-35,CP-36,CP-37,CP-38,CP-39,CP-40,CP-41,CP-42,CP-43,CP-44,CP-45,CP-46,CP-47,CP-48,CP-49,CP-50',NULL),
 ('location_id_tunnels_4','SUBWAY_TUNNELS_USECTION',NULL,'TunnelSubComponent_14,TunnelSubComponent_15,TunnelSubComponent_16','Column 1,Column 2,Column 3,Column 4,Column 5,Column 6,Column 7,Column 8,Column 9,Column 10,Column 11,Column 12,Column 13,Column 14,Column 15,Column 16,Column 17,Column 18,Column 19,Column 20,Column 21,Column 22,Column 23,Column 24,Column 25,Column 26,Column 27,Column 28,Column 29,Column 30,Column 31,Column 32,Column 33,Column 34,Column 35,Column 36,Column 37,Column 38,Column 39,Column 40,Column 41,Column 42,Column 43,Column 44,Column 45,Column 46,Column 47,Column 48,Column 49,Column 50',NULL);

