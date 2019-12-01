create type observation_type as enum (
    'CRITICAL', 'PRIORITY', 'ROUTINE', 'MONITOR'
    );


alter table observation_defects
    add column observation_type observation_type;
alter table observation_defects
    add column size VARCHAR(50);
