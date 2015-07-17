DROP TABLE IF EXISTS ch_profiles_default;

/*
CREATE TABLE ch_profiles_default(
	sns_profile_id BIGINT NULL,
	user_id BIGINT NULL,
	union_id BIGINT NULL,
	date_create_sns_profile DATETIME NULL,
	date_create_credit DATETIME NULL,
	date_create_session DATETIME NULL,
	Default_45 INT NULL,
	Default_60 INT NULL,
	Default_Moving INT NULL,
	Passed INT NULL,
	Purchased INT NULL,
	sess_result_count_ud INT NULL,
	sess_result_count_fulnr INT NULL,
	sess_result_count_fslnr INT NULL,
	sess_result_count_udl INT NULL,
	sess_result_count_cnm INT NULL,
	sess_result_count_ub INT NULL,
	sess_result_count_snf INT NULL,
PRIMARY KEY (sns_profile_id)
);

INSERT INTO ch_profiles_default (sns_profile_id, user_id, union_id, date_create_sns_profile, date_create_credit, date_create_session, 
Default_45, Default_60, Default_Moving, Passed, Purchased, sess_result_count_ud, sess_result_count_fulnr, sess_result_count_fslnr, sess_result_count_udl,
sess_result_count_cnm, sess_result_count_ub, sess_result_count_snf)
*/

CREATE TABLE ch_profiles_default
(PRIMARY KEY sns_profile_id (sns_profile_id), 
INDEX sns_profile_id (sns_profile_id),
INDEX union_id (union_id),
INDEX union_id_profile (union_id, sns_profile_id))

SELECT
	sns_profiles.sns_profile_id as sns_profile_id,
	sns_profiles.user_id as user_id,
/*
(select _ITEM from (SELECT
				paydb.union_sns_profiles.sns_item_id as _ID,
				paydb.union_sns_profiles.union_id as _ITEM
				from paydb.union_sns_profiles 
) as temptable1
			WHERE _ID = sns_profiles.sns_profile_id) as union_id,
*/
-- paydb.union_sns_profiles.union_id as union_id,
paydb.union_users.union_id as union_id,

(select _ITEM from (SELECT
				paydb.unions.id as _ID,
				paydb.unions.blocked as _ITEM
				from paydb.unions
) as temptable1
			WHERE _ID = paydb.union_users.union_id) as union_blocked,

	FROM_UNIXTIME(sns_profiles.date_create) as date_create_sns_profile,
	Vw_Loans_Issued_two.Date_Create as date_create_credit,

	max(Vw_Loans_Issued_two.Loan_Number) as Loan_Number,
	-- min(Vw_Sessions_Data.date_start) as date_create_session,

	CASE
	WHEN max(Vw_Loans_Issued_two.Loan_Number) IS NULL THEN NULL
	WHEN max(Vw_Loans_Issued_two.Loan_Number) > 4 THEN 1
	ELSE 0
	END as Paid_Back_3_Plus_Times,

	CASE
	WHEN SUM(Vw_Loans_Issued_two.Bin_First_Default_45) IS NULL THEN NULL
	WHEN SUM(Vw_Loans_Issued_two.Bin_First_Default_45) > 0 THEN 1
	ELSE 0
	END as Default_45,

	CASE	
	WHEN SUM(Vw_Loans_Issued_two.Bin_First_Default_60) IS NULL THEN NULL
	WHEN SUM(Vw_Loans_Issued_two.Bin_First_Default_60) > 0 THEN 1
	ELSE 0
	END as Default_60,

	CASE	
	WHEN SUM(Vw_Loans_Issued_two.Binary_Default_45) IS NULL THEN NULL
	WHEN SUM(Vw_Loans_Issued_two.Binary_Default_45) > 0 THEN 1
	ELSE 0
	END as Default_Moving,

	sns_profiles.condition_passed as Passed,

	CASE
	WHEN SUM(Vw_Loans_Issued_two.Binary_Default_45) IS NULL THEN NULL
	WHEN SUM(Vw_Loans_Issued_two.Binary_Default_45) > 0 THEN 1
	ELSE 0
	END as Purchased
