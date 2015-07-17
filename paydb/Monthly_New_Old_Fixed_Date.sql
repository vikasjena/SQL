SET @DAY_1 = 1;
SET @DAY_2 = 10;
SET @DAYS_TO_PAY = 30;
-- SET @LOAN_NUM_MIN = 1;
-- SET @LOAN_NUM_MAX = 1;

SELECT
CONCAT(YEAR(Vw_Loans_Issued_two.Date_Create),' - ',MONTH(Vw_Loans_Issued_two.Date_Create) ) AS Date_,
Vw_Loans_Issued_two.Is_First AS IsFirst,
CONCAT(FORMAT((1-((SELECT SUM_BY_MONTH FROM
      (SELECT
					SUM(Vw_Loans_Issued_two.Amount_Original_Paid) as SUM_BY_MONTH,
					MONTH (Vw_Loans_Issued_two.Date_Create) as _MONTH,
					YEAR (Vw_Loans_Issued_two.Date_Create) as _YEAR,
					Vw_Loans_Issued_two.Is_First as IsFirst_
       FROM
					Vw_Loans_Issued_two
			 WHERE	
					DAY(Vw_Loans_Issued_two.Date_Create) BETWEEN @DAY_1 AND @DAY_2
					AND Vw_Loans_Issued_two.Days_To_Pay <= @DAYS_TO_PAY
-- 					AND Vw_Loans_Issued_two.Loan_Number BETWEEN @LOAN_NUM_MIN AND @LOAN_NUM_MAX
       GROUP BY
					YEAR (Vw_Loans_Issued_two.Date_Create),
					MONTH (Vw_Loans_Issued_two.Date_Create),
					Vw_Loans_Issued_two.Is_First) as temp_table
/* Условие к первому вложенному селекту */
			 WHERE _MONTH = MONTH (Vw_Loans_Issued_two.Date_Create) 
				AND _YEAR = YEAR(Vw_Loans_Issued_two.Date_Create) 
				AND IsFirst_ = Vw_Loans_Issued_two.Is_First) / SUM(Vw_Loans_Issued_two.Amount_Original)))*100,2),'%') AS Dynamic_Def,

		CONCAT(FORMAT(((sum(Vw_Loans_Issued_two.Amount_Original) - 
																																	(SELECT SUM_BY_MONTH FROM
																																		(SELECT
																																				(SUM(Vw_Loans_Issued_two.Amount_Original_Paid) + SUM(Vw_Loans_Issued_two.Interest_Paid)) as SUM_BY_MONTH,
																																				MONTH (Vw_Loans_Issued_two.Date_Create) as _MONTH,
																																				YEAR (Vw_Loans_Issued_two.Date_Create) as _YEAR,
																																				Vw_Loans_Issued_two.Is_First as IsFirst_
																																		 FROM
																																				Vw_Loans_Issued_two
																																		 WHERE	
																																				DAY(Vw_Loans_Issued_two.Date_Create) BETWEEN @DAY_1 AND @DAY_2
																																				AND Vw_Loans_Issued_two.Days_To_Pay <= @DAYS_TO_PAY
																															-- 					AND Vw_Loans_Issued_two.Loan_Number BETWEEN @LOAN_NUM_MIN AND @LOAN_NUM_MAX
																																		 GROUP BY
																																				YEAR (Vw_Loans_Issued_two.Date_Create),
																																				MONTH (Vw_Loans_Issued_two.Date_Create),
																																				Vw_Loans_Issued_two.Is_First) as temp_table
																																		/* Условие к первому вложенному селекту */
																																		 WHERE _MONTH = MONTH (Vw_Loans_Issued_two.Date_Create) 
																																			AND _YEAR = YEAR(Vw_Loans_Issued_two.Date_Create)
																																			AND IsFirst_ = Vw_Loans_Issued_two.Is_First)																									
										) / sum(Vw_Loans_Issued_two.Amount_Original))*100,2),'%') AS Margin,

		CONCAT(FORMAT((( (sum(Vw_Loans_Issued_two.Amount_To_Pay)) + 
																																		(SELECT SUM_BY_MONTH FROM
																																		(SELECT
																																				SUM(Vw_Loans_Issued_two.Operations_Cost)as SUM_BY_MONTH,
																																				MONTH (Vw_Loans_Issued_two.Date_Create) as _MONTH,
																																				YEAR (Vw_Loans_Issued_two.Date_Create) as _YEAR,
																																				Vw_Loans_Issued_two.Is_First as IsFirst_
																																		 FROM
																																				Vw_Loans_Issued_two
																																		 WHERE	
																																				DAY(Vw_Loans_Issued_two.Date_Create) BETWEEN @DAY_1 AND @DAY_2
																																				AND Vw_Loans_Issued_two.Days_To_Pay <= @DAYS_TO_PAY
																															-- 					AND Vw_Loans_Issued_two.Loan_Number BETWEEN @LOAN_NUM_MIN AND @LOAN_NUM_MAX
																																		 GROUP BY
																																				YEAR (Vw_Loans_Issued_two.Date_Create),
																																				MONTH (Vw_Loans_Issued_two.Date_Create),
																																				Vw_Loans_Issued_two.Is_First) as temp_table
																																		/* Условие к первому вложенному селекту */
																																		 WHERE _MONTH = MONTH (Vw_Loans_Issued_two.Date_Create) 
																																			AND _YEAR = YEAR(Vw_Loans_Issued_two.Date_Create)
																																			AND IsFirst_ = Vw_Loans_Issued_two.Is_First)	
																													- 
																																		(SELECT SUM_BY_MONTH FROM
																																		(SELECT
																																				(SUM(Vw_Loans_Issued_two.Amount_Original_Paid) + SUM(Vw_Loans_Issued_two.Interest_Paid)) as SUM_BY_MONTH,
																																				MONTH (Vw_Loans_Issued_two.Date_Create) as _MONTH,
																																				YEAR (Vw_Loans_Issued_two.Date_Create) as _YEAR,
																																				Vw_Loans_Issued_two.Is_First as IsFirst_
																																		 FROM
																																				Vw_Loans_Issued_two
																																		 WHERE	
																																				DAY(Vw_Loans_Issued_two.Date_Create) BETWEEN @DAY_1 AND @DAY_2
																																				AND Vw_Loans_Issued_two.Days_To_Pay <= @DAYS_TO_PAY
																															-- 					AND Vw_Loans_Issued_two.Loan_Number BETWEEN @LOAN_NUM_MIN AND @LOAN_NUM_MAX
																																		 GROUP BY
																																				YEAR (Vw_Loans_Issued_two.Date_Create),
																																				MONTH (Vw_Loans_Issued_two.Date_Create),
																																				Vw_Loans_Issued_two.Is_First) as temp_table
																																		/* Условие к первому вложенному селекту */
																																		 WHERE _MONTH = MONTH (Vw_Loans_Issued_two.Date_Create) 
																																			AND _YEAR = YEAR(Vw_Loans_Issued_two.Date_Create)
																																			AND IsFirst_ = Vw_Loans_Issued_two.Is_First)	
										) / (sum(Vw_Loans_Issued_two.Amount_To_Pay)))*100,2),'%') AS Margin_Net,

