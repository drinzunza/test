alter table companies alter column logo type text;
ALTER TABLE companies ADD COLUMN is_deleted BOOLEAN default false;
ALTER TABLE companies ADD COLUMN created_by INT NOT NULL default 0;
ALTER TABLE companies ADD COLUMN updated_by INT NOT NULL default 0;
ALTER TABLE companies ADD COLUMN created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW();
ALTER TABLE companies ADD COLUMN updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW();

CREATE TRIGGER set_companies_updated_at
    BEFORE UPDATE
    ON companies
    FOR EACH ROW
EXECUTE PROCEDURE trigger_set_updated_at();

ALTER TABLE company_owners ADD COLUMN company_id INT;
ALTER TABLE company_owners ADD COLUMN is_deleted BOOLEAN default false;
ALTER TABLE company_owners ADD COLUMN created_by INT NOT NULL default 0;
ALTER TABLE company_owners ADD COLUMN updated_by INT NOT NULL default 0;
ALTER TABLE company_owners ADD COLUMN created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW();
ALTER TABLE company_owners ADD COLUMN updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW();

CREATE TRIGGER set_company_owners_updated_at
    BEFORE UPDATE
    ON company_owners
    FOR EACH ROW
EXECUTE PROCEDURE trigger_set_updated_at();



