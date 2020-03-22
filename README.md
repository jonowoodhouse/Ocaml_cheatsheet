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
(* ------------------------------------------------------------
   Records - Construction, destruction, annotation and renaming
   ------------------------------------------------------------ *)
type contact = { name : string; mobile : string; birth_year : int }
[@@deriving sexp]

let records_example =
  (* ------------------------------------------------------------
     Records - Construction, destruction, annotation and renaming
     ------------------------------------------------------------ *)
  (* record construction *)
  let c = { name = "Adam"; mobile = "012345678"; birth_year = 1995 } in
  printf "%s %s %i\n" c.name c.mobile c.birth_year;
  printf !"%{sexp:contact}\n" c;
  let create_contact name mobile birth_year = { name; mobile; birth_year } in
  let c2 = create_contact "James" "999999999" 1988 in
  (* Use dot notation *)
  let print1 x = printf "%s %s %i\n" x.name x.mobile x.birth_year in
  (* Use record deconstruction *)
  let print2 { name; mobile; birth_year } (* much better *) =
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
  print4 c2

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

(* ------------------------------------------------------------
   Records in modules. 2nd example
   ------------------------------------------------------------ *)
module Price = struct
  type t = { x : float }

  let create x = { x }
end

let module_records_example2 =
  let price1 = Price.create 5.50 in
  let (price2 : Price.t) = { x = 6.50 } in
  (ignore price1, price2)

```

## OCaml Terminology
| Term                            	| Definition                                                                                                                                     	|
|---------------------------------	|------------------------------------------------------------------------------------------------------------------------------------------------	|
| annonymouse function            	| `fun i -> 2 * i`                                                                                                                               	|
| applicative                     	| Some modules aren't quite monads. They have a [map] function like a Monad but not a [bind] function. [Command] is an example of a Applicative. 	|
| capitalisation                  	| Modules are Capitalised. functions and values are not.                                                                                         	|
| destructive substitution        	| with type t:=t (TODO explain more)                                                                                                             	|
| early binding                   	| runs at app start e.g. `let two_pi = 2.0 *. Float.pi`                                                                                          	|
| first-order functions           	| Functions that operate on normal data elements (e.g. ints, strings, records, variants etc.) See also high-order functions.                     	|
| high-order functions            	| Functions that take other functions as arguments or return functions. See also first-order functions                                           	|
| identity function               	| `Fn.id`                                                                                                                                        	|
| interface, signature, module type	| are all used interchangeably                                                                                                                   	|
| polymorphic functions           	| functions that act over values with many different types. Similar to templates in C++ and Generics in C# and Java                              	|
| record                          	| A bit like a struct in C.</br> `type person = {age : int; name : string}`                                                                      	|
| record type                     	| A record inside a module. `module Foo = struct`</br> `  type t = {bar : int; baz : string }`</br> `end`</br>                                     	|
| type parameter                  	| ['a] is a type parameter. Also known as a type variable. Forms a paramaterised type in a 'a pair.                                              	|
| val                             	| used in signatures, module signatures or in .mli files                                                                                         	|
| variant                         	| type color = &#124; Red &#124; Green &#124; Blue                                                                                               	|
| variant - polymorphic variant    	| \`Red \`Green \`Blue etc.                                                                                                                      	|
|                                 	|                                                                                                                                                	|



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
