-- DROP TABLE IF EXISTS paydb.ch_friends_count_check;
-- CREATE TABLE paydb.ch_friends_count_check
-- SELECT 
-- 	profile_counters.profile_id, 
-- 	`profiles`.sns_id,
-- 	`profiles`.sns_item_id,
-- 	profile_counters.friends,
-- 	COUNT(friends.id)
-- 
-- FROM 
-- 	snsdb.profile_counters
-- 	INNER JOIN snsdb.`profiles` on snsdb.profile_counters.profile_id = snsdb.`profiles`.id
-- 	LEFT OUTER JOIN snsdb.friends on snsdb.friends.sns_id = snsdb.`profiles`.sns_id AND snsdb.friends.sns_item_id = snsdb.`profiles`.sns_item_id
-- GROUP BY 
-- 	profile_counters.profile_id
-- -- LIMIT 10
-- ;

SELECT 
	ch_friends_count_check.*,
	ch_friends_count_check.`COUNT(friends.id)` - ch_friends_count_check.friends as diff,
	FORMAT(((ch_friends_count_check.`COUNT(friends.id)` - ch_friends_count_check.friends) / friends)*100,2) as diff_percent
FROM `ch_friends_count_check`
WHERE 
	(((ch_friends_count_check.`COUNT(friends.id)` - ch_friends_count_check.friends) / friends)*100 < -10 
	OR ((ch_friends_count_check.`COUNT(friends.id)` - ch_friends_count_check.friends) / friends)*100 IS NULL)
	AND (ch_friends_count_check.friends BETWEEN 10 AND 1000)
ORDER BY 
	friends DESC
;