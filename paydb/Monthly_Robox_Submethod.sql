SELECT
 Year (FROM_UNIXTIME(bills.date_create)) AS Year_,
 MONTH (FROM_UNIXTIME(bills.date_create)) AS Month_,
 count(bills.id),
 sum(bills.amount),
 payment_systems. NAME,
CONCAT(FORMAT((sum(bills.amount) / (SELECT sum(bills.amount) FROM bills WHERE Year(FROM_UNIXTIME(bills.date_create)) = Year_ AND MONTH(FROM_UNIXTIME(bills.date_create)) = Month_ AND bills.payment_system_id = 1 AND bills.`status` = 0)* 100),2),'%') AS Percentage,
bills.payment_system_id AS 'Id',
bills.payment_system_method AS 'Method'
FROM
 bills
INNER JOIN payment_systems ON bills.payment_system_id = payment_systems.id
LEFT OUTER JOIN payment_system_methods on bills.payment_system_method_id = payment_system_methods.id


WHERE
	bills.`status` = 0
	AND bills.payment_system_id = 1

GROUP BY
 Year (FROM_UNIXTIME(bills.date_create)),
 MONTH(FROM_UNIXTIME(bills.date_create)),
	payment_systems. NAME,
	bills.payment_system_method
ORDER BY
 Year (FROM_UNIXTIME(bills.date_create)) Asc,
  MONTH(FROM_UNIXTIME(bills.date_create)),
	sum(bills.amount) DESC