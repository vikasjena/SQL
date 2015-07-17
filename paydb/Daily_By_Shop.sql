SELECT
	CONCAT(YEAR(FROM_UNIXTIME(credits.date_create)),'-',MONTH (FROM_UNIXTIME(max(credits.date_create)))) AS 'Date',
	DAY(FROM_UNIXTIME(credits.date_create))  AS 'Day',
	credits.shop_id,
	shops.short_name,
-- 	MONTH (FROM_UNIXTIME(max(credits.date_create))) AS Month_,
	FORMAT(sum(credits.amount_original),2) AS Amount_Original,

CONCAT(FORMAT(
		(SELECT SUM_BY_DAY FROM
      (SELECT
					SUM(Vw_Loans_Issued_two.Amount_Original) as SUM_BY_DAY,
					MONTH (Vw_Loans_Issued_two.Date_Create) as _MONTH,
					YEAR (Vw_Loans_Issued_two.Date_Create) as _YEAR,
					DAY(Vw_Loans_Issued_two.Date_Create) as _DAY,
					shops.short_name AS _NAME
       FROM
					Vw_Loans_Issued_two
       LEFT OUTER JOIN shops ON Vw_Loans_Issued_two.Shop_Id = shops.id
				WHERE Vw_Loans_Issued_two.Is_First = 1
       GROUP BY
					YEAR (Vw_Loans_Issued_two.Date_Create),
					MONTH (Vw_Loans_Issued_two.Date_Create),
					DAY(Vw_Loans_Issued_two.Date_Create),
					shops.short_name ) as temp_table
/* Условие к первому вложенному селекту, чтобы выбирал из второго селекта только те суммы, которые относятся к месяцу и магазину, выбираемому в самом первом (верхнем) селекте. */
			 WHERE _MONTH = MONTH (Vw_Loans_Issued_two.Date_Create) 
				AND _YEAR = YEAR(Vw_Loans_Issued_two.Date_Create) 
				AND _DAY = DAY(Vw_Loans_Issued_two.Date_Create)
				AND _NAME = shops.short_name ) / (sum(Vw_Loans_Issued_two.Amount_Original))*100, 2),'%') AS 'New Vol %',

-- FORMAT(sum(credits.interest_accrued),2) AS Interest_Accrued,
-- (FORMAT(sum(credits.amount_original) * (100 - shops.shop_commission) / 100,2)) AS To_Pay,
-- FORMAT(sum(Vw_Loans_Issued_two.Operations_Cost),2) AS Operations_Cost,
FORMAT(sum(credits.amount_paid),2) AS Amount_Paid,
FORMAT(sum(credits.interest_paid),2) AS Interest_Paid,
-- CONCAT(FORMAT(((sum(credits.interest_paid) / sum(credits.amount_paid)))*100,2),'%') AS 'Int_to_Body_P',
-- CONCAT(FORMAT(((sum(credits.interest_paid) / sum(credits.amount_original)))*100,2),'%') AS 'Int_to_Orig',
	count(credits.id) AS Cr_Count,
	count(DISTINCT credits.user_id) AS Users_Count,
	sum(credits.is_first_credit) AS New_Users,
	FORMAT(count(credits.id) / count(DISTINCT credits.user_id),2) AS 'Purch.Per.Usr',
	(FORMAT((sum(credits.amount_original) / count(DISTINCT credits.user_id)),0)) AS ARPPU,
	FORMAT((sum(credits.amount_original) / count(credits.id)),0) AS AvgCrdAmnt,
