open Graph
open Printf

let init_graph graph = 
    gmap graph (fun a -> (0,a)) ;;


let clone_nodes gr = 
    let new_graph = empty_graph in 
        n_iter gr (fun a -> new_node new_graph a);
    new_graph;;