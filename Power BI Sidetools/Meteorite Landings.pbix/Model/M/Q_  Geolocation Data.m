let
    Source = Table.Group(#"Raw Meteorite Data", {"Single Group"}, {{"All Locations", each Text.Combine([geolocation], ","), type text}}),
    #"Concat Locations" = Source[All Locations],
    #"All Locations" = List.First(#"Concat Locations"),
    #"Convert to Table" = Table.FromValue(#"All Locations"),
    #"Renamed Columns" = Table.RenameColumns(#"Convert to Table",{{"Value", "Locations"}}),
    #"Invoked Custom Function" = Table.AddColumn(#"Renamed Columns", "Location Data", each fnGetLocationData([Locations])),
    #"Location Data" = #"Invoked Custom Function"{0}[Location Data],
    #"Changed Type" = Table.TransformColumnTypes(#"Location Data",{{"cc", type text}, {"admin1", type text}, {"admin2", type text}}),
    #"Merged Queries" = Table.NestedJoin(#"Changed Type", {"cc"}, #"Country Codes", {"Alpha-2 code"}, "Country Codes", JoinKind.LeftOuter),
    #"Expanded Country Codes" = Table.ExpandTableColumn(#"Merged Queries", "Country Codes", {"Country"}, {"Country"}),
    #"Renamed Columns1" = Table.RenameColumns(#"Expanded Country Codes",{{"Country", "country"}}),
    #"Reordered Columns" = Table.ReorderColumns(#"Renamed Columns1",{"geolocation", "cc", "country", "admin1", "admin2"}),
    #"Removed Columns" = Table.RemoveColumns(#"Reordered Columns",{"cc"})
in
    #"Removed Columns"