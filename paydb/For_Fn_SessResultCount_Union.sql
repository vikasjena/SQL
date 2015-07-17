
DROP FUNCTION IF EXISTS SessResultCountUnion;
CREATE FUNCTION SessResultCountUnion (ID BIGINT, purchase_date BIGINT, result_text CHAR(30)) 
-- COMMENT 'Returns count of Specified Results of sessions that the user has started before making his first purchase including the session of the purchase'
RETURNS BIGINT DETERMINISTIC
READS SQL DATA	

BEGIN
DECLARE _COUNT BIGINT;
SELECT 
COUNT(Vw_Sessions_Data.id) INTO _COUNT
FROM Vw_Sessions_Data
WHERE Vw_Sessions_Data.date_start_u <= purchase_date AND Vw_Sessions_Data.union_id = ID AND Vw_Sessions_Data.result = result_text;
RETURN _COUNT;
END;

-- select SessResultCount(3575, UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan), 'first union loan_not_repaid') from Vw_Users_Loans where User_Id = 3575