# Visualisation-Based Graph Database Comparison (Neo4j)

## Overview

This project presents a **visualisation-driven framework for comparing graph database versions** using Neo4j. It enables the detection and interpretation of differences across multiple analytical layers:

* **Structural differences** (node and relationship additions/deletions)
* **Relational differences** (property-level modifications)
* **Quantitative differences** (influence shifts using PageRank)

The framework constructs a **difference graph (ΔG)** that isolates only the relevant changes while preserving contextual neighbourhood structure, making it easier for non-technical users to interpret graph evolution.

---

## Objectives

* Detect structural changes between graph versions (G1 and G2)
* Identify semantic (property-level) modifications in relationships
* Measure indirect impact of structural changes using centrality metrics
* Construct a focused **ΔG subgraph** for visual analysis
* Enable intuitive exploration using Neo4j and Bloom

---

## Repository Structure

```
neo4j-graph-diff-visualisation/
│
├── data/
│   ├── gut_landmarks_g1.csv
│   ├── gut_regions_g1.csv
│   ├── gut_landmarks_g2.csv
│   ├── gut_regions_g2.csv
│
├── scripts/
│   ├── load_data.cypher
│   ├── structural_diff.cypher
│   ├── relational_diff.cypher
│   ├── pagerank_analysis.cypher
│   ├── delta_graph.cypher
│
└── README.md
```

---

## Dataset Description

The dataset represents a **graph-based anatomical model of the gastrointestinal tract**.

Each graph version is constructed using two CSV files:

### Landmark Files (Nodes)

Contain anatomical boundary points:

* `ident` — unique identifier
* `anatomy` — anatomical name
* `abbreviation` — short label
* `pos` — spatial position
* `version` — graph version (G1 or G2)

### Region Files (Relationships)

Define connections between landmarks:

* `ident` — relationship identifier
* `anatomy` — segment name
* `source` / `target` — connected landmarks
* `start`, `end`, `length` — spatial properties
* `version` — graph version

---

## Methodology

The framework follows a **multi-layer differencing pipeline**:

### 1. Data Ingestion

Graph data is loaded from CSV files using Cypher:

```
LOAD CSV → Nodes (Landmarks) + Relationships (Regions)
```

---

### 2. Structural Differencing

Detects:

* Node additions and deletions
* Relationship additions and deletions

---

### 3. Relational Differencing

Identifies **property-level changes** where structure remains unchanged.

---

### 4. Quantitative Analysis

Uses **PageRank centrality** to detect influence shifts:

```
Δpr = |pr_G1 − pr_G2|
```

---

### 5. ΔG Construction

Builds a **difference subgraph (ΔG)** containing:

* Changed nodes
* Modified relationships
* Contextual neighbourhood (1-hop expansion)

---

## How to Run

### Step 1 — Load Data

Run:

```
scripts/load_data.cypher
```

---

### Step 2 — Detect Structural Differences

```
scripts/structural_diff.cypher
```

---

### Step 3 — Detect Relational Differences

```
scripts/relational_diff.cypher
```

---

### Step 4 — Run Quantitative Analysis

```
scripts/pagerank_analysis.cypher
```

---

### Step 5 — Construct ΔG

```
scripts/delta_graph.cypher
```

---

## 📈 Key Features

* Deterministic graph alignment using unique identifiers
* Separation of structural, relational, and quantitative changes
* Detection of **non-local influence propagation**
* Scalable and reproducible pipeline
* Visualisation-ready output using Neo4j Bloom

---

## Key Insight

Local structural changes (e.g., node deletion or edge rewiring) can produce **non-local effects** across the graph.
This framework captures those effects using centrality-based analysis and highlights them in ΔG.

---

## Reproducibility

All datasets and queries are included in this repository, enabling full reproduction of results.

---

## Technologies Used

* **Neo4j** — Graph database
* **Cypher** — Query language
* **Neo4j Graph Data Science (GDS)** — PageRank computation
* **Neo4j Bloom** — Visualisation

---

## Author

**Niveditha Purandara**
MSc Data Science
Heriot-Watt University

---

## Notes

This project was developed as part of a dissertation on **graph database comparison and visual analytics**, focusing on improving accessibility for domain experts through visual differencing techniques.

---
