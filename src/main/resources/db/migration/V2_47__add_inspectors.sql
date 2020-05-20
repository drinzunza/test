insert into inspection_roles (inspection_id, user_id, roles)
select uuid, created_by, '{INSPECTOR}' from inspections;

truncate table projects;

update users set company_id = 1 where company_id is null;

insert into projects (name, company_id, is_deleted, created_by, updated_by)
select concat('Project of ', first_name, ' ', last_name), company_id, false, id, id from users;

update inspections set project_id = (select id from projects where projects.created_by = inspections.created_by);