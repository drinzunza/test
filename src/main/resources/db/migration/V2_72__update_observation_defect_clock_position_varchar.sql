ALTER TABLE observation_defects ALTER COLUMN clock_position TYPE varchar(100) USING clock_position::varchar;
