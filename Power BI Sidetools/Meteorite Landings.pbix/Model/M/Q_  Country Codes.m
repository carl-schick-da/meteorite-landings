let
    Source = Web.BrowserContents("https://gist.github.com/tadast/8827699#file-countries_codes_and_coordinates-csv"),
    #"Extracted Table From Html" = Html.Table(Source, {{"Column1", "TABLE.js-csv-data.csv-data.js-file-line-container > * > TR > :nth-child(1)"}, {"Column2", "TABLE.js-csv-data.csv-data.js-file-line-container > * > TR > :nth-child(2)"}, {"Column3", "TABLE.js-csv-data.csv-data.js-file-line-container > * > TR > :nth-child(3)"}, {"Column4", "TABLE.js-csv-data.csv-data.js-file-line-container > * > TR > :nth-child(4)"}, {"Column5", "TABLE.js-csv-data.csv-data.js-file-line-container > * > TR > :nth-child(5)"}, {"Column6", "TABLE.js-csv-data.csv-data.js-file-line-container > * > TR > :nth-child(6)"}, {"Column7", "TABLE.js-csv-data.csv-data.js-file-line-container > * > TR > :nth-child(7)"}}, [RowSelector="TABLE.js-csv-data.csv-data.js-file-line-container > * > TR"]),
    #"Promoted Headers" = Table.PromoteHeaders(#"Extracted Table From Html", [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"", type text}, {"Country", type text}, {"Alpha-2 code", type text}, {"Alpha-3 code", type text}, {"Numeric code", Int64.Type}, {"Latitude (average)", type number}, {"Longitude (average)", type number}}),
    #"Removed Columns" = Table.RemoveColumns(#"Changed Type",{""})
in
    #"Removed Columns"