SELECT
	CONCAT(YEAR(FROM_UNIXTIME(credits.date_create)),'-',MONTH (FROM_UNIXTIME(max(credits.date_create)))) AS 'Date',
-- 	MONTH(FROM_UNIXTIME(max(credits.date_create))) AS Month_,
-- 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AS Year_,
	credits.shop_id,
	shops.short_name,
	FORMAT(sum(credits.amount_original),2) AS Amount_Original,
	count(credits.is_first_credit) AS Cred_Count,

format((((SELECT 
				_COUNT
				FROM 
				(SELECT 
					credit_sessions.shop_id AS _ID,
					count(credit_sessions.id) AS _COUNT,
					month(FROM_UNIXTIME(credit_sessions.date_start)) AS _MONTH,
					year(FROM_UNIXTIME(credit_sessions.date_start)) AS _YEAR
				FROM credit_sessions
				-- WHERE (Vw_Sessions_Unions_By_Days.is_new_user = 1 OR Vw_Sessions_Unions_By_Days.is_new_user IS NULL)
				GROUP BY
					credit_sessions.shop_id,
					year(FROM_UNIXTIME(credit_sessions.date_start)),
					Month(FROM_UNIXTIME(credit_sessions.date_start))
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) 
							AND  _ID = credits.shop_id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create))))) ),0) AS 'All_Clicks',


format((((SELECT 
				_COUNT
				FROM 
				(SELECT 
					Vw_Sessions_Unions_By_Days.shop_id AS _ID,
					count(Vw_Sessions_Unions_By_Days.id) AS _COUNT,
					month(Vw_Sessions_Unions_By_Days.date_start) AS _MONTH,
					year(Vw_Sessions_Unions_By_Days.date_start) AS _YEAR
				FROM Vw_Sessions_Unions_By_Days
				-- WHERE (Vw_Sessions_Unions_By_Days.is_new_user = 1 OR Vw_Sessions_Unions_By_Days.is_new_user IS NULL)
				GROUP BY
					Vw_Sessions_Unions_By_Days.shop_id,
					year(Vw_Sessions_Unions_By_Days.date_start),
					month(Vw_Sessions_Unions_By_Days.date_start)
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) 
							AND  _ID = credits.shop_id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create))))) ),0) AS 'All_Unique_Clicks',

format((((SELECT 
				_COUNT
				FROM 
				(SELECT 
					Vw_Sessions_Unions_By_Days.shop_id AS _ID,
					sum(Vw_Sessions_Unions_By_Days.about_opened) AS _COUNT,
					month(Vw_Sessions_Unions_By_Days.date_start) AS _MONTH,
					year(Vw_Sessions_Unions_By_Days.date_start) AS _YEAR
				FROM Vw_Sessions_Unions_By_Days
				-- WHERE (Vw_Sessions_Unions_By_Days.is_new_user = 1 OR Vw_Sessions_Unions_By_Days.is_new_user IS NULL)
				GROUP BY
					Vw_Sessions_Unions_By_Days.shop_id,
					year(Vw_Sessions_Unions_By_Days.date_start),
					month(Vw_Sessions_Unions_By_Days.date_start)
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) 
							AND  _ID = credits.shop_id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create))))) ),0) AS 'All_About_Clicks',

format((((SELECT 
				_COUNT
				FROM 
				(SELECT 
					Vw_Sessions_Unions_By_Days.shop_id AS _ID,
					sum(Vw_Sessions_Unions_By_Days.about_opened) AS _COUNT,
					month(Vw_Sessions_Unions_By_Days.date_start) AS _MONTH,
					year(Vw_Sessions_Unions_By_Days.date_start) AS _YEAR
				FROM Vw_Sessions_Unions_By_Days
				WHERE (Vw_Sessions_Unions_By_Days.is_new_user = 1 OR Vw_Sessions_Unions_By_Days.is_new_user IS NULL)
				GROUP BY
					Vw_Sessions_Unions_By_Days.shop_id,
					year(Vw_Sessions_Unions_By_Days.date_start),
					month(Vw_Sessions_Unions_By_Days.date_start)
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) 
							AND  _ID = credits.shop_id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create))))) ),0) AS 'New_About_Clicks',

