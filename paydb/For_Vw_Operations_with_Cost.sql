SELECT
	`credit_operations`.`id` AS `Credit_Operations_Id`,
	`credit_operations`.`credit_id` AS `Credit_Id`,
	`Vw_PS_Comission`.`status` AS `Bill_Status`,
	from_unixtime(
		`credit_operations`.`date_create`
	) AS `Date_Create_Operation`,
	from_unixtime(
		`Vw_PS_Comission`.`date_create`
	) AS `Date_Create_Bill`,
	`credit_operations`.`type_id` AS `Type_Id_Operation`,
	`credit_operations`.`bill_id` AS `Bill_Id`,
	`Vw_PS_Comission`.`payment_system_id` AS `Payment_System_Id`,
	`credit_operations`.`amount` AS `Amount_Operation`,
	`Vw_PS_Comission`.`PS_Comission` AS `Payment_System_Comission`,
	(
		CASE
		WHEN (
			`credit_operations`.`bill_id` IS NOT NULL
		) THEN
			(
				`credit_operations`.`amount` * (
					`Vw_PS_Comission`.`PS_Comission` - `Vw_PS_Comission`.`Markup`
				)
			)
		ELSE
			(
				`credit_operations`.`amount` * 0.0425
			)
		END
	) AS `Operation_Cost`,
	(
		CASE
		WHEN (
			`credit_operations`.`bill_id` IS NOT NULL
		) THEN
			(
				`credit_operations`.`amount` - (
					`credit_operations`.`amount` * `Vw_PS_Comission`.`PS_Comission`
				)
			)
		ELSE
			(
				`credit_operations`.`amount` - (
					`credit_operations`.`amount` * 0.0425
				)
			)
		END
	) AS `Received_After_Cost`
FROM
	(
		`credit_operations`
		LEFT JOIN `Vw_PS_Comission` ON (
			(
				`credit_operations`.`bill_id` = `Vw_PS_Comission`.`id`
			)
		)
	)
WHERE
	(
		`credit_operations`.`type_id` IN (3, 4)
	)