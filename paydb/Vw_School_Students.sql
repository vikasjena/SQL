select 
snsdb_new.education.school_id as school_id,
count(distinct snsdb_new.education.profile_id) as students_count
from
snsdb_new.education 
GROUP BY snsdb_new.education.school_id