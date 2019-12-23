INSERT INTO "defects" ("id","name","number") VALUES ('Defect_NA_BridgeSubComponent_124(Bridges)','N/A',NULL),
('Defect_NA_BridgeSubComponent_125(Bridges)','N/A',NULL),
('Defect_NA_TunnelSubComponent_56(Tunnels)','N/A',NULL),
('Defect_NA_TunnelSubComponent_57(Tunnels)','N/A',NULL);

INSERT INTO "conditions" ("id","description","type","defect_id") VALUES ('Defect_NA_SubComponent_124(Bridges)_Condition_1','None','GOOD','Defect_NA_BridgeSubComponent_124(Bridges)'),
('Defect_NA_SubComponent_124(Bridges)_Condition_2','None','FAIR','Defect_NA_BridgeSubComponent_124(Bridges)'),
('Defect_NA_SubComponent_124(Bridges)_Condition_3','None','POOR','Defect_NA_BridgeSubComponent_124(Bridges)'),
('Defect_NA_SubComponent_124(Bridges)_Condition_4','None','SEVERE','Defect_NA_BridgeSubComponent_124(Bridges)');

INSERT INTO "conditions" ("id","description","type","defect_id") VALUES ('Defect_NA_SubComponent_125(Bridges)_Condition_1','None','GOOD','Defect_NA_BridgeSubComponent_125(Bridges)'),
('Defect_NA_SubComponent_125(Bridges)_Condition_2','None','FAIR','Defect_NA_BridgeSubComponent_125(Bridges)'),
('Defect_NA_SubComponent_125(Bridges)_Condition_3','None','POOR','Defect_NA_BridgeSubComponent_125(Bridges)'),
('Defect_NA_SubComponent_125(Bridges)_Condition_4','None','SEVERE','Defect_NA_BridgeSubComponent_125(Bridges)');

INSERT INTO "conditions" ("id","description","type","defect_id") VALUES ('Defect_NA_SubComponent_56(Tunnels)_Condition_1','None','GOOD','Defect_NA_TunnelSubComponent_56(Tunnels)'),
('Defect_NA_SubComponent_56(Tunnels)_Condition_2','None','FAIR','Defect_NA_TunnelSubComponent_56(Tunnels)'),
('Defect_NA_SubComponent_56(Tunnels)_Condition_3','None','POOR','Defect_NA_TunnelSubComponent_56(Tunnels)'),
('Defect_NA_SubComponent_56(Tunnels)_Condition_4','None','SEVERE','Defect_NA_TunnelSubComponent_56(Tunnels)');

INSERT INTO "conditions" ("id","description","type","defect_id") VALUES ('Defect_NA_SubComponent_57(Tunnels)_Condition_1','None','GOOD','Defect_NA_TunnelSubComponent_57(Tunnels)'),
('Defect_NA_SubComponent_57(Tunnels)_Condition_2','None','FAIR','Defect_NA_TunnelSubComponent_57(Tunnels)'),
('Defect_NA_SubComponent_57(Tunnels)_Condition_3','None','POOR','Defect_NA_TunnelSubComponent_57(Tunnels)'),
('Defect_NA_SubComponent_57(Tunnels)_Condition_4','None','SEVERE','Defect_NA_TunnelSubComponent_57(Tunnels)');

INSERT INTO "sub_component_and_defects" ("sub_component_id","defect_id") VALUES ('BridgeSubComponent_124','Defect_NA_BridgeSubComponent_124(Bridges)'),
 ('BridgeSubComponent_125','Defect_NA_BridgeSubComponent_125(Bridges)'),
 ('TunnelSubComponent_56','Defect_NA_TunnelSubComponent_56(Tunnels)'),
 ('TunnelSubComponent_57','Defect_NA_TunnelSubComponent_57(Tunnels)');

INSERT INTO "etags" ("hash","change") VALUES ('b11dc058fe004909615a64f01be9654', '{"defects":["Defect_NA_BridgeSubComponent_124(Bridges)","Defect_NA_BridgeSubComponent_125(Bridges)","Defect_NA_TunnelSubComponent_56(Tunnels)","Defect_NA_TunnelSubComponent_57(Tunnels)"],"conditions":["Defect_NA_SubComponent_124(Bridges)_Condition_1","Defect_NA_SubComponent_124(Bridges)_Condition_2","Defect_NA_SubComponent_124(Bridges)_Condition_3","Defect_NA_SubComponent_124(Bridges)_Condition_4","Defect_NA_SubComponent_125(Bridges)_Condition_1","Defect_NA_SubComponent_125(Bridges)_Condition_2","Defect_NA_SubComponent_125(Bridges)_Condition_3","Defect_NA_SubComponent_125(Bridges)_Condition_4","Defect_NA_SubComponent_56(Tunnels)_Condition_1","Defect_NA_SubComponent_56(Tunnels)_Condition_2","Defect_NA_SubComponent_56(Tunnels)_Condition_3","Defect_NA_SubComponent_56(Tunnels)_Condition_4","Defect_NA_SubComponent_57(Tunnels)_Condition_1","Defect_NA_SubComponent_57(Tunnels)_Condition_2","Defect_NA_SubComponent_57(Tunnels)_Condition_3","Defect_NA_SubComponent_57(Tunnels)_Condition_4"],"subcomponents":["Defect_NA_BridgeSubComponent_124(Bridges)","Defect_NA_BridgeSubComponent_125(Bridges)","Defect_NA_TunnelSubComponent_56(Tunnels)","Defect_NA_TunnelSubComponent_57(Tunnels)"]}');