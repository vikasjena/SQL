DROP TABLE IF EXISTS Vw_Users_Loans;
CREATE TABLE Vw_Users_Loans

(PRIMARY KEY User_Id (User_Id), 
INDEX User_Id (User_Id),
INDEX sns_profile_id_first_sess (sns_profile_id_first_sess),
INDEX sns_profile_id_passed (sns_profile_id_passed),
INDEX Union_Id (Union_Id),
INDEX Phone (Phone),
INDEX Cohort (Cohort),
INDEX sns_profile_id (sns_profile_id))

SELECT 
	Vw_Loans_Issued_two.Old_Id, 
	Vw_Loans_Issued_two.Shop_Id,

(select _SNS_ID FROM 
	(SELECT
		min(paydb.sns_profiles.date_create),
		paydb.sns_profiles.user_id as _ID,
		paydb.sns_profiles.sns_id as _SNS_ID
		FROM sns_profiles
		GROUP BY sns_profiles.user_id) AS Temp_Table1
	WHERE Vw_Loans_Issued_two.User_Id = _ID)
 as sns_id,

COALESCE(
(select _SNS_ID FROM 
	(SELECT
		min(paydb.sns_profiles.date_create),
		paydb.sns_profiles.user_id as _ID,
		paydb.sns_profiles.sns_profile_id as _SNS_ID
		FROM sns_profiles
		GROUP BY sns_profiles.user_id) AS Temp_Table1
	WHERE Vw_Loans_Issued_two.User_Id = _ID),  

(select _SNS_ID FROM 
	(SELECT
		ch_profile_id_old.UserFk as _ID,
		ch_profile_id_old.Uid as _SNS_ID
		FROM ch_profile_id_old
		) AS Temp_Table1
	WHERE Vw_Loans_Issued_two.Old_Id = _ID)

) as sns_profile_id,

(select _SNS_ID FROM 
	(SELECT
		min(paydb.sns_profiles.date_create),
		paydb.sns_profiles.user_id as _ID,
		paydb.sns_profiles.sns_id as _SNS_ID
		FROM sns_profiles
		WHERE sns_profiles.condition_passed = 1
		GROUP BY sns_profiles.user_id) AS Temp_Table1
	WHERE Vw_Loans_Issued_two.User_Id = _ID)
 as sns_id_passed,

COALESCE(
(select _SNS_ID FROM 
	(SELECT
		min(paydb.sns_profiles.date_create),
		paydb.sns_profiles.user_id as _ID,
		paydb.sns_profiles.sns_profile_id as _SNS_ID
		FROM sns_profiles
		WHERE sns_profiles.condition_passed = 1
		GROUP BY sns_profiles.user_id) AS Temp_Table1
	WHERE Vw_Loans_Issued_two.User_Id = _ID),  

(select _SNS_ID FROM 
	(SELECT
		ch_profile_id_old.UserFk as _ID,
		ch_profile_id_old.Uid as _SNS_ID
		FROM ch_profile_id_old
		) AS Temp_Table1
	WHERE Vw_Loans_Issued_two.Old_Id = _ID)

) as sns_profile_id_passed,

COALESCE(
(select _SNS_ID FROM 
	(SELECT
		min(paydb.Vw_Sessions_Data.date_start),
		paydb.Vw_Sessions_Data.current_union_id as _ID,
		paydb.Vw_Sessions_Data.sns_profile_id as _SNS_ID
		FROM Vw_Sessions_Data
		GROUP BY Vw_Sessions_Data.current_union_id
											) AS Temp_Table1
	WHERE Vw_Loans_Issued_two.union_id_first = _ID), 
 
COALESCE(
(select _SNS_ID FROM 
	(SELECT
		min(paydb.sns_profiles.date_create),
		paydb.sns_profiles.user_id as _ID,
		paydb.sns_profiles.sns_profile_id as _SNS_ID
		FROM sns_profiles
		GROUP BY sns_profiles.user_id) AS Temp_Table1
	WHERE Vw_Loans_Issued_two.User_Id = _ID),  

(select _SNS_ID FROM 
	(SELECT
		ch_profile_id_old.UserFk as _ID,
		ch_profile_id_old.Uid as _SNS_ID
		FROM ch_profile_id_old
		) AS Temp_Table1
	WHERE Vw_Loans_Issued_two.Old_Id = _ID)

)) as sns_profile_id_first_sess,


