let rec dfs g from to = 
    let next_arc = List.hd out_arcs g from

