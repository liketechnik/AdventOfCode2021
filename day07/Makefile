
all: star1 star2

.PHONY: star1
star1: input star1.adb
	gnatmake star1.adb
	./star1 input

.PHONY: star2
star2: input star2.adb
	gnatmake star2.adb
	./star2 input

input: ../.aoc-session.txt
	curl --cookie 'session=$(file < ../.aoc-session.txt)' -O https://adventofcode.com/2021/day/7/input

clean:
	-rm input star1 *.cmi *.cmx *.o listbased
