
SET @COHORT = 201310;
SET @YE = 2013;
SET @YE2 = 2014;
SET @MaxCount = 18
-- SET @MO = 3;
; 
DROP TABLE IF EXISTS Cohort_Issued_Count;
CREATE TABLE IF NOT EXISTS Cohort_Issued_Count(
loan_num INT,
Jan INT, Feb INT, Mar INT, Apr INT, May INT, Jun INT, 
Jul INT, Aug INT, Sep INT, Oct INT, Nov INT, Dece INT,
Jan14 INT, Feb14 INT, Mar14 INT, Apr14 INT, May14 INT, Jun14 INT
)
;
INSERT INTO Cohort_Issued_Count (loan_num) VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18)
;
UPDATE Cohort_Issued_Count,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	COUNT(Vw_Loans_Issued_two.Credit_Id)AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 1
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued_Count.Jan = SubQ.Sum
WHERE Cohort_Issued_Count.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued_Count,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	COUNT(Vw_Loans_Issued_two.Credit_Id)AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 2
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued_Count.Feb = SubQ.Sum
WHERE Cohort_Issued_Count.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued_Count,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	COUNT(Vw_Loans_Issued_two.Credit_Id)AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 3
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued_Count.Mar = SubQ.Sum
WHERE Cohort_Issued_Count.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued_Count,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	COUNT(Vw_Loans_Issued_two.Credit_Id)AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 4
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued_Count.Apr = SubQ.Sum
WHERE Cohort_Issued_Count.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued_Count,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	COUNT(Vw_Loans_Issued_two.Credit_Id)AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 5
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued_Count.May = SubQ.Sum
WHERE Cohort_Issued_Count.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued_Count,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	COUNT(Vw_Loans_Issued_two.Credit_Id)AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 6
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued_Count.Jun = SubQ.Sum
WHERE Cohort_Issued_Count.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued_Count,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	COUNT(Vw_Loans_Issued_two.Credit_Id)AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 7
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued_Count.Jul = SubQ.Sum
WHERE Cohort_Issued_Count.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued_Count,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	COUNT(Vw_Loans_Issued_two.Credit_Id)AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 8
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued_Count.Aug = SubQ.Sum
WHERE Cohort_Issued_Count.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued_Count,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	COUNT(Vw_Loans_Issued_two.Credit_Id)AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 9
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued_Count.Sep = SubQ.Sum
WHERE Cohort_Issued_Count.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued_Count,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	COUNT(Vw_Loans_Issued_two.Credit_Id)AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 10
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued_Count.Oct = SubQ.Sum
WHERE Cohort_Issued_Count.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued_Count,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	COUNT(Vw_Loans_Issued_two.Credit_Id)AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 11
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued_Count.Nov = SubQ.Sum
WHERE Cohort_Issued_Count.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued_Count,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	COUNT(Vw_Loans_Issued_two.Credit_Id)AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 12
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued_Count.Dece = SubQ.Sum
WHERE Cohort_Issued_Count.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued_Count,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	COUNT(Vw_Loans_Issued_two.Credit_Id)AS Sum
FROM 
	Vw_Loans_Issued_two
LEFT OUTER JOIN 
	Vw_Users_Loans on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
WHERE 
	Vw_Users_Loans.Cohort = @COHORT 
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE2
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 1
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Issued_Count.Jan14 = SubQ.Sum
WHERE Cohort_Issued_Count.loan_num = SubQ.Loan_Number18
;
SELECT * from Cohort_Issued_Count

