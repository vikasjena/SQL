DROP TEMPORARY TABLE IF EXISTS paydb.profile_loc_1;
CREATE TEMPORARY TABLE paydb.profile_loc_1
SELECT 
	snsdb_new.profiles.id,
	snsdb_new.profiles.sns_id,
	snsdb_new.profiles.sns_item_id,
	snsdb_new.profiles.first_name,
	snsdb_new.profiles.last_name,
	snsdb_new.profiles.gender,
	-- hometown_location_id,
	snsdb_new.profiles.location_location_id,
	-- country_id,
	snsdb_new.profiles.timezone

FROM 
	snsdb_new.profiles 
	INNER JOIN paydb.sns_profiles ON paydb.sns_profiles.sns_profile_id = snsdb_new.profiles.sns_item_id 
WHERE
paydb.sns_profiles.condition_passed = 1
;

DROP TEMPORARY TABLE IF EXISTS paydb.profile_loc;
CREATE TEMPORARY TABLE paydb.profile_loc
SELECT
*,
(select _COUNTRY from (SELECT
				snsdb_new.locations.id as _ID,
				snsdb_new.locations.geo_country_id as _COUNTRY,
				snsdb_new.locations.geo_city_id as _CITY,
				snsdb_new.locations.geo_region_id as _REGION
				from snsdb_new.locations 
) as temptable1
			WHERE _ID = paydb.profile_loc_1.location_location_id)
as loc_loc_country,

(select _REGION from (SELECT
				snsdb_new.locations.id as _ID,
				snsdb_new.locations.geo_country_id as _COUNTRY,
				snsdb_new.locations.geo_city_id as _CITY,
				snsdb_new.locations.geo_region_id as _REGION
				from snsdb_new.locations 
) as temptable1
			WHERE _ID = paydb.profile_loc_1.location_location_id)
as loc_loc_region,

(select _CITY from (SELECT
				snsdb_new.locations.id as _ID,
				snsdb_new.locations.geo_country_id as _COUNTRY,
				snsdb_new.locations.geo_city_id as _CITY,
				snsdb_new.locations.geo_region_id as _REGION
				from snsdb_new.locations 
) as temptable1
			WHERE _ID = paydb.profile_loc_1.location_location_id)
as loc_loc_city
/*
	location_country_id,
(select _COUNTRY from (SELECT
				snsdb_new.locations.id as _ID,
				snsdb_new.locations.geo_country_id as _COUNTRY,
				snsdb_new.locations.geo_city_id as _CITY,
				snsdb_new.locations.geo_region_id as _REGION
				from snsdb_new.locations 
) as temptable1
			WHERE _ID = paydb.profile_loc_1.location_country_id)
as loc_country_country,

(select _REGION from (SELECT
				snsdb_new.locations.id as _ID,
				snsdb_new.locations.geo_country_id as _COUNTRY,
				snsdb_new.locations.geo_city_id as _CITY,
				snsdb_new.locations.geo_region_id as _REGION
				from snsdb_new.locations 
) as temptable1
			WHERE _ID = paydb.profile_loc_1.location_country_id)
as loc_country_region,

(select _CITY from (SELECT
				snsdb_new.locations.id as _ID,
				snsdb_new.locations.geo_country_id as _COUNTRY,
				snsdb_new.locations.geo_city_id as _CITY,
				snsdb_new.locations.geo_region_id as _REGION
				from snsdb_new.locations 
) as temptable1
			WHERE _ID = paydb.profile_loc_1.location_country_id)
as loc_country_city,
*/

FROM
	paydb.profile_loc_1
;

DROP TABLE IF EXISTS paydb_andrew.profiles_locations;
CREATE TABLE paydb_andrew.profiles_locations
SELECT
*,
(select _NAME from (SELECT
					geo_amigo.countries.id as _ID,
					geo_amigo.countries.`name` as _NAME
				from geo_amigo.countries 
) as temptable1
			WHERE _ID = paydb.profile_loc.loc_loc_country)
as loc_loc_country_name,

(select _NAME from (SELECT
					geo_amigo.regions.id as _ID,
					geo_amigo.regions.name_yandex as _NAME
				from geo_amigo.regions 
) as temptable1
			WHERE _ID = paydb.profile_loc.loc_loc_region)
as loc_loc_region_name,

(select _NAME from (SELECT
					geo_amigo.cities.id as _ID,
					geo_amigo.cities.`name` as _NAME
				from geo_amigo.cities 
) as temptable1
			WHERE _ID = paydb.profile_loc.loc_loc_city)
as loc_loc_city_name

FROM 
	paydb.profile_loc
;

SELECT
	*
FROM
	paydb_andrew.profiles_locations