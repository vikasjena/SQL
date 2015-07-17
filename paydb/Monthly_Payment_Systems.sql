SELECT
 Year (FROM_UNIXTIME(bills.date_create)) AS Year_,
 MONTH (FROM_UNIXTIME(bills.date_create)) AS Month_,
 count(bills.id),
 sum(bills.amount),
 payment_systems. NAME,
 CONCAT(
  FORMAT(
   (
    sum(bills.amount) / (
     
     
     SELECT SUM_BY_MONTH FROM
      (
       SELECT
        SUM(bills.amount) as SUM_BY_MONTH,
       MONTH (
         FROM_UNIXTIME(bills.date_create)
        ) as _MONTH
       FROM
        bills
       INNER JOIN payment_systems ON bills.payment_system_id = payment_systems.id
       WHERE
        bills.date_create > 1382299200
       AND bills.`status` = 0
       GROUP BY
       MONTH (
         FROM_UNIXTIME(bills.date_create)
        )
      ) as temp_table
/*
Условие к первому вложенному селекту, чтобы выбирал из второго селекта только те суммы, которые относятся к месяцу, выбираемому в самом первом (верхнем) селекте.
*/
      WHERE _MONTH = MONTH (
       FROM_UNIXTIME(bills.date_create)
      )
    )
   ) * 100,
   2
  ),
  '%'
 ) AS In_Percent,
 bills.payment_system_id AS 'Id' -- bills.payment_system_method
FROM
 bills
INNER JOIN payment_systems ON bills.payment_system_id = payment_systems.id
WHERE
 bills.`status` = 0
AND bills.date_create > 1382299200

GROUP BY
 payment_systems. NAME,
 /* bills.payment_system_method */
 Year (FROM_UNIXTIME(bills.date_create)),
 MONTH (FROM_UNIXTIME(bills.date_create))
ORDER BY
 Year (FROM_UNIXTIME(bills.date_create)) ASC,
 MONTH (FROM_UNIXTIME(bills.date_create)) ASC,
 count(bills.id) DESC
