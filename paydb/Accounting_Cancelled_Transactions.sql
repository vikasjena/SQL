SELECT
	shops.id AS Id,
	YEAR(FROM_UNIXTIME(credits.date_create)) AS "Год",
	MONTH (FROM_UNIXTIME(max(credits.date_create))) AS "Месяц",
	shops.short_name AS "Сокращение",
	shops.full_name AS "Юридическое Наименование",
	FORMAT(sum(credits.amount_original),2) AS "Оборот",
	FORMAT(count(credits.id),0) AS "Кол-во",
	CONCAT((shop_commission),'%') AS "Комиссия",
	(FORMAT(sum(credits.amount_original) * (100 - shops.shop_commission) / 100,2)) AS "К Оплате"
FROM
	credits
LEFT OUTER JOIN shops ON credits.shop_id = shops.id
WHERE
	shops.id NOT IN (10002, 10003)   /* ИСКЛЮЧАЕМ ТЕСТОВЫЙ МАГАЗИН */
	AND shops.test_mode = 0
	AND credits.canceled = 1
		/* ЗАДАЕМ МЕСЯЦ ЗА КОТОРЫЙ ХОТИМ ДАННЫЕ */
  AND YEAR(FROM_UNIXTIME(credits.date_create)) = 2014
	-- AND MONTH(FROM_UNIXTIME(credits.date_create)) = 04
GROUP BY
	MONTH (FROM_UNIXTIME(credits.date_create)),
	YEAR(FROM_UNIXTIME(credits.date_create)),
	credits.shop_id 
	-- credits.shop_id BETWEEN '10005' AND '10005'
ORDER BY
	YEAR (FROM_UNIXTIME(credits.date_create)) ASC,
	MONTH (FROM_UNIXTIME(credits.date_create)) ASC,
	sum(credits.amount_original) DESC