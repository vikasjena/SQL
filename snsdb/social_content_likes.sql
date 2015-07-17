SET @sns_item = 1441413738;
SET @sns_id = 2;
-- ************************************************************************* BASE TABLE WITH LIKES *******************************************************
DROP TEMPORARY TABLE IF EXISTS paydb.content_likes_base_tmp;
CREATE TEMPORARY TABLE paydb.content_likes_base_tmp
SELECT 
	FROM_UNIXTIME(paydb.sns_profiles.date_create) as date_create,
	content_types.`id` as type_id,
	content.sns_item_id_1,
	content.sns_item_id_0,

-- 	content.parent_sns_item_id_0,
-- 	content.parent_sns_item_id_1,

	content.to_sns_item_id,
	content_types.`name` as type_name,
	COUNT(likes.id) as cnt_likes,
	content.shares,
	content.`from`,

 	content.title,
 	content.content,
	content.date
FROM 
	`content` 
	INNER JOIN content_types on content_types.id = content.type_id
	INNER JOIN paydb.sns_profiles on paydb.sns_profiles.sns_id = content.sns_id AND paydb.sns_profiles.sns_profile_id = content.sns_item_id_0
 	LEFT OUTER JOIN likes on content.sns_item_id_1 = likes.sns_object_id_1 -- GENERAL CASE
-- 	LEFT OUTER JOIN likes on content.sns_item_id_1 = likes.sns_object_id_0 -- *** AUTOLIKES

WHERE 
	content.sns_item_id_0 = @sns_item
	AND content.sns_id = @sns_id
	AND content.date <= FROM_UNIXTIME(paydb.sns_profiles.date_create)
-- 	AND likes.profile_id = content.profile_id -- ****** AUTOLIKES ******
 
/*
-- ****** LIKES ONLY FROM FRIENDS  ******
	AND 	likes.sns_profile_id IN -- NOT IN Очень долго обрабатывается
												(SELECT
														frnd.friend_sns_item_id 
													FROM 
														snsdb_new.friends as frnd
													WHERE  frnd.sns_item_id = content.sns_item_id_0 and frnd.sns_id = content.sns_id)
*/
GROUP BY 
	content.sns_item_id_1
-- HAVING cnt_likes > 0
ORDER BY 
	-- content.type_id,
	date DESC
LIMIT 200;


-- ************************************************************************* SELF LIKES TABLE *******************************************************
DROP TEMPORARY TABLE IF EXISTS paydb.content_likes_self_tmp;
CREATE TEMPORARY TABLE paydb.content_likes_self_tmp
SELECT 
-- 	FROM_UNIXTIME(paydb.sns_profiles.date_create) as date_create,
-- 	content_types.`id` as type_id,
	content.sns_item_id_1,
	content.sns_item_id_0,
-- 	content.parent_sns_item_id_0,
-- 	content.parent_sns_item_id_1,
-- 	content.to_sns_item_id,
-- 	content_types.`name` as type_name,
	COUNT(likes.id) as cnt_likes,
-- 	content.shares,
-- 	content.`from`,
-- 	content.title,
-- 	content.content,
	content.date
FROM 
	`content` 
	INNER JOIN content_types on content_types.id = content.type_id
	INNER JOIN paydb.sns_profiles on paydb.sns_profiles.sns_id = content.sns_id AND paydb.sns_profiles.sns_profile_id = content.sns_item_id_0
--  	LEFT OUTER JOIN likes on content.sns_item_id_1 = likes.sns_object_id_1 -- GENERAL CASE
 	LEFT OUTER JOIN likes on content.sns_item_id_1 = likes.sns_object_id_0 -- *** AUTOLIKES

WHERE 
	content.sns_item_id_0 = @sns_item
	AND content.sns_id = @sns_id
	AND content.date <= FROM_UNIXTIME(paydb.sns_profiles.date_create)
 	AND likes.profile_id = content.profile_id -- ****** AUTOLIKES ******
 
