# OCaml Cheatsheet

### Website: [jonowoodhouse.github.io/Ocaml_cheatsheet/](https://jonowoodhouse.github.io/Ocaml_cheatsheet/)

View the [cheatsheet.ml](https://github.com/jonowoodhouse/Ocaml_cheatsheet/blob/master/cheatsheet.ml) source code file for great examples of using Ocaml.

```ocaml
open Core

let () = print_endline "hello world"

let variables_example =
  (* Variables example ------------- *)
  let x = 5 in
  let f = 9. (* float (no trailing zero required) *) in
  let s = "a string" in

  (* Annotated variables ------------ *)
  let y : int = 6 in
  let (z : int) = 7 in

  (* Annoated return type - int is the type of calc *)
  let calc x y s : int =
    printf "A %s has %i lives\n" s (x + y);
    x + y
  in

  (* printing to the screen ----------*)
  printf "%d %d %d %f %s\n" x y z f s;
  print_s [%message (s : string)];
  print_s (String.sexp_of_t s);
  (* This uses: https://github.com/janestreet/ppx_custom_printf*)
  printf !"%{sexp:string} %{sexp#mach:string} %{String}\n" s s s;
  let (_ : int) = calc 5 4 "cat" in

  let rec fold list ~init ~accum =
    match list with
    | [] -> init
    | hd :: tl -> fold tl ~init:(accum init hd) ~accum
  in
  (* anonymous function (fun keyword) *)
  printf "%i\n" (fold [ 1; 2; 3 ] ~init:0 ~accum:(fun init elem -> init + elem));

  (*  List.fold *)
  printf "Done\n"

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
