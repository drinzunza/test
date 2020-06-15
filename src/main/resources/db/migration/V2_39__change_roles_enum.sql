DROP TABLE roles;

ALTER TABLE project_roles DROP COLUMN role_id;

create type user_role as enum (
    'ADMIN', 'PM', 'INSPECTOR', 'GUEST'
);

alter table project_roles add column roles user_role[];
