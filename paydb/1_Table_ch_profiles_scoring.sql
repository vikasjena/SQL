drop table if exists paydb.ch_profiles_scoring;
CREATE TABLE paydb.ch_profiles_scoring
SELECT
snsdb_new.`profiles`.id,
snsdb_new.`profiles`.sns_id,
snsdb_new.`profiles`.sns_item_id,


-- ***************************************** PROFILE DATA ***********************************************************
CASE WHEN snsdb_new.`profiles`.gender = 'M' THEN 1 ELSE 0 END AS male,
CASE WHEN snsdb_new.`profiles`.gender = 'F' THEN 1 ELSE 0 END AS female,

CASE 
WHEN DATEDIFF(snsdb_new.`profiles`.created, snsdb_new.`profiles`.birth_date) is NULL THEN 0
ELSE DATEDIFF(snsdb_new.`profiles`.created, snsdb_new.`profiles`.birth_date) END AS age,

-- *******TIMEZONE BRGINS***********
CASE WHEN ROUND(snsdb_new.`profiles`.timezone) = 1 THEN 1 ELSE 0 END AS timezone_1,
CASE WHEN ROUND(snsdb_new.`profiles`.timezone) = 2 THEN 1 ELSE 0 END AS timezone_2,
CASE WHEN ROUND(snsdb_new.`profiles`.timezone) = 3 THEN 1 ELSE 0 END AS timezone_3,
CASE WHEN ROUND(snsdb_new.`profiles`.timezone) = 4 THEN 1 ELSE 0 END AS timezone_4,
CASE WHEN ROUND(snsdb_new.`profiles`.timezone) = 5 THEN 1 ELSE 0 END AS timezone_5,
CASE WHEN ROUND(snsdb_new.`profiles`.timezone) = 6 THEN 1 ELSE 0 END AS timezone_6,
CASE WHEN ROUND(snsdb_new.`profiles`.timezone) = 7 THEN 1 ELSE 0 END AS timezone_7,
CASE WHEN ROUND(snsdb_new.`profiles`.timezone) = 8 THEN 1 ELSE 0 END AS timezone_8,
CASE WHEN ROUND(snsdb_new.`profiles`.timezone) = 9 THEN 1 ELSE 0 END AS timezone_9,
CASE WHEN ROUND(snsdb_new.`profiles`.timezone) = 10 THEN 1 ELSE 0 END AS timezone_10,
CASE WHEN ROUND(snsdb_new.`profiles`.timezone) = 11 THEN 1 ELSE 0 END AS timezone_11,
CASE WHEN ROUND(snsdb_new.`profiles`.timezone) = 12 THEN 1 ELSE 0 END AS timezone_12,
CASE WHEN ROUND(snsdb_new.`profiles`.timezone) = '-1' THEN 1 ELSE 0 END AS 'timezone_1-',
CASE WHEN ROUND(snsdb_new.`profiles`.timezone) = '-2' THEN 1 ELSE 0 END AS 'timezone_2-',
CASE WHEN ROUND(snsdb_new.`profiles`.timezone) = '-3' THEN 1 ELSE 0 END AS 'timezone_3-',
CASE WHEN ROUND(snsdb_new.`profiles`.timezone) = '-4' THEN 1 ELSE 0 END AS 'timezone_4-',
CASE WHEN ROUND(snsdb_new.`profiles`.timezone) = '-5' THEN 1 ELSE 0 END AS 'timezone_5-',
CASE WHEN ROUND(snsdb_new.`profiles`.timezone) = '-6' THEN 1 ELSE 0 END AS 'timezone_6-',
CASE WHEN ROUND(snsdb_new.`profiles`.timezone) = '-7' THEN 1 ELSE 0 END AS 'timezone_7-',
CASE WHEN ROUND(snsdb_new.`profiles`.timezone) = '-8' THEN 1 ELSE 0 END AS 'timezone_8-',
CASE WHEN ROUND(snsdb_new.`profiles`.timezone) = '-9' THEN 1 ELSE 0 END AS 'timezone_9-',
CASE WHEN ROUND(snsdb_new.`profiles`.timezone) = '-10' THEN 1 ELSE 0 END AS 'timezone_10-',
CASE WHEN ROUND(snsdb_new.`profiles`.timezone) = '-11' THEN 1 ELSE 0 END AS 'timezone_11-',
CASE WHEN ROUND(snsdb_new.`profiles`.timezone) = '-12' THEN 1 ELSE 0 END AS 'timezone_12-',
-- *******TIMEZONE ENDS***********

