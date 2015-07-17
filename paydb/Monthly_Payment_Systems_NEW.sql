SELECT
  Year (FROM_UNIXTIME(bills.date_create)) AS Year_,
  MONTH (FROM_UNIXTIME(bills.date_create)) AS Month_,
  count(bills.id) as Count,
	bills.payment_system_method_id AS 'Id',
  payment_system_methods.`name` As 'NAME',
	CONCAT(FORMAT(
	(sum(bills.amount) / 
	(SELECT sum(bills.amount) 
		FROM bills 
		WHERE 
		Year(FROM_UNIXTIME(bills.date_create)) = Year_ 
		AND MONTH(FROM_UNIXTIME(bills.date_create)) = Month_ 
		AND bills.`status` = 0)* 100),2),'%') AS Percentage,
  sum(bills.amount) as Amount,
  FORMAT((bills.markup/100 * sum(bills.amount)),2) as Markup,
	FORMAT(sum(bills.amount)*(bills.commission/100),2) as comission
FROM
  bills
	LEFT OUTER JOIN payment_systems ON bills.payment_system_id = payment_systems.id
	LEFT OUTER JOIN payment_system_methods on bills.payment_system_method_id = payment_system_methods.id
WHERE
	bills.`status` = 0
GROUP BY
  Year (FROM_UNIXTIME(bills.date_create)),
  MONTH(FROM_UNIXTIME(bills.date_create)),
  payment_system_methods.`name`,
	bills.payment_system_method_id
ORDER BY
  Year (FROM_UNIXTIME(bills.date_create)) Asc,
  MONTH(FROM_UNIXTIME(bills.date_create)),
	sum(bills.amount) DESC