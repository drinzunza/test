create table inspections
(
    id              VARCHAR(50)              NOT NULL,
    uuid            VARCHAR(50) PRIMARY KEY,
    is_editable     BOOLEAN                           default true,
    start_date      TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    end_date        TIMESTAMP WITH TIME ZONE,
    structure_id    VARCHAR(50),
    temperature     DOUBLE PRECISION,
    humidity        DOUBLE PRECISION,
    wind            DOUBLE PRECISION,
    latitude        DOUBLE PRECISION,
    longitude       DOUBLE PRECISION,
    altitude        DOUBLE PRECISION,
    status          inspection_status                 DEFAULT 'IN_PROGRESS',
    report_id       VARCHAR(50),
    report_date     TIMESTAMP WITH TIME ZONE,
    report_link     TEXT,
    general_summary TEXT,
    sgr_rating      TEXT,
    term_rating     inspection_term_rating,
    created_by      INT                      NOT NULL,
    updated_by      INT                      NOT NULL,
    created_at      TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_inspections_updated_at
    BEFORE UPDATE
    ON inspections
    FOR EACH ROW
EXECUTE PROCEDURE trigger_set_updated_at();
