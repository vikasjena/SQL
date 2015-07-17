SELECT
	CONCAT(YEAR(FROM_UNIXTIME(Vw_Loans_Issued_two.Date_Create_U)),'-',MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))) AS 'Date',
	FORMAT(sum(Vw_Loans_Issued_two.Amount_Original),2) AS Amount_Original,
	FORMAT(sum(Vw_Loans_Issued_two.Interest_Accrued),2) AS 'Sum(Int_Accrued)',
	FORMAT(sum(Vw_Loans_Issued_two.Amount_Original_Paid),2) AS Amount_Original_Paid,
	FORMAT(sum(Vw_Loans_Issued_two.Amount_Remaining),2) AS Amount_Remaining,
	FORMAT(sum(Vw_Loans_Issued_two.Interest_Paid),2) AS Int_Paid,
	CONCAT(FORMAT(((sum(Vw_Loans_Issued_two.Interest_Paid) / sum(Vw_Loans_Issued_two.Amount_Original_Paid)))*100,2),'%') AS 'Int_to_Body_P',
	CONCAT(FORMAT(((sum(Vw_Loans_Issued_two.Interest_Paid) / sum(Vw_Loans_Issued_two.Amount_Original)))*100,2),'%') AS 'Int_to_Orig',

	CONCAT(FORMAT(((sum(Vw_Loans_Issued_two.Amount_Original) - sum(Vw_Loans_Issued_two.Amount_Original_Paid)) / sum(Vw_Loans_Issued_two.Amount_Original))*100,2),'%') AS Moving_D_Rate,
	CONCAT(FORMAT(((sum(Vw_Loans_Issued_two.Amount_Original) - sum(Vw_Loans_Issued_two.Amount_Original_Paid) - sum(Vw_Loans_Issued_two.Interest_Paid)) / sum(Vw_Loans_Issued_two.Amount_Original))*100,2),'%') AS Margin,
	CONCAT(FORMAT(((sum(Vw_Loans_Issued_two.Amount_To_Pay) + sum(Vw_Loans_Issued_two.Operations_Cost) - sum(Vw_Loans_Issued_two.Amount_Original_Paid) - sum(Vw_Loans_Issued_two.Interest_Paid)) / sum(Vw_Loans_Issued_two.Amount_Original))*100,2),'%') AS Margin_Net,

	FORMAT(sum(Vw_Loans_Issued_two.Operations_Cost),2) AS PS_Comm,
	FORMAT(avg(shops.shop_commission),2) AS Avg_Com,
	SUM(Vw_Loans_Issued_two.Amount_To_Pay) AS To_Pay,

	FORMAT((
	(SELECT 
	_AMOUNT
	FROM 
	(SELECT 
	SUM(credit_operations.amount) AS _AMOUNT,
	MONTH(FROM_UNIXTIME(credit_operations.date_create)) AS _MONTH
	,YEAR(FROM_UNIXTIME(credit_operations.date_create)) AS _YEAR
	FROM credit_operations
	WHERE credit_operations.type_id in (2,7)
	GROUP BY
	MONTH(FROM_UNIXTIME(credit_operations.date_create))
,YEAR(FROM_UNIXTIME(credit_operations.date_create))
	) AS temp_table_1
	WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))))),2) AS Int_Accrued,


	FORMAT((sum(Vw_Loans_Issued_two.Amount_Original)*(shops.shop_commission/100)),2) AS Shop_Com_Accrued,

	FORMAT((
	(SELECT 
	_AMOUNT
	FROM 
	(SELECT 
	SUM(credit_operations.amount) AS _AMOUNT,
	MONTH(FROM_UNIXTIME(credit_operations.date_create)) AS _MONTH
	,YEAR(FROM_UNIXTIME(credit_operations.date_create)) AS _YEAR
	FROM credit_operations
	LEFT OUTER JOIN Vw_Loans_Issued_two on credit_operations.credit_id = Vw_Loans_Issued_two.Credit_Id
	WHERE credit_operations.type_id in (2,7) AND Vw_Loans_Issued_two.`Status` != 'Default' and Vw_Loans_Issued_two.Credit_Id NOT IN (10002, 10003, 10036)
	GROUP BY
	MONTH(FROM_UNIXTIME(credit_operations.date_create))
	,YEAR(FROM_UNIXTIME(credit_operations.date_create))
	) AS temp_table_1
	WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND  _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))))),2) AS Good_Int_Accrued,



	count(Vw_Loans_Issued_two.Credit_Id) AS cr_count,
	count(DISTINCT Vw_Loans_Issued_two.User_Id) AS users_count,
	sum(Vw_Loans_Issued_two.Is_First) AS new_users,

	FORMAT(count(Vw_Loans_Issued_two.Credit_Id) / count(DISTINCT Vw_Loans_Issued_two.User_Id),2) AS 'Purch.Per.Usr',
	(FORMAT((sum(Vw_Loans_Issued_two.Amount_Original) / count(DISTINCT Vw_Loans_Issued_two.User_Id)),0)) AS ARPPU,
	FORMAT((sum(Vw_Loans_Issued_two.Amount_Original) / count(Vw_Loans_Issued_two.Credit_Id)),0) AS AvgCrdAmnt,



