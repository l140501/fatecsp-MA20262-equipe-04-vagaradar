//CargosVinculados - Corresponde ao dProdutos

let
    Fonte = ArquivoCadastro{[Item = "Tab-CargosReferencia", Kind = "Sheet"]}[Data],
    CabecalhosPromovidos = Table.PromoteHeaders(Fonte, [PromoteAllScalars=true]),
    Tipos = Table.TransformColumnTypes(CabecalhosPromovidos, {
        {"Cargos", type text},
        {"id_cargo", Int64.Type}
    }),
    ComChave = Table.AddColumn(Tipos, "Chave_Cargo", each Text.Upper(Text.Trim([Cargos])), type text),
    #"Linhas Filtradas" = Table.SelectRows(ComChave, each true)
in
    #"Linhas Filtradas"