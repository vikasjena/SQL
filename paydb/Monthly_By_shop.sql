SELECT
	CONCAT(YEAR(FROM_UNIXTIME(Vw_Loans_Issued_two.Date_Create_U)),'-',MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))) AS 'Date',
	Vw_Loans_Issued_two.Shop_Id,
	shops.short_name,
-- 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AS Month_,
	FORMAT(sum(Vw_Loans_Issued_two.Amount_Original),2) AS Amount_Original,
	FORMAT(sum(Vw_Loans_Issued_two.Interest_Accrued),2) AS Interest_Accrued,
	(FORMAT(sum(Vw_Loans_Issued_two.Amount_Original) * (100 - shops.shop_commission) / 100,2)) AS To_Pay,
	FORMAT(sum(Vw_Loans_Issued_two.Operations_Cost),2) AS PS_Comm,
	FORMAT(sum(Vw_Loans_Issued_two.Amount_Original_Paid),2) AS Amount_Paid,
	FORMAT(sum(Vw_Loans_Issued_two.Interest_Paid),2) AS Interest_Paid,
	CONCAT(FORMAT(((sum(Vw_Loans_Issued_two.Interest_Paid) / sum(Vw_Loans_Issued_two.Amount_Original_Paid)))*100,2),'%') AS 'Int_to_Body_P',
	CONCAT(FORMAT(((sum(Vw_Loans_Issued_two.Interest_Paid) / sum(Vw_Loans_Issued_two.Amount_Original)))*100,2),'%') AS 'Int_to_Orig',
	count(Vw_Loans_Issued_two.Credit_Id) AS Cr_Count,
	count(DISTINCT Vw_Loans_Issued_two.User_Id) AS Users_Count,
	sum(Vw_Loans_Issued_two.Is_First) AS New_Users,
	FORMAT(count(Vw_Loans_Issued_two.Credit_Id) / count(DISTINCT Vw_Loans_Issued_two.User_Id),2) AS 'Purch.Per.Usr',
	(FORMAT((sum(Vw_Loans_Issued_two.Amount_Original) / count(DISTINCT Vw_Loans_Issued_two.User_Id)),0)) AS ARPPU,
	FORMAT((sum(Vw_Loans_Issued_two.Amount_Original) / count(Vw_Loans_Issued_two.Credit_Id)),0) AS AvgCrdAmnt,
