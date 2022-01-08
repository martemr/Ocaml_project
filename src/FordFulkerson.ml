open Graph
open Tools
open Dfs
open Printf

(* On crée pour chaque arc un arc dans le sens inverse avec le
 flot opposé pour éviter d'avoir a ajouter des arcs par la suite *)
let create_reverse_edges gr =
     let new_graph = clone_nodes gr in 
        let new_arcbis gr id1 id2 (flot,flotmax)= new_arc (new_arc gr id1 id2 (flot,flotmax)) id2 id1 (flotmax-flot,flotmax) in
            e_fold gr new_arcbis new_graph ;;

(* On modifie les labels du graph pour en faire des tuples (flot/flot_max) et on crée les arcs inverses *)
let init_graph graph =   
    let graph1 = gmap graph (fun a -> (0,(int_of_string a))) in
    create_reverse_edges graph1;;

let convert_option arc = 
    match arc with
        | Some z -> z
        | None -> (-1,10000);;

let convert_path gr l = 
    match l with
        None->[]
        |Some l -> let rec aux gr l =
            (match l with
                | [] -> []
                | ((current,dest)::tl)-> (current,dest,(convert_option (find_arc gr current dest)))::(aux gr tl))
                in aux gr l;;

(* Recherche de la plus grande incrémentation de flot possible sur l'arc retourné par le dernier dfs *)
let rec find_min_incr gr l = 
    match l with
        [] -> 999999
        | [(current,dest,(flot,flotmax))]->  flotmax-flot
        |(current,dest,(flot,flotmax))::tl-> min (flotmax-flot) (find_min_incr gr tl);;

(* Mise à jour des labels du graph en fonction du dernier chemin trouvé par le dfs *)
let maj_graph gr source dest l= 
     let lbis = convert_path gr l in 
      let i = find_min_incr gr lbis in
       let rec aux gr l i=
        match l with
            []->gr  (* On met a jour les arcs du chemins trouvés ainsi que les arcs réciproques *)
            |(s,d,(flot,flot_max))::tl->aux (new_arc (new_arc gr s d (flot+i,flot_max)) d s (flot_max-flot-i,flot_max)) tl i in
         aux gr lbis i;;


(* Fonction prenant en argument un graph contenant les flots max et renvoyant le graph de flot maximal *)
let fordFulkerson gr source dest =
    let gr1 = (init_graph gr) in
      let rec aux gr source dest = 
        let l = dfs gr source dest in
        match l with
            None->gr  (* Cas où il n'existe plus de chemin entre la source et le puit -> fin du Ford Fulkerson *)
            |l->aux (maj_graph gr source dest l) source dest in 
    aux gr1 source dest;;
    
