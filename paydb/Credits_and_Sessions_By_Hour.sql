select hour(FROM_UNIXTIME(credits.date_create)), count(credits.id) from credits 
-- where credits.shop_id = 10051 
group by hour(FROM_UNIXTIME(credits.date_create))
;
select FROM_UNIXTIME(credit_sessions.date_start), hour(FROM_UNIXTIME(credit_sessions.date_start)), count(credit_sessions.id) from credit_sessions 
where FROM_UNIXTIME(credit_sessions.date_start) > '2014-04-18 00:00:00'
AND FROM_UNIXTIME(credit_sessions.date_start) < '2014-04-18 23:59:59'
-- AND credit_sessions.shop_id = 10001
group by hour(FROM_UNIXTIME(credit_sessions.date_start))

