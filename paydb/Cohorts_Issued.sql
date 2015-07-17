
SET @COHORT = 201310;
SET @YE = 2013;
SET @YE2 = 2014;
SET @MaxCount = 18
-- SET @MO = 3;
; 
DROP TABLE IF EXISTS Cohort_Issued;
CREATE TABLE IF NOT EXISTS Cohort_Issued(
loan_num INT,
Jan INT, Feb INT, Mar INT, Apr INT, May INT, Jun INT, 
Jul INT, Aug INT, Sep INT, Oct INT, Nov INT, Dece INT,
Jan14 INT, Feb14 INT, Mar14 INT, Apr14 INT, May14 INT, Jun14 INT
)
;
INSERT INTO Cohort_Issued (loan_num) VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18)
;
UPDATE Cohort_Issued,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
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
SET Cohort_Issued.Jan = SubQ.Sum
WHERE Cohort_Issued.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
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
SET Cohort_Issued.Feb = SubQ.Sum
WHERE Cohort_Issued.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
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
SET Cohort_Issued.Mar = SubQ.Sum
WHERE Cohort_Issued.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
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
SET Cohort_Issued.Apr = SubQ.Sum
WHERE Cohort_Issued.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
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
SET Cohort_Issued.May = SubQ.Sum
WHERE Cohort_Issued.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
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
SET Cohort_Issued.Jun = SubQ.Sum
WHERE Cohort_Issued.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
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
SET Cohort_Issued.Jul = SubQ.Sum
WHERE Cohort_Issued.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
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
SET Cohort_Issued.Aug = SubQ.Sum
WHERE Cohort_Issued.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
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
SET Cohort_Issued.Sep = SubQ.Sum
WHERE Cohort_Issued.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
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
SET Cohort_Issued.Oct = SubQ.Sum
WHERE Cohort_Issued.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
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
SET Cohort_Issued.Nov = SubQ.Sum
WHERE Cohort_Issued.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
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
SET Cohort_Issued.Dece = SubQ.Sum
WHERE Cohort_Issued.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Issued,
(SELECT 
	Vw_Loans_Issued_two.Loan_Number18 as Loan_Number18,
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Sum
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
SET Cohort_Issued.Jan14 = SubQ.Sum
WHERE Cohort_Issued.loan_num = SubQ.Loan_Number18
;
SELECT * from Cohort_Issued