CONCAT(FORMAT((sum(Vw_Loans_Issued_two.Amount_Original) / 
		(SELECT SUM_BY_MONTH FROM
      (SELECT
					SUM(Vw_Loans_Issued_two.Amount_Original) as SUM_BY_MONTH,
					MONTH (Vw_Loans_Issued_two.Date_Create) as _MONTH,
					YEAR (Vw_Loans_Issued_two.Date_Create) as _YEAR
       FROM
					Vw_Loans_Issued_two
			 WHERE 
-- 					Vw_Loans_Issued_two.Days_To_Pay <= @DAYS_TO_PAY AND
						DAY(Vw_Loans_Issued_two.Date_Create) BETWEEN @DAY_1 AND @DAY_2
       GROUP BY
					YEAR (Vw_Loans_Issued_two.Date_Create),
					MONTH (Vw_Loans_Issued_two.Date_Create) ) as temp_table
/* Условие к первому вложенному селекту, чтобы выбирал из второго селекта только те суммы, которые относятся к месяцу и магазину, выбираемому в самом первом (верхнем) селекте. */
			 WHERE _MONTH = MONTH (Vw_Loans_Issued_two.Date_Create) 
				AND _YEAR = YEAR(Vw_Loans_Issued_two.Date_Create) 
				 ))*100, 2),'%') AS 'New/Old %',

	CONCAT(FORMAT((((SELECT SUM_BY_MONTH FROM
																																		(SELECT
																																				SUM(Vw_Loans_Issued_two.Interest_Paid)as SUM_BY_MONTH,
																																				MONTH (Vw_Loans_Issued_two.Date_Create) as _MONTH,
																																				YEAR (Vw_Loans_Issued_two.Date_Create) as _YEAR,
																																				Vw_Loans_Issued_two.Is_First as IsFirst_
																																		 FROM
																																				Vw_Loans_Issued_two
																																		 WHERE	
																																				DAY(Vw_Loans_Issued_two.Date_Create) BETWEEN @DAY_1 AND @DAY_2
																																				AND Vw_Loans_Issued_two.Days_To_Pay <= @DAYS_TO_PAY
																															-- 					AND Vw_Loans_Issued_two.Loan_Number BETWEEN @LOAN_NUM_MIN AND @LOAN_NUM_MAX
																																		 GROUP BY
																																				YEAR (Vw_Loans_Issued_two.Date_Create),
																																				MONTH (Vw_Loans_Issued_two.Date_Create),
																																				Vw_Loans_Issued_two.Is_First) as temp_table
																																		/* Условие к первому вложенному селекту */
																																		 WHERE _MONTH = MONTH (Vw_Loans_Issued_two.Date_Create) 
																																			AND _YEAR = YEAR(Vw_Loans_Issued_two.Date_Create)
																																			AND IsFirst_ = Vw_Loans_Issued_two.Is_First) / sum(Vw_Loans_Issued_two.Amount_Original)))*100,2),'%') AS 'Int_to_Body_P',
	CONCAT(FORMAT((((SELECT SUM_BY_MONTH FROM
																																		(SELECT
																																				SUM(Vw_Loans_Issued_two.Interest_Paid)as SUM_BY_MONTH,
																																				MONTH (Vw_Loans_Issued_two.Date_Create) as _MONTH,
																																				YEAR (Vw_Loans_Issued_two.Date_Create) as _YEAR,
																																				Vw_Loans_Issued_two.Is_First as IsFirst_
																																		 FROM
																																				Vw_Loans_Issued_two
																																		 WHERE	
																																				DAY(Vw_Loans_Issued_two.Date_Create) BETWEEN @DAY_1 AND @DAY_2
																																				AND Vw_Loans_Issued_two.Days_To_Pay <= @DAYS_TO_PAY
																															-- 					AND Vw_Loans_Issued_two.Loan_Number BETWEEN @LOAN_NUM_MIN AND @LOAN_NUM_MAX
																																		 GROUP BY
																																				YEAR (Vw_Loans_Issued_two.Date_Create),
																																				MONTH (Vw_Loans_Issued_two.Date_Create),
																																				Vw_Loans_Issued_two.Is_First) as temp_table
																																		/* Условие к первому вложенному селекту */
																																		 WHERE _MONTH = MONTH (Vw_Loans_Issued_two.Date_Create) 
																																			AND _YEAR = YEAR(Vw_Loans_Issued_two.Date_Create)
																																			AND IsFirst_ = Vw_Loans_Issued_two.Is_First) / sum(Vw_Loans_Issued_two.Amount_Original)))*100,2),'%') AS 'Int_to_Orig',


