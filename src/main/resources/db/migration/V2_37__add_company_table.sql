CREATE TABLE companies (
	id	SERIAL PRIMARY KEY NOT NULL,
	name	VARCHAR(50) NOT NULL,
	logo	VARCHAR(255)
);

ALTER TABLE users ADD COLUMN company_id INT NULL;


/* Add AltaVista's company id for all existing users & structures as all current user are under AltaVista prior to 
this migration */

DO $$ 
DECLARE alta_vista_id INT;

BEGIN 
INSERT INTO companies (name, logo) VALUES ('Alta Vista', 'logo_altavista.png') RETURNING id INTO alta_vista_id;
UPDATE users SET company_id = alta_vista_id WHERE company_id IS NULL;
END $$;

INSERT INTO companies (name, logo) VALUES ('Demo Company', 'logo_datarecon.png');