-- USERS WITH CREDITS COUNT (WITH PROFILES IN SNSDB)
select 
-- count(distinct paydb.sns_profiles.sns_profile_id) 
count(distinct credits.user_id) 
from sns_profiles 
INNER JOIN credits on credits.user_id = sns_profiles.user_id
;

-- THE SAME AS ABOVE BUT CROSS JOINED WITH SNSDB
select 
-- count(distinct paydb.sns_profiles.sns_profile_id) 
count(distinct paydb.sns_profiles.user_id)
from sns_profiles 
INNER JOIN credits on credits.user_id = sns_profiles.user_id
INNER JOIN snsdb.`profiles` on (snsdb.`profiles`.sns_item_id = paydb.sns_profiles.sns_profile_id)
;

