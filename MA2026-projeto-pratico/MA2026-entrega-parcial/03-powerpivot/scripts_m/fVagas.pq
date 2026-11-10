//fVagas

let
Fonte = cad_Etapa2{[Item = "fVagas", Kind = "Table"]}[Data],
Tipos = Table.TransformColumnTypes(Fonte, {
{"ID_Vaga", Int64.Type}, {"Titulo_Vaga", type text}, {"area", type text},
{"Empresa", type text}, {"Modelo_Trabalho", type text},
{"Cidade", type text}, {"UF", type text}, {"Data_Publicacao", type date},
{"Dia_SemanaPublicacao", type text}, {"salario_medio", Currency.Type},
{"Indice_medio_vs_brasil_ajustado", type number},
{"Arquivo_Origem", type text}, {"Linha_Origem", Int64.Type}})
in
Tipos