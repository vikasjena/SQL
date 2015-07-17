DROP FUNCTION IF EXISTS TimeTermsSumUsr;
CREATE FUNCTION TimeTermsSumUsr (ID BIGINT, purchase_date BIGINT) 
-- COMMENT 'Returns count of sessions that the user has started before making his first purchase including the session of the purchase'
RETURNS BIGINT DETERMINISTIC
READS SQL DATA	

BEGIN
DECLARE _SUM BIGINT;
SELECT 
SUM(Vw_Sessions_Data.time_to_read_terms) INTO _SUM
FROM Vw_Sessions_Data
WHERE Vw_Sessions_Data.date_start_u <= purchase_date AND Vw_Sessions_Data.user_id = ID;
RETURN _SUM;
END;

-- select SessCount(4795,  1387209249) as ABC

DROP FUNCTION IF EXISTS TimeCompleteSumUsr;
CREATE FUNCTION TimeCompleteSumUsr (ID BIGINT, purchase_date BIGINT) 
-- COMMENT 'Returns count of sessions that the user has started before making his first purchase including the session of the purchase'
RETURNS BIGINT DETERMINISTIC
READS SQL DATA	

BEGIN
DECLARE _SUM BIGINT;
SELECT 
SUM(Vw_Sessions_Data.time_to_complete) INTO _SUM
FROM Vw_Sessions_Data
WHERE Vw_Sessions_Data.date_start_u <= purchase_date AND Vw_Sessions_Data.user_id = ID;
RETURN _SUM;
END;

-- select SessCount(4795,  1387209249) as ABC

DROP FUNCTION IF EXISTS OfertyClick;
CREATE FUNCTION OfertyClick (ID BIGINT, SessId BIGINT) 
-- COMMENT 'Returns count of sessions that the user has started before making his first purchase including the session of the purchase'
RETURNS BIGINT DETERMINISTIC
READS SQL DATA	

BEGIN
DECLARE _SUM BIGINT;
SELECT 
Vw_Sessions_Data.oferty_opened INTO _SUM
FROM Vw_Sessions_Data
WHERE Vw_Sessions_Data.id = SessId AND Vw_Sessions_Data.user_id = ID;
RETURN _SUM;
END;

DROP FUNCTION IF EXISTS CessionClick;
CREATE FUNCTION CessionClick (ID BIGINT, SessId BIGINT) 
-- COMMENT 'Returns count of sessions that the user has started before making his first purchase including the session of the purchase'
RETURNS BIGINT DETERMINISTIC
READS SQL DATA	

BEGIN
DECLARE _SUM BIGINT;
SELECT 
Vw_Sessions_Data.cession_opened INTO _SUM
FROM Vw_Sessions_Data
WHERE Vw_Sessions_Data.id = SessId AND Vw_Sessions_Data.user_id = ID;
RETURN _SUM;
END;