SELECT 

/*
(SELECT 
		_AMOUNT
	FROM 
	(SELECT 
		Vw_Loans_Issued_two.Union_Id AS _AMOUNT,
		Vw_Loans_Issued_two.User_Id as _ID
	FROM Vw_Loans_Issued_two
	GROUP BY
		Vw_Loans_Issued_two.Union_Id) AS temp_table_1
	  WHERE _ID = users.id) AS Union_id_cred,
*/
(SELECT 
		_AMOUNT
	FROM 
	(SELECT 
		union_users.union_id AS _AMOUNT,
		union_users.user_id as _ID
	FROM union_users
) AS temp_table_1
	  WHERE _ID = users.id) AS Union_id_un_usr,

(SELECT 
		_AMOUNT
	FROM 
	(SELECT 
		sum(Vw_Loans_Issued_two.Amount_Original) AS _AMOUNT,
		Vw_Loans_Issued_two.Union_Id as _ID
	FROM Vw_Loans_Issued_two
	GROUP BY
		Vw_Loans_Issued_two.Union_Id) AS temp_table_1
	  WHERE _ID = 
									(SELECT 
											_AMOUNT
										FROM 
										(SELECT 
											union_users.union_id AS _AMOUNT,
											union_users.user_id as _ID
										FROM union_users
									) AS temp_table_1
											WHERE _ID = users.id)) 
AS Union_SUM,

sum(credits.amount_original),
FROM_UNIXTIME(users.date_create) as date_create,
users.* 
FROM users 
LEFT OUTER JOIN credits on (credits.user_id = users.id)
-- WHERE FROM_UNIXTIME(users.date_create) > "2013-11-01 00:00:00"
GROUP BY 
users.id
HAVING Union_SUM IS NOT NULL
AND Union_SUM > 1