format((((SELECT 
				_COUNT
				FROM 
				(SELECT 
					Vw_Sessions_Unions_By_Days.shop_id AS _ID,
					count(Vw_Sessions_Unions_By_Days.id) AS _COUNT,
					month(Vw_Sessions_Unions_By_Days.date_start) AS _MONTH,
					year(Vw_Sessions_Unions_By_Days.date_start) AS _YEAR
				FROM Vw_Sessions_Unions_By_Days
				WHERE Vw_Sessions_Unions_By_Days.finish_by_condition_id = 1
						-- Vw_Sessions_Unions_By_Days.code_conf_bin = 1 -- AND Vw_Sessions_Unions_By_Days.is_new_user != 0
				GROUP BY
					Vw_Sessions_Unions_By_Days.shop_id,
					year(Vw_Sessions_Unions_By_Days.date_start),
					month(Vw_Sessions_Unions_By_Days.date_start)
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) 
							AND  _ID = credits.shop_id  AND _MONTH = MONTH (FROM_UNIXTIME(max(credits.date_create))))) ),0) AS 'All_Finished',

format((((SELECT 
				_COUNT
				FROM 
				(SELECT 
					Vw_Sessions_Unions_By_Days.shop_id AS _ID,
					count(Vw_Sessions_Unions_By_Days.id) AS _COUNT,
					month(Vw_Sessions_Unions_By_Days.date_start) AS _MONTH,
					year(Vw_Sessions_Unions_By_Days.date_start) AS _YEAR
				FROM Vw_Sessions_Unions_By_Days
				WHERE Vw_Sessions_Unions_By_Days.credit_confirmed_bin = 1 -- and Vw_Sessions_Unions_By_Days.is_new_user = 1
				GROUP BY
					Vw_Sessions_Unions_By_Days.shop_id,
					year(Vw_Sessions_Unions_By_Days.date_start),
					month(Vw_Sessions_Unions_By_Days.date_start)
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) 
							AND  _ID = credits.shop_id  AND _MONTH = MONTH (FROM_UNIXTIME(max(credits.date_create))))) ),0) AS 'All_Purchased',

format((((SELECT 
				_COUNT
				FROM 
				(SELECT 
					Vw_Sessions_Unions_By_Days.shop_id AS _ID,
					count(Vw_Sessions_Unions_By_Days.id) AS _COUNT,
					month(Vw_Sessions_Unions_By_Days.date_start) AS _MONTH,
					year(Vw_Sessions_Unions_By_Days.date_start) AS _YEAR
				FROM Vw_Sessions_Unions_By_Days
				WHERE (Vw_Sessions_Unions_By_Days.is_new_user = 1 OR Vw_Sessions_Unions_By_Days.is_new_user IS NULL)
				GROUP BY
					Vw_Sessions_Unions_By_Days.shop_id,
					year(Vw_Sessions_Unions_By_Days.date_start),
					month(Vw_Sessions_Unions_By_Days.date_start)
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) 
							AND  _ID = credits.shop_id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create))))) ),0) AS 'New_Unique_Clicks',

format((((SELECT 
				_COUNT
				FROM 
				(SELECT 
					Vw_Sessions_Unions_By_Days.shop_id AS _ID,
					count(Vw_Sessions_Unions_By_Days.id) AS _COUNT,
					month(Vw_Sessions_Unions_By_Days.date_start) AS _MONTH,
					year(Vw_Sessions_Unions_By_Days.date_start) AS _YEAR
				FROM Vw_Sessions_Unions_By_Days
				WHERE Vw_Sessions_Unions_By_Days.sn_click_bin = 1 and (Vw_Sessions_Unions_By_Days.is_new_user = 1 OR Vw_Sessions_Unions_By_Days.is_new_user IS NULL)
							-- Vw_Sessions_Unions_By_Days.code_conf_bin = 1 
				GROUP BY
					Vw_Sessions_Unions_By_Days.shop_id,
					year(Vw_Sessions_Unions_By_Days.date_start),
					month(Vw_Sessions_Unions_By_Days.date_start)
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) 
							AND  _ID = credits.shop_id  AND _MONTH = MONTH (FROM_UNIXTIME(max(credits.date_create))))) ),0) AS 'New_SN_Clicks',

