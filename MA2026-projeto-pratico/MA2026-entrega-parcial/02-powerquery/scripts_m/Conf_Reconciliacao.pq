//Conf_Reconciliacao

let
    Lidas = Table.RowCount(Vagas_Bruto),
    Aceitas = Table.RowCount(fVagas),
    Rejeitadas = Table.RowCount(Rejeitados),
    Resultado = #table(type table [Indicador = text, Linhas = Int64.Type], {
    {"1. Linhas lidas (todas as cidades)", Lidas},
    {"2. Aceitas em fVagas", Aceitas},
    {"3. Registradas em Rejeitados", Rejeitadas},
    {"4. Diferença (1 - 2 - 3): deve ser 0", Lidas - Aceitas - Rejeitadas}})
in
    Resultado