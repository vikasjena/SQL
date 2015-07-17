DROP TABLE IF EXISTS ch_scoring_data_light;
CREATE table if not EXISTS ch_scoring_data_light
SELECT

Vw_Users_Loans.Date_First_Loan AS Date_First_Purchase,
Vw_Users_Sessions_1st_Loan.user_id AS user_id,
sns_profiles.sns_id AS Sns_Id,
sns_profiles.sns_profile_id AS sns_profile_id,
Vw_Users_Sessions_1st_Loan.shop_id AS shop_id,

-- DEFAULT MEASURES START ---------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Vw_Users_Loans.Session_First_Loan AS Session_First_Purchase_Id,
-- Vw_Users_Loans.Days_To_Pay_Avg AS days_to_pay_avg,
-- Vw_Users_Loans.Bin_Moving_Default AS bin_moving_default,
-- CASE WHEN Vw_Users_Loans.Bin_Moving_Default = 0 THEN 2 ELSE 1 END AS bin_moving_default,
-- Vw_Users_Loans.Bin_First_Default_30 AS bin_first_default_30,
Vw_Users_Loans.Bin_First_Default_45 AS bin_first_default_45,
Vw_Users_Loans.Bin_First_Default_60 AS bin_first_default_60,
-- Vw_Users_Loans.Bin_First_Default_90 AS bin_first_default_90,

-- BINARY FIRST SESSION ACTIVITY START-------------------------------------------------------------------------------------------------------------------------------------------------

Vw_Users_Sessions.sn_click_bin as first_sess_sn_click_bin,
Vw_Users_Sessions.permission_ok_bin as first_sess_permission_ok_bin,
Vw_Users_Sessions.phone_enter_bin as first_sess_phone_enter_bin,
Vw_Users_Sessions.code_conf_bin as first_sess_code_conf_bin,

CASE WHEN Vw_Users_Sessions.sns_id = 'VK' THEN 1 ELSE 0 END AS  first_sess_sn_vk,
CASE WHEN Vw_Users_Sessions.sns_id = 'FB' THEN 1 ELSE 0 END AS  first_sess_sn_fb,
CASE WHEN Vw_Users_Sessions.sns_id = 'OK' THEN 1 ELSE 0 END AS  first_sess_sn_ok,

Vw_Users_Sessions.amount AS amount_first_session,
SessCountUsr(Vw_Users_Loans.User_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan)) as sess_before_purchase,

-- USE WITH CAUTION: FEATURE ADDED IN LATE 1stQueater 2014
Vw_Users_Sessions.cession_opened as first_sess_cession_opened,
Vw_Users_Sessions.oferty_opened as first_sess_oferty_opened,
Vw_Users_Sessions.about_opened as first_sess_about_opened,
Vw_Users_Sessions.cession_opened_bin as first_sess_cession_opened_bin,
Vw_Users_Sessions.oferty_opened_bin as first_sess_oferty_opened_bin,
Vw_Users_Sessions.about_opened_bin as first_sess_about_opened_bin,

-- CUMULATIVE SESSIONS RESULTS BEFORE PURCHASE

SessResultCountUsr(Vw_Users_Loans.User_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan), 'shop daily limits') AS sess_result_count_sdl_usr,
SessResultCountUsr(Vw_Users_Loans.User_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan), 'union debt') AS sess_result_count_ud_usr,
SessResultCountUsr(Vw_Users_Loans.User_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan), 'first union loan not repaid') AS sess_result_count_fulnr_usr,
SessResultCountUsr(Vw_Users_Loans.User_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan), 'first shop loan not repaid') AS sess_result_count_fslnr_usr,
SessResultCountUsr(Vw_Users_Loans.User_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan), 'unrepaid default loan') AS sess_result_count_udl_usr,
SessResultCountUsr(Vw_Users_Loans.User_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan), 'conditions not met') AS sess_result_count_cnm_usr,
SessResultCountUsr(Vw_Users_Loans.User_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan), 'union blocked') AS sess_result_count_ub_usr,
SessResultCountUsr(Vw_Users_Loans.User_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan), 'session not finished') AS sess_result_count_snf_usr,

