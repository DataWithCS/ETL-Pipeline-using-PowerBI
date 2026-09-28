# Data Dictionary

## Purpose

This document defines the expected structure and meaning of the data used by the ETL pipeline.

Because the pipeline is designed to process multiple yearly CSV files, the source files should maintain a compatible schema.

> **Important:** The exact columns in this document should be updated to match the actual dataset used in the repository.

---

## Source Files

| File | Description |
|---|---|
| `2016.csv` | Source data for 2016 |
| `2017.csv` | Source data for 2017 |
| `2018.csv` | Source data for 2018 |
| `2019.csv` | Source data for 2019 |

---

## Schema Rules

For the folder-combination approach to work reliably, yearly files should generally have:

- The same column names
- Compatible data types
- Compatible column structure
- The same business meaning for corresponding columns

If a new file contains a different schema, the Power Query transformation may require modification.

---

## Generic Data Dictionary Template

Replace the example fields below with the actual fields from the dataset.

| Column | Data Type | Description | Example | Transformation |
|---|---|---|---|---|
| `ID` | Whole Number/Text | Unique record identifier | `10001` | Type validation |
| `Date` | Date | Date associated with the record | `2019-01-15` | Date conversion |
| `Customer` | Text | Customer name or identifier | `ABC Ltd` | Trim/Clean |
| `Category` | Text | Business category | `Technology` | Standardization |
| `Location` | Text | Geographic location | `Mumbai` | Trim/standardize |
| `Quantity` | Whole Number | Number of units | `25` | Numeric validation |
| `Amount` | Decimal | Monetary/business amount | `12500.50` | Decimal conversion |
| `Year` | Whole Number | Source/reporting year | `2019` | Derived from file/source |

---

## Data Type Guidelines

### Text

Use for:

- Names
- Categories
- Locations
- Descriptions
- IDs that contain letters

### Whole Number

Use for:

- Counts
- Quantities
- Integer identifiers where appropriate
- Year

### Decimal Number

Use for:

- Revenue
- Sales
- Costs
- Percentages when stored numerically
- Measurements

### Date

Use for:

- Transaction dates
- Order dates
- Joining dates
- Reporting dates

---

## Data Quality Rules

The following checks should be performed during transformation:

### Required Fields

Important business fields should not unexpectedly contain null values.

### Unique Identifier

If a unique record ID exists, duplicates should be investigated.

### Dates

Dates should be valid and use a consistent interpretation.

### Numeric Fields

Numeric fields should contain valid numeric values.

### Categories

Categorical values should use consistent naming.

Example:

```text
Mumbai
mumbai
MUMBAI
Mumbai 
```

should be reviewed and standardized where they represent the same business value.

---

## Source vs Transformed Data

### Raw Data

Stored under:

```text
data/raw/
```

Raw files should not be manually modified as part of the normal pipeline.

### Transformed Data

Created by Power Query during the ETL process.

The transformation layer is responsible for:

```text
Raw Data
   ↓
Cleaning
   ↓
Standardization
   ↓
Validation
   ↓
Combined Dataset
```

---

## Schema Change Policy

If a new yearly file introduces:

- New columns
- Removed columns
- Renamed columns
- Different data types
- Different business definitions

the pipeline should be reviewed before relying on the refreshed output.

A schema change should be documented rather than silently ignored.
