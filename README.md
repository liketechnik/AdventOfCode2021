# Advent of Code 2021

[![About](https://img.shields.io/badge/Advent%20of%20Code%20🎄-2021-brightgreen)](https://adventofcode.com/2021/about)
[![Days completed](https://img.shields.io/badge/day%20📅-16-blue)](https://adventofcode.com/2021)
[![Stars](https://img.shields.io/badge/stars%20⭐-17-yellow)](https://adventofcode.com/2021/stats)

https://adventofcode.com/2020/about

## Day 01
[![Language](https://img.shields.io/badge/Language-asm-yellowgreen)](https://en.wikipedia.org/wiki/GNU_Assembler)

- written in assembler
- build: `cd day01 && make`
- retrieve solution: open in debugger, set breakpoint at the break label, read content of register r11 ;)

## Day 02
[![Language](https://img.shields.io/badge/Language-sql-yellowgreen)](https://www.postgresql.org)

- written in SQL (tested and executed on a PostgreSQL DB)
- run: `cd day02 && make` (expects to be able to connect to a DB with `psql` and to be allowed to create a `aoc_day2_input` table)

## Day 03

### Star 1
[![Language](https://img.shields.io/badge/Language-awk-yellowgreen)](https://en.wikipedia.org/wiki/AWK)

- written in `awk`
- run: `cd day03 && make star1`

### Star 2
[![Language](https://img.shields.io/badge/Language-bash-yellowgreen)](https://www.gnu.org/software/bash/)
[![Language](https://img.shields.io/badge/Language-grep-yellowgreen)](https://www.gnu.org/software/grep/)
[![Language](https://img.shields.io/badge/Language-coreutils-yellowgreen)](https://www.gnu.org/software/coreutils/)

- written in `bash` (ab)using various UNIX tools
- run: `cd day03 && make star2`

## Day 04
[![Language](https://img.shields.io/badge/Language-nix-yellowgreen)](https://nixos.org/)

- written in `Nix`, inspired by https://github.com/jonringer/AoC2021
- run: `cd day04 && make star1` (outputs both solutions)

## Day 05
[![Language](https://img.shields.io/badge/Language-Guile-yellowgreen)](https://www.gnu.org/software/guile/)

- written in `Guile`, a [Scheme](https://en.wikipedia.org/wiki/Scheme_(programming_language) implementation, which itself is a [Lisp](https://en.wikipedia.org/wiki/Lisp_(programming_language)) dialect 
- run: `cd day05 && make` 

## Day 06
[![Language](https://img.shields.io/badge/Language-OCaml-yellowgreen)](https://ocaml.org/)

- written in `OCaml`
- run: `cd day06 && make`
- alternative: `cd day06 && make listbased` (only works for the first star though)

## Day 07
[![Language](https://img.shields.io/badge/Language-Ada-yellowgreen)](https://www.adaic.org/)

- written in `Ada`
- run: `cd day07 && make`

## Day 08
[![Language](https://img.shields.io/badge/Language-Erlang-yellowgreen)](https://www.erlang.org/)

- written in `Erlang`
- run: `cd day08 && make`
- the process of me thinking about possible ways to solve the problem for star2 is detailed in the `broken,` `testing_thoughts...` and `thinking...` files 