FORMAT(SUM(Vw_Loans_Issued_two.Amount_Original),2) AS Am_Orig,
FORMAT(SUM(Vw_Loans_Issued_two.Amount_Remaining),2) AS Am_Rem,
-- FORMAT(SUM(Accr_Int),2) AS Acc_Int,
FORMAT((SELECT SUM_BY_MONTH FROM
																																		(SELECT
																																				SUM(Vw_Loans_Issued_two.Amount_Original_Paid)as SUM_BY_MONTH,
																																				MONTH (Vw_Loans_Issued_two.Date_Create) as _MONTH,
																																				YEAR (Vw_Loans_Issued_two.Date_Create) as _YEAR,
																																				Vw_Loans_Issued_two.Is_First as IsFirst_
																																		 FROM
																																				Vw_Loans_Issued_two
																																		 WHERE	
																																				DAY(Vw_Loans_Issued_two.Date_Create) BETWEEN @DAY_1 AND @DAY_2
																																				AND Vw_Loans_Issued_two.Days_To_Pay <= @DAYS_TO_PAY
																															-- 					AND Vw_Loans_Issued_two.Loan_Number BETWEEN @LOAN_NUM_MIN AND @LOAN_NUM_MAX
																																		 GROUP BY
																																				YEAR (Vw_Loans_Issued_two.Date_Create),
																																				MONTH (Vw_Loans_Issued_two.Date_Create),
																																				Vw_Loans_Issued_two.Is_First) as temp_table
																																		/* Условие к первому вложенному селекту */
																																		 WHERE _MONTH = MONTH (Vw_Loans_Issued_two.Date_Create) 
																																			AND _YEAR = YEAR(Vw_Loans_Issued_two.Date_Create)
																																			AND IsFirst_ = Vw_Loans_Issued_two.Is_First),2) AS Paid_Orig,
