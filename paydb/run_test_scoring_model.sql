SET @Date = '2014-12-17 23:00:00';
SELECT 
FROM_UNIXTIME(`c`.date_start),
 c.result as time,
 `sl`.id,
 `c`.current_union_id,
 `sl`.session_id,
 `sl`.shop_id,
	`us`.quality,
 `sl`.model_out,
 `sl`.num_map_cluster,
 `sl`.map_out,
 `sl`.flag_blocked,
	c.scoring_model_flag
,sl.*
FROM `scoring_model_log` `sl` 
LEFT OUTER JOIN credit_sessions `c` on `c`.id = `sl`.session_id 
LEFT OUTER JOIN users `us` on `c`.user_id = `us`.id
WHERE FROM_UNIXTIME(`c`.date_start) > @Date
-- and result = 'credit confirmed'
-- and result = 'scoring model blocked'
-- and c.sns_id = "FB"
ORDER by 
FROM_UNIXTIME(`c`.date_start) DESC,
result, 
sl.model_out DESC
