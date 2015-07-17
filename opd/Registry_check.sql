SELECT 
register.id,
FROM_UNIXTIME(register.date_create) as date_ordered,
FROM_UNIXTIME(register.date_delivery) as date_delivery,
FROM_UNIXTIME(register_paid.date_paid) as date_paid,
register.shop_id,
register.order_id,
register.checkout_id,
register.checkout_order_id,
register.amount,
register.delivery_amount,
sum(register_details.amount * register_details.count) - register.amount as det_amount_ch,
register.amount + register.delivery_amount - register.amountNP as reg_amount_ch,
register.amountNP,
DATEDIFF(FROM_UNIXTIME(register.date_delivery), FROM_UNIXTIME(register.date_create)) as delivery_days,
delivery_services.`name`,
register.zip,
register.city,
register.street,
register.house,
register.flat


FROM 
	register
	INNER JOIN delivery_services on delivery_services.id = register.delivery_service_id
	LEFT JOIN register_details on register_details.checkout_order_id = register.checkout_order_id AND register_details.checkout_id = register.checkout_id
	LEFT JOIN register_paid on register_paid.checkout_order_id = register.checkout_order_id AND register_paid.checkout_id = register.checkout_id
GROUP BY
	register.checkout_order_id
ORDER BY
	register.date_delivery DESC