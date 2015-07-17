DROP FUNCTION IF EXISTS ProfilesCountUnion;
CREATE FUNCTION ProfilesCountUnion (ID BIGINT, purchase_date BIGINT) 
-- COMMENT 'Returns count of sessions that the user has started before making his first purchase including the session of the purchase'
RETURNS BIGINT DETERMINISTIC
READS SQL DATA	

BEGIN
DECLARE _COUNT BIGINT;
SELECT 
COUNT(DISTINCT union_sns_profiles.sns_item_id) INTO _COUNT
FROM union_sns_profiles INNER JOIN sns_profiles on sns_profiles.sns_profile_id = union_sns_profiles.sns_item_id
WHERE sns_profiles.date_create <= purchase_date AND union_sns_profiles.union_id = ID;
RETURN _COUNT;
END;