FORMAT((SELECT SUM_BY_MONTH FROM
																																		(SELECT
																																				SUM(Vw_Loans_Issued_two.Interest_Paid)as SUM_BY_MONTH,
																																				MONTH (Vw_Loans_Issued_two.Date_Create) as _MONTH,
																																				YEAR (Vw_Loans_Issued_two.Date_Create) as _YEAR,
																																				Vw_Loans_Issued_two.Is_First as IsFirst_
																																		 FROM
																																				Vw_Loans_Issued_two
																																		 WHERE	
																																				DAY(Vw_Loans_Issued_two.Date_Create) BETWEEN @DAY_1 AND @DAY_2
																																				AND Vw_Loans_Issued_two.Days_To_Pay <= @DAYS_TO_PAY
																															-- 					AND Vw_Loans_Issued_two.Loan_Number BETWEEN @LOAN_NUM_MIN AND @LOAN_NUM_MAX
																																		 GROUP BY
																																				YEAR (Vw_Loans_Issued_two.Date_Create),
																																				MONTH (Vw_Loans_Issued_two.Date_Create),
																																				Vw_Loans_Issued_two.Is_First) as temp_table
																																		/* Условие к первому вложенному селекту */
																																		 WHERE _MONTH = MONTH (Vw_Loans_Issued_two.Date_Create) 
																																			AND _YEAR = YEAR(Vw_Loans_Issued_two.Date_Create)
																																			AND IsFirst_ = Vw_Loans_Issued_two.Is_First),2) AS Paid_Int,

FORMAT((SELECT SUM_BY_MONTH FROM
																																		(SELECT
																																				SUM(Vw_Loans_Issued_two.Operations_Cost)as SUM_BY_MONTH,
																																				MONTH (Vw_Loans_Issued_two.Date_Create) as _MONTH,
																																				YEAR (Vw_Loans_Issued_two.Date_Create) as _YEAR,
																																				Vw_Loans_Issued_two.Is_First as IsFirst_
																																		 FROM
																																				Vw_Loans_Issued_two
																																		 WHERE	
																																				DAY(Vw_Loans_Issued_two.Date_Create) BETWEEN @DAY_1 AND @DAY_2
																																				AND Vw_Loans_Issued_two.Days_To_Pay <= @DAYS_TO_PAY
																															-- 					AND Vw_Loans_Issued_two.Loan_Number BETWEEN @LOAN_NUM_MIN AND @LOAN_NUM_MAX
																																		 GROUP BY
																																				YEAR (Vw_Loans_Issued_two.Date_Create),
																																				MONTH (Vw_Loans_Issued_two.Date_Create),
																																				Vw_Loans_Issued_two.Is_First) as temp_table
																																		/* Условие к первому вложенному селекту */
																																		 WHERE _MONTH = MONTH (Vw_Loans_Issued_two.Date_Create) 
																																			AND _YEAR = YEAR(Vw_Loans_Issued_two.Date_Create)
																																			AND IsFirst_ = Vw_Loans_Issued_two.Is_First),2) AS PS_Comm,

	FORMAT(SUM(Vw_Loans_Issued_two.Amount_To_Pay),2) AS To_Pay,
	count(Vw_Loans_Issued_two.Credit_Id) AS credits_count,
	count(DISTINCT Vw_Loans_Issued_two.User_Id) AS users_count,
	FORMAT(count(Vw_Loans_Issued_two.Credit_Id) / count(DISTINCT Vw_Loans_Issued_two.User_Id),2) AS 'Purch.Per.Usr',
	(FORMAT((sum(Vw_Loans_Issued_two.Amount_Original) / count(DISTINCT Vw_Loans_Issued_two.User_Id)),0)) AS ARPPU,
	FORMAT((sum(Vw_Loans_Issued_two.Amount_Original) / count(Vw_Loans_Issued_two.Credit_Id)),0) AS AvgCrdAmnt,


