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
                if (List.mem x marked_nodes || (flot == flotmax)) then find_not_marked_son g father_node rest marked_nodes
                else Some x ;;


(* Source et dest sont des id de nodes*)
let dfs g source dest =
    let rec loop g source dest marked_nodes acu = 
        match find_not_marked_son g source (out_arcs g source) marked_nodes with (* premier fils *)
            | None -> None (** Noeud puits *)
            | Some x -> if x=dest then Some ((source,x)::acu) else loop g x dest (x::marked_nodes) ((source,x)::acu)
    in 
        loop g source dest [source] [];;




(*
      let next_arcs_list = out_arcs g source in (* Get the output arcs from the head node and take the first one *)
        if (List.mem dest next_arc) (* Si la destination est trouvée *)
        then acu::dest (* fin *)
        else ( match next_arcs_list with
            | [] -> []
            | (next_id, lbl)::rest when not (List.mem (source,next_id) marked_arcs) -> (* if not maked*) loop g source dest marked_arcs::(source,next_id) acu::
            | (next_id, lbl)::rest -> (* if maked*) loop g source dest marked_arcs::(source,next_id)
            let next_arc = List.hd.
            if (List.mem marked_arcs) (* Si l'arc est déja marqué *)
            loop g from to 

            in 
            loop g source dest [] []


let rec loop current dest next_arcs_list marked_arcs acu = 
        if (List.mem dest next_arc) (* Si la destination est trouvée *)
        then Some acu::(current, dest) (* fin *)
        else ( (* sinon, on parcourt la liste des arcs suivants *)
            match next_arcs_list with
                | [] when (List.mem dest acu)-> Some acu
                | []-> None
                | (next_id,lbl)::rest when not (List.mem (source,next_id) marked_arcs) -> (* if not maked*) loop g next_id dest (out_arcs g next_id) marked_arcs::(source,next_id)
                | (next_id,lbl)::rest -> (* if maked*) loop g source dest rest marked_arcs::(source,next_id)

in 
loop source dest (out_arcs g source) [] [];;*)