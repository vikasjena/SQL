DROP TABLE IF EXISTS ch_sns_profiles_friends_payments;
CREATE TABLE ch_sns_profiles_friends_payments
SELECT
	FROM_UNIXTIME(sns_profiles.date_create) as date_create,
	sns_profiles.first_name,
	sns_profiles.last_name,
	sns_profiles.sns_id,
	sns_profiles.sns_profile_id,
	sns_profiles.birthdate,
	union_sns_profiles.union_id, 	
	sns_profiles.count_friends,

(SELECT count(DISTINCT _LIST) 
											FROM (
											select 
											frnd.sns_id as _sns_id,
											frnd.sns_item_id as _sns_profile_id,
											frnd.friend_sns_item_id as _LIST
											FROM snsdb_new.friends as frnd) as tmp_tbl
											WHERE _sns_id = sns_profiles.sns_id AND _sns_profile_id = sns_profiles.sns_profile_id) as cnt_frnd,

frnd_union_original(sns_profiles.sns_id, sns_profiles.sns_profile_id) as frnd_union_original,
frnd_union_paid(sns_profiles.sns_id, sns_profiles.sns_profile_id) as frnd_union_paid,

frnd_profile_original(sns_profiles.sns_id, sns_profiles.sns_profile_id) as frnd_profile_original,
frnd_profile_default(sns_profiles.sns_id, sns_profiles.sns_profile_id) as frnd_profile_default,
frnd_profile_paid(sns_profiles.sns_id, sns_profiles.sns_profile_id) as frnd_profile_paid,
frnd_profile_original_cnt(sns_profiles.sns_id, sns_profiles.sns_profile_id) as frnd_profile_original_cnt
,frnd_profile_default_cnt(sns_profiles.sns_id, sns_profiles.sns_profile_id) as frnd_profile_default_cnt,
frnd_profile_paid_cnt(sns_profiles.sns_id, sns_profiles.sns_profile_id) as frnd_profile_paid_cnt

FROM
	sns_profiles
	INNER JOIN union_sns_profiles on union_sns_profiles.sns_id =  sns_profiles.sns_id AND sns_profiles.sns_profile_id = union_sns_profiles.sns_item_id
WHERE sns_profiles.condition_passed = 1
-- HAVING cnt_frnd = count_friends LIMIT 100