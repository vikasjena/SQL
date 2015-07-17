DROP FUNCTION IF EXISTS user_quality;
CREATE FUNCTION user_quality (ID BIGINT, _DATE BIGINT) 
-- COMMENT 'Returns count of sessions that the user has started before making his first purchase including the session of the purchase'
RETURNS BIGINT DETERMINISTIC
READS SQL DATA	

BEGIN
DECLARE _QUALITY BIGINT;
SELECT 
     CASE
      WHEN ((SUM(`credits`.`amount_remaining`) = 0) AND (SUM(`credits`.`amount_paid`) > 10000))
       THEN 3
      WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (SUM(`credits`.`amount_paid`) > 10000) AND (  date_add(MAX(from_unixtime(`credits`.`date_default`)), INTERVAL 15 DAY)  > _DATE) )
       THEN 2.5
      WHEN ((SUM(`credits`.`amount_remaining`) = 0) AND (SUM(`credits`.`amount_paid`) BETWEEN 2000 AND 10000))
       THEN 2
      WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (SUM(`credits`.`amount_paid`) BETWEEN 2000 AND 10000) AND (date_add(MAX(from_unixtime(`credits`.`date_default`)), INTERVAL 15 DAY)  > _DATE))
       THEN 1.5
      WHEN ((SUM(`credits`.`amount_remaining`) = 0) AND (SUM(`credits`.`amount_paid`) BETWEEN 1 AND 2000))
       THEN 1
      WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (SUM(`credits`.`amount_paid`) BETWEEN 1 AND 2000) AND (date_add(MAX(from_unixtime(`credits`.`date_default`)), INTERVAL 15 DAY)  > _DATE))
       THEN 0.5
      WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (SUM(`credits`.`amount_paid`) = 0) AND (date_add(MAX(from_unixtime(`credits`.`date_default`)), INTERVAL 15 DAY)  > _DATE))
       THEN -0.5
      WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (SUM(`credits`.`amount_paid`) = 0) AND (date_add(MAX(from_unixtime(`credits`.`date_default`)), INTERVAL 15 DAY)  < _DATE))
       THEN -1
      WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (SUM(`credits`.`amount_paid`) BETWEEN 1 AND 2000) AND (date_add(MAX(from_unixtime(`credits`.`date_default`)), INTERVAL 15 DAY)  < _DATE))
       THEN -1.25
      WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (SUM(`credits`.`amount_paid`) BETWEEN 2000 AND 10000) AND (date_add(MAX(from_unixtime(`credits`.`date_default`)), INTERVAL 15 DAY)  < _DATE))
       THEN -1.5
      WHEN ((SUM(`credits`.`amount_remaining`) > 0) AND (SUM(`credits`.`amount_paid`) > 10000) AND (  date_add(MAX(from_unixtime(`credits`.`date_default`)), INTERVAL 15 DAY)  < _DATE) )
       THEN -2.5
      END
      INTO _QUALITY
    FROM `credits`
    LEFT JOIN `union_users` ON (`credits`.`user_id` = `union_users`.`user_id`)
    WHERE `credits`.`canceled` = 0 
					AND `union_users`.`user_id` = ID
					AND credits.date_create <= _DATE
    GROUP BY `union_users`.`user_id`
;
RETURN _QUALITY;
END;

select user_quality(306,  1387209249) as quality




