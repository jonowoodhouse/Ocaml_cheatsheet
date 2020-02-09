open Core

let () = print_endline "hello world"

let variable_example =
  (* Variable example *)
  let x = 5 in
  let f = 9. (* float (no trailing zero required) *) in
  let s = "a string" in
  (* Annotated Variables *)
  let y : int = 6 in
  let (z : int) = 7 in
  (* printing to the screen *)
  printf "%d %d %d %f %s\n" x y z f s;
  print_s [%message (s : string)];
  (* printf !"%(string)" s *) (* TODO Add more*)


(* TODO:
   Google Analytics and Home Page

   variables
   annotated variables and return types
   printing to the screen / print_s [%message]
   arguments
   records (022)
   modules (021 023)
   tuples
   matching and function
   variants (004 024 025)
   polymorphic variants
   fun
   partial functions
   options
   ref and mutable
   List - map, fold, reduce (010 017 029 030  )
   Set
   Map
   Hashtbl (027)
   string (018 019)
   map + bind
   pipes
   In_channel (008)
   Lazy (028)
   Sexp (031)
   Identifiable
   functors (031)
   phantom types
   compare (020)
   async
   error handling and Or_error and Result.t (026)
   expect tests (002)
   Assembler & profiling (014 015 016)
   ppx
   Cool tricks
   Spacemacs commands
*)
