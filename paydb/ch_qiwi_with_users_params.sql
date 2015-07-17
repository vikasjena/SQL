select 
ch_qiwi_w_user_id.*,
Vw_Users_Loans.Union_Id as un_id,
Vw_Users_Loans.Amount_Original_Sum as ao_sum,
Vw_Users_Loans.Amount_Original_Paid_Sum as ao_p_sum,
Vw_Users_Loans.Quantity_Payments as p_q,
Vw_Users_Loans.sns_id_passed as sns_id,
Vw_Users_Loans.sns_profile_id_passed as sns_profile_id,
Vw_Users_Loans.Shop_Id as shop_id,
Vw_Users_Loans.Cohort as cohort,  
Vw_Users_Loans.Is_BLocked as blocked,  
Vw_Users_Loans.Count_Credits as c_c,  
Vw_Users_Loans.Count_Shops_Credits as cs_c,  
Vw_Users_Loans.Days_To_Pay_Avg as adtp,  
Vw_Users_Loans.Bin_Moving_Default_45 as b_m_d  


from ch_qiwi_w_user_id
LEFT OUTER JOIN Vw_Users_Loans on ch_qiwi_w_user_id.id = Vw_Users_Loans.User_Id
where 
(m_1 is not null or m_2 is not null or m_3 is not null or m_4 is not null)
and Vw_Users_Loans.Amount_Original_Sum is not null 
and Vw_Users_Loans.Cohort not in (20146, 20147)