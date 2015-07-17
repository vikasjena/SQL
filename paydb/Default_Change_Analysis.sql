select 
-- Vw_Loans_Issued_two.Shop_Id,
MONTH(Vw_Loans_Issued_two.Date_Create),
SUM(Vw_Loans_Issued_two.Amount_Original) as amount_original,
SUM(Vw_Loans_Issued_two.Amount_Original_Paid) as Amount_Original_Paid_Sum,
(SUM(Vw_Loans_Issued_two.Amount_Original_Paid) / SUM(Vw_Loans_Issued_two.Amount_Original)) as 'paid_%_AO',
(SUM(Vw_Loans_Issued_two.Interest_Paid) / SUM(Vw_Loans_Issued_two.Amount_Original)) as 'paid_%',
(SUM(Vw_Loans_Issued_two.Interest_Paid) / SUM(Vw_Loans_Issued_two.Amount_Original_Paid)) as 'paid_%_from_amPaid'

FROM Vw_Loans_Issued_two
WHERE  
Vw_Loans_Issued_two.Loan_Number = 1 AND
MONTH(Vw_Loans_Issued_two.Date_Create) BETWEEN 6 AND 9 AND YEAR(Vw_Loans_Issued_two.Date_Create) = 2014 AND DAY(Vw_Loans_Issued_two.Date_Create)  BETWEEN 20 AND 30
AND (Vw_Loans_Issued_two.Days_To_Pay < 22 OR Vw_Loans_Issued_two.Days_To_Pay IS NULL)
AND Shop_Id NOT IN  (10047, 10031, 10041, 10058, 10085, 10002)

GROUP BY 
-- Vw_Loans_Issued_two.Shop_Id,
MONTH(Vw_Loans_Issued_two.Date_Create)
;

select 
-- Vw_Loans_Issued_two.Shop_Id,
MONTH(Vw_Loans_Issued_two.Date_Create),
SUM(Vw_Loans_Issued_two.Amount_Original) as amount_original,
SUM(Vw_Loans_Issued_two.Amount_Original_Paid) as Amount_Original_Paid_Sum,
(SUM(Vw_Loans_Issued_two.Amount_Original_Paid) / SUM(Vw_Loans_Issued_two.Amount_Original)) as 'paid_%_AO',
(SUM(Vw_Loans_Issued_two.Interest_Paid) / SUM(Vw_Loans_Issued_two.Amount_Original)) as 'paid_%',
(SUM(Vw_Loans_Issued_two.Interest_Paid) / SUM(Vw_Loans_Issued_two.Amount_Original_Paid)) as 'paid_%_from_amPaid'

FROM Vw_Loans_Issued_two
WHERE  
Vw_Loans_Issued_two.Loan_Number = 1 AND
MONTH(Vw_Loans_Issued_two.Date_Create) BETWEEN 6 AND 9 AND YEAR(Vw_Loans_Issued_two.Date_Create) = 2014 AND DAY(Vw_Loans_Issued_two.Date_Create)  BETWEEN 20 AND 30
-- AND (Vw_Loans_Issued_two.Days_To_Pay < 22 OR Vw_Loans_Issued_two.Days_To_Pay IS NULL)
AND Shop_Id NOT IN  (10047, 10031, 10041, 10058, 10085, 10002)

GROUP BY 
-- Vw_Loans_Issued_two.Shop_Id,
MONTH(Vw_Loans_Issued_two.Date_Create)