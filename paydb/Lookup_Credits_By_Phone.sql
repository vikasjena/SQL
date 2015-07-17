SELECT
	shops.short_name,
	credits.*

FROM
credits
LEFT JOIN users ON users.id = credits.user_id
LEFT OUTER JOIN shops on shops.id = credits.shop_id
WHERE
	users.phone = 79056350859
ORDER BY credits.date_create DESC