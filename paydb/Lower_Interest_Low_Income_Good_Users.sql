SELECT 
	Vw_Users_Loans.User_Id,
	Vw_Users_Loans.Phone,
	Vw_Users_Loans.Amount_Original_Paid_Sum,
	Vw_Users_Loans.Interest_Paid_Sum

FROM 
	Vw_Users_Loans 
WHERE
	Vw_Users_Loans.Amount_Original_Paid_Sum > 20000
	AND Vw_Users_Loans.Interest_Paid_Sum < 1000
ORDER BY 
	Vw_Users_Loans.Amount_Original_Paid_Sum DESC
LIMIT	15