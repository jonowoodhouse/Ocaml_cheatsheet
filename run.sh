#!/bin/bash
dune build @all && _build/default/cheatsheet.exe && echo '-----' && ocamlformat -i cheatsheet.ml && dune build @all && _build/default/cheatsheet.exe
