create type structural_type as enum (
    'STRUCTURAL', 'MAINTENANCE'
    );


alter table observation_defects
    add column type structural_type;
