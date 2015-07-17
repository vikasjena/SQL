DROP FUNCTION IF EXISTS LoanCount;
CREATE FUNCTION LoanCount (ID BIGINT, purchase_date BIGINT) 
-- COMMENT 'Returns count of sessions that the user has started before making his first purchase including the session of the purchase'
RETURNS BIGINT DETERMINISTIC
READS SQL DATA	

BEGIN
DECLARE _COUNT BIGINT;
SELECT 
COUNT(credits.id) INTO _COUNT
FROM credits
WHERE credits.date_create <= purchase_date AND credits.user_id = ID;
RETURN _COUNT;
END;

-- select LoanCount(306,  1382349934) as ABC;
