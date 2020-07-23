insert into project_structures (project_id, structure_id)
    select project_id, structure_id from inspections
where project_id is not null and structure_id is not null;

DELETE FROM project_structures WHERE id NOT IN
  (SELECT MIN(id) as id FROM project_structures as t GROUP BY t.project_id, t.structure_id);

insert into project_roles (project_id, user_id, roles)
    select project_id, created_by, '{PM}' from inspections
where project_id is not null and created_by is not null;

DELETE FROM project_roles WHERE id NOT IN
  (SELECT MIN(id) as id FROM project_roles as t GROUP BY t.project_id, t.user_id);

update users set
                 company_id = (select id from companies where name = 'Demo Company')
where email not in
      ('dusty@uav-recon.com','sales@voltinspections.com','mark@vonleffern.com','cburgan@altavistasolutions.com','eleach@altavistasolutions.com',
      'mabdelbarr@altavistasolutions.com','jalvary@morgnerco.com','rdoumani@altavistasolutions.com','jolarte@altavistasolutions.com','mike@voltinspections.com',
      'walexander@tmisolutionsllc.com','bdagher@altavistasolutions.com','vleanos@tmisolutions.com','iharris@altavistasolutions.com','mike@mythril.tech',
      'nzaatar@datarecon.com','charlie@nar.ai','agregory@workworks.com','datarecon19@gmail.com');