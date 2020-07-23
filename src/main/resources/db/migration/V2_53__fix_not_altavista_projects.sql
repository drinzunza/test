update projects set company_id = (select id from companies where name = 'Demo Company')
where created_by in (select id from users where company_id = (select id from companies where name = 'Demo Company'));

