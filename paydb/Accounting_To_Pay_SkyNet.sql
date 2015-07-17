SELECT
	shops.id AS Id,
	YEAR(FROM_UNIXTIME(credits.date_create)) AS "Год",
	MONTH (FROM_UNIXTIME(min(credits.date_create))) AS "Месяц min",
	MONTH (FROM_UNIXTIME(max(credits.date_create))) AS "Месяц max",
	WEEK(FROM_UNIXTIME(max(credits.date_create)),3) AS "Неделя",
	FROM_UNIXTIME(max(credits.date_create)) AS "Дата_Макс",
	shops.short_name AS "Сокращение",
	shops.full_name AS "Юридическое Наименование",
	FORMAT(sum(credits.amount_original),2) AS "Оборот",
	CONCAT((shop_commission),'%') AS "Комиссия",
	(FORMAT(sum(credits.amount_original) * (100 - shops.shop_commission) / 100,2)) AS "К Оплате"
FROM
	credits
LEFT OUTER JOIN shops ON credits.shop_id = shops.id
WHERE
	shops.id IN (10014)   /* SKYNet */
	AND YEAR(FROM_UNIXTIME(credits.date_create)) IN (2014, 2015)
	-- AND MONTH(FROM_UNIXTIME(credits.date_create)) = 01
	AND credits.canceled = 0
  -- AND FROM_UNIXTIME(credits.date_create) > '2013-12-31 23:59:59' AND  FROM_UNIXTIME(credits.date_create) < '2014-01-28 00:00:00'
GROUP BY
	-- MONTH(FROM_UNIXTIME(credits.date_create)),
	YEAR(FROM_UNIXTIME(credits.date_create)),
	WEEK(FROM_UNIXTIME(credits.date_create),3),
	credits.shop_id 
ORDER BY
	YEAR (FROM_UNIXTIME(credits.date_create)) DESC,
	-- MONTH (FROM_UNIXTIME(credits.date_create)) ASC,
WEEK(FROM_UNIXTIME(max(credits.date_create)),3) DESC
-- 	sum(credits.amount_original) DESC
/*;
select week(FROM_UNIXTIME(credits.date_create),3) , sum(credits.amount_original) as Volume from credits 
where FROM_UNIXTIME(credits.date_create) > '2013-12-31 23:59:59' AND  FROM_UNIXTIME(credits.date_create) < '2014-01-20 00:00:00'
AND credits.shop_id = 10014
GROUP BY week(FROM_UNIXTIME(credits.date_create),3) ASC
*/