
SET @YE = 2013;
SET @YE2 = 2014;

DROP TABLE IF EXISTS Cohort_Churn;
CREATE TABLE IF NOT EXISTS Cohort_Churn(
Cohort INT, Usr_Count INT,
Month_1 FLOAT, Month_2 FLOAT, Month_3 FLOAT, Month_4 FLOAT, Month_5 FLOAT, Month_6 FLOAT, 
Month_7 FLOAT, Month_8 FLOAT, Month_9 FLOAT, Month_10 FLOAT, Month_11 FLOAT, Month_12 FLOAT, 
Month_13 FLOAT, Month_14 FLOAT, Month_15 FLOAT, Month_16 FLOAT, Month_17 FLOAT, Month_18 FLOAT,
 Month_19 FLOAT, Month_20 FLOAT, Month_21 FLOAT, Month_22 FLOAT, Month_23 FLOAT, Month_24 FLOAT
)
; 																							-- CHAGE "2013" and "2014" IN VALUES BELOW TO YEARS IN VARIABLES @YE AND @YE2 --
INSERT INTO Cohort_Churn (Cohort) VALUES (20131),(20132),(20133),(20134),(20135),(20136),(20137),(20138),(20139),(201310),(201311),(201312),
																				 (20141),(20142),(20143),(20144),(20145),(20146),(20147),(20148),(20149),(201410),(201411),(201412);