/*
                                                                   НАЧАЛО РАСЧЕТА ДЕФОЛТОВ
*/
CASE
WHEN MONTH(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) >= (Month(NOW()) -1) AND YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) = (YEAR(NOW()))
OR MONTH(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) >= (Month(NOW()) +11) AND YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) = (YEAR(NOW()) -1)
THEN 'n/a'
ELSE
CONCAT(FORMAT(( 
(SELECT 
_AMOUNT
FROM 
(SELECT 
SUM(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,
MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
FROM Vw_Loans_Issued_two
WHERE Vw_Loans_Issued_two.`Status`= 'Default'
GROUP BY
MONTH(Vw_Loans_Issued_two.Date_Create)
,YEAR(Vw_Loans_Issued_two.Date_Create) 
) AS temp_table_1
WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND   _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))) / sum(Vw_Loans_Issued_two.Amount_Original))*100,2),'%') END AS Def_Quant,


CASE
WHEN MONTH(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) >= (Month(NOW()) -1) AND YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) = (YEAR(NOW()))
OR MONTH(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) >= (Month(NOW()) +11) AND YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) = (YEAR(NOW()) -1)
THEN 'n/a'
ELSE
CONCAT(FORMAT(( 
(SELECT 
_AMOUNT
FROM 
(SELECT 
SUM(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,
MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
FROM Vw_Loans_Issued_two
WHERE Vw_Loans_Issued_two.`Status 30`= 'Default'
GROUP BY
MONTH(Vw_Loans_Issued_two.Date_Create)
,YEAR(Vw_Loans_Issued_two.Date_Create) 
) AS temp_table_1
WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))) / sum(Vw_Loans_Issued_two.Amount_Original))*100,2),'%') END AS Am_Def_30,


CASE
WHEN MONTH(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) >= (Month(NOW()) -2) AND YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) = (YEAR(NOW()))
OR MONTH(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) >= (Month(NOW()) +10) AND YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) = (YEAR(NOW()) -1)
THEN 'n/a'
ELSE
CONCAT(FORMAT(( 
(SELECT 
_AMOUNT
FROM 
(SELECT 
SUM(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,
MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
FROM Vw_Loans_Issued_two
WHERE Vw_Loans_Issued_two.`Status 60`= 'Default'
GROUP BY
MONTH(Vw_Loans_Issued_two.Date_Create)
,YEAR(Vw_Loans_Issued_two.Date_Create) 
) AS temp_table_1
WHERE  _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))) / sum(Vw_Loans_Issued_two.Amount_Original))*100,2),'%') END AS Am_Def_60,

CASE
WHEN MONTH(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) >= (Month(NOW()) -3) AND YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) = (YEAR(NOW()))
OR MONTH(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) >= (Month(NOW()) +9) AND YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) = (YEAR(NOW()) -1)
THEN 'n/a'
ELSE
CONCAT(FORMAT((
(SELECT 
_AMOUNT
FROM 
(SELECT 
SUM(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,
MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
FROM Vw_Loans_Issued_two
WHERE Vw_Loans_Issued_two.`Status 90`= 'Default'
GROUP BY
MONTH(Vw_Loans_Issued_two.Date_Create)
,YEAR(Vw_Loans_Issued_two.Date_Create) 
) AS temp_table_1
WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))) / sum(Vw_Loans_Issued_two.Amount_Original))*100,2),'%') END AS Am_Def_90,


/*
                                                            ОКОНЧАНИЕ РАСЧЕТА ПО ДЕФОЛТОВ
*/
/*
                                                            НАЧАЛО РАСЧЕТА ПО ВОЗВРАТОВ
*/

