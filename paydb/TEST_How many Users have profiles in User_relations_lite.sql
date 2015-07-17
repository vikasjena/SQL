SELECT
		paydb.user_relations_lite_directional.sns_item_id0 as _ID,
		count(DISTINCT paydb.user_relations_lite_directional.sns_item_id1) as _COUNT
FROM paydb.user_relations_lite_directional
-- INNER JOIN snsdb.`profiles` on (snsdb.`profiles`.sns_item_id = paydb.sns_profiles.sns_profile_id)
INNER JOIN Vw_Users_Loans on Vw_Users_Loans.sns_profile_id = user_relations_lite_directional.sns_item_id0
GROUP BY paydb.user_relations_lite_directional.sns_item_id0