/*
                                                            ДЕФОЛТЫ И ОПЛАТЫ

	CASE
		WHEN MONTH(FROM_UNIXTIME(max(credits.date_create))) >= (Month(NOW()) -1) AND YEAR(FROM_UNIXTIME(max(credits.date_create))) = (YEAR(NOW()))
		OR MONTH(FROM_UNIXTIME(max(credits.date_create))) >= (Month(NOW()) +11) AND YEAR(FROM_UNIXTIME(max(credits.date_create))) = (YEAR(NOW()) -1)
		THEN 'n/a'
		ELSE
	CONCAT(FORMAT(( 
	(SELECT 
		_AMOUNT
	FROM 
	(SELECT 
		SUM(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,
		credits.shop_id AS _ID,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
		,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
	FROM Vw_Loans_Issued_two
		LEFT OUTER JOIN credits ON credits.id = Vw_Loans_Issued_two.Credit_Id
	WHERE Vw_Loans_Issued_two.`Status`= 'Default'
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		credits.shop_id) AS temp_table_1
	WHERE _YEAR = YEAR(FROM_UNIXTIME(max(credits.date_create))) AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create))) AND _ID = credits.shop_id) / sum(credits.amount_original))*100,2),'%') END AS Def_Quant,


	CASE
		WHEN MONTH(FROM_UNIXTIME(max(credits.date_create))) >= (Month(NOW()) -1) AND YEAR(FROM_UNIXTIME(max(credits.date_create))) = (YEAR(NOW()))
		OR MONTH(FROM_UNIXTIME(max(credits.date_create))) >= (Month(NOW()) +11) AND YEAR(FROM_UNIXTIME(max(credits.date_create))) = (YEAR(NOW()) -1)
		THEN 'n/a'
		ELSE
	CONCAT(FORMAT(( 
	(SELECT 
		_AMOUNT
	FROM 
	(SELECT 
		SUM(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,
		credits.shop_id AS _ID,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
		,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
	FROM Vw_Loans_Issued_two
		LEFT OUTER JOIN credits ON credits.id = Vw_Loans_Issued_two.Credit_Id
	WHERE Vw_Loans_Issued_two.`Status 30`= 'Default'
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		credits.shop_id) AS temp_table_1
	WHERE _YEAR = YEAR(FROM_UNIXTIME(max(credits.date_create))) AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create))) AND _ID = credits.shop_id) / sum(credits.amount_original))*100,2),'%') END AS Am_Def_30,

	CASE
		WHEN MONTH(FROM_UNIXTIME(max(credits.date_create))) >= (Month(NOW()) -2) AND YEAR(FROM_UNIXTIME(max(credits.date_create))) = (YEAR(NOW()))
		OR MONTH(FROM_UNIXTIME(max(credits.date_create))) >= (Month(NOW()) +10) AND YEAR(FROM_UNIXTIME(max(credits.date_create))) = (YEAR(NOW()) -1)
		THEN 'n/a'
		ELSE
	CONCAT(FORMAT(( 
	(SELECT 
		_AMOUNT
	FROM 
	(SELECT 
		SUM(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,
		credits.shop_id AS _ID,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
		,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
	FROM Vw_Loans_Issued_two
		LEFT OUTER JOIN credits ON credits.id = Vw_Loans_Issued_two.Credit_Id
	WHERE Vw_Loans_Issued_two.`Status 60`= 'Default'
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		credits.shop_id) AS temp_table_1
	WHERE _YEAR = YEAR(FROM_UNIXTIME(max(credits.date_create))) AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create))) AND _ID = credits.shop_id) / sum(credits.amount_original))*100,2),'%') END AS Am_Def_60,

	CASE
		WHEN MONTH(FROM_UNIXTIME(max(credits.date_create))) >= (Month(NOW()) -3) AND YEAR(FROM_UNIXTIME(max(credits.date_create))) = (YEAR(NOW()))
		OR MONTH(FROM_UNIXTIME(max(credits.date_create))) >= (Month(NOW()) +9) AND YEAR(FROM_UNIXTIME(max(credits.date_create))) = (YEAR(NOW()) -1)
		THEN 'n/a'
		ELSE
	CONCAT(FORMAT((
	(SELECT 
		_AMOUNT
	FROM 
	(SELECT 
		SUM(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,
		credits.shop_id AS _ID,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
		,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
	FROM Vw_Loans_Issued_two
		LEFT OUTER JOIN credits ON credits.id = Vw_Loans_Issued_two.Credit_Id
	WHERE Vw_Loans_Issued_two.`Status 90`= 'Default'
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		credits.shop_id) AS temp_table_1
	WHERE _YEAR = YEAR(FROM_UNIXTIME(max(credits.date_create))) AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create))) AND _ID = credits.shop_id) / sum(credits.amount_original))*100,2),'%') END AS Am_Def_90,
*/
 CONCAT(format((((SELECT 
			_COUNT
			FROM 
			(SELECT 
				credit_sessions.shop_id AS _ID,
				count(credit_sessions.id) AS _COUNT,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				DAY(FROM_UNIXTIME(credit_sessions.date_start)) AS _DAY,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions
			WHERE credit_sessions.is_new_user = 1 and credit_sessions.result = 'credit confirmed'
			GROUP BY
				credit_sessions.shop_id,
				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start)),
				DAY(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _DAY = DAY(FROM_UNIXTIME(credits.date_create)) AND _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create)))) )
				/  
		((SELECT 
			_COUNT
			FROM 
			(SELECT 
				credit_sessions.shop_id AS _ID,
				count(credit_sessions.id) AS _COUNT,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				DAY(FROM_UNIXTIME(credit_sessions.date_start)) AS _DAY,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions
			WHERE credit_sessions.is_new_user = 1 and credit_sessions.result IN ('credit confirmed', 'conditions not met')
			GROUP BY
				credit_sessions.shop_id,
				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start)),
				DAY(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _DAY = DAY(FROM_UNIXTIME(credits.date_create)) AND _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create))))
) )*100,2),'%') AS Approval,

		CONCAT(FORMAT(((sum(credits.amount_original) - sum(credits.amount_paid)) / sum(credits.amount_original))*100,2),'%') AS Moving_D_Rate,
		CONCAT(FORMAT(((sum(credits.amount_original) - sum(credits.amount_paid) - sum(credits.interest_paid)) / sum(credits.amount_original))*100,2),'%') AS Margin,

		CONCAT(FORMAT((((sum(Vw_Loans_Issued_two.Amount_Original)*(1 - shops.shop_commission/100)) + sum(Vw_Loans_Issued_two.Operations_Cost) - sum(Vw_Loans_Issued_two.Amount_Original_Paid) 
		- sum(Vw_Loans_Issued_two.Interest_Paid)) / (sum(credits.amount_original)*(1 - shops.shop_commission/100)))*100,2),'%') AS Margin_Net,

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
			WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create)))) 

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
			WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create)))))*100,2),'%') AS Margin_Net,
		*/
		-- ALTERNATIVE VERSION OF MARGIN NET CALC END
	CONCAT((shop_commission),'%') AS Comission,
