DROP TABLE IF EXISTS scoring_short_data_full;
CREATE table if not EXISTS scoring_short_data_full
SELECT
-- DEFAULT MEASURES START ---------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Vw_Users_Loans.Session_First_Loan AS Session_First_Purchase_Id,
-- Vw_Users_Loans.Days_To_Pay_Avg AS days_to_pay_avg,
-- Vw_Users_Loans.Bin_Moving_Default AS bin_moving_default,
-- CASE WHEN Vw_Users_Loans.Bin_Moving_Default = 0 THEN 2 ELSE 1 END AS bin_moving_default,
-- Vw_Users_Loans.Bin_First_Default_30 AS bin_first_default_30,
Vw_Users_Loans.Bin_First_Default_45 AS bin_first_default_45,
Vw_Users_Loans.Bin_First_Default_60 AS bin_first_default_60,
-- Vw_Users_Loans.Bin_First_Default_90 AS bin_first_default_90,

-- DEFAULT MEASURES END --

-- sns_profiles.first_name as name_,
-- -------------------------------- REAL NAME --------------------------------
/*
CASE WHEN
(select id from names where name = sns_profiles.first_name limit 1) 
IS NOT NULL THEN 1 ELSE 0 END AS real_name,
*/
-- -------------------------------- REAL NAME --------------------------------

/*
-- IDENTIFICATIONS BEGIN --------------------------------------------------------------------------------------------------------------------------------------------------------------
		users.usr_tmp_id AS User_Temp_Id,
		sns_profiles.sns_id AS Sns_Id,
		users.phone AS Phone,
		users.first_name AS 'Name',
		users.last_name AS Surname,
		users.id AS user_id,
		Vw_Users_Loans.Is_BLocked AS Is_BLocked,
	  Vw_Users_Loans.Union_Id AS Union_Id,
		Vw_Users_Loans.Sub_Id AS Sub_Id,
		Vw_Users_Loans.Session_First_Loan AS Session_First_Purchase_Id,
-- IDENTIFICATIONS END --

-- DATES FOR ORDERING AND SORTING BEGIN --
		Vw_Users_Loans.Date_First_Loan AS Date_First_Purchase,
		UNIX_TIMESTAMP(Vw_Users_Loans.Date_First_Loan) AS Date_First_Purchase_U,
		Vw_Users_Loans.Count_Shops_Credits AS Count_Shops,
		Vw_Users_Loans.Is_Regular AS Is_Regular,
-- DATES FOR ORDERING AND SORTING END --

-- STATISTICS FOR CROSS SHOPS SORTING BEGIN --
	 Vw_Users_Loans.Count_Credits AS Count_Credits,
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

-- USER AND SNS PROFILING BEGINS-------------------------------------------------------------------------------------------------------------------------------------------------------------

-- DATEDIFF(NOW(), sns_profiles.birthdate) AS age_days,

CASE WHEN DATEDIFF(NOW(), sns_profiles.birthdate)/365 IS NULL THEN 1 ELSE 0 END AS age_null,
-- CASE WHEN DATEDIFF(NOW(), sns_profiles.birthdate)/365 > 0  and DATEDIFF(NOW(), sns_profiles.birthdate)/365 < 14 THEN 1 ELSE 0 END AS age_grp_0_13,
CASE WHEN DATEDIFF(NOW(), sns_profiles.birthdate)/365 >= 14  and DATEDIFF(NOW(), sns_profiles.birthdate)/365 < 20 THEN 1 ELSE 0 END AS age_grp_14_20,
CASE WHEN DATEDIFF(NOW(), sns_profiles.birthdate)/365 >= 20 and DATEDIFF(NOW(), sns_profiles.birthdate)/365 < 25 THEN 1 ELSE 0 END AS age_grp_20_25,
CASE WHEN DATEDIFF(NOW(), sns_profiles.birthdate)/365 >= 25 and DATEDIFF(NOW(), sns_profiles.birthdate)/365 < 30 THEN 1 ELSE 0 END AS age_grp_25_30,
CASE WHEN DATEDIFF(NOW(), sns_profiles.birthdate)/365 >= 30 and DATEDIFF(NOW(), sns_profiles.birthdate)/365 < 35 THEN 1 ELSE 0 END AS age_grp_30_35,
CASE WHEN DATEDIFF(NOW(), sns_profiles.birthdate)/365 >= 35 and DATEDIFF(NOW(), sns_profiles.birthdate)/365 < 40 THEN 1 ELSE 0 END AS age_grp_35_40,
CASE WHEN DATEDIFF(NOW(), sns_profiles.birthdate)/365 >= 40 and DATEDIFF(NOW(), sns_profiles.birthdate)/365 < 45 THEN 1 ELSE 0 END AS age_grp_40_45,
CASE WHEN DATEDIFF(NOW(), sns_profiles.birthdate)/365 >= 45 and DATEDIFF(NOW(), sns_profiles.birthdate)/365 < 50 THEN 1 ELSE 0 END AS age_grp_45_50,
CASE WHEN DATEDIFF(NOW(), sns_profiles.birthdate)/365 >= 50 and DATEDIFF(NOW(), sns_profiles.birthdate)/365 < 60 THEN 1 ELSE 0 END AS age_grp_50_60,
CASE WHEN DATEDIFF(NOW(), sns_profiles.birthdate)/365 >= 60 THEN 1 ELSE 0 END AS 'age_grp_60_plus',

-- CASE WHEN users.gender = 'male' THEN	1 WHEN users.gender = 'female' THEN	0 ELSE	NULL END AS Gender,
CASE WHEN sns_profiles.gender = 'm' THEN	1 WHEN sns_profiles.gender = 'f' THEN	0 ELSE	NULL END AS Gender,
sns_profiles.count_friends AS Friends,

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

sns_profiles.condition_passed AS Condition_Pass
-- USER AND SNS PROFILING SUPPORT DATA ENDS
*/
-- USER AND SNS PROFILING ENDS

