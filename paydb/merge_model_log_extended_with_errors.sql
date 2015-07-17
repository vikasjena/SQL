Drop TEMPORARY TABLE IF EXISTS union_log_tmp;
CREATE TEMPORARY TABLE IF NOT EXISTS union_log_tmp
SELECT 

(select time from (select
				(FROM_UNIXTIME(credit_sessions.date_start)) as time,
				credit_sessions.id as _ID
				from credit_sessions
				) as TEMP
				where _ID = client_data_model_log.Session_id_1) as time,

(select u_id from (select
				credit_sessions.user_id as u_id,
				credit_sessions.id as _ID
				from credit_sessions
				) as TEMP
				where _ID = client_data_model_log.Session_id_1) as u_id_1,

(select u_id from (select
				credit_sessions.user_id as u_id,
				credit_sessions.id as _ID
				from credit_sessions
				) as TEMP
				where _ID = client_data_model_log.Session_id_2) as u_id_2,

(select _VAL from (select
				client_data_values.`value` as _VAL,
				client_data_values.session_id as _ID
				from client_data_values
				where param_id = '2509'
				group by client_data_values.session_id ) as TEMP
				where _ID = client_data_model_log.Session_id_1) as S1_OS,

(select _VAL from (select
				client_data_values.`value` as _VAL,
				client_data_values.session_id as _ID
				from client_data_values
				where param_id = '2509'
				group by client_data_values.session_id ) as TEMP
				where _ID = client_data_model_log.Session_id_2) as S2_OS,

(select _VAL from (select
				client_data_values.`value` as _VAL,
				client_data_values.session_id as _ID
				from client_data_values
				where param_id = '2508'
				group by client_data_values.session_id ) as TEMP
				where _ID = client_data_model_log.Session_id_1) as S1_BR,


(select _VAL from (select
				client_data_values.`value` as _VAL,
				client_data_values.session_id as _ID
				from client_data_values
				where param_id = '2508'
				group by client_data_values.session_id ) as TEMP
				where _ID = client_data_model_log.Session_id_2) as S2_BR,

case 
when Union_id_1 != Union_id_2 and Union_id_2 != 0 then 1 else null 
end as mrg,

 client_data_model_log.* 
FROM `client_data_model_log` 
HAVING mrg = 1
order by id desc;



Drop TEMPORARY TABLE IF EXISTS union_log_tmp_2;
CREATE TEMPORARY TABLE IF NOT EXISTS union_log_tmp_2
SELECT 

(select item_ from (select
				Vw_Users_Loans.Amount_Original_Sum as item_,
				Vw_Users_Loans.User_Id as _ID
				from Vw_Users_Loans
				) as TEMP
				where _ID = union_log_tmp.u_id_1) as u_1_debt,

(select item_ from (select
				Vw_Users_Loans.Amount_Original_Sum as item_,
				Vw_Users_Loans.User_Id as _ID
				from Vw_Users_Loans
				) as TEMP
				where _ID = union_log_tmp.u_id_2) as u_2_debt,

(select item_ from (select
				Vw_Users_Loans.Amount_Original_Paid_Sum as item_,
				Vw_Users_Loans.User_Id as _ID
				from Vw_Users_Loans
				) as TEMP
				where _ID = union_log_tmp.u_id_1) as u_1_paid,

(select item_ from (select
				Vw_Users_Loans.Quantity_Payments as item_,
				Vw_Users_Loans.User_Id as _ID
				from Vw_Users_Loans
				) as TEMP
				where _ID = union_log_tmp.u_id_1) as u_1_paid_c,

(select item_ from (select
				Vw_Users_Loans.Phone as item_,
				Vw_Users_Loans.User_Id as _ID
				from Vw_Users_Loans
				) as TEMP
				where _ID = union_log_tmp.u_id_1) as u_1_phone,

(select item_ from (select
				Vw_Users_Loans.Amount_Original_Paid_Sum as item_,
				Vw_Users_Loans.User_Id as _ID
				from Vw_Users_Loans
				) as TEMP
				where _ID = union_log_tmp.u_id_2) as u_2_paid,

(select item_ from (select
				Vw_Users_Loans.Quantity_Payments as item_,
				Vw_Users_Loans.User_Id as _ID
				from Vw_Users_Loans
				) as TEMP
				where _ID = union_log_tmp.u_id_2) as u_2_paid_c,

(select item_ from (select
				Vw_Users_Loans.Phone as item_,
				Vw_Users_Loans.User_Id as _ID
				from Vw_Users_Loans
				) as TEMP
				where _ID = union_log_tmp.u_id_2) as u_2_phone,

CASE WHEN 
(select item_ from (select
				client_data_fingerprint.`all` as item_,
				client_data_fingerprint.session_id as _ID
				from client_data_fingerprint
				) as TEMP
				where _ID = union_log_tmp.Session_id_1) =

(select item_ from (select
				client_data_fingerprint.`all` as item_,
				client_data_fingerprint.session_id as _ID
				from client_data_fingerprint
				) as TEMP
				where _ID = union_log_tmp.Session_id_2) THEN 1 ELSE NULL END AS fp_math,

(select item_ from (select
				client_data_fingerprint.`all` as item_,
				client_data_fingerprint.session_id as _ID
				from client_data_fingerprint
				) as TEMP
				where _ID = union_log_tmp.Session_id_1) as fp_u_1,

(select item_ from (select
				client_data_fingerprint.`all` as item_,
				client_data_fingerprint.session_id as _ID
				from client_data_fingerprint
				) as TEMP
				where _ID = union_log_tmp.Session_id_2) as fp_u_2,



union_log_tmp.* 
from union_log_tmp
;
-- SELECTING RESULTS *****************************************************************
SELECT * from union_log_tmp_2
;
-- MARKING ERRORS (OBVIOUS) **********************************************************
SELECT 
CASE 
when u_id_1 = u_id_2 THEN NULL
when fp_math = 1 THEN NULL
when u_1_paid is NULL AND u_2_paid > 1000 THEN 'error'
when u_2_paid is NULL AND u_1_paid > 1000 THEN 'error'
when (u_1_paid < 1000 OR u_1_paid is NULL) AND u_2_paid > 1000 THEN 'error'
when (u_2_paid < 1000 OR u_2_paid is NULL) AND u_1_paid > 1000 THEN 'error'
when u_2_paid > 1000 AND u_1_paid > 1000 THEN 'error'
when u_2_paid_c > 2 AND u_1_paid = 0 THEN 'error'
when u_1_paid_c > 2 AND u_2_paid = 0 THEN 'error'
when u_2_paid_c > 2 AND u_1_paid = NULL THEN 'error'
when u_1_paid_c > 2 AND u_2_paid = NULL THEN 'error'
END AS nn_error,

union_log_tmp_2.*
FROM union_log_tmp_2
-- where time > '2014-08-02 11:00:00'
where time > '2014-08-27 15:00:00'
			-- and (Union_id_1 = 786 or Union_id_2 = 786)
HAVING nn_error = 'error' 
						-- and Union_id_1 = 242
				-- and Out_NN < 0.9
			-- and Shop_id_1 = 10014