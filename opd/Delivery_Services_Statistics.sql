SET @DATE = '2015-04-01'
;
SELECT 
	SUM(register.amount) AS sum_amount,
	SUM(register.delivery_amount) AS sum_amount_delivery,
	SUM(register.amountNP) AS sum_amount_NP,
	ROUND(avg(register.amount),2) AS avg_amount,
	ROUND(avg(register.delivery_amount),2) AS avg_amount_delivery,
	ROUND(avg(register.amountNP),2) AS avg_amount_NP,
	COUNT(register.id) AS orders_cnt,
	CONCAT(FORMAT((count(register.id) / (SELECT CNT FROM 
																			 (SELECT COUNT(register.id) AS CNT 
																				FROM register 
																				WHERE FROM_UNIXTIME(register.date_delivery) > @DATE) AS test_table))*100,2),"%") 
	AS orders_prcnt,
	ROUND(AVG(DATEDIFF(FROM_UNIXTIME(register.date_delivery), FROM_UNIXTIME(register.date_create))),1) AS avg_delivery_days,
	delivery_services.`name` AS delivery_service

FROM 
	register
	INNER JOIN delivery_services ON delivery_services.id = register.delivery_service_id
WHERE 
	FROM_UNIXTIME(register.date_delivery) > @DATE
GROUP BY
	delivery_services.`name`
ORDER BY
	orders_cnt DESC,
	register.date_delivery DESC