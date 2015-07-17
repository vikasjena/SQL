SELECT `credits`.`id` AS `Credit_Id`
	,`credits`.`tmp_id` AS `Old_Id`
	,`credits`.`shop_id` AS `Shop_Id`
	,`credit_sessions`.`id` AS `Session_Id`
	,`credit_sessions`.`sns_id` AS `SNS_Id`
	,`credits`.`user_id` AS `User_Id`
	,`credits`.`sub_id` AS `Sub_Id`
	,`credits`.`order_id` AS `Order_Id`
	,`union_users`.`union_id` AS `Union_Id`
	,`unions`.`blocked` AS `Is_Blocked`
	,`users`.`phone` AS `User_Phone`
	,`users`.`limit_id` AS `limit_id`
	,`credits`.`limit_id` AS `limit_id_loan`
	,`products`.`name` AS `Product_Id`
	,from_unixtime(`credits`.`date_create`) AS `Date_Create`
	,`credits`.`date_create` AS `Date_Create_U`
	,from_unixtime(`credits`.`date_end_grace`) AS `Date_End_Grace`
	,from_unixtime(`credits`.`date_default`) AS `Date_Default`
	,`credits`.`amount_original` AS `Amount_Original`
	,`credits`.`amount_remaining` AS `Amount_Remaining`
	,`credits`.`interest_accrued` AS `Interest_Accrued`
	,`credits`.`interest_remaining` AS `Interest_Remaining`
	,`credits`.`is_first_credit` AS `Is_First`
	,from_unixtime((
			SELECT min(`credit_operations`.`date_create`)
			FROM `credit_operations`
			WHERE ((`credit_operations`.`credit_id` = `credits`.`id`) AND (`credit_operations`.`type_id` IN (3, 4)))
			)) AS `Date_Payment_First`
	,from_unixtime((
			SELECT max(`credit_operations`.`date_create`)
			FROM `credit_operations`
			WHERE ((`credit_operations`.`credit_id` = `credits`.`id`) AND (`credit_operations`.`type_id` IN (3, 4)))
			)) AS `Date_Payment_Last`
	,(
		SELECT count(`credit_operations`.`id`)
		FROM `credit_operations`
		WHERE ((`credit_operations`.`credit_id` = `credits`.`id`) AND (`credit_operations`.`type_id` = 3))
		) AS `Quantity_Payments`
	,(
		SELECT sum(`credit_operations`.`amount`)
		FROM `credit_operations`
		WHERE ((`credit_operations`.`credit_id` = `credits`.`id`) AND (`credit_operations`.`type_id` = 3))
		) AS `Amount_Original_Paid`
	,(
		SELECT sum(`credit_operations`.`amount`)
		FROM `credit_operations`
		WHERE ((`credit_operations`.`credit_id` = `credits`.`id`) AND (`credit_operations`.`type_id` = 4))
		) AS `Interest_Paid`
	,(
		CASE 
			WHEN (`credits`.`amount_remaining` = 0)
				THEN from_unixtime((
							SELECT max(`credit_operations`.`date_create`)
							FROM `credit_operations`
							WHERE ((`credit_operations`.`credit_id` = `credits`.`id`) AND (`credit_operations`.`type_id` IN (3, 4)))
							))
			ELSE NULL
			END
		) AS `Date_PB_All`
	,(
		CASE 
			WHEN ((`credits`.`amount_remaining` > 0) AND (from_unixtime(`credits`.`date_default`) < now()))
				THEN 'Default'
			WHEN ((`credits`.`amount_remaining` > 0) AND (from_unixtime(`credits`.`date_end_grace`) < now()) AND (from_unixtime(`credits`.`date_default`) > now()))
				THEN 'Fee'
			WHEN ((`credits`.`amount_remaining` > 0) AND (from_unixtime(`credits`.`date_end_grace`) > now()))
				THEN 'Grace'
			WHEN (`credits`.`amount_remaining` = 0)
				THEN 'Paid Back'
			END
		) AS `Status`
	,(
		CASE 
			WHEN ((`credits`.`amount_remaining` > 0) AND (from_unixtime(`credits`.`date_default`) < now()))
				THEN 1
			WHEN ((`credits`.`amount_remaining` > 0) AND (from_unixtime(`credits`.`date_end_grace`) < now()) AND (from_unixtime(`credits`.`date_default`) > now()))
				THEN 0
			WHEN ((`credits`.`amount_remaining` > 0) AND (from_unixtime(`credits`.`date_end_grace`) > now()))
				THEN 0
			WHEN (`credits`.`amount_remaining` = 0)
				THEN 0
			END
		) AS `Binary_Default`
	,`shops`.`shop_commission` AS `Shop_Comission`
	,(`credits`.`amount_original` * (1 - (`shops`.`shop_commission` / 100))) AS `Amount_To_Pay`
FROM (
	(
		(
			(
				(
					(
						(
							(
								`credits` INNER JOIN `credit_sessions` ON ((`credits`.`id` = `credit_sessions`.`credit_id`))
								) LEFT JOIN `union_users` ON ((`credits`.`user_id` = `union_users`.`user_id`))
							) LEFT JOIN `unions` ON ((`unions`.`id` = `union_users`.`union_id`))
						) LEFT JOIN `users` ON ((`credits`.`user_id` = `users`.`id`))
					) LEFT JOIN `products_users` ON ((`users`.`id` = `products_users`.`user_id`))
				) LEFT JOIN `products` ON ((`products_users`.`product_id` = `products`.`id`))
			) LEFT JOIN `credit_operations` ON ((`credits`.`id` = `credit_operations`.`credit_id`))
		) LEFT JOIN `shops` ON ((`shops`.`id` = `credits`.`shop_id`))
	)
where credits.canceled = 0
GROUP BY `credits`.`id`
ORDER BY `credits`.`date_create` DESC
