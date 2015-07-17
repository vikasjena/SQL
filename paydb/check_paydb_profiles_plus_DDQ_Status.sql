
SELECT paydb.sns_profiles.*,
(SELECT _STATE FROM 
				(SELECT 
				snsdb_new.data_download_queue.state as _STATE,
				snsdb_new.data_download_queue.sns_item_id as _PROFILE_ID,
				snsdb_new.data_download_queue.sns_id as _SNS_ID
				FROM snsdb_new.data_download_queue
				WHERE snsdb_new.data_download_queue.id IN (SELECT _ID FROM (
																									 SELECT snsdb_new.data_download_queue.sns_item_id as _PROFILE_ID
																													,snsdb_new.data_download_queue.sns_id as _SNS_ID
																													,snsdb_new.data_download_queue.id as _ID			
																													,MIN(snsdb_new.data_download_queue.created) as _DATE	
																									 FROM snsdb_new.data_download_queue
																									 GROUP BY
																													snsdb_new.data_download_queue.sns_item_id,
																													snsdb_new.data_download_queue.sns_id,
																													snsdb_new.data_download_queue.id
																																		) AS TempTabl_1)
				GROUP BY
				snsdb_new.data_download_queue.sns_item_id,
				snsdb_new.data_download_queue.sns_id
				) as TempTbl
WHERE paydb.sns_profiles.sns_id = _SNS_ID AND paydb.sns_profiles.sns_profile_id = _PROFILE_ID) as state_in_DDQ
from paydb.sns_profiles