UPDATE Cohort_Churn,
(SELECT 
	Vw_Users_Loans.Cohort as Cohort,
	COUNT(Vw_Users_Loans.User_Id) AS Count_
FROM 
	Vw_Users_Loans
WHERE
	Vw_Users_Loans.Shop_Id NOT IN (10009, 10010)
	AND YEAR(Vw_Users_Loans.Date_First_Loan) = @YE
GROUP BY Vw_Users_Loans.Cohort
) as SubQ
SET Cohort_Churn.Usr_Count = SubQ.Count_
WHERE Cohort_Churn.Cohort = SubQ.Cohort
;
UPDATE Cohort_Churn,
(SELECT 
	Vw_Users_Loans.Cohort as Cohort,
	COUNT(Vw_Users_Loans.User_Id) AS Count_
FROM 
	Vw_Users_Loans
WHERE
	Vw_Users_Loans.Shop_Id NOT IN (10009, 10010)
	AND YEAR(Vw_Users_Loans.Date_First_Loan) = @YE2
GROUP BY Vw_Users_Loans.Cohort
) as SubQ
SET Cohort_Churn.Usr_Count = SubQ.Count_
WHERE Cohort_Churn.Cohort = SubQ.Cohort
;
UPDATE Cohort_Churn,
(SELECT 
	Vw_Users_Loans.Cohort as Cohort,
	(COUNT(DISTINCT Vw_Loans_Issued_two.User_Id) / Cohort_Churn.Usr_Count) AS Count_
FROM 
	Vw_Users_Loans
	LEFT OUTER JOIN Vw_Loans_Issued_two on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
	LEFT OUTER JOIN Cohort_Churn on Vw_Users_Loans.Cohort = Cohort_Churn.Cohort
WHERE
	Vw_Users_Loans.Shop_Id NOT IN (10009, 10010)
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 2
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
GROUP BY Vw_Users_Loans.Cohort
) as SubQ
SET Cohort_Churn.Month_2 = SubQ.Count_
WHERE Cohort_Churn.Cohort = SubQ.Cohort
;
UPDATE Cohort_Churn,
(SELECT 
	Vw_Users_Loans.Cohort as Cohort,
	(COUNT(DISTINCT Vw_Loans_Issued_two.User_Id) / Cohort_Churn.Usr_Count) AS Count_
FROM 
	Vw_Users_Loans
	LEFT OUTER JOIN Vw_Loans_Issued_two on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
	LEFT OUTER JOIN Cohort_Churn on Vw_Users_Loans.Cohort = Cohort_Churn.Cohort
WHERE
	Vw_Users_Loans.Shop_Id NOT IN (10009, 10010)
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 3
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
GROUP BY Vw_Users_Loans.Cohort
) as SubQ
SET Cohort_Churn.Month_3 = SubQ.Count_
WHERE Cohort_Churn.Cohort = SubQ.Cohort
;
UPDATE Cohort_Churn,
(SELECT 
	Vw_Users_Loans.Cohort as Cohort,
	(COUNT(DISTINCT Vw_Loans_Issued_two.User_Id) / Cohort_Churn.Usr_Count) AS Count_
FROM 
	Vw_Users_Loans
	LEFT OUTER JOIN Vw_Loans_Issued_two on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
	LEFT OUTER JOIN Cohort_Churn on Vw_Users_Loans.Cohort = Cohort_Churn.Cohort
WHERE
	Vw_Users_Loans.Shop_Id NOT IN (10009, 10010)
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 4
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
GROUP BY Vw_Users_Loans.Cohort
) as SubQ
SET Cohort_Churn.Month_4 = SubQ.Count_
WHERE Cohort_Churn.Cohort = SubQ.Cohort
;
UPDATE Cohort_Churn,
(SELECT 
	Vw_Users_Loans.Cohort as Cohort,
	(COUNT(DISTINCT Vw_Loans_Issued_two.User_Id) / Cohort_Churn.Usr_Count) AS Count_
FROM 
	Vw_Users_Loans
	LEFT OUTER JOIN Vw_Loans_Issued_two on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
	LEFT OUTER JOIN Cohort_Churn on Vw_Users_Loans.Cohort = Cohort_Churn.Cohort
WHERE
	Vw_Users_Loans.Shop_Id NOT IN (10009, 10010)
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 5
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
GROUP BY Vw_Users_Loans.Cohort
) as SubQ
SET Cohort_Churn.Month_5 = SubQ.Count_
WHERE Cohort_Churn.Cohort = SubQ.Cohort
;
UPDATE Cohort_Churn,
(SELECT 
	Vw_Users_Loans.Cohort as Cohort,
	(COUNT(DISTINCT Vw_Loans_Issued_two.User_Id) / Cohort_Churn.Usr_Count) AS Count_
FROM 
	Vw_Users_Loans
	LEFT OUTER JOIN Vw_Loans_Issued_two on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
	LEFT OUTER JOIN Cohort_Churn on Vw_Users_Loans.Cohort = Cohort_Churn.Cohort
WHERE
	Vw_Users_Loans.Shop_Id NOT IN (10009, 10010)
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 6
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
GROUP BY Vw_Users_Loans.Cohort
) as SubQ
SET Cohort_Churn.Month_6 = SubQ.Count_
WHERE Cohort_Churn.Cohort = SubQ.Cohort
;
UPDATE Cohort_Churn,
(SELECT 
	Vw_Users_Loans.Cohort as Cohort,
	(COUNT(DISTINCT Vw_Loans_Issued_two.User_Id) / Cohort_Churn.Usr_Count) AS Count_
FROM 
	Vw_Users_Loans
	LEFT OUTER JOIN Vw_Loans_Issued_two on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
	LEFT OUTER JOIN Cohort_Churn on Vw_Users_Loans.Cohort = Cohort_Churn.Cohort
WHERE
	Vw_Users_Loans.Shop_Id NOT IN (10009, 10010)
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 7
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
GROUP BY Vw_Users_Loans.Cohort
) as SubQ
SET Cohort_Churn.Month_7 = SubQ.Count_
WHERE Cohort_Churn.Cohort = SubQ.Cohort
;
UPDATE Cohort_Churn,
(SELECT 
	Vw_Users_Loans.Cohort as Cohort,
	(COUNT(DISTINCT Vw_Loans_Issued_two.User_Id) / Cohort_Churn.Usr_Count) AS Count_
FROM 
	Vw_Users_Loans
	LEFT OUTER JOIN Vw_Loans_Issued_two on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
	LEFT OUTER JOIN Cohort_Churn on Vw_Users_Loans.Cohort = Cohort_Churn.Cohort
WHERE
	Vw_Users_Loans.Shop_Id NOT IN (10009, 10010)
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 8
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
GROUP BY Vw_Users_Loans.Cohort
) as SubQ
SET Cohort_Churn.Month_8 = SubQ.Count_
WHERE Cohort_Churn.Cohort = SubQ.Cohort
;
UPDATE Cohort_Churn,
(SELECT 
	Vw_Users_Loans.Cohort as Cohort,
	(COUNT(DISTINCT Vw_Loans_Issued_two.User_Id) / Cohort_Churn.Usr_Count) AS Count_
FROM 
	Vw_Users_Loans
	LEFT OUTER JOIN Vw_Loans_Issued_two on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
	LEFT OUTER JOIN Cohort_Churn on Vw_Users_Loans.Cohort = Cohort_Churn.Cohort
WHERE
	Vw_Users_Loans.Shop_Id NOT IN (10009, 10010)
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 9
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
GROUP BY Vw_Users_Loans.Cohort
) as SubQ
SET Cohort_Churn.Month_9 = SubQ.Count_
WHERE Cohort_Churn.Cohort = SubQ.Cohort
;
UPDATE Cohort_Churn,
(SELECT 
	Vw_Users_Loans.Cohort as Cohort,
	(COUNT(DISTINCT Vw_Loans_Issued_two.User_Id) / Cohort_Churn.Usr_Count) AS Count_
FROM 
	Vw_Users_Loans
	LEFT OUTER JOIN Vw_Loans_Issued_two on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
	LEFT OUTER JOIN Cohort_Churn on Vw_Users_Loans.Cohort = Cohort_Churn.Cohort
WHERE
	Vw_Users_Loans.Shop_Id NOT IN (10009, 10010)
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 10
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
GROUP BY Vw_Users_Loans.Cohort
) as SubQ
SET Cohort_Churn.Month_10 = SubQ.Count_
WHERE Cohort_Churn.Cohort = SubQ.Cohort
;
UPDATE Cohort_Churn,
(SELECT 
	Vw_Users_Loans.Cohort as Cohort,
	(COUNT(DISTINCT Vw_Loans_Issued_two.User_Id) / Cohort_Churn.Usr_Count) AS Count_
FROM 
	Vw_Users_Loans
	LEFT OUTER JOIN Vw_Loans_Issued_two on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
	LEFT OUTER JOIN Cohort_Churn on Vw_Users_Loans.Cohort = Cohort_Churn.Cohort
WHERE
	Vw_Users_Loans.Shop_Id NOT IN (10009, 10010)
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 11
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
GROUP BY Vw_Users_Loans.Cohort
) as SubQ
SET Cohort_Churn.Month_11 = SubQ.Count_
WHERE Cohort_Churn.Cohort = SubQ.Cohort
;
UPDATE Cohort_Churn,
(SELECT 
	Vw_Users_Loans.Cohort as Cohort,
	(COUNT(DISTINCT Vw_Loans_Issued_two.User_Id) / Cohort_Churn.Usr_Count) AS Count_
FROM 
	Vw_Users_Loans
	LEFT OUTER JOIN Vw_Loans_Issued_two on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
	LEFT OUTER JOIN Cohort_Churn on Vw_Users_Loans.Cohort = Cohort_Churn.Cohort
WHERE
	Vw_Users_Loans.Shop_Id NOT IN (10009, 10010)
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 12
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE
GROUP BY Vw_Users_Loans.Cohort
) as SubQ
SET Cohort_Churn.Month_12 = SubQ.Count_
WHERE Cohort_Churn.Cohort = SubQ.Cohort
;
UPDATE Cohort_Churn,
(SELECT 
	Vw_Users_Loans.Cohort as Cohort,
	(COUNT(DISTINCT Vw_Loans_Issued_two.User_Id) / Cohort_Churn.Usr_Count) AS Count_
FROM 
	Vw_Users_Loans
	LEFT OUTER JOIN Vw_Loans_Issued_two on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
	LEFT OUTER JOIN Cohort_Churn on Vw_Users_Loans.Cohort = Cohort_Churn.Cohort
WHERE
	Vw_Users_Loans.Shop_Id NOT IN (10009, 10010)
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 1
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE2
GROUP BY Vw_Users_Loans.Cohort
) as SubQ
SET Cohort_Churn.Month_13 = SubQ.Count_
WHERE Cohort_Churn.Cohort = SubQ.Cohort
;
UPDATE Cohort_Churn,
(SELECT 
	Vw_Users_Loans.Cohort as Cohort,
	(COUNT(DISTINCT Vw_Loans_Issued_two.User_Id) / Cohort_Churn.Usr_Count) AS Count_
FROM 
	Vw_Users_Loans
	LEFT OUTER JOIN Vw_Loans_Issued_two on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
	LEFT OUTER JOIN Cohort_Churn on Vw_Users_Loans.Cohort = Cohort_Churn.Cohort
WHERE
	Vw_Users_Loans.Shop_Id NOT IN (10009, 10010)
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 2
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE2
GROUP BY Vw_Users_Loans.Cohort
) as SubQ
SET Cohort_Churn.Month_14 = SubQ.Count_
WHERE Cohort_Churn.Cohort = SubQ.Cohort
;
UPDATE Cohort_Churn,
(SELECT 
	Vw_Users_Loans.Cohort as Cohort,
	(COUNT(DISTINCT Vw_Loans_Issued_two.User_Id) / Cohort_Churn.Usr_Count) AS Count_
FROM 
	Vw_Users_Loans
	LEFT OUTER JOIN Vw_Loans_Issued_two on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
	LEFT OUTER JOIN Cohort_Churn on Vw_Users_Loans.Cohort = Cohort_Churn.Cohort
WHERE
	Vw_Users_Loans.Shop_Id NOT IN (10009, 10010)
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 3
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE2
GROUP BY Vw_Users_Loans.Cohort
) as SubQ
SET Cohort_Churn.Month_15 = SubQ.Count_
WHERE Cohort_Churn.Cohort = SubQ.Cohort
;

