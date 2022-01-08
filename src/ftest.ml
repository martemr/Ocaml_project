(*open Gfile
open Tools
open ReadFile 

let () =

  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  let infile = Sys.argv.(1) in
  
  (* Open file *)
  let () = test_function (from_file infile) 
  in

  ();;
*)