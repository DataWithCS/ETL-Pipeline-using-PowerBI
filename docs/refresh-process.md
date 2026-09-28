# Refresh Process

## Purpose

This document explains how the ETL pipeline processes existing data and incorporates new yearly files.

The pipeline uses a **folder-based Power Query source**, which allows multiple compatible files to be processed using the same transformation logic.

---

# 1. Initial Setup

Place the source CSV files in the configured source folder.

Example:

```text
data/raw/
├── 2016.csv
├── 2017.csv
├── 2018.csv
└── 2019.csv
```

Open the Power BI `.pbix` file and verify that the folder source is correctly configured.

---

# 2. Refresh Existing Data

In Power BI Desktop:

```text
Home
  ↓
Refresh
```

Power BI requests the latest data from the configured source.

The folder query identifies the available files and sends them through the Power Query transformation steps.

---

# 3. What Happens During Refresh?

Conceptually:

```text
Source Folder
     ↓
Identify Files
     ↓
Read CSV Content
     ↓
Apply Transformation Steps
     ↓
Combine Data
     ↓
Load Model
     ↓
Recalculate DAX
     ↓
Update Visuals
```

Power Query reapplies the recorded transformation steps during refresh.

---

# 4. Adding a New Year

Suppose the pipeline currently contains:

```text
2016.csv
2017.csv
2018.csv
2019.csv
```

A new file arrives:

```text
2020.csv
```

Place it in the same source folder:

```text
data/raw/
├── 2016.csv
├── 2017.csv
├── 2018.csv
├── 2019.csv
└── 2020.csv
```

Then refresh the Power BI report.

If the new file follows the expected schema, the folder-based query can process it using the existing transformation logic.

---

# 5. New Data Flow

```text
                  NEW FILE
                  2020.csv
                     │
                     ▼
                Source Folder
                     │
                     ▼
                Power Query
                     │
          ┌──────────┼──────────┐
          ▼          ▼          ▼
        Clean     Transform   Validate
          │          │          │
          └──────────┼──────────┘
                     ▼
                   Append
                     │
                     ▼
               Power BI Model
                     │
                     ▼
                 Dashboard
```

---

# 6. Important Requirement — Schema Compatibility

The new file should generally contain:

- Compatible column names
- Compatible data types
- Compatible structure
- Consistent business meaning

For example, if existing files contain:

```text
Customer
Date
Product
Sales
```

and the new file suddenly contains:

```text
Customer Name
Transaction Date
Product Name
Revenue
```

the transformation logic may need to be updated.

---

# 7. Refresh Validation Checklist

After adding new data, verify:

- [ ] New file exists in the source folder
- [ ] File follows the expected schema
- [ ] Power Query successfully reads the file
- [ ] No query errors are present
- [ ] Row count increased as expected
- [ ] New year appears in the data
- [ ] Important measures changed as expected
- [ ] Dashboard visuals reflect the new data
- [ ] Filters/slicers include the new period
- [ ] No unexpected duplicates were introduced

---

# 8. Troubleshooting

## Problem: New File Is Not Appearing

Check:

1. Is the file in the correct source folder?
2. Does the file extension match the folder query filter?
3. Does the file follow the expected schema?
4. Is the file being excluded by a filter in Power Query?

---

## Problem: Column Error

Possible causes:

- Column renamed
- Column removed
- New column structure
- Different headers
- Different delimiter

Review the Power Query Applied Steps.

---

## Problem: Data Type Error

Example:

```text
Expected Number
Received Text
```

Check the source data and the `Changed Type` step.

---

## Problem: Duplicate Records

Check whether:

- The source contains duplicates
- Multiple files overlap
- The same file was copied into the source folder
- The transformation logic needs a uniqueness rule

---

# 9. Refresh in Power BI Service

If the report is published to Power BI Service, the refresh process depends on where the source files are hosted.

For local/on-premises files, an appropriate gateway or supported architecture may be required.

For cloud-based sources, configure the relevant connection and scheduled refresh settings.

The exact configuration depends on the source environment.

---

# 10. Production Considerations

A production-grade pipeline should additionally consider:

- Authentication
- Data source credentials
- Gateway configuration
- Scheduled refresh
- Error monitoring
- Data quality checks
- Incremental refresh
- Row-level security where required
- Source schema changes
- Documentation
- Ownership and maintenance

---

# 11. Refresh Architecture

```text
          Source Files
               │
               ▼
        Power Query Source
               │
               ▼
       Transformation Steps
               │
               ▼
        Combined Dataset
               │
               ▼
         Power BI Model
               │
               ▼
            Measures
               │
               ▼
           Dashboard
```

---

# 12. Core Principle

The purpose of the refreshable pipeline is:

> **New compatible data should flow through an existing transformation process instead of requiring the entire ETL workflow to be rebuilt manually.**

This is the fundamental difference between a manual reporting process and a repeatable data pipeline.
