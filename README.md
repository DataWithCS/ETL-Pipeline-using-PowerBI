# ETL Pipeline Using Power BI & Power Query

> **A practical end-to-end ETL pipeline that extracts multi-year CSV data, transforms and combines it using Power Query, and loads the final dataset into Power BI for analysis and dashboarding.**

![Power BI](https://img.shields.io/badge/Power%20BI-Data%20Analytics-yellow)
![Power Query](https://img.shields.io/badge/Power%20Query-ETL-blue)
![ETL](https://img.shields.io/badge/ETL-Pipeline-green)
![Data Engineering](https://img.shields.io/badge/Data-Engineering-orange)

---

## 📌 Project Overview

This project demonstrates how a **Data Analyst can build a repeatable ETL pipeline using Power BI and Power Query**.

The project uses multiple yearly CSV files such as:

```text
2016.csv
2017.csv
2018.csv
2019.csv
```

Instead of manually cleaning and combining every file, we build the transformation logic once in **Power Query**.

The pipeline then:

```text
CSV Files
    ↓
Extract
    ↓
Power Query
    ↓
Clean + Transform + Combine
    ↓
Data Model
    ↓
Power BI
    ↓
Dashboard & Insights
```

The main idea is simple:

> **Build the transformation process once and reuse it whenever new compatible data arrives.**

---

# 🎯 Project Objectives

This project is designed to demonstrate:

- How ETL works in a practical BI environment
- How to extract data from multiple CSV files
- How to combine files using Power Query
- How to clean and standardize raw data
- How to handle missing values and duplicates
- How to create reusable transformation logic
- How to load transformed data into Power BI
- How to create a Power BI data model
- How to build an analytical dashboard
- How a pipeline can process new yearly files after refresh
- How a Power BI workflow can become the foundation for Data Engineering

---

# 🧠 What is Data Engineering?

**Data Engineering** is the process of building systems that collect, transform, store, and deliver data so that it can be reliably used for analytics, reporting, applications, and AI.

In simple terms:

> **Data Engineering makes data available, reliable, and ready to use.**

A Data Engineer commonly works with:

- Data sources
- Databases
- APIs
- ETL / ELT
- Data pipelines
- Data warehouses
- Data lakes
- Cloud platforms
- Data quality
- Workflow orchestration

This project represents a **small-scale ETL implementation** using Power Query and Power BI.

---

# 🔄 What is ETL?

ETL stands for:

```text
E → Extract
T → Transform
L → Load
```

## 1. Extract

Collect data from one or more sources.

Examples:

- CSV
- Excel
- SQL databases
- APIs
- Cloud storage

In this project, the primary sources are yearly CSV files.

```text
2016.csv
2017.csv
2018.csv
2019.csv
```

---

## 2. Transform

Convert raw data into clean, consistent, analysis-ready data.

Typical transformations include:

- Removing unnecessary columns
- Renaming columns
- Changing data types
- Removing duplicates
- Handling missing values
- Standardizing text
- Filtering records
- Splitting columns
- Merging columns
- Creating calculated columns
- Combining multiple files

---

## 3. Load

Load the transformed data into the analytical destination.

In this project:

```text
Power Query
     ↓
Power BI Data Model
     ↓
Dashboard
```

---

# 🏗️ Solution Architecture

```text
                           ETL PIPELINE
                                │
       ┌────────────────────────┼────────────────────────┐
       │                        │                        │
       ▼                        ▼                        ▼
    EXTRACT                 TRANSFORM                  LOAD
       │                        │                        │
       │                   Power Query                  │
       │                        │                        │
       ▼                        ▼                        ▼
  CSV Files                Clean Data              Power BI
       │                        │                   Dataset
       │                        │                        │
       ├── 2016.csv             ├── Clean              │
       ├── 2017.csv             ├── Transform          ▼
       ├── 2018.csv             ├── Validate        Data Model
       └── 2019.csv             └── Combine             │
                                                        ▼
                                                   Dashboard
```

### High-Level Data Flow

```text
Multiple CSV Files
        │
        ▼
   Folder Source
        │
        ▼
    Power Query
        │
        ├── Promote Headers
        ├── Change Data Types
        ├── Remove Columns
        ├── Handle Missing Values
        ├── Remove Duplicates
        ├── Standardize Values
        ├── Create Columns
        └── Combine Files
        │
        ▼
  Cleaned Dataset
        │
        ▼
   Power BI Model
        │
        ▼
    Dashboard
```

---

# 📂 Repository Structure

The repository is organized as follows:

```text
ETL-Pipeline-PowerBI/
│
├── README.md
│
├── data/
│   ├── raw/
│   │   └── yearly CSV files
│   │
│   └── sample/
│       └── sample dataset
│
├── power-query/
│   ├── transformation-steps.md
│   └── m-code/
│       └── transformation.m
│
├── power-bi/
│   ├── ETL-Pipeline.pbix
│   └── screenshots/
│
├── docs/
│   ├── architecture.md
│   ├── data-dictionary.md
│   └── refresh-process.md
│
├── .gitignore
└── LICENSE
```

> **Note:** The final repository structure may evolve as the project is developed.

---

# 🛠️ Tools & Technologies

| Technology | Purpose |
|---|---|
| **Power BI Desktop** | Data modeling, DAX and visualization |
| **Power Query** | ETL and data transformation |
| **CSV** | Source data |
| **DAX** | Analytical calculations |
| **GitHub** | Version control and project documentation |

---

# 📥 Data Sources

The pipeline is designed around yearly CSV files.

Example:

| File | Data Period |
|---|---|
| `2016.csv` | 2016 |
| `2017.csv` | 2017 |
| `2018.csv` | 2018 |
| `2019.csv` | 2019 |

The files should have a **compatible structure**.

For reliable automated processing, new files should generally maintain:

- Compatible column names
- Compatible data types
- Compatible structure
- Consistent business meaning

If the source schema changes significantly, the Power Query transformation may need to be updated.

---

# ⚙️ ETL Process

## Step 1 — Source Folder

Place the yearly CSV files in a common folder:

```text
Data/
├── 2016.csv
├── 2017.csv
├── 2018.csv
└── 2019.csv
```

---

## Step 2 — Connect Power BI to the Folder

In Power BI Desktop:

```text
Home
  ↓
Get Data
  ↓
Folder
```

Select the folder containing the source files.

Power BI reads the available files from the folder.

---

## Step 3 — Combine Files

Power Query can combine files that follow a compatible structure.

```text
2016.csv ─┐
2017.csv ─┤
2018.csv ─┼──→ Combine Files
2019.csv ─┘
```

This avoids manually importing and transforming every file independently.

---

# 🧹 Data Transformation

The raw data is transformed using Power Query.

Typical transformation steps include:

### 1. Promote Headers

Convert the first row into column headers where required.

### 2. Change Data Types

Example:

```text
Order Date      → Date
Quantity        → Whole Number
Sales Amount    → Decimal Number
Customer Name   → Text
```

### 3. Remove Unnecessary Columns

Remove fields that aren't required for analysis.

### 4. Rename Columns

Use clear, consistent and business-friendly names.

Example:

```text
cust_nm → Customer Name
ord_dt  → Order Date
amt     → Sales Amount
```

### 5. Handle Missing Values

Depending on business requirements:

- Replace values
- Remove records
- Keep nulls
- Apply business rules

### 6. Remove Duplicates

Duplicate records can incorrectly increase:

- Sales
- Orders
- Customer counts
- KPIs

### 7. Standardize Values

Example:

```text
Mumbai
mumbai
MUMBAI
Mumbai 
```

can be standardized into a consistent representation.

### 8. Create Derived Columns

Examples:

- Year
- Month
- Category
- Age Group
- Revenue Band

---

# 🧩 Transformation Flow

```text
Source
  ↓
Promote Headers
  ↓
Change Data Types
  ↓
Remove Unnecessary Columns
  ↓
Rename Columns
  ↓
Handle Missing Values
  ↓
Remove Duplicates
  ↓
Standardize Values
  ↓
Create Derived Columns
  ↓
Filter Records
  ↓
Final Dataset
```

Power Query stores these operations as **Applied Steps**.

This makes the transformation process repeatable during refresh.

---

# 🔎 Data Validation

Before loading the final dataset, validate:

- Row count
- Column count
- Data types
- Null values
- Duplicate records
- Date values
- Numeric values
- Category consistency
- Required fields
- Business rules

Example checks:

```text
Sales Amount < 0
Quantity < 0
Invalid Date
Missing Customer ID
Unexpected Category
```

These should be investigated according to the business context rather than blindly removed.

---

# 📊 Power BI Data Model

After transformation, the data is loaded into Power BI.

A simple model can look like:

```text
                 Cleaned Data
                      │
          ┌───────────┼───────────┐
          ▼           ▼           ▼
        Date      Customer     Product
                      │
                      ▼
                 Power BI Model
                      │
                      ▼
                  Dashboard
```

For a larger analytical implementation, a **star schema** can be introduced:

```text
                 Dim Date
                     │
                     │
Dim Customer ─── Fact Sales ─── Dim Product
                     │
                     │
                Dim Location
```

---

# 📐 Example DAX Measures

The actual measures depend on the dataset.

### Total Sales

```DAX
Total Sales =
SUM(Sales[Sales Amount])
```

### Total Quantity

```DAX
Total Quantity =
SUM(Sales[Quantity])
```

### Total Orders

```DAX
Total Orders =
DISTINCTCOUNT(Sales[Order ID])
```

### Total Customers

```DAX
Total Customers =
DISTINCTCOUNT(Sales[Customer ID])
```

### Average Sales

```DAX
Average Sales =
AVERAGE(Sales[Sales Amount])
```

---

# 📈 Dashboard Layer

The final Power BI dashboard converts the cleaned data into business insights.

### Possible KPI Cards

```text
┌──────────────┐ ┌──────────────┐ ┌──────────────┐
│ Total Sales  │ │ Total Orders │ │  Customers   │
└──────────────┘ └──────────────┘ └──────────────┘
```

### Possible Visualizations

- Sales by Year
- Monthly Sales Trend
- Sales by Category
- Sales by Region
- Top Products
- Customer Analysis
- Year-over-Year Growth

### Recommended Dashboard Flow

```text
              EXECUTIVE SUMMARY

   Total Sales | Orders | Customers | Growth

 ┌────────────────────┐  ┌────────────────────┐
 │    Sales Trend     │  │  Sales by Category │
 └────────────────────┘  └────────────────────┘

 ┌────────────────────┐  ┌────────────────────┐
 │ Regional Analysis  │  │   Top Products     │
 └────────────────────┘  └────────────────────┘
```

---

# 🔄 Refresh & New Data

This is one of the most important concepts in this project.

Suppose the source folder initially contains:

```text
2016.csv
2017.csv
2018.csv
```

Later, a new file arrives:

```text
2019.csv
```

The file is placed into the same source folder:

```text
Data/
├── 2016.csv
├── 2017.csv
├── 2018.csv
└── 2019.csv
```

After refreshing the Power BI data source, the folder-based query can process the new file using the existing transformation logic, **provided the new file follows the expected structure**.

Conceptually:

```text
                  2019.csv
                     │
                     ▼
             Existing ETL Logic
                     │
             ┌───────┴───────┐
             ▼               ▼
           Clean          Transform
             │               │
             └───────┬───────┘
                     ▼
                  Combine
                     │
                     ▼
                Power BI
                     │
                     ▼
              Updated Report
```

### This is the key idea:

> **New data should enter the existing pipeline instead of requiring a completely new manual process.**

---

# ❌ Manual Workflow vs ✅ ETL Workflow

## Manual Workflow

```text
2016 → Clean → Report
2017 → Clean → Report
2018 → Clean → Report
2019 → Clean → Report
```

### Problems

- Repetitive work
- Time-consuming
- Difficult to maintain
- Higher chance of inconsistent transformations
- Difficult to scale

---

## ETL Workflow

```text
                  ┌── 2016
                  ├── 2017
Source Folder ────┼── 2018
                  └── 2019
                       │
                       ▼
                  Power Query
                       │
                       ▼
                Transformation
                       │
                       ▼
                 Combined Data
                       │
                       ▼
                  Power BI
                       │
                       ▼
                   Dashboard
```

### Benefits

- Reusable
- Repeatable
- Consistent
- Easier to maintain
- Easier to refresh
- Supports growing data volumes better than manual processing

---

# 🧪 Data Quality Checklist

Before publishing the report:

- [ ] Correct source files are loaded
- [ ] Required columns exist
- [ ] Column names are consistent
- [ ] Data types are correct
- [ ] Duplicate records are handled
- [ ] Null values are reviewed
- [ ] Date values are valid
- [ ] Numeric values are valid
- [ ] Categories are standardized
- [ ] Row counts are reasonable
- [ ] DAX measures return expected results
- [ ] Dashboard filters work
- [ ] New files can be processed correctly
- [ ] No confidential information is exposed

---

# 🔐 GitHub & Security Best Practices

Do **not** commit sensitive information such as:

```text
Passwords
API Keys
Access Tokens
Connection Strings
Personal Information
Confidential Company Data
```

Use `.gitignore` for files that should not be committed.

Example:

```gitignore
.env
*.key
*.pem
secrets/
credentials/
```

If the `.pbix` file contains confidential or proprietary data, do not publish it publicly.

---

# 📸 Recommended Screenshots

To make the repository easier to understand, include screenshots of:

```text
docs/
└── screenshots/
    ├── architecture.png
    ├── source-files.png
    ├── power-query.png
    ├── applied-steps.png
    ├── data-model.png
    └── dashboard.png
```

Recommended README presentation:

```text
Project Overview
       ↓
Architecture
       ↓
Dataset
       ↓
ETL Process
       ↓
Power Query
       ↓
Data Model
       ↓
Dashboard
       ↓
Refresh Process
       ↓
Learning Outcomes
```

---

# 🎓 Learning Outcomes

After completing this project, a learner should understand:

### Data Analytics

- Data cleaning
- Data transformation
- Data modeling
- Power BI
- DAX
- Dashboard development

### Data Engineering

- ETL
- Data pipelines
- Source ingestion
- Transformation logic
- Data validation
- Repeatable workflows
- Refresh-based processing
- Pipeline thinking

### Power Query

- Folder ingestion
- Combine Files
- Applied Steps
- Data type management
- Data cleaning
- Reusable transformation logic

---

# 🚀 How This Project Can Scale

The current architecture:

```text
CSV
 ↓
Power Query
 ↓
Power BI
```

can evolve into a modern Data Engineering architecture:

```text
Multiple Sources
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
      │
      ├──────────────→ Power BI
      │
      └──────────────→ AI Applications
```

A future cloud implementation could look like:

```text
CSV / Excel / API / SQL
          │
          ▼
   Azure Data Factory
          │
          ▼
   Azure Data Lake
          │
          ▼
   Databricks / Spark
          │
          ▼
   Data Warehouse
       │       │
       ▼       ▼
   Power BI    AI
```

This project therefore acts as a bridge from:

> **Data Analytics → Data Engineering → AI Engineering**

---

# 🔮 Future Enhancements

## Version 2 — Advanced Power BI

- Star schema
- Advanced DAX
- Incremental refresh
- Data validation
- Advanced data modeling

## Version 3 — Cloud Data Engineering

- Azure Data Factory
- Azure Data Lake Storage
- Azure SQL
- Cloud-based ingestion
- Automated pipelines

## Version 4 — Big Data

- Apache Spark
- PySpark
- Databricks
- Delta Lake
- Medallion Architecture

## Version 5 — AI

- Natural language analytics
- LLM-powered insights
- RAG over business documentation
- AI Data Analyst
- AI Agents

---

# 🧠 Key Concepts Demonstrated

| Concept | Status |
|---|:---:|
| Data Extraction | ✅ |
| ETL | ✅ |
| Data Cleaning | ✅ |
| Data Transformation | ✅ |
| Data Combination | ✅ |
| Data Validation | ✅ |
| Data Modeling | ✅ |
| Power Query | ✅ |
| Power BI | ✅ |
| DAX | ✅ |
| Dashboarding | ✅ |
| Refreshable Pipeline | ✅ |
| GitHub Documentation | ✅ |

---

# 🎤 Project Explanation

A simple way to explain this project in an interview or webinar:

> **"Instead of treating every year's data as a separate report, I built a repeatable ETL pipeline using Power Query. The pipeline extracts multiple CSV files, applies standardized transformation steps, combines the data, and loads the cleaned dataset into Power BI. When a new compatible yearly file arrives, the same transformation logic can be applied during refresh, reducing repetitive manual work."**

---

# 💡 Key Takeaway

```text
RAW DATA
   ↓
EXTRACT
   ↓
TRANSFORM
   ↓
VALIDATE
   ↓
LOAD
   ↓
DATA MODEL
   ↓
POWER BI
   ↓
DASHBOARD
   ↓
BUSINESS INSIGHTS
```

> **ETL is not just about moving data. It is about building a repeatable process that turns raw data into reliable, analysis-ready data.**

---

## 👨‍💻 Project Information

**Project:** ETL Pipeline Using Power BI & Power Query  
**Domain:** Data Analytics / Business Intelligence / Data Engineering  
**Primary Tool:** Microsoft Power BI  
**ETL Tool:** Power Query  
**Source:** Multi-year CSV files  
**Output:** Analytical Power BI Dataset & Dashboard

---

## ⭐ DataWithCS

This project is part of practical learning resources focused on helping Data Analysts understand the transition from **Data Analytics to Data Engineering and AI**.

**Learn → Build → Document → Scale**

