// ============================================================
// STRUCTURAL DIFFERENCE DETECTION
// ============================================================
// Detects:
// 1. Node deletions (G1 → missing in G2)
// 2. Node additions (G2 → missing in G1)
// 3. Relationship deletions
// 4. Relationship additions
// ============================================================


// ============================================================
// NODE DELETION (Present in G1, missing in G2)
// ============================================================

MATCH (n1:Landmark {version:'G1'})
WHERE NOT EXISTS {
    MATCH (n2:Landmark {version:'G2'})
    WHERE n2.ident = n1.ident
}
SET n1.change_type = 'DELETED';


// ============================================================
// NODE ADDITION (Present in G2, missing in G1)
// ============================================================

MATCH (n2:Landmark {version:'G2'})
WHERE NOT EXISTS {
    MATCH (n1:Landmark {version:'G1'})
    WHERE n1.ident = n2.ident
}
SET n2.change_type = 'ADDED';


// ============================================================
// RELATIONSHIP DELETION (G1 → not in G2)
// ============================================================

MATCH (a1:Landmark {version:'G1'})-[r1:REGION {version:'G1'}]->(b1:Landmark {version:'G1'})
WHERE NOT EXISTS {
    MATCH (a2:Landmark {version:'G2'})-[r2:REGION {version:'G2'}]->(b2:Landmark {version:'G2'})
    WHERE a2.ident = a1.ident
      AND b2.ident = b1.ident
      AND r2.ident = r1.ident
}
SET r1.change_type = 'REL_DELETED';


// ============================================================
// RELATIONSHIP ADDITION (G2 → not in G1)
// ============================================================

MATCH (a2:Landmark {version:'G2'})-[r2:REGION {version:'G2'}]->(b2:Landmark {version:'G2'})
WHERE NOT EXISTS {
    MATCH (a1:Landmark {version:'G1'})-[r1:REGION {version:'G1'}]->(b1:Landmark {version:'G1'})
    WHERE a1.ident = a2.ident
      AND b1.ident = b2.ident
      AND r1.ident = r2.ident
}
SET r2.change_type = 'REL_ADDED';