SessResultCountUnion(Vw_Users_Loans.Union_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan), 'shop daily limits') AS sess_result_count_sdl_union,
SessResultCountUnion(Vw_Users_Loans.Union_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan), 'union debt') AS sess_result_count_ud_union,
SessResultCountUnion(Vw_Users_Loans.Union_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan), 'first union loan not repaid') AS sess_result_count_fulnr_union,
SessResultCountUnion(Vw_Users_Loans.Union_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan), 'first shop loan not repaid') AS sess_result_count_fslnr_union,
SessResultCountUnion(Vw_Users_Loans.Union_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan), 'unrepaid default loan') AS sess_result_count_udl_union,
SessResultCountUnion(Vw_Users_Loans.Union_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan), 'conditions not met') AS sess_result_count_cnm_union,
SessResultCountUnion(Vw_Users_Loans.Union_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan), 'union blocked') AS sess_result_count_ub_union,
SessResultCountUnion(Vw_Users_Loans.Union_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan), 'session not finished') AS sess_result_count_snf_union,

SessResultCountUnionCurrent(Vw_Users_Loans.Union_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan), 'shop daily limits') AS sess_result_count_sdl_union_current,
SessResultCountUnionCurrent(Vw_Users_Loans.Union_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan), 'union debt') AS sess_result_count_ud_union_current,
SessResultCountUnionCurrent(Vw_Users_Loans.Union_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan), 'first union loan not repaid') AS sess_result_count_fulnr_union_current,
SessResultCountUnionCurrent(Vw_Users_Loans.Union_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan), 'first shop loan not repaid') AS sess_result_count_fslnr_union_current,
SessResultCountUnionCurrent(Vw_Users_Loans.Union_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan), 'unrepaid default loan') AS sess_result_count_udl_union_current,
SessResultCountUnionCurrent(Vw_Users_Loans.Union_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan), 'conditions not met') AS sess_result_count_cnm_union_current,
SessResultCountUnionCurrent(Vw_Users_Loans.Union_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan), 'union blocked') AS sess_result_count_ub_union_current,
SessResultCountUnionCurrent(Vw_Users_Loans.Union_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan), 'session not finished') AS sess_result_count_snf_union_current,

-- FIRST SESSION ACTIVITY END


-- FIRST PURCHASE ACTIVITY BEGINS ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Vw_Users_Sessions_1st_Loan.shop_id
-- Vw_Users_Sessions_1st_Loan.is_new_user AS is_new_user,
Vw_Users_Sessions_1st_Loan.is_new_profile AS is_new_profile,
(Vw_Users_Sessions_1st_Loan.amount
/
(select _AMOUNT from (
	SELECT 
			products.shop_id as _ID,
			min(products.amount_limit) as _AMOUNT
	FROM
			products
	GROUP BY products.shop_id
	) as Temp_Table1
	WHERE 
			_ID = Vw_Users_Sessions_1st_Loan.shop_id)
) AS Amount_First_Purchase,


(Vw_Users_Sessions.amount	- Vw_Users_Sessions_1st_Loan.amount)/Vw_Users_Sessions_1st_Loan.amount AS amounts_diff_weighed, 
(UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan) - Vw_Users_Sessions.date_start) AS decision_time_t,

CASE WHEN Vw_Users_Sessions_1st_Loan.sns_id = 'VK' THEN 1 ELSE 0 END AS  loan_sn_vk,
CASE WHEN Vw_Users_Sessions_1st_Loan.sns_id = 'FB' THEN 1 ELSE 0 END AS  loan_sn_fb,
CASE WHEN Vw_Users_Sessions_1st_Loan.sns_id = 'OK' THEN 1 ELSE 0 END AS  loan_sn_ok,

