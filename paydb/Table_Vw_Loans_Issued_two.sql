DROP TABLE IF EXISTS Vw_Loans_Issued_two;
CREATE TABLE Vw_Loans_Issued_two
(PRIMARY KEY cred_id (Credit_Id), 
INDEX Credit_Id (Credit_Id),
INDEX Old_Id (Old_Id),
INDEX Shop_Id (Shop_Id),
INDEX Session_Id (Session_Id),
INDEX User_Id (User_Id),
INDEX Union_Id (Union_Id),
INDEX union_id_first (union_id_first),
INDEX User_Phone (User_Phone),
INDEX Date_Create (Date_Create))
SELECT 

	Vw_Loans_Issued_one.Credit_Id, 
	Vw_Loans_Issued_one.Old_Id, 
	Vw_Loans_Issued_one.Shop_Id,
	Vw_Loans_Issued_one.Session_Id, 
	Vw_Loans_Issued_one.SNS_Id, 
	Vw_Loans_Issued_one.User_Id, 
	Vw_Loans_Issued_one.Sub_Id, 
	Vw_Loans_Issued_one.Union_Id, -- This is current Union_Id the latest, that to which all other unions have merged
	
(select _ITEM from (SELECT
				Vw_Sessions_Data.current_union_id as _ID,
				Vw_Sessions_Data.union_id  as _ITEM
				from Vw_Sessions_Data 
				GROUP BY Vw_Sessions_Data.current_union_id
) as temptable1
			WHERE _ID = Vw_Loans_Issued_one.Union_Id) as union_id_first,

	Vw_Loans_Issued_one.Is_Blocked, 
	Vw_Loans_Issued_one.User_Phone, 
	Vw_Loans_Issued_one.limit_id, 
	Vw_Loans_Issued_one.limit_id_loan, 
	Vw_Loans_Issued_one.Product_Id, 
	Vw_Loans_Issued_one.Date_Create, 
	Vw_Loans_Issued_one.Date_Create_U, 
	LoanCount(Vw_Loans_Issued_one.User_Id, Vw_Loans_Issued_one.Date_Create_U) as Loan_Number,
CASE
WHEN LoanCount(Vw_Loans_Issued_one.User_Id, Vw_Loans_Issued_one.Date_Create_U) > 18 THEN 18
ELSE LoanCount(Vw_Loans_Issued_one.User_Id, Vw_Loans_Issued_one.Date_Create_U)
END AS Loan_Number18,
	Vw_Loans_Issued_one.Date_End_Grace, 
	Vw_Loans_Issued_one.Date_Default, 
	Vw_Loans_Issued_one.Amount_Original, 
	Vw_Loans_Issued_one.Amount_Remaining, 
	Vw_Loans_Issued_one.Interest_Accrued, 
	Vw_Loans_Issued_one.Interest_Remaining, 
	Vw_Loans_Issued_one.Is_First, 
	Vw_Loans_Issued_one.Date_Payment_First, 
	Vw_Loans_Issued_one.Date_Payment_Last, 
	Vw_Loans_Issued_one.Quantity_Payments, 
	Vw_Loans_Issued_one.Amount_Original_Paid, 
	Vw_Loans_Issued_one.Interest_Paid, 
	Vw_Loans_Issued_one.Date_PB_All, 
	Vw_Loans_Issued_one.Status as Status, 
	Vw_Loans_Issued_one.Binary_Default,

	CASE
	WHEN Vw_Loans_Issued_one.Date_PB_All IS NULL AND DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 45 DAY) < NOW() THEN  1
	WHEN Vw_Loans_Issued_one.Date_PB_All IS NULL AND DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 45 DAY) > NOW() THEN NULL
	WHEN Vw_Loans_Issued_one.Date_PB_All > DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 45 DAY) THEN 1
	WHEN Vw_Loans_Issued_one.Date_PB_All < DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 45 DAY) THEN 0
	ELSE 0
	END AS "Binary_Default_45",

	CASE
	WHEN Vw_Loans_Issued_one.Date_PB_All IS NULL AND DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 60 DAY) < NOW() THEN  1
	WHEN Vw_Loans_Issued_one.Date_PB_All IS NULL AND DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 60 DAY) > NOW() THEN NULL
	WHEN Vw_Loans_Issued_one.Date_PB_All > DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 60 DAY) THEN 1
	WHEN Vw_Loans_Issued_one.Date_PB_All < DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 60 DAY) THEN 0
	ELSE 0
	END AS "Binary_Default_60",

	CASE
	WHEN Vw_Loans_Issued_one.Date_PB_All IS NULL AND DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 90 DAY) < NOW() THEN  1
	WHEN Vw_Loans_Issued_one.Date_PB_All IS NULL AND DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 90 DAY) > NOW() THEN NULL
	WHEN Vw_Loans_Issued_one.Date_PB_All > DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 90 DAY) THEN 1
	WHEN Vw_Loans_Issued_one.Date_PB_All < DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 90 DAY) THEN 0
	ELSE 0
	END AS "Binary_Default_90",

