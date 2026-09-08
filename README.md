# -Mercedes-Benz-12M-Sales-Analytics-
`SQL &amp; Tableau End-to-End Pipeline on 12M Mercedes-Benz Sales Dataset`


# 📌 Executive Summary
This project delivers a **High-Performance SQL Data Pipeline and Executive Tableau Dashboard** analyzing **12 Million records** of Mercedes-Benz sales data (2020–2025/2026). 

The entire ETL (Extract, Transform, Load) and aggregation process was engineered locally on a **constrained system (4GB RAM, Intel Core i3 @ 1.2GHz)** without utilizing dedicated enterprise servers or cloud computing instances ($0 Infrastructure Cost).

---

## 🛠️ Tech Stack & Resource Constraints

* **Database & Query Engine:** T-SQL (MS SQL Server)
* **Visualization:** Tableau Desktop / Public
* **Processor:** Intel Core i3 (1.2 GHz)
* **RAM:** 4 GB System Memory
* **Infrastructure Cost:** $0.00 USD

🏛️ 2. Architecture Blueprint & Data Flow

The data architecture is engineered to prevent memory overflows (OOM) through stream-based chunking and strict type casting at the ingestion boundary.

 [ Raw CSV Data (12M+ Rows) ]
              │
              ▼ (used read_csv to load data by indexing )
 [ Staging & Type Casting Layer (SQL / Pandas Buffer) ]
              │
              ├──► Filter: Base Price > 0, Horsepower > 0, Sales Volume > 0
              └──► Filter: Drop NULLs across critical dimensions
              │
              ▼
 [ Memory-Optimized Aggregation Engine (RAM Limit: 2GB) ]
              │
              ├──► Group By: Model, Year, Region, Color, Fuel Type, Turbo
              └──► Compute: SUM(Base Price), SUM(Sales Volume), SUM(Horsepower)
              │
              ▼
 [ Analytical Datastore / Presentation Layer ]

 4. Memory-Optimized Processing Strategy (4GB RAM Constraint)

Processing 12M rows natively in Python/Pandas or SQL engines often causes Out-Of-Memory (OOM) errors on low-spec hardware. The following engineering patterns were enforced:

    Chunked Iteration (Generator Pattern): Instead of loading all 12 million rows into memory simultaneously, the data pipeline consumes the CSV in sequential chunks (e.g., 500,000 rows per batch).

    Aggressive Downcasting:

        Floats and unoptimized integers are dynamically cast to efficient types (int32, int64 only where necessary).

        Categorical string columns (Model, Color, Fuel Type) are converted to Pandas category dtype to minimize memory footprint by up to 70%.

    In-Stream Aggregation: Partial aggregations are computed per chunk and accumulated, avoiding large intermediate join tables in RAM.
    