format((((SELECT 
				_COUNT
				FROM 
				(SELECT 
					Vw_Sessions_Unions_By_Days.shop_id AS _ID,
					count(Vw_Sessions_Unions_By_Days.id) AS _COUNT,
					month(Vw_Sessions_Unions_By_Days.date_start) AS _MONTH,
					year(Vw_Sessions_Unions_By_Days.date_start) AS _YEAR
				FROM Vw_Sessions_Unions_By_Days
				WHERE Vw_Sessions_Unions_By_Days.permission_ok_bin = 1 and (Vw_Sessions_Unions_By_Days.is_new_user = 1 OR Vw_Sessions_Unions_By_Days.is_new_user IS NULL)
							-- Vw_Sessions_Unions_By_Days.code_conf_bin = 1 
				GROUP BY
					Vw_Sessions_Unions_By_Days.shop_id,
					year(Vw_Sessions_Unions_By_Days.date_start),
					month(Vw_Sessions_Unions_By_Days.date_start)
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) 
							AND  _ID = credits.shop_id  AND _MONTH = MONTH (FROM_UNIXTIME(max(credits.date_create))))) ),0) AS 'New_SN_Oks',

format((((SELECT 
				_COUNT
				FROM 
				(SELECT 
					Vw_Sessions_Unions_By_Days.shop_id AS _ID,
					count(Vw_Sessions_Unions_By_Days.id) AS _COUNT,
					month(Vw_Sessions_Unions_By_Days.date_start) AS _MONTH,
					year(Vw_Sessions_Unions_By_Days.date_start) AS _YEAR
				FROM Vw_Sessions_Unions_By_Days
				WHERE Vw_Sessions_Unions_By_Days.phone_enter_bin = 1 and (Vw_Sessions_Unions_By_Days.is_new_user = 1 OR Vw_Sessions_Unions_By_Days.is_new_user IS NULL)
							-- Vw_Sessions_Unions_By_Days.code_conf_bin = 1 
				GROUP BY
					Vw_Sessions_Unions_By_Days.shop_id,
					year(Vw_Sessions_Unions_By_Days.date_start),
					month(Vw_Sessions_Unions_By_Days.date_start)
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) 
							AND  _ID = credits.shop_id  AND _MONTH = MONTH (FROM_UNIXTIME(max(credits.date_create))))) ),0) AS 'New_Phones',

format((((SELECT 
				_COUNT
				FROM 
				(SELECT 
					Vw_Sessions_Unions_By_Days.shop_id AS _ID,
					count(Vw_Sessions_Unions_By_Days.id) AS _COUNT,
					month(Vw_Sessions_Unions_By_Days.date_start) AS _MONTH,
					year(Vw_Sessions_Unions_By_Days.date_start) AS _YEAR
				FROM Vw_Sessions_Unions_By_Days
				WHERE Vw_Sessions_Unions_By_Days.finish_by_condition_id = 1 and (Vw_Sessions_Unions_By_Days.is_new_user = 1 OR Vw_Sessions_Unions_By_Days.is_new_user IS NULL)
							-- Vw_Sessions_Unions_By_Days.code_conf_bin = 1 
				GROUP BY
					Vw_Sessions_Unions_By_Days.shop_id,
					year(Vw_Sessions_Unions_By_Days.date_start),
					month(Vw_Sessions_Unions_By_Days.date_start)
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) 
							AND  _ID = credits.shop_id  AND _MONTH = MONTH (FROM_UNIXTIME(max(credits.date_create))))) ),0) AS 'New_Finished',

