
DROP PROCEDURE IF EXISTS Cohort_Issued_upd;
DELIMITER //
CREATE PROCEDURE Cohort_Issued_upd(
		IN COHORT INT, 
		IN YE INT)
DETERMINISTIC
MODIFIES SQL DATA
SQL SECURITY INVOKER

BEGIN
DROP TABLE IF EXISTS Chort1;
CREATE TABLE IF NOT EXISTS Chort1(
loan_num INT,
Jan INT, Feb INT, Mar INT, Apr INT, May INT, Jun INT, 
Jul INT, Aug INT, Sep INT, Oct INT, Nov INT, Dece INT, Jan14 INT
)
;
INSERT INTO Chort1 (loan_num) VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18)
;
UPDATE Chort1,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = MO
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Chort1.Mar = SubQ.Sum
WHERE Chort1.loan_num = SubQ.Loan_Number
;
END;
//
DELIMITER ;

CALL Cohort_Issued_Mar(20133,2013)
;-- ,'Chort1','Loan_Number18');

select * from Chort1
;