// ============================================================
// LOAD DATA INTO NEO4J FROM CSV FILES
// ============================================================
// This script loads G1 and G2 graph data from CSV files.
// It creates Landmark nodes and REGION relationships.
// ============================================================


// ============================================================
// LOAD G1 LANDMARKS
// ============================================================

LOAD CSV WITH HEADERS FROM 'file:///gut_landmarks_g1.csv' AS row
CREATE (:Landmark {
  ident: row.ident,
  anatomy: row.anatomy,
  abbreviation: row.abbreviation,
  pos: toInteger(row.pos),
  version: row.version
});


// ============================================================
// LOAD G1 REGIONS
// ============================================================

LOAD CSV WITH HEADERS FROM 'file:///gut_regions_g1.csv' AS row
MATCH (a:Landmark {abbreviation: row.source, version: 'G1'}),
      (b:Landmark {abbreviation: row.target, version: 'G1'})
CREATE (a)-[:REGION {
  ident: row.ident,
  anatomy: row.anatomy,
  start: toInteger(row.start),
  end: toInteger(row.end),
  length: toInteger(row.length),
  version: row.version
}]->(b);


// ============================================================
// LOAD G2 LANDMARKS
// ============================================================

LOAD CSV WITH HEADERS FROM 'file:///gut_landmarks_g2.csv' AS row
CREATE (:Landmark {
  ident: row.ident,
  anatomy: row.anatomy,
  abbreviation: row.abbreviation,
  pos: toInteger(row.pos),
  version: row.version
});


// ============================================================
// LOAD G2 REGIONS
// ============================================================

LOAD CSV WITH HEADERS FROM 'file:///gut_regions_g2.csv' AS row
MATCH (a:Landmark {abbreviation: row.source, version: 'G2'}),
      (b:Landmark {abbreviation: row.target, version: 'G2'})
CREATE (a)-[:REGION {
  ident: row.ident,
  anatomy: row.anatomy,
  start: toInteger(row.start),
  end: toInteger(row.end),
  length: toInteger(row.length),
  version: row.version
}]->(b);
