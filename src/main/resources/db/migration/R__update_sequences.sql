BEGIN;
LOCK TABLE users IN EXCLUSIVE MODE;
SELECT setval('users_id_seq', COALESCE((SELECT MAX(id) + 1 FROM users), 1), false);
COMMIT;

BEGIN;
LOCK TABLE password_reset_attempts IN EXCLUSIVE MODE;
SELECT setval('password_reset_attempts_id_seq', COALESCE((SELECT MAX(id) + 1 FROM password_reset_attempts), 1), false);
COMMIT;
