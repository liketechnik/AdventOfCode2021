

all: star1 star2

star1: input
	guile -s ./star1.scm input

star2: input
	guile -s ./star2.scm input

input: ../.aoc-session.txt
	curl --cookie 'session=$(file < ../.aoc-session.txt)' -O https://adventofcode.com/2021/day/5/input

clean:
	rm input
