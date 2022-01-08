open Graph

(* Convertit un type option en un normal*)
let convert_option arc =
    match arc with
        | Some z -> z
        | None -> (-1,10000);;

(* Cherche le premier fils non marqué *)
let rec find_not_marked_son g father_node son_list marked_nodes =
    match son_list with
        | [] -> None
        | (x,(flot,flotmax))::rest -> 
                if (List.mem x marked_nodes || (flot == flotmax)) 
                then find_not_marked_son g father_node rest marked_nodes
                else Some x ;;


(* Cherche un chemin en deep first search *)
let dfs g source dest = (* Source et dest sont des id de nodes*)
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