/*
                                                            ДЕФОЛТЫ И ОПЛАТЫ
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
		Vw_Loans_Issued_two.Shop_Id AS _ID,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
		,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
	FROM Vw_Loans_Issued_two
	WHERE Vw_Loans_Issued_two.`Status`= 'Default'
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		Vw_Loans_Issued_two.Shop_Id) AS temp_table_1
	WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) 
AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) 
AND _ID = Vw_Loans_Issued_two.Shop_Id) / sum(Vw_Loans_Issued_two.Amount_Original))*100,2),'%') END AS Def_Quant,


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
		Vw_Loans_Issued_two.Shop_Id AS _ID,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
		,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
	FROM Vw_Loans_Issued_two
	WHERE Vw_Loans_Issued_two.`Status 30`= 'Default'
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		Vw_Loans_Issued_two.Shop_Id) AS temp_table_1
	WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND _ID = Vw_Loans_Issued_two.Shop_Id) / sum(Vw_Loans_Issued_two.Amount_Original))*100,2),'%') END AS Am_Def_30,

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
		Vw_Loans_Issued_two.Shop_Id AS _ID,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
		,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
	FROM Vw_Loans_Issued_two
	WHERE Vw_Loans_Issued_two.`Status 60`= 'Default'
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		Vw_Loans_Issued_two.Shop_Id) AS temp_table_1
	WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND _ID = Vw_Loans_Issued_two.Shop_Id) / sum(Vw_Loans_Issued_two.Amount_Original))*100,2),'%') END AS Am_Def_60,

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
		Vw_Loans_Issued_two.Shop_Id AS _ID,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
		,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
	FROM Vw_Loans_Issued_two
	WHERE Vw_Loans_Issued_two.`Status 90`= 'Default'
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		Vw_Loans_Issued_two.Shop_Id) AS temp_table_1
	WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND _ID = Vw_Loans_Issued_two.Shop_Id) / sum(Vw_Loans_Issued_two.Amount_Original))*100,2),'%') END AS Am_Def_90,

 CONCAT(format((((SELECT 
			_COUNT
			FROM 
			(SELECT 
				credit_sessions.shop_id AS _ID,
				count(DISTINCT credit_sessions.user_id) AS _COUNT,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions
			WHERE credit_sessions.is_new_user = 1 and credit_sessions.result = 'credit confirmed'
			GROUP BY
				credit_sessions.shop_id,
				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND  _ID = Vw_Loans_Issued_two.Shop_Id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))) )
				/  
		((SELECT 
			_COUNT
			FROM 
			(SELECT 
				credit_sessions.shop_id AS _ID,
				count(DISTINCT credit_sessions.user_id) AS _COUNT,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions
-- 			WHERE credit_sessions.is_new_user = 1 and credit_sessions.result IN ('credit confirmed', 'conditions not met')
			WHERE credit_sessions.is_new_user = 1 and credit_sessions.result != 'session not finished'
			GROUP BY
				credit_sessions.shop_id,
				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND  _ID = Vw_Loans_Issued_two.Shop_Id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))))
) )*100,2),'%') AS Approval,

		CONCAT(FORMAT(((sum(Vw_Loans_Issued_two.Amount_Original) - sum(Vw_Loans_Issued_two.Amount_Original_Paid)) / sum(Vw_Loans_Issued_two.Amount_Original))*100,2),'%') AS Moving_D_Rate,
		CONCAT(FORMAT(((sum(Vw_Loans_Issued_two.Amount_Original) - sum(Vw_Loans_Issued_two.Amount_Original_Paid) - sum(Vw_Loans_Issued_two.Interest_Paid)) / sum(Vw_Loans_Issued_two.Amount_Original))*100,2),'%') AS Margin,
		CONCAT(FORMAT(((sum(Vw_Loans_Issued_two.Amount_To_Pay) + sum(Vw_Loans_Issued_two.Operations_Cost) - sum(Vw_Loans_Issued_two.Amount_Original_Paid) - sum(Vw_Loans_Issued_two.Interest_Paid)) / sum(Vw_Loans_Issued_two.Amount_Original))*100,2),'%') AS Margin_Net,

		-- Считается Правильно при сортировке по магазинам
		-- ALTERNATIVE VERSION OF MARGIN NET CALC BEGIN
		/*
		CONCAT(FORMAT((((SELECT 
			_AMOUNT
			FROM 
			(SELECT 
			SUM(Vw_To_Pay_Monthly_By_Shop_4.`К Оплате`) AS _AMOUNT
			,Vw_To_Pay_Monthly_By_Shop_4.id AS _ID
			,Vw_To_Pay_Monthly_By_Shop_4.`Месяц` AS _MONTH
			,Vw_To_Pay_Monthly_By_Shop_4.`Год` AS _YEAR
			FROM Vw_To_Pay_Monthly_By_Shop_4
			GROUP BY
			Vw_To_Pay_Monthly_By_Shop_4.`Год`,
			Vw_To_Pay_Monthly_By_Shop_4.`Месяц`
			,Vw_To_Pay_Monthly_By_Shop_4.id
			) AS temp_table_1
			WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND  _ID = Vw_Loans_Issued_two.Shop_Id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))) 

		+ sum(Vw_Loans_Issued_two.Operations_Cost) - sum(Vw_Loans_Issued_two.Amount_Original_Paid) - sum(Vw_Loans_Issued_two.Interest_Paid))

			/  (SELECT 
			_AMOUNT
			FROM 
			(SELECT 
			SUM(Vw_To_Pay_Monthly_By_Shop_4.`К Оплате`) AS _AMOUNT
			,Vw_To_Pay_Monthly_By_Shop_4.id AS _ID
			,Vw_To_Pay_Monthly_By_Shop_4.`Месяц` AS _MONTH
			,Vw_To_Pay_Monthly_By_Shop_4.`Год` AS _YEAR
			FROM Vw_To_Pay_Monthly_By_Shop_4
			GROUP BY
			Vw_To_Pay_Monthly_By_Shop_4.`Год`,
			Vw_To_Pay_Monthly_By_Shop_4.`Месяц`
			,Vw_To_Pay_Monthly_By_Shop_4.id
			) AS temp_table_1
			WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND  _ID = Vw_Loans_Issued_two.Shop_Id AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))))*100,2),'%') AS Margin_Net,
		*/
		-- ALTERNATIVE VERSION OF MARGIN NET CALC END
	CONCAT((shop_commission),'%') AS Comission,
	CONCAT(FORMAT((
	(SELECT 
		_AMOUNT
	FROM 
	(SELECT 
		SUM(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,
		Vw_Loans_Issued_two.Shop_Id AS _ID,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
		,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
	FROM Vw_Loans_Issued_two
	WHERE Vw_Loans_Issued_two.Paid_During = 'Grace'
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		Vw_Loans_Issued_two.Paid_During,
		Vw_Loans_Issued_two.Shop_Id
	) AS temp_table_1
	WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND  _ID = Vw_Loans_Issued_two.Shop_Id AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))) / sum(Vw_Loans_Issued_two.Amount_Original_Paid))*100,2),'%') AS Paid_Grace,

	CONCAT(FORMAT((
	(SELECT 
		_AMOUNT
	FROM 
	(SELECT 
		SUM(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,
		Vw_Loans_Issued_two.Shop_Id AS _ID,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
		,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
	FROM Vw_Loans_Issued_two
	WHERE Vw_Loans_Issued_two.Paid_During = 'Fee'
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		Vw_Loans_Issued_two.Paid_During,
		Vw_Loans_Issued_two.Shop_Id
	) AS temp_table_1
	WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND  _ID = Vw_Loans_Issued_two.Shop_Id AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))) / sum(Vw_Loans_Issued_two.Amount_Original_Paid))*100,2),'%') AS Paid_Fee,

	CONCAT(FORMAT((
	(SELECT 
		_AMOUNT
	FROM 
	(SELECT 
		SUM(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,
		Vw_Loans_Issued_two.Shop_Id AS _ID,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
		,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
	FROM Vw_Loans_Issued_two
	WHERE Vw_Loans_Issued_two.Paid_During = 'Default'
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		Vw_Loans_Issued_two.Paid_During,
		Vw_Loans_Issued_two.Shop_Id
	) AS temp_table_1
	WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND  _ID = Vw_Loans_Issued_two.Shop_Id AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))) / sum(Vw_Loans_Issued_two.Amount_Original_Paid))*100,2),'%') AS Paid_Default,

	CONCAT(FORMAT((
	(SELECT 
		_AMOUNT
	FROM 
	(SELECT 
		SUM(Vw_Loans_Issued_two.Amount_Original_Paid) AS _AMOUNT,
		Vw_Loans_Issued_two.Shop_Id AS _ID,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
		,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
	FROM Vw_Loans_Issued_two
	WHERE Vw_Loans_Issued_two.Status != 'Paid Back'
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		Vw_Loans_Issued_two.Paid_During,
		Vw_Loans_Issued_two.Shop_Id
	) AS temp_table_1
	WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND  _ID = Vw_Loans_Issued_two.Shop_Id AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))) / sum(Vw_Loans_Issued_two.Amount_Original_Paid))*100,2),'%') AS Paid_Partially,


