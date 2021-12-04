
all: star1

star1: input
	nix eval -f ./star1.nix

input: ../.aoc-session.txt
	curl --cookie 'session=$(file < ../.aoc-session.txt)' -O https://adventofcode.com/2021/day/4/input

clean:
