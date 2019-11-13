create table photos
(
    id                    VARCHAR(50)              NOT NULL,
    uuid                  VARCHAR(50) PRIMARY KEY,
    observation_defect_id VARCHAR(50)              NOT NULL,
    link                  VARCHAR(100)             NOT NULL,
    latitude              DOUBLE PRECISION,
    longitude             DOUBLE PRECISION,
    altitude              DOUBLE PRECISION,
    drawables             TEXT,
    created_by            INT                      NOT NULL,
    updated_by            INT                      NOT NULL,
    created_at            TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at            TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_photos_updated_at
    BEFORE UPDATE
    ON photos
    FOR EACH ROW
EXECUTE PROCEDURE trigger_set_updated_at();
