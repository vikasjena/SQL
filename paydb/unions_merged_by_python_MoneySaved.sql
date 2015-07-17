-- SESSIOINS FOR UNIONS MERGED BY MODEL
drop TEMPORARY table if exists sfsfsfsf;
create TEMPORARY table if not exists sfsfsfsf
SELECT 
 FROM_UNIXTIME(credit_sessions.date_start) as time,
 credit_sessions.user_id,
case when Union_id_1 != Union_id_2 and Union_id_2 != 0 then 1 else null end as mrg,
 client_data_model_log.* 
FROM `client_data_model_log` 
 left join credit_sessions on credit_sessions.id = client_data_model_log.Session_id_1 
HAVING 
	time > '2014-08-02 11:00:00' -- AND time <'2014-08-04 11:00:00'
	and mrg = 1
order by id desc
;

drop table if exists ch_unions_merged_by_python_tmp;
create table if not exists ch_unions_merged_by_python_tmp
SELECT
case when Union_id_1 < Union_id_2 then Union_id_1
ELSE Union_id_2 END AS union_1,
case when Union_id_1 > Union_id_2 then Union_id_1
ELSE Union_id_2 END AS union_2

from sfsfsfsf
GROUP BY union_1, union_2
;
-- select * from unions_merged_by_pyth;
drop TEMPORARY table if exists ch_unions_merged_by_python_tmp_2;
create TEMPORARY table if not exists ch_unions_merged_by_python_tmp_2
select 
	shop_id,
	union_id,
	id, 
	CASE
	when max(amount) > 1500 then 1500
	else max(amount)
	end as amount,
	 result,
	 count(*)
 from credit_sessions 
where union_id in (select union_1 from ch_unions_merged_by_python_tmp) or union_id in (select union_2 from ch_unions_merged_by_python_tmp) 
GROUP BY result, union_id
;
drop TEMPORARY table if exists ch_unions_merged_by_python_tmp_3;
create TEMPORARY table if not exists ch_unions_merged_by_python_tmp_3
select * from ch_unions_merged_by_python_tmp_2 where result in ('union blocked', 'union debt', 'first union loan not repaid', 'unrepaid default loan') GROUP BY union_id;

-- LIST OF BLOCKED FRAUDSTERS
SELECT
 * 
from ch_unions_merged_by_python_tmp_3;

-- SUM AND QUANTITY OF PREVENTED FRAUDULENT OPERATIONS
SELECT shop_id,
 count(*),
 sum(amount) as sum
 from ch_unions_merged_by_python_tmp_3
 GROUP BY shop_id
ORDER BY sum desc;
