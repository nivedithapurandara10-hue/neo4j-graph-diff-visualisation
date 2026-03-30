// ============================================================
// DELTA GRAPH (ΔG) CONSTRUCTION
// ============================================================
// Builds a focused subgraph containing all changed elements
// and their immediate neighborhood context
// ============================================================


// ============================================================
// STEP 1 — IDENTIFY CHANGED NODES
// ============================================================

MATCH (n:Landmark)
WHERE n.change_type IS NOT NULL
WITH collect(n) AS changedNodes
RETURN size(changedNodes);


// ============================================================
// STEP 2 — EXPAND 1-HOP NEIGHBOURHOOD
// ============================================================

MATCH (n:Landmark)
WHERE n.change_type IS NOT NULL
WITH collect(n) AS changedNodes

UNWIND changedNodes AS c

MATCH (c)-[r]-(neighbor)

// Mark nodes and relationships as part of ΔG
SET c.in_delta_graph = true
SET neighbor.in_delta_graph = true
SET r.in_delta_graph = true;


// ============================================================
// STEP 3 — INCLUDE MODIFIED RELATIONSHIPS
// ============================================================

MATCH ()-[r]->()
WHERE r.mod_type IS NOT NULL
SET r.in_delta_graph = true;


// ============================================================
// STEP 4 — VERIFY ΔG SIZE
// ============================================================

MATCH (n)
WHERE n.in_delta_graph = true
RETURN count(n) AS delta_nodes;

MATCH ()-[r]->()
WHERE r.in_delta_graph = true
RETURN count(r) AS delta_relationships;


// ============================================================
// STEP 5 — VISUALISE ΔG
// ============================================================

MATCH (n)
WHERE n.in_delta_graph = true
MATCH (n)-[r]-(m)
WHERE r.in_delta_graph = true
RETURN n, r, m;
