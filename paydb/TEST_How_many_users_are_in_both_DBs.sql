SELECT

ABS(((select _COUNT FROM 
	(SELECT
		paydb.user_relations_lite_directional.sns_item_id0 as _ID,
		count(DISTINCT paydb.user_relations_lite_directional.sns_item_id1) as _COUNT
	FROM paydb.user_relations_lite_directional
	GROUP BY paydb.user_relations_lite_directional.sns_item_id0) AS Temp_Table1
	WHERE sns_profiles.sns_profile_id = _ID) / sns_profiles.count_friends)*100 - 100) as Abs_Frnd_Diff,

sns_profiles.sns_id AS Sns_Id,
snsdb.`profiles` .first_name,
sns_profiles.*



FROM
	scoring_short_data_full
LEFT OUTER JOIN sns_profiles on sns_profiles.sns_profile_id = scoring_short_data_full.sns_profile_id
INNER JOIN snsdb.`profiles` on snsdb.`profiles`.sns_item_id = scoring_short_data_full.sns_profile_id

-- and sns_profiles.sns_id = 1
