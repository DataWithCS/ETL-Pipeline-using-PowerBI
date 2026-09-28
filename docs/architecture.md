# ETL Pipeline Architecture

## Overview

This project implements a small-scale ETL pipeline using **Power BI and Power Query**.

The pipeline extracts data from multiple yearly CSV files, applies reusable transformation logic, combines the data into a unified analytical dataset, and loads the result into Power BI for data modeling and dashboarding.

## Architecture

```text
                    DATA SOURCES
                         │
             ┌───────────┼───────────┐
             ▼           ▼           ▼
          2016.csv    2017.csv    2018.csv
             │           │           │
             └───────────┼───────────┘
                         │
                      2019.csv
                         │
                         ▼
                  ┌─────────────┐
                  │   EXTRACT   │
                  │ Folder      │
                  │ Connector   │
                  └──────┬──────┘
                         │
                         ▼
                  ┌─────────────┐
                  │ TRANSFORM   │
                  │ Power Query │
                  └──────┬──────┘
                         │
              ┌──────────┼──────────┐
              ▼          ▼          ▼
          Clean Data  Standardize  Validate
              │          │          │
              └──────────┼──────────┘
                         ▼
                  Combine / Append
                         │
                         ▼
                ┌────────────────┐
                │  LOAD          │
                │  Power BI      │
                │  Data Model    │
                └───────┬────────┘
                        │
                        ▼
                ┌────────────────┐
                │   DASHBOARD     │
                │   & INSIGHTS    │
                └────────────────┘
```

## ETL Layers

### 1. Extract

Source files are stored in:

```text
data/raw/
├── 2016.csv
├── 2017.csv
├── 2018.csv
└── 2019.csv
```

Power BI connects to the folder rather than treating each file as a completely separate report.

### 2. Transform

Power Query performs the transformation layer.

Typical steps:

1. Read files from the source folder.
2. Filter out unwanted files.
3. Read the CSV content.
4. Promote headers.
5. Standardize column names.
6. Set appropriate data types.
7. Remove unnecessary columns.
8. Handle missing values.
9. Remove duplicates where appropriate.
10. Standardize categorical values.
11. Create derived fields such as Year where required.
12. Combine the yearly datasets.
13. Validate the final result.

### 3. Load

The final transformed table is loaded into the Power BI model.

```text
Power Query
     ↓
Clean Dataset
     ↓
Power BI Data Model
     ↓
DAX Measures
     ↓
Visualizations
```

## Refresh Architecture

The pipeline is designed around a folder-based source.

If a new compatible file arrives:

```text
2020.csv
```

it can be placed into:

```text
data/raw/
```

and included in the next refresh, provided it meets the expected schema and the folder query is configured to include it.

```text
Existing Files ─┐
                │
New File ───────┼──→ Power Query → Transform → Combine
                │                              │
                └──────────────────────────────┘
                                               ↓
                                          Power BI
                                               ↓
                                          Dashboard
```

## Design Principles

### Reusability

Transformation logic should be created once and reused during refresh.

### Consistency

The same transformation rules should be applied to all compatible source files.

### Separation of Layers

Raw data, transformation logic, documentation, and reporting assets should be kept separate.

### Scalability

The architecture should make it possible to move from local CSV ingestion to cloud-based data engineering in the future.

## Future Architecture

The current implementation can evolve into:

```text
CSV / Excel / API / SQL
          │
          ▼
   Data Ingestion
          │
          ▼
      Data Lake
          │
          ▼
   Transformation
          │
          ▼
   Data Warehouse
       │       │
       ▼       ▼
   Power BI    AI
```

Possible future technologies include Azure Data Factory, Azure Data Lake, Databricks, Spark, and AI/RAG applications.
