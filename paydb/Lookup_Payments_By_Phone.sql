SELECT
	FROM_UNIXTIME(credit_operations.date_create) AS Date_Create,
	bills.payment_system_id,
	bills.payment_system_method,
	bills.`status`,
	credit_operations.*
FROM
	credit_operations
LEFT JOIN credits ON credits.id = credit_operations.credit_id
LEFT JOIN users ON users.id = credits.user_id
LEFT JOIN bills ON bills.id = credit_operations.bill_id
WHERE
	credit_operations.type_id != 2 AND
	users.phone = 79062876057

ORDER BY credit_operations.date_create DESC