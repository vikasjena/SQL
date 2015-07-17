
DROP FUNCTION IF EXISTS PayBacksCount;
CREATE FUNCTION PayBacksCount (ID BIGINT) 
-- COMMENT 'Returns count of sessions that the user has started before making his first purchase including the session of the purchase'
RETURNS BIGINT DETERMINISTIC
READS SQL DATA	

BEGIN
DECLARE _COUNT BIGINT;
SELECT 
COUNT(credits.id) INTO _COUNT
FROM credits
WHERE credits.amount_remaining = 0 AND credits.user_id = ID;
RETURN _COUNT;
END;