SELECT
-- IDENTIFICATIONS BEGIN --
-- users.usr_tmp_id AS User_Temp_Id,
-- Vw_Users_Sessions.sub_id AS sub_id,
-- Vw_Users_Sessions.order_id AS order_id,
-- Vw_Users_Sessions.user_id AS user_id,
-- sns_profiles.sns_id AS Sns_Id,
-- Vw_Users_Sessions.credit_id AS credit_id,
-- Vw_Users_Sessions.union_id AS union_id,
-- Vw_Users_Sessions.subtitle AS subtitle,
-- users.phone AS Phone,
-- users.first_name AS 'Name',
-- users.last_name AS Surname,
-- Vw_Users_Loans.Is_BLocked AS Is_BLocked,
Vw_Users_Sessions.shop_id AS shop_id,
count(users.id) AS user_id_c,
-- COUNT(Vw_Users_Sessions.phone) AS Phone,
/*
		
		Vw_Users_Loans.Sub_Id AS Sub_Id,
		Vw_Users_Loans.Union_Id AS Union_Id,
	  Vw_Users_Sessions.sns_profile_id AS sns_profile_id,

		Vw_Users_Sessions.id AS Session_First_Session_Id,
		Vw_Users_Loans.Session_First_Loan AS Session_First_Purchase_Id,
		Vw_Users_Sessions.sns_id AS S_Network,
		Vw_Users_Sessions.ip AS ip,

-- IDENTIFICATIONS END --

-- DATES FOR ORDERING AND SORTING BEGIN --
		Vw_Users_Loans.Date_First_Loan AS Date_First_Purchase,
		FROM_UNIXTIME(Vw_Users_Sessions.date_start) AS Date_First_Session,
		UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan) AS Date_First_Purchase_U,
		Vw_Users_Sessions.date_start AS Date_First_Session_U,
-- DATES FOR ORDERING AND SORTING END --

-- STATISTICS FOR CROSS SHOPS SORTING BEGIN --
	 Vw_Users_Loans.Count_Credits AS Count_Credits,
	 Vw_Users_Sessions.Count_Shops AS Count_Shops_Sessions,
	 Vw_Users_Loans.Count_Shops_Credits AS Count_Shops_w_Credits,
-- STATISTICS FOR CROSS SHOPS SORTING END --

-- SUMMARY OF OPERATIONS BEGIN --
	 Vw_Users_Loans.Amount_Original_Sum AS Amount_Original_Sum,
	 Vw_Users_Loans.Amount_Remaining_Sum AS Amount_Remaining_Sum,
	 Vw_Users_Loans.Interest_Accrued_Sum AS Interest_Accrued_Sum,
	 Vw_Users_Loans.Interest_Remaining_Sum AS Interest_Remaining_Sum,
	 Vw_Users_Loans.Date_Payment_First AS Date_Payment_First,
	 Vw_Users_Loans.Quantity_Payments AS Quantity_Payments,
	 Vw_Users_Loans.Amount_Original_Paid_Sum AS Amount_Original_Paid_Sum,
	 Vw_Users_Loans.Interest_Paid_Sum AS Interest_Paid_Sum,
	 Vw_Users_Loans.Amount_To_Pay_Sum AS Amount_To_Pay_Sum,
	 Vw_Users_Loans.Amount_Operations_Sum AS Amount_Operations_Sum,
	 Vw_Users_Loans.Operations_Cost_Sum AS Operations_Cost_Sum,
	 Vw_Users_Loans.Amount_Received_Operations_Sum AS Amount_Received_Operations_Sum,
-- SUMMARY OF OPERATIONS END --
*/
-- DEFAULT MEASURES START --
-- Vw_Users_Loans.Days_To_Pay_Avg AS days_to_pay_avg,
Vw_Users_Loans.Bin_Moving_Default AS bin_moving_default,
-- Vw_Users_Loans.Bin_First_Default_30 AS bin_first_default_30,
-- Vw_Users_Loans.Bin_First_Default_45 AS bin_first_default_45,
-- Vw_Users_Loans.Bin_First_Default_60 AS bin_first_default_60,
-- Vw_Users_Loans.Bin_First_Default_90 AS bin_first_default_90,
-- DEFAULT MEASURES END --