FORMAT(
	(SELECT 
		_DAYS
	FROM 
	(SELECT 
		Vw_Loans_Issued_two.Shop_Id AS _ID,
		AVG(Vw_Loans_Issued_two.Days_To_Pay) AS _DAYS,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
		,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
	FROM Vw_Loans_Issued_two
	WHERE Vw_Loans_Issued_two.Status = 'Paid Back'
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		Vw_Loans_Issued_two.Shop_Id
	) AS temp_table_1
	WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND  _ID = Vw_Loans_Issued_two.Shop_Id AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))),2) AS Days_Pay_AVG,

	FORMAT(
	(SELECT 
		_DAYS
	FROM 
	(SELECT 
		Vw_Loans_Issued_two.Shop_Id AS _ID,
		AVG(Vw_Loans_Issued_two.Days_To_Pay) AS _DAYS,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
		,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
	FROM Vw_Loans_Issued_two
	WHERE Vw_Loans_Issued_two.Paid_During = 'Grace'
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		Vw_Loans_Issued_two.Paid_During,
		Vw_Loans_Issued_two.Shop_Id
	) AS temp_table_1
	WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND  _ID = Vw_Loans_Issued_two.Shop_Id AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))),2) AS Days_Pay_Grace,

	FORMAT(
	(SELECT 
		_DAYS
	FROM 
	(SELECT 
		Vw_Loans_Issued_two.Shop_Id AS _ID,
		AVG(Vw_Loans_Issued_two.Days_To_Pay) AS _DAYS,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
		,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
	FROM Vw_Loans_Issued_two
	WHERE Vw_Loans_Issued_two.Paid_During = 'Fee'
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		Vw_Loans_Issued_two.Paid_During,
		Vw_Loans_Issued_two.Shop_Id
	) AS temp_table_1
	WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND   _ID = Vw_Loans_Issued_two.Shop_Id AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))),2) AS Days_Pay_Fee,

	FORMAT(
	(SELECT 
		_DAYS
	FROM 
	(SELECT 
		Vw_Loans_Issued_two.Shop_Id AS _ID,
		AVG(Vw_Loans_Issued_two.Days_To_Pay) AS _DAYS,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
		,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
	FROM Vw_Loans_Issued_two
	WHERE Vw_Loans_Issued_two.Paid_During = 'Default'
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		Vw_Loans_Issued_two.Paid_During,
		Vw_Loans_Issued_two.Shop_Id
	) AS temp_table_1
	WHERE _YEAR = YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND _ID = Vw_Loans_Issued_two.Shop_Id AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))),2) AS Days_Pay_Default,

