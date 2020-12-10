ALTER TABLE inspections ADD COLUMN is_archived BOOLEAN default false;
ALTER TABLE observations ADD COLUMN is_inspected BOOLEAN default false;