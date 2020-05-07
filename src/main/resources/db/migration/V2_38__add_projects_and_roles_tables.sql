CREATE TABLE projects (
	id	SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(50) NOT NULL,
	company_id INT NOT NULL
);

CREATE TABLE project_structures (
	id	SERIAL PRIMARY KEY NOT NULL,
	project_id INT NOT NULL,
	structure_id INT NOT NULL
);

CREATE TABLE roles (
	id	SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(50) NOT NULL
);

CREATE TABLE project_roles (
	id	SERIAL PRIMARY KEY NOT NULL,
	user_id INT NOT NULL,
	role_id INT NOT NULL
);

CREATE TABLE inspection_users (
	id	SERIAL PRIMARY KEY NOT NULL,
	inspection_id VARCHAR(50) NOT NULL,
	user_id INT NOT NULL
);

INSERT INTO roles (name) VALUES ('Admin'),('Project Manager'),('Client');

ALTER TABLE observation_defects ADD COLUMN clock_position INT;
ALTER TABLE observation_defects ADD COLUMN repair_date TIMESTAMP WITH TIME ZONE;
ALTER TABLE observation_defects ADD COLUMN repair_method VARCHAR(255);