CONCAT(FORMAT((
(SELECT 
_AMOUNT
FROM 
(SELECT 
SUM(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,
MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
FROM Vw_Loans_Issued_two
WHERE Vw_Loans_Issued_two.Paid_During = 'Grace'
GROUP BY
MONTH(Vw_Loans_Issued_two.Date_Create),
YEAR(Vw_Loans_Issued_two.Date_Create),
Vw_Loans_Issued_two.Paid_During
) AS temp_table_1
WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))) / sum(Vw_Loans_Issued_two.Amount_Original_Paid))*100,2),'%') AS Paid_Grace,

CONCAT(FORMAT((
(SELECT 
_AMOUNT
FROM 
(SELECT 
SUM(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,
MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
FROM Vw_Loans_Issued_two
WHERE Vw_Loans_Issued_two.Paid_During = 'Fee'
GROUP BY
MONTH(Vw_Loans_Issued_two.Date_Create),
YEAR(Vw_Loans_Issued_two.Date_Create),
Vw_Loans_Issued_two.Paid_During
) AS temp_table_1
WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))) / sum(Vw_Loans_Issued_two.Amount_Original_Paid))*100,2),'%') AS Paid_Fee,

CONCAT(FORMAT((
(SELECT 
_AMOUNT
FROM 
(SELECT 
SUM(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,
MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
FROM Vw_Loans_Issued_two
WHERE Vw_Loans_Issued_two.Paid_During = 'Default'
GROUP BY
MONTH(Vw_Loans_Issued_two.Date_Create),
YEAR(Vw_Loans_Issued_two.Date_Create),
Vw_Loans_Issued_two.Paid_During
) AS temp_table_1
WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))) / sum(Vw_Loans_Issued_two.Amount_Original_Paid))*100,2),'%') AS Paid_Default,

CONCAT(FORMAT((
(SELECT 
_AMOUNT
FROM 
(SELECT 
SUM(Vw_Loans_Issued_two.Amount_Original_Paid) AS _AMOUNT,
MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
FROM Vw_Loans_Issued_two
WHERE Vw_Loans_Issued_two.Status != 'Paid Back'
GROUP BY
MONTH(Vw_Loans_Issued_two.Date_Create),
YEAR(Vw_Loans_Issued_two.Date_Create),
Vw_Loans_Issued_two.Paid_During
) AS temp_table_1
WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))) / sum(Vw_Loans_Issued_two.Amount_Original_Paid))*100,2),'%') AS Paid_Partially,

FORMAT(
(SELECT 
_DAYS
FROM 
(SELECT 
AVG(Vw_Loans_Issued_two.Days_To_Pay) AS _DAYS,
MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
FROM Vw_Loans_Issued_two
WHERE Vw_Loans_Issued_two.Status = 'Paid Back'
GROUP BY
MONTH(Vw_Loans_Issued_two.Date_Create),
YEAR(Vw_Loans_Issued_two.Date_Create)
) AS temp_table_1
WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND  _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))),2) AS Days_Pay_AVG,


FORMAT(
(SELECT 
_DAYS
FROM 
(SELECT 
AVG(Vw_Loans_Issued_two.Days_To_Pay) AS _DAYS,
MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
FROM Vw_Loans_Issued_two
WHERE Vw_Loans_Issued_two.Paid_During = 'Grace'
GROUP BY
MONTH(Vw_Loans_Issued_two.Date_Create),
YEAR(Vw_Loans_Issued_two.Date_Create),
Vw_Loans_Issued_two.Paid_During
) AS temp_table_1
WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND  _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))),2) AS Days_Pay_Grace,

FORMAT(
(SELECT 
_DAYS
FROM 
(SELECT 
AVG(Vw_Loans_Issued_two.Days_To_Pay) AS _DAYS,
MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
FROM Vw_Loans_Issued_two
WHERE Vw_Loans_Issued_two.Paid_During = 'Fee'
GROUP BY
MONTH(Vw_Loans_Issued_two.Date_Create),
YEAR(Vw_Loans_Issued_two.Date_Create),
Vw_Loans_Issued_two.Paid_During
) AS temp_table_1
WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND  _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))),2) AS Days_Pay_Fee,

FORMAT(
(SELECT 
_DAYS
FROM 
(SELECT 
AVG(Vw_Loans_Issued_two.Days_To_Pay) AS _DAYS,
MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
FROM Vw_Loans_Issued_two
WHERE Vw_Loans_Issued_two.Paid_During = 'Default'
GROUP BY
MONTH(Vw_Loans_Issued_two.Date_Create),
YEAR(Vw_Loans_Issued_two.Date_Create),
Vw_Loans_Issued_two.Paid_During
) AS temp_table_1
WHERE  _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND  _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))),2) AS Days_Pay_Default


/*
                                                            ОКОНЧАНИЕ РАСЧЕТА ПО ВОЗВРАТОВ
*/

