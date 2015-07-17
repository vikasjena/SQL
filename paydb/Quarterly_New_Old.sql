SELECT
	YEAR(FROM_UNIXTIME(max(credits.date_create))) AS 'Year',
	QUARTER (FROM_UNIXTIME(max(credits.date_create))) AS 'Quarter',
	credits.is_first_credit AS IsFirst,
	FORMAT(sum(credits.amount_original),2) AS amount_original,
	FORMAT(sum(credits.amount_paid),2) AS amount_paid,
	FORMAT(sum(credits.interest_accrued),2) AS interest_accrued,
	FORMAT(sum(credits.interest_paid),2) AS interest_paid,
	count(credits.id) AS credits_count,
	count(DISTINCT credits.user_id) AS users_count,
	sum(credits.is_first_credit) AS new_users,
	FORMAT(count(credits.id) / count(DISTINCT credits.user_id),2) AS 'Purch.Per.Usr',
	(FORMAT((sum(credits.amount_original) / count(DISTINCT credits.user_id)),0	)) AS ARPPU,
	FORMAT((sum(credits.amount_original) / count(credits.id)),0) AS AvgCrdAmnt,

	CONCAT(FORMAT(((sum(credits.amount_original) - sum(credits.amount_paid)) / sum(credits.amount_original))*100,2),'%') AS Moving_D_Rate,
	CONCAT(FORMAT(((sum(credits.amount_original) - sum(credits.amount_paid) - sum(credits.interest_paid)) / sum(credits.amount_original))*100,2),'%') AS Margin,
	CONCAT((FORMAT(avg(shop_commission),2)),'%') AS Comission,
	(FORMAT(sum(credits.amount_original) * (100 - shops.shop_commission) / 100,2	)) AS To_Pay
FROM
	credits
LEFT OUTER JOIN shops ON credits.shop_id = shops.id
GROUP BY
QUARTER (FROM_UNIXTIME(credits.date_create)),
Year (FROM_UNIXTIME(credits.date_create))
,credits.is_first_credit
ORDER BY
Year (FROM_UNIXTIME(credits.date_create)) DESC,
credits.is_first_credit ASC,
QUARTER (FROM_UNIXTIME(credits.date_create)) ASC