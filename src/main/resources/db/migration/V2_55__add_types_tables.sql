CREATE TABLE structure_types (
	id SERIAL PRIMARY KEY NOT NULL,
	code VARCHAR(255) NOT NULL,
	name VARCHAR(255) NOT NULL
);

CREATE TABLE company_structure_types (
	id	SERIAL PRIMARY KEY NOT NULL,
	company_id INT NOT NULL,
	structure_type_id INT NOT NULL
);

INSERT INTO structure_types (id, code, name) VALUES (1, 'BRIDGES_AND_AERIAL_STRUCTURE', 'Bridges');
INSERT INTO structure_types (id, code, name) VALUES (2, 'SUBWAY_TUNNELS_USECTION', 'Tunnels');

ALTER TABLE structures ADD COLUMN structure_type_id INT;
ALTER TABLE components ADD COLUMN structure_type_id INT;
UPDATE structures SET structure_type_id = 1 WHERE type = 'BRIDGES_AND_AERIAL_STRUCTURE';
UPDATE components SET structure_type_id = 2 WHERE type = 'SUBWAY_TUNNELS_USECTION';
ALTER TABLE structures DROP COLUMN type;
ALTER TABLE components DROP COLUMN type;
DROP TYPE structure_component_type;

INSERT INTO company_structure_types (company_id, structure_type_id) VALUES (1, 1), (1, 2), (2, 1), (2, 2);