-- *******PROFILE COMPLETION BEGINS***********
CASE WHEN snsdb_new.`profiles`.gender IS NULL THEN 0 ELSE 1 END AS gender_bin,
CASE WHEN snsdb_new.`profiles`.timezone IS NULL THEN 0 ELSE 1 END AS timezone_bin,
CASE WHEN snsdb_new.`profiles`.livejournal IS NULL THEN 0 ELSE 1 END AS livejournal_bin,
CASE WHEN snsdb_new.`profiles`.instagram IS NULL THEN 0 ELSE 1 END AS instagram_bin,
CASE WHEN snsdb_new.`profiles`.facebook_id IS NULL THEN 0 ELSE 1 END AS facebook_id_bin,
CASE WHEN snsdb_new.`profiles`.facebook_name IS NULL THEN 0 ELSE 1 END AS facebook_name_bin,
CASE WHEN snsdb_new.`profiles`.twitter IS NULL THEN 0 ELSE 1 END AS twitter_bin,
CASE WHEN snsdb_new.`profiles`.updated IS NULL THEN 0 ELSE 1 END AS updated_bin,
CASE WHEN snsdb_new.`profiles`.relationship_partner_sns_item_id IS NULL THEN 0 ELSE 1 END AS relationship_partner_sns_item_id_bin,
CASE WHEN snsdb_new.`profiles`.skype IS NULL THEN 0 ELSE 1 END AS skype_bin,
CASE WHEN snsdb_new.`profiles`.relationship_type_id IS NULL THEN 0 ELSE 1 END AS relationship_type_id_bin,
CASE WHEN snsdb_new.`profiles`.home_phone IS NULL THEN 0 ELSE 1 END AS home_phone_bin,

CASE WHEN snsdb_new.`profiles`.first_name IS NULL THEN 0 ELSE 1 END AS first_name_bin,
CASE WHEN snsdb_new.`profiles`.last_name IS NULL THEN 0 ELSE 1 END AS last_name_bin,
CASE WHEN snsdb_new.`profiles`.nickname IS NULL THEN 0 ELSE 1 END AS nickname_bin,
CASE WHEN snsdb_new.`profiles`.screen_name IS NULL THEN 0 ELSE 1 END AS screen_name_bin,
CASE WHEN snsdb_new.`profiles`.location_location_id IS NULL THEN 0 ELSE 1 END AS location_location_id_bin,
CASE WHEN snsdb_new.`profiles`.location_country_id IS NULL THEN 0 ELSE 1 END AS location_country_id_bin,
CASE WHEN snsdb_new.`profiles`.country_id IS NULL THEN 0 ELSE 1 END AS country_id_bin,
CASE WHEN snsdb_new.`profiles`.hometown_location_id IS NULL THEN 0 ELSE 1 END AS hometown_location_id_bin,
CASE WHEN snsdb_new.`profiles`.status IS NULL THEN 0 ELSE 1 END AS status_bin,

