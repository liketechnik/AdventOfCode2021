
JQ := $(shell command -v jq 2> /dev/null)

all: star1

star1: input
ifndef JQ
	nix eval -f ./star1.nix
else
	nix eval -f ./star1.nix --json | $(JQ)
endif

input: ../.aoc-session.txt
	curl --cookie 'session=$(file < ../.aoc-session.txt)' -O https://adventofcode.com/2021/day/4/input

clean:
	rm input
