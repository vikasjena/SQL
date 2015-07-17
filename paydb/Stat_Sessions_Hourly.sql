SELECT 
	CONCAT(YEAR(FROM_UNIXTIME(credit_sessions.date_start)),'-',MONTH(FROM_UNIXTIME(credit_sessions.date_start)),'-',DAY(FROM_UNIXTIME(credit_sessions.date_start))) AS Date
  ,YEAR(FROM_UNIXTIME(credit_sessions.date_start)) _Year
	,MONTH(FROM_UNIXTIME(credit_sessions.date_start)) _Month
	,DAY(FROM_UNIXTIME(credit_sessions.date_start)) AS _Day
	,HOUR(FROM_UNIXTIME(credit_sessions.date_start)) AS _Hour
	,(SELECT
			_COUNT
		FROM
				 (SELECT
						COUNT(credit_sessions.id) AS _COUNT 
						,DAY(FROM_UNIXTIME(credit_sessions.date_start)) AS DAY_
						,MONTH(FROM_UNIXTIME(credit_sessions.date_start)) AS MONTH_
						,YEAR(FROM_UNIXTIME(credit_sessions.date_start)) AS YEAR_
						,HOUR(FROM_UNIXTIME(credit_sessions.date_start)) AS HOUR_
					FROM credit_sessions 
					GROUP BY 
					  DAY(FROM_UNIXTIME(credit_sessions.date_start))
						,MONTH(FROM_UNIXTIME(credit_sessions.date_start))
						,YEAR(FROM_UNIXTIME(credit_sessions.date_start))
						,HOUR(FROM_UNIXTIME(credit_sessions.date_start))) AS Temp_Table
		WHERE 
			DAY(FROM_UNIXTIME(credit_sessions.date_start)) = DAY_ 
			AND MONTH(FROM_UNIXTIME(credit_sessions.date_start)) = MONTH_
			AND YEAR(FROM_UNIXTIME(credit_sessions.date_start)) = YEAR_
			AND HOUR(FROM_UNIXTIME(credit_sessions.date_start)) = HOUR_
) AS Count_Sess

From credit_sessions
GROUP BY
	 _Year
	,_Month
	,_Day
	,_Hour
-- GROUP BY credit_sessions.phone ORDER BY FROM_UNIXTIME(date_start) ASC