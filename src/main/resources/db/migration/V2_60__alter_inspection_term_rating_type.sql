ALTER TABLE inspections ADD COLUMN term_rating_code DOUBLE PRECISION;

UPDATE inspections SET term_rating_code = 5.0 WHERE term_rating = 'EXCELLENT';
UPDATE inspections SET term_rating_code = 4.0 WHERE term_rating = 'GOOD';
UPDATE inspections SET term_rating_code = 3.0 WHERE term_rating = 'ADEQUATE';
UPDATE inspections SET term_rating_code = 2.0 WHERE term_rating = 'MARGINAL';
UPDATE inspections SET term_rating_code = 1.0 WHERE term_rating = 'POOR';

ALTER TABLE inspections DROP COLUMN term_rating;
ALTER TABLE inspections RENAME COLUMN term_rating_code to term_rating;
