DROP TABLE IF EXISTS table_2_7;
CREATE TEMPORARY TABLE table_2_7
(
SELECT
  credit_id,
  SUM(amount) AS operations_accrued
 FROM
  credit_operations
 WHERE
  type_id IN (2, 7, 6)
 GROUP BY
  credit_id
);

DROP TABLE IF EXISTS table_3_8;
CREATE TEMPORARY TABLE table_3_8
(
SELECT
  credit_id,
  SUM(amount) AS operations_amount_original_paid
 FROM
  credit_operations
 WHERE
  type_id IN (3, 8)
 GROUP BY
  credit_id
);

DROP TABLE IF EXISTS table_4_9;
CREATE TEMPORARY TABLE table_4_9

(
SELECT
  credit_id,
  SUM(amount) AS operations_amount_interest_paid
 FROM
  credit_operations
 WHERE
  type_id IN (4, 9)
 GROUP BY
  credit_id
);

DROP TABLE IF EXISTS armagedon;
CREATE TEMPORARY TABLE armagedon
(
SELECT
 credits.id,
 credits.user_id,
 credits.interest_accrued,
 credits.interest_paid,
 credits.amount_paid,
  (credits.interest_accrued - operations_accrued) AS interest_accrued_diff,
  (credits.interest_paid -  operations_amount_interest_paid) AS interest_paid_diff,
  (credits.amount_paid - operations_amount_original_paid) AS amount_paid_diff
FROM
 credits
LEFT JOIN table_2_7 ON table_2_7.credit_id = credits.id
LEFT JOIN table_3_8 ON table_3_8.credit_id = credits.id
LEFT JOIN table_4_9 ON table_4_9.credit_id = credits.id
GROUP BY credits.id
ORDER BY credits.id ASC
);

SELECT * FROM armagedon WHERE amount_paid_diff <> 0 OR  interest_paid_diff != 0 OR interest_accrued_diff != 0 ;

SELECT 
SUM(interest_accrued_diff),
SUM(interest_paid_diff),
SUM(amount_paid_diff)
FROM armagedon;



DROP TABLE IF EXISTS armagedon;
DROP TABLE IF EXISTS table_2_7;
DROP TABLE IF EXISTS table_3_8;
DROP TABLE IF EXISTS table_4_9;