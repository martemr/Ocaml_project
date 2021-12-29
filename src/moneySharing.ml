
open Graph
open Array

open Gfile
open Tools
open Dfs
open Printf
open FordFulkerson

open Ftest

let read_line contributors_list line = 
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
          | _-> read_line list line
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
    |(x,_,money,0)::tl->graph
    |(x,_,money,diff)::tl when diff>0 -> create_edges_graph(new_arc graph x 1000 (string_of_int diff)) contributors_list average_money tl (* Arcs vers le puits *)
    |(x,_,money,diff)::tl -> 
        let rec aux graph= function (* Créé les arces entre les noeuds *)
            []->graph
            |(y,_,money,diff)::tl when diff<=0 ->graph
            |(y,_,money,diff)::tl -> aux (new_arc graph x y (string_of_int average_money)) tl in 
    
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



let () = 

  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  let infile = Sys.argv.(1) 
  in  

  let () = test_function (moneySharing infile)
  in
  ()
            