
SET @COHORT = '2013-5';
SET @YE = 2013;
SET @MaxCount = 18
-- SET @MO = 3;
; 
DROP TABLE IF EXISTS Cohort_Issued18;
CREATE TABLE IF NOT EXISTS Cohort_Issued18(
loan_num INT,
Jan INT, Feb INT, Mar INT, Apr INT, May INT, Jun INT, 
Jul INT, Aug INT, Sep INT, Oct INT, Nov INT, Dece INT
)
;
INSERT INTO Cohort_Issued18 (loan_num) VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18)
;
UPDATE Cohort_Issued18,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 1
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued18.Jan = SubQ.Sum
WHERE Cohort_Issued18.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued18,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 2
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued18.Feb = SubQ.Sum
WHERE Cohort_Issued18.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued18,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 3
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued18.Mar = SubQ.Sum
WHERE Cohort_Issued18.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued18,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 4
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued18.Apr = SubQ.Sum
WHERE Cohort_Issued18.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued18,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 5
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued18.May = SubQ.Sum
WHERE Cohort_Issued18.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued18,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 6
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued18.Jun = SubQ.Sum
WHERE Cohort_Issued18.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued18,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 7
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued18.Jul = SubQ.Sum
WHERE Cohort_Issued18.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued18,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 8
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued18.Aug = SubQ.Sum
WHERE Cohort_Issued18.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued18,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 9
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued18.Sep = SubQ.Sum
WHERE Cohort_Issued18.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued18,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 10
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued18.Oct = SubQ.Sum
WHERE Cohort_Issued18.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued18,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 11
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued18.Nov = SubQ.Sum
WHERE Cohort_Issued18.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued18,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 12
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued18.Dece = SubQ.Sum
WHERE Cohort_Issued18.loan_num = SubQ.Loan_Number18
;
DROP TABLE IF EXISTS Cohort_Issued18_Count;
CREATE TABLE IF NOT EXISTS Cohort_Issued18_Count(
loan_num INT,
Jan INT, Feb INT, Mar INT, Apr INT, May INT, Jun INT, 
Jul INT, Aug INT, Sep INT, Oct INT, Nov INT, Dece INT
)
;
INSERT INTO Cohort_Issued18_Count (loan_num) VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18)
;
UPDATE Cohort_Issued18_Count,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	COUNT(Vw_Loans_Issued_two.Credit_Id)AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 1
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued18_Count.Jan = SubQ.Sum
WHERE Cohort_Issued18_Count.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued18_Count,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	COUNT(Vw_Loans_Issued_two.Credit_Id)AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 2
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued18_Count.Feb = SubQ.Sum
WHERE Cohort_Issued18_Count.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued18_Count,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	COUNT(Vw_Loans_Issued_two.Credit_Id)AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 3
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued18_Count.Mar = SubQ.Sum
WHERE Cohort_Issued18_Count.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued18_Count,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	COUNT(Vw_Loans_Issued_two.Credit_Id)AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 4
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued18_Count.Apr = SubQ.Sum
WHERE Cohort_Issued18_Count.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued18_Count,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	COUNT(Vw_Loans_Issued_two.Credit_Id)AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 5
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued18_Count.May = SubQ.Sum
WHERE Cohort_Issued18_Count.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued18_Count,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	COUNT(Vw_Loans_Issued_two.Credit_Id)AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 6
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued18_Count.Jun = SubQ.Sum
WHERE Cohort_Issued18_Count.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued18_Count,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	COUNT(Vw_Loans_Issued_two.Credit_Id)AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 7
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued18_Count.Jul = SubQ.Sum
WHERE Cohort_Issued18_Count.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued18_Count,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	COUNT(Vw_Loans_Issued_two.Credit_Id)AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 8
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued18_Count.Aug = SubQ.Sum
WHERE Cohort_Issued18_Count.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued18_Count,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	COUNT(Vw_Loans_Issued_two.Credit_Id)AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 9
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued18_Count.Sep = SubQ.Sum
WHERE Cohort_Issued18_Count.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued18_Count,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	COUNT(Vw_Loans_Issued_two.Credit_Id)AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 10
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued18_Count.Oct = SubQ.Sum
WHERE Cohort_Issued18_Count.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued18_Count,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	COUNT(Vw_Loans_Issued_two.Credit_Id)AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 11
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued18_Count.Nov = SubQ.Sum
WHERE Cohort_Issued18_Count.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued18_Count,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	COUNT(Vw_Loans_Issued_two.Credit_Id)AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 12
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued18_Count.Dece = SubQ.Sum
WHERE Cohort_Issued18_Count.loan_num = SubQ.Loan_Number18
;
DROP TABLE IF EXISTS Cohort_Paid18;
CREATE TABLE IF NOT EXISTS Cohort_Paid18(
loan_num INT,
Jan INT, Feb INT, Mar INT, Apr INT, May INT, Jun INT, 
Jul INT, Aug INT, Sep INT, Oct INT, Nov INT, Dece INT
)
;
INSERT INTO Cohort_Paid18 (loan_num) VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18)
;
UPDATE Cohort_Paid18,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	sum(`credit_operations`.`amount`) AS Sum
FROM 
	credit_operations