(SELECT PS_NAME FROM	
		(SELECT 
			min(credit_operations.id),
			credit_operations.credit_id as _ID,
			bills.payment_system_method_id as _PS_ID,
			payment_system_methods.`name` as PS_NAME
		FROM 
			credit_operations 
			INNER JOIN bills on bills.id = credit_operations.bill_id
			INNER JOIN payment_system_methods on bills.payment_system_method_id = payment_system_methods.id
		WHERE bills.`status` = 0
					AND credit_operations.type_id = 3
		GROUP BY 
					credit_operations.credit_id) as temp_tbl
		WHERE Vw_Loans_Issued_one.Credit_Id = _ID) as Paid_With,



	Vw_Loans_Issued_one.Amount_To_Pay, 
	Vw_Loans_Issued_one.Shop_Comission,

-- SUM(Vw_Operations_With_Cost.Amount_Operation) AS Amount_Sum_Operations,
-- SUM(Vw_Operations_With_Cost.Operation_Cost) AS Operations_Cost,
-- SUM(Vw_Operations_With_Cost.Received_After_Cost) AS Amount_Received_Operations,

(select _ITEM from (SELECT
				Vw_Operations_With_Cost.Credit_Id as _ID,
				sum(Vw_Operations_With_Cost.Amount_Operation)  as _ITEM
				from Vw_Operations_With_Cost 
				GROUP BY Vw_Operations_With_Cost.Credit_Id 
) as temptable1
			WHERE _ID = Vw_Loans_Issued_one.Credit_Id) as Amount_Sum_Operations,

(select _ITEM from (SELECT
				Vw_Operations_With_Cost.Credit_Id as _ID,
				sum(Vw_Operations_With_Cost.Operation_Cost)  as _ITEM
				from Vw_Operations_With_Cost 
				GROUP BY Vw_Operations_With_Cost.Credit_Id 
) as temptable1
			WHERE _ID = Vw_Loans_Issued_one.Credit_Id) as Operations_Cost,

