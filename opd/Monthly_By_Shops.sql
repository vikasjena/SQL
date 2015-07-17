SELECT
	shops.id AS Id,
	YEAR(FROM_UNIXTIME(credits.date_create)) AS "Год",
	MONTH (FROM_UNIXTIME(max(credits.date_create))) AS "Месяц",
-- 	DAY (FROM_UNIXTIME(max(credits.date_create))) AS "День",
	shops.short_name AS "Сокращение",
-- 	shops.full_name AS "Юридическое Наименование",
	FORMAT(count(credits.amount_original),2) AS "Кол-во Заказов",
	FORMAT(sum(credits.amount_original),2) AS "Оборот",
	FORMAT((sum(credits.amount_original)) / (count(credits.amount_original)),0) AS "Ср. Заказ",
	FORMAT((count(credits.amount_original) / DAY (FROM_UNIXTIME(max(credits.date_create)))),0) AS "Заказов в день",
	FORMAT(sum(credits.amount_delivery),2) AS "В.т.ч. Доставка",
	CONCAT((products.commission),'%') AS "Комиссия %",
	(FORMAT((sum(credits.amount_original)) * (100 - products.commission) / 100,2)) AS "К Оплате",
	(FORMAT((sum(credits.amount_original) + sum(credits.amount_delivery)) * (products.commission) / 100,2)) AS "Комиссия"

-- CASE 
-- WHEN shops.id IN (10014, 10037, 10075) THEN "Понедельно" 
-- WHEN shops.id IN (10001, 10059, 10064) THEN "С другой компании"
-- WHEN shops.id IN (10058) THEN "Не оплачиваем"
-- WHEN shops.id IN (10056) THEN "Перезаключить договор на новые реквизиты"
-- END AS "Комментарий"

FROM
	opd.credits
LEFT OUTER JOIN shops ON credits.shop_id = shops.id
INNER JOIN products ON credits.product_id = products.id
WHERE
	shops.test_mode = 0
-- 	AND credits.canceled = 0
-- 	AND (MONTH (FROM_UNIXTIME(credits.date_create)) != MONTH (FROM_UNIXTIME(credits.date_cancel)) OR credits.canceled = 0)
		/* ЗАДАЕМ МЕСЯЦ ЗА КОТОРЫЙ ХОТИМ ДАННЫЕ */
--   AND YEAR(FROM_UNIXTIME(credits.date_create)) = 2015
--  	AND MONTH(FROM_UNIXTIME(credits.date_create)) = 02
GROUP BY
	MONTH (FROM_UNIXTIME(credits.date_create)),
	YEAR(FROM_UNIXTIME(credits.date_create)),
	-- DAY(FROM_UNIXTIME(credits.date_create)),
	credits.shop_id 
	-- credits.shop_id BETWEEN '10005' AND '10005'
ORDER BY
	YEAR (FROM_UNIXTIME(credits.date_create)) DESC,
	MONTH (FROM_UNIXTIME(credits.date_create)) DESC,
-- 	DAY (FROM_UNIXTIME(credits.date_create)) DESC,
	sum(credits.amount_original) DESC