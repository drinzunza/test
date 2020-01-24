CREATE TABLE observation_names (
    id VARCHAR(50) PRIMARY KEY NOT NULL,
    name VARCHAR(255),
    deleted BOOLEAN default false
);

alter table observation_defects add column observationNameId VARCHAR(50);

INSERT INTO "observation_names" ("id","name") VALUES ('1','Graffiti'),
 ('2','Missing Gratings'),
 ('3','Protruding Component'),
 ('4','Missing Bolts or Anchors'),
 ('5','Misalignment'),
 ('6','Trash or Deleterious'),
 ('7','Material'),
 ('8','Debris'),
 ('9','Standing Water'),
 ('10','Water Leakage'),
 ('11','Missing Components'),
 ('12','Broken Cover'),
 ('13','Broken Cover'),
 ('14','Broken Component'),
 ('15','Misplaced Component'),
 ('16','Vegetation'),
 ('17','Delamination'),
 ('18','General Damage'),
 ('19','Trip/Slip Hazards'),
 ('20','Other');

INSERT INTO "etags" ("hash","change") VALUES ('d321c054fe104101613a54f01be1a3b',
'{"observationNames":["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"]}');
