(* Faire attention au chemin saturé
    Label du chemin entre a et b de type (x, y), si x=0, il n'y a pas de chemin de b vers a,
    si x=y pas de chemin de a vers b.
    Dans les autres cas, le chemin est dans les deux sens.
 *)

let rec dfs g from to = 
    let next_arc = List.hd out_arcs g from

