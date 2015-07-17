SELECT 
	data_download_queue.priority,
	data_download_queue.local_status,
	data_download_queue.sns_id,
	COUNT(DISTINCT data_download_queue.sns_item_id) AS count,

	(SELECT cnt FROM (
		SELECT 
			count(id) as cnt,
			data_download_queue.priority as prt,
			data_download_queue.local_status as st,
			data_download_queue.sns_id as snid
		FROM data_download_queue 
		WHERE (data_download_queue.parse_profile = 0 or data_download_queue.parse_profile IS NULL)
-- 					AND data_download_queue.local_status = 'complete'
		GROUP BY 
			data_download_queue.priority,
			data_download_queue.local_status,
			data_download_queue.sns_id 
		) as tmp_tbl
		WHERE 	
	data_download_queue.priority = prt AND data_download_queue.local_status = st AND data_download_queue.sns_id = snid
) as 'profile_err',

	(SELECT cnt FROM (
		SELECT 
			count(id) as cnt,
			data_download_queue.priority as prt,
			data_download_queue.local_status as st,
			data_download_queue.sns_id as snid
		FROM data_download_queue 
		WHERE (data_download_queue.parse_wall = 0 or data_download_queue.parse_wall IS NULL) 
-- 					AND data_download_queue.local_status = 'complete'
		GROUP BY 
			data_download_queue.priority,
			data_download_queue.local_status,
			data_download_queue.sns_id 
		) as tmp_tbl
		WHERE 	
	data_download_queue.priority = prt AND data_download_queue.local_status = st AND data_download_queue.sns_id = snid
) as 'wall_err',

	(SELECT cnt FROM (
		SELECT 
			count(id) as cnt,
			data_download_queue.priority as prt,
			data_download_queue.local_status as st,
			data_download_queue.sns_id as snid
		FROM data_download_queue 
		WHERE (data_download_queue.parse_photos = 0 or data_download_queue.parse_photos IS NULL)
-- 					AND data_download_queue.local_status = 'complete'
		GROUP BY 
			data_download_queue.priority,
			data_download_queue.local_status,
			data_download_queue.sns_id 
		) as tmp_tbl
		WHERE 	
	data_download_queue.priority = prt AND data_download_queue.local_status = st AND data_download_queue.sns_id = snid
) as 'photos_err',

	(SELECT cnt FROM (
		SELECT 
			count(id) as cnt,
			data_download_queue.priority as prt,
			data_download_queue.local_status as st,
			data_download_queue.sns_id as snid
		FROM data_download_queue 
		WHERE (data_download_queue.parse_videos = 0 or data_download_queue.parse_videos IS NULL)
-- 					AND data_download_queue.local_status = 'complete'
		GROUP BY 
			data_download_queue.priority,
			data_download_queue.local_status,
			data_download_queue.sns_id 
		) as tmp_tbl
		WHERE 	
	data_download_queue.priority = prt AND data_download_queue.local_status = st AND data_download_queue.sns_id = snid
) as 'videos_err',

	(SELECT cnt FROM (
		SELECT 
			count(id) as cnt,
			data_download_queue.priority as prt,
			data_download_queue.local_status as st,
			data_download_queue.sns_id as snid
		FROM data_download_queue 
		WHERE (data_download_queue.parse_friends = 0 or data_download_queue.parse_friends IS NULL)
-- 					AND data_download_queue.local_status = 'complete'
		GROUP BY 
			data_download_queue.priority,
			data_download_queue.local_status,
			data_download_queue.sns_id 
		) as tmp_tbl
		WHERE 	
	data_download_queue.priority = prt AND data_download_queue.local_status = st AND data_download_queue.sns_id = snid
) as 'friends_err',

	(SELECT cnt FROM (
		SELECT 
			count(id) as cnt,
			data_download_queue.priority as prt,
			data_download_queue.local_status as st,
			data_download_queue.sns_id as snid
		FROM data_download_queue 
		WHERE (data_download_queue.parse_groups = 0 or data_download_queue.parse_groups IS NULL) 
-- 					AND data_download_queue.local_status = 'complete'
		GROUP BY 
			data_download_queue.priority,
			data_download_queue.local_status,
			data_download_queue.sns_id 
		) as tmp_tbl
		WHERE 	
	data_download_queue.priority = prt AND data_download_queue.local_status = st AND data_download_queue.sns_id = snid
) as 'groups_err'

FROM 
	data_download_queue
WHERE sns_id IN (1, 2)	
-- AND data_download_queue.local_status = 'complete'
GROUP BY
	data_download_queue.priority,
	data_download_queue.local_status,
	data_download_queue.sns_id
ORDER BY
-- 	sns_id,
-- 	data_download_queue.local_status,
	data_download_queue.priority DESC,
	count DESC
