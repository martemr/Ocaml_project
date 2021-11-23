open Graph
open Printf

let init_graph graph = 
    gmap graph (fun a -> (0,a)) ;;

let rec find_min_incr L = 
        match L with
            []->9999
            |(s,d,(flot,flot_max))::tl->min (flot_max-flot) (find_min_incr L);;


let clone_nodes gr = 
    let new_graph = empty_graph in 
        n_iter gr (fun a -> new_node new_graph a);
    new_graph;;