-- BINARY FIRST SESSION ACTIVITY START
-- Vw_Users_Sessions.network_type,
-- Vw_Users_Sessions.sn_click_bin,
-- Vw_Users_Sessions.permission_ok_bin,
-- Vw_Users_Sessions.phone_enter_bin,
-- Vw_Users_Sessions.code_conf_bin,
-- BINARY FIRST SESSION ACTIVITY END

-- FIRST SESSION ACTIVITY BEGIN
-- Vw_Users_Sessions.is_new_user AS is_new_user,
-- Vw_Users_Sessions.shop_id
-- Vw_Users_Sessions.is_new_profile AS is_new_profile,
sum(CASE WHEN Vw_Users_Sessions.sns_id = 'VK' THEN 1 ELSE 0 END) AS  sn_vk,
sum(CASE WHEN Vw_Users_Sessions.sns_id = 'FB' THEN 1 ELSE 0 END) AS  sn_fb,
sum(CASE WHEN Vw_Users_Sessions.sns_id = 'OK' THEN 1 ELSE 0 END) AS  sn_ok,
avg(Vw_Users_Sessions.amount) AS amount_first_session,
-- Vw_Users_Sessions.time_to_score,
avg(Vw_Users_Sessions.time_to_read_description) AS time_to_read_descr_a,
avg(Vw_Users_Sessions.time_to_read_terms) as time_to_read_terms_a,
min(Vw_Users_Sessions.time_to_read_description) AS time_to_read_description_min,
min(Vw_Users_Sessions.time_to_read_terms) as time_to_read_terms_min,
max(Vw_Users_Sessions.time_to_read_description) AS time_to_read_description_max,
max(Vw_Users_Sessions.time_to_read_terms) as time_to_read_terms_max,
avg(Vw_Users_Sessions.time_to_enter_phone) as time_to_enter_phone,
avg(Vw_Users_Sessions.time_to_enter_code) as time_to_enter_code,
avg(Vw_Users_Sessions.sms_sent) AS sms_sent,
avg(Vw_Users_Sessions.phone_confirm_attempts) AS phone_confirm_attempts,
-- Vw_Users_Sessions.quick_session AS one_click,
-- Vw_Users_Sessions.delivery AS delivery,
-- Vw_Users_Sessions.offline AS offline,
-- CASE WHEN Vw_Users_Sessions.result = 'credit confirmed' THEN 1 ELSE 0 END AS  'credit_confirmed',
-- CASE WHEN Vw_Users_Sessions.result = 'shop daily limits' THEN 1 ELSE 0 END AS  'shop_daily_limits',
-- CASE WHEN Vw_Users_Sessions.result = 'union debt' THEN 1 ELSE 0 END AS  'union_debt',
-- CASE WHEN Vw_Users_Sessions.result = 'first union loan not repaid' THEN 1 ELSE 0 END AS  'first_union_loan_not_repaid',
-- CASE WHEN Vw_Users_Sessions.result = 'conditions not met' THEN 1 ELSE 0 END AS  'conditions_not_met',
-- FIRST SESSION ACTIVITY END

-- FIRST PURCHASE ACTIVITY BEGINS
	 (SELECT
			Amount_Original_
		FROM
			(SELECT
					Vw_Loans_Issued_two.Amount_Original AS Amount_Original_,
					MIN(Vw_Loans_Issued_two.Date_Create) AS Date_,
					Vw_Loans_Issued_two.User_Id AS User_Id_
				FROM
					Vw_Loans_Issued_two
				GROUP BY
					Vw_Loans_Issued_two.User_Id
			) AS First_Loan
		WHERE
			User_Id_ = users.id
	) AS Amount_First_Purchase,
(UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan) - Vw_Users_Sessions.date_start) AS decision_time_t,  -- TIMEDIFF(Vw_Users_Loans.Date_First_Loan, Vw_Users_Sessions.date_start) AS Decision_Time,

(Vw_Users_Sessions.amount	- 
(SELECT
			Amount_Original_
		FROM
			(SELECT
					Vw_Loans_Issued_two.Amount_Original AS Amount_Original_,
					MIN(Vw_Loans_Issued_two.Date_Create) AS Date_,
					Vw_Loans_Issued_two.User_Id AS User_Id_
				FROM
					Vw_Loans_Issued_two
				GROUP BY
					Vw_Loans_Issued_two.User_Id
			) AS First_Loan
		WHERE
			User_Id_ = users.id) ) AS amounts_diff, 

