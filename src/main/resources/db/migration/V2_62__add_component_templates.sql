CREATE TABLE sub_component_and_structures (
    id SERIAL PRIMARY KEY,
    sub_component_id VARCHAR(50) NOT NULL,
    structure_id VARCHAR(50) NOT NULL,
    size INT
);

CREATE TABLE sub_component_inspections (
    id SERIAL PRIMARY KEY,
    sub_component_and_structure_id INT NOT NULL,
    inspection_id VARCHAR(50) NOT NULL,
    is_checked BOOLEAN default true
);
