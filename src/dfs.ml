open Graph

(* Faire attention au chemin saturé
    Label du chemin entre a et b de type (x, y), si x=0, il n'y a pas de chemin de b vers a,
    si x=y pas de chemin de a vers b.
    Dans les autres cas, le chemin est dans les deux sens.
 *)

(* Called like find_not_marked_son graph node (out_arcs g node) marked_nodes *)
(** Get the first son not marked. *)

let convert_option arc =
    match arc with
        | Some z -> z
        | None -> (-1,10000);;

let rec find_not_marked_son g father_node son_list marked_nodes =
    match son_list with
        | [] -> None
        | (x,(flot,flotmax))::rest -> 
                if (List.mem x marked_nodes || (flot == flotmax)) 
                then find_not_marked_son g father_node rest marked_nodes
                else Some x ;;


(* Source et dest sont des id de nodes*)
let dfs g source dest =
    let rec loop g source dest marked_nodes acu = 
        match find_not_marked_son g source (out_arcs g source) marked_nodes with (* premier fils *)
            | None -> None (** Noeud puits *)
            | Some x when x=dest-> Some ((source,x)::acu)
            | Some x -> let marked_bis = loop g x dest (x::marked_nodes) ((source,x)::acu) in 
                match marked_bis with 
                    | None -> loop g source dest (x::marked_nodes) acu
                    | l -> l
    in 
        loop g source dest [source] [];;