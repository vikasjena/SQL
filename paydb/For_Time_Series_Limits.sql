SELECT
	YEAR(FROM_UNIXTIME(credits.date_create)) AS Year_,
	MONTH(FROM_UNIXTIME(credits.date_create)) AS Month_,
	shops.short_name AS Shop,
	users.phone AS Phone,
	credits.user_id AS UsrID,
	credits.sub_id AS SubID,

(SELECT Count_ FROM (
	select count(credits.id) as Count_,
	credits.user_id as Id_
	from credits
	group by credits.user_id
	) as Temp_Table
where credits.user_id = Id_) as Crd_Count,
	
(SELECT Count_ FROM (
	select count(DISTINCT credits.product_id) as Count_,
	credits.user_id as Id_
	from credits
	group by credits.user_id
	) as Temp_Table
where credits.user_id = Id_) as Lmts_Count,

CASE
WHEN MAX(products.amount_limit) IS NULL 
THEN 300
ELSE MAX(products.amount_limit)


END AS Max_Limit,
	SUM(amount_original),
	SUM(amount_remaining),
	SUM(amount_paid),
	DATEDIFF(NOW(), MAX(FROM_UNIXTIME(credits.date_create)) ) as Last_Buy_Days_Ago,
	unions.blocked AS Blocked

FROM
	credits
	LEFT OUTER JOIN Vw_Users_Loans on Vw_Users_Loans.User_Id = credits.user_id
	LEFT OUTER JOIN shops ON credits.shop_id = shops.id
	LEFT OUTER JOIN users ON credits.user_id = users.id
	-- LEFT OUTER JOIN products_users ON (products_users.user_id = credits.user_id)
	LEFT OUTER JOIN products ON (products.id = credits.product_id)
	LEFT OUTER JOIN union_users ON users.id = union_users.user_id
	LEFT OUTER JOIN unions ON union_users.union_id = unions.id
WHERE 
	Vw_Users_Loans.Shop_Id = '10001'
	AND	users.phone NOT IN (
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
-- 	AND Vw_Users_Loans.Bin_Moving_Default_45 = 0
-- 	AND unions.blocked = 0
	-- AND MONTH(FROM_UNIXTIME(credits.date_create)) = '9'
GROUP BY
	users.phone,
	YEAR(FROM_UNIXTIME(credits.date_create)),
	MONTH(FROM_UNIXTIME(credits.date_create))
	
HAVING
	Crd_Count > 5
	AND Lmts_Count > 3

ORDER BY 	
	users.phone,
	YEAR(FROM_UNIXTIME(credits.date_create)),
	MONTH(FROM_UNIXTIME(credits.date_create))
	

