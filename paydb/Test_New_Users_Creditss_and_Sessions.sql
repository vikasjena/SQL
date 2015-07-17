select 
year(FROM_UNIXTIME(date_start)), 
month(FROM_UNIXTIME(date_start)), 
count(DISTINCT user_id)  
from credit_sessions 
WHERE 
is_new_user = 1 
and FROM_UNIXTIME(date_start) > '2013-11-01 00:00:00' 
and credit_sessions.credit_id is not null 
and shop_id not in (10009, 10010) 
group by year(FROM_UNIXTIME(date_start)), month(FROM_UNIXTIME(date_start));

select 
year(FROM_UNIXTIME(date_create)), 
month(FROM_UNIXTIME(date_create)), 
count(DISTINCT id)  
from credits 
WHERE 
credits.is_first_credit = 1 
and FROM_UNIXTIME(date_create) > '2013-11-01 00:00:00' 
and shop_id not in (10009, 10010) 
group by year(FROM_UNIXTIME(date_create)), month(FROM_UNIXTIME(date_create));

