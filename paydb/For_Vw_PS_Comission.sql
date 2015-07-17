SELECT
	`bills`.`id` AS `id`,
	`bills`.`payment_system_id` AS `payment_system_id`,
	`bills`.`payment_system_method` AS `payment_system_method`,
	`bills`.`payment_system_method_id` AS `payment_system_method_id`,
	`bills`.`payment_system_order_id` AS `payment_system_order_id`,
	`bills`.`amount` AS `amount`,
	`bills`.`status` AS `status`,
	`bills`.`date_create` AS `date_create`,
	`bills`.`date_last_update` AS `date_last_update`,
	`bills`.`user_id` AS `user_id`,
	`bills`.`commission` AS `commission`,
	(`bills`.`commission` / 100) AS `PS_Comission`,
	(
		COALESCE (`bills`.`markup`, 0) / 100
	) AS `Markup`,
	(
		`bills`.`amount` * (
			(
				`bills`.`commission` - COALESCE (`bills`.`markup`, 0)
			) / 100
		)
	) AS `Bill_Cost`
FROM
	`bills`
WHERE
	(`bills`.`status` = 0)