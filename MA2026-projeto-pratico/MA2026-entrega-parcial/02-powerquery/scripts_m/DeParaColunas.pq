//DeParaColunas

let
    Tabela = #table(type table [Nome_Origem = text, Nome_Alvo = text], {
        {"id", "ID_Vaga"},
        {"title", "Titulo_Vaga"},
        {"company", "Empresa"},
        {"location", "Localizacao"},
        {"work_mode", "Modelo_Trabalho"},
        {"link", "Link"},
        {"posted", "Data_Publicacao"}
    })
in
    Tabela