format((((SELECT 
				_COUNT
				FROM 
				(SELECT 
					Vw_Sessions_Unions_By_Days.shop_id AS _ID,
					count(Vw_Sessions_Unions_By_Days.id) AS _COUNT,
					month(Vw_Sessions_Unions_By_Days.date_start) AS _MONTH,
					year(Vw_Sessions_Unions_By_Days.date_start) AS _YEAR
				FROM Vw_Sessions_Unions_By_Days
				WHERE Vw_Sessions_Unions_By_Days.credit_confirmed_bin = 1 and (Vw_Sessions_Unions_By_Days.is_new_user = 1 OR Vw_Sessions_Unions_By_Days.is_new_user IS NULL) -- and Vw_Sessions_Unions_By_Days.is_new_user = 1
				GROUP BY
					Vw_Sessions_Unions_By_Days.shop_id,
					year(Vw_Sessions_Unions_By_Days.date_start),
					month(Vw_Sessions_Unions_By_Days.date_start)
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) 
							AND  _ID = credits.shop_id  AND _MONTH = MONTH (FROM_UNIXTIME(max(credits.date_create))))) ),0) AS 'New_Purchased',

	
/* ----------------------------------------------------- NEW UNIQUE USERS SALES CONVERSION BEGINNING ----------------------------------------------------------------------*/

