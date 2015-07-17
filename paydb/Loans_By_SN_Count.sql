select COUNT(Vw_Loans_Issued_two.Credit_Id)

from Vw_Loans_Issued_two
where Vw_Loans_Issued_two.Date_Create > '2013-10-17' and Vw_Loans_Issued_two.SNS_Id = 'FB'
;
select COUNT(Vw_Loans_Issued_two.Credit_Id)

from Vw_Loans_Issued_two
where Vw_Loans_Issued_two.Date_Create > '2013-10-17' and Vw_Loans_Issued_two.SNS_Id = 'OK'
;
select COUNT(Vw_Loans_Issued_two.Credit_Id)

from Vw_Loans_Issued_two
where Vw_Loans_Issued_two.Date_Create > '2013-10-17' and Vw_Loans_Issued_two.SNS_Id = 'VK'