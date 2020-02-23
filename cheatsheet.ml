open Core

let () = print_endline "hello world"

let variables_example =
  (* Variables example -------------------- *)
  let x = 5 in
  let real = 9. (* float (no trailing zero required) *) in
  let s = "a string" in

  (* Annotated variables ------------------ *)
  let y : int = 6 in
  let (z : int) = 7 in

  (* Annoated return type - int is the type of calc *)
  let calc x y s : int =
    printf "A %s has %i lives\n" s (x + y);
    x + y
  in

  (* Renaming arguments ------------------- *)
  let f ~a:renamed_a = renamed_a * 2 in

  (* printing to the screen --------------- *)
  printf "%d %d %d %f %s %i\n" x y z real s (f ~a:50);
  print_s [%message (s : string)];
  print_s (String.sexp_of_t s);
  (* This uses: https://github.com/janestreet/ppx_custom_printf*)
  printf !"%{sexp:string} %{sexp#mach:string} %{String}\n" s s s;
  let (_ : int) = calc 5 4 "cat" in

  (* recursion ---------------------------- *)
  let rec fold list ~init ~accum =
    match list with
    | [] -> init
    | hd :: tl -> fold tl ~init:(accum init hd) ~accum
  in
  (* anonymous function (fun keyword) ----- *)
  printf "%i\n" (fold [ 1; 2; 3 ] ~init:0 ~accum:(fun init elem -> init + elem))

(* define some types *)
type contact = { name : string; mobile : string; birth_year : int }
[@@deriving sexp]

let records_example =
  let c = { name = "Adam"; mobile = "012345678"; birth_year = 1995 } in
  printf "%s %s %i\n" c.name c.mobile c.birth_year;
  printf !"%{sexp:contact}\n" c;
  (* Use dot notation *)
  let print1 x = printf "%s %s %i\n" x.name x.mobile x.birth_year in
  (* Use record deconstruction *)
  let print2 { name; mobile; birth_year } =
    printf "%s %s %i\n" name mobile birth_year
  in
  (* use argument renaming and annotated variable *)
  let print3 ({ name; mobile; birth_year = b } : contact) =
    printf "%s %s %i\n" name mobile b
  in
  let print4 c =
    (* use record deconstruction *)
    let { name = n; mobile = m; birth_year } = c in
    printf "%s %s %i\n" n m birth_year
  in
  print1 c;
  print2 c;
  print3 c;
  let create_contact name mobile birth_year = { name; mobile; birth_year } in
  let c1 = create_contact "James" "999999999" 1988 in
  print4 c1

module File = struct
  type t = { file_name : string; size : int; attributes : int }
  [@@deriving sexp]

  let to_string t =
    if t.attributes > 700 then String.uppercase t.file_name else t.file_name
end

let module_records_example =
  let create_directory_entry file_name size attributes =
    { File.file_name; size; attributes }
  in
  let is_small_file file =
    let { File.file_name = _; size; attributes = _ } = file in
    size < 1000
  in
  let file = create_directory_entry "temp.log" 100 755 in
  printf !"%{sexp:File.t}\n" file;
  (* ppx uses File.to_string *)
  printf !"%{File} : is_small_file=%b\n" file (is_small_file file)

(* printf !"%(string)" s *)
(* TODO Add more*)

(* TODO:
   Google Analytics and Home Page

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
