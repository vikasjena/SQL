SET @Date = '2014-11-30';

DROP TABLE IF EXISTS paydb_andrew.client_data_values;
CREATE TABLE IF NOT EXISTS paydb_andrew.client_data_values
LIKE paydb.client_data_values;
INSERT INTO paydb_andrew.client_data_values
SELECT * from paydb.client_data_values WHERE paydb.client_data_values.session_id IN 
(SELECT _ID FROM(SELECT paydb.credit_sessions.id as _ID from paydb.credit_sessions WHERE FROM_UNIXTIME(paydb.credit_sessions.date_start) BETWEEN '2014-02-04' AND @Date) as Table1)
;

DROP TABLE IF EXISTS paydb_andrew.credit_sessions;
CREATE TABLE IF NOT EXISTS paydb_andrew.credit_sessions
LIKE paydb.credit_sessions;
INSERT INTO paydb_andrew.credit_sessions
SELECT * from paydb.credit_sessions WHERE FROM_UNIXTIME(paydb.credit_sessions.date_start) BETWEEN '2014-02-04' AND @Date
;

DROP TABLE IF EXISTS paydb_andrew.an_sessions;
CREATE TABLE IF NOT EXISTS paydb_andrew.an_sessions
LIKE paydb.an_sessions;
INSERT INTO paydb_andrew.an_sessions
SELECT * from paydb.an_sessions WHERE paydb.an_sessions.session_id IN 
(SELECT _ID FROM(SELECT paydb.credit_sessions.id as _ID from paydb.credit_sessions WHERE FROM_UNIXTIME(paydb.credit_sessions.date_start) BETWEEN '2014-02-04' AND @Date) as Table1)
;

DROP TABLE IF EXISTS paydb_andrew.an_client_data_value_options;
CREATE TABLE IF NOT EXISTS paydb_andrew.an_client_data_value_options
LIKE paydb.an_client_data_value_options;
INSERT INTO paydb_andrew.an_client_data_value_options
SELECT * from paydb.an_client_data_value_options
;
DROP TABLE IF EXISTS paydb_andrew.an_sets;
CREATE TABLE IF NOT EXISTS paydb_andrew.an_sets
LIKE paydb.an_sets;
INSERT INTO paydb_andrew.an_sets
SELECT * from paydb.an_sets
;

DROP TABLE IF EXISTS paydb_andrew.client_data_model_log;
CREATE TABLE IF NOT EXISTS paydb_andrew.client_data_model_log
LIKE paydb.client_data_model_log ;
INSERT INTO paydb_andrew.client_data_model_log
SELECT * from paydb.client_data_model_log 
;

DROP TABLE IF EXISTS paydb_andrew.scoring_model_log;
CREATE TABLE IF NOT EXISTS paydb_andrew.scoring_model_log
LIKE paydb.scoring_model_log ;
INSERT INTO paydb_andrew.scoring_model_log
SELECT * from paydb.scoring_model_log 
;

-- DROP TABLE IF EXISTS paydb_andrew.sns_profiles;
-- CREATE TABLE IF NOT EXISTS paydb_andrew.sns_profiles
-- LIKE paydb.sns_profiles ;
-- INSERT INTO paydb_andrew.sns_profiles
-- SELECT * from paydb.sns_profiles 
-- ;

DROP TABLE IF EXISTS paydb_andrew.client_data;
CREATE TABLE IF NOT EXISTS paydb_andrew.client_data
LIKE paydb.client_data ;
INSERT INTO paydb_andrew.client_data
SELECT * from paydb.client_data 
;

DROP TABLE IF EXISTS paydb_andrew.client_data_fingerprint;
CREATE TABLE IF NOT EXISTS paydb_andrew.client_data_fingerprint
LIKE paydb.client_data_fingerprint;
INSERT INTO paydb_andrew.client_data_fingerprint
SELECT * from paydb.client_data_fingerprint 
;

DROP TABLE IF EXISTS paydb_andrew.Vw_Sessions_Data;
CREATE TABLE IF NOT EXISTS paydb_andrew.Vw_Sessions_Data
LIKE paydb.Vw_Sessions_Data;
INSERT INTO paydb_andrew.Vw_Sessions_Data
SELECT  * from paydb.Vw_Sessions_Data WHERE Vw_Sessions_Data.date_start BETWEEN '2014-02-04' AND @Date
;

DROP TABLE IF EXISTS paydb_andrew.credit_sessions;
CREATE TABLE IF NOT EXISTS paydb_andrew.credit_sessions
LIKE paydb.credit_sessions;
INSERT INTO paydb_andrew.credit_sessions
SELECT  * from paydb.credit_sessions WHERE FROM_UNIXTIME(paydb.credit_sessions.date_start) BETWEEN '2014-02-04' AND @Date