/*
	CONCAT(FORMAT((
	(SELECT 
		_AMOUNT
	FROM 
	(SELECT 
		SUM(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,
		credits.shop_id AS _ID,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
		,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
	FROM Vw_Loans_Issued_two
		LEFT OUTER JOIN credits ON credits.id = Vw_Loans_Issued_two.Credit_Id
	WHERE Vw_Loans_Issued_two.Paid_During = 'Grace'
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		Vw_Loans_Issued_two.Paid_During,
		credits.shop_id
	) AS temp_table_1
	WHERE _YEAR = YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create)))) / sum(credits.amount_paid))*100,2),'%') AS Paid_Grace,

	CONCAT(FORMAT((
	(SELECT 
		_AMOUNT
	FROM 
	(SELECT 
		SUM(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,
		credits.shop_id AS _ID,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
		,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
	FROM Vw_Loans_Issued_two
		LEFT OUTER JOIN credits ON credits.id = Vw_Loans_Issued_two.Credit_Id
	WHERE Vw_Loans_Issued_two.Paid_During = 'Fee'
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		Vw_Loans_Issued_two.Paid_During,
		credits.shop_id
	) AS temp_table_1
	WHERE _YEAR = YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create)))) / sum(credits.amount_paid))*100,2),'%') AS Paid_Fee,

	CONCAT(FORMAT((
	(SELECT 
		_AMOUNT
	FROM 
	(SELECT 
		SUM(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,
		credits.shop_id AS _ID,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
		,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
	FROM Vw_Loans_Issued_two
		LEFT OUTER JOIN credits ON credits.id = Vw_Loans_Issued_two.Credit_Id
	WHERE Vw_Loans_Issued_two.Paid_During = 'Default'
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		Vw_Loans_Issued_two.Paid_During,
		credits.shop_id
	) AS temp_table_1
	WHERE _YEAR = YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create)))) / sum(credits.amount_paid))*100,2),'%') AS Paid_Default,

	CONCAT(FORMAT((
	(SELECT 
		_AMOUNT
	FROM 
	(SELECT 
		SUM(Vw_Loans_Issued_two.Amount_Original_Paid) AS _AMOUNT,
		credits.shop_id AS _ID,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
		,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
	FROM Vw_Loans_Issued_two
		LEFT OUTER JOIN credits ON credits.id = Vw_Loans_Issued_two.Credit_Id
	WHERE Vw_Loans_Issued_two.Status != 'Paid Back'
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		Vw_Loans_Issued_two.Paid_During,
		credits.shop_id
	) AS temp_table_1
	WHERE _YEAR = YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create)))) / sum(credits.amount_paid))*100,2),'%') AS Paid_Partially,


FORMAT(
	(SELECT 
		_DAYS
	FROM 
	(SELECT 
		credits.shop_id AS _ID,
		AVG(Vw_Loans_Issued_two.Days_To_Pay) AS _DAYS,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
		,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
	FROM Vw_Loans_Issued_two
		LEFT OUTER JOIN credits ON credits.id = Vw_Loans_Issued_two.Credit_Id
	WHERE Vw_Loans_Issued_two.Status = 'Paid Back'
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		credits.shop_id
	) AS temp_table_1
	WHERE _YEAR = YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create)))),2) AS Days_Pay_AVG,

	FORMAT(
	(SELECT 
		_DAYS
	FROM 
	(SELECT 
		credits.shop_id AS _ID,
		AVG(Vw_Loans_Issued_two.Days_To_Pay) AS _DAYS,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
		,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
	FROM Vw_Loans_Issued_two
		LEFT OUTER JOIN credits ON credits.id = Vw_Loans_Issued_two.Credit_Id
	WHERE Vw_Loans_Issued_two.Paid_During = 'Grace'
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		Vw_Loans_Issued_two.Paid_During,
		credits.shop_id
	) AS temp_table_1
	WHERE _YEAR = YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create)))),2) AS Days_Pay_Grace,

	FORMAT(
	(SELECT 
		_DAYS
	FROM 
	(SELECT 
		credits.shop_id AS _ID,
		AVG(Vw_Loans_Issued_two.Days_To_Pay) AS _DAYS,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
		,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
	FROM Vw_Loans_Issued_two
		LEFT OUTER JOIN credits ON credits.id = Vw_Loans_Issued_two.Credit_Id
	WHERE Vw_Loans_Issued_two.Paid_During = 'Fee'
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		Vw_Loans_Issued_two.Paid_During,
		credits.shop_id
	) AS temp_table_1
	WHERE _YEAR = YEAR(FROM_UNIXTIME(max(credits.date_create))) AND   _ID = credits.shop_id AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create)))),2) AS Days_Pay_Fee,

	FORMAT(
	(SELECT 
		_DAYS
	FROM 
	(SELECT 
		credits.shop_id AS _ID,
		AVG(Vw_Loans_Issued_two.Days_To_Pay) AS _DAYS,
		MONTH(Vw_Loans_Issued_two.Date_Create) AS _MONTH
		,YEAR(Vw_Loans_Issued_two.Date_Create) AS _YEAR
	FROM Vw_Loans_Issued_two
		LEFT OUTER JOIN credits ON credits.id = Vw_Loans_Issued_two.Credit_Id
	WHERE Vw_Loans_Issued_two.Paid_During = 'Default'
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create),
		YEAR(Vw_Loans_Issued_two.Date_Create),
		Vw_Loans_Issued_two.Paid_During,
		credits.shop_id
	) AS temp_table_1
	WHERE _YEAR = YEAR(FROM_UNIXTIME(max(credits.date_create))) AND _ID = credits.shop_id AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create)))),2) AS Days_Pay_Default,
*/
CONCAT(format((((SELECT 
			_COUNT
			FROM 
			(SELECT 
				credit_sessions.shop_id AS _ID,
				count(sns_profiles.gender) AS _COUNT,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				DAY(FROM_UNIXTIME(credit_sessions.date_start)) AS _DAY,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions left OUTER JOIN sns_profiles on credit_sessions.sns_profile_id = sns_profiles.id
			WHERE credit_sessions.is_new_user = 1 and credit_sessions.result = 'credit confirmed' and sns_profiles.gender = 'm'
			GROUP BY
				credit_sessions.shop_id,
				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start)),
				DAY(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _DAY = DAY(FROM_UNIXTIME(credits.date_create)) AND _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create)))) )
				/  
		((SELECT 
			_COUNT
			FROM 
			(SELECT 
				credit_sessions.shop_id AS _ID,
				count(sns_profiles.gender) AS _COUNT,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				DAY(FROM_UNIXTIME(credit_sessions.date_start)) AS _DAY,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions left OUTER JOIN sns_profiles on credit_sessions.sns_profile_id = sns_profiles.id
			WHERE credit_sessions.is_new_user = 1 and credit_sessions.result IN ('credit confirmed' /*, 'conditions not met'*/ ) and sns_profiles.gender IN ('m', 'f')
			GROUP BY
				credit_sessions.shop_id,
				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start)),
				DAY(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _DAY = DAY(FROM_UNIXTIME(credits.date_create)) AND _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create))))
) )*100,2),'%') AS 'Gender(m)',

