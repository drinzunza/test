update users set company_id = (select id from companies where name = 'Demo Company')
where email not in (
'cburgan@altavistasolutions.com', 'eleach@altavistasolutions.com',
'mabdelbarr@altavistasolutions.com', 'rdoumani@altavistasolutions.com', 'jolarte@altavistasolutions.com',
'bdagher@altavistasolutions.com', 'iharris@altavistasolutions.com');