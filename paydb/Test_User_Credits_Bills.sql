select * FROM users where id = 12631;

select FROM_UNIXTIME(date_create), credits.* from credits where user_id = 12631  ORDER BY date_create DESC; 

select FROM_UNIXTIME(date_create), FROM_UNIXTIME(date_last_update), bills.*  from bills where user_id = 12631  and status = 0 ORDER BY date_create DESC;

select FROM_UNIXTIME(date_create), user_operations.*, user_operation_types.`name` FROM user_operations JOIN user_operation_types on user_operations.type_id =  user_operation_types.id where user_operations.user_id = 12631 ORDER BY date_create DESC;

SELECT credit_operations.*, credits.amount_original, FROM_UNIXTIME(credit_operations.date_create),  FROM_UNIXTIME(credits.date_create) from credit_operations left join credits on credit_operations.credit_id = credits.id where credit_operations.credit_id in (16390,
16389,
16386,
16378,
15842,
15670
)