CONCAT(format((((SELECT 
			_COUNT
			FROM 
			(SELECT 
				credit_sessions.shop_id AS _ID,
				count(sns_profiles.gender) AS _COUNT,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				DAY(FROM_UNIXTIME(credit_sessions.date_start)) AS _DAY,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions left OUTER JOIN sns_profiles on credit_sessions.sns_profile_id = sns_profiles.id
			WHERE credit_sessions.is_new_user = 1 and credit_sessions.result = 'credit confirmed' and sns_profiles.gender = 'f'
			GROUP BY
				credit_sessions.shop_id,
				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start)),
				DAY(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _DAY = DAY(FROM_UNIXTIME(credits.date_create)) AND _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create)))) )
				/  
		((SELECT 
			_COUNT
			FROM 
			(SELECT 
				credit_sessions.shop_id AS _ID,
				count(sns_profiles.id) AS _COUNT,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				DAY(FROM_UNIXTIME(credit_sessions.date_start)) AS _DAY,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions left OUTER JOIN sns_profiles on credit_sessions.sns_profile_id = sns_profiles.id
			WHERE credit_sessions.is_new_user = 1 and credit_sessions.result IN ('credit confirmed') -- 'conditions not met')
			GROUP BY
				credit_sessions.shop_id,
				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start)),
				DAY(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _DAY = DAY(FROM_UNIXTIME(credits.date_create)) AND _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create))))
) )*100,2),'%') AS 'Gender(f)',


