//fVagas - Corresponde ao fVendas

let
    Origem = Vagas_Bruto,
    SemLinhasEmBranco = Table.SelectRows(Origem, each not List.IsEmpty(
List.RemoveMatchingItems(Record.FieldValues(Record.SelectFields(_, ColunasAlvo)), {"", null
}))),
    SemIDVagaVazio = Table.SelectRows(SemLinhasEmBranco, each [ID_Vaga] <> null and Text.Trim(Text.From([ID_Vaga])) <> ""),
    SemTituloVazio = Table.SelectRows(SemIDVagaVazio, each [Titulo_Vaga] <> null and Text.Trim(Text.From([Titulo_Vaga])) <> ""),
    EmpresaTratada = Table.ReplaceValue(SemTituloVazio, null, "Não informada", Replacer.ReplaceValue, {"Empresa"}),
    LocalizacaoTratada = Table.ReplaceValue(EmpresaTratada, null, "Não informada", Replacer.ReplaceValue, {"Localizacao"}),
    ModeloTrabalhoTratado = Table.ReplaceValue(LocalizacaoTratada, null, "Não informado", Replacer.ReplaceValue, {"Modelo_Trabalho"}),
    LinkTratado = Table.ReplaceValue(ModeloTrabalhoTratado, null, "Sem link", Replacer.ReplaceValue, {"Link"}),
    DataTratada = Table.ReplaceValue(LinkTratado, null, "Não informada", Replacer.ReplaceValue, {"Data_Publicacao"}),
    SemDuplicatasExatas = Table.Distinct(DataTratada, {"ID_Vaga", "Titulo_Vaga", "Empresa", "Localizacao"}),
    DataConvertida = Table.TransformColumns(SemDuplicatasExatas, {
        {"Data_Publicacao", fnData, type nullable date}}),
    SemDataInvalida = Table.SelectRows(DataConvertida, each [Data_Publicacao] <> null),
    NoPeriodo = Table.SelectRows(SemDataInvalida, each 
        [Data_Publicacao] >= #date(2026, 1, 1) and [Data_Publicacao] <= #date(2026, 12, 31)),
    TiposPtBR = Table.TransformColumnTypes(NoPeriodo,{{"ID_Vaga", type text }, {"Titulo_Vaga", type text}, {"Empresa", type text}, {"Localizacao", type text}, {"Modelo_Trabalho", type text}, {"Link", type text}, {"Data_Publicacao", type date}, {"Linha_Origem", Int64.Type}}),
    SemErrosDeTipo = Table.RemoveRowsWithErrors(TiposPtBR, {"ID_Vaga", "Titulo_Vaga", "Empresa", "Localizacao", "Modelo_Trabalho", "Link", "Data_Publicacao", "Linha_Origem"}),
    QtdEValorValidos = Table.SelectRows(SemErrosDeTipo, each [ID_Vaga] <> null and Text.Trim([ID_Vaga]) <> "" and [Titulo_Vaga] <> null and Text.Trim([Titulo_Vaga]) <> ""),
    TextosAparados = Table.TransformColumns(QtdEValorValidos,{{"Titulo_Vaga", Text.Trim, type text}, {"Empresa", Text.Trim, type text}, {"Localizacao", Text.Trim, type text}, {"Modelo_Trabalho", Text.Trim, type text}, {"Link", Text.Trim, type text}}),
    PrimeiraMaiuscula = Table.TransformColumns(TextosAparados,{{"Titulo_Vaga", Text.Proper, type text}, {"Localizacao", Text.Proper, type text}, {"Modelo_Trabalho", Text.Proper, type text}}),
    ModeloTrabalhoOficial = Table.TransformColumns(PrimeiraMaiuscula, {
        {"Modelo_Trabalho", each fnValorOficial(_, {"On-Site", "Remote", "Hybrid", "Não Informado"}), type text}
    }),
    Chave_Cidade = Table.AddColumn(ModeloTrabalhoOficial, "Chave_Cidade", each Text.Upper([Localizacao])),
    MesclaCidade = Table.NestedJoin(Chave_Cidade, {"Chave_Cidade"}, DeParaCidades, {"Chave_Local"}, "DeParaCidades", JoinKind.LeftOuter),
    ExpandeCIdade = Table.ExpandTableColumn(MesclaCidade, "DeParaCidades", {"Cidade", "UF"}, {"Cidade", "UF"}),
    Chave_Cargo = Table.AddColumn(ExpandeCIdade, "Chave_Cargo", each Text.Upper([Titulo_Vaga])),
    MesclaCargo = Table.NestedJoin(Chave_Cargo, {"Chave_Cargo"}, CargosVinculados, {"Chave_Cargo"}, "CargosVinculados", JoinKind.LeftOuter),
    ExpandeCargo = Table.ExpandTableColumn(MesclaCargo, "CargosVinculados", {"id_cargo"}, {"id_cargo"}),
    RenomearIDcargo = Table.RenameColumns(ExpandeCargo,{{"id_cargo", "Id_cargo"}}),
    Chave_IDCargo = Table.AddColumn(RenomearIDcargo, "Chave_ID_Cargo", each [Id_cargo]),
    MesclaIDCargo = Table.NestedJoin(Chave_IDCargo, {"Chave_ID_Cargo"}, CargosReferencia, {"id_cargo"}, "CargosReferencia", JoinKind.LeftOuter),
    ExpandeSalario = Table.ExpandTableColumn(MesclaIDCargo, "CargosReferencia", {"area", "salario_medio", "indice_medio_vs_brasil"}, {"area", "salario_medio", "indice_medio_vs_brasil"}),
    ComSalario = Table.SelectRows(ExpandeSalario, each ([indice_medio_vs_brasil] <> null)),
    OrdemOriginal = Table.Buffer(Table.Sort(ComSalario, {{"Arquivo_Origem", Order.Ascending}, {"Linha_Origem", Order.Ascending}})),
    SemDuplicatas = Table.Distinct(OrdemOriginal, {"ID_Vaga", "Titulo_Vaga", "Empresa", "Localizacao"}),
    Dia_SemanaPublicacao = Table.AddColumn(SemDuplicatas, "Dia_SemanaPublicacao", each Date.DayOfWeekName([Data_Publicacao], "pt-BR")),
    TipoSemanaPublicacao = Table.TransformColumnTypes(Dia_SemanaPublicacao,{{"Dia_SemanaPublicacao", type text}, {"salario_medio", Currency.Type}, {"indice_medio_vs_brasil", type text}}),
    IndiceMedioVSBrasil = Table.AddColumn(TipoSemanaPublicacao, "Indice_medio_vs_brasil_ajustado", each Number.FromText(Text.Replace(Text.Trim([indice_medio_vs_brasil]), "x", ""), "pt-BR")),
    TipoIndiceMedioVsBrasil = Table.TransformColumnTypes(IndiceMedioVSBrasil,{{"Indice_medio_vs_brasil_ajustado", Percentage.Type}}),
    FormatoFinal = Table.SelectColumns(TipoIndiceMedioVsBrasil,{"ID_Vaga", "Titulo_Vaga", "area", "Empresa", "Modelo_Trabalho", "Cidade", "UF", "Data_Publicacao", "Dia_SemanaPublicacao", "salario_medio", "Indice_medio_vs_brasil_ajustado", "Arquivo_Origem", "Linha_Origem"})
in
    FormatoFinal