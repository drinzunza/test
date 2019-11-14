alter table inspections
    add column spans_count int not null default 0;

alter table observations
    add column dimension_number int not null default 0;

alter table observations
    drop column span_number;

alter table observation_defects
    add column span_number int not null default 0;
