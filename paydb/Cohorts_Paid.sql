
SET @COHORT = 20132;
SET @YE = 2013;
SET @YE2 = 2014;
SET @MaxCount = 18;
-- SET @MO = 3;

DROP TABLE IF EXISTS Cohort_Paid;
CREATE TABLE IF NOT EXISTS Cohort_Paid(
loan_num INT,
Jan INT, Feb INT, Mar INT, Apr INT, May INT, Jun INT, 
Jul INT, Aug INT, Sep INT, Oct INT, Nov INT, Dece INT,
Jan14 INT, Feb14 INT, Mar14 INT, Apr14 INT, May14 INT, Jun14 INT
)
;
INSERT INTO Cohort_Paid (loan_num) VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18)
;
UPDATE Cohort_Paid,
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
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 3)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 1)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid.Jan = SubQ.Sum
WHERE Cohort_Paid.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid,
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
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 3)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 2)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid.Feb = SubQ.Sum
WHERE Cohort_Paid.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid,
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
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 3)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 3)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid.Mar = SubQ.Sum
WHERE Cohort_Paid.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid,
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
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 3)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 4)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid.Apr = SubQ.Sum
WHERE Cohort_Paid.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid,
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
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 3)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 5)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid.May = SubQ.Sum
WHERE Cohort_Paid.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid,
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
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 3)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 6)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid.Jun = SubQ.Sum
WHERE Cohort_Paid.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid,
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
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 3)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 7)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid.Jul = SubQ.Sum
WHERE Cohort_Paid.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid,
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
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 3)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 8)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid.Aug = SubQ.Sum
WHERE Cohort_Paid.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid,
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
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 3)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 9)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid.Sep = SubQ.Sum
WHERE Cohort_Paid.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid,
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
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 3)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 10)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid.Oct = SubQ.Sum
WHERE Cohort_Paid.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid,
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
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 3)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 11)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid.Nov = SubQ.Sum
WHERE Cohort_Paid.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid,
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
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
	AND (`credit_operations`.`type_id` = 3)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 12)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid.Dece = SubQ.Sum
WHERE Cohort_Paid.loan_num = SubQ.Loan_Number18
;
UPDATE Cohort_Paid,
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
	AND Vw_Loans_Issued_two.Loan_Number18 <= @MaxCount AND Vw_Loans_Issued_two.Shop_Id NOT IN (10010,10009)
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE2
	AND (`credit_operations`.`type_id` = 3)
	AND (MONTH(FROM_UNIXTIME(credit_operations.date_create)) = 1)
	AND (YEAR(FROM_UNIXTIME(credit_operations.date_create)) = @YE2)
GROUP BY Vw_Loans_Issued_two.Loan_Number18
) as SubQ
SET Cohort_Paid.Jan14 = SubQ.Sum
WHERE Cohort_Paid.loan_num = SubQ.Loan_Number18
;
SELECT * from Cohort_Paid