-- QIWI SCORING BEGINS ------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
sum(Qiwi_Scoring.TotalPaymentsSum) AS TotalPaymentsSum,
sum(Qiwi_Scoring.Payments6MonthSum) AS Payments6MonthSum, 	 
sum(Qiwi_Scoring.Payments3MonthSum) AS 	Payments3MonthSum,
sum(Qiwi_Scoring.Payments1MonthSum)  AS Payments1MonthSum,
sum(Qiwi_Scoring.TotalPaymentsCount) AS TotalPaymentsCount	 ,
sum(Qiwi_Scoring.Payments6MonthCount) AS 	Payments6MonthCount,
sum(Qiwi_Scoring.Payments3MonthCount) AS	Payments3MonthCount,
sum(Qiwi_Scoring.Payments1MonthCount) AS Payments1MonthCount,
sum(Qiwi_Scoring.TotalMaxPayment) AS TotalMaxPayment,
sum(Qiwi_Scoring.MaxPayment6Month) AS MaxPayment6Month,
sum(Qiwi_Scoring.MaxPayment3Month) AS MaxPayment3Month,
sum(Qiwi_Scoring.MaxPayment1Month) AS MaxPayment1Month,
-- sum(Qiwi_Scoring.FirstPayDate) AS FirstPayDate,
-- sum(Qiwi_Scoring.LastPayDate) AS LastPayDate,
sum(Qiwi_Scoring.PaymentsForMaxPaymentsCountProvider) AS PaymentsForMaxPaymentsCountProvider,	
sum(Qiwi_Scoring.MaxDifferenceInDays) AS MaxDifferenceInDays
*/


ABS(((select _COUNT FROM 
	(SELECT
		paydb.user_relations_lite_directional.sns_item_id0 as _ID,
		count(DISTINCT paydb.user_relations_lite_directional.sns_item_id1) as _COUNT
	FROM paydb.user_relations_lite_directional
	GROUP BY paydb.user_relations_lite_directional.sns_item_id0) AS Temp_Table1
	WHERE sns_profiles.sns_profile_id = _ID) / sns_profiles.count_friends)*100 - 100) as Abs_Frnd_Diff,

Vw_Users_Loans.Date_First_Loan AS Date_First_Purchase,
sns_profiles.sns_id AS Sns_Id,

CASE WHEN sns_profiles.sns_profile_id is NULL
THEN ch_profile_id_old.Uid
ELSE sns_profiles.sns_profile_id
END AS sns_profile_id,

Vw_Users_Loans.Shop_Id AS shop_id

FROM
	users
LEFT OUTER JOIN Vw_Users_Loans ON Vw_Users_Loans.User_Id = users.id
LEFT OUTER JOIN sns_profiles on sns_profiles.user_id = users.id -- and sns_profiles.sns_id = 1
LEFT OUTER JOIN ch_profile_id_old on Vw_Users_Loans.Old_Id = ch_profile_id_old.UserFk

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
-- AND Vw_Users_Loans.Date_First_Loan > '2013-10-18 00:00:00'
-- AND Vw_Users_Loans.Date_First_Loan < '2014-01-10 00:00:00'  -- loan_time_to_tead_terms НЕДОСТОВЕРНЫ С 10 Января по 27 Марта 2014.
AND DATE_ADD(Vw_Users_Loans.Date_First_Loan,INTERVAL 45 DAY) < NOW()
-- AND Vw_Users_Loans.Shop_Id NOT IN (10002, 10003, 10009, 10010)
-- AND sns_profiles.sns_id = 1
GROUP BY
	Vw_Users_Loans.User_Id
-- HAVING Abs_Frnd_Diff <= 10
;
SELECT * FROM scoring_short_data_full;