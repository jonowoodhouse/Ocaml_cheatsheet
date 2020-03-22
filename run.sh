#!/bin/bash
dune build @all && _build/default/cheatsheet.exe && echo '-----' && ocamlformat -m 110 -i cheatsheet.ml && dune build @all && _build/default/cheatsheet.exe
