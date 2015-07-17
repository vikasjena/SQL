DROP TABLE IF EXISTS Vw_Sessions_Data;
CREATE TABLE IF NOT EXISTS Vw_Sessions_Data
(PRIMARY KEY id (id), 
INDEX id (id),
INDEX credit_id (credit_id),
INDEX shop_id (shop_id),
INDEX date_start (date_start),
INDEX user_id (user_id),
INDEX union_id (union_id),
INDEX sns_profile_id (sns_profile_id),
INDEX  current_union_id ( current_union_id))

SELECT
	credit_sessions.id AS id,
	credit_sessions.shop_id AS shop_id,
	credit_sessions.user_id AS user_id,
	credit_sessions.sub_id AS sub_id,
	credit_sessions.order_id AS order_id,
	credit_sessions.union_id AS union_id,

/*
COALESCE((
(select _ID_new from (SELECT
				paydb.union_log.merged_union_id as _ID,
				min(paydb.union_log.union_id)  as _ID_new
				from paydb.union_log 
				GROUP BY paydb.union_log.merged_union_id
) as temptable1
			WHERE _ID = credit_sessions.union_id )), credit_sessions.union_id) as union_id_current,
*/
/*
COALESCE(
(select _ID_new from (
				SELECT 
					`cs`.id as _ID,
					`us`.union_id as _ID_new
				FROM 
							`credit_sessions` `cs`
				JOIN `union_subids` `us` ON (`us`.`shop_id` = `cs`.`shop_id` AND `us`.`sub_id` = `cs`.`sub_id`)
) as temptable1
			WHERE _ID = credit_sessions.sub_id),

(select _ID_new from (SELECT
				paydb.union_log.merged_union_id as _ID,
				min(paydb.union_log.union_id)  as _ID_new
				from paydb.union_log 
				GROUP BY paydb.union_log.merged_union_id
) as temptable1
			WHERE _ID = credit_sessions.union_id ),
credit_sessions.union_id) as union_id_current,
*/

(select _ID_new from (SELECT
				paydb.union_subids.sub_id as _ID,
				paydb.union_subids.shop_id as _ID_SHOP,
				paydb.union_subids.union_id  as _ID_new
				from paydb.union_subids 
				#GROUP BY 
) as temptable1
			WHERE _ID = credit_sessions.sub_id and _ID_SHOP = credit_sessions.shop_id) as current_union_subids,

credit_sessions.current_union_id, 

(select _VAL from (SELECT
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
									#GROUP BY 
) as temptable1
									WHERE _ID = credit_sessions.id) as sub_id_creation_date_u,

