ALTER TABLE observation_defects ADD COLUMN created_at_client TIMESTAMP WITH TIME ZONE;
UPDATE observation_defects as od SET created_at_client =
    (SELECT CONCAT(
        SUBSTRING(id, LENGTH(id) - 3, 4), '-',
        SUBSTRING(id, LENGTH(id) - 7, 2), '-',
        SUBSTRING(id, LENGTH(id) - 5, 2))
        FROM observation_defects WHERE uuid = od.uuid)::timestamp
WHERE
    SUBSTRING(id, LENGTH(id) - 8, 1) = '-' AND
    SUBSTRING(id, LENGTH(id) - 3, 4) > '2015' AND
    SUBSTRING(id, LENGTH(id) - 3, 4) < '2022' AND
    SUBSTRING(id, LENGTH(id) - 7, 2) > '00' AND
    SUBSTRING(id, LENGTH(id) - 7, 2) < '13' AND
    SUBSTRING(id, LENGTH(id) - 5, 2) > '00' AND
    SUBSTRING(id, LENGTH(id) - 5, 2) < '31';