-- DUE TO BUG WITH TIMESTAMPS APPROXIMATE THE READ/DIDN'T READ BY TOTAL COMPLEATION TIME
-- Vw_Users_Sessions_1st_Loan.time_to_read_description as loan_time_to_read_description,
-- Vw_Users_Sessions_1st_Loan.time_to_read_terms as loan_time_to_read_terms,
Vw_Users_Sessions_1st_Loan.time_to_complete AS loan_time_to_complete,

-- TimeTermsSumUsr(Vw_Users_Sessions_1st_Loan.user_id, UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan)) as loan_sum_time_to_read_terms,
-- TimeCompleteSumUsr(Vw_Users_Sessions_1st_Loan.user_id, UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan)) as loan_sum_time_to_complete,
Vw_Users_Sessions_1st_Loan.sms_sent AS loan_sms_sent,
Vw_Users_Sessions_1st_Loan.phone_confirm_attempts AS loan_phone_confirm_attempts,
-- Vw_Users_Sessions_1st_Loan.quick_session AS loan_one_click,
-- Vw_Users_Sessions_1st_Loan.delivery AS loan_delivery,
-- Vw_Users_Sessions_1st_Loan.offline AS loan_offline,

-- USE WITH CAUTION: FEATURE ADDED IN LATE 1stQueater 2014
Vw_Users_Sessions_1st_Loan.cession_opened as first_loan_cession_opened,
Vw_Users_Sessions_1st_Loan.oferty_opened as first_loan_oferty_opened,
Vw_Users_Sessions_1st_Loan.about_opened as first_loan_about_opened,
Vw_Users_Sessions_1st_Loan.cession_opened_bin as first_loan_cession_opened_bin,
Vw_Users_Sessions_1st_Loan.oferty_opened_bin as first_loan_oferty_opened_bin,
Vw_Users_Sessions_1st_Loan.about_opened_bin as first_loan_about_opened_bin,


-- UNION STATISTICS DURING FIRST PURCHASE
UserIdCountBeforeDate(Vw_Users_Loans.Union_Id,  UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan)) AS users_in_union_before_purchase,
UserIdCountInCurrentUnion(Vw_Users_Loans.Union_Id) AS UserIdCountInCurrentUnion,
ProfilesCountUnion(Vw_Users_Loans.Union_Id, UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan)) AS profiles_in_union,
ProfilesCountUnion(Vw_Users_Loans.Union_Id, "2015-12-12 00:00:00") AS profiles_in_union_total,
-- FIRST PURCHASE ACTIVITY END


DATEDIFF(NOW(), sns_profiles.birthdate) AS age_days,

CASE WHEN DATEDIFF(NOW(), sns_profiles.birthdate)/365 IS NULL THEN 1 ELSE 0 END AS age_null,

-- CASE WHEN users.gender = 'male' THEN	1 WHEN users.gender = 'female' THEN	0 ELSE	NULL END AS Gender,
CASE WHEN sns_profiles.gender = 'm' THEN	1 WHEN sns_profiles.gender = 'f' THEN	0 ELSE	NULL END AS Gender,
sns_profiles.count_friends AS Friends,

