let
    Source = Table.NestedJoin(#"Raw Meteorite Data", {"geolocation"}, #"Geolocation Data", {"geolocation"}, "Geolocation Data", JoinKind.LeftOuter),
    #"Expanded Geolocation Data" = Table.ExpandTableColumn(Source, "Geolocation Data", {"country", "admin1", "admin2"}, {"country", "admin1", "admin2"}),
    #"Removed Columns" = Table.RemoveColumns(#"Expanded Geolocation Data",{"Single Group", "geolocation"})
in
    #"Removed Columns"