-- 	Vw_Loans_Issued_two.Product_Id,
	Vw_Loans_Issued_two.User_Id AS User_Id, 
	Vw_Loans_Issued_two.Sub_Id AS Sub_Id, 
	min(Vw_Loans_Issued_two.Union_Id) AS Union_Id, 
 	Vw_Loans_Issued_two.User_Phone AS Phone, 
 	Vw_Loans_Issued_two.limit_id AS limit_id, 
	Vw_Loans_Issued_two.Is_Blocked AS Is_BLocked, 

	CASE 
	WHEN 	COUNT(Vw_Loans_Issued_two.Credit_Id) > 1 THEN 1
	WHEN 	COUNT(Vw_Loans_Issued_two.Credit_Id) = 1 THEN 0
	ELSE NULL END AS Is_Regular, 

	CONCAT(YEAR(MIN(Vw_Loans_Issued_two.Date_Create)),MONTH(MIN(Vw_Loans_Issued_two.Date_Create))) AS Cohort, 

	MIN(Vw_Loans_Issued_two.Session_Id) AS Session_First_Loan, 
	MIN(Vw_Loans_Issued_two.Date_Create) AS Date_First_Loan, 
	MIN(Vw_Loans_Issued_two.Date_Create_U) AS Date_First_Loan_U, 
	MAX(Vw_Loans_Issued_two.Date_Create) AS Date_Last_Loan, 
	MAX(Vw_Loans_Issued_two.Date_Create_U) AS Date_Last_Loan_U, 
	MIN(Vw_Loans_Issued_two.Date_Payment_First) AS Date_Payment_First, 
	MAX(Vw_Loans_Issued_two.Date_Payment_Last) AS Date_Payment_Last, 
	FORMAT(AVG(Vw_Loans_Issued_two.Days_To_Pay),1) AS Days_To_Pay_Avg,

(SELECT _SESS_ID FROM
								(SELECT 
									min(cs.id) AS _SESS_ID,
									cs.user_id as _USER
								FROM credit_sessions as cs
								WHERE cs.result = 'credit confirmed'
								GROUP BY cs.user_id) as TempTbl
WHERE _USER = Vw_Loans_Issued_two.User_Id) as Session_First_Confirmed_Loan,


(SELECT _SESS_ID FROM
								(SELECT 
									min(cs.id) AS _SESS_ID,
									cs.user_id as _USER
								FROM credit_sessions as cs
								WHERE cs.result != 'session not finished'
								GROUP BY cs.user_id) as TempTbl
WHERE _USER = Vw_Loans_Issued_two.User_Id) as Session_First_Full_Session,


(select _PAY_FIRST_METHOD FROM 
	(SELECT
		min(paydb.bills.date_create) as _MIN_DATE,
		paydb.bills.user_id as _ID,
		paydb.bills.payment_system_method_id as _PAY_FIRST_METHOD
		FROM paydb.bills
		WHERE paydb.bills.`status` = 0
		GROUP BY paydb.bills.user_id
				) AS Temp_Table1
	WHERE Vw_Loans_Issued_two.User_Id = _ID)
 as payment_method_first,

(select _PAY_MOST_METHOD FROM 
	(SELECT
		paydb.bills.user_id as _ID,
		paydb.bills.payment_system_method_id as _PAY_MOST_METHOD,
		count(paydb.bills.payment_system_method_id) as _COUNT
		FROM paydb.bills
		WHERE paydb.bills.`status` = 0
		GROUP BY paydb.bills.user_id
		ORDER BY _COUNT DESC
		LIMIT 1 ) AS Temp_Table1
	WHERE Vw_Loans_Issued_two.User_Id = _ID)
 as payment_method_most,


(select _DEF FROM 
	(SELECT
		paydb.Vw_Loans_Issued_two.User_Id as _ID,
		paydb.Vw_Loans_Issued_two.Binary_Default as _DEF,
		paydb.Vw_Loans_Issued_two.Date_Create as _DATE
		FROM paydb.Vw_Loans_Issued_two
		where paydb.Vw_Loans_Issued_two.Loan_Number = 2
) AS Temp_Table1
	WHERE Vw_Loans_Issued_two.User_Id = _ID)
 as bin_moving_default_second_loan,

