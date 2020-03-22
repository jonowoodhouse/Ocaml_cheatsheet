# OCaml Cheatsheet

### Website: [jonowoodhouse.github.io/Ocaml_cheatsheet/](https://jonowoodhouse.github.io/Ocaml_cheatsheet/)

View the [cheatsheet.ml](https://github.com/jonowoodhouse/Ocaml_cheatsheet/blob/master/cheatsheet.ml) source code file for great examples of using Ocaml.

```ocaml
open Core

let () = print_endline "hello world"

let variables_example =
  (* ------------------------------------------------------------
     Variables
     ------------------------------------------------------------ *)
  let x = 5 in
  let real = 9. (* float (no trailing zero required) *) in
  let s = "a string" in

  (* ------------------------------------------------------------
     Annotated variables
     ------------------------------------------------------------ *)
  let y : int = 6 in
  let (z : int) = 7 in

  (* ------------------------------------------------------------
     Annotated return type - [calc] returns an int
     ------------------------------------------------------------ *)
  let calc x y s : int =
    printf "A %s has %i lives\n" s (x + y);
    x + y
  in

  (* ------------------------------------------------------------
     Renaming arguments
     ------------------------------------------------------------ *)
  let f ~a:renamed_a = renamed_a * 2 in

  (* ------------------------------------------------------------
     Printing to the screen 
     ------------------------------------------------------------ *)
  printf "%d %d %d %f %s %i\n" x y z real s (f ~a:50);
  print_s [%message "Description" (s : string)];
  print_s (String.sexp_of_t s);
  (* This uses: https://github.com/janestreet/ppx_custom_printf*)
  printf !"%{sexp:string} %{sexp#mach:string} %{String}\n" s s s;
  let (_ : int) = calc 5 4 "cat" in

  (* ------------------------------------------------------------
     Recursion
     ------------------------------------------------------------ *)
  let rec fold list ~init ~accum =
    match list with
    | [] -> init
    | hd :: tl -> fold tl ~init:(accum init hd) ~accum
  in

  (* ------------------------------------------------------------
     Anonymous function (fun keyword)
     ------------------------------------------------------------ *)
  printf "%i\n" (fold [ 1; 2; 3 ] ~init:0 ~accum:(fun init elem -> init + elem))

(* types *)
type contact = { name : string; mobile : string; birth_year : int }
[@@deriving sexp]

let records_example =
  (* ------------------------------------------------------------
     Records
     ------------------------------------------------------------ *)
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

(* modules with records of type t *)
module File = struct
  type t = { file_name : string; size : int; attributes : int }
  [@@deriving sexp]

  let to_string t =
    if t.attributes > 700 then String.uppercase t.file_name else t.file_name
end

let module_records_example =
  (* ------------------------------------------------------------
     Records in modules
     ------------------------------------------------------------ *)
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

```

## Compiling cheatsheet.ml
- See My OCaml programming environment section below
- from the shell run this in linux:
```shell
	eval `opam config env`
	dune build @all
	_build/default/cheatsheet.exe
```	

## My OCaml programming environment
- Note: Don't bother use Windows - much easier in Linux
- [Ubuntu LTS](https://ubuntu.com/download/desktop)
- [SpaceMacs](https://www.spacemacs.org/)
- [OCaml](https://ocaml.org/) (and opam)
- Dune

## Useful links
- [Real World Ocaml book](https://dev.realworldocaml.org/) 
- [Installing OCaml](https://dev.realworldocaml.org/install.html) 

## Opam
	# TODO: complete this list
	opam install dune utop ocamlformat core async merlin

## Dune
in an empty folder:
```shell
	eval `opam config env`
	dune init executable dune_example
	dune build @all
	_build/default/main.exe
```	

## Ocamlformat
- Requires an empty ``.ocamformat`` file in the project folder
- ``ocamlformat -i cheatsheet.ml``

## Other Tips
- Other cool tips will go here

## Further Reading
- [99 OCaml Problems](https://ocaml.org/learn/tutorials/99problems.html) 

## TODO
- Opam install list
- Test on a new Ubuntu environment
- Spacemacs and installation instructions
