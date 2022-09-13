create type clone_status as enum (
    'UNCHANGED', 'CHANGED'
    );

ALTER TABLE observation_defects ADD COLUMN clone_status clone_status;