(
(select _LOC from (SELECT
				snsdb_new.locations.id as _ID,
				snsdb_new.locations.geo_region_id as _LOC
				from snsdb_new.locations 
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.location_location_id)) as location_location_reg,

(
(select _LOC from (SELECT
				snsdb_new.locations.id as _ID,
				snsdb_new.locations.geo_city_id as _LOC
				from snsdb_new.locations 
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.location_location_id)) as location_location_cit,

(
(select _LOC from (SELECT
				snsdb_new.locations.id as _ID,
				snsdb_new.locations.geo_country_id as _LOC
				from snsdb_new.locations 
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.location_location_id)) as location_location_cou,


(
(select _LOC from (SELECT
				snsdb_new.locations.id as _ID,
				snsdb_new.locations.geo_region_id as _LOC
				from snsdb_new.locations 
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.location_country_id)) as location_country_reg,

(
(select _LOC from (SELECT
				snsdb_new.locations.id as _ID,
				snsdb_new.locations.geo_city_id as _LOC
				from snsdb_new.locations 
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.location_country_id)) as location_country_cit,

(
(select _LOC from (SELECT
				snsdb_new.locations.id as _ID,
				snsdb_new.locations.geo_country_id as _LOC
				from snsdb_new.locations 
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.location_country_id)) as location_country_cou,

(
(select _LOC from (SELECT
				snsdb_new.locations.id as _ID,
				snsdb_new.locations.geo_region_id as _LOC
				from snsdb_new.locations 
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.country_id)) as country_reg,

(
(select _LOC from (SELECT
				snsdb_new.locations.id as _ID,
				snsdb_new.locations.geo_city_id as _LOC
				from snsdb_new.locations 
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.country_id)) as country_cit,

(
(select _LOC from (SELECT
				snsdb_new.locations.id as _ID,
				snsdb_new.locations.geo_country_id as _LOC
				from snsdb_new.locations 
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.country_id)) as country_cou,


(
(select _LOC from (SELECT
				snsdb_new.locations.id as _ID,
				snsdb_new.locations.geo_region_id as _LOC
				from snsdb_new.locations 
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.hometown_location_id)) as hometown_location_reg,

(
(select _LOC from (SELECT
				snsdb_new.locations.id as _ID,
				snsdb_new.locations.geo_city_id as _LOC
				from snsdb_new.locations 
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.hometown_location_id)) as hometown_location_cit,

(
(select _LOC from (SELECT
				snsdb_new.locations.id as _ID,
				snsdb_new.locations.geo_country_id as _LOC
				from snsdb_new.locations 
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.hometown_location_id)) as hometown_location_cou,
-- *******PROFILE COMPLETION ENDS***********

-- ***************************************** EDUCATION DATA ***********************************************************

CASE WHEN snsdb_new.education.school_id IS NULL THEN 0 ELSE 1 END AS education,

COALESCE((
(select _COUNT from (SELECT
				snsdb_new.education.profile_id as _ID,
				COUNT(snsdb_new.schools.id) as _COUNT
				from snsdb_new.education left JOIN snsdb_new.schools on schools.id = snsdb_new.education.school_id
				WHERE snsdb_new.schools.type = 'University'
				GROUP BY snsdb_new.education.profile_id
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.id)), 0) as high_school_count,

COALESCE((
(select GROUP_CONCAT(DISTINCT _LIST SEPARATOR ', ') from (SELECT
				snsdb_new.education.profile_id as _ID,
				snsdb_new.schools.id as _LIST
				from snsdb_new.education left JOIN snsdb_new.schools on schools.id = snsdb_new.education.school_id
				WHERE snsdb_new.schools.type = 'University'
				-- GROUP BY snsdb_new.education.profile_id
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.id)), 0) as high_schools,

COALESCE((
(select _COUNT from (SELECT
				snsdb_new.education.profile_id as _ID,
				COUNT(snsdb_new.schools.id) as _COUNT
				from snsdb_new.education left JOIN snsdb_new.schools on schools.id = snsdb_new.education.school_id
				WHERE snsdb_new.schools.type = 'School'
				GROUP BY snsdb_new.education.profile_id
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.id)), 0) as college_count,


COALESCE((
(select GROUP_CONCAT(DISTINCT _LIST SEPARATOR ', ') from (SELECT
				snsdb_new.education.profile_id as _ID,
				snsdb_new.schools.id as _LIST
				from snsdb_new.education left JOIN snsdb_new.schools on schools.id = snsdb_new.education.school_id
				WHERE snsdb_new.schools.type = 'School'
				-- GROUP BY snsdb_new.education.profile_id
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.id)), 0) as colleges,

COALESCE((
(select GROUP_CONCAT(DISTINCT _LIST SEPARATOR ', ') from (SELECT
				snsdb_new.education.profile_id as _ID,
				snsdb_new.schools.id as _LIST
				from snsdb_new.education left JOIN snsdb_new.schools on schools.id = snsdb_new.education.school_id
				WHERE snsdb_new.schools.type not in ('School', 'University')
				-- GROUP BY snsdb_new.education.profile_id
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.id)), 0) as other_education,


/*
COALESCE((
(select _SUM from (SELECT
					snsdb_new.education.profile_id as _ID,
					Vw_Schools_Students.school_id as _SCHOOL_ID,
					sum(Vw_Schools_Students.students_count) as _SUM
				from 
					snsdb_new.education 
					left JOIN snsdb_new.schools on schools.id = snsdb_new.education.school_id 
					left JOIN Vw_Schools_Students on schools.id = Vw_Schools_Students.school_id
				WHERE snsdb_new.schools.type = 'University'
				GROUP BY snsdb_new.education.profile_id
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.id)
-- paydb.Vw_Schools_Students.students_count 
/ 
(select _avg from (SELECT
				avg(paydb.Vw_Schools_Students.students_count) as _avg
				from paydb.Vw_Schools_Students left JOIN snsdb_new.schools on schools.id = Vw_Schools_Students.school_id
				where schools.type = 'University'
) as temptable1
			)) / COALESCE((
(select _COUNT from (SELECT
				snsdb_new.education.profile_id as _ID,
				COUNT(snsdb_new.schools.id) as _COUNT
				from snsdb_new.education left JOIN snsdb_new.schools on schools.id = snsdb_new.education.school_id
				WHERE snsdb_new.schools.type = 'University'
				GROUP BY snsdb_new.education.profile_id
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.id)), 0), 0) as high_school_weighed, -- Count of profiles with the same Uni_Id divided by average count of profiles in average Uni_Id

COALESCE((
(select _SUM from (SELECT
					snsdb_new.education.profile_id as _ID,
					Vw_Schools_Students.school_id as _SCHOOL_ID,
					sum(Vw_Schools_Students.students_count) as _SUM
				from 
					snsdb_new.education 
					left JOIN snsdb_new.schools on schools.id = snsdb_new.education.school_id 
					left JOIN Vw_Schools_Students on schools.id = Vw_Schools_Students.school_id
				WHERE snsdb_new.schools.type = 'School'
				GROUP BY snsdb_new.education.profile_id
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.id)
-- paydb.Vw_Schools_Students.students_count 
/ 
(select _avg from (SELECT
				avg(paydb.Vw_Schools_Students.students_count) as _avg
				from paydb.Vw_Schools_Students left JOIN snsdb_new.schools on schools.id = Vw_Schools_Students.school_id
				where schools.type = 'School'
) as temptable1
			)) / COALESCE((
(select _COUNT from (SELECT
				snsdb_new.education.profile_id as _ID,
				COUNT(snsdb_new.schools.id) as _COUNT
				from snsdb_new.education left JOIN snsdb_new.schools on schools.id = snsdb_new.education.school_id
				WHERE snsdb_new.schools.type = 'School'
				GROUP BY snsdb_new.education.profile_id
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.id)), 0), 0) as college_weighed,
*/


-- ***************************************** JOB DATA *****************************************************************
-- VERY FEW PPL (about 4k) from the sample have jobs. More testing required if this simple measure proves to be usefull

COALESCE((
(select _COUNT from (SELECT
				snsdb_new.jobs.profile_id as _ID,
				COUNT(snsdb_new.jobs.id) as _COUNT
				from snsdb_new.jobs
				GROUP BY snsdb_new.jobs.profile_id
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.id)), 0) as jobs,


-- ***************************************** INTERESTS DATA ***********************************************************

COALESCE((
(select _COUNT from (SELECT
				snsdb_new.interests.profile_id as _ID,
				COUNT(snsdb_new.interests.id) as _COUNT
				from snsdb_new.interests 
				GROUP BY snsdb_new.interests.profile_id
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.id)), 0) as interests_cnt,

COALESCE((
(select _COUNT from (SELECT
				snsdb_new.interests.profile_id as _ID,
				COUNT(snsdb_new.interests.id) as _COUNT
				from snsdb_new.interests 
				where snsdb_new.interests.interest_type_id = 1
				GROUP BY snsdb_new.interests.profile_id
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.id)), 0) as interests_other_cnt,

COALESCE((
(select _COUNT from (SELECT
				snsdb_new.interests.profile_id as _ID,
				COUNT(snsdb_new.interests.id) as _COUNT
				from snsdb_new.interests 
				where snsdb_new.interests.interest_type_id = 2
				GROUP BY snsdb_new.interests.profile_id
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.id)), 0) as movies_cnt,


COALESCE((
(select _COUNT from (SELECT
				snsdb_new.interests.profile_id as _ID,
				COUNT(snsdb_new.interests.id) as _COUNT
				from snsdb_new.interests 
				where snsdb_new.interests.interest_type_id = 3
				GROUP BY snsdb_new.interests.profile_id
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.id)), 0) as tv_cnt,

COALESCE((
(select _COUNT from (SELECT
				snsdb_new.interests.profile_id as _ID,
				COUNT(snsdb_new.interests.id) as _COUNT
				from snsdb_new.interests 
				where snsdb_new.interests.interest_type_id = 4
				GROUP BY snsdb_new.interests.profile_id
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.id)), 0) as books_cnt,

COALESCE((
(select _COUNT from (SELECT
				snsdb_new.interests.profile_id as _ID,
				COUNT(snsdb_new.interests.id) as _COUNT
				from snsdb_new.interests 
				where snsdb_new.interests.interest_type_id = 5
				GROUP BY snsdb_new.interests.profile_id
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.id)), 0) as games_cnt,

COALESCE((
(select _COUNT from (SELECT
				snsdb_new.interests.profile_id as _ID,
				COUNT(snsdb_new.interests.id) as _COUNT
				from snsdb_new.interests 
				where snsdb_new.interests.interest_type_id = 6
				GROUP BY snsdb_new.interests.profile_id
) as temptable1
			WHERE _ID = snsdb_new.`profiles`.id)), 0) as about_cnt


-- ***************************************** CONTENT DATA ***********************************************************






-- ***************************************** PROFILE DATA ***********************************************************

FROM snsdb_new.`profiles`
	LEFT OUTER JOIN snsdb_new.education on snsdb_new.education.profile_id = snsdb_new.`profiles`.id
WHERE snsdb_new.`profiles`.sns_item_id IN (SELECT paydb.sns_profiles.sns_profile_id FROM paydb.sns_profiles)

GROUP BY snsdb_new.`profiles`.sns_item_id

-- LIMIT 1000