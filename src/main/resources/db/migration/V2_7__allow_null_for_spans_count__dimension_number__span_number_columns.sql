alter table inspections
    alter column spans_count drop not null;

alter table observations
    alter column dimension_number drop not null;

alter table observation_defects
    alter column span_number drop not null;
