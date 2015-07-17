SELECT 
YEAR(FROM_UNIXTIME(credit_sessions.date_start)) as Ye,
MONTH(FROM_UNIXTIME(credit_sessions.date_start)) as Mo,

CONCAT(format(
			(
			SELECT 
					_COUNT
			FROM 
			(
			SELECT 
				COUNT(credit_sessions.id) AS _COUNT,
				YEAR(FROM_UNIXTIME(credit_sessions.date_start)) as _YEAR,
				MONTH(FROM_UNIXTIME(credit_sessions.date_start)) as _MONTH
			FROM credit_sessions
				WHERE (credit_sessions.date_auth IS NOT NULL OR credit_sessions.quick_session = 1) AND credit_sessions.shop_id NOT IN (10010, 10009)
						-- 	AND credit_sessions.is_new_user = 1
			GROUP BY
				YEAR(FROM_UNIXTIME(credit_sessions.date_start))
				,MONTH(FROM_UNIXTIME(credit_sessions.date_start))
		) AS temp_table_1
			WHERE _YEAR = YEAR(FROM_UNIXTIME(credit_sessions.date_start)) 
		AND _MONTH = 	MONTH(FROM_UNIXTIME(credit_sessions.date_start))
		)
		/  
		(
		SELECT 
				_COUNT
			FROM 
			(
			SELECT 
				COUNT(credit_sessions.id) AS _COUNT,
				YEAR(FROM_UNIXTIME(credit_sessions.date_start)) as _YEAR,
				MONTH(FROM_UNIXTIME(credit_sessions.date_start)) as _MONTH
			FROM credit_sessions
				WHERE credit_sessions.date_start IS NOT NULL AND credit_sessions.shop_id NOT IN (10010, 10009)
					-- 		AND credit_sessions.is_new_user = 1
				GROUP BY
					YEAR(FROM_UNIXTIME(credit_sessions.date_start))
					,MONTH(FROM_UNIXTIME(credit_sessions.date_start))
			 ) AS temp_table_1
			WHERE _YEAR = YEAR(FROM_UNIXTIME(credit_sessions.date_start)) 
		AND _MONTH = 	MONTH(FROM_UNIXTIME(credit_sessions.date_start))
)*100,2),'%') AS 'Social_Network'
,
CONCAT(format(
			(
			SELECT 
					_COUNT
			FROM 
			(
			SELECT 
				COUNT(credit_sessions.id) AS _COUNT,
				YEAR(FROM_UNIXTIME(credit_sessions.date_start)) as _YEAR,
				MONTH(FROM_UNIXTIME(credit_sessions.date_start)) as _MONTH
			FROM credit_sessions
				WHERE (credit_sessions.date_sms IS NOT NULL OR credit_sessions.quick_session = 1) AND credit_sessions.shop_id NOT IN (10010, 10009)
			GROUP BY
				YEAR(FROM_UNIXTIME(credit_sessions.date_start))
				,MONTH(FROM_UNIXTIME(credit_sessions.date_start))
		) AS temp_table_1
			WHERE _YEAR = YEAR(FROM_UNIXTIME(credit_sessions.date_start)) 
		AND _MONTH = 	MONTH(FROM_UNIXTIME(credit_sessions.date_start))
		)
		/  
		(
		SELECT 
				_COUNT
			FROM 
			(
			SELECT 
				COUNT(credit_sessions.id) AS _COUNT,
				YEAR(FROM_UNIXTIME(credit_sessions.date_start)) as _YEAR,
				MONTH(FROM_UNIXTIME(credit_sessions.date_start)) as _MONTH
			FROM credit_sessions
				WHERE credit_sessions.date_start IS NOT NULL AND credit_sessions.shop_id NOT IN (10010, 10009)
							-- AND credit_sessions.is_new_user = 1
			GROUP BY
				YEAR(FROM_UNIXTIME(credit_sessions.date_start))
				,MONTH(FROM_UNIXTIME(credit_sessions.date_start))
							 ) AS temp_table_1
			WHERE _YEAR = YEAR(FROM_UNIXTIME(credit_sessions.date_start)) 
		AND _MONTH = 	MONTH(FROM_UNIXTIME(credit_sessions.date_start))
)*100,2),'%') AS 'Phone_Number'
,
CONCAT(format(
			(
			SELECT 
					_COUNT
			FROM 
			(
			SELECT 
				COUNT(credit_sessions.id) AS _COUNT,
				YEAR(FROM_UNIXTIME(credit_sessions.date_start)) as _YEAR,
				MONTH(FROM_UNIXTIME(credit_sessions.date_start)) as _MONTH
			FROM credit_sessions
				WHERE credit_sessions.credit_id IS NOT NULL AND credit_sessions.shop_id NOT IN (10010, 10009)
							-- AND credit_sessions.is_new_user = 1
			GROUP BY
				YEAR(FROM_UNIXTIME(credit_sessions.date_start))
				,MONTH(FROM_UNIXTIME(credit_sessions.date_start))
						) AS temp_table_1
			WHERE _YEAR = YEAR(FROM_UNIXTIME(credit_sessions.date_start)) 
		AND _MONTH = 	MONTH(FROM_UNIXTIME(credit_sessions.date_start))
		)
		/  
		(
		SELECT 
				_COUNT
			FROM 
			(
			SELECT 
				COUNT(credit_sessions.id) AS _COUNT,
				YEAR(FROM_UNIXTIME(credit_sessions.date_start)) as _YEAR,
				MONTH(FROM_UNIXTIME(credit_sessions.date_start)) as _MONTH
			FROM credit_sessions
				WHERE credit_sessions.date_start IS NOT NULL AND credit_sessions.shop_id NOT IN (10010, 10009)
							-- AND credit_sessions.is_new_user = 1
							GROUP BY
				YEAR(FROM_UNIXTIME(credit_sessions.date_start))
				,MONTH(FROM_UNIXTIME(credit_sessions.date_start))
			 ) AS temp_table_1
			WHERE _YEAR = YEAR(FROM_UNIXTIME(credit_sessions.date_start)) 
		AND _MONTH = 	MONTH(FROM_UNIXTIME(credit_sessions.date_start))
)*100,2),'%') AS 'Score_Ok'

FROM 
credit_sessions
GROUP BY
YEAR(FROM_UNIXTIME(credit_sessions.date_start)),
MONTH(FROM_UNIXTIME(credit_sessions.date_start))
