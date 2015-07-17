DROP TABLE IF EXISTS paydb.user_relations_lite_directional;
CREATE TABLE IF NOT EXISTS paydb.user_relations_lite_directional(
id MEDIUMINT NOT NULL AUTO_INCREMENT, sns_id INT, sns_item_id0 BIGINT(20), sns_item_id1 BIGINT(20), PRIMARY KEY (id), UNIQUE KEY (sns_item_id0, sns_item_id1))
;
INSERT INTO paydb.user_relations_lite_directional (sns_id, sns_item_id0, sns_item_id1)
SELECT 
snsdb_new.user_relations_lite_users.sns_id,
snsdb_new.user_relations_lite_users.sns_item_id0,	
snsdb_new.user_relations_lite_users.sns_item_id1
FROM snsdb_new.user_relations_lite_users
ON DUPLICATE KEY UPDATE paydb.user_relations_lite_directional.sns_item_id0=paydb.user_relations_lite_directional.sns_item_id0,
 paydb.user_relations_lite_directional.sns_item_id1=paydb.user_relations_lite_directional.sns_item_id1
;
INSERT INTO paydb.user_relations_lite_directional (sns_id, sns_item_id0, sns_item_id1)
SELECT 
snsdb_new.user_relations_lite_users.sns_id,
snsdb_new.user_relations_lite_users.sns_item_id1,	
snsdb_new.user_relations_lite_users.sns_item_id0
FROM snsdb_new.user_relations_lite_users
ON DUPLICATE KEY UPDATE paydb.user_relations_lite_directional.sns_item_id0=paydb.user_relations_lite_directional.sns_item_id0,
 paydb.user_relations_lite_directional.sns_item_id1=paydb.user_relations_lite_directional.sns_item_id1