;
DROP TABLE IF EXISTS paydb_andrew.client_data_params;
CREATE TABLE IF NOT EXISTS paydb_andrew.client_data_params
LIKE paydb.client_data_params;
INSERT INTO paydb_andrew.client_data_params
SELECT * FROM paydb.client_data_params
;
-- 
-- DROP TABLE IF EXISTS paydb_andrew.shops;
-- CREATE TABLE IF NOT EXISTS paydb_andrew.shops
-- LIKE paydb.shops;
-- INSERT INTO paydb_andrew.shops
-- SELECT *
-- FROM paydb.shops
-- ;
-- DROP TABLE IF EXISTS paydb_andrew.limits;
-- CREATE TABLE IF NOT EXISTS paydb_andrew.limits
-- LIKE paydb.limits;
-- INSERT INTO paydb_andrew.limits
-- SELECT * FROM paydb.limits
-- ;
-- DROP TABLE IF EXISTS paydb_andrew.interests;
-- CREATE TABLE IF NOT EXISTS paydb_andrew.interests
-- LIKE paydb.interests;
-- INSERT INTO paydb_andrew.interests
-- SELECT * FROM paydb.interests
-- ;
-- ************CONSTRAINTS _2 **********************
 DROP TABLE IF EXISTS paydb_andrew.unions_2;
 CREATE TABLE IF NOT EXISTS paydb_andrew.unions_2
 SELECT * FROM paydb.unions
 ;
 
 DROP TABLE IF EXISTS paydb_andrew.users_2;
 CREATE TABLE IF NOT EXISTS paydb_andrew.users_2
 SELECT paydb.users.*,
				Vw_Users_Loans.Bin_First_Default_45,
				Vw_Users_Loans.Bin_First_Default_60,
				Vw_Users_Loans.Date_First_Loan_U,
				Vw_Users_Loans.Session_First_Loan,
				Vw_Users_Loans.Cohort,
				union_users.union_id,

				(select _COUNT FROM 
						(SELECT
							union_users.union_id as _ID,
							count(union_users.user_id) as _COUNT
							FROM paydb.union_users
							GROUP BY union_users.union_id
							) AS Temp_Table1
						WHERE _ID = paydb.union_users.union_id) as union_quantity_users,

				(select _SUM FROM 
						(SELECT
							cs.current_union_id as _ID,
							sum(COALESCE(cs.bad_unmerged, 0)) as _SUM
							FROM paydb.credit_sessions as cs
							GROUP BY cs.current_union_id
							) AS Temp_Table1
						WHERE _ID = paydb.union_users.union_id) as bad_unmerged,


				(select _SUM FROM 
						(SELECT
							cs.id as _ID,
							COALESCE(cs.bad_unmerged, 0) as _SUM
							FROM paydb.credit_sessions as cs
							) AS Temp_Table1
						WHERE _ID = Vw_Users_Loans.Session_First_Loan) as bad_unmerged_first_sess


 FROM paydb.users
			INNER JOIN paydb.Vw_Users_Loans on paydb.users.id = Vw_Users_Loans.User_Id
			INNER JOIN paydb.union_users on paydb.users.id = paydb.union_users.user_id
			
WHERE Vw_Users_Loans.Date_First_Loan_U > 1391299200
HAVING bad_unmerged = 0 AND union_quantity_users = 1 AND bad_unmerged_first_sess = 0

;
 DROP TABLE IF EXISTS paydb_andrew.users_2_with_bad_unmerged;
 CREATE TABLE IF NOT EXISTS paydb_andrew.users_2_with_bad_unmerged
 SELECT paydb.users.*,
				Vw_Users_Loans.Bin_First_Default_45,
				Vw_Users_Loans.Bin_First_Default_60,
				Vw_Users_Loans.Date_First_Loan_U,
				Vw_Users_Loans.Session_First_Loan,
				Vw_Users_Loans.Session_First_Confirmed_Loan,
				Vw_Users_Loans.Session_First_Full_Session,
				Vw_Users_Loans.Cohort,
				union_users.union_id,

				(select _COUNT FROM 
						(SELECT
							union_users.union_id as _ID,
							count(union_users.user_id) as _COUNT
							FROM paydb.union_users
							GROUP BY union_users.union_id
							) AS Temp_Table1
						WHERE _ID = paydb.union_users.union_id) as union_quantity_users,

				(select _SUM FROM 
						(SELECT
							cs.current_union_id as _ID,
							sum(COALESCE(cs.bad_unmerged, 0)) as _SUM
							FROM paydb.credit_sessions as cs
							GROUP BY cs.current_union_id
							) AS Temp_Table1
						WHERE _ID = paydb.union_users.union_id) as bad_unmerged,


				(select _SUM FROM 
						(SELECT
							cs.id as _ID,
							COALESCE(cs.bad_unmerged, 0) as _SUM
							FROM paydb.credit_sessions as cs
							) AS Temp_Table1
						WHERE _ID = Vw_Users_Loans.Session_First_Loan) as bad_unmerged_first_sess


 FROM paydb.users
			INNER JOIN paydb.Vw_Users_Loans on paydb.users.id = Vw_Users_Loans.User_Id
			INNER JOIN paydb.union_users on paydb.users.id = paydb.union_users.user_id
			
WHERE Vw_Users_Loans.Date_First_Loan_U > 1391299200
-- HAVING bad_unmerged = 0 AND union_quantity_users = 1 AND bad_unmerged_first_sess = 0

-- ************CONSTRAINTS _2 END **********************
/*
CREATE TABLE paydb_andrew.content
SELECT
*
FROM snsdb_new.content
WHERE snsdb_new.content.profile_id IN (select snsdb_new.`profiles`.id from snsdb_new.`profiles` where snsdb_new.`profiles`.sns_item_id in (54169147, 35552384, 170874764))

*/

