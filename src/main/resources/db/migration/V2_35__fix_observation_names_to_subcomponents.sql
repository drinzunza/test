alter table observation_defects add column observation_name_id VARCHAR(50);
alter table sub_components drop column observation_name_id;