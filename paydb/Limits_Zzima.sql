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
			/* TO INCREASSE FROM BASE (300) TO 600 */
CASE
WHEN
					SUM(amount_paid) >= 900 
	AND			SUM(amount_paid) < 1200 
	AND          	 (MAX(products.amount_limit) < 600  OR MAX(products.amount_limit) IS NULL)
THEN 600
				/* TO INCREASSE FROM 600 TO 900 */
WHEN 		
					SUM(amount_paid) >=1200 
	AND			SUM(amount_paid) < 1500 
	AND          	 (MAX(products.amount_limit) < 900)
 THEN 900
				/* TO INCREASSE FROM 900 TO 1200 */
 WHEN		
					SUM(amount_paid) >=1500 
	AND			SUM(amount_paid) < 1800 
	AND          	 (MAX(products.amount_limit) < 1200)
THEN 1200
				/* TO INCREASSE FROM 1200 TO 1500 */
WHEN		
					SUM(amount_paid) >=1800 
	AND			SUM(amount_paid) < 2100 
	AND          	 (MAX(products.amount_limit) < 1500)
THEn 1500
	/* TO INCREASSE FROM 1500 TO 1800 */
WHEN		
					SUM(amount_paid) >=2100 
	AND			SUM(amount_paid) < 2400 
	AND          	 (MAX(products.amount_limit) < 1800)
THEN 1800
	/* TO INCREASSE FROM 1800 TO 2100 */
WHEN 		
					SUM(amount_paid) >=2400 
	AND			SUM(amount_paid) < 2700 
	AND          	 (MAX(products.amount_limit) < 2100)
THEN 2100
	/* TO INCREASSE FROM 2100 TO 2400 */
WHEN		
					SUM(amount_paid) >=2400 
	 AND			SUM(amount_paid) < 3000 
	AND          	 (MAX(products.amount_limit) >= 1800 AND MAX(products.amount_limit) < 2400)	
THEN 2400
	/* TO INCREASSE FROM 2400 TO 3000 */
WHEN		
					SUM(amount_paid) >=4000 
 AND			SUM(amount_remaining) < 1000 
	AND          	 (MAX(products.amount_limit) >= 2400 AND MAX(products.amount_limit) < 3000)	
THEN 3000
	/* TO INCREASSE FROM 3000 TO 5000 */
WHEN
					SUM(amount_paid) >=12000 
	 AND			SUM(amount_remaining) < 2700 
	AND          	 (MAX(products.amount_limit) >= 3000 AND MAX(products.amount_limit) < 5000)	
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
	Vw_Users_Loans.Shop_Id = '10001'
	AND Vw_Users_Loans.Bin_Moving_Default_45 = 0
	AND unions.blocked = 0
	-- AND MONTH(FROM_UNIXTIME(credits.date_create)) = '9'
GROUP BY
	users.phone
HAVING 
New_Limit is not null
AND Last_Buy_Days_Ago < 90
AND Crd_Count > 3
-- New_Limit = 1800

ORDER BY 	
	New_Limit DESC,
	SUM(amount_paid) DESC
