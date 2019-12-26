UPDATE observation_defects SET id = CONCAT(floor(random() * 1000 + 1)::int, id) WHERE id IN
  (SELECT id FROM observation_defects GROUP BY id HAVING COUNT(*) > 1);
  
UPDATE observation_defects SET id = CONCAT(floor(random() * 1000 + 1)::int, id) WHERE id IN
  (SELECT id FROM observation_defects GROUP BY id HAVING COUNT(*) > 1);

UPDATE observation_defects SET id = CONCAT(floor(random() * 1000 + 1)::int, id) WHERE id IN
  (SELECT id FROM observation_defects GROUP BY id HAVING COUNT(*) > 1);

create unique index observation_defects_id_uindex
	on observation_defects (id);