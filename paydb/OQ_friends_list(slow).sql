SELECT 
paydb.ch_OQGRAPH_graph.linkid
-- snsdb.`profiles`.first_name,
-- snsdb.`profiles`.last_name
-- GROUP_CONCAT(linkid ORDER BY seq) AS path
FROM paydb.ch_OQGRAPH_graph -- LEFT JOIN snsdb.`profiles` on linkid = snsdb.`profiles`.sns_item_id
WHERE latch = '' and origid = 107219649 -- 'breadth_first' AND origid = 3187544 AND weight = 1 -- weight here is the degree of connection
-- ORDER BY seq ASC

-- 3187544 ME
-- 75030104 Kolya
-- 2584115 Artem
-- 75030104 Stas
