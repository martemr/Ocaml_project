open Gfile
open Tools
open Dfs
open Printf


let print_path p output_path =
  let ff = open_out output_path in
  fprintf ff "test" ;;

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf "\nUsage: %s infile source sink outfile\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)

  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)

  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph = from_file infile in

  (* Rewrite the graph that has been read. *)

  let new_gr= gmap graph (int_of_string) in 

  (* let new_gr1=add_arc new_gr 0 2 100 in

  let new_gr2= gmap new_gr1 (string_of_int) in 

  let () = export new_gr2 outfile in

  ()

  *)

  (*let () = dfs new_gr 0 5 in

  let () = print_path l output in*)

  ()
  (* *)

