//CargosVinculados

let
Fonte = cad_Etapa2{[Item = "CargosVinculados", Kind = "Table"]}[Data],
Tipos = Table.TransformColumnTypes(Fonte, {
{"id_vaga", Int64.Type}, {"Cargos", type text}, {"id_cargo", Int64.Type}})
in
Tipos