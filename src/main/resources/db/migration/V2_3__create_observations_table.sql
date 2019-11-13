create table observations
(
    id                      VARCHAR(50)              NOT NULL,
    uuid                    VARCHAR(50) PRIMARY KEY,
    inspection_id           VARCHAR(50)              NOT NULL,
    structural_component_id VARCHAR(50),
    sub_component_id        VARCHAR(50),
    drawing_number          VARCHAR(50),
    room_number             VARCHAR(50),
    span_number             VARCHAR(50),
    location_description    VARCHAR(100),
    created_by              INT                      NOT NULL,
    updated_by              INT                      NOT NULL,
    created_at              TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at              TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_observations_updated_at
    BEFORE UPDATE
    ON observations
    FOR EACH ROW
EXECUTE PROCEDURE trigger_set_updated_at();
