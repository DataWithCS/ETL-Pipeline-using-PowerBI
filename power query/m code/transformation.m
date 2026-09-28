// Power Query M — folder-based ingestion of yearly CSV files.
// Replace FolderPath with the absolute path to your local data/raw folder.
// This is a reusable template: adjust delimiter, encoding, and column types
// to match your actual CSV files before using it in production.
let
    FolderPath = "C:\\YOUR_PROJECT\\data\\raw",
    Source = Folder.Files(FolderPath),
    CSVFiles = Table.SelectRows(
        Source,
        each Text.Lower([Extension]) = ".csv"
            and not Text.StartsWith([Name], "~$")
            and [Attributes]?[Hidden]? <> true
    ),
    CheckFiles = if Table.RowCount(CSVFiles) = 0
        then error "No CSV files found in the configured source folder."
        else CSVFiles,
    ParseCSV = (fileContent as binary, fileName as text) as table =>
        let
            Parsed = Csv.Document(
                fileContent,
                [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]
            ),
            Headers = Table.PromoteHeaders(Parsed, [PromoteAllScalars = true]),
            TrimmedHeaders = Table.TransformColumnNames(Headers, each Text.Trim(_)),
            WithSourceFile = Table.AddColumn(
                TrimmedHeaders, "Source File", each fileName, type text
            ),
            YearText = Text.BeforeDelimiter(fileName, ".", {0, RelativePosition.FromEnd}),
            ParsedYear = try Number.FromText(YearText) otherwise null,
            WithSourceYear = Table.AddColumn(
                WithSourceFile, "Source Year", each ParsedYear, Int64.Type
            )
        in
            WithSourceYear,
    ParsedTables = Table.AddColumn(
        CheckFiles, "Parsed Data", each ParseCSV([Content], [Name]), type table
    ),
    Combined = Table.Combine(ParsedTables[Parsed Data]),
    // IMPORTANT: Explicitly set your business column types here after
    // inspecting the source schema. Example:
    // Typed = Table.TransformColumnTypes(Combined,
    //     {{"Order Date", type date}, {"Sales Amount", type number}}, "en-US"),
    Output = Combined
in
    Output

