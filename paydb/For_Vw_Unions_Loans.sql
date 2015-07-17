SELECT 
-- Vw_Loans_Issued_two.Old_Id, 
-- Vw_Loans_Issued_two.Shop_Id,
-- 	Vw_Loans_Issued_two.Product_Id,
	Vw_Loans_Issued_two.User_Id AS User_Id, 
	Vw_Loans_Issued_two.Sub_Id AS Sub_Id, 
	Vw_Loans_Issued_two.Union_Id AS Union_Id, 
 	Vw_Loans_Issued_two.User_Phone AS Phone, 
	Vw_Loans_Issued_two.Is_Blocked AS Is_BLocked, 

	CASE 
	WHEN 	COUNT(Vw_Loans_Issued_two.Credit_Id) > 1 THEN 1
	WHEN 	COUNT(Vw_Loans_Issued_two.Credit_Id) = 1 THEN 0
	ELSE NULL END AS Is_Regular, 

	MIN(Vw_Loans_Issued_two.Session_Id) AS Session_First_Loan, 
	MIN(Vw_Loans_Issued_two.Date_Create) AS Date_First_Loan, 
	MIN(Vw_Loans_Issued_two.Date_Payment_First) AS Date_Payment_First, 
	MAX(Vw_Loans_Issued_two.Date_Payment_Last) AS Date_Payment_Last, 
	FORMAT(AVG(Vw_Loans_Issued_two.Days_To_Pay),1) AS Days_To_Pay_Avg,
/*
	(SELECT Date_
 	FROM (SELECT 
					Vw_Loans_Issued_two.Amount_Original AS Amount_Original_,
					MIN(Vw_Loans_Issued_two.Date_Create) AS Date_,
					Vw_Loans_Issued_two.User_Id AS User_Id_
				FROM Vw_Loans_Issued_two
				GROUP BY Vw_Loans_Issued_two.User_Id) 
	AS First_Loan 
	WHERE User_Id_ = 	Vw_Loans_Issued_two.User_Id)
	AS Date_First_Loan_2,
*/
/*
	(SELECT Amount_Original_
 	FROM (SELECT 
					Vw_Loans_Issued_two.Amount_Original AS Amount_Original_,
					MIN(Vw_Loans_Issued_two.Date_Create) AS Date_,
					Vw_Loans_Issued_two.User_Id AS User_Id_
				FROM Vw_Loans_Issued_two
				GROUP BY Vw_Loans_Issued_two.User_Id) 
	AS First_Loan 
	WHERE User_Id_ = 	Vw_Loans_Issued_two.User_Id)
	AS Amount_First_Loan,
*/
	COUNT(Vw_Loans_Issued_two.Credit_Id) AS Count_Credits, 
	COUNT(DISTINCT Vw_Loans_Issued_two.Shop_Id) AS Count_Shops_Credits, 
-- Vw_Loans_Issued_two.Date_End_Grace, 
-- Vw_Loans_Issued_two.Date_Default, 
-- 	Vw_Loans_Issued_two.Is_First, 
-- Vw_Loans_Issued_two.Date_PB_All, 
-- Vw_Loans_Issued_two.Status, 
	SUM(Vw_Loans_Issued_two.Amount_Original) AS Amount_Original_Sum, 
	SUM(Vw_Loans_Issued_two.Amount_Remaining) AS Amount_Remaining_Sum, 
	SUM(Vw_Loans_Issued_two.Interest_Accrued) AS Interest_Accrued_Sum,  
	SUM(Vw_Loans_Issued_two.Interest_Remaining) AS Interest_Remaining_Sum,  
	SUM(Vw_Loans_Issued_two.Quantity_Payments) AS Quantity_Payments,
	SUM(Vw_Loans_Issued_two.Amount_Original_Paid) AS Amount_Original_Paid_Sum, 
	SUM(Vw_Loans_Issued_two.Interest_Paid) AS Interest_Paid_Sum, 
	SUM(Vw_Loans_Issued_two.Amount_Sum_Operations) AS Amount_Operations_Sum,
	SUM(Vw_Loans_Issued_two.Operations_Cost) AS Operations_Cost_Sum,
	SUM(Vw_Loans_Issued_two.Amount_Received_Operations) AS Amount_Received_Operations_Sum,
	SUM(Vw_Loans_Issued_two.Amount_To_Pay) AS Amount_To_Pay_Sum, 	
	-- FORMAT(SUM(Vw_Operations_With_Cost_4.Payment_System_Comission)/COUNT(Vw_Operations_With_Cost_4.Bill_Id),2) AS Avg_PS_Comission,

	CASE
	WHEN SUM(Vw_Loans_Issued_two.Binary_Default) > 0 THEN 1
	ELSE 0
	END AS Bin_Moving_Default,
	SUM(Bin_First_Default_30) AS Bin_First_Default_30,
	SUM(Bin_First_Default_45) AS Bin_First_Default_45,
	SUM(Bin_First_Default_60) AS Bin_First_Default_60,
	SUM(Bin_First_Default_90) AS Bin_First_Default_90

FROM Vw_Loans_Issued_two
-- WHERE Shop_Id = 10009
GROUP BY Union_Id
-- ORDER BY 
-- Date_First_Loan DESC
-- Interest_Paid DESC