SELECT

YEAR(FROM_UNIXTIME(credit_operations.date_create)) AS Ye,
MONTH(FROM_UNIXTIME(credit_operations.date_create)) AS Mo,
count(credit_operations.id) AS 'Кол-во оплат',
CASE 
WHEN credit_operations.type_id = 3 THEN 'Оплата ОД'
WHEN credit_operations.type_id = 4 THEN 'Оплата %'
END AS 'Тип Операции',
sum(credit_operations.amount) AS "Сумма",
AVG(bills.commission) as 'Средняя Комиссия ПС',
sum(bills.commission/100 * credit_operations.amount) as "Комиссия в руб.",
sum(credit_operations.amount) - (sum(bills.commission/100 * credit_operations.amount)) as "Получено от ПС в руб."

FROM
credit_operations
LEFT JOIN bills on (bills.id = credit_operations.bill_id)
WHERE
credit_operations.type_id IN (3, 4)
GROUP BY 
YEAR(FROM_UNIXTIME(credit_operations.date_create)),
MONTH(FROM_UNIXTIME(credit_operations.date_create)),
credit_operations.type_id,
MONTH(FROM_UNIXTIME(credit_operations.date_create))
ORDER BY
Ye ASC,
Mo ASC