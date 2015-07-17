DROP TABLE IF EXISTS ch_users_scoring;
CREATE TABLE ch_users_scoring

(PRIMARY KEY User_Id (User_Id), 
INDEX User_Id (User_Id),
INDEX sns_profile_id_first_sess (sns_profile_id_first_sess),
INDEX sns_profile_id_passed (sns_profile_id_passed),
INDEX Union_Id (Union_Id),
INDEX Phone (Phone),
INDEX Cohort (Cohort),
INDEX sns_profile_id (sns_profile_id))

SELECT * FROM Vw_Users_Loans