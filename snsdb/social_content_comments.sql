SET @sns_item = 1103793950;
SET @sns_id = 2;

    SELECT  FROM_UNIXTIME(paydb.sns_profiles.date_create) as date_create,
            snsdb_new.content_types.`id` as type_id,
            snsdb_new.content.sns_item_id_1,
            snsdb_new.content.sns_item_id_0,
            -- snsdb_new.content.to_sns_item_id,
            -- snsdb_new.content_types.`name` as type_name,
            snsdb_new.content.shares
            -- ,snsdb_new.content.`from`
            -- ,snsdb_new.content.date
    FROM
        snsdb_new.`content`
        INNER JOIN snsdb_new.content_types on snsdb_new.content_types.id = snsdb_new.content.type_id
        INNER JOIN paydb.sns_profiles on paydb.sns_profiles.sns_id = snsdb_new.content.sns_id AND paydb.sns_profiles.sns_profile_id = snsdb_new.content.sns_item_id_0
    WHERE
        snsdb_new.content.sns_item_id_0 = @sns_item
        AND snsdb_new.content.sns_id = @sns_id
        AND (content.date <= FROM_UNIXTIME(paydb.sns_profiles.date_create) OR content.date IS NULL)
    GROUP BY
        snsdb_new.content.id
    ORDER BY
        date DESC
    LIMIT 200;



-- ************************************************************************* BASE TABLE WITH COMMENTS *******************************************************
SELECT 
	-- FROM_UNIXTIME(paydb.sns_profiles.date_create) as date_create,
	-- content_types.`id` as type_id,
	content.sns_item_id_1,
	-- content.sns_item_id_0,
-- 	content.parent_sns_item_id_0,
-- 	content.parent_sns_item_id_1,
	content.to_sns_item_id,
	content_types.`name` as type_name,
	COUNT(comments.id) as cnt_comments,
	content.shares,
	content.`from`,
-- 	content.title,
-- 	content.content,
	content.date
FROM 
	snsdb_new.content
	INNER JOIN snsdb_new.content_types on content_types.id = content.type_id
	INNER JOIN paydb.sns_profiles on paydb.sns_profiles.sns_id = content.sns_id AND paydb.sns_profiles.sns_profile_id = content.sns_item_id_0
 	INNER JOIN (SELECT * FROM snsdb_new.comments WHERE comments.parent_sns_item_id_0 = @sns_item LIMIT 200000) as comments on content.sns_item_id_1 = comments.parent_sns_item_id_1
--  	LEFT OUTER JOIN comments on content.sns_item_id_1 = comments.parent_sns_item_id_1
       # INNER JOIN (SELECT * FROM snsdb_new.likes WHERE snsdb_new.likes.sns_object_id_0 = %s LIMIT 200000) as likes on content.sns_item_id_1 = likes.sns_object_id_1
WHERE 
	content.sns_item_id_0 = @sns_item
	AND content.sns_id = @sns_id
	AND content.date <= FROM_UNIXTIME(paydb.sns_profiles.date_create)

GROUP BY 
	content.sns_item_id_1
ORDER BY 
	date
LIMIT 200;


-- ************************************************************************* SELF COMMENTS TABLE *******************************************************
SELECT 
-- 	FROM_UNIXTIME(paydb.sns_profiles.date_create) as date_create,
-- 	content_types.`id` as type_id,
 	content.sns_item_id_1,
-- 	content.sns_item_id_0,

-- 	content.parent_sns_item_id_0,
-- 	content.parent_sns_item_id_1,

-- 	content.to_sns_item_id,
-- 	content_types.`name` as type_name,
	COUNT(content.id) as cnt_comments,
-- 	content.shares,
-- 	content.`from`,

-- 	content.title,
-- 	content.content,
 	content.date
FROM 
	`content` 
	INNER JOIN content_types on content_types.id = content.type_id
	INNER JOIN paydb.sns_profiles on paydb.sns_profiles.sns_id = content.sns_id AND paydb.sns_profiles.sns_profile_id = content.sns_item_id_0
 	INNER JOIN (SELECT * FROM snsdb_new.comments WHERE comments.parent_sns_item_id_0 = @sns_item LIMIT 200000) as comments on content.sns_item_id_1 = comments.parent_sns_item_id_1
