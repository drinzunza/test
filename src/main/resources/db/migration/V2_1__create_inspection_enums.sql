create type inspection_term_rating as enum (
    'EXCELLENT', 'GOOD', 'ADEQUATE', 'MARGINAL', 'POOR'
    );

create type inspection_status as enum (
    'IN_PROGRESS', 'COMPLETED'
    );

create type critical_finding as enum (
    'STRUCTURAL', 'SAFETY', 'OTHER'
    );
