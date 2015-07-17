SELECT 
	count(ddl.error) as cnt, 
	LEFT(ddl.error,100) as err 
FROM 
	`data_download_log` as ddl
	INNER JOIN data_download_queue as ddq ON ddq.id = ddl.queue_id
WHERE 
	ddl.status = 0 AND 
	ddq.download_status = 'complete' AND
	ddq.download_friends = 0 OR ddq.download_friends IS NULL OR ddq.download_profile = 0 OR ddq.download_profile IS NULL
-- error NOT LIKE '%Local data of%' AND 
-- 	error NOT LIKE '%Access denied%' 
GROUP BY 
	err 
ORDER BY 
	cnt DESC;