DROP FUNCTION IF EXISTS frnd_union_original;
CREATE FUNCTION frnd_union_original (SNS_ID INT, SNS_PROFILE_ID BIGINT)  
RETURNS BIGINT DETERMINISTIC
READS SQL DATA	
BEGIN
DECLARE _DATA_OUT BIGINT;

SELECT 					
	sum(cr.amount_original) INTO _DATA_OUT
-- 	(sum(cr.amount_paid) + sum(cr.interest_paid)) as amount_paid,
-- 	 sum(cr.amount_remaining) as amount_remaining
FROM
	sns_profiles as prof
	INNER JOIN union_sns_profiles as un_prof on prof.sns_id = un_prof.sns_id AND un_prof.sns_item_id = prof.sns_profile_id
	INNER JOIN union_users as un_users ON un_users.union_id = un_prof.union_id
	INNER JOIN credits as cr on cr.user_id = un_users.user_id
WHERE 
	prof.sns_profile_id IN (SELECT 
														frnd.friend_sns_item_id 
													FROM 
														snsdb_new.friends as frnd
													WHERE  sns_item_id = SNS_PROFILE_ID and sns_id = SNS_ID)
AND cr.date_create < prof.date_create

-- GROUP BY 
-- 	prof.sns_profile_id
;
RETURN _DATA_OUT;
END;

-- SELECT frnd_amount_original(1, 3187544)

DROP FUNCTION IF EXISTS frnd_union_paid;
CREATE FUNCTION frnd_union_paid (SNS_ID INT, SNS_PROFILE_ID BIGINT)  
RETURNS BIGINT DETERMINISTIC
READS SQL DATA	
BEGIN
DECLARE _DATA_OUT BIGINT;

SELECT 					
	SUM((SELECT SUM(amount) FROM credit_operations as co WHERE co.type_id = 3 AND co.credit_id = cr.id AND co.date_create < prof.date_create)) INTO _DATA_OUT
-- 	(sum(cr.amount_paid) + sum(cr.interest_paid)) as amount_paid,
-- 	 sum(cr.amount_remaining) as amount_remaining
FROM
	sns_profiles as prof
	INNER JOIN union_sns_profiles as un_prof on prof.sns_id = un_prof.sns_id AND un_prof.sns_item_id = prof.sns_profile_id
	INNER JOIN union_users as un_users ON un_users.union_id = un_prof.union_id
	INNER JOIN credits as cr on cr.user_id = un_users.user_id
WHERE 
	prof.sns_profile_id IN (SELECT 
														frnd.friend_sns_item_id 
													FROM 
														snsdb_new.friends as frnd
													WHERE  sns_item_id = SNS_PROFILE_ID and sns_id = SNS_ID)
AND cr.date_create < prof.date_create
-- GROUP BY 
-- 	prof.sns_profile_id
;
RETURN _DATA_OUT;
END;



DROP FUNCTION IF EXISTS frnd_profile_original;
CREATE FUNCTION frnd_profile_original (SNS_ID INT, SNS_PROFILE_ID BIGINT)  
RETURNS BIGINT DETERMINISTIC
READS SQL DATA	
BEGIN
DECLARE _DATA_OUT BIGINT;

SELECT 					
	sum(cr.amount_original) INTO _DATA_OUT
-- 	(sum(cr.amount_paid) + sum(cr.interest_paid)) as amount_paid,
-- 	 sum(cr.amount_remaining) as amount_remaining
FROM
	sns_profiles as prof
	INNER JOIN credit_sessions as cs on cs.sns_profile_id = prof.id
	INNER JOIN credits as cr on cr.id = cs.credit_id
WHERE 
	prof.sns_profile_id IN (SELECT 
														frnd.friend_sns_item_id 
													FROM 
														snsdb_new.friends as frnd
													WHERE  sns_item_id = SNS_PROFILE_ID and sns_id = SNS_ID)
