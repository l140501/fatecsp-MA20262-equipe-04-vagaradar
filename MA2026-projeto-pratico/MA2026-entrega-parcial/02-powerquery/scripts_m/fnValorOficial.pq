//fnValorOficial

(valor as nullable text, lista as list) as nullable text =>
let
    Encontrados = List.Select(lista, each Text.Upper(_) = Text.Upper(valor))
in
    if valor = null or List.IsEmpty(Encontrados) then valor else Encontrados{0}