DROP FUNCTION IF EXISTS HandshakesInDefaultCount;
CREATE FUNCTION HandshakesInDefaultCount (ID BIGINT, HS INT)  
RETURNS BIGINT DETERMINISTIC
READS SQL DATA	
BEGIN
DECLARE _COUNT BIGINT;
SELECT 
	-- ch_profiles_default.sns_profile_id into _count
	sum(ch_profiles_default.Default_45) INTO _COUNT
	FROM
	ch_profiles_default
	WHERE	ch_profiles_default.sns_profile_id IN (SELECT 
																									paydb.ch_OQGRAPH_graph.linkid
																								FROM 
																									paydb.ch_OQGRAPH_graph 
																								WHERE 
																									latch = 'breadth_first' and origid = ID AND weight = HS
)
;
RETURN _COUNT;
END;
