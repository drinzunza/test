ALTER TABLE structures ADD COLUMN code VARCHAR(50) NOT NULL DEFAULT '';
UPDATE structures SET code = id;