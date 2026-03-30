// ============================================================
// QUANTITATIVE DIFFERENCE ANALYSIS (PAGERANK)
// ============================================================
// Computes PageRank for G1 and G2 separately and detects
// influence shifts based on centrality differences
// ============================================================


// ============================================================
// STEP 1 — PROJECT G1 GRAPH
// ============================================================

CALL gds.graph.project.cypher(
  'graph_G1',
  'MATCH (n:Landmark {version:"G1"}) RETURN id(n) AS id',
  'MATCH (a:Landmark {version:"G1"})-[r:REGION {version:"G1"}]->(b:Landmark {version:"G1"})
   RETURN id(a) AS source, id(b) AS target'
);


// ============================================================
// STEP 2 — COMPUTE PAGERANK FOR G1
// ============================================================

CALL gds.pageRank.write('graph_G1', {
  writeProperty: 'pr_G1'
});


// ============================================================
// STEP 3 — DROP G1 PROJECTION
// ============================================================

CALL gds.graph.drop('graph_G1');


// ============================================================
// STEP 4 — PROJECT G2 GRAPH
// ============================================================

CALL gds.graph.project.cypher(
  'graph_G2',
  'MATCH (n:Landmark {version:"G2"}) RETURN id(n) AS id',
  'MATCH (a:Landmark {version:"G2"})-[r:REGION {version:"G2"}]->(b:Landmark {version:"G2"})
   RETURN id(a) AS source, id(b) AS target'
);


// ============================================================
// STEP 5 — COMPUTE PAGERANK FOR G2
// ============================================================

CALL gds.pageRank.write('graph_G2', {
  writeProperty: 'pr_G2'
});


// ============================================================
// STEP 6 — DROP G2 PROJECTION
// ============================================================

CALL gds.graph.drop('graph_G2');


// ============================================================
// STEP 7 — COMPUTE INFLUENCE DELTA
// ============================================================

MATCH (g1:Landmark {version:'G1'}),
      (g2:Landmark {version:'G2'})
WHERE g1.ident = g2.ident
WITH g1, g2, abs(g1.pr_G1 - g2.pr_G2) AS delta
WHERE delta > 0.0001
SET g2.change_type = 'INFLUENCE_SHIFT';


// ============================================================
// STEP 8 — VERIFY RESULTS
// ============================================================

MATCH (n:Landmark)
WHERE n.change_type = 'INFLUENCE_SHIFT'
RETURN n.ident, n.change_type;
