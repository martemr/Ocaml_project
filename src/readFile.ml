open Graph
open Gfile
open Tools
open Dfs
open Printf
open FordFulkerson


let test_function graph =
  
  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf "\nUsage: %s infile source sink outfile\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  let outfile = Sys.argv.(4)

  and source = int_of_string Sys.argv.(2)
  and sink   = int_of_string Sys.argv.(3)
  in

  (** Calcule le fordFulkerson *)
  let new_gr = fordFulkerson graph source sink in 

  (** Convertit le label d'un tuble à un string plus lisible *)
  let convert_string graph sep = 
      gmap graph (fun (a,b) -> ((string_of_int a)^sep^(string_of_int b))) in 
  
  
  export (convert_string new_gr "/") outfile; (* Exporte le fichier au format pour créer le svg*)
  write_file (outfile^".txt") (convert_string new_gr " ") (*Exporte le fichier au format txt pour l'affichage via site web *)

;;