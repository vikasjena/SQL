SELECT 
 paydb_andrew.Vw_Sessions_Data.id,
 paydb_andrew.Vw_Sessions_Data.phone,
 paydb_andrew.Vw_Sessions_Data.ip,
 paydb_andrew.ip_details.region_id,
 paydb_andrew.regions.`name`,
 paydb_andrew.probability_phones.probability_region_practical
FROM 
 paydb_andrew.Vw_Sessions_Data 
 LEFT JOIN paydb_andrew.ip_details ON paydb_andrew.Vw_Sessions_Data.ip = paydb_andrew.ip_details.ip
 LEFT JOIN paydb_andrew.probability_phones ON paydb_andrew.Vw_Sessions_Data.phone = paydb_andrew.probability_phones.phone
 LEFT JOIN paydb_andrew.regions ON paydb_andrew.ip_details.region_id = paydb_andrew.regions.id
-- WHERE paydb_andrew.Vw_Sessions_Data.phone in (79055142335, 79370673016)
GROUP BY phone
HAVING paydb_andrew.probability_phones.probability_region_practical IS NULL AND phone IS NOT NULL 

ORDER BY
 phone