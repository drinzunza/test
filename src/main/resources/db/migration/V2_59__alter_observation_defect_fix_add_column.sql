ALTER TABLE companies DROP COLUMN previous_defect_number;
ALTER TABLE observation_defects ADD COLUMN previous_defect_number VARCHAR(50);