CONCAT(format((((SELECT 
			_COUNT
			FROM 
			(SELECT 
				credit_sessions.shop_id AS _ID,
				count(credit_sessions.id) AS _COUNT,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				DAY(FROM_UNIXTIME(credit_sessions.date_start)) AS _DAY,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions
			WHERE credit_sessions.quick_session = 0 and credit_sessions.result IN('credit confirmed', 'conditions not met')
			GROUP BY
				credit_sessions.shop_id,
				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start)),
				DAY(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _DAY = DAY(FROM_UNIXTIME(credits.date_create)) AND _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create)))) )
				/  
		((SELECT 
			_COUNT
			FROM 
			(SELECT 
				credit_sessions.shop_id AS _ID,
				count(credit_sessions.id) AS _COUNT,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				DAY(FROM_UNIXTIME(credit_sessions.date_start)) AS _DAY,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions 
			WHERE credit_sessions.quick_session = 0
			GROUP BY
				credit_sessions.shop_id,
				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start)),
				DAY(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _DAY = DAY(FROM_UNIXTIME(credits.date_create)) AND  _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create))))
) )*100,2),'%') AS 'Conv_Full_Circle',


CONCAT(format((((SELECT 
			_COUNT
			FROM 
			(SELECT 
				credit_sessions.shop_id AS _ID,
				count(credit_sessions.id) AS _COUNT,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				DAY(FROM_UNIXTIME(credit_sessions.date_start)) AS _DAY,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions
			WHERE credit_sessions.quick_session = 1 and credit_sessions.result IN('credit confirmed', 'conditions not met')
			GROUP BY
				credit_sessions.shop_id,
				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start)),
				DAY(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _DAY = DAY(FROM_UNIXTIME(credits.date_create)) AND _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create)))) )
				/  
		((SELECT 
			_COUNT
			FROM 
			(SELECT 
				credit_sessions.shop_id AS _ID,
				count(credit_sessions.id) AS _COUNT,
				month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
				DAY(FROM_UNIXTIME(credit_sessions.date_start)) AS _DAY,
				year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
			FROM credit_sessions 
			WHERE credit_sessions.quick_session = 1
			GROUP BY
				credit_sessions.shop_id,
				year(FROM_UNIXTIME(credit_sessions.date_start)),
				month(FROM_UNIXTIME(credit_sessions.date_start)),
				DAY(FROM_UNIXTIME(credit_sessions.date_start))
									) AS temp_table_1
			WHERE _DAY = DAY(FROM_UNIXTIME(credits.date_create)) AND _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create))))
) )*100,2),'%') AS 'Conv_One_Click'



