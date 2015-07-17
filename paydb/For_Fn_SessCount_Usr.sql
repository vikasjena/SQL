DROP FUNCTION IF EXISTS SessCountUsr;
CREATE FUNCTION SessCountUsr (ID BIGINT, purchase_date BIGINT) 
-- COMMENT 'Returns count of sessions that the user has started before making his first purchase including the session of the purchase'
RETURNS BIGINT DETERMINISTIC
READS SQL DATA	

BEGIN
DECLARE _COUNT BIGINT;
SELECT 
COUNT(Vw_Sessions_Data.id) INTO _COUNT
FROM Vw_Sessions_Data
WHERE Vw_Sessions_Data.date_start_u < purchase_date AND Vw_Sessions_Data.user_id = ID;
RETURN _COUNT;
END;

-- select SessCount(4795,  1387209249) as ABC