LEFT OUTER JOIN 
	Vw_Loans_Issued_two on Vw_Loans_Issued_two.Credit_Id = credit_operations.credit_id
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 3)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 1)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid18.Jan = SubQ.Sum
WHERE Cohort_Paid18.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid18,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	sum(`credit_operations`.`amount`) AS Sum
FROM 
	credit_operations
LEFT OUTER JOIN 
	Vw_Loans_Issued_two on Vw_Loans_Issued_two.Credit_Id = credit_operations.credit_id
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 3)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 2)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid18.Feb = SubQ.Sum
WHERE Cohort_Paid18.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid18,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	sum(`credit_operations`.`amount`) AS Sum
FROM 
	credit_operations
LEFT OUTER JOIN 
	Vw_Loans_Issued_two on Vw_Loans_Issued_two.Credit_Id = credit_operations.credit_id
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE  
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 3)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 3)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid18.Mar = SubQ.Sum
WHERE Cohort_Paid18.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid18,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	sum(`credit_operations`.`amount`) AS Sum
FROM 
	credit_operations
LEFT OUTER JOIN 
	Vw_Loans_Issued_two on Vw_Loans_Issued_two.Credit_Id = credit_operations.credit_id
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 3)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 4)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid18.Apr = SubQ.Sum
WHERE Cohort_Paid18.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid18,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	sum(`credit_operations`.`amount`) AS Sum
FROM 
	credit_operations
LEFT OUTER JOIN 
	Vw_Loans_Issued_two on Vw_Loans_Issued_two.Credit_Id = credit_operations.credit_id
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE  
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 3)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 5)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid18.May = SubQ.Sum
WHERE Cohort_Paid18.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid18,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	sum(`credit_operations`.`amount`) AS Sum
FROM 
	credit_operations
LEFT OUTER JOIN 
	Vw_Loans_Issued_two on Vw_Loans_Issued_two.Credit_Id = credit_operations.credit_id
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 3)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 6)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid18.Jun = SubQ.Sum
WHERE Cohort_Paid18.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid18,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	sum(`credit_operations`.`amount`) AS Sum
FROM 
	credit_operations
LEFT OUTER JOIN 
	Vw_Loans_Issued_two on Vw_Loans_Issued_two.Credit_Id = credit_operations.credit_id
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 3)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 7)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid18.Jul = SubQ.Sum
WHERE Cohort_Paid18.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid18,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	sum(`credit_operations`.`amount`) AS Sum
FROM 
	credit_operations
LEFT OUTER JOIN 
	Vw_Loans_Issued_two on Vw_Loans_Issued_two.Credit_Id = credit_operations.credit_id
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 3)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 8)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid18.Aug = SubQ.Sum
WHERE Cohort_Paid18.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid18,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	sum(`credit_operations`.`amount`) AS Sum
FROM 
	credit_operations
LEFT OUTER JOIN 
	Vw_Loans_Issued_two on Vw_Loans_Issued_two.Credit_Id = credit_operations.credit_id
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 3)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 9)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid18.Sep = SubQ.Sum
WHERE Cohort_Paid18.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid18,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	sum(`credit_operations`.`amount`) AS Sum
FROM 
	credit_operations
LEFT OUTER JOIN 
	Vw_Loans_Issued_two on Vw_Loans_Issued_two.Credit_Id = credit_operations.credit_id
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 3)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 10)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid18.Oct = SubQ.Sum
WHERE Cohort_Paid18.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid18,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	sum(`credit_operations`.`amount`) AS Sum
FROM 
	credit_operations
LEFT OUTER JOIN 
	Vw_Loans_Issued_two on Vw_Loans_Issued_two.Credit_Id = credit_operations.credit_id
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 3)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 11)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid18.Nov = SubQ.Sum
WHERE Cohort_Paid18.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid18,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	sum(`credit_operations`.`amount`) AS Sum
FROM 
	credit_operations
LEFT OUTER JOIN 
	Vw_Loans_Issued_two on Vw_Loans_Issued_two.Credit_Id = credit_operations.credit_id
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 3)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 12)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid18.Dece = SubQ.Sum
WHERE Cohort_Paid18.loan_num = SubQ.Loan_Number18
;
DROP TABLE IF EXISTS Cohort_Paid18_Int;
CREATE TABLE IF NOT EXISTS Cohort_Paid18_Int(
loan_num INT,
Jan INT, Feb INT, Mar INT, Apr INT, May INT, Jun INT, 
Jul INT, Aug INT, Sep INT, Oct INT, Nov INT, Dece INT
)
;
INSERT INTO Cohort_Paid18_Int (loan_num) VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18)
;
UPDATE Cohort_Paid18_Int,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	sum(`credit_operations`.`amount`) AS Sum
FROM 
	credit_operations
