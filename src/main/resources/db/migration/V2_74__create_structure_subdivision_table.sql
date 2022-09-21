create table if not exists structure_subdivision
(
    uuid              VARCHAR(50)               PRIMARY KEY,
    inspection_id     VARCHAR(50)               NOT NULL,
    name              VARCHAR(50),
    number            INT,
    sgr_rating        TEXT
);

create table if not exists observation_structure_subdivision
(
    uuid                            VARCHAR(50)     PRIMARY KEY,
    structure_subdivision_id        VARCHAR(50)     NOT NULL,
    observation_id                  VARCHAR(50)     NOT NULL,
    dimension_number                INT             NOT NULL DEFAULT 0
);

alter table observation_defects add column if not exists structure_subdivision_id VARCHAR(50);