
all: star1 star2

star1: star1.s input_prepared
	gcc -g -m64 -o star1 star1.s

star2: star2.s input_prepared
	gcc -g -m64 -o star2 star2.s

input_prepared: input
	cp input input_tmp
	sed -z -i -e 's|\n|, |g' input_tmp
	$(file > input_prepared,.int content)
	sed -i -e "s|content|$$(cat input_tmp)|" input_prepared
	sed -i -e "s|, $$||" input_prepared
	rm input_tmp

input: ../.aoc-session.txt
	curl --cookie 'session=$(file < ../.aoc-session.txt)' -O https://adventofcode.com/2021/day/1/input

clean:
	rm input_prepared
	rm star1
	rm star2
