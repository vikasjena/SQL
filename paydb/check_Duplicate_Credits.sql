select count(*) as count_, paydb.credits.*  from paydb.credits GROUP BY paydb.credits.shop_id, paydb.credits.order_id having count_ > 1
;
SELECT * from paydb.credits where id in (22686, 22685)
;
SELECT * from paydb.credits where order_id in (32258)
;