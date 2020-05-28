create type structure_component_type as enum (
    'BRIDGES_AND_AERIAL_STRUCTURE',
    'RETAINING_WALLS_AND_CONCENTRATE_TRACKS',
    'SUBWAY_STATIONS_AND_AERIAL_STATIONS',
    'SUBWAY_TUNNELS_USECTION'
);

ALTER TABLE structures ALTER COLUMN type type structure_component_type USING (type::structure_component_type);;

ALTER TABLE components ADD COLUMN company_id INT;
ALTER TABLE components ADD COLUMN type structure_component_type;
update components set company_id = (select id from companies where name = 'Alta Vista');
update components set type = (select min(type) from structures as s, structure_and_components as sc where s.id = sc.structure_id and sc.component_id = components.id);