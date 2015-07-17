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

CASE
WHEN		
	SUM(amount_paid) >=5000
	AND COUNT(DISTINCT credits.id) >= 6
	AND (MAX(products.amount_limit) IS NULL)
THEN 3000

				/* TO INCREASSE FROM 1000 TO 1500 */
WHEN		
	SUM(amount_paid) >=2000
	AND COUNT(DISTINCT credits.id) >= 3
	AND (	MAX(products.amount_limit) < 1500 OR 	MAX(products.amount_limit) IS NULL)
THEN 1500
				/* TO INCREASSE FROM 1500 TO 2000 */
WHEN		
	SUM(amount_paid) >=3000 
	AND SUM(amount_paid) < 6000
	AND COUNT(DISTINCT credits.id) > 4
	AND (	MAX(products.amount_limit) < 2000)
THEN 2000
				/* TO INCREASSE FROM 2000 TO 3000 */
WHEN
	SUM(amount_paid) >= 4000 
	AND (	MAX(products.amount_limit) < 3000)
	AND COUNT(DISTINCT credits.id) > 5
THEN 3000
				/* TO INCREASSE FROM 3000 TO 5000 */
WHEN
	SUM(amount_paid) >= 12000 
	AND (	MAX(products.amount_limit) < 5000)
	AND COUNT(DISTINCT credits.id) > 10
THEN 5000
END AS 'New_Limit'

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
	Vw_Users_Loans.Shop_Id IN (10051, 10052, 10042, 10058, 10047)

	AND Vw_Users_Loans.Bin_Moving_Default_45 = 0
	AND unions.blocked = 0
	-- AND MONTH(FROM_UNIXTIME(credits.date_create)) = '9'
GROUP BY
	users.phone
HAVING
New_Limit is not null
AND Last_Buy_Days_Ago < 90
AND Crd_Count > 3
			
ORDER BY 	
	Shop ASC,
	New_Limit DESC,
	SUM(amount_paid) DESC
