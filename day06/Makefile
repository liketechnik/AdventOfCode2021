
all: star1 

.PHONY: star1
star1: input
	ocamlopt -o star1 star1.ml
	./star1 input

.PHONY: listbased
listbased: input
	ocamlopt -o listbased listbased.ml
	./listbased input

input: ../.aoc-session.txt
	curl --cookie 'session=$(file < ../.aoc-session.txt)' -O https://adventofcode.com/2021/day/6/input

clean:
	-rm input star1 *.cmi *.cmx *.o listbased
