alter table photos
    add column created_at_client TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW();

UPDATE photos SET created_at_client = created_at;