//Vagas_Bruto - Corresponde ao stg_vendas_bruta

let
    Origem = Folder.Files(pPastaVagas),
    SoXlsx = Table.SelectRows(Origem, each [Extension] = ".xlsx"),
    SoPlanilhas = Table.SelectRows(SoXlsx, each not Text.StartsWith([Name], "~$")),
    ComDados = Table.AddColumn(SoPlanilhas, "Dados", each fnLerVagas([Content])),
    SoNomeEDados = Table.SelectColumns(ComDados,{"Name", "Dados"}),
    Renomeada = Table.RenameColumns(SoNomeEDados,{{"Name", "Arquivo_Origem"}}),
    Anexada = Table.ExpandTableColumn(Renomeada, "Dados", ColunasAlvo & {"Linha_Origem"}),
    Ordenada = Table.Sort(Anexada, {{"Arquivo_Origem", Order.Ascending}, {"Linha_Origem", Order.Ascending}})
in
    Ordenada