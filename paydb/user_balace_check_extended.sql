SELECT 
 users.id,
 users.phone,
	credits.id as credit_id,
 (SELECT SUM(cr_op.amount) FROM credit_operations as cr_op INNER JOIN credits as cr ON cr.id = cr_op.credit_id WHERE cr_op.type_id = 1 AND cr.user_id = credits.user_id AND cr_op.canceled = 0) as r_am,
 (SELECT SUM(cr_op.amount) FROM credit_operations as cr_op INNER JOIN credits as cr ON cr.id = cr_op.credit_id WHERE cr_op.type_id = 2 AND cr.user_id = credits.user_id AND cr_op.canceled = 0) as r_int,
 (SELECT SUM(cr_op.amount) FROM credit_operations as cr_op INNER JOIN credits as cr ON cr.id = cr_op.credit_id WHERE cr_op.type_id = 6 AND cr.user_id = credits.user_id AND cr_op.canceled = 0) as r_sh,
 (SELECT SUM(cr_op.amount) FROM credit_operations as cr_op INNER JOIN credits as cr ON cr.id = cr_op.credit_id WHERE cr_op.type_id = 3 AND cr.user_id = credits.user_id AND cr_op.canceled = 0) as p_am,
 (SELECT SUM(cr_op.amount) FROM credit_operations as cr_op INNER JOIN credits as cr ON cr.id = cr_op.credit_id WHERE cr_op.type_id = 4 AND cr.user_id = credits.user_id AND cr_op.canceled = 0) as p_int,
	(SELECT SUM(cr_op.amount) FROM credit_operations as cr_op INNER JOIN credits as cr ON cr.id = cr_op.credit_id WHERE cr_op.type_id IN (7,8,9) AND cr.user_id = credits.user_id AND cr_op.canceled = 0) as cor,
 (SELECT ( COALESCE(p_am, 0) + COALESCE(p_int, 0)  - COALESCE(r_am, 0) - COALESCE(r_int, 0) - COALESCE(r_sh, 0) + COALESCE(cor, 0) ) ) as balance_oper,
 (SELECT (SUM(cr.amount_remaining) + SUM(cr.interest_remaining)) *-1 FROM credits as cr WHERE cr.user_id = credits.user_id) as balance_credits,
 (SELECT (SUM(cr.amount_paid) + SUM(cr.interest_paid)) FROM credits as cr WHERE cr.user_id = credits.user_id) as paid_credits,
 (SELECT SUM(bl.amount) FROM bills as bl WHERE bl.`status` = 0 AND users.id = bl.user_id) as paid_bills,

 (SELECT (SUM(cr.amount_original)) FROM credits as cr WHERE cr.user_id = credits.user_id) as original_credits,
 (SELECT (SUM(cr.interest_accrued)) FROM credits as cr WHERE cr.user_id = credits.user_id) as interest_credits,

 users.balance as balance_orig
FROM users
INNER JOIN credits ON credits.user_id = users.id
INNER JOIN credit_operations ON credit_operations.credit_id = credits.id
-- WHERE users.id = 2261
-- WHERE FROM_UNIXTIME(users.date_create)  >  '2014-01-01'
GROUP BY users.id
HAVING  
-- users.id = 306
-- balance_oper <> balance_orig AND balance_oper <> balace_credits AND balance_orig <> balace_credits
-- balance_oper <> balance_orig OR balance_credits <> balance_orig OR balance_credits <> balance_oper
-- paid_credits <> paid_bills
original_credits <> r_am OR interest_credits <> (COALESCE(r_int, 0) + COALESCE(r_sh,0))