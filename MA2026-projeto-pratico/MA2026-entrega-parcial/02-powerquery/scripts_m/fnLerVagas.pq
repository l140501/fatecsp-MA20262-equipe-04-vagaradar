//fnLerVagas

(conteudo as binary) as table =>
let
    Planilha = fnLerPlanilha(conteudo),
    Padronizada = fnPadronizarColunas(Planilha),
    // Adiciona o número da linha de origem da planilha
    ComLinha = Table.AddIndexColumn(Padronizada, "Linha_Origem", 2, 1, Int64.Type)
in
    ComLinha