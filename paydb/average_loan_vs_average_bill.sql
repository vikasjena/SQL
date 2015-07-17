SELECT
-- l2.User_Id,
-- l2.Is_First,
l2.limit_id,
YEAR(l2.Date_Create) as Year_,
MONTH(l2.Date_Create) as Month_,
AVG(l2.Amount_Original) as avg_loan,
(SELECT _AVG_BILL FROM 
(SELECT 
avg(bills.amount) as _AVG_BILL,
YEAR(FROM_UNIXTIME(bills.date_create)) as _YEAR,
MONTH(FROM_UNIXTIME(bills.date_create)) as _MONTH
FROM bills
WHERE bills.`status` = 0
GROUP BY
YEAR(FROM_UNIXTIME(bills.date_create)),
MONTH(FROM_UNIXTIME(bills.date_create))) as Temp_Tbl
WHERE _YEAR = YEAR(l2.Date_Create) AND _MONTH = MONTH(l2.Date_Create)) as avg_bill
									
FROM Vw_Loans_Issued_two as l2
WHERE 
	YEAR(l2.Date_Create) = 2014 AND MONTH(l2.Date_Create) IN (6,7,8,9,10,11)
-- 	AND Shop_Id != 10001
GROUP BY 
-- l2.Is_First,
l2.limit_id,
YEAR(l2.Date_Create),
MONTH(l2.Date_Create)
