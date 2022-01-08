open Graph
open Array

open Gfile
open Tools
open Dfs
open Printf
open FordFulkerson
open ReadFile

open Ftest

let read_line_input_data contributors_list line = 
  try Scanf.sscanf line "%d %s %d" (fun nb name money -> (nb, name,money,0)::contributors_list)
  with e ->
    Printf.printf "Cannot read conrbution in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file" ;;

let read_datafile path = 

  let infile = open_in path in

  (* Read all lines until end of file. *)
  let rec loop list =
    try
      let line = input_line infile in

      (* Remove leading and trailing spaces. *)
      let line = String.trim line in

      let list2 =
        (* Ignore empty lines *)
        if line = "" then []

        (* The first character of a line determines its content : n or e. *)
        else match line.[0] with
          | _-> read_line_input_data list line
      in      
      loop list2

    with End_of_file -> list (* Done *)
  in

  let final_list = loop [] in
  
  close_in infile ;
  final_list;;
  

(** Calcule la somme des contributions *)
let rec calcul_total = function
    [] -> 0
    |(_,_,x,_)::tl -> x + calcul_total tl;; 

(** Ajoute les noeuds correspondants aux personnes *)
let rec create_nodes_graph graph = function
    | [] -> graph
    | (_,name,_,_)::tl -> create_nodes_graph (new_node graph name) tl ;;

(** Calcule et ajoute dans la liste la difference de chacun *)
let calcul_diff contributors_list average_money =
    let rec loop contributors_list acu = match contributors_list with
        | [] -> acu 
        | (nb,name,money,diff)::tl -> loop tl ((nb,name,money,money-average_money)::acu)
    in loop contributors_list [];;

let rec create_nodes_graph graph = function
    []->graph
    |(x,_,_,_)::tl-> create_nodes_graph (new_node graph x) tl ;;


let rec create_edges_graph graph contributors_list average_money= function
    []->graph
    |(x,name,money,0)::tl->graph
    |(x,name,money,diff)::tl when diff>0 -> create_edges_graph(new_arc graph x 1000 (string_of_int diff)) contributors_list average_money tl (* Arcs vers le puits *)
    |(x,name1,money,diff)::tl -> 
        let rec aux graph= function (* Créé les arcs entre les noeuds *)
            []->graph
            |(y,name,money,dif)::tl when dif<=0 ->aux graph tl
            |(y,name,money,dif)::tl -> aux (new_arc graph x y (string_of_int average_money)) tl in 

        create_edges_graph(new_arc (aux graph contributors_list) 0 x (string_of_int (-diff))) contributors_list average_money tl;; (* Arcs de la source *)


let moneySharing input_file =
    (* Get input file *)
    let contributors_list = read_datafile input_file in
    (* Calcul total amount *)
    let total = calcul_total contributors_list in
    (* Calcul the average and diff each*)
    let average_money = (total/(List.length contributors_list)) in
    (* Calcul the diff each*)
    let contributors_list1 = calcul_diff contributors_list average_money in
    (* Creates nodes in the graph *)
    let graph = create_nodes_graph empty_graph contributors_list1 in
    let graph1 = new_node (new_node graph 0) 1000 in (* on ajoute les noeuds correspondants à la source et au puit : id=0 pour la source et id = 1000 pour le puit *)

    (* Creates arcs in the graph *)
            
    create_edges_graph graph1 contributors_list1 average_money contributors_list1;;


let rec endette l id = 
  match l with
    []-> false
    |(x,_,_,diff)::tl when (x = id && diff<0)-> true
    |(x,_,_,diff)::tl when x = id-> false
    |hd::tl -> endette tl id;;
  
let rec namebyID l id =
  match l with
    []-> "Nom pas trouvé"
    |(x,name,_,_)::tl when x = id-> name
    |hd::tl -> namebyID tl id;;

let read_line_output_data line contributors_list=

  try Scanf.sscanf line "e %d %d %_d %s %_s@%%"
        (fun id1 id2 label -> if (id1<>0 && id2<>1000 && (int_of_string label)>0 && (endette contributors_list id1))
                              then Printf.printf " - %s doit %s à %s \n" (namebyID contributors_list id1) label (namebyID contributors_list id2))
  with e ->
    Printf.printf "Cannot read arc in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"



let display_results input_file output_file =
  let infile = open_in output_file in

  let contributors_list = read_datafile input_file in
  (* Calcul total amount *)
  let total = calcul_total contributors_list in
  (* Calcul the average and diff each*)
  let average_money = (total/(List.length contributors_list)) in
  (* Calcul the diff each*)
  let contributors_list1 = calcul_diff contributors_list average_money in
    
  (* Read all lines until end of file. *)
  let rec loop x =
    try
      let line = input_line infile in

      (* Remove leading and trailing spaces. *)
      let line = String.trim line in

      
        (* Ignore empty lines *)
        if line <> "" && (line.[0] == 'e') then (read_line_output_data line contributors_list1; loop x+1)
        else loop x+1;
      
               
    with End_of_file -> x (* Done *)
  in

  let final_graph = loop 0 in
  
  close_in infile ;
  final_graph;;
  
  
  
let () = 

  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  let infile = Sys.argv.(1) in
  let outfile = "outfile.txt"
  in 
  
  let () = test_function (moneySharing infile) in
  Printf.printf "\nResultats après exécution : \n";
  Printf.printf "\nNombre d'arcs du graph : %d\n" (display_results infile outfile);
  ();;
