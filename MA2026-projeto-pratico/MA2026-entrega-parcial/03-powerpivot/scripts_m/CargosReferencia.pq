//CargosReferencia

let
Fonte = cad_Etapa2{[Item = "CargosReferencia", Kind = "Table"]}[Data],
Tipos = Table.TransformColumnTypes(Fonte, {
{"id_cargo", Int64.Type}, {"cargo_referencia", type text}, {"cbo", type text},
{"area", type text}, {"salario_p25", Currency.Type}, {"salario_medio", Currency.Type}, 
{"salario_p75", Currency.Type}, {"salario_teto", Currency.Type}, {"fonte", type text},
{"data_referencia", type date}, {"indice_medio_vs_brasil", type number}, 
{"indice_p25_vs_brasil", type number}})
in
    Tipos