/*
                                                            НАЧАЛО РАСЧЕТА LLA




CONCAT(FORMAT(( 
(SELECT 
_AMOUNT
FROM 
(SELECT 
SUM(Vw_Loans_Issued_two.Interest_Accrued) AS _AMOUNT,
MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
FROM Vw_Loans_Issued_two
WHERE Vw_Loans_Issued_two.`Status 90` != 'Default'
GROUP BY
MONTH(Vw_Loans_Issued_two.Date_Create)
,YEAR(Vw_Loans_Issued_two.Date_Create) 
) AS temp_table_1
WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))) / sum(Vw_Loans_Issued_two.Amount_Original))*100,2),'%') AS Int%_Accr_BS,


FORMAT( 
(SELECT 
_AMOUNT
FROM 
(SELECT 
SUM(Vw_Loans_Issued_two.Interest_Accrued) AS _AMOUNT,
MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
FROM Vw_Loans_Issued_two
WHERE Vw_Loans_Issued_two.`Status 90` != 'Default'
GROUP BY
MONTH(Vw_Loans_Issued_two.Date_Create)
,YEAR(Vw_Loans_Issued_two.Date_Create) 
) AS temp_table_1
WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))),2) AS Int$_Accr_BS,

	FORMAT((sum(Vw_Loans_Issued_two.Amount_Original)*(shops.shop_commission/100)),2) AS Shop_Com_Accrued,

	FORMAT((
	(SELECT 
	_AMOUNT
	FROM 
	(SELECT 
	SUM(credit_operations.amount) AS _AMOUNT,
	MONTH(FROM_UNIXTIME(credit_operations.date_create)) AS _MONTH
	,YEAR(FROM_UNIXTIME(credit_operations.date_create)) AS _YEAR
	FROM credit_operations
	LEFT OUTER JOIN Vw_Loans_Issued_two on credit_operations.credit_id = Vw_Loans_Issued_two.Credit_Id
	WHERE credit_operations.type_id in (2,7) AND Vw_Loans_Issued_two.`Status` != 'Default'
	GROUP BY
	MONTH(FROM_UNIXTIME(credit_operations.date_create))
	,YEAR(FROM_UNIXTIME(credit_operations.date_create))
	) AS temp_table_1
	WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND  _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))))),2) AS Good_Int_Accrued,

CASE
WHEN MONTH(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) >= (Month(NOW()) -1) AND YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) = (YEAR(NOW()))
OR MONTH(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) >= (Month(NOW()) +11) AND YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) = (YEAR(NOW()) -1)
THEN 'n/a'
ELSE
CONCAT(FORMAT(( 
(SELECT 
_AMOUNT
FROM 
(SELECT 
SUM(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,
MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
FROM Vw_Loans_Issued_two
WHERE Vw_Loans_Issued_two.`Status 30`= 'Default'
GROUP BY
MONTH(Vw_Loans_Issued_two.Date_Create)
,YEAR(Vw_Loans_Issued_two.Date_Create) 
) AS temp_table_1
WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))) 

/ 

(SELECT 
_AMOUNT
FROM 
(SELECT 
SUM(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,
MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
FROM Vw_Loans_Issued_two
WHERE Vw_Loans_Issued_two.`Status`= 'Default'
GROUP BY
MONTH(Vw_Loans_Issued_two.Date_Create)
,YEAR(Vw_Loans_Issued_two.Date_Create) 
) AS temp_table_1
WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))) 

)*100,2),'%') END AS Am__30

*/

FROM
	Vw_Loans_Issued_two
	LEFT OUTER JOIN shops ON Vw_Loans_Issued_two.Shop_Id = shops.id
 WHERE
			shops.test_mode = 0
  -- Vw_Loans_Issued_two.Shop_Id NOT IN (10002, 10003, 10036)
	-- AND MONTH(FROM_UNIXTIME(Vw_Loans_Issued_two.Date_Create_U)) = 10
	-- AND Vw_Loans_Issued_two.Shop_Id BETWEEN '10005' AND '10005'
GROUP BY
	YEAR(FROM_UNIXTIME(Vw_Loans_Issued_two.Date_Create_U)),
	MONTH (FROM_UNIXTIME(Vw_Loans_Issued_two.Date_Create_U))
ORDER BY
	YEAR(FROM_UNIXTIME(Vw_Loans_Issued_two.Date_Create_U)) ASC,
	MONTH (FROM_UNIXTIME(Vw_Loans_Issued_two.Date_Create_U)) ASC,
	sum(Vw_Loans_Issued_two.Amount_Original) DESC