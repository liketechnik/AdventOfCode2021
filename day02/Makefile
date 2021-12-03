
all: star1 star2

star1: star1.sql database_setup
	psql -f star1.sql

star2: star2.sql database_setup
	psql -f star2.sql

database_setup: input database_setup.sql
	psql -f database_setup.sql

input: ../.aoc-session.txt
	curl --cookie 'session=$(file < ../.aoc-session.txt)' -O https://adventofcode.com/2021/day/2/input

clean:
	rm input_prepared
	rm star1
	rm star2
