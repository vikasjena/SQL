SELECT
*
FROM snsdb_new.content
WHERE snsdb_new.content.profile_id IN (select snsdb_new.`profiles`.id from snsdb_new.`profiles` where snsdb_new.`profiles`.sns_item_id in (SELECT paydb.sns_profiles.sns_profile_id FROM paydb.sns_profiles)))
