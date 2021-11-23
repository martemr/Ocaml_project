(* Algorithme de Deep First Search dans un graphe
    Prend un graphe et retourne un path de node donnant un chemin du puits à la source *)

open Graph

(* Type de retour : Liste d'arcs de type : (source, destination, (flot,flot_max)) *)
val dfs: 'a graph -> 'b 
