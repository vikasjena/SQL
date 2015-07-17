SELECT
CONCAT(YEAR(Vw_Loans_Issued_two.Date_Create), "_", MONTH(Vw_Loans_Issued_two.Date_Create)) AS 'Year_Mo',
YEAR(Vw_Loans_Issued_two.Date_Create)as 'Year',
MONTH(Vw_Loans_Issued_two.Date_Create) AS 'Month',
credits.shop_id AS 'Id',
shops.short_name AS Shop,
credits.limit_id AS PrId,
limits.amount AS 'Limit',
-- products.name AS Product,
Sum(Vw_Loans_Issued_two.Amount_Remaining) / SUM(Vw_Loans_Issued_two.Amount_Original) AS Dynamic_Def,

   
    sum(credits.amount_original) / 

(
     SELECT SUM_BY_MONTH FROM
      (
       SELECT
        SUM(credits.amount_original) as SUM_BY_MONTH,
       MONTH (
         FROM_UNIXTIME(credits.date_create)
        ) as _MONTH,
				shops.short_name AS _NAME
       FROM
        credits
       LEFT OUTER JOIN shops ON credits.shop_id = shops.id
       -- WHERE
       GROUP BY
       MONTH (
         FROM_UNIXTIME(credits.date_create)
        ),
				shops.short_name
      ) as temp_table
/*
Условие к первому вложенному селекту, чтобы выбирал из второго селекта только те суммы, которые относятся к месяцу и магазину, выбираемому в самом первом (верхнем) селекте.
*/
      WHERE _MONTH = MONTH (
       FROM_UNIXTIME(credits.date_create) 
      ) AND _NAME = shops.short_name
    )
 AS 'Prd. In %',

SUM(Vw_Loans_Issued_two.Amount_Original) AS Am_Orig,
Sum(Vw_Loans_Issued_two.Amount_Remaining) AS Am_Rem,
-- SUM(Accr_Int) AS Acc_Int,
SUM(Vw_Loans_Issued_two.Amount_Original_Paid) AS Paid_Orig,
SUM(Vw_Loans_Issued_two.Interest_Paid) AS Paid_Int


FROM
	Vw_Loans_Issued_two
	LEFT OUTER JOIN credits ON Vw_Loans_Issued_two.Credit_Id = credits.id
	LEFT OUTER JOIN shops ON credits.shop_id = shops.id
	-- LEFT OUTER JOIN products ON credits.product_id = products.id
	LEFT OUTER JOIN limits ON credits.limit_id = limits.id

-- WHERE MONTH (CrdIssueDate) BETWEEN '1' AND '10'

GROUP BY
	YEAR(Vw_Loans_Issued_two.Date_Create),
	MONTH (Vw_Loans_Issued_two.Date_Create),
	credits.limit_id,
	credits.shop_id,
	shops.short_name

ORDER BY
	YEAR (Vw_Loans_Issued_two.Date_Create),
	MONTH (Vw_Loans_Issued_two.Date_Create),
	credits.shop_id ASC