CONCAT(format((((SELECT 
			_COUNT
			FROM 
			(SELECT 
				credit_sessions.shop_id AS _ID,
				count(sns_profiles.gender) AS _COUNT,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions left OUTER JOIN sns_profiles on credit_sessions.sns_profile_id = sns_profiles.id
			WHERE credit_sessions.is_new_user = 1 and credit_sessions.result = 'credit confirmed' and sns_profiles.gender = 'm'
			GROUP BY
				credit_sessions.shop_id,
				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND  _ID = Vw_Loans_Issued_two.Shop_Id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))) )
				/  
		((SELECT 
			_COUNT
			FROM 
			(SELECT 
				credit_sessions.shop_id AS _ID,
				count(sns_profiles.gender) AS _COUNT,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions left OUTER JOIN sns_profiles on credit_sessions.sns_profile_id = sns_profiles.id
			WHERE credit_sessions.is_new_user = 1 and credit_sessions.result IN ('credit confirmed' /*, 'conditions not met'*/ ) and sns_profiles.gender IN ('m', 'f')
			GROUP BY
				credit_sessions.shop_id,
				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND  _ID = Vw_Loans_Issued_two.Shop_Id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))))
) )*100,2),'%') AS 'Gender(m)',

CONCAT(format((((SELECT 
			_COUNT
			FROM 
			(SELECT 
				credit_sessions.shop_id AS _ID,
				count(sns_profiles.gender) AS _COUNT,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions left OUTER JOIN sns_profiles on credit_sessions.sns_profile_id = sns_profiles.id
			WHERE credit_sessions.is_new_user = 1 and credit_sessions.result = 'credit confirmed' and sns_profiles.gender = 'f'
			GROUP BY
				credit_sessions.shop_id,
				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND  _ID = Vw_Loans_Issued_two.Shop_Id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))) )
				/  
		((SELECT 
			_COUNT
			FROM 
			(SELECT 
				credit_sessions.shop_id AS _ID,
				count(sns_profiles.id) AS _COUNT,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions left OUTER JOIN sns_profiles on credit_sessions.sns_profile_id = sns_profiles.id
			WHERE credit_sessions.is_new_user = 1 and credit_sessions.result IN ('credit confirmed') -- 'conditions not met')
			GROUP BY
				credit_sessions.shop_id,
				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND  _ID = Vw_Loans_Issued_two.Shop_Id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))))
) )*100,2),'%') AS 'Gender(f)',


