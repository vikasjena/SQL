select COUNT(credit_sessions.id)

from credit_sessions
where FROM_UNIXTIME(credit_sessions.date_start) > '2013-10-17' and credit_sessions.sns_id = 'FB'
;
select COUNT(credit_sessions.id)

from credit_sessions
where FROM_UNIXTIME(credit_sessions.date_start) > '2013-10-17' and credit_sessions.sns_id = 'OK'
;
select COUNT(credit_sessions.id)

from credit_sessions
where FROM_UNIXTIME(credit_sessions.date_start) > '2013-10-17' and credit_sessions.sns_id = 'VK'