DATEDIFF(FROM_UNIXTIME(Vw_Users_Sessions_1st_Loan.date_start_u), FROM_UNIXTIME(sns_profiles.date_create_profile)) AS time_since_creation,
DATEDIFF(FROM_UNIXTIME(Vw_Users_Sessions_1st_Loan.date_start_u), FROM_UNIXTIME(sns_profiles.date_last_login)) AS time_since_login,
-- (Vw_Users_Sessions_1st_Loan.date_start_u) - (sns_profiles.date_last_login) AS time_since_login_u,
DATEDIFF(FROM_UNIXTIME(Vw_Users_Sessions_1st_Loan.date_start_u), FROM_UNIXTIME(sns_profiles.date_last_activity)) AS time_since_activity,


	COALESCE(FriendsInDefaultCount(sns_profiles.sns_profile_id), 0) as Friends_In_Default_45,
	COALESCE(FriendsInBlockedCount(sns_profiles.sns_profile_id), 0) as Friends_Blocked,
	COALESCE(FriendsPaidVARLoansCount(sns_profiles.sns_profile_id, 1), 0) as Friends_Paid_One_plus,
	COALESCE(FriendsPaidVARLoansCount(sns_profiles.sns_profile_id, 2), 0) as Friends_Paid_Two_plus,
	COALESCE(FriendsPaidVARLoansCount(sns_profiles.sns_profile_id, 3), 0) as Friends_Paid_Three_plus,
	COALESCE(FriendsPaidVARLoansCount(sns_profiles.sns_profile_id, 4), 0) as Friends_Paid_Four_plus,
	COALESCE(FriendsPaidVARLoansCount(sns_profiles.sns_profile_id, 5), 0) as Friends_Paid_Five_plus,
	COALESCE(FriendsPaidVARLoansCount(sns_profiles.sns_profile_id, 6), 0) as Friends_Paid_Six_plus,
	COALESCE(FriendsInDefault60Count(sns_profiles.sns_profile_id), 0) as Friends_In_Default_60,
	COALESCE(FriendsPassedCount(sns_profiles.sns_profile_id), 0) as Friends_Passed,
	COALESCE(FriendsPurchasedCount(sns_profiles.sns_profile_id), 0) as Friends_Purchased,
	COALESCE(FriendsRejectedCount(sns_profiles.sns_profile_id), 0) as Friends_Rejected,

ABS(((select _COUNT FROM 
	(SELECT
		paydb.user_relations_lite_directional.sns_item_id0 as _ID,
		count(DISTINCT paydb.user_relations_lite_directional.sns_item_id1) as _COUNT
	FROM paydb.user_relations_lite_directional
	GROUP BY paydb.user_relations_lite_directional.sns_item_id0) AS Temp_Table1
	WHERE sns_profiles.sns_profile_id = _ID) / sns_profiles.count_friends)*100 - 100) as Abs_Frnd_Diff


FROM
	users
LEFT OUTER JOIN Vw_Users_Loans ON Vw_Users_Loans.User_Id = users.id
LEFT OUTER JOIN Vw_Users_Sessions_1st_Loan ON Vw_Users_Sessions_1st_Loan.user_id = Vw_Users_Loans.User_Id
LEFT OUTER JOIN Vw_Users_Sessions ON Vw_Users_Sessions.user_id = Vw_Users_Loans.User_Id
LEFT OUTER JOIN sns_profiles on sns_profiles.sns_profile_id = Vw_Users_Sessions_1st_Loan.sns_profile_id 
WHERE
	users.phone NOT IN (
		10000000002,
		71000000000,
		79055142335,
		79853644521,
		79030189999,
		79263395978,
		79264978766,
		79039308310,
		79266048566,
		79169202325,
		79150140601,
		79104210977)
AND Vw_Users_Loans.Date_First_Loan > '2014-02-04 00:00:00'
-- AND Vw_Users_Loans.Date_First_Loan < '2014-01-10 00:00:00'  -- loan_time_to_tead_terms НЕДОСТОВЕРНЫ С 10 Января по 27 Марта 2014.
-- AND DATE_ADD(Vw_Users_Loans.Date_First_Loan,INTERVAL 45 DAY) < NOW()
-- AND bin_first_default_45 IS NOT NULL 
-- AND Vw_Users_Sessions_1st_Loan.shop_id NOT IN (10002, 10003, 10009, 10010)
-- AND sns_profiles.sns_id = 1
GROUP BY
	Vw_Users_Loans.User_Id
-- HAVING Abs_Frnd_Diff <= 10


/*
AND (Vw_Users_Sessions_1st_Loan.sn_click_bin = 0 OR
 Vw_Users_Sessions_1st_Loan.permission_ok_bin = 0 OR
 Vw_Users_Sessions_1st_Loan.phone_enter_bin = 0 OR
 Vw_Users_Sessions_1st_Loan.code_conf_bin = 0)
*/

;
SELECT * FROM ch_scoring_data_light;