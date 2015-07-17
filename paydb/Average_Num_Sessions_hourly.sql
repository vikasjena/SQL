select 
hour(FROM_UNIXTIME(credit_sessions.date_start)) as Hour_1,
(SELECT COUNT_ FROM( 
				SELECT 
				count(credit_sessions.id) as COUNT_,
				hour(FROM_UNIXTIME(credit_sessions.date_start)) as HOUR_
				FROM credit_sessions
				WHERE FROM_UNIXTIME(credit_sessions.date_start) > '2014-03-01 00:00:00'
				GROUP BY 
				-- day(FROM_UNIXTIME(credit_sessions.date_start)),
				hour(FROM_UNIXTIME(credit_sessions.date_start))
				) as TEMPTABLE_1
				WHERE HOUR_ = hour(FROM_UNIXTIME(credit_sessions.date_start))) / 243 as Ses_Count

-- ,DATEDIFF(FROM_UNIXTIME(max(credit_sessions.date_start)), FROM_UNIXTIME(min(credit_sessions.date_start))) as Date_Diff

FROM
	credit_sessions
WHERE FROM_UNIXTIME(credit_sessions.date_start) > '2014-03-01 00:00:00'
GROUP BY 
	hour(FROM_UNIXTIME(credit_sessions.date_start))