(select _ITEM from (SELECT
				Vw_Operations_With_Cost.Credit_Id as _ID,
				sum(Vw_Operations_With_Cost.Received_After_Cost)  as _ITEM
				from Vw_Operations_With_Cost 
				GROUP BY Vw_Operations_With_Cost.Credit_Id  
) as temptable1
			WHERE _ID = Vw_Loans_Issued_one.Credit_Id) as Amount_Received_Operations,


	CASE
	WHEN Vw_Loans_Issued_one.Date_PB_All < Vw_Loans_Issued_one.Date_End_Grace THEN  "Grace"
	WHEN Vw_Loans_Issued_one.Date_PB_All > Vw_Loans_Issued_one.Date_End_Grace AND Vw_Loans_Issued_one.Date_PB_All < Vw_Loans_Issued_one.Date_Default THEN  "Fee"
	WHEN Vw_Loans_Issued_one.Date_PB_All > Vw_Loans_Issued_one.Date_Default THEN "Default"
	WHEN Vw_Loans_Issued_one.Date_PB_All IS NULL THEN NULL
	END AS "Paid_During",

	DATEDIFF(Vw_Loans_Issued_one.Date_PB_All,Vw_Loans_Issued_one.Date_Create) AS Days_To_Pay,

	CASE
	WHEN Vw_Loans_Issued_one.Date_PB_All IS NULL AND DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 30 DAY) < NOW() THEN  "Default"
	WHEN Vw_Loans_Issued_one.Date_PB_All IS NULL AND DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 30 DAY) > NOW() THEN  "N/S"
	WHEN Vw_Loans_Issued_one.Date_PB_All > DATE_ADD(Date_Create,INTERVAL 30 DAY) THEN "Default"
	WHEN Vw_Loans_Issued_one.Date_PB_All < DATE_ADD(Date_Create,INTERVAL 30 DAY) THEN "Paid Back"
	END AS "Status 30",

	CASE
	WHEN Vw_Loans_Issued_one.Date_PB_All IS NULL AND DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 45 DAY) < NOW() THEN  "Default"
	WHEN Vw_Loans_Issued_one.Date_PB_All IS NULL AND DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 45 DAY) > NOW() THEN  "N/S"
	WHEN Vw_Loans_Issued_one.Date_PB_All > DATE_ADD(Date_Create,INTERVAL 45 DAY) THEN "Default"
	WHEN Vw_Loans_Issued_one.Date_PB_All < DATE_ADD(Date_Create,INTERVAL 45 DAY) THEN "Paid Back"
	END AS "Status 45",

	CASE
	WHEN Vw_Loans_Issued_one.Date_PB_All IS NULL AND DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 60 DAY) < NOW() THEN  "Default"
	WHEN Vw_Loans_Issued_one.Date_PB_All IS NULL AND DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 60 DAY) > NOW() THEN  "N/S"
	WHEN Vw_Loans_Issued_one.Date_PB_All > DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 60 DAY) THEN "Default"
	WHEN Vw_Loans_Issued_one.Date_PB_All < DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 60 DAY) THEN "Paid Back"
	END AS "Status 60",

	CASE
	WHEN Vw_Loans_Issued_one.Date_PB_All IS NULL AND DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 90 DAY) < NOW() THEN  "Default"
	WHEN Vw_Loans_Issued_one.Date_PB_All IS NULL AND DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 90 DAY) > NOW() THEN  "N/S"
	WHEN Vw_Loans_Issued_one.Date_PB_All > DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 90 DAY) THEN "Default"
	WHEN Vw_Loans_Issued_one.Date_PB_All < DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 90 DAY) THEN "Paid Back"
	END AS "Status 90",

	CASE
	WHEN Vw_Loans_Issued_one.Date_PB_All IS NULL AND DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 30 DAY) < NOW() AND 	Vw_Loans_Issued_one.Is_First = 1 THEN  1
	WHEN Vw_Loans_Issued_one.Date_PB_All IS NULL AND DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 30 DAY) > NOW() THEN NULL
	WHEN Vw_Loans_Issued_one.Date_PB_All > DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 30 DAY) AND 	Vw_Loans_Issued_one.Is_First = 1 THEN  1
	WHEN Vw_Loans_Issued_one.Date_PB_All < DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 30 DAY) AND 	Vw_Loans_Issued_one.Is_First = 1  THEN 0
	ELSE 0
	END AS "Bin_First_Default_30",

	CASE
	WHEN Vw_Loans_Issued_one.Date_PB_All IS NULL AND DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 45 DAY) < NOW() AND 	Vw_Loans_Issued_one.Is_First = 1 THEN  1
	WHEN Vw_Loans_Issued_one.Date_PB_All IS NULL AND DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 45 DAY) > NOW() THEN NULL
	WHEN Vw_Loans_Issued_one.Date_PB_All > DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 45 DAY) AND 	Vw_Loans_Issued_one.Is_First = 1 THEN  1
	WHEN Vw_Loans_Issued_one.Date_PB_All < DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 45 DAY) AND 	Vw_Loans_Issued_one.Is_First = 1  THEN 0
	ELSE 0
	END AS "Bin_First_Default_45",

	CASE
	WHEN Vw_Loans_Issued_one.Date_PB_All IS NULL AND DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 60 DAY) < NOW() AND 	Vw_Loans_Issued_one.Is_First = 1 THEN  1
	WHEN Vw_Loans_Issued_one.Date_PB_All IS NULL AND DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 60 DAY) > NOW() THEN NULL
	WHEN Vw_Loans_Issued_one.Date_PB_All > DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 60 DAY) AND 	Vw_Loans_Issued_one.Is_First = 1 THEN  1
	WHEN Vw_Loans_Issued_one.Date_PB_All < DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 60 DAY) AND 	Vw_Loans_Issued_one.Is_First = 1  THEN 0
	ELSE 0
	END AS "Bin_First_Default_60",

	CASE
	WHEN Vw_Loans_Issued_one.Date_PB_All IS NULL AND DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 90 DAY) < NOW() AND 	Vw_Loans_Issued_one.Is_First = 1 THEN  1
	WHEN Vw_Loans_Issued_one.Date_PB_All IS NULL AND DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 90 DAY) > NOW() THEN NULL
	WHEN Vw_Loans_Issued_one.Date_PB_All > DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 90 DAY) AND 	Vw_Loans_Issued_one.Is_First = 1 THEN  1
	WHEN Vw_Loans_Issued_one.Date_PB_All < DATE_ADD(Vw_Loans_Issued_one.Date_Create,INTERVAL 90 DAY) AND 	Vw_Loans_Issued_one.Is_First = 1  THEN 0
	ELSE 0
	END AS "Bin_First_Default_90"

FROM Vw_Loans_Issued_one
-- LEFT OUTER JOIN Vw_Operations_With_Cost ON Vw_Loans_Issued_one.Credit_Id = Vw_Operations_With_Cost.Credit_Id
-- where User_Phone = 79030189999
GROUP BY Vw_Loans_Issued_one.Credit_Id
-- having test <> 0
-- ORDER BY 
-- Date_Create DESC