# Power Query — Transformation Steps

## Purpose

This folder-based ETL template ingests yearly CSV files (for example, `2016.csv`, `2017.csv`, and `2018.csv`) into a single Power BI query. When a compatible `2019.csv` is added to the same folder, a **refresh** re-runs the transformation and includes it. This is **not** real-time streaming or automatic refresh merely because a file was added.

> **Template status:** The actual CSV columns have not been supplied, so no business-specific cleaning rules or data types have been assumed. Customize and validate the query against your real files.

## Files

- `m-code/transformation.m` — runnable Power Query M template.
- `transformation-steps.md` — this implementation and validation guide.

## Prerequisites

- Power BI Desktop.
- A local folder containing the CSV files, e.g. `data/raw/2016.csv`, `data/raw/2017.csv`, `data/raw/2018.csv`.
- Consistent CSV delimiter and encoding; the template assumes **comma-delimited UTF-8** with headers in the first row.
- Compatible business schema across files. The template combines columns by name, so mismatched headers can silently create extra columns and nulls; review them before publishing.

## Configure and run

1. In Power BI Desktop, select **Home → Transform data → Power Query Editor**.
2. Choose **New Source → Blank Query** (or create a blank query from the editor).
3. Open **Advanced Editor**, replace its contents with `m-code/transformation.m`, and select **Done**.
4. Edit `FolderPath` to the **absolute path on the machine performing the refresh**, for example `C:\\Projects\\ETL-Pipeline-PowerBI\\data\\raw`. Power Query does not automatically resolve a GitHub-relative `data/raw` path.
5. If your CSV uses a different separator or encoding, update `Delimiter` and `Encoding` in `Csv.Document`.
6. Review the preview, source filenames, row counts, headers, and `Source Year` values.
7. Add **explicit data types** for actual business fields in the query (see below).
8. Apply only cleaning rules justified by the dataset; then **Close & Apply** to load the table into Power BI.

## What the provided M code does

| Stage | Implementation | Result |
|---|---|---|
| Extract | `Folder.Files(FolderPath)` | Lists files in the folder (including subfolders). |
| Filter | `.csv`, not hidden, not temporary | Limits inputs to intended CSV files. |
| Parse | `Csv.Document` | Reads each file using configured CSV settings. |
| Headers | `Table.PromoteHeaders` | Uses first row as column names. |
| Header cleanup | `Table.TransformColumnNames` | Trims whitespace from header names. |
| Lineage | `Source File` | Records the filename for each row. |
| Year | `Source Year` | Derives a year from filenames such as `2018.csv`; otherwise null. |
| Combine | `Table.Combine` | Appends parsed rows, aligning columns by name. |
| Load | `Close & Apply` | Loads the resulting table to the Power BI model. |

**Folder scope:** `Folder.Files` also includes subfolders. Keep unrelated CSV files out of this folder, or add a folder-path filter if needed.

## Customize the transformation

After `Combined`, insert transformations appropriate for **your actual columns**. For example, *only if* your CSV really contains `Order Date` and `Sales Amount`:

```powerquery
Typed = Table.TransformColumnTypes(
    Combined,
    {{"Order Date", type date}, {"Sales Amount", type number}},
    "en-US"
),
Output = Typed
```

For locale-sensitive dates and decimals, use the correct locale for your source. Do not assume every file uses the same date convention without checking.

### Cleaning decisions to document

- **Missing values:** Which columns are required? Are blanks meaningful? Avoid indiscriminately replacing nulls with zero.
- **Duplicates:** Define the business key before removing any rows. Identical-looking records can be valid separate transactions.
- **Text standardization:** Trim or normalize known categories only when their meaning is established.
- **Invalid values:** Identify rejected or suspect rows, and record how they are handled.
- **Schema changes:** Check for missing/extra columns, changed names, and incompatible data types.

The template deliberately **does not** delete rows, impute missing values, or infer business column types.

## Test the new-file refresh

1. Start with `2016.csv`, `2017.csv`, and `2018.csv` in `data/raw/`.
2. Refresh the query and record the row count and distinct `Source File` values.
3. Add a compatible `2019.csv` to the same folder.
4. In Power BI Desktop, choose **Refresh**.
5. Confirm `2019.csv` appears in `Source File`, `Source Year` is `2019`, and the row count changes as expected.
6. Verify that prior-year totals have not unexpectedly changed and that the new rows pass data-quality checks.

**Important:** In the Power BI Service, refresh requires a reachable source path and, for a local/on-premises folder, typically an appropriately configured **on-premises data gateway**. Publishing a PBIX or uploading a new CSV to GitHub does not by itself refresh the published semantic model. Scheduled refresh must be configured separately.

## Troubleshooting

| Symptom | Check |
|---|---|
| `No CSV files found` | Confirm `FolderPath`, file extensions, and folder permissions. |
| Unexpected null columns | Compare CSV header spelling, spaces, and schema across years. |
| Year is null | File must be named like `2018.csv`; customize extraction for other naming conventions. |
| Dates or numbers look wrong | Configure explicit data types and the correct locale. |
| New file not included | Confirm the file is in the source folder and refresh was run. |
| Service refresh fails | Check gateway, credentials, folder availability, and scheduled-refresh configuration. |

## Architecture

```text
2016.csv ─┐
2017.csv ─┼──► Folder.Files ──► Parse/headers ──► Combine
2018.csv ─┘                                      │
2019.csv ──► (included on next refresh)           ▼
                                      Validate / business cleanup
                                                 │
                                                 ▼
                                         Power BI data model
                                                 │
                                                 ▼
                                              Dashboard
```

## Next steps

Once the actual dataset is available, replace example column references with the real schema, document a data dictionary and business rules, add validation checks, and record dashboard measures separately. The repository should describe transformations **actually implemented**, not planned features as completed.
