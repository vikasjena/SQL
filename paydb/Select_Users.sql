SELECT	`c`.`user_id`,
	`u`.`phone`,
	SUM(`c`.`amount_paid`) AS `paid`,
	`p`.`amount_limit`
FROM	`credits` `c`
	LEFT JOIN `products_users` `pu` ON (`pu`.`user_id` = `c`.`user_id`)
	LEFT JOIN `products` `p` ON (`p`.`id` = `pu`.`product_id`)
	LEFT JOIN `users` `u` ON (`u`.`id` = `c`.`user_id`)
WHERE	`c`.`user_id` NOT IN (SELECT `id` FROM `default_users`)
	AND `c`.`shop_id` = 10001
GROUP BY `c`.`user_id`
HAVING	`paid` >= 2700 -- AND `paid` < 2700
ORDER BY `p`.`amount_limit`
;
