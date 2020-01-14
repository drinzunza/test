create type condition_type as enum (
    'GOOD', 'FAIR', 'POOR', 'SEVERE'
    );

alter table conditions alter column type type condition_type using type::condition_type;
