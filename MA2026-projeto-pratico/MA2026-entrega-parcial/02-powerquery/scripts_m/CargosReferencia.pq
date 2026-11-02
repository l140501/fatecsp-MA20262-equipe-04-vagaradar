//CargosReferencia - Corresponde ao dProdutos

let
    Fonte = ArquivoCadastro{[Item = "Cadastro", Kind = "Sheet"]}[Data],
    CabecalhosPromovidos = Table.PromoteHeaders(Fonte, [PromoteAllScalars=true]),
    Tipos = Table.TransformColumnTypes(CabecalhosPromovidos, {
        {"id_cargo", Int64.Type},
        {"cargo_referencia", type text},
        {"cbo", type text},
        {"area", type text},
        {"salario_p25", type number},
        {"salario_medio", type number},
        {"salario_p75", type number},
        {"salario_teto", type number},
        {"fonte", type text},
        {"data_referencia", Int64.Type},
        {"indice_medio_vs_brasil", type text},
        {"indice_p25_vs_brasil", type text}
    })
in
    Tipos