/*
-- **************************************************************** ПРИЧИНЫ ОТКАЗА ПО САМОМУ НОВОМУ ЮНИОНУ ПОЛЬЗОВАТЕЛЯ НЕ ЗАВИСИМО ОТ ПРОФИЛЯ ****************************************************************
SessResultCountUnionCurrent(sns_profiles.sns_profile_id,  (select _ITEM from (SELECT
				paydb.union_sns_profiles.sns_item_id as _ID,
				paydb.union_sns_profiles.union_id as _ITEM
				from paydb.union_sns_profiles 
) as temptable1
			WHERE _ID = sns_profiles.sns_profile_id), 'union debt') AS sess_result_count_ud,

SessResultCountUnionCurrent(sns_profiles.sns_profile_id,  (select _ITEM from (SELECT
				paydb.union_sns_profiles.sns_item_id as _ID,
				paydb.union_sns_profiles.union_id as _ITEM
				from paydb.union_sns_profiles 
) as temptable1
			WHERE _ID = sns_profiles.sns_profile_id), 'first union loan not repaid') AS sess_result_count_fulnr,

SessResultCountUnionCurrent(sns_profiles.sns_profile_id,  (select _ITEM from (SELECT
				paydb.union_sns_profiles.sns_item_id as _ID,
				paydb.union_sns_profiles.union_id as _ITEM
				from paydb.union_sns_profiles 
) as temptable1
			WHERE _ID = sns_profiles.sns_profile_id), 'first shop loan not repaid') AS sess_result_count_fslnr,

SessResultCountUnionCurrent(sns_profiles.sns_profile_id,  (select _ITEM from (SELECT
				paydb.union_sns_profiles.sns_item_id as _ID,
				paydb.union_sns_profiles.union_id as _ITEM
				from paydb.union_sns_profiles 
) as temptable1
			WHERE _ID = sns_profiles.sns_profile_id), 'unrepaid default loan') AS sess_result_count_udl,

SessResultCountUnionCurrent(sns_profiles.sns_profile_id,  (select _ITEM from (SELECT
				paydb.union_sns_profiles.sns_item_id as _ID,
				paydb.union_sns_profiles.union_id as _ITEM
				from paydb.union_sns_profiles 
) as temptable1
			WHERE _ID = sns_profiles.sns_profile_id), 'conditions not met') AS sess_result_count_cnm,

SessResultCountUnionCurrent(sns_profiles.sns_profile_id,  (select _ITEM from (SELECT
				paydb.union_sns_profiles.sns_item_id as _ID,
				paydb.union_sns_profiles.union_id as _ITEM
				from paydb.union_sns_profiles 
) as temptable1
			WHERE _ID = sns_profiles.sns_profile_id), 'union blocked') AS sess_result_count_ub,

SessResultCountUnionCurrent(sns_profiles.sns_profile_id,  (select _ITEM from (SELECT
				paydb.union_sns_profiles.sns_item_id as _ID,
				paydb.union_sns_profiles.union_id as _ITEM
				from paydb.union_sns_profiles 
) as temptable1
			WHERE _ID = sns_profiles.sns_profile_id), 'session not finished') AS sess_result_count_snf
*/

FROM
	sns_profiles
	-- LEFT OUTER JOIN Vw_Sessions_Data on Vw_Sessions_Data.sns_profile_id = sns_profiles.id 
	LEFT OUTER JOIN Vw_Loans_Issued_two on Vw_Loans_Issued_two.User_Id = sns_profiles.user_id
	LEFT OUTER JOIN paydb.union_users on paydb.union_users.user_id = sns_profiles.user_id
	-- LEFT OUTER JOIN paydb.union_sns_profiles on paydb.union_sns_profiles.sns_item_id = sns_profiles.sns_profile_id

-- where sns_profiles.condition_passed = 1
GROUP BY sns_profiles.sns_profile_id
;

