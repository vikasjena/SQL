SET @Date = '2014-11-14 19:30:00';
SELECT 
	cs.result,
	sum(cs.is_new_user) sess_with_new_users,

	(SELECT 
		_COUNT
	FROM 
		(SELECT 
			COUNT(credit_sessions.id) AS _COUNT,
			credit_sessions.result AS _RESULT
		FROM 
			credit_sessions
		WHERE 
			FROM_UNIXTIME(credit_sessions.date_start) > @Date AND 
			credit_sessions.merge_model_flag IS NOT NULL
		GROUP BY
			credit_sessions.result
			) AS temp_table_1
		WHERE _RESULT =  cs.result) AS merge_model_count,


	(SELECT 
		_COUNT
	FROM 
		(SELECT 
			COUNT(credit_sessions.id) AS _COUNT,
			credit_sessions.result AS _RESULT
		FROM 
			credit_sessions
		WHERE 
			FROM_UNIXTIME(credit_sessions.date_start) > @Date AND 
			credit_sessions.merge_model_flag = 1
		GROUP BY
			credit_sessions.result
			) AS temp_table_1
		WHERE _RESULT =  cs.result) AS merge_model_blocked,

	format((SELECT 
		_COUNT
	FROM 
		(SELECT 
			SUM(credit_sessions.amount) AS _COUNT,
			credit_sessions.result AS _RESULT
		FROM 
			credit_sessions
		WHERE 
			FROM_UNIXTIME(credit_sessions.date_start) > @Date AND 
			credit_sessions.merge_model_flag = 1
		GROUP BY
			credit_sessions.result
			) AS temp_table_1
		WHERE _RESULT =  cs.result),0) AS merge_model_blocked_sum,



	(SELECT 
		_COUNT
	FROM 
		(SELECT 
			COUNT(credit_sessions.id) AS _COUNT,
			credit_sessions.result AS _RESULT
		FROM 
			credit_sessions
		WHERE 
			FROM_UNIXTIME(credit_sessions.date_start) > @Date AND 
			credit_sessions.scoring_model_flag IS NOT NULL
		GROUP BY
			credit_sessions.result
			) AS temp_table_1
		WHERE _RESULT =  cs.result) AS scoring_model_count,

(SELECT 
		_COUNT
	FROM 
		(SELECT 
			COUNT(credit_sessions.id) AS _COUNT,
			credit_sessions.result AS _RESULT
		FROM 
			credit_sessions
		WHERE 
			FROM_UNIXTIME(credit_sessions.date_start) > @Date AND 
			credit_sessions.scoring_model_flag = 1
		GROUP BY
			credit_sessions.result
			) AS temp_table_1
		WHERE _RESULT =  cs.result) AS scoring_model_blocked,

format((SELECT 
		_COUNT
	FROM 
		(SELECT 
			SUM(credit_sessions.amount) AS _COUNT,
			credit_sessions.result AS _RESULT
		FROM 
			credit_sessions
		WHERE 
			FROM_UNIXTIME(credit_sessions.date_start) > @Date AND 
			credit_sessions.scoring_model_flag = 1
		GROUP BY
			credit_sessions.result
			) AS temp_table_1
		WHERE _RESULT =  cs.result),0) AS scoring_model_blocked_sum,

(SELECT 
		_COUNT
	FROM 
		(SELECT 
			COUNT(credits.id) AS _COUNT
		FROM 
			credits
		WHERE 
			credits.is_first_credit = 1
			AND FROM_UNIXTIME(credits.date_create) > @Date
			) AS temp_table_1
) AS first_credits

FROM
	credit_sessions as cs
WHERE
-- 	cs.is_new_user = 1	AND 
		FROM_UNIXTIME(cs.date_start) > @Date
GROUP BY
	cs.result
ORDER BY 
	merge_model_count DESC
	
;
select 
	FROM_UNIXTIME(cs.date_start), 
	cs.result,
	(SELECT _COUNT FROM (SELECT
								credits.user_id as _ID,
								count(credits.id) as _COUNT
								FROM credits
								GROUP BY credits.user_id) as TEMP_TBS
								WHERE _ID = cs.user_id
								) as purchases,
	
scoring_model_log.model_out,
scoring_model_log.sum_map_coef,
scoring_model_log.flag_blocked,
	scoring_model_log.* 
from 
	scoring_model_log 
	INNER JOIN credit_sessions as cs on cs.id = scoring_model_log.session_id 
where 
	FROM_UNIXTIME(cs.date_start) > @Date
ORDER BY 
	scoring_model_log.id desc  