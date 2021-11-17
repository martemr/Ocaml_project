(* Yes, we have to repeat open Graph. *)
open Graph

(* assert false is of type ∀α.α, so the type-checker is happy. *)
let clone_nodes (gr:'a graph) = n_fold gr new_node empty_graph ;;

let gmap gr f = 
    let new_graph = clone_nodes gr in 
        let new_arcbis gr id1 id2 lbl= new_arc gr id1 id2 (f lbl) in
            e_fold gr new_arcbis new_graph ;;

