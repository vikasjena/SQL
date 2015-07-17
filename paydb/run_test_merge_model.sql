SET @Date = '2014-10-29 13:00:00';
select 
FROM_UNIXTIME(c.date_start) as time,
c.id,
c.amount,
c.user_id,
-- c.phone,
c.shop_id,
c.sns_id,
sns_profiles.sns_profile_id,
c.sns_profile_id,
c.union_id,
c.current_union_id,
c.credit_id,
c.result,
c.condition_id,
c.merge_model_flag,
unions.quality as qlt_un,
users.quality as qlt_usr,
c.scoring_model_flag,
c.is_new_user,
client_data_model_log.quality_1,
client_data_model_log.quality_2,
client_data_model_log.flag_reject
FROM 
	credit_sessions as c 
	INNER JOIN unions on unions.id = c.union_id
	INNER JOIN users on users.id = c.user_id
	LEFT OUTER JOIN client_data_model_log on client_data_model_log.Session_id_1 = c.id
	LEFT OUTER JOIN sns_profiles on sns_profiles.id = c.sns_profile_id
where 
	c.merge_model_flag IS NOT NULL
	AND c.merge_model_flag = 1
-- and result = 'merge model blocked'
-- and result = 'credit confirmed' OR result = 'merge model blocked'
HAVING time > @Date -- AND result = 'merge model blocked' AND quality_un > 0
ORDER BY 
FROM_UNIXTIME(c.date_start) DESC,
shop_id,
	c.merge_model_flag DESC,
	c.result