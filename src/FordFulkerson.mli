
open Graph

val init_graph: string graph -> (int * int) graph

val fordFulkerson: string graph -> id -> id ->  (int * int) graph

val printOptionList: (id * id) list option ->unit
val convert_option: (id * id) option ->(id * id)