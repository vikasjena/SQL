DROP TABLE IF EXISTS paydb.ch_schools;
CREATE TABLE IF NOT EXISTS paydb.ch_schools
SELECT 
schools.id,
schools.sns_id,
schools.sns_item_id,
schools.location_id,
schools.`name`,
schools.type,
COUNT(DISTINCT snsdb_new.education.profile_id) as student_cnt
FROM
snsdb_new.schools LEFT JOIN snsdb_new.education on snsdb_new.education.school_id = snsdb_new.schools.id
GROUP BY
snsdb_new.schools.id
ORDER BY student_cnt DESC
;