CREATE TABLE project_structures (
	id	SERIAL PRIMARY KEY NOT NULL,
	project_id INT NOT NULL,
	structure_id INT NOT NULL
);

CREATE TABLE projects (
	id	SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(50) NOT NULL,
	company_id INT NOT NULL,
	is_deleted BOOLEAN default false,
	created_by INT NOT NULL,
    updated_by INT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_projects_updated_at
    BEFORE UPDATE
    ON projects
    FOR EACH ROW
EXECUTE PROCEDURE trigger_set_updated_at();

CREATE TABLE roles (
	id	SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(50) NOT NULL
);

CREATE TABLE project_roles (
	id	SERIAL PRIMARY KEY NOT NULL,
	project_id INT NOT NULL,
	user_id INT NOT NULL,
	role_id INT NOT NULL
);

CREATE TABLE inspection_users (
	id	SERIAL PRIMARY KEY NOT NULL,
	inspection_id VARCHAR(50) NOT NULL,
	user_id INT NOT NULL
);

CREATE TABLE company_owners (
	id	SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(255) NOT NULL
);

INSERT INTO roles (name) VALUES ('Admin'),('Project Manager'),('Inspector'),('Guest');

ALTER TABLE observation_defects ADD COLUMN clock_position INT;
ALTER TABLE observation_defects ADD COLUMN repair_date TIMESTAMP WITH TIME ZONE;
ALTER TABLE observation_defects ADD COLUMN repair_method VARCHAR(255);

ALTER TABLE inspections ADD COLUMN project_id INT;
ALTER TABLE users ADD COLUMN admin BOOLEAN default false;

ALTER TABLE structures ADD COLUMN company_owner_id INT;
INSERT INTO company_owners (name) VALUES ('Los Angeles Metropoliten');
UPDATE structures SET company_owner_id = 1 WHERE company_owner_id IS NULL;
