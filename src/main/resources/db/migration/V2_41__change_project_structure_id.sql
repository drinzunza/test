ALTER TABLE project_structures DROP COLUMN structure_id;
ALTER TABLE project_structures ADD COLUMN structure_id VARCHAR(50) NOT NULL;