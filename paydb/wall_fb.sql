SET @profile = 1103793950
;
SELECT  
						snsdb_new.content.date as date_create,
            snsdb_new.content.sns_item_id_1,
            snsdb_new.content.sns_item_id_0,
            snsdb_new.content.to_sns_item_id,
            snsdb_new.content.`to`,
            snsdb_new.content_types.`id` as type_id,
            snsdb_new.content_types.`name` as type_name,
            snsdb_new.content.shares,
            snsdb_new.content.`from_sns_item_id`,
            snsdb_new.content.`from`
            ,UNIX_TIMESTAMP(snsdb_new.content.date) as `date_create_u`
    FROM
        snsdb_new.`content`
        INNER JOIN snsdb_new.content_types on snsdb_new.content_types.id = snsdb_new.content.type_id
        INNER JOIN paydb.sns_profiles on paydb.sns_profiles.sns_id = snsdb_new.content.sns_id AND paydb.sns_profiles.sns_profile_id = snsdb_new.content.sns_item_id_0
    WHERE
        snsdb_new.content.sns_item_id_0 = @profile
        AND snsdb_new.content.sns_id = 2
        AND (content.date <= FROM_UNIXTIME(paydb.sns_profiles.date_create) OR content.date IS NULL)
    GROUP BY
        snsdb_new.content.id
    ORDER BY
				type_id,
        date DESC
    LIMIT 100;