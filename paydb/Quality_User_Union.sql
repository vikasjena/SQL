SELECT 
   MAX(`credits`.`id`) AS `credit_id`
	,MAX(`credits`.`shop_id`) AS `shop_id`
	,MAX(`credits`.`user_id`) AS `user_id`
	,MAX(`union_users`.`union_id`) AS `union_id`
	,`unions`.`blocked` AS `blocked`
	,MAX(from_unixtime(`credits`.`date_create`)) AS `date_create`
	,MAX(`credits`.`date_create`) AS `date_create_u`
	,MAX(from_unixtime(`credits`.`date_end_grace`)) AS `date_end_grace`
	,MAX(from_unixtime(`credits`.`date_default`)) AS `date_default`
	,SUM(`credits`.`amount_original`) AS `amount_original`
	,SUM(`credits`.`amount_paid`) AS `amount_paid`
	,SUM(`credits`.`amount_remaining`) AS `amount_remaining`
	,(
		CASE 
			WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND MAX(from_unixtime(`credits`.`date_default`)) < now())
				THEN 'Default'
			WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (MAX(from_unixtime(`credits`.`date_end_grace`)) < now()) AND (MAX(from_unixtime(`credits`.`date_default`)) > now()))
				THEN 'Fee'
			WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (MAX(from_unixtime(`credits`.`date_end_grace`)) > now()))
				THEN 'Grace'
			WHEN (SUM(`credits`.`amount_remaining`) = 0)
				THEN 'Paid Back'
			END
		) AS `status`
	,(
		CASE 
			WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (MAX(from_unixtime(`credits`.`date_default`)) < now()))
				THEN 1
			WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (MAX(from_unixtime(`credits`.`date_end_grace`)) < now()) AND (MAX(from_unixtime(`credits`.`date_default`)) > now()))
				THEN 0
			WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (MAX(from_unixtime(`credits`.`date_end_grace`)) > now()))
				THEN 0
			WHEN (SUM(`credits`.`amount_remaining`) = 0)
				THEN 0
			END
		) AS `binary_default`

	,(
		CASE 
			WHEN ((SUM(`credits`.`amount_remaining`) = 0) AND (SUM(`credits`.`amount_paid`) > 10000))
				THEN 3
			WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (SUM(`credits`.`amount_paid`) > 10000) AND (  date_add(MAX(from_unixtime(`credits`.`date_default`)), INTERVAL 15 DAY)  > now()) )
				THEN 2.5
			WHEN ((SUM(`credits`.`amount_remaining`) = 0) AND (SUM(`credits`.`amount_paid`) BETWEEN 2000 AND 10000))
				THEN 2
			WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (SUM(`credits`.`amount_paid`) BETWEEN 2000 AND 10000) AND (date_add(MAX(from_unixtime(`credits`.`date_default`)), INTERVAL 15 DAY)  > now()))
				THEN 1.5
			WHEN ((SUM(`credits`.`amount_remaining`) = 0) AND (SUM(`credits`.`amount_paid`) BETWEEN 1 AND 2000))
				THEN 1
			WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (SUM(`credits`.`amount_paid`) BETWEEN 1 AND 2000) AND (date_add(MAX(from_unixtime(`credits`.`date_default`)), INTERVAL 15 DAY)  > now()))
				THEN 0.5
			WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (SUM(`credits`.`amount_paid`) = 0) AND (date_add(MAX(from_unixtime(`credits`.`date_default`)), INTERVAL 15 DAY)  > now()))
				THEN -0.5
			WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (SUM(`credits`.`amount_paid`) = 0) AND (date_add(MAX(from_unixtime(`credits`.`date_default`)), INTERVAL 15 DAY)  < now()))
				THEN -1
			WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (SUM(`credits`.`amount_paid`) BETWEEN 1 AND 2000) AND (date_add(MAX(from_unixtime(`credits`.`date_default`)), INTERVAL 15 DAY)  < now()))
				THEN -1.25
			WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (SUM(`credits`.`amount_paid`) BETWEEN 2000 AND 10000) AND (date_add(MAX(from_unixtime(`credits`.`date_default`)), INTERVAL 15 DAY)  < now()))
				THEN -1.5
			WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (SUM(`credits`.`amount_paid`) > 10000) AND (  date_add(MAX(from_unixtime(`credits`.`date_default`)), INTERVAL 15 DAY)  < now()) )
				THEN -2.5

			END
		) AS `quality`

FROM 	`credits` 
			 LEFT JOIN `union_users` ON (`credits`.`user_id` = `union_users`.`user_id`)
			 LEFT JOIN `unions` ON (`unions`.`id` = `union_users`.`union_id`)

where credits.canceled = 0
-- GROUP BY `credits`.`user_id`
GROUP BY `union_users`.`union_id`
ORDER BY quality DESC,
					MAX(`credits`.`date_create`) DESC

/*
;
CREATE TABLE paydb_andrew.unions_with_quality
SELECT 
	`union_users`.*
	,(
		CASE 
			WHEN ((SUM(`credits`.`amount_remaining`) = 0) AND (SUM(`credits`.`amount_paid`) > 10000))
				THEN 3
			WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (SUM(`credits`.`amount_paid`) > 10000) AND (  date_add(MAX(from_unixtime(`credits`.`date_default`)), INTERVAL 15 DAY)  > now()) )
				THEN 2.5
			WHEN ((SUM(`credits`.`amount_remaining`) = 0) AND (SUM(`credits`.`amount_paid`) BETWEEN 2000 AND 10000))
				THEN 2
			WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (SUM(`credits`.`amount_paid`) BETWEEN 2000 AND 10000) AND (date_add(MAX(from_unixtime(`credits`.`date_default`)), INTERVAL 15 DAY)  > now()))
				THEN 1.5
			WHEN ((SUM(`credits`.`amount_remaining`) = 0) AND (SUM(`credits`.`amount_paid`) BETWEEN 1 AND 2000))
				THEN 1
			WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (SUM(`credits`.`amount_paid`) BETWEEN 1 AND 2000) AND (date_add(MAX(from_unixtime(`credits`.`date_default`)), INTERVAL 15 DAY)  > now()))
				THEN 0.5
			WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (SUM(`credits`.`amount_paid`) = 0) AND (date_add(MAX(from_unixtime(`credits`.`date_default`)), INTERVAL 15 DAY)  > now()))
				THEN -0.5
			WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (SUM(`credits`.`amount_paid`) <= 2000) AND (date_add(MAX(from_unixtime(`credits`.`date_default`)), INTERVAL 15 DAY)  < now()))
				THEN -1
			WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (SUM(`credits`.`amount_paid`) BETWEEN 2000 AND 10000) AND (date_add(MAX(from_unixtime(`credits`.`date_default`)), INTERVAL 15 DAY)  < now()))
				THEN -1.5
			WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (SUM(`credits`.`amount_paid`) > 10000) AND (  date_add(MAX(from_unixtime(`credits`.`date_default`)), INTERVAL 15 DAY)  < now()) )
				THEN -2.5
			END
		) AS `quality`
FROM 	
	`credits` 
	LEFT JOIN `union_users` ON (`credits`.`user_id` = `union_users`.`user_id`)
where 
	credits.canceled = 0
	AND `union_users`.`union_id` IS NOT NULL
GROUP BY 
	`union_users`.`union_id`
ORDER BY 
	quality ASC

*/