CONCAT(format((((SELECT 
				_COUNT
				FROM 
				(SELECT 
					Vw_Sessions_Unions_By_Days.shop_id AS _ID,
					count(Vw_Sessions_Unions_By_Days.id) AS _COUNT,
					month(Vw_Sessions_Unions_By_Days.date_start) AS _MONTH,
					year(Vw_Sessions_Unions_By_Days.date_start) AS _YEAR
				FROM Vw_Sessions_Unions_By_Days
				WHERE Vw_Sessions_Unions_By_Days.sn_click_bin = 1 and (Vw_Sessions_Unions_By_Days.is_new_user = 1 OR Vw_Sessions_Unions_By_Days.is_new_user IS NULL)
				GROUP BY
					Vw_Sessions_Unions_By_Days.shop_id,
					year(Vw_Sessions_Unions_By_Days.date_start),
					month(Vw_Sessions_Unions_By_Days.date_start)
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id  AND _MONTH = MONTH (FROM_UNIXTIME(max(credits.date_create)))) )
					/  
			((SELECT 
				_COUNT
				FROM 
				(SELECT 
					Vw_Sessions_Unions_By_Days.shop_id AS _ID,
					count(Vw_Sessions_Unions_By_Days.id) AS _COUNT,
					month(Vw_Sessions_Unions_By_Days.date_start) AS _MONTH,
					year(Vw_Sessions_Unions_By_Days.date_start) AS _YEAR
				FROM Vw_Sessions_Unions_By_Days 
				WHERE (Vw_Sessions_Unions_By_Days.is_new_user = 1 OR Vw_Sessions_Unions_By_Days.is_new_user IS NULL)
				GROUP BY
					Vw_Sessions_Unions_By_Days.shop_id,
					year(Vw_Sessions_Unions_By_Days.date_start),
					month(Vw_Sessions_Unions_By_Days.date_start)
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id  AND _MONTH = MONTH (FROM_UNIXTIME(max(credits.date_create))))
	) )*100,2),'%') AS 'Conv_to_SN_New',


CONCAT(format((((SELECT 
				_COUNT
				FROM 
				(SELECT 
					Vw_Sessions_Unions_By_Days.shop_id AS _ID,
					count(Vw_Sessions_Unions_By_Days.id) AS _COUNT,
					month(Vw_Sessions_Unions_By_Days.date_start) AS _MONTH,
					year(Vw_Sessions_Unions_By_Days.date_start) AS _YEAR
				FROM Vw_Sessions_Unions_By_Days
				WHERE Vw_Sessions_Unions_By_Days.permission_ok_bin = 1 and (Vw_Sessions_Unions_By_Days.is_new_user = 1 OR Vw_Sessions_Unions_By_Days.is_new_user IS NULL)
				GROUP BY
					Vw_Sessions_Unions_By_Days.shop_id,
					year(Vw_Sessions_Unions_By_Days.date_start),
					month(Vw_Sessions_Unions_By_Days.date_start)
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id  AND _MONTH = MONTH (FROM_UNIXTIME(max(credits.date_create)))) )
					/  
			((SELECT 
				_COUNT
				FROM 
				(SELECT 
					Vw_Sessions_Unions_By_Days.shop_id AS _ID,
					count(Vw_Sessions_Unions_By_Days.id) AS _COUNT,
					month(Vw_Sessions_Unions_By_Days.date_start) AS _MONTH,
					year(Vw_Sessions_Unions_By_Days.date_start) AS _YEAR
				FROM Vw_Sessions_Unions_By_Days 
				WHERE (Vw_Sessions_Unions_By_Days.is_new_user = 1 OR Vw_Sessions_Unions_By_Days.is_new_user IS NULL)
				GROUP BY
					Vw_Sessions_Unions_By_Days.shop_id,
					year(Vw_Sessions_Unions_By_Days.date_start),
					month(Vw_Sessions_Unions_By_Days.date_start)
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id  AND _MONTH = MONTH (FROM_UNIXTIME(max(credits.date_create))))
	) )*100,2),'%') AS 'Conv_to_SN_Ok_New',

CONCAT(format((((SELECT 
				_COUNT
				FROM 
				(SELECT 
					Vw_Sessions_Unions_By_Days.shop_id AS _ID,
					count(Vw_Sessions_Unions_By_Days.id) AS _COUNT,
					month(Vw_Sessions_Unions_By_Days.date_start) AS _MONTH,
					year(Vw_Sessions_Unions_By_Days.date_start) AS _YEAR
				FROM Vw_Sessions_Unions_By_Days
				WHERE Vw_Sessions_Unions_By_Days.phone_enter_bin = 1 and (Vw_Sessions_Unions_By_Days.is_new_user = 1 OR Vw_Sessions_Unions_By_Days.is_new_user IS NULL)
				GROUP BY
					Vw_Sessions_Unions_By_Days.shop_id,
					year(Vw_Sessions_Unions_By_Days.date_start),
					month(Vw_Sessions_Unions_By_Days.date_start)
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id  AND _MONTH = MONTH (FROM_UNIXTIME(max(credits.date_create)))) )
					/  
			((SELECT 
				_COUNT
				FROM 
				(SELECT 
					Vw_Sessions_Unions_By_Days.shop_id AS _ID,
					count(Vw_Sessions_Unions_By_Days.id) AS _COUNT,
					month(Vw_Sessions_Unions_By_Days.date_start) AS _MONTH,
					year(Vw_Sessions_Unions_By_Days.date_start) AS _YEAR
				FROM Vw_Sessions_Unions_By_Days 
				WHERE (Vw_Sessions_Unions_By_Days.is_new_user = 1 OR Vw_Sessions_Unions_By_Days.is_new_user IS NULL)
				GROUP BY
					Vw_Sessions_Unions_By_Days.shop_id,
					year(Vw_Sessions_Unions_By_Days.date_start),
					month(Vw_Sessions_Unions_By_Days.date_start)
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id  AND _MONTH = MONTH (FROM_UNIXTIME(max(credits.date_create))))
	) )*100,2),'%') AS 'Conv_to_phone_New',



CONCAT(format((((SELECT 
				_COUNT
				FROM 
				(SELECT 
					Vw_Sessions_Unions_By_Days.shop_id AS _ID,
					count(Vw_Sessions_Unions_By_Days.id) AS _COUNT,
					month(Vw_Sessions_Unions_By_Days.date_start) AS _MONTH,
					year(Vw_Sessions_Unions_By_Days.date_start) AS _YEAR
				FROM Vw_Sessions_Unions_By_Days
				WHERE Vw_Sessions_Unions_By_Days.finish_by_condition_id = 1 and (Vw_Sessions_Unions_By_Days.is_new_user = 1 OR Vw_Sessions_Unions_By_Days.is_new_user IS NULL)
				GROUP BY
					Vw_Sessions_Unions_By_Days.shop_id,
					year(Vw_Sessions_Unions_By_Days.date_start),
					month(Vw_Sessions_Unions_By_Days.date_start)
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id  AND _MONTH = MONTH (FROM_UNIXTIME(max(credits.date_create)))) )
					/  
			((SELECT 
				_COUNT
				FROM 
				(SELECT 
					Vw_Sessions_Unions_By_Days.shop_id AS _ID,
					count(Vw_Sessions_Unions_By_Days.id) AS _COUNT,
					month(Vw_Sessions_Unions_By_Days.date_start) AS _MONTH,
					year(Vw_Sessions_Unions_By_Days.date_start) AS _YEAR
				FROM Vw_Sessions_Unions_By_Days 
				WHERE (Vw_Sessions_Unions_By_Days.is_new_user = 1 OR Vw_Sessions_Unions_By_Days.is_new_user IS NULL)
				GROUP BY
					Vw_Sessions_Unions_By_Days.shop_id,
					year(Vw_Sessions_Unions_By_Days.date_start),
					month(Vw_Sessions_Unions_By_Days.date_start)
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id  AND _MONTH = MONTH (FROM_UNIXTIME(max(credits.date_create))))
	) )*100,2),'%') AS 'Conv_to_finish_New',


CONCAT(format((((SELECT 
				_COUNT
				FROM 
				(SELECT 
					Vw_Sessions_Unions_By_Days.shop_id AS _ID,
					count(Vw_Sessions_Unions_By_Days.id) AS _COUNT,
					month(Vw_Sessions_Unions_By_Days.date_start) AS _MONTH,
					year(Vw_Sessions_Unions_By_Days.date_start) AS _YEAR
				FROM Vw_Sessions_Unions_By_Days
				WHERE Vw_Sessions_Unions_By_Days.credit_confirmed_bin = 1 and (Vw_Sessions_Unions_By_Days.is_new_user = 1 OR Vw_Sessions_Unions_By_Days.is_new_user IS NULL)
				GROUP BY
					Vw_Sessions_Unions_By_Days.shop_id,
					year(Vw_Sessions_Unions_By_Days.date_start),
					month(Vw_Sessions_Unions_By_Days.date_start)
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id  AND _MONTH = MONTH (FROM_UNIXTIME(max(credits.date_create)))) )
					/  
			((SELECT 
				_COUNT
				FROM 
				(SELECT 
					Vw_Sessions_Unions_By_Days.shop_id AS _ID,
					count(Vw_Sessions_Unions_By_Days.id) AS _COUNT,
					month(Vw_Sessions_Unions_By_Days.date_start) AS _MONTH,
					year(Vw_Sessions_Unions_By_Days.date_start) AS _YEAR
				FROM Vw_Sessions_Unions_By_Days 
				WHERE (Vw_Sessions_Unions_By_Days.is_new_user = 1 OR Vw_Sessions_Unions_By_Days.is_new_user IS NULL)
				GROUP BY
					Vw_Sessions_Unions_By_Days.shop_id,
					year(Vw_Sessions_Unions_By_Days.date_start),
					month(Vw_Sessions_Unions_By_Days.date_start)
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id  AND _MONTH = MONTH (FROM_UNIXTIME(max(credits.date_create))))
	) )*100,2),'%') AS 'Conv_to_purch_New',



/* ----------------------------------------------------- NEW UNIQUE USERS SALES CONVERSION END ----------------------------------------------------------------------*/


CONCAT(format((((SELECT 
				_COUNT
				FROM 
				(SELECT 
					Vw_Sessions_Unions_By_Days.shop_id AS _ID,
					count(Vw_Sessions_Unions_By_Days.id) AS _COUNT,
					month(Vw_Sessions_Unions_By_Days.date_start) AS _MONTH,
					year(Vw_Sessions_Unions_By_Days.date_start) AS _YEAR
				FROM Vw_Sessions_Unions_By_Days
				WHERE Vw_Sessions_Unions_By_Days.credit_confirmed_bin = 1 and Vw_Sessions_Unions_By_Days.is_new_user = 0
				GROUP BY
					Vw_Sessions_Unions_By_Days.shop_id,
					year(Vw_Sessions_Unions_By_Days.date_start),
					month(Vw_Sessions_Unions_By_Days.date_start)
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id  AND _MONTH = MONTH (FROM_UNIXTIME(max(credits.date_create)))) )
					/  
			((SELECT 
				_COUNT
				FROM 
				(SELECT 
					Vw_Sessions_Unions_By_Days.shop_id AS _ID,
					count(Vw_Sessions_Unions_By_Days.id) AS _COUNT,
					month(Vw_Sessions_Unions_By_Days.date_start) AS _MONTH,
					year(Vw_Sessions_Unions_By_Days.date_start) AS _YEAR
				FROM Vw_Sessions_Unions_By_Days 
				WHERE Vw_Sessions_Unions_By_Days.is_new_user = 0
				GROUP BY
					Vw_Sessions_Unions_By_Days.shop_id,
					year(Vw_Sessions_Unions_By_Days.date_start),
					month(Vw_Sessions_Unions_By_Days.date_start)
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create))))
	) )*100,2),'%') AS 'Conv_to_purch_Old',

	CONCAT(format((((SELECT 
				_COUNT
				FROM 
				(SELECT 
					Vw_Sessions_Unions_By_Days.shop_id AS _ID,
					count(Vw_Sessions_Unions_By_Days.id) AS _COUNT,
					month(Vw_Sessions_Unions_By_Days.date_start) AS _MONTH,
					year(Vw_Sessions_Unions_By_Days.date_start) AS _YEAR
				FROM Vw_Sessions_Unions_By_Days
				WHERE Vw_Sessions_Unions_By_Days.credit_confirmed_bin = 1
				GROUP BY
					Vw_Sessions_Unions_By_Days.shop_id,
					year(Vw_Sessions_Unions_By_Days.date_start),
					month(Vw_Sessions_Unions_By_Days.date_start)
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id  AND _MONTH = MONTH (FROM_UNIXTIME(max(credits.date_create)))) )
					/  
			((SELECT 
				_COUNT
				FROM 
				(SELECT 
					Vw_Sessions_Unions_By_Days.shop_id AS _ID,
					count(Vw_Sessions_Unions_By_Days.id) AS _COUNT,
					month(Vw_Sessions_Unions_By_Days.date_start) AS _MONTH,
					year(Vw_Sessions_Unions_By_Days.date_start) AS _YEAR
				FROM Vw_Sessions_Unions_By_Days 
			-- WHERE 
				GROUP BY
					Vw_Sessions_Unions_By_Days.shop_id,
					year(Vw_Sessions_Unions_By_Days.date_start),
					month(Vw_Sessions_Unions_By_Days.date_start)
										) AS temp_table_1
				WHERE _YEAR = 	YEAR(FROM_UNIXTIME(max(credits.date_create))) AND  _ID = credits.shop_id  AND _MONTH = 	MONTH (FROM_UNIXTIME(max(credits.date_create))))
	) )*100,2),'%') AS 'Conv_to_purch_All'



FROM
	credits
	LEFT OUTER JOIN shops ON credits.shop_id = shops.id
	LEFT OUTER JOIN Vw_Loans_Issued_two ON credits.id = Vw_Loans_Issued_two.Credit_Id
WHERE
	credits.shop_id NOT IN (10002/*testShop*/, 10003/*testShop*/, 10036 /*testShop*/) -- ,10013, 10012, 10006, 10053, 10059, 10056, 10041, 10044, 10026,
 -- 10039, 10031, 10043, 10055, 10008, 10040, 10030, 10045) -- , 10006/*Человече*/, 10007/*Военторг*/, 10004/*Zoo-Zoo*/, 10012/*ДавайНаСвидание*/) -- and credits.shop_id = 10001
-- AND shops.id = 10001
-- AND FROM_UNIXTIME(credits.date_create) BETWEEN '2014-01-23 23:59:59' AND '2014-01-25 00:00:00'
GROUP BY
	YEAR (FROM_UNIXTIME(credits.date_create)),
	MONTH (FROM_UNIXTIME(credits.date_create)),
	credits.shop_id 
	-- credits.shop_id BETWEEN '10005' AND '10005'
ORDER BY
	YEAR (FROM_UNIXTIME(credits.date_create)) ASC,
	MONTH (FROM_UNIXTIME(credits.date_create)) ASC,
	sum(credits.amount_original) DESC