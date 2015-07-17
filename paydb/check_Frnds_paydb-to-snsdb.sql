DROP TABLE IF EXISTS paydb.temp_frnd_count_difference_2
;
CREATE TABLE IF NOT EXISTS paydb.temp_frnd_count_difference_2 
(
sns_id INT,
sns_item_id BIGINT,
frnd_count_snsdb BIGINT,
PRIMARY KEY sns_id_and_profile (sns_id, sns_item_id), 
INDEX sns_item_id (sns_item_id),
INDEX sns_id (sns_id)
)
;
INSERT INTO temp_frnd_count_difference_2 (sns_id, sns_item_id, frnd_count_snsdb)
SELECT 
					snsdb_new.friends.sns_id as sns_id,
					snsdb_new.friends.sns_item_id as sns_item_id,
					count(snsdb_new.friends.friend_sns_item_id) as _COUNT
FROM 
					snsdb_new.friends
WHERE 		snsdb_new.friends.sns_item_id IN (SELECT paydb.sns_profiles.sns_profile_id FROM paydb.sns_profiles)		
GROUP BY 
					snsdb_new.friends.sns_item_id,
				  snsdb_new.friends.sns_id