UPDATE Cohort_Churn,
(SELECT 
	Vw_Users_Loans.Cohort as Cohort,
	(COUNT(DISTINCT Vw_Loans_Issued_two.User_Id) / Cohort_Churn.Usr_Count) AS Count_
FROM 
	Vw_Users_Loans
	LEFT OUTER JOIN Vw_Loans_Issued_two on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
	LEFT OUTER JOIN Cohort_Churn on Vw_Users_Loans.Cohort = Cohort_Churn.Cohort
WHERE
	Vw_Users_Loans.Shop_Id NOT IN (10009, 10010)
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 4
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE2
GROUP BY Vw_Users_Loans.Cohort
) as SubQ
SET Cohort_Churn.Month_16 = SubQ.Count_
WHERE Cohort_Churn.Cohort = SubQ.Cohort


;
UPDATE Cohort_Churn,
(SELECT 
	Vw_Users_Loans.Cohort as Cohort,
	(COUNT(DISTINCT Vw_Loans_Issued_two.User_Id) / Cohort_Churn.Usr_Count) AS Count_
FROM 
	Vw_Users_Loans
	LEFT OUTER JOIN Vw_Loans_Issued_two on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
	LEFT OUTER JOIN Cohort_Churn on Vw_Users_Loans.Cohort = Cohort_Churn.Cohort
WHERE
	Vw_Users_Loans.Shop_Id NOT IN (10009, 10010)
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 5
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE2
GROUP BY Vw_Users_Loans.Cohort
) as SubQ
SET Cohort_Churn.Month_17 = SubQ.Count_
WHERE Cohort_Churn.Cohort = SubQ.Cohort
;
UPDATE Cohort_Churn,
(SELECT 
	Vw_Users_Loans.Cohort as Cohort,
	(COUNT(DISTINCT Vw_Loans_Issued_two.User_Id) / Cohort_Churn.Usr_Count) AS Count_
FROM 
	Vw_Users_Loans
	LEFT OUTER JOIN Vw_Loans_Issued_two on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
	LEFT OUTER JOIN Cohort_Churn on Vw_Users_Loans.Cohort = Cohort_Churn.Cohort
WHERE
	Vw_Users_Loans.Shop_Id NOT IN (10009, 10010)
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 6
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE2
GROUP BY Vw_Users_Loans.Cohort
) as SubQ
SET Cohort_Churn.Month_18 = SubQ.Count_
WHERE Cohort_Churn.Cohort = SubQ.Cohort
;
UPDATE Cohort_Churn,
(SELECT 
	Vw_Users_Loans.Cohort as Cohort,
	(COUNT(DISTINCT Vw_Loans_Issued_two.User_Id) / Cohort_Churn.Usr_Count) AS Count_
FROM 
	Vw_Users_Loans
	LEFT OUTER JOIN Vw_Loans_Issued_two on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
	LEFT OUTER JOIN Cohort_Churn on Vw_Users_Loans.Cohort = Cohort_Churn.Cohort
WHERE
	Vw_Users_Loans.Shop_Id NOT IN (10009, 10010)
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 7
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE2
GROUP BY Vw_Users_Loans.Cohort
) as SubQ
SET Cohort_Churn.Month_19 = SubQ.Count_
WHERE Cohort_Churn.Cohort = SubQ.Cohort
;
UPDATE Cohort_Churn,
(SELECT 
	Vw_Users_Loans.Cohort as Cohort,
	(COUNT(DISTINCT Vw_Loans_Issued_two.User_Id) / Cohort_Churn.Usr_Count) AS Count_
FROM 
	Vw_Users_Loans
	LEFT OUTER JOIN Vw_Loans_Issued_two on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
	LEFT OUTER JOIN Cohort_Churn on Vw_Users_Loans.Cohort = Cohort_Churn.Cohort
WHERE
	Vw_Users_Loans.Shop_Id NOT IN (10009, 10010)
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 8
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE2
GROUP BY Vw_Users_Loans.Cohort
) as SubQ
SET Cohort_Churn.Month_20 = SubQ.Count_
WHERE Cohort_Churn.Cohort = SubQ.Cohort
;
UPDATE Cohort_Churn,
(SELECT 
	Vw_Users_Loans.Cohort as Cohort,
	(COUNT(DISTINCT Vw_Loans_Issued_two.User_Id) / Cohort_Churn.Usr_Count) AS Count_
FROM 
	Vw_Users_Loans
	LEFT OUTER JOIN Vw_Loans_Issued_two on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
	LEFT OUTER JOIN Cohort_Churn on Vw_Users_Loans.Cohort = Cohort_Churn.Cohort
WHERE
	Vw_Users_Loans.Shop_Id NOT IN (10009, 10010)
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 9
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE2
GROUP BY Vw_Users_Loans.Cohort
) as SubQ
SET Cohort_Churn.Month_21 = SubQ.Count_
WHERE Cohort_Churn.Cohort = SubQ.Cohort
;
UPDATE Cohort_Churn,
(SELECT 
	Vw_Users_Loans.Cohort as Cohort,
	(COUNT(DISTINCT Vw_Loans_Issued_two.User_Id) / Cohort_Churn.Usr_Count) AS Count_
FROM 
	Vw_Users_Loans
	LEFT OUTER JOIN Vw_Loans_Issued_two on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
	LEFT OUTER JOIN Cohort_Churn on Vw_Users_Loans.Cohort = Cohort_Churn.Cohort
WHERE
	Vw_Users_Loans.Shop_Id NOT IN (10009, 10010)
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 10
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE2
GROUP BY Vw_Users_Loans.Cohort
) as SubQ
SET Cohort_Churn.Month_22 = SubQ.Count_
WHERE Cohort_Churn.Cohort = SubQ.Cohort
;
UPDATE Cohort_Churn,
(SELECT 
	Vw_Users_Loans.Cohort as Cohort,
	(COUNT(DISTINCT Vw_Loans_Issued_two.User_Id) / Cohort_Churn.Usr_Count) AS Count_
FROM 
	Vw_Users_Loans
	LEFT OUTER JOIN Vw_Loans_Issued_two on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
	LEFT OUTER JOIN Cohort_Churn on Vw_Users_Loans.Cohort = Cohort_Churn.Cohort
WHERE
	Vw_Users_Loans.Shop_Id NOT IN (10009, 10010)
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 11
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE2
GROUP BY Vw_Users_Loans.Cohort
) as SubQ
SET Cohort_Churn.Month_23 = SubQ.Count_
WHERE Cohort_Churn.Cohort = SubQ.Cohort
;
UPDATE Cohort_Churn,
(SELECT 
	Vw_Users_Loans.Cohort as Cohort,
	(COUNT(DISTINCT Vw_Loans_Issued_two.User_Id) / Cohort_Churn.Usr_Count) AS Count_
FROM 
	Vw_Users_Loans
	LEFT OUTER JOIN Vw_Loans_Issued_two on Vw_Loans_Issued_two.User_Id = Vw_Users_Loans.User_Id
	LEFT OUTER JOIN Cohort_Churn on Vw_Users_Loans.Cohort = Cohort_Churn.Cohort
WHERE
	Vw_Users_Loans.Shop_Id NOT IN (10009, 10010)
	AND MONTH(Vw_Loans_Issued_two.Date_Create) = 12
	AND YEAR(Vw_Loans_Issued_two.Date_Create) = @YE2
GROUP BY Vw_Users_Loans.Cohort
) as SubQ
SET Cohort_Churn.Month_24 = SubQ.Count_
WHERE Cohort_Churn.Cohort = SubQ.Cohort
;

select * from Cohort_Churn