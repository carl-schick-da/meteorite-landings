let
    Source = (locations as text) => let
    #"Get Locations Parameter" = if locations = null then "" else locations,
    #"Extract Script" = File.Contents("R:\OneDrive\Documents\GitHub\meteorite-landings\meteorite_landings_pbi.py"),
    #"Prepend Parameter" = "pbi_args = [" & #"Get Locations Parameter" & "]" & "#(lf)#(lf)" & Text.FromBinary(#"Extract Script"),
    #"Execute Script" = Python.Execute(#"Prepend Parameter"),
    #"Retrieve Dataframe" = #"Execute Script"{[Name="location_info"]}[Value]
in
    #"Retrieve Dataframe"
in
    Source