 DROP TABLE IF EXISTS paydb_andrew.users_2_with_bad_unmerged;
 CREATE TABLE IF NOT EXISTS paydb_andrew.users_2_with_bad_unmerged
 SELECT paydb.users.*,
				Vw_Users_Loans.Bin_First_Default_45,
				Vw_Users_Loans.Bin_First_Default_60,
				Vw_Users_Loans.Date_First_Loan_U,
				Vw_Users_Loans.Session_First_Loan,
				Vw_Users_Loans.Session_First_Confirmed_Loan,
				Vw_Users_Loans.Session_First_Full_Session,
				Vw_Users_Loans.Cohort,
				union_users.union_id,

				(select _COUNT FROM 
						(SELECT
							union_users.union_id as _ID,
							count(union_users.user_id) as _COUNT
							FROM paydb.union_users
							GROUP BY union_users.union_id
							) AS Temp_Table1
						WHERE _ID = paydb.union_users.union_id) as union_quantity_users,

				(select _SUM FROM 
						(SELECT
							cs.current_union_id as _ID,
							sum(COALESCE(cs.bad_unmerged, 0)) as _SUM
							FROM paydb.credit_sessions as cs
							GROUP BY cs.current_union_id
							) AS Temp_Table1
						WHERE _ID = paydb.union_users.union_id) as bad_unmerged,


				(select _SUM FROM 
						(SELECT
							cs.id as _ID,
							COALESCE(cs.bad_unmerged, 0) as _SUM
							FROM paydb.credit_sessions as cs
							) AS Temp_Table1
						WHERE _ID = Vw_Users_Loans.Session_First_Loan) as bad_unmerged_first_sess


 FROM paydb.users
			INNER JOIN paydb.Vw_Users_Loans on paydb.users.id = Vw_Users_Loans.User_Id
			INNER JOIN paydb.union_users on paydb.users.id = paydb.union_users.user_id
			
-- WHERE Vw_Users_Loans.Date_First_Loan_U > 1391299200