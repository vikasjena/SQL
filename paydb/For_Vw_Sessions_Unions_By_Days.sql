SELECT
MAX(Vw_Sessions_Data.date_start) AS date_start,
YEAR(Vw_Sessions_Data.date_start) AS Year_,
MONTH(Vw_Sessions_Data.date_start) AS Month_,
DAY(Vw_Sessions_Data.date_start) AS Day_,
TIME(Vw_Sessions_Data.date_start) AS Time_,
MAX(Vw_Sessions_Data.network_type) as SN_Type,
Vw_Sessions_Data.shop_id AS shop_id,
MAX(Vw_Sessions_Data.id) as id,
-- Vw_Sessions_Data.user_id AS user_id,
-- Vw_Sessions_Data.sub_id AS sub_id,
-- Vw_Sessions_Data.order_id AS order_id,
Vw_Sessions_Data.union_id AS union_id,
Vw_Sessions_Data.union_id_current,
SUM(Vw_Sessions_Data.is_new_profile) AS is_new_profile,
SUM(Vw_Sessions_Data.is_new_user) AS is_new_user,

Vw_Sessions_Data.result AS result,

CASE WHEN 
SUM(Vw_Sessions_Data.sn_click_bin) > 0 THEN 1 ELSE 0 END as sn_click_bin,
CASE WHEN 
SUM(Vw_Sessions_Data.permission_ok_bin) > 0 THEN 1 ELSE 0 END as permission_ok_bin,
CASE WHEN 
SUM(Vw_Sessions_Data.phone_enter_bin) > 0 THEN 1 ELSE 0 END as phone_enter_bin,
CASE WHEN 
SUM(Vw_Sessions_Data.code_conf_bin) > 0 THEN 1 ELSE 0 END as code_conf_bin,
CASE WHEN 
SUM(Vw_Sessions_Data.condition_id) IS NOT NULL THEN 1 ELSE 0 END as finish_by_condition_id,
CASE WHEN 
MAX(Vw_Sessions_Data.credit_id) IS NOT NULL THEN 1 ELSE 0 END AS credit_confirmed_bin,
CASE WHEN 
SUM(Vw_Sessions_Data.about_opened) > 0 THEN 1 ELSE 0 END as about_opened,

MAX(Vw_Sessions_Data.time_to_read_description) as time_to_read_description,
MAX(Vw_Sessions_Data.time_to_read_terms) as time_to_read_terms,
MAX(Vw_Sessions_Data.time_to_complete) as time_to_complete


-- Vw_Sessions_Data.quick_session AS quick_session
-- Vw_Sessions_Data.delivery AS delivery,
-- Vw_Sessions_Data.offline AS offline
-- Vw_Sessions_Data.result AS result

FROM
	Vw_Sessions_Data

GROUP BY
Vw_Sessions_Data.union_id_current,
YEAR(Vw_Sessions_Data.date_start),
MONTH(Vw_Sessions_Data.date_start),
DAY(Vw_Sessions_Data.date_start)

ORDER BY 
YEAR(Vw_Sessions_Data.date_start) ASC,
MONTH(Vw_Sessions_Data.date_start) ASC,
DAY(Vw_Sessions_Data.date_start) ASC,
TIME(Vw_Sessions_Data.date_start) ASC

