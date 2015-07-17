SELECT FROM_UNIXTIME(max(credits.date_create)) AS date_create, 
 count(credits.id) AS cn, 
users.phone,
 credits.*
 FROM credits INNER JOIN users ON credits.user_id = users.id
WHERE order_id != ""
GROUP BY order_id, shop_id
HAVING count(order_id) > 1
ORDER BY date_create DESC
;
SELECT FROM_UNIXTIME(credits.date_create), credits.order_id, credits.* from credits LEFT OUTER JOIN users on users.id = credits.user_id where users.phone =  79045509853 -- AND credits.date_create >= 1387097722 AND credits.date_create <= 1387097723
ORDER by credits.date_create DESC
;
SELECT 
	FROM_UNIXTIME(credit_sessions.date_start) AS date_start,
	FROM_UNIXTIME(credit_sessions.date_sns_redirect) AS date_sns_redirect,
	FROM_UNIXTIME(credit_sessions.date_auth) AS date_auth,
	FROM_UNIXTIME(credit_sessions.date_phone) AS date_phone,
	FROM_UNIXTIME(credit_sessions.date_terms) AS date_terms,
	FROM_UNIXTIME(credit_sessions.date_sms) AS date_sms,
	FROM_UNIXTIME(credit_sessions.date_finish) AS date_finish,
	FROM_UNIXTIME(credit_sessions.date_cession) AS date_cession,
	credit_sessions.order_id,
	credit_sessions.*
from credit_sessions where credit_sessions.phone = 79045509853 -- AND credit_sessions.date_start = 1387097668
ORDER BY credit_sessions.date_start DESC