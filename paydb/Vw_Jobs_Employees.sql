select 
snsdb_new.jobs.employer_id as employer_id,
count(distinct snsdb_new.jobs.profile_id) as employees_count
from
snsdb_new.jobs 
GROUP BY snsdb_new.jobs.employer_id
;
select 
snsdb_new.jobs.position_id as position_id,
count(distinct snsdb_new.jobs.profile_id) as position_employees_count
from
snsdb_new.jobs 
GROUP BY snsdb_new.jobs.position_id
;
select 
Vw_Jobs

