SELECT
min(Vw_Sessions_Data.id) AS id,
Vw_Sessions_Data.shop_id AS shop_id,
Vw_Sessions_Data.user_id AS user_id,
Vw_Sessions_Data.sub_id AS sub_id,
Vw_Sessions_Data.order_id AS order_id,
Vw_Sessions_Data.union_id AS union_id,
Vw_Sessions_Data.union_id_current,
Vw_Sessions_Data.credit_id AS credit_id,
Vw_Sessions_Data.sns_profile_id AS sns_profile_id,
Vw_Sessions_Data.sns_id AS sns_id,
/*
	Vw_Sessions_Data.condition_id AS condition_id,
	Vw_Sessions_Data.date_start,
	Vw_Sessions_Data.date_sns_redirect,
	Vw_Sessions_Data.date_auth,
	Vw_Sessions_Data.date_phone,
	Vw_Sessions_Data.date_terms,
	Vw_Sessions_Data.date_sms,
	Vw_Sessions_Data.date_finish,
	Vw_Sessions_Data.date_cession,

	Vw_Sessions_Data.date_start_u, -- clicked PP button in store
	Vw_Sessions_Data.date_sns_redirect_u, -- clicked on SN icon on our landing page (offline = date_start)
	Vw_Sessions_Data.date_auth_u, -- DL'ed data and scored it
	Vw_Sessions_Data.date_phone_u, -- We showed Cell Phone requesting form
	Vw_Sessions_Data.date_terms_u, -- 1st timer - we show Terms and Conditions (otherwise show field for  c,SMS code entry) (enpty for Offline)
	Vw_Sessions_Data.date_sms_u, -- Time we sent out SMS with CODE (If he passed the score this date = date when we sent SMS with deal confirmation)
	Vw_Sessions_Data.date_finish_u, -- date when entered correct SMS code
	Vw_Sessions_Data.date_cession_u, -- Show cession agreement to the used (last frame)
*/
-- COUNT(DISTINCT Vw_Sessions_Data.shop_id) AS Count_Shops,
MIN(Vw_Sessions_Data.date_start_u) AS date_start,

Vw_Sessions_Data.network_type,
Vw_Sessions_Data.sn_click_bin,
Vw_Sessions_Data.permission_ok_bin,
Vw_Sessions_Data.phone_enter_bin,
Vw_Sessions_Data.code_conf_bin,

Vw_Sessions_Data.time_to_read_description,
Vw_Sessions_Data.time_to_score,
Vw_Sessions_Data.time_to_enter_phone,
Vw_Sessions_Data.time_to_read_terms,
Vw_Sessions_Data.time_to_enter_code,
Vw_Sessions_Data.time_to_complete,

Vw_Sessions_Data.oferty_opened,
Vw_Sessions_Data.cession_opened,
Vw_Sessions_Data.about_opened,
Vw_Sessions_Data.oferty_opened_bin,
Vw_Sessions_Data.cession_opened_bin,
Vw_Sessions_Data.about_opened_bin,

AVG(Vw_Sessions_Data.time_to_read_description) AS time_to_read_description_Avg,
AVG(Vw_Sessions_Data.time_to_score) AS time_to_score_Avg,
AVG(Vw_Sessions_Data.time_to_enter_phone) AS time_to_enter_phone_Avg,
AVG(Vw_Sessions_Data.time_to_read_terms) AS time_to_read_terms_Avg,
AVG(Vw_Sessions_Data.time_to_enter_code) AS time_to_enter_code_Avg,
AVG(Vw_Sessions_Data.time_to_complete) AS time_to_complete_Avg,
	
Vw_Sessions_Data.amount AS amount,
Vw_Sessions_Data.is_new_profile AS is_new_profile,
Vw_Sessions_Data.is_new_user AS is_new_user,
Vw_Sessions_Data.quick_session AS quick_session,
Vw_Sessions_Data.delivery AS delivery,
Vw_Sessions_Data.offline AS offline,
Vw_Sessions_Data.phone AS phone,
Vw_Sessions_Data.ip AS ip,
Vw_Sessions_Data.sms_sent AS sms_sent,
Vw_Sessions_Data.phone_confirm_attempts AS phone_confirm_attempts,
Vw_Sessions_Data.result AS result

/*
	Vw_Sessions_Data.subtitle AS subtitle,
	Vw_Sessions_Data.redirect AS redirect,
	Vw_Sessions_Data.js_callback AS js_callback,
	Vw_Sessions_Data.type AS type,
	Vw_Sessions_Data.phone_confirm_code AS phone_confirm_code
*/

FROM
	Vw_Sessions_Data
-- WHERE user_id = 7197
GROUP BY Vw_Sessions_Data.union_id_current
-- HAVING user_id  = 4032 -- date_terms < date_phone