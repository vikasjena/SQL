DROP TEMPORARY TABLE IF EXISTS tbl_1;
CREATE TEMPORARY TABLE tbl_1
select 
id,
user_id,
FROM_UNIXTIME(cs.date_start),
shop_id,
avg(amount) as amount,
result
FROM
	credit_sessions as cs 
WHERE 
	cs.result = 'merge model blocked'
	and FROM_UNIXTIME(cs.date_start) > '2014-09-25'
GROUP BY
user_id
ORDER BY 
	shop_id,
	user_id,
	amount DESC
;
select * from tbl_1
;
SELECT
shop_id,
ROUND(sum(amount))
FROM tbl_1
GROUP BY shop_id