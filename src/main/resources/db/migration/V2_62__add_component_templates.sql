ALTER TABLE inspections ADD COLUMN template_id INT;

CREATE TABLE templates (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    structure_type_id INT NOT NULL,
    company_id INT NOT NULL,
    is_deleted BOOLEAN default false
);

CREATE TABLE template_components (
    id SERIAL PRIMARY KEY,
    template_id INT NOT NULL,
    component_id VARCHAR(50) NOT NULL,
    is_active BOOLEAN default true
);

CREATE TABLE template_sub_components (
    id SERIAL PRIMARY KEY,
    template_component_id INT NOT NULL,
    sub_component_id VARCHAR(50) NOT NULL,
    is_active BOOLEAN default true
);

CREATE TABLE template_defects (
    id SERIAL PRIMARY KEY,
    template_sub_component_id INT NOT NULL,
    defect_id VARCHAR(50) NOT NULL,
    is_active BOOLEAN default true
);
