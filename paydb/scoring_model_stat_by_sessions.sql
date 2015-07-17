SET @Date = '2014-10-27 19:00:00';
select 
	FROM_UNIXTIME(cs.date_start), 
	cs.result,
	cs.shop_id,
	scoring_model_log.flag_blocked,
	scoring_model_log.model_out,
	users.quality,
	cs.credit_id,
	cs.phone,

DATEDIFF(FROM_UNIXTIME(cs.date_start), (select _VAL from (SELECT
								paydb.extra_score_values.credit_session_id as _ID,
								-- paydb.extra_score_vars.shop_id as _ID_SHOP,
								CASE WHEN paydb.extra_score_vars.shop_id IN (10075, 10052, 10079) 
										 THEN FROM_UNIXTIME(paydb.extra_score_values.`value`)
										 ELSE paydb.extra_score_values.`value`
								END as _VAL
				from 
								paydb.extra_score_values
								LEFT OUTER JOIN extra_score_vars on extra_score_vars.id = extra_score_values.var_id
				WHERE extra_score_vars.`name` = 'subid_register_date'
) as temptable1
				WHERE _ID = cs.id)) AS days_since_reg,

cs.is_new_user,
cs.is_new_profile,
cs.sns_id,

	scoring_model_log.* 
from 
	scoring_model_log 
	INNER JOIN credit_sessions as cs on cs.id = scoring_model_log.session_id 
	INNER JOIN users on scoring_model_log.user_id = users.id
where 
	FROM_UNIXTIME(cs.date_start) > @Date 
AND scoring_model_log.flag_blocked = 1
-- and 	cs.result = 'credit confirmed'
ORDER BY 
	scoring_model_log.id desc