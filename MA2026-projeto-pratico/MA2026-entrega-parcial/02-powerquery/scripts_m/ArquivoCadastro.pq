//ArquivoCadastro - Corresponde ao pArquivoEtapa1

let
    Fonte = Excel.Workbook(File.Contents(pArquivoCadastro), null, true)
in
    Fonte