--  	LEFT OUTER JOIN comments on content.sns_item_id_1 = comments.parent_sns_item_id_1

WHERE 
	content.sns_item_id_0 = @sns_item
	AND content.sns_id = @sns_id
	AND content.date <= FROM_UNIXTIME(paydb.sns_profiles.date_create)

-- ****** AUTOCOMMENTS ******
AND comments.from_sns_item_id = @sns_item  
 
/*
-- ****** COMMENTS ONLY FROM FRIENDS  ******
	AND 	comments.from_sns_item_id IN -- NOT IN Очень долго обрабатывается
												(SELECT
														frnd.friend_sns_item_id 
													FROM 
														snsdb_new.friends as frnd
													WHERE  frnd.sns_item_id = content.sns_item_id_0 and frnd.sns_id = content.sns_id)
*/
GROUP BY 
	content.id
ORDER BY 
	date
LIMIT 200;


-- ************************************************************************* FRIENDS COMMENTS TABLE *******************************************************
SELECT 
-- 	FROM_UNIXTIME(paydb.sns_profiles.date_create) as date_create,
-- 	content_types.`id` as type_id,
 	content.sns_item_id_1,
-- 	content.sns_item_id_0,

-- 	content.parent_sns_item_id_0,
-- 	content.parent_sns_item_id_1,

-- 	content.to_sns_item_id,
-- 	content_types.`name` as type_name,
 	COUNT(content.id) as cnt_comments,
-- 	content.shares,
-- 	content.`from`,

-- 	content.title,
-- 	content.content,
 	content.date
FROM 
	`content` 
	INNER JOIN content_types on content_types.id = content.type_id
	INNER JOIN paydb.sns_profiles on paydb.sns_profiles.sns_id = content.sns_id AND paydb.sns_profiles.sns_profile_id = content.sns_item_id_0
 	INNER JOIN (SELECT * FROM snsdb_new.comments WHERE comments.parent_sns_item_id_0 = @sns_item LIMIT 200000) as comments on content.sns_item_id_1 = comments.parent_sns_item_id_1
--  	LEFT OUTER JOIN comments on content.sns_item_id_1 = comments.parent_sns_item_id_1

WHERE 
	content.sns_item_id_0 = @sns_item
	AND content.sns_id = @sns_id
	AND content.date <= FROM_UNIXTIME(paydb.sns_profiles.date_create)

-- ****** AUTOCOMMENTS ******
-- AND content.sns_item_id_0 = comments.from_sns_item_id         
 

-- ****** COMMENTS ONLY FROM FRIENDS  ******
	AND 	comments.from_sns_item_id IN -- NOT IN Очень долго обрабатывается
												(SELECT
														frnd.friend_sns_item_id 
													FROM 
														snsdb_new.friends as frnd
													WHERE  frnd.sns_item_id = content.sns_item_id_0 and frnd.sns_id = content.sns_id)

GROUP BY 
	content.sns_item_id_1
ORDER BY 
	date
LIMIT 200;

/*
-- ************************************************************************* FINAL MERGED COMMENTS OUTPUT *******************************************************
SELECT 
base.date_create,
base.type_id,
base.sns_item_id_0, 
base.sns_item_id_1, 
-- base.parent_sns_item_id_0,
-- base.parent_sns_item_id_1, 
base.sns_item_id_1, 
base.type_name, 
base.cnt_comments, 
slf_like.cnt_comments as cnt_slf_comments, 
frnd_like.cnt_comments as cnt_frnd_comments,
base.shares,
-- base.title,
-- base.content,
base.date

FROM
	paydb.content_comments_base_tmp as base
	LEFT OUTER JOIN paydb.content_comments_self_tmp as slf_like on slf_like.sns_item_id_1 = base.sns_item_id_1
	LEFT OUTER JOIN paydb.content_comments_friends_tmp as frnd_like on frnd_like.sns_item_id_1 = base.sns_item_id_1
ORDER BY
date DESC
*/