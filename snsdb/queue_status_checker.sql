SELECT 
	data_download_queue.priority,
	data_download_queue.state,
	data_download_queue.sns_id,
	COUNT(DISTINCT data_download_queue.sns_item_id) AS count
FROM 
	data_download_queue
WHERE sns_id IN (1, 2)	AND data_download_queue.priority >=10
GROUP BY
	data_download_queue.priority,
	data_download_queue.state

ORDER BY
	data_download_queue.state,
	data_download_queue.priority DESC,
	count DESC

;
SELECT 
	data_download_queue.state,
	COUNT(DISTINCT data_download_queue.sns_item_id) AS count
FROM 
	data_download_queue
WHERE sns_id IN (1, 2)
			AND data_download_queue.priority >=10
GROUP BY
	data_download_queue.state

ORDER BY
	data_download_queue.state,
	data_download_queue.priority DESC,
	count DESC
;

SELECT 
	data_download_queue.state,
	COUNT(DISTINCT data_download_queue.sns_item_id) AS count
FROM 
	data_download_queue
-- WHERE sns_id IN (1, 2, 3) AND data_download_queue.priority >=10
GROUP BY
	data_download_queue.state

ORDER BY
	data_download_queue.state,
	data_download_queue.priority DESC,
	count DESC