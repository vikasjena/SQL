SELECT 
--	paydb_andrew.`users_2_with_bad_unmerged`.`Session_First_Loan`,
	paydb.`credit_sessions`.`shop_id` AS shop_id, 
	/*
	case
		when paydb_andrew.`users_2_with_bad_unmerged`.`quality`> 0 or paydb_andrew.`users_2_with_bad_unmerged`.`Bin_First_Default_45` = 0 then 1
		else -1
	end as qual,
	*/
	SUM(paydb.`credit_sessions`.`amount`) AS sum_amount,
	MONTH(FROM_UNIXTIME(Date_First_Loan_U)) AS month_credit
	-- scoring_log.`flag_blocked` as scoring_flag,
	-- ,max(paydb.`client_data_model_log`.`flag_reject`) as merge_flag
	-- merge_log.merge_flag
FROM paydb_andrew.`users_2_with_bad_unmerged`
	INNER JOIN paydb.`credit_sessions`
		ON paydb.`credit_sessions`.id = paydb_andrew.`users_2_with_bad_unmerged`.`Session_First_Loan`
	LEFT JOIN (SELECT flag_blocked, session_id FROM paydb_andrew.`scoring_model_log` WHERE paydb_andrew.`scoring_model_log`.`version` = '2.02') 
	 AS scoring_log
		ON scoring_log.`session_id` = paydb_andrew.`users_2_with_bad_unmerged`.`Session_First_Loan`
	LEFT JOIN (SELECT MAX(paydb.`client_data_model_log`.`flag_reject`) AS merge_flag, paydb.`client_data_model_log`.Session_id_1 FROM paydb.`client_data_model_log` GROUP BY Session_id_1)
	 AS merge_log
		ON merge_log.Session_id_1 = paydb_andrew.`users_2_with_bad_unmerged`.`Session_First_Loan`
WHERE 
	MONTH(FROM_UNIXTIME(Date_First_Loan_U))>=4 AND
	MONTH(FROM_UNIXTIME(Date_First_Loan_U))<=5 AND
	YEAR(FROM_UNIXTIME(Date_First_Loan_U))=2015
	AND (scoring_log.`flag_blocked` = 0 OR scoring_log.`flag_blocked` IS NULL) -- includes scoring blocked if disabled
	AND (merge_log.merge_flag = 0 OR merge_log.merge_flag IS NULL) -- includes merge blocked if disabled
	AND (paydb_andrew.`users_2_with_bad_unmerged`.`quality`< 0 OR paydb_andrew.`users_2_with_bad_unmerged`.`Bin_First_Default_45` = 1) -- includes users in default

GROUP BY MONTH(FROM_UNIXTIME(Date_First_Loan_U))  
 ,paydb.`credit_sessions`.`shop_id`
ORDER BY MONTH(FROM_UNIXTIME(Date_First_Loan_U)), paydb.`credit_sessions`.`shop_id`, paydb_andrew.`users_2_with_bad_unmerged`.`Session_First_Loan` 
	