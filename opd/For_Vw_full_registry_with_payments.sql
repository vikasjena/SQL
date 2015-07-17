SELECT
	shops.id AS Id,
  register.checkout_order_id,
	FROM_UNIXTIME(credits.date_create) AS "DateClaimPurchase",
	FROM_UNIXTIME(credits.date_purchase) AS "DatePurchase",
	FROM_UNIXTIME(credits.date_delivery) AS "DateDelivery",
	FROM_UNIXTIME(register_paid.date_paid) AS "DatePaid",
	DATEDIFF(FROM_UNIXTIME(register_paid.date_paid), FROM_UNIXTIME(credits.date_create)) as days_paid_checkout,
	DATEDIFF(FROM_UNIXTIME(register.date_delivery), FROM_UNIXTIME(register.date_create)) as days_delivery,
	CASE
		WHEN register_paid.date_paid IS NULL AND DATEDIFF(NOW(), FROM_UNIXTIME(credits.date_delivery)) > 12
		THEN DATEDIFF(NOW(), FROM_UNIXTIME(credits.date_delivery))
		ELSE NULL
	END AS days_unpaid_12_plus,

	delivery_services.`name` as delivery_partner,
	shops.short_name AS "Сокращение",
	shops.full_name AS "Юридическое Наименование",
	FORMAT((credits.amount_original),2) AS "Оборот",
	FORMAT((credits.amount_delivery),2) AS "В.т.ч. Доставка",
	FORMAT(credits.amount_original * (100 - products.commission)/100,2) AS "Paid to Shop",
	FORMAT((register_paid.amountNP),2) AS "Amount in PaidOutRegistry",
	FORMAT((register_paid.amountNP*(100 - credits.checkout_commission)/100),2) AS "Received less commission",
	CONCAT(products.commission, "%") AS "Комиссия Продукта",
  CONCAT(credits.checkout_commission, "%") AS "Комиссия Чекаута",
	FORMAT(credits.amount_original * (products.commission - credits.checkout_commission)/100,2) AS "Gross Profit"
FROM
	opd.credits
	INNER JOIN shops ON credits.shop_id = shops.id
	INNER JOIN products ON credits.product_id = products.id
	LEFT OUTER JOIN register_paid ON register_paid.credit_id = credits.id
	LEFT OUTER JOIN register ON register.credit_id = credits.id
	LEFT OUTER JOIN delivery_services ON delivery_services.id = register.delivery_service_id
WHERE
	shops.test_mode = 0
GROUP BY
	credits.id
ORDER BY
	YEAR (FROM_UNIXTIME(credits.date_create)) DESC,
	MONTH (FROM_UNIXTIME(credits.date_create)) DESC,
	DAY (FROM_UNIXTIME(credits.date_create)) DESC