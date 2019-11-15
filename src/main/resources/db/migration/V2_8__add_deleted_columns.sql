alter table inspections
    add column is_deleted boolean default false;

alter table observations
    add column is_deleted boolean default false;

alter table observation_defects
    add column is_deleted boolean default false;

alter table photos
    add column is_deleted boolean default false;
