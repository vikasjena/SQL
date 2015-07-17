
-- DROP TABLE IF EXISTS ch_OQGRAPH_data;
CREATE TABLE IF NOT EXISTS ch_OQGRAPH_data(
	origid INT UNSIGNED NULL,
	destid INT UNSIGNED NULL,
	PRIMARY KEY (origid, destid),
	KEY (destid)
);

INSERT INTO paydb.ch_OQGRAPH_data (origid, destid)
SELECT 
	user_relations_lite_directional.sns_item_id0, 
	user_relations_lite_directional.sns_item_id1
FROM 
	user_relations_lite_directional
ON DUPLICATE KEY UPDATE origid=origid, destid=destid
;

/*
-- DROP TABLE IF EXISTS paydb.ch_OQGRAPH_graph;
CREATE TABLE ch_OQGRAPH_graph (
  latch VARCHAR(32) NULL,
  origid BIGINT UNSIGNED NULL,
  destid BIGINT UNSIGNED NULL,
  weight DOUBLE NULL,
  seq BIGINT UNSIGNED NULL,
  linkid BIGINT UNSIGNED NULL,
  KEY (latch, origid, destid) USING HASH,
  KEY (latch, destid, origid) USING HASH
) 
ENGINE=OQGRAPH 
data_table='ch_OQGRAPH_data' origid='origid' destid='destid';
*/