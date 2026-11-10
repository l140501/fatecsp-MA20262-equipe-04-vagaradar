//Cidades

let
Fonte = cad_Etapa2{[Item = "Cidades", Kind = "Table"]}[Data],
TudoTexto = Table.TransformColumnTypes(Fonte,

List.Transform(Table.ColumnNames(Fonte), each {_, type text}))
in
TudoTexto