FROM
	credits
	LEFT OUTER JOIN shops ON credits.shop_id = shops.id
	LEFT OUTER JOIN Vw_Loans_Issued_two ON credits.id = Vw_Loans_Issued_two.Credit_Id
WHERE
	credits.shop_id NOT IN (10002/*testShop*/, 10003/*testShop*/, 10006/*Человече*/, 10007/*Военторг*/, 10004/*Zoo-Zoo*/, 10012/*ДавайНаСвидание*/)
 AND MONTH(FROM_UNIXTIME(credits.date_create)) = 01 
 AND credits.shop_id  = 10001
-- AND FROM_UNIXTIME(credits.date_create) BETWEEN '2014-01-23 23:59:59' AND '2014-01-25 00:00:00'
GROUP BY
	YEAR (FROM_UNIXTIME(credits.date_create)),
	MONTH (FROM_UNIXTIME(credits.date_create)),
	DAY(FROM_UNIXTIME(credits.date_create)),
	credits.shop_id 
	-- credits.shop_id BETWEEN '10005' AND '10005'
ORDER BY
	YEAR (FROM_UNIXTIME(credits.date_create)) ASC,
	MONTH (FROM_UNIXTIME(credits.date_create)) ASC,
	DAY(FROM_UNIXTIME(credits.date_create)) ASC,
	sum(credits.amount_original) DESC