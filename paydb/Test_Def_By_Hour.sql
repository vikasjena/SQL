SELECT
HOUR(Vw_Loans_Issued_two.Date_Create) as 'Hour',
COUNT(Vw_Loans_Issued_two.Credit_Id) as Count, 
SUM(Vw_Loans_Issued_two.Binary_Default_45) as Defaulted,
(SUM(Vw_Loans_Issued_two.Binary_Default_45) / COUNT(Vw_Loans_Issued_two.Credit_Id)) as 'Def_%'

from	Vw_Loans_Issued_two 
WHERE Vw_Loans_Issued_two.Is_First = 1
GROUP BY HOUR(Vw_Loans_Issued_two.Date_Create)