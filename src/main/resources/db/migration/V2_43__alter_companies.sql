DROP TABLE company_owners;
alter table structures rename column company_owner_id to company_id;

create type company_type as enum ('INSPECTION', 'OWNER');

alter table companies add type company_type default 'INSPECTION' not null;

DO $$
DECLARE lam_id INT;
BEGIN
INSERT INTO companies (name, type) VALUES ('Los Angeles Metropoliten', 'OWNER') RETURNING id INTO lam_id;
UPDATE structures SET company_id = lam_id WHERE company_id = 1;
END $$;