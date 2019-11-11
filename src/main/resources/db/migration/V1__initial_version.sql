CREATE OR REPLACE FUNCTION trigger_set_updated_at()
    RETURNS TRIGGER AS
$$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

create table users
(
    id         SERIAL PRIMARY KEY,
    email      VARCHAR(100) UNIQUE      NOT NULL,
    password   VARCHAR(100)             NOT NULL,
    first_name VARCHAR(100)             NOT NULL,
    last_name  VARCHAR(100)             NOT NULL,
    position   VARCHAR(100),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_users_updated_at
    BEFORE UPDATE
    ON users
    FOR EACH ROW
EXECUTE PROCEDURE trigger_set_updated_at();

create table password_reset_attempts
(
    id         SERIAL PRIMARY KEY,
    user_id    INT                      NOT NULL,
    code       INT                      NOT NULL,
    used       BOOLEAN                  NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_password_reset_attempts_updated_at
    BEFORE UPDATE
    ON password_reset_attempts
    FOR EACH ROW
EXECUTE PROCEDURE trigger_set_updated_at();
