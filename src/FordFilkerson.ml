open Graph
open Printf

let init_graph graph = 
    let f a = (0,int_of_string(a)) in 
    Graph.e_iter graph f ;;


let clone_nodes gr = 
    let new_graph = empty_graph in 
        n_iter gr (fun a -> new_node new_graph a);
    new_graph;;