LEFT OUTER JOIN 
	Vw_Loans_Issued_two on Vw_Loans_Issued_two.Credit_Id = credit_operations.credit_id
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 4)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 1)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid18_Int.Jan = SubQ.Sum
WHERE Cohort_Paid18_Int.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid18_Int,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	sum(`credit_operations`.`amount`) AS Sum
FROM 
	credit_operations
LEFT OUTER JOIN 
	Vw_Loans_Issued_two on Vw_Loans_Issued_two.Credit_Id = credit_operations.credit_id
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 4)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 2)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid18_Int.Feb = SubQ.Sum
WHERE Cohort_Paid18_Int.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid18_Int,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	sum(`credit_operations`.`amount`) AS Sum
FROM 
	credit_operations
LEFT OUTER JOIN 
	Vw_Loans_Issued_two on Vw_Loans_Issued_two.Credit_Id = credit_operations.credit_id
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 4)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 3)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid18_Int.Mar = SubQ.Sum
WHERE Cohort_Paid18_Int.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid18_Int,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	sum(`credit_operations`.`amount`) AS Sum
FROM 
	credit_operations
LEFT OUTER JOIN 
	Vw_Loans_Issued_two on Vw_Loans_Issued_two.Credit_Id = credit_operations.credit_id
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 4)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 4)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid18_Int.Apr = SubQ.Sum
WHERE Cohort_Paid18_Int.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid18_Int,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	sum(`credit_operations`.`amount`) AS Sum
FROM 
	credit_operations
LEFT OUTER JOIN 
	Vw_Loans_Issued_two on Vw_Loans_Issued_two.Credit_Id = credit_operations.credit_id
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 4)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 5)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid18_Int.May = SubQ.Sum
WHERE Cohort_Paid18_Int.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid18_Int,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	sum(`credit_operations`.`amount`) AS Sum
FROM 
	credit_operations
LEFT OUTER JOIN 
	Vw_Loans_Issued_two on Vw_Loans_Issued_two.Credit_Id = credit_operations.credit_id
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 4)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 6)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid18_Int.Jun = SubQ.Sum
WHERE Cohort_Paid18_Int.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid18_Int,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	sum(`credit_operations`.`amount`) AS Sum
FROM 
	credit_operations
LEFT OUTER JOIN 
	Vw_Loans_Issued_two on Vw_Loans_Issued_two.Credit_Id = credit_operations.credit_id
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 4)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 7)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid18_Int.Jul = SubQ.Sum
WHERE Cohort_Paid18_Int.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid18_Int,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	sum(`credit_operations`.`amount`) AS Sum
FROM 
	credit_operations
LEFT OUTER JOIN 
	Vw_Loans_Issued_two on Vw_Loans_Issued_two.Credit_Id = credit_operations.credit_id
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 4)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 8)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid18_Int.Aug = SubQ.Sum
WHERE Cohort_Paid18_Int.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid18_Int,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	sum(`credit_operations`.`amount`) AS Sum
FROM 
	credit_operations
LEFT OUTER JOIN 
	Vw_Loans_Issued_two on Vw_Loans_Issued_two.Credit_Id = credit_operations.credit_id
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 4)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 9)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid18_Int.Sep = SubQ.Sum
WHERE Cohort_Paid18_Int.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid18_Int,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	sum(`credit_operations`.`amount`) AS Sum
FROM 
	credit_operations
LEFT OUTER JOIN 
	Vw_Loans_Issued_two on Vw_Loans_Issued_two.Credit_Id = credit_operations.credit_id
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 4)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 10)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid18_Int.Oct = SubQ.Sum
WHERE Cohort_Paid18_Int.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid18_Int,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	sum(`credit_operations`.`amount`) AS Sum
FROM 
	credit_operations
LEFT OUTER JOIN 
	Vw_Loans_Issued_two on Vw_Loans_Issued_two.Credit_Id = credit_operations.credit_id
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 4)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 11)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid18_Int.Nov = SubQ.Sum
WHERE Cohort_Paid18_Int.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid18_Int,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	sum(`credit_operations`.`amount`) AS Sum
FROM 
	credit_operations
LEFT OUTER JOIN 
	Vw_Loans_Issued_two on Vw_Loans_Issued_two.Credit_Id = credit_operations.credit_id
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 4)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 12)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid18_Int.Dece = SubQ.Sum
WHERE Cohort_Paid18_Int.loan_num = SubQ.Loan_Number18
;
SELECT * from Cohort_Issued18;
SELECT * from Cohort_Issued18_Count;
SELECT * from Cohort_Paid18;
SELECT * from Cohort_Paid18_Int;

