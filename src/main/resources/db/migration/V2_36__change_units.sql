update sub_components set measure_unit = 'SF' where measure_unit = 'SFT';
update sub_components set measure_unit = 'LF' where measure_unit = 'LFT';

INSERT INTO "etags" ("hash","change") VALUES ('d522c01afa104801415a34f51ce1816',
    (select CONCAT('{"subcomponents":[', (select STRING_AGG(CONCAT('"', id, '"'), ',') from sub_components where measure_unit in
    ('SF', 'LF')), ']}')));