/*
-- ****** LIKES ONLY FROM FRIENDS  ******
	AND 	likes.sns_profile_id IN -- NOT IN Очень долго обрабатывается
												(SELECT
														frnd.friend_sns_item_id 
													FROM 
														snsdb_new.friends as frnd
													WHERE  frnd.sns_item_id = content.sns_item_id_0 and frnd.sns_id = content.sns_id)
*/
GROUP BY 
	content.sns_item_id_1
-- HAVING cnt_likes > 0
ORDER BY 
	-- content.type_id,
	date DESC
LIMIT 200;

-- ************************************************************************* FRIENDS LIKES TABLE *******************************************************
DROP TEMPORARY TABLE IF EXISTS paydb.content_likes_friends_tmp;
CREATE TEMPORARY TABLE paydb.content_likes_friends_tmp
SELECT 
-- 	FROM_UNIXTIME(paydb.sns_profiles.date_create) as date_create,
-- 	content_types.`id` as type_id,
	content.sns_item_id_1,
	content.sns_item_id_0,
-- 	content.parent_sns_item_id_0,
-- 	content.parent_sns_item_id_1,
-- 	content.to_sns_item_id,
-- 	content_types.`name` as type_name,
	COUNT(likes.id) as cnt_likes,
-- 	content.shares,
-- 	content.`from`,
-- 	content.title,
-- 	content.content,
	content.date
FROM 
	`content` 
	INNER JOIN content_types on content_types.id = content.type_id
	INNER JOIN paydb.sns_profiles on paydb.sns_profiles.sns_id = content.sns_id AND paydb.sns_profiles.sns_profile_id = content.sns_item_id_0
 	LEFT OUTER JOIN likes on content.sns_item_id_1 = likes.sns_object_id_1 -- GENERAL CASE
 	-- LEFT OUTER JOIN likes on content.sns_item_id_1 = likes.sns_object_id_0 -- *** AUTOLIKES

WHERE 
	content.sns_item_id_0 = @sns_item
	AND content.sns_id = @sns_id
	AND content.date <= FROM_UNIXTIME(paydb.sns_profiles.date_create)
 	-- AND likes.profile_id = content.profile_id -- ****** AUTOLIKES ******
 

-- ****** LIKES ONLY FROM FRIENDS  ******
	AND 	likes.sns_profile_id IN -- NOT IN Очень долго обрабатывается
												(SELECT
														frnd.friend_sns_item_id 
													FROM 
														snsdb_new.friends as frnd
													WHERE  frnd.sns_item_id = content.sns_item_id_0 and frnd.sns_id = content.sns_id)

GROUP BY 
	content.sns_item_id_1
-- HAVING cnt_likes > 0
ORDER BY 
	-- content.type_id,
	date DESC
LIMIT 200;

-- ************************************************************************* FINAL MERGED OUTPUT *******************************************************
SELECT 
base.date_create,
base.type_id,
base.sns_item_id_0, 
base.sns_item_id_1, 
-- base.parent_sns_item_id_0,
-- base.parent_sns_item_id_1, 
base.sns_item_id_1, 
base.type_name, 
base.cnt_likes, 
slf_like.cnt_likes as cnt_slf_like, 
frnd_like.cnt_likes as cnt_frnd_like,
base.shares,
base.title,
base.content,
base.date

FROM
	paydb.content_likes_base_tmp as base
	LEFT OUTER JOIN paydb.content_likes_self_tmp as slf_like on slf_like.sns_item_id_1 = base.sns_item_id_1
	LEFT OUTER JOIN paydb.content_likes_friends_tmp as frnd_like on frnd_like.sns_item_id_1 = base.sns_item_id_1
ORDER BY
date DESC
;
SELECT * FROM paydb.content_likes_base_tmp;
SELECT * FROM paydb.content_likes_self_tmp;
SELECT * FROM paydb.content_likes_friends_tmp;
