SET @DATE = '2014-05-16 15:28:00';
select 
visitors.source as source,
(DATEDIFF(NOW(), min(FROM_UNIXTIME(visitors.date_create)))) as shown_for_days,
count(DISTINCT visitors.cookie) as count,
CONCAT(FORMAT(((count(DISTINCT visitors.cookie)/
(select _COUNT from (select 
	count(distinct visitors.cookie) as _COUNT
	from visitors
	where FROM_UNIXTIME(visitors.date_create) > @DATE
) as temptable1)))*100,2),'%') as "count_%",

(select _COUNT from (select 
	visitors.source as _source,
	count(distinct visitors.cookie) as _COUNT
	from visitors
	INNER JOIN visitors_to_sessions on visitors_to_sessions.visitor_id = visitors.id
	where FROM_UNIXTIME(visitors.date_create) > @DATE
	GROUP BY visitors.source
	) as temptable1
	where _source = visitors.source
) as credit_sessions,

(select _COUNT from (select 
	visitors.source as _source,
	count(distinct visitors.cookie) as _COUNT
	from visitors
	INNER JOIN visitors_to_sessions on visitors_to_sessions.visitor_id = visitors.id
	INNER JOIN credit_sessions on credit_sessions.id = visitors_to_sessions.credit_session_id
	where FROM_UNIXTIME(visitors.date_create) > @DATE
				AND credit_sessions.date_sns_redirect is not null
	GROUP BY visitors.source
	) as temptable1
	where _source = visitors.source
) as sn_click,

(select _COUNT from (select 
	visitors.source as _source,
	count(distinct visitors.cookie) as _COUNT
	from visitors
	INNER JOIN visitors_to_sessions on visitors_to_sessions.visitor_id = visitors.id
	INNER JOIN credit_sessions on credit_sessions.id = visitors_to_sessions.credit_session_id
	where FROM_UNIXTIME(visitors.date_create) > @DATE
				AND credit_sessions.date_phone is not null
	GROUP BY visitors.source
	) as temptable1
	where _source = visitors.source
) as sn_permission_ok,

(select _COUNT from (select 
	visitors.source as _source,
	count(distinct visitors.cookie) as _COUNT
	from visitors
	INNER JOIN visitors_to_sessions on visitors_to_sessions.visitor_id = visitors.id
	INNER JOIN credit_sessions on credit_sessions.id = visitors_to_sessions.credit_session_id
	where FROM_UNIXTIME(visitors.date_create) > @DATE
				AND credit_sessions.date_sms is not null
	GROUP BY visitors.source
	) as temptable1
	where _source = visitors.source
) as phone,

(select _COUNT from (select 
	visitors.source as _source,
	count(distinct visitors.cookie) as _COUNT
	from visitors
	INNER JOIN visitors_to_sessions on visitors_to_sessions.visitor_id = visitors.id
	INNER JOIN credit_sessions on credit_sessions.id = visitors_to_sessions.credit_session_id
	where FROM_UNIXTIME(visitors.date_create) > @DATE
				AND credit_sessions.condition_id is not null
	GROUP BY visitors.source
	) as temptable1
	where _source = visitors.source
) as session_finished,

(select _COUNT from (select 
	visitors.source as _source,
	count(distinct visitors.cookie) as _COUNT
	from visitors
	INNER JOIN visitors_to_sessions on visitors_to_sessions.visitor_id = visitors.id
	INNER JOIN credit_sessions on credit_sessions.id = visitors_to_sessions.credit_session_id
	where FROM_UNIXTIME(visitors.date_create) > @DATE
				AND credit_sessions.result = 'credit confirmed'
	GROUP BY visitors.source
	) as temptable1
	where _source = visitors.source
) as purchases,



min(FROM_UNIXTIME(visitors.date_create)) as min_date_create,
max(FROM_UNIXTIME(visitors.date_create)) as max_date_create,
min(FROM_UNIXTIME(visitors.date_last_seen)) as min_last_seen,
max(FROM_UNIXTIME(visitors.date_last_seen)) as max_last_seen

from visitors
WHERE FROM_UNIXTIME(visitors.date_create)  > @DATE
GROUP BY visitors.source
ORDER BY 
-- source, 
count desc