CONCAT(format((((SELECT 
			_COUNT
			FROM 
			(SELECT 
				credit_sessions.shop_id AS _ID,
				count(credit_sessions.id) AS _COUNT,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions
			WHERE credit_sessions.quick_session = 0 and credit_sessions.result IN('credit confirmed', 'conditions not met')
			GROUP BY
				credit_sessions.shop_id,
				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND  _ID = Vw_Loans_Issued_two.Shop_Id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))) )
				/  
		((SELECT 
			_COUNT
			FROM 
			(SELECT 
				credit_sessions.shop_id AS _ID,
				count(credit_sessions.id) AS _COUNT,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions 
			WHERE credit_sessions.quick_session = 0
			GROUP BY
				credit_sessions.shop_id,
				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND  _ID = Vw_Loans_Issued_two.Shop_Id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))))
) )*100,2),'%') AS 'Conv_Full_Circle',


CONCAT(format((((SELECT 
			_COUNT
			FROM 
			(SELECT 
				credit_sessions.shop_id AS _ID,
				count(credit_sessions.id) AS _COUNT,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions
			WHERE credit_sessions.quick_session = 1 and credit_sessions.result IN('credit confirmed', 'conditions not met')
			GROUP BY
				credit_sessions.shop_id,
				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND  _ID = Vw_Loans_Issued_two.Shop_Id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U)))) )
				/  
		((SELECT 
			_COUNT
			FROM 
			(SELECT 
				credit_sessions.shop_id AS _ID,
				count(credit_sessions.id) AS _COUNT,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions 
			WHERE credit_sessions.quick_session = 1
			GROUP BY
				credit_sessions.shop_id,
				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))) AND  _ID = Vw_Loans_Issued_two.Shop_Id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(Vw_Loans_Issued_two.Date_Create_U))))
) )*100,2),'%') AS 'Conv_One_Click'



FROM
	Vw_Loans_Issued_two
	LEFT OUTER JOIN shops ON Vw_Loans_Issued_two.Shop_Id = shops.id
WHERE
	Vw_Loans_Issued_two.Shop_Id NOT IN (10002/*testShop*/, 10003/*testShop*/, 10036 /*testShop*/) -- , 10006/*Человече*/, 10007/*Военторг*/, 10004/*Zoo-Zoo*/, 10012/*ДавайНаСвидание*/) -- and Vw_Loans_Issued_two.Shop_Id = 10001
-- AND shops.id = 10100
-- AND MONTH(FROM_UNIXTIME(Vw_Loans_Issued_two.Date_Create_U)) > 6 AND YEAR(FROM_UNIXTIME(Vw_Loans_Issued_two.Date_Create_U)) = 1014
-- AND FROM_UNIXTIME(Vw_Loans_Issued_two.Date_Create_U) BETWEEN '2014-01-23 23:59:59' AND '2014-01-25 00:00:00'
GROUP BY
	YEAR (Vw_Loans_Issued_two.Date_Create) ASC,
	MONTH (Vw_Loans_Issued_two.Date_Create),
	Vw_Loans_Issued_two.Shop_Id 
	-- Vw_Loans_Issued_two.Shop_Id BETWEEN '10005' AND '10005'
ORDER BY
	YEAR (Vw_Loans_Issued_two.Date_Create) ASC,
	MONTH (Vw_Loans_Issued_two.Date_Create) ASC,
	sum(Vw_Loans_Issued_two.Amount_Original) DESC