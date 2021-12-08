
all: star2 

.PHONY: star1
star1: input 
	escript -c star1.erl input

.PHONY: star2
star2: input
	escript -c star2.erl input

input: ../.aoc-session.txt
	curl --cookie 'session=$(file < ../.aoc-session.txt)' -O https://adventofcode.com/2021/day/8/input

clean:
	-rm -rf input 
