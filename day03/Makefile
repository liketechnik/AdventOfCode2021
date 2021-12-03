
all: star1 star2

star1: input
	awk -f star1.awk input

star2: input
	./star2.sh input

input: ../.aoc-session.txt
	curl --cookie 'session=$(file < ../.aoc-session.txt)' -O https://adventofcode.com/2021/day/3/input

clean:
