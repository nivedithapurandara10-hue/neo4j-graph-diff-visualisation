// ============================================================
// RELATIONAL DIFFERENCE DETECTION
// ============================================================
// Detects property-level changes in relationships
// where structure remains the same across versions
// ============================================================


// ============================================================
// RELATIONSHIP PROPERTY MODIFICATION
// ============================================================

MATCH (a1:Landmark {version:'G1'})-[r1:REGION {version:'G1'}]->(b1:Landmark {version:'G1'}),
      (a2:Landmark {version:'G2'})-[r2:REGION {version:'G2'}]->(b2:Landmark {version:'G2'})
WHERE a1.ident = a2.ident
  AND b1.ident = b2.ident
  AND r1.ident = r2.ident
  AND (
        r1.anatomy <> r2.anatomy OR
        r1.start <> r2.start OR
        r1.end <> r2.end OR
        r1.length <> r2.length
      )
SET r2.mod_type = 'REL_MODIFIED';