/*
	(SELECT Date_
 	FROM (SELECT 
					Vw_Loans_Issued_two.Amount_Original AS Amount_Original_,
					MIN(Vw_Loans_Issued_two.Date_Create) AS Date_,
					Vw_Loans_Issued_two.User_Id AS User_Id_
				FROM Vw_Loans_Issued_two
				GROUP BY Vw_Loans_Issued_two.User_Id) 
	AS First_Loan 
	WHERE User_Id_ = 	Vw_Loans_Issued_two.User_Id)
	AS Date_First_Loan_2,
*/
/*
	(SELECT Amount_Original_
 	FROM (SELECT 
					Vw_Loans_Issued_two.Amount_Original AS Amount_Original_,
					MIN(Vw_Loans_Issued_two.Date_Create) AS Date_,
					Vw_Loans_Issued_two.User_Id AS User_Id_
				FROM Vw_Loans_Issued_two
				GROUP BY Vw_Loans_Issued_two.User_Id) 
	AS First_Loan 
	WHERE User_Id_ = 	Vw_Loans_Issued_two.User_Id)
	AS Amount_First_Loan,
*/
	COUNT(Vw_Loans_Issued_two.Credit_Id) AS Count_Credits, 
	COUNT(DISTINCT Vw_Loans_Issued_two.Shop_Id) AS Count_Shops_Credits, 

-- TIME TO READ TERMS AND DESCRIPTION ---

 LoanTimeTerms(MIN(Vw_Loans_Issued_two.Session_Id)) as loan_time_to_tead_terms,

 LoanTimeDescription(MIN(Vw_Loans_Issued_two.Session_Id)) as loan_time_to_tead_description,

-- Vw_Loans_Issued_two.Date_End_Grace, 
-- Vw_Loans_Issued_two.Date_Default, 
-- Vw_Loans_Issued_two.Is_First, 
-- Vw_Loans_Issued_two.Date_PB_All, 
-- Vw_Loans_Issued_two.Status, 
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Amount_Original_Sum, 
	SUM(Vw_Loans_Issued_two.Amount_Remaining) AS Amount_Remaining_Sum, 
	SUM(Vw_Loans_Issued_two.Interest_Accrued) AS Interest_Accrued_Sum,  
	SUM(Vw_Loans_Issued_two.Interest_Remaining) AS Interest_Remaining_Sum,  
	SUM(Vw_Loans_Issued_two.Quantity_Payments) AS Quantity_Payments,
	SUM(Vw_Loans_Issued_two.Amount_Original_Paid) AS Amount_Original_Paid_Sum, 
	SUM(Vw_Loans_Issued_two.Interest_Paid) AS Interest_Paid_Sum, 
	SUM(Vw_Loans_Issued_two.Amount_Sum_Operations) AS Amount_Operations_Sum,
	SUM(Vw_Loans_Issued_two.Operations_Cost) AS Operations_Cost_Sum,
	SUM(Vw_Loans_Issued_two.Amount_Received_Operations) AS Amount_Received_Operations_Sum,
	SUM(Vw_Loans_Issued_two.Amount_To_Pay) AS Amount_To_Pay_Sum, 	
	-- FORMAT(SUM(Vw_Operations_With_Cost_4.Payment_System_Comission)/COUNT(Vw_Operations_With_Cost_4.Bill_Id),2) AS Avg_PS_Comission,

	CASE
	WHEN SUM(Vw_Loans_Issued_two.Binary_Default) > 0 THEN 1
	ELSE 0
	END AS Bin_Moving_Default,

	CASE
	WHEN SUM(Vw_Loans_Issued_two.Binary_Default_45) > 0 THEN 1
	ELSE 0
	END AS Bin_Moving_Default_45,

	CASE
	WHEN SUM(Vw_Loans_Issued_two.Binary_Default_60) > 0 THEN 1
	ELSE 0
	END AS Bin_Moving_Default_60,

	CASE
	WHEN SUM(Vw_Loans_Issued_two.Binary_Default_90) > 0 THEN 1
	ELSE 0
	END AS Bin_Moving_Default_90,

	SUM(Bin_First_Default_30) AS Bin_First_Default_30,
	SUM(Bin_First_Default_45) AS Bin_First_Default_45,
	SUM(Bin_First_Default_60) AS Bin_First_Default_60,
	SUM(Bin_First_Default_90) AS Bin_First_Default_90

FROM Vw_Loans_Issued_two
-- WHERE Shop_Id = 10009
GROUP BY User_Id
-- ORDER BY 
-- Date_First_Loan DESC
-- Interest_Paid DESC