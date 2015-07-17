SELECT
	shops.id AS Id,
	YEAR(FROM_UNIXTIME(credits.date_create)) AS "Год",
	MONTH (FROM_UNIXTIME(max(credits.date_create))) AS "Месяц",
	shops.short_name AS "Сокращение",
	shops.full_name AS "Юридическое Наименование",
	FORMAT(sum(credits.amount_original),2) AS "Оборот",
	CONCAT((shop_commission),'%') AS "Комиссия",
	(FORMAT(sum(credits.amount_original) * (100 - shops.shop_commission) / 100,2)) AS "К Оплате",
CASE 
WHEN shops.id IN (10014, 10037, 10075, 10096, 10085) THEN "Понедельно" 
WHEN shops.id IN (10001, 10059, 10064) THEN "С другой компании"
WHEN shops.id IN (10058) THEN "Не оплачиваем"
WHEN shops.id IN (10056) THEN ""
END AS "Комментарий"

FROM
	credits
LEFT OUTER JOIN shops ON credits.shop_id = shops.id
WHERE
	shops.id NOT IN (10002, 10003) -- 10058, 10059)   /* ИСКЛЮЧАЕМ ТЕСТОВЫЙ МАГАЗИН И СкайНэт, которому платим каждую неделю*/
	AND shops.test_mode = 0
	AND credits.canceled = 0
		/* ЗАДАЕМ МЕСЯЦ ЗА КОТОРЫЙ ХОТИМ ДАННЫЕ */
  AND YEAR(FROM_UNIXTIME(credits.date_create)) = 2015
	AND MONTH(FROM_UNIXTIME(credits.date_create)) = 06
GROUP BY
	MONTH (FROM_UNIXTIME(credits.date_create)),
	YEAR(FROM_UNIXTIME(credits.date_create)),
	credits.shop_id 
	-- credits.shop_id BETWEEN '10005' AND '10005'
ORDER BY
	YEAR (FROM_UNIXTIME(credits.date_create)) ASC,
	MONTH (FROM_UNIXTIME(credits.date_create)) ASC,
	sum(credits.amount_original) DESC