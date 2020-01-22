DROP TABLE observation_names;

CREATE TABLE observation_names (
    id VARCHAR(50) PRIMARY KEY NOT NULL,
    name VARCHAR(255),
    deleted BOOLEAN default false
);

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
 ('13','Broken Component'),
 ('14','Misplaced Component'),
 ('15','Vegetation'),
 ('16','Delamination'),
 ('17','General Damage'),
 ('18','Trip/Slip Hazards'),
 ('19','Other');

UPDATE etags SET change =
(select CONCAT('{"observationNames":["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19"],"defects":[',
(select STRING_AGG(CONCAT('"', id, '"'), ',') from defects), ']}'))
WHERE hash = 'd321c054fe104101613a54f01be1a3b';