/*
                                                             НАЧАЛО РАСЧЕТА ПО ОПЕРАЦИЯМ
*/
CASE
WHEN MONTH(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create))) >= (Month(NOW()) -1) AND YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create))) = (YEAR(NOW()))
OR MONTH(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create))) >= (Month(NOW()) +11) AND YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create))) = (YEAR(NOW()) -1)
THEN 'n/a'
ELSE
CONCAT(FORMAT(( 
(SELECT 
_AMOUNT
FROM 
(SELECT 
SUM(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,

Vw_Loans_Issued_two.Is_First AS IsFirst_,
MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH, YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
FROM Vw_Loans_Issued_two
WHERE Vw_Loans_Issued_two.`Status 30`= 'Default'
AND DAY(Vw_Loans_Issued_two.Date_Create) BETWEEN @DAY_1 AND @DAY_2
AND Vw_Loans_Issued_two.Days_To_Pay <= @DAYS_TO_PAY
GROUP BY
YEAR(Vw_Loans_Issued_two.Date_Create),
MONTH(Vw_Loans_Issued_two.Date_Create), 

Vw_Loans_Issued_two.Is_First) AS temp_table_1
WHERE  _YEAR = YEAR(Vw_Loans_Issued_two.Date_Create) 
AND _MONTH = 	MONTH(Vw_Loans_Issued_two.Date_Create)

AND IsFirst_ = Vw_Loans_Issued_two.Is_First) 
/ sum(Vw_Loans_Issued_two.Amount_Original))*100,2),'%') END AS Am_Def_30,

CASE
WHEN MONTH(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create))) >= (Month(NOW()) -2) AND YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create))) = (YEAR(NOW()))
OR MONTH(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create))) >= (Month(NOW()) +10) AND YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create))) = (YEAR(NOW()) -1)
THEN 'n/a'
ELSE
CONCAT(FORMAT(( 
(SELECT 
_AMOUNT
FROM 
(SELECT 
SUM(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,

Vw_Loans_Issued_two.Is_First AS IsFirst_,
MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH, YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
FROM Vw_Loans_Issued_two
WHERE Vw_Loans_Issued_two.`Status 60`= 'Default'
AND DAY(Vw_Loans_Issued_two.Date_Create) BETWEEN @DAY_1 AND @DAY_2
AND Vw_Loans_Issued_two.Days_To_Pay <= @DAYS_TO_PAY
GROUP BY
YEAR(Vw_Loans_Issued_two.Date_Create),
MONTH(Vw_Loans_Issued_two.Date_Create), 

Vw_Loans_Issued_two.Is_First) AS temp_table_1
WHERE  _YEAR = YEAR(Vw_Loans_Issued_two.Date_Create) 
AND _MONTH = 	MONTH(Vw_Loans_Issued_two.Date_Create)

AND IsFirst_ = Vw_Loans_Issued_two.Is_First) 
/ sum(Vw_Loans_Issued_two.Amount_Original))*100,2),'%') END AS Am_Def_60,

CASE
WHEN MONTH(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create))) >= (Month(NOW()) -3) AND YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create))) = (YEAR(NOW()))
OR MONTH(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create))) >= (Month(NOW()) +9) AND YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create))) = (YEAR(NOW()) -1)
THEN 'n/a'
ELSE
CONCAT(FORMAT((
(SELECT 
_AMOUNT
FROM 
(SELECT 
SUM(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,

Vw_Loans_Issued_two.Is_First AS IsFirst_,
MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH, 
YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
FROM Vw_Loans_Issued_two
WHERE Vw_Loans_Issued_two.`Status 90`= 'Default'
AND DAY(Vw_Loans_Issued_two.Date_Create) BETWEEN @DAY_1 AND @DAY_2
AND Vw_Loans_Issued_two.Days_To_Pay <= @DAYS_TO_PAY
GROUP BY
YEAR(Vw_Loans_Issued_two.Date_Create),
MONTH(Vw_Loans_Issued_two.Date_Create), 

Vw_Loans_Issued_two.Is_First) AS temp_table_1
WHERE  _YEAR = YEAR(Vw_Loans_Issued_two.Date_Create) 
AND _MONTH = 	MONTH(Vw_Loans_Issued_two.Date_Create)

AND IsFirst_ = Vw_Loans_Issued_two.Is_First) 
/ sum(Vw_Loans_Issued_two.Amount_Original))*100,2),'%') END AS Am_Def_90,

/*
                                                            Начало РАСЧЕТА ВОЗВРАТОВ
*/

CONCAT(FORMAT((
(SELECT 
_AMOUNT
FROM 
(SELECT 
		SUM(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,
		Vw_Loans_Issued_two.Is_First AS IsFirst_,
		
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH, 
		YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
FROM Vw_Loans_Issued_two
WHERE Vw_Loans_Issued_two.Paid_During = 'Grace'
AND DAY(Vw_Loans_Issued_two.Date_Create) BETWEEN @DAY_1 AND @DAY_2
-- AND Vw_Loans_Issued_two.Days_To_Pay <= @DAYS_TO_PAY
GROUP BY
		YEAR(Vw_Loans_Issued_two.Date_Create),
		MONTH(Vw_Loans_Issued_two.Date_Create), 
		Vw_Loans_Issued_two.Paid_During,
		Vw_Loans_Issued_two.Is_First
		) AS temp_table_1
WHERE IsFirst_ = Vw_Loans_Issued_two.Is_First
		AND   _YEAR = YEAR(Vw_Loans_Issued_two.Date_Create) 
		AND _MONTH = 	MONTH (max(Vw_Loans_Issued_two.Date_Create))) 
/ sum(Vw_Loans_Issued_two.Amount_Original_Paid))*100,2),'%') AS Paid_Grace,

CONCAT(FORMAT((
(SELECT 
_AMOUNT
FROM 
(SELECT 
		SUM(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,
		Vw_Loans_Issued_two.Is_First AS IsFirst_,
		
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH, 
		YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
		FROM Vw_Loans_Issued_two
WHERE Vw_Loans_Issued_two.Paid_During = 'Fee'
AND DAY(Vw_Loans_Issued_two.Date_Create) BETWEEN @DAY_1 AND @DAY_2
-- AND Vw_Loans_Issued_two.Days_To_Pay <= @DAYS_TO_PAY
GROUP BY
		YEAR(Vw_Loans_Issued_two.Date_Create),
		MONTH(Vw_Loans_Issued_two.Date_Create), 
		Vw_Loans_Issued_two.Paid_During,
		Vw_Loans_Issued_two.Is_First
		) AS temp_table_1
WHERE IsFirst_ = Vw_Loans_Issued_two.Is_First 
		AND  _YEAR = YEAR(Vw_Loans_Issued_two.Date_Create) 
		AND _MONTH = 	MONTH (max(Vw_Loans_Issued_two.Date_Create))) 
/ sum(Vw_Loans_Issued_two.Amount_Original_Paid))*100,2),'%') AS Paid_Fee,

CONCAT(FORMAT((
(SELECT 
_AMOUNT
FROM 
(SELECT 
		SUM(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,
		Vw_Loans_Issued_two.Is_First AS IsFirst_,
		
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH, 
		YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
		FROM Vw_Loans_Issued_two
WHERE Vw_Loans_Issued_two.Paid_During = 'Default'
AND DAY(Vw_Loans_Issued_two.Date_Create) BETWEEN @DAY_1 AND @DAY_2
-- AND Vw_Loans_Issued_two.Days_To_Pay <= @DAYS_TO_PAY
GROUP BY
		YEAR(Vw_Loans_Issued_two.Date_Create),
		MONTH(Vw_Loans_Issued_two.Date_Create), 
		Vw_Loans_Issued_two.Paid_During,
		Vw_Loans_Issued_two.Is_First
		) AS temp_table_1
WHERE IsFirst_ = Vw_Loans_Issued_two.Is_First
		AND  _YEAR = YEAR(Vw_Loans_Issued_two.Date_Create) 
		AND _MONTH = 	MONTH (max(Vw_Loans_Issued_two.Date_Create))) 
/ sum(Vw_Loans_Issued_two.Amount_Original_Paid))*100,2),'%') AS Paid_Default,

CONCAT(FORMAT((
(SELECT 
_AMOUNT
FROM 
(SELECT 
		SUM(Vw_Loans_Issued_two.Amount_Original_Paid) AS _AMOUNT,
		Vw_Loans_Issued_two.Is_First AS IsFirst_,
		
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH, 
		YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
		FROM Vw_Loans_Issued_two
WHERE Vw_Loans_Issued_two.Status != 'Paid Back'
AND DAY(Vw_Loans_Issued_two.Date_Create) BETWEEN @DAY_1 AND @DAY_2
-- AND Vw_Loans_Issued_two.Days_To_Pay <= @DAYS_TO_PAY
GROUP BY
		YEAR(Vw_Loans_Issued_two.Date_Create),
		MONTH(Vw_Loans_Issued_two.Date_Create), 
		Vw_Loans_Issued_two.Paid_During,
		Vw_Loans_Issued_two.Is_First
		) AS temp_table_1
WHERE IsFirst_ = Vw_Loans_Issued_two.Is_First
		AND  _YEAR = YEAR(Vw_Loans_Issued_two.Date_Create) 
		AND _MONTH = 	MONTH (max(Vw_Loans_Issued_two.Date_Create))) 
/ sum(Vw_Loans_Issued_two.Amount_Original_Paid))*100,2),'%') AS Paid_Partially,



FORMAT(
(SELECT 
_DAYS
FROM 
(SELECT 
		Vw_Loans_Issued_two.Is_First AS IsFirst_,
		
		AVG(Vw_Loans_Issued_two.Days_To_Pay) AS _DAYS,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH, 
		YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
FROM Vw_Loans_Issued_two
WHERE Vw_Loans_Issued_two.Paid_During = 'Grace'
AND DAY(Vw_Loans_Issued_two.Date_Create) BETWEEN @DAY_1 AND @DAY_2
-- AND Vw_Loans_Issued_two.Days_To_Pay <= @DAYS_TO_PAY
GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		Vw_Loans_Issued_two.Paid_During,
		Vw_Loans_Issued_two.Is_First
		) AS temp_table_1
WHERE IsFirst_ = Vw_Loans_Issued_two.Is_First
		AND  _YEAR = YEAR(Vw_Loans_Issued_two.Date_Create) 
		AND _MONTH = 	MONTH (max(Vw_Loans_Issued_two.Date_Create))),2) AS Days_Pay_Grace,

FORMAT(
(SELECT 
_DAYS
FROM 
(SELECT 
		Vw_Loans_Issued_two.Is_First AS IsFirst_,
		
		AVG(Vw_Loans_Issued_two.Days_To_Pay) AS _DAYS,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH, 
		YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
		FROM Vw_Loans_Issued_two
		WHERE Vw_Loans_Issued_two.Paid_During = 'Fee'
AND DAY(Vw_Loans_Issued_two.Date_Create) BETWEEN @DAY_1 AND @DAY_2
-- AND Vw_Loans_Issued_two.Days_To_Pay <= @DAYS_TO_PAY
GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		Vw_Loans_Issued_two.Paid_During,
		Vw_Loans_Issued_two.Is_First
		) AS temp_table_1
WHERE IsFirst_ = Vw_Loans_Issued_two.Is_First 
		AND  _YEAR = YEAR(Vw_Loans_Issued_two.Date_Create) 
		AND _MONTH = 	MONTH (max(Vw_Loans_Issued_two.Date_Create))),2) AS Days_Pay_Fee,

FORMAT(
(SELECT 
_DAYS
FROM 
(SELECT 
		Vw_Loans_Issued_two.Is_First AS IsFirst_,
		AVG(Vw_Loans_Issued_two.Days_To_Pay) AS _DAYS,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH, 
		YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
FROM Vw_Loans_Issued_two
WHERE 
	Vw_Loans_Issued_two.Paid_During = 'Default'
AND DAY(Vw_Loans_Issued_two.Date_Create) BETWEEN @DAY_1 AND @DAY_2
-- AND Vw_Loans_Issued_two.Days_To_Pay <= @DAYS_TO_PAY
GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create), 
		YEAR(Vw_Loans_Issued_two.Date_Create),
		Vw_Loans_Issued_two.Paid_During,
		Vw_Loans_Issued_two.Is_First

		) AS temp_table_1
WHERE IsFirst_ = Vw_Loans_Issued_two.Is_First 
		AND  _YEAR = YEAR(Vw_Loans_Issued_two.Date_Create) 
		AND _MONTH = 	MONTH (max(Vw_Loans_Issued_two.Date_Create))),2) AS Days_Pay_Default,


/*
                                                            ОКОНЧАНИЕ РАСЧЕТА ПО ОПЕРАЦИЯМ
*/

CONCAT(format((((SELECT 
			_COUNT
			FROM 
			(SELECT 

				count(sns_profiles.gender) AS _COUNT,
				credit_sessions.is_new_user AS IsFirst_,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions left OUTER JOIN sns_profiles on credit_sessions.sns_profile_id = sns_profiles.id
			WHERE credit_sessions.result = 'credit confirmed' and sns_profiles.gender = 'f'
						AND DAY(FROM_UNIXTIME(credit_sessions.date_start)) BETWEEN @DAY_1 AND @DAY_2
			GROUP BY

				credit_sessions.is_new_user,
				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _YEAR = 	YEAR(max(Vw_Loans_Issued_two.Date_Create)) 
 
			AND _MONTH = 	MONTH(max(Vw_Loans_Issued_two.Date_Create))
			AND IsFirst_ = Vw_Loans_Issued_two.Is_First  ) )
				/  
		((SELECT 
			_COUNT
			FROM 
			(SELECT 

				count(sns_profiles.id) AS _COUNT,
				credit_sessions.is_new_user AS IsFirst_,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions left OUTER JOIN sns_profiles on credit_sessions.sns_profile_id = sns_profiles.id
			WHERE credit_sessions.is_new_user = 1 and credit_sessions.result IN ('credit confirmed') -- 'conditions not met')
						AND DAY(FROM_UNIXTIME(credit_sessions.date_start)) BETWEEN @DAY_1 AND @DAY_2
			GROUP BY

				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _YEAR = 	YEAR(max(Vw_Loans_Issued_two.Date_Create)) 
 
			AND _MONTH = 	MONTH(max(Vw_Loans_Issued_two.Date_Create))
			AND IsFirst_ = Vw_Loans_Issued_two.Is_First )
) )*100,2),'%') AS 'Gender(f)',


CONCAT(format((((SELECT 
			_COUNT
			FROM 
			(SELECT 

				count(credit_sessions.id) AS _COUNT,
				credit_sessions.is_new_user AS IsFirst_,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions
			WHERE credit_sessions.quick_session = 0 and credit_sessions.result IN('credit confirmed', 'conditions not met')
						AND DAY(FROM_UNIXTIME(credit_sessions.date_start)) BETWEEN @DAY_1 AND @DAY_2
			GROUP BY

				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _YEAR = 	YEAR(max(Vw_Loans_Issued_two.Date_Create)) 
 
			AND _MONTH = 	MONTH(max(Vw_Loans_Issued_two.Date_Create))
			AND IsFirst_ = Vw_Loans_Issued_two.Is_First ) )
				/  
		((SELECT 
			_COUNT
			FROM 
			(SELECT 

				count(credit_sessions.id) AS _COUNT,
				credit_sessions.is_new_user AS IsFirst_,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions 
			WHERE credit_sessions.quick_session = 0
						AND DAY(FROM_UNIXTIME(credit_sessions.date_start)) BETWEEN @DAY_1 AND @DAY_2
			GROUP BY

				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _YEAR = 	YEAR(max(Vw_Loans_Issued_two.Date_Create)) 
 
			AND _MONTH = 	MONTH(max(Vw_Loans_Issued_two.Date_Create))
			AND IsFirst_ = Vw_Loans_Issued_two.Is_First )
) )*100,2),'%') AS 'Conv_Full_Circle',


CONCAT(format((((SELECT 
			_COUNT
			FROM 
			(SELECT 

				count(credit_sessions.id) AS _COUNT,
				credit_sessions.is_new_user AS IsFirst_,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions
			WHERE credit_sessions.quick_session = 1 and credit_sessions.result IN('credit confirmed', 'conditions not met')
						AND DAY(FROM_UNIXTIME(credit_sessions.date_start)) BETWEEN @DAY_1 AND @DAY_2
			GROUP BY

				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _YEAR = 	YEAR(max(Vw_Loans_Issued_two.Date_Create)) 
 
			AND _MONTH = 	MONTH(max(Vw_Loans_Issued_two.Date_Create))
			AND IsFirst_ = Vw_Loans_Issued_two.Is_First ) )
				/  
		((SELECT 
			_COUNT
			FROM 
			(SELECT 

				count(credit_sessions.id) AS _COUNT,
				credit_sessions.is_new_user AS IsFirst_,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions 
			WHERE credit_sessions.quick_session = 1
						AND DAY(FROM_UNIXTIME(credit_sessions.date_start)) BETWEEN @DAY_1 AND @DAY_2
			GROUP BY

				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _YEAR = 	YEAR(max(Vw_Loans_Issued_two.Date_Create)) 
 
			AND _MONTH = 	MONTH(max(Vw_Loans_Issued_two.Date_Create))
			AND IsFirst_ = Vw_Loans_Issued_two.Is_First )
) )*100,2),'%') AS 'Conv_One_Click'

FROM
	Vw_Loans_Issued_two
WHERE 
	Vw_Loans_Issued_two.Shop_Id NOT IN (10002/*testShop*/, 10003/*testShop*/, 10036)
-- 	AND YEAR(Vw_Loans_Issued_two.Date_Create) = 2014
-- 	AND MONTH(Vw_Loans_Issued_two.Date_Create) IN (8,9,10,11, 12)
--   AND	Vw_Loans_Issued_two.Days_To_Pay <= @DAYS_TO_PAY
 	AND DAY(Vw_Loans_Issued_two.Date_Create) BETWEEN @DAY_1 AND @DAY_2

-- ,10006/*Человече*/, 10007/*Военторг*/, 10004/*Zoo-Zoo*/, 10012/*ДавайНаСвидание*/, 10013/*СкидкаБум*/) 
-- and Vw_Loans_Issued_two.Shop_Id IN (10001, 10005)
-- AND MONTH(FROM_UNIXTIME(credits.date_create)) = 11
-- AND FROM_UNIXTIME(credits.date_create) BETWEEN '2014-01-23 23:59:59' AND '2014-01-25 00:00:00'
GROUP BY
	YEAR(Vw_Loans_Issued_two.Date_Create),
	MONTH (Vw_Loans_Issued_two.Date_Create),
	Vw_Loans_Issued_two.Is_First
ORDER BY
	Vw_Loans_Issued_two.Is_First,
	YEAR (Vw_Loans_Issued_two.Date_Create) ASC,
	MONTH (Vw_Loans_Issued_two.Date_Create) ASC,
	SUM(Vw_Loans_Issued_two.Amount_Original) DESC
-- ,	Vw_Loans_Issued_two.Is_First
