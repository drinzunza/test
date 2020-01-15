CREATE TABLE "reports" (
    "id"	VARCHAR(50) NOT NULL,
	"uuid"	VARCHAR(50) PRIMARY KEY NOT NULL,
	"link"	VARCHAR(255) NOT NULL,
	"inspection_id"	VARCHAR(50) NOT NULL,
	"created_by" INT NOT NULL,
    "updated_by" INT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

create unique index reports_id_uindex
	on reports (id);