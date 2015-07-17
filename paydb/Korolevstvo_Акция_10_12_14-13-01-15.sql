select 

min(FROM_UNIXTIME(credits.date_create)) as min_date,
max(FROM_UNIXTIME(credits.date_create)) as max_date,
sum(credits.amount_original) as amount,
sum(credits.amount_original)*0.0001 as comission,
(sum(credits.amount_original)*0.1 - sum(credits.amount_original)*0.0001) as 'разница к зачету'


from credits
where 
credits.shop_id = 10051
AND FROM_UNIXTIME(credits.date_create) BETWEEN '2015-01-01' AND '2015-01-14'