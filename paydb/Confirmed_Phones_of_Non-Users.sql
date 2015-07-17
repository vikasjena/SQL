select * from Vw_Sessions_Data 
where Vw_Sessions_Data.date_finish is not null 
and Vw_Sessions_Data.result != 'credit confirmed'
and is_new_user = 1