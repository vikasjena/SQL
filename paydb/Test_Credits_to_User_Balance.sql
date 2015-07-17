SELECT 
 credits.id,
 users.phone, 
 users.first_name, 
 users.last_name,
 SUM(credits.amount_original) as original,
 SUM(credits.amount_remaining) as remaining,
 SUM(credits.amount_paid) as paid,
 SUM(credits.interest_accrued) as int_accrued,
 SUM(credits.interest_remaining) as int_remaining,
 SUM(credits.interest_paid) as int_paid,
 SUM(credits.amount_original - credits.amount_paid + credits.interest_accrued - credits.interest_paid) as balance1,
 users.balance as usr_balance,
 SUM(credits.amount_original - credits.amount_paid + credits.interest_accrued - credits.interest_paid) + users.balance as diff
FROM credits INNER JOIN users ON credits.user_id = users.id
WHERE credits.canceled = 0
GROUP BY 
 users.phone, 
 users.first_name, 
 users.last_name
HAVING 
 balance1 <> usr_balance * -1 
-- AND SUM(credits.amount_original - credits.amount_paid + credits.interest_accrued - credits.interest_paid) > 0