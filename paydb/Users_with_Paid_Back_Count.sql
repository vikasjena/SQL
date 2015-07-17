
select 
Vw_Loans_Issued_two.User_Id as user_id, 
PayBacksCount(user_id) as Count_Paybacks,
sum(Vw_Loans_Issued_two.Amount_Original) as AO, 
sum(Vw_Loans_Issued_two.Amount_Remaining) as AR 
from Vw_Loans_Issued_two 
where Shop_Id = 10001 and Vw_Loans_Issued_two.Date_Create < '2013-12-29 00:00:00' 
group by User_Id
having PayBacksCount(user_id) >= 1
 ;
-- select PayBacksCount(557)