AND cr.date_create < prof.date_create
-- GROUP BY 
-- 	prof.sns_profile_id
;
RETURN _DATA_OUT;
END;



DROP FUNCTION IF EXISTS frnd_profile_default;
CREATE FUNCTION frnd_profile_default (SNS_ID INT, SNS_PROFILE_ID BIGINT)  
RETURNS BIGINT DETERMINISTIC
READS SQL DATA	
BEGIN
DECLARE _DATA_OUT BIGINT;

SELECT 					
-- 	sum(cr.amount_original) INTO _DATA_OUT
	SUM(cr.amount_original - (SELECT SUM(amount) FROM credit_operations as co WHERE co.type_id = 3 AND co.credit_id = cr.id AND co.date_create < prof.date_create)) INTO _DATA_OUT
-- 	(sum(cr.amount_paid) + sum(cr.interest_paid)) as amount_paid,
-- 	 sum(cr.amount_remaining) as amount_remaining
FROM
	sns_profiles as prof
	INNER JOIN credit_sessions as cs on cs.sns_profile_id = prof.id
	INNER JOIN credits as cr on cr.id = cs.credit_id
WHERE 
	prof.sns_profile_id IN (SELECT 
														frnd.friend_sns_item_id 
													FROM 
														snsdb_new.friends as frnd
													WHERE  sns_item_id = SNS_PROFILE_ID and sns_id = SNS_ID)
AND cr.date_create < prof.date_create
AND cr.date_default < prof.date_create
-- HAVING SUM((SELECT SUM(amount) FROM credit_operations as co WHERE co.type_id = 3 AND co.credit_id = cr.id AND co.date_create < prof.date_create)) < sum(cr.amount_original)
-- GROUP BY 
-- 	prof.sns_profile_id
;
RETURN _DATA_OUT;
END;
-- SELECT frnd_amount_original_default(1, 28704752)



DROP FUNCTION IF EXISTS frnd_profile_paid;
CREATE FUNCTION frnd_profile_paid (SNS_ID INT, SNS_PROFILE_ID BIGINT)  
RETURNS BIGINT DETERMINISTIC
READS SQL DATA	
BEGIN
DECLARE _DATA_OUT BIGINT;

SELECT 					
	SUM((SELECT SUM(amount) FROM credit_operations as co WHERE co.type_id = 3 AND co.credit_id = cr.id AND co.date_create < prof.date_create)) INTO _DATA_OUT
-- 	(sum(cr.amount_paid) + sum(cr.interest_paid)) as amount_paid,
-- 	 sum(cr.amount_remaining) as amount_remaining
FROM
	sns_profiles as prof
	INNER JOIN credit_sessions as cs on cs.sns_profile_id = prof.id
	INNER JOIN credits as cr on cr.id = cs.credit_id
WHERE 
	prof.sns_profile_id IN (SELECT 
														frnd.friend_sns_item_id 
													FROM 
														snsdb_new.friends as frnd
													WHERE  sns_item_id = SNS_PROFILE_ID and sns_id = SNS_ID)
AND cr.date_create < prof.date_create
-- GROUP BY 
-- 	prof.sns_profile_id
;
RETURN _DATA_OUT;
END;
-- SELECT frnd_amount_original_default(1, 28704752)

DROP FUNCTION IF EXISTS frnd_profile_original_cnt;
CREATE FUNCTION frnd_profile_original_cnt (SNS_ID INT, SNS_PROFILE_ID BIGINT)  
RETURNS BIGINT DETERMINISTIC
READS SQL DATA	
BEGIN
DECLARE _DATA_OUT BIGINT;

SELECT 					
	COUNT(DISTINCT prof.sns_profile_id) INTO _DATA_OUT
