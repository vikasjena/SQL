SELECT
	shops.id AS Id,
	YEAR(FROM_UNIXTIME(credits.date_create)) AS "Год",
	MONTH (FROM_UNIXTIME(max(credits.date_create))) AS "Месяц",
	shops.short_name AS "Сокращение",
	shops.full_name AS "Юридическое Наименование",
	sum(credits.amount_original) AS "Оборот",
	shops.shop_commission AS "Комиссия",
	(sum(credits.amount_original) * (100 - shops.shop_commission) / 100) AS "К Оплате"
FROM
	credits
LEFT OUTER JOIN shops ON credits.shop_id = shops.id
WHERE shops.test_mode = 0
GROUP BY
	MONTH (FROM_UNIXTIME(credits.date_create)),
	YEAR(FROM_UNIXTIME(credits.date_create)),
	credits.shop_id 