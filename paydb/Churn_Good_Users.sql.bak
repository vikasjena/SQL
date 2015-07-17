SELECT
	-- MONTH(FROM_UNIXTIME(credits.date_create)) AS Month_,
	shops.short_name AS Shop,
	users.phone AS Phone,
	users.id AS UsrID,
	credits.sub_id AS SubID,
	MAX(products.amount_limit) AS Max_Limit,
	SUM(amount_original),
	SUM(amount_remaining),
	SUM(amount_paid),
	DATEDIFF(NOW(), MAX(FROM_UNIXTIME(credits.date_create)) ) as Last_Buy_Days_Ago,
	COUNT(DISTINCT credits.id) AS Crd_Count,
	unions.blocked AS Blocked,
	Vw_Users_Loans.Bin_Moving_Default_45 as 'Default'


FROM
	credits
	LEFT OUTER JOIN Vw_Users_Loans on Vw_Users_Loans.User_Id = credits.user_id
	LEFT OUTER JOIN shops ON credits.shop_id = shops.id
	LEFT OUTER JOIN users ON credits.user_id = users.id
	LEFT OUTER JOIN products_users ON (products_users.user_id = credits.user_id)
	LEFT OUTER JOIN products ON (products.id = products_users.product_id)
	LEFT OUTER JOIN union_users ON users.id = union_users.user_id
	LEFT OUTER JOIN unions ON union_users.union_id = unions.id
WHERE 
	Vw_Users_Loans.Shop_Id = '10001' AND 
	Vw_Users_Loans.Bin_Moving_Default_45 = 0 AND
	unions.blocked = 0
	AND users.phone NOT IN (
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
GROUP BY
	users.phone
HAVING 
Last_Buy_Days_Ago > 60
AND Last_Buy_Days_Ago < 120
AND SUM(amount_original) >= 50
AND COUNT(DISTINCT credits.id)  <= 2
AND ( MAX(products.amount_limit) < 600 OR MAX(products.amount_limit) IS NULL )
ORDER BY 	
	shops.short_name,
	COUNT(DISTINCT credits.id) DESC,
	SUM(amount_paid) DESC,
	Last_Buy_Days_Ago DESC
