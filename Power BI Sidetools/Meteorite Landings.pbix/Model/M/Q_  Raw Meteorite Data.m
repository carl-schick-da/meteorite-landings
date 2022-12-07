let
    App_Token = Text.FromBinary(File.Contents("R:\OneDrive\Documents\GitHub\meteorite_landings\.apptoken")),
    URL_for_API = "http://data.nasa.gov/resource/gh4g-9sfh.csv?$limit=50000&$$app_token=" & App_Token,
    Source = Csv.Document(Web.Contents(URL_for_API),[Delimiter=",", Columns=10, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"name", type text}, {"id", Int64.Type}, {"nametype", type text}, {"recclass", type text}, {"mass", type number}, {"fall", type text}, {"year", type datetime}, {"reclat", type number}, {"reclong", type number}, {"geolocation", type text}}),
    #"Extracted Year" = Table.TransformColumns(#"Changed Type",{{"year", Date.Year, Int64.Type}}),
    #"Filtered Rows" = Table.SelectRows(#"Extracted Year", each [reclat] <> null and [reclat] <> ""),
    #"Filtered Rows1" = Table.SelectRows(#"Filtered Rows", each [reclat] <> 0 and [reclat] >= -90 and [reclat] <= 90),
    #"Filtered Rows2" = Table.SelectRows(#"Filtered Rows1", each [reclong] <> 0 and [reclong] >= -180 and [reclong] <= 180),
    #"Reordered Columns" = Table.ReorderColumns(#"Filtered Rows2",{"id", "name", "nametype", "recclass", "mass", "fall", "year", "reclat", "reclong"}),
    #"Renamed Columns" = Table.RenameColumns(#"Reordered Columns",{{"nametype", "type"}, {"recclass", "class"}, {"reclat", "latitude"}, {"reclong", "longitude"}}),
    #"Added Custom" = Table.AddColumn(#"Renamed Columns", "Single Group", each 1),
    #"Reordered Columns1" = Table.ReorderColumns(#"Added Custom",{"Single Group", "id", "name", "type", "class", "mass", "fall", "year", "latitude", "longitude", "geolocation"})
in
    #"Reordered Columns1"