SELECT 					
-- 								users.phone,
								prof.first_name,
								prof.last_name,
								prof.sns_id as prf_sns_id,
								prof.sns_profile_id as prf_sns_prof_id,

								FROM_UNIXTIME(cr.date_create) as date_start,

								un_users.union_id,
								un_users.user_id,

								sum(cr.amount_original) as amount_original,
								(sum(cr.amount_paid) + sum(cr.interest_paid)) as amount_paid,
								sum(cr.amount_remaining) amount_remaining
							FROM
									sns_profiles as prof
									LEFT OUTER JOIN union_sns_profiles as un_prof on prof.sns_id = un_prof.sns_id AND un_prof.sns_item_id = prof.sns_profile_id
									RIGHT OUTER JOIN union_users as un_users ON un_users.union_id = un_prof.union_id
									RIGHT OUTER JOIN credits as cr on cr.user_id = un_users.user_id

 WHERE prof.sns_profile_id IN (select 
 frnd.friend_sns_item_id
 FROM snsdb_new.friends as frnd
 WHERE  sns_item_id = 3187544)
 
GROUP BY 
-- un_users.union_id
	cr.id
LIMIT 200