-- ТО DO: ADD MORE DATA FROM THE SESSION WHEN THE PURCHASE WAS MADE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- TO DO: SEE INTO FIRST SESSION IDENTIFICATION WHEN THE PHONE NUMBER WAS NOT ENTERED AND USER ID WAS NULL

-- FIRST PURCHASE ACTIVITY END

/*
-- AVERAGE SESSION ACTIVITY BEGIN
Vw_Users_Sessions.time_to_read_description_Avg,
Vw_Users_Sessions.time_to_score_Avg,
Vw_Users_Sessions.time_to_enter_phone_Avg,
Vw_Users_Sessions.time_to_read_terms_Avg,
Vw_Users_Sessions.time_to_enter_code_Avg,
-- AVERAGE SESSION ACTIVITY END


Vw_Users_Loans.Is_Regular AS Is_Regular,
*/

-- USER AND SNS PROFILING BEGINS
/*
CASE
WHEN users.gender = 'male' THEN	1
WHEN users.gender = 'female' THEN	0
ELSE	NULL END AS Gender,
*/
AVG(sns_profiles.count_friends) AS Friends,
AVG(DATEDIFF(NOW(), sns_profiles.birthdate)) AS age_days,
AVG(DATEDIFF(FROM_UNIXTIME(Vw_Users_Sessions.date_start), FROM_UNIXTIME(sns_profiles.date_create_profile))) AS time_since_creation,
AVG(DATEDIFF(FROM_UNIXTIME(Vw_Users_Sessions.date_start), FROM_UNIXTIME(sns_profiles.date_last_login))) AS time_since_login,
AVG(DATEDIFF(FROM_UNIXTIME(Vw_Users_Sessions.date_start), FROM_UNIXTIME(sns_profiles.date_last_activity))) AS time_since_activity

-- USER AND SNS PROFILING ENDS
/*
-- USER AND SNS PROFILING SUPPORT DATA BEGINS
sns_profiles.first_name AS First_Name,
sns_profiles.last_name AS Last_Name,
sns_profiles.gender AS Gender,
FROM_UNIXTIME(sns_profiles.date_create_profile) AS Date_Create_Prifile,
FROM_UNIXTIME(sns_profiles.date_last_login) AS Date_Last_Login,
FROM_UNIXTIME(sns_profiles.date_last_activity) AS Date_Last_Activity,
FROM_UNIXTIME(sns_profiles.date_create) AS Date_Create_,
(sns_profiles.date_create_profile) AS Date_Create_Prifile_Unix,
(sns_profiles.date_last_login) AS Date_Last_Login_Unix,
(sns_profiles.date_last_activity) AS Date_Last_Activity_Unix,
(sns_profiles.date_create) AS Date_Create_Unix,

Vw_Users_Sessions.result AS result,
sns_profiles.condition_passed AS Condition_Pass
-- USER AND SNS PROFILING SUPPORT DATA ENDS
*/
FROM
	users
LEFT OUTER JOIN Vw_Users_Loans ON Vw_Users_Loans.User_Id = users.id
LEFT OUTER JOIN Vw_Users_Sessions ON Vw_Users_Sessions.User_Id = users.id
LEFT OUTER JOIN sns_profiles on sns_profiles.id = Vw_Users_Sessions.sns_profile_id 
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
AND Vw_Users_Loans.Date_First_Loan > '2013-10-20 00:00:00'
AND Vw_Users_Loans.Date_First_Loan < '2013-12-20 00:00:00'
AND Vw_Users_Sessions.is_new_user = 1
AND Vw_Users_Sessions.time_to_read_description >= 0 AND
Vw_Users_Sessions.time_to_enter_phone >= 0 AND
Vw_Users_Sessions.time_to_read_terms >= 0 AND
Vw_Users_Sessions.time_to_enter_code >= 0 
AND Vw_Users_Sessions.shop_id IN (10001, 10005, 10008, /* 10009, 10010, */ 10014)
GROUP BY
Vw_Users_Sessions.shop_id,
Vw_Users_Loans.Bin_Moving_Default
ORDER BY
Vw_Users_Sessions.shop_id ASC,
Vw_Users_Loans.Bin_Moving_Default
	