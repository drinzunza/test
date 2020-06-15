DROP TABLE inspection_users;
CREATE TABLE inspection_roles (
	id SERIAL PRIMARY KEY NOT NULL,
	inspection_id VARCHAR(50) NOT NULL,
	user_id INT NOT NULL,
	roles user_role[]
);

