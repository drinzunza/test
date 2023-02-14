alter table observations add column if not exists computed_health_index DOUBLE PRECISION DEFAULT 1.0;
alter table observation_structure_subdivision add column if not exists computed_health_index DOUBLE PRECISION DEFAULT 1.0;
alter table structure_subdivision add column if not exists computed_sgr_rating DOUBLE PRECISION DEFAULT 1.0;
