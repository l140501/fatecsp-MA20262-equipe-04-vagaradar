//fnPadronizarColunas

(tabela as table) as table =>
let
    // 1. Remove espaços em branco das extremidades dos cabeçalhos
    CabecalhosLimpos = Table.TransformColumnNames(tabela, Text.Trim),
    // 2. Cria os pares {nome original em inglês, nome alvo em português}
    Pares = List.Zip({DeParaColunas[Nome_Origem], DeParaColunas[Nome_Alvo]}),
    // 3. Renomeia apenas as colunas existentes
    Renomeada = Table.RenameColumns(CabecalhosLimpos, Pares, MissingField.Ignore),
    // 4. Reordena no formato em português (preenche com nulo se alguma coluna não existir)
    NoFormatoAlvo = Table.SelectColumns(Renomeada, ColunasAlvo, MissingField.UseNull)
in
    NoFormatoAlvo