-- 	(sum(cr.amount_paid) + sum(cr.interest_paid)) as amount_paid,
-- 	 sum(cr.amount_remaining) as amount_remaining
FROM
	sns_profiles as prof
	INNER JOIN credit_sessions as cs on cs.sns_profile_id = prof.id
	INNER JOIN credits as cr on cr.id = cs.credit_id
WHERE 
	prof.sns_profile_id IN (SELECT 
														frnd.friend_sns_item_id 
													FROM 
														snsdb_new.friends as frnd
													WHERE  sns_item_id = SNS_PROFILE_ID and sns_id = SNS_ID)
AND cr.date_create < prof.date_create
-- GROUP BY 
-- 	prof.sns_profile_id
;
RETURN _DATA_OUT;
END;


-- ***************************************************************************************************************************************************************************
DROP FUNCTION IF EXISTS frnd_profile_default_cnt;
CREATE FUNCTION frnd_profile_default_cnt (SNS_ID INT, SNS_PROFILE_ID BIGINT)  
RETURNS BIGINT DETERMINISTIC
READS SQL DATA	
BEGIN
DECLARE _DATA_OUT BIGINT;

SELECT 					
	COUNT(DISTINCT prof.sns_profile_id) INTO _DATA_OUT
-- 	(sum(cr.amount_paid) + sum(cr.interest_paid)) as amount_paid,
-- 	 sum(cr.amount_remaining) as amount_remaining
FROM
	sns_profiles as prof
	INNER JOIN credit_sessions as cs on cs.sns_profile_id = prof.id
	INNER JOIN credits as cr on cr.id = cs.credit_id
WHERE 
	prof.sns_profile_id IN (SELECT 
														frnd.friend_sns_item_id 
													FROM 
														snsdb_new.friends as frnd
													WHERE  sns_item_id = SNS_PROFILE_ID and sns_id = SNS_ID)
AND cr.date_create < prof.date_create
AND cr.date_default < prof.date_create
AND cr.amount_remaining > 0
-- AND cr.amount_original - (SELECT SUM(amount) FROM credit_operations as co WHERE co.type_id = 3 AND co.credit_id = cr.id AND co.date_create < prof.date_create) > 0
-- HAVING 	SUM(cr.amount_original - (SELECT SUM(amount) FROM credit_operations as co WHERE co.type_id = 3 AND co.credit_id = cr.id AND co.date_create < prof.date_create)) > 0
-- GROUP BY 
-- prof.sns_profile_id 
;
RETURN _DATA_OUT;
END;
-- SELECT frnd_amount_original_default(1, 28704752)


DROP FUNCTION IF EXISTS frnd_profile_paid_cnt;
CREATE FUNCTION frnd_profile_paid_cnt (SNS_ID INT, SNS_PROFILE_ID BIGINT)  
RETURNS BIGINT DETERMINISTIC
READS SQL DATA	
BEGIN
DECLARE _DATA_OUT BIGINT;

SELECT 					
	COUNT(DISTINCT prof.sns_profile_id) INTO _DATA_OUT
-- 	(sum(cr.amount_paid) + sum(cr.interest_paid)) as amount_paid,
-- 	 sum(cr.amount_remaining) as amount_remaining
FROM
	sns_profiles as prof
	INNER JOIN credit_sessions as cs on cs.sns_profile_id = prof.id
	INNER JOIN credits as cr on cr.id = cs.credit_id
WHERE 
	prof.sns_profile_id IN (SELECT 
														frnd.friend_sns_item_id 
													FROM 
														snsdb_new.friends as frnd
													WHERE  sns_item_id = SNS_PROFILE_ID and sns_id = SNS_ID)
AND cr.date_create < prof.date_create
AND cr.amount_paid > 0
-- AND (SELECT SUM(amount) FROM credit_operations as co WHERE co.type_id = 3 AND co.credit_id = cr.id AND co.date_create < prof.date_create) > 0
-- GROUP BY 
-- 	prof.sns_profile_id
;
RETURN _DATA_OUT;
END;

