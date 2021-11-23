open Graph
open Printf

let init_graph graph = 
    gmap graph (fun a -> (0,a)) ;;

let rec find_min_incr gr l = 
        match l with
            []->9999
            |(s,d,(flot,flot_max))::tl when (find_arc gr s d <> None)->min (flot_max-flot) (find_min_incr gr tl)
            |(s,d,(flot,flot_max))::tl -> min (flot_max) (find_min_incr gr tl);;

let clone_nodes gr = 
    let new_graph = empty_graph in 
        n_iter gr (fun a -> new_node new_graph a);
    new_graph;;

let maj_graph gr source dest =
    let l = dfs gr source dest in
     let i = find_min_incr gr l in
      let aux gr l i=
        match l with
            []->gr  
            |(s,d,(flot,flot_max))::tl when (find_arc gr s d <> None)->aux (new_arc s d (flot+i,flot_max)) tl i
            |(s,d,(flot,flot_max))::tl -> aux (new_arc d s (flot-i,flot_max)) tl i;;


let init_graph_beta graph = 
    gmap graph (fun a -> (0,a)) ;;

let rec find_min_incr_beta gr l = 
        match l with
            []->9999
            |(s,d,(flot,flot_max))::tl when (find_arc gr s d <> None)->min (flot_max-flot) (find_min_incr gr tl)
            |(s,d,(flot,flot_max))::tl -> min (flot_max) (find_min_incr gr tl);;

let clone_nodes_beta gr = 
    let new_graph = empty_graph in 
        n_iter gr (fun a -> new_node new_graph a);
    new_graph;;

let maj_graph_beta gr source dest =
    let l = dfs gr source dest in
     let i = find_min_incr gr l in
      let aux gr l i=
        match l with
            []->gr  
            |(s,d,(flot,flot_max))::tl when (find_arc gr s d <> None)->aux (new_arc s d (flot+i,flot_max)) tl i
            |(s,d,(flot,flot_max))::tl -> aux (new_arc d s (flot-i,flot_max)) tl i;;