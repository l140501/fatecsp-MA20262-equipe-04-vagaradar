//DeParaCidades

let
    Fonte = ArquivoCadastro{[Item = "Tab-DeparaCidades", Kind = "Sheet"]}[Data],
    CabecalhosPromovidos = Table.PromoteHeaders(Fonte, [PromoteAllScalars=true]),
    Tipos = Table.TransformColumnTypes(CabecalhosPromovidos, {
        {"Local_Origem", type text},
        {"Cidade", type text},
        {"UF", type text},
        {"Precisao", type text}
    }),
    ComChave = Table.AddColumn(Tipos, "Chave_Local", each Text.Upper(Text.Trim([Local_Origem])), type text)
in
    ComChave