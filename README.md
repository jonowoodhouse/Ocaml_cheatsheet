# OCaml Cheatsheet

View the source code file cheatsheet.ml for great examples of using Ocaml.

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
	opam install dune utop ocamlformat core async

## Dune
in an empty folder:

	eval `opam config env`
	dune init executable dune_example
	dune build @all
	_build/default/main.exe

## Ocamlformat
- Requires an empty ``.ocamformat`` file in the project folder
- ``ocamlformat -i cheatsheet.ml`

## Other Tips
- Other cool tips will go here

## Further Reading
- [99 OCaml Problems](https://ocaml.org/learn/tutorials/99problems.html) 

## TODO
- Opam install list
- Test on a new Ubuntu environment
- Spacemacs and installation instructions