DATEDIFF(FROM_UNIXTIME(credit_sessions.date_start), (select _VAL from (SELECT
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
				WHERE _ID = credit_sessions.id)) AS days_since_reg,


(select _VAL from (SELECT
				paydb.extra_score_values.credit_session_id as _ID,
				-- paydb.extra_score_vars.shop_id as _ID_SHOP,
				paydb.extra_score_values.`value`  as _VAL
				from paydb.extra_score_values
				LEFT OUTER JOIN extra_score_vars on extra_score_vars.id = extra_score_values.var_id
				WHERE extra_score_vars.`name` = 'nickname'
				#GROUP BY 
) as temptable1
			WHERE _ID = credit_sessions.id) as nickname,

(select _VAL from (SELECT
											paydb.extra_score_values.credit_session_id as _ID,
 											paydb.extra_score_values.`value` as _VAL
									from 
												paydb.extra_score_values
												LEFT OUTER JOIN extra_score_vars on extra_score_vars.id = extra_score_values.var_id
									WHERE extra_score_vars.`name` = 'user_count_sales'
									#GROUP BY 
) as temptable1
									WHERE _ID = credit_sessions.id) as user_count_sales,

(select _ITEM FROM 
	(SELECT
		paydb.extra_score_values.credit_session_id as _ID,
		paydb.extra_score_values.`value` as _ITEM
		FROM extra_score_values
		INNER JOIN extra_score_vars on extra_score_vars.id = extra_score_values.var_id
		where extra_score_vars.`name` = 'user_address' 
				) AS Temp_Table1
	WHERE credit_sessions.id = _ID)
 as user_address,


-- union_log.union_id AS union_id_new,
-- case when union_log.union_id is null then credit_sessions.union_id else union_log.union_id end as union_id_current,

	credit_sessions.credit_id AS credit_id,
	credit_sessions.sns_profile_id AS profile_id,


(select sns_profile_id from (SELECT
				paydb.sns_profiles.id as _ID,
				paydb.sns_profiles.sns_profile_id  as sns_profile_id
				from paydb.sns_profiles 
				-- GROUP BY 
) as temptable1
			WHERE _ID = credit_sessions.sns_profile_id) as sns_profile_id,

-- sns_profiles.id AS sns_profile_id,

	credit_sessions.sns_id AS sns_id,
	FROM_UNIXTIME(credit_sessions.date_start) AS date_start,
	FROM_UNIXTIME(credit_sessions.date_sns_redirect) AS date_sns_redirect,
	FROM_UNIXTIME(credit_sessions.date_auth) AS date_auth,
	FROM_UNIXTIME(credit_sessions.date_phone) AS date_phone,
	FROM_UNIXTIME(credit_sessions.date_terms) AS date_terms,
	FROM_UNIXTIME(credit_sessions.date_sms) AS date_sms,
	FROM_UNIXTIME(credit_sessions.date_finish) AS date_finish,
	FROM_UNIXTIME(credit_sessions.date_cession) AS date_cession,
	-- COUNT(DISTINCT credit_sessions.shop_id) AS Count_Shops,
	-- MIN(FROM_UNIXTIME(credit_sessions.date_start)) AS date_start,

	credit_sessions.date_start AS date_start_u, -- clicked PP button in store
	credit_sessions.date_sns_redirect AS date_sns_redirect_u, -- clicked on SN icon on our landing page (offline = date_start)
	credit_sessions.date_auth AS date_auth_u, -- DL'ed data and scored it
	credit_sessions.date_phone AS date_phone_u, -- We showed Cell Phone requesting form
	credit_sessions.date_terms AS date_terms_u, -- 1st timer - we show Terms and Conditions (otherwise show field for  c,SMS code entry) (enpty for Offline)
	credit_sessions.date_sms AS date_sms_u, -- Time we sent out SMS with CODE (If he passed the score this date = date when we sent SMS with deal confirmation)
	credit_sessions.date_finish AS date_finish_u, -- date when entered correct SMS code
	credit_sessions.date_cession AS date_cession_u, -- Show cession agreement to the used (last frame)

CASE
WHEN credit_sessions.sns_id = 'VK'
THEN 1
WHEN credit_sessions.sns_id = 'FB'
THEN 2
WHEN credit_sessions.sns_id = 'OK'
THEN 3
ELSE 0
END AS network_type,

CASE
WHEN credit_sessions.date_sns_redirect IS NOT NULL 
THEN 1
ELSE 0
END AS sn_click_bin,

CASE
WHEN credit_sessions.date_auth IS NOT NULL 
THEN 1
ELSE 0
END AS permission_ok_bin,

CASE
WHEN credit_sessions.date_sms IS NOT NULL 
THEN 1
ELSE 0
END AS phone_enter_bin,

CASE
WHEN credit_sessions.date_finish IS NOT NULL 
THEN 1
ELSE 0
END AS code_conf_bin,

	(credit_sessions.date_sns_redirect - credit_sessions.date_start)	AS time_to_read_description,
	(credit_sessions.date_auth - credit_sessions.date_sns_redirect)	AS time_to_score,
	(credit_sessions.date_terms - credit_sessions.date_phone)	AS time_to_enter_phone,
	(credit_sessions.date_finish - credit_sessions.date_terms)	AS time_to_read_terms,
	(credit_sessions.date_finish - credit_sessions.date_sms)	AS time_to_enter_code,
	(credit_sessions.date_finish - credit_sessions.date_start)	AS time_to_complete,
	
	credit_sessions.oferty_opened  as oferty_opened,
	credit_sessions.cession_opened as cession_opened,
	credit_sessions.about_opened as about_opened,

	CASE WHEN 
	credit_sessions.oferty_opened > 0 
	THEN 1
	WHEN credit_sessions.oferty_opened is null then Null
	ELSE 0
	END as oferty_opened_bin,

	CASE WHEN 
	credit_sessions.cession_opened > 0 
	THEN 1
	WHEN credit_sessions.cession_opened is null then Null
	ELSE 0
	END as cession_opened_bin,

	CASE WHEN 
	credit_sessions.about_opened > 0
	THEN 1
	WHEN credit_sessions.about_opened is null then Null
	ELSE 0
	END as about_opened_bin,
	
	credit_sessions.amount AS amount,
	credit_sessions.is_new_profile AS is_new_profile,
	credit_sessions.is_new_user AS is_new_user,
	credit_sessions.quick_session AS quick_session,
	credit_sessions.delivery AS delivery,
	credit_sessions.offline AS offline,
	credit_sessions.phone AS phone,
	credit_sessions.ip AS ip,
	credit_sessions.sms_sent AS sms_sent,
	credit_sessions.phone_confirm_attempts AS phone_confirm_attempts,
	credit_sessions.condition_id as condition_id,
	credit_sessions.result AS result,
	credit_sessions.merge_model_flag,
	credit_sessions.scoring_model_flag

	/*
		credit_sessions.subtitle AS subtitle,
		credit_sessions.redirect AS redirect,
		credit_sessions.js_callback AS js_callback,
		credit_sessions.type AS type,
		credit_sessions.phone_confirm_code AS phone_confirm_code,
	*/
FROM
	credit_sessions
-- GROUP BY credit_sessions.user_id
-- HAVING date_terms < date_phone
-- order by credit_sessions.date_start DESC