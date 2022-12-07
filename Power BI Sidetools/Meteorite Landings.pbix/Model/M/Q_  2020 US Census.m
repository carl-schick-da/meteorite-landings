let
    Source = Csv.Document(Web.Contents("https://www2.census.gov/programs-surveys/popest/datasets/2010-2020/counties/totals/co-est2020.csv"),[Delimiter=",", Columns=21, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"SUMLEV", Int64.Type}, {"REGION", Int64.Type}, {"DIVISION", Int64.Type}, {"STATE", Int64.Type}, {"COUNTY", Int64.Type}, {"STNAME", type text}, {"CTYNAME", type text}, {"CENSUS2010POP", type text}, {"ESTIMATESBASE2010", Int64.Type}, {"POPESTIMATE2010", Int64.Type}, {"POPESTIMATE2011", Int64.Type}, {"POPESTIMATE2012", Int64.Type}, {"POPESTIMATE2013", Int64.Type}, {"POPESTIMATE2014", Int64.Type}, {"POPESTIMATE2015", Int64.Type}, {"POPESTIMATE2016", Int64.Type}, {"POPESTIMATE2017", Int64.Type}, {"POPESTIMATE2018", Int64.Type}, {"POPESTIMATE2019", Int64.Type}, {"POPESTIMATE042020", Int64.Type}, {"POPESTIMATE2020", Int64.Type}}),
    #"Filtered Rows" = Table.SelectRows(#"Changed Type", each ([SUMLEV] = 50)),
    #"Removed Other Columns" = Table.SelectColumns(#"Filtered Rows",{"STNAME", "CTYNAME", "POPESTIMATE2020"}),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Other Columns",{{"STNAME", "state"}, {"CTYNAME", "county"}, {"POPESTIMATE2020", "population"}})
in
    #"Renamed Columns"