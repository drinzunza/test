create unique index etags_hash_uindex
	on etags (hash);

INSERT INTO "etags" ("hash","change") VALUES ('c12dc05afe104901615a64f01be1635',
    (select CONCAT('{"subcomponents":[', (select STRING_AGG(CONCAT('"', id, '"'), ',') from sub_components where measure_unit in
    ('Each', 'Each Unit', 'each', 'ft.', 'length, ft', 'sq.ft.', 'sq. ft.', 'sq. ft. (surface)', 'sq.ft. (surface)', 'sq ft. (surface)', 'area, ft2')), ']}')));

update sub_components set measure_unit = 'EA' where measure_unit = 'Each';
update sub_components set measure_unit = 'EA' where measure_unit = 'Each Unit';
update sub_components set measure_unit = 'EA' where measure_unit = 'each';
update sub_components set measure_unit = 'LFT' where measure_unit = 'ft.';
update sub_components set measure_unit = 'LFT' where measure_unit = 'length, ft';
update sub_components set measure_unit = 'SFT' where measure_unit = 'sq.ft.';
update sub_components set measure_unit = 'SFT' where measure_unit = 'sq. ft.';
update sub_components set measure_unit = 'SFT' where measure_unit = 'sq. ft. (surface)';
update sub_components set measure_unit = 'SFT' where measure_unit = 'sq.ft. (surface)';
update sub_components set measure_unit = 'SFT' where measure_unit = 'sq ft. (surface)';
update sub_components set measure_unit = 'SFT' where measure_unit = 'area, ft2';