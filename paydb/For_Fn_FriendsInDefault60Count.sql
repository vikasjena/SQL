DROP FUNCTION IF EXISTS FriendsInDefault60Count;
CREATE FUNCTION FriendsInDefault60Count (ID BIGINT)  
RETURNS BIGINT DETERMINISTIC
READS SQL DATA	
BEGIN
DECLARE _COUNT BIGINT;
SELECT 
	-- ch_profiles_default.sns_profile_id into _count
	sum(ch_profiles_default.Default_60) INTO _COUNT
	FROM
	ch_profiles_default
	WHERE	ch_profiles_default.sns_profile_id IN (SELECT sns_item_id1 FROM user_relations_lite_directional WHERE	sns_item_id0 = ID)
;
RETURN _COUNT;
END;
