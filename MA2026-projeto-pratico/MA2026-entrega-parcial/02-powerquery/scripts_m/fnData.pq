//fnData

(valor as any) as nullable date =>
let
    Resultado =
        if valor = null then null
        else if valor is date then valor
        else if valor is datetime then Date.From(valor)
        else if valor is number then Date.From(valor) // Série numérica do Excel (ex: 46235)
        else
            let
                Texto = Text.Replace(Text.Trim(Text.From(valor)), "/", "-"),
                Partes = Text.Split(Texto, "-"),
                P1 = Number.From(Partes{0}),
                P2 = Number.From(Partes{1}),
                P3 = Number.From(Partes{2}),
                Data = if Text.Length(Partes{0}) = 4 then #date(P1, P2, P3) else #date(P3, P2, P1)
            in
                Data
in
    try Resultado otherwise null