SET @DAY_1 = 1;
SET @DAY_2 = 20;
SET @DAYS_TO_PAY = 25;
SET @LOAN_NUM_MIN = 0;
SET @LOAN_NUM_MAX = 999;
select 
-- Vw_Loans_Issued_two.Shop_Id,
MONTH(Vw_Loans_Issued_two.Date_Create) as _MONTH,
max(Date_Payment_Last) as date_payment_max,
SUM(Vw_Loans_Issued_two.Amount_Original) as amount_original,
SUM(Vw_Loans_Issued_two.Amount_Original_Paid) as Amount_Original_Paid_Sum,

(SELECT SUM(Vw_Loans_Issued_two.Amount_Original_Paid) 
	FROM Vw_Loans_Issued_two 
	WHERE 
		YEAR(Vw_Loans_Issued_two.Date_Create) = 2014 
		AND DAY(Vw_Loans_Issued_two.Date_Create) BETWEEN @DAY_1 AND @DAY_2
		AND MONTH(Vw_Loans_Issued_two.Date_Create) = _MONTH
		AND Vw_Loans_Issued_two.Days_To_Pay <= @DAYS_TO_PAY
		AND Vw_Loans_Issued_two.Loan_Number BETWEEN @LOAN_NUM_MIN AND @LOAN_NUM_MAX
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create)
) as 'Paid_Within_Days',

(1 - (SELECT SUM(Vw_Loans_Issued_two.Amount_Original_Paid) 
	FROM Vw_Loans_Issued_two 
	WHERE 
		YEAR(Vw_Loans_Issued_two.Date_Create) = 2014 
		AND DAY(Vw_Loans_Issued_two.Date_Create) BETWEEN @DAY_1 AND @DAY_2
		AND MONTH(Vw_Loans_Issued_two.Date_Create) = _MONTH
		AND Vw_Loans_Issued_two.Days_To_Pay <= @DAYS_TO_PAY
		AND Vw_Loans_Issued_two.Loan_Number BETWEEN @LOAN_NUM_MIN AND @LOAN_NUM_MAX
	GROUP BY
		MONTH(Vw_Loans_Issued_two.Date_Create)
) / SUM(Vw_Loans_Issued_two.Amount_Original)) as 'Paid_Within_Days_Def',
				
(1 - (SUM(Vw_Loans_Issued_two.Amount_Original_Paid) / SUM(Vw_Loans_Issued_two.Amount_Original))) as 'Default_Moving',
(SUM(Vw_Loans_Issued_two.Interest_Paid) / SUM(Vw_Loans_Issued_two.Amount_Original)) as 'Paid_%',
(SUM(Vw_Loans_Issued_two.Interest_Paid) / SUM(Vw_Loans_Issued_two.Amount_Original_Paid)) as 'paid_%_from_amPaid'

FROM Vw_Loans_Issued_two
WHERE  
	Vw_Loans_Issued_two.Loan_Number BETWEEN @LOAN_NUM_MIN AND @LOAN_NUM_MAX AND
	MONTH(Vw_Loans_Issued_two.Date_Create) BETWEEN 6 AND 12 	AND 
	YEAR(Vw_Loans_Issued_two.Date_Create) = 2014 	AND 
	DAY(Vw_Loans_Issued_two.Date_Create)  BETWEEN @DAY_1 AND @DAY_2
GROUP BY 
	-- Vw_Loans_Issued_two.Shop_Id,
	MONTH(Vw_Loans_Issued_two.Date_Create)