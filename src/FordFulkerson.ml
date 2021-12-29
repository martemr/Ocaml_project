open Graph
open Tools
open Dfs


let create_reverse_edges gr = (* *)
    let new_graph = clone_nodes gr in 
        let new_arcbis gr id1 id2 (flot,flotmax)= new_arc (new_arc gr id1 id2 (flot,flotmax)) id2 id1 (flotmax-flot,flotmax) in
            e_fold gr new_arcbis new_graph ;;

let init_graph graph =   (* *)
    let graph1 = gmap graph (fun a -> (0,(int_of_string a))) in
    create_reverse_edges graph1;;

let convert_option arc = (* *)
    match arc with
        | Some z -> z
        | None -> (-1,10000);;
 
let convert_path gr l = (* *)
    match l with
        None->[]
        |Some l -> let rec aux gr l =
            (match l with
                | [] -> []
                | ((current,dest)::tl)-> (current,dest,(convert_option (find_arc gr current dest)))::(aux gr tl))
                in aux gr l;;

let rec find_min_incr gr l =  (* *)
    match l with
        [] -> 999999
        | [(current,dest,(flot,flotmax))]-> flotmax-flot 
        |(current,dest,(flot,flotmax))::tl->min (flotmax-flot) (find_min_incr gr tl);;

let maj_graph gr source dest l= (* *)
     let lbis = convert_path gr l in 
      let i = find_min_incr gr lbis in
       let rec aux gr l i=
        match l with
            []->gr  (* On met a jour les arcs du chemins trouvés ainsi que les arcs réciproques *)
            |(s,d,(flot,flot_max))::tl->aux (new_arc (new_arc gr s d (flot+i,flot_max)) d s (flot_max-flot-i,flot_max)) tl i in
         aux gr lbis i;;

let fordFulkerson gr source dest =
    let gr1 = (init_graph gr) in
     let rec aux gr source dest = 
        let l = dfs gr source dest in
        match l with
            None->gr
            |l->aux (maj_graph gr source dest l) source dest in 
    aux gr1 source dest;;
    
