//Rejeitados 

let
    Origem = Vagas_Bruto,
    Mescla = Table.NestedJoin(Origem, {"Arquivo_Origem", "Linha_Origem"}, fVagas, {"Arquivo_Origem", "Linha_Origem"}, "fVagas", JoinKind.LeftAnti),
    SoRejeitadas = Table.RemoveColumns(Mescla,{"fVagas"}),
    Cidades = List.Buffer(DeParaCidades[Chave_Cidades]),
    Id_cargo = List.Buffer(CargosVinculados[Chave_Id_Cargo]),
    ENumero = (v) => v = null or (try (Number.From(v, "pt-BR") is number) otherwise false),
    Chave = (v) => if v = null then null else Text.Upper(Text.Trim(Text.From(v))),
    Diagnostico = (r as record) as text =>
        let
            Valores = List.RemoveMatchingItems(Record.FieldValues(Record.SelectFields(r, ColunasAlvo, MissingField.UseNull)), {"", null}),
            Data = fnData(Record.FieldOrDefault(r, "Data_Publicacao", null)),
            IdVaga = Record.FieldOrDefault(r, "ID_Vaga", null),
            TituloVaga = Record.FieldOrDefault(r, "Titulo_Vaga", null),
            SalarioMedio = Record.FieldOrDefault(r, "salario_medio", null),
            IndiceMedio = Record.FieldOrDefault(r, "indice_medio_vs_brasil", null)
        in
            if List.IsEmpty(Valores) then "Linha em branco"
            else if IdVaga = null or Text.Trim(Text.From(IdVaga)) = "" then "ID_Vaga vazio"
            else if TituloVaga = null or Text.Trim(Text.From(TituloVaga)) = "" then "Titulo_Vaga vazio"
            else if Data = null then "Data inválida"
            else if Data < #date(2026, 1, 1) or Data > #date(2026, 12, 31) then "Data fora do período"
            else if SalarioMedio = null or IndiceMedio = null then "Cargo não mapeado no De-Para"
            else "Linha duplicada",

    
    ComMotivo = Table.AddColumn(SoRejeitadas, "Motivo", each Diagnostico(_), type text),
    Ordenada = Table.Sort(ComMotivo, {{"Arquivo_Origem", Order.Ascending}, {"Linha_Origem", Order.Ascending}})
in
    Ordenada