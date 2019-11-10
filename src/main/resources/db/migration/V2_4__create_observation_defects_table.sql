create table observation_defects
(
    id                VARCHAR(50)              NOT NULL,
    uuid              VARCHAR(50) PRIMARY KEY,
    observation_id    VARCHAR(50)              NOT NULL,
    defect_id         VARCHAR(50),
    condition_id      VARCHAR(50),
    description       TEXT,
    material_id       VARCHAR(50),
    critical_findings critical_finding[],
    created_by        INT                      NOT NULL,
    updated_by        INT                      NOT NULL,
    created_at        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_observation_defects_updated_at
    BEFORE UPDATE
    ON observation_defects
    FOR EACH ROW
EXECUTE PROCEDURE trigger_set_updated_at();
