SELECT
FROM_UNIXTIME(credit_sessions.date_start) as time,

(select _ID from (select
				client_data_model_log.Session_id_1 as _ID
				from client_data_model_log
				group by client_data_model_log.Session_id_1 ) as TEMP
				where _ID = credit_sessions.id) as is_in_py_log,

credit_sessions.date_auth,

(select _ID from (select
				an_sessions.session_id as _ID
				from an_sessions
				group by an_sessions.session_id ) as TEMP
				where _ID = credit_sessions.id) as is_in_an_sess,

(select _VAL from (select
				client_data_values.`value` as _VAL,
				client_data_values.session_id as _ID
				from client_data_values
				where param_id = '2508' 
				group by client_data_values.session_id) as TEMP
				where _ID = credit_sessions.id) as is_in_cl_data_vals,

(select _VAL from (select
				client_data_fingerprint.canvas as _VAL,
				client_data_fingerprint.session_id as _ID
				from client_data_fingerprint
				group by client_data_fingerprint.session_id) as TEMP
				where _ID = credit_sessions.id) as is_in_fingerprint_c,
/*
(select _VAL from (select
				client_data_fingerprint.`all` as _VAL,
				client_data_fingerprint.session_id as _ID
				from client_data_fingerprint
				group by client_data_fingerprint.session_id) as TEMP
				where _ID = credit_sessions.id) as is_in_fingerprint_a,

(select _VAL from (select
				client_data_fingerprint.is_ie as _VAL,
				client_data_fingerprint.session_id as _ID
				from client_data_fingerprint
				group by client_data_fingerprint.session_id) as TEMP
				where _ID = credit_sessions.id) as is_in_fingerprint_ie,

(select _VAL from (select
				client_data_fingerprint.screen as _VAL,
				client_data_fingerprint.session_id as _ID
				from client_data_fingerprint
				group by client_data_fingerprint.session_id) as TEMP
				where _ID = credit_sessions.id) as is_in_fingerprint_s,

(select _VAL from (select
				client_data_fingerprint.w_options as _VAL,
				client_data_fingerprint.session_id as _ID
				from client_data_fingerprint
				group by client_data_fingerprint.session_id) as TEMP
				where _ID = credit_sessions.id) as is_in_fingerprint_wo,
*/
credit_sessions.union_id,
credit_sessions.date_sns_redirect,

credit_sessions.*


from credit_sessions
where credit_sessions.shop_id in (select shop_id from tmp_python_union_shops)
			and credit_sessions.date_sns_redirect is not null
having date_auth is NOT NULL and is_in_py_log IS NULL
order by id desc
Limit 1000