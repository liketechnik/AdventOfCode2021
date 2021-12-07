open Printf;;
open List;;
open String;;

let file_channel = open_in(Sys.argv.(1));;
let line = input_line file_channel;;
let line_split = split_on_char ',' line;;
let initial_state = List.map int_of_string line_split;;

let next_day state = 
    let babies = List.filter_map  (function e -> if e == 0 then Some(8) else None) state in
    let aged = List.rev_map (function e -> if e == 0 then 6 else e - 1) state in
    List.rev_append aged babies;;

let rec simulate state days = 
    if days <= 0 then
        state
    else
        let next_state = next_day state in
        let next_day = days - 1 in
        simulate next_state next_day;;

(* let res = simulate initial_state 18;; *)
(* List.iter (printf "%d ") res *)

printf "After %d days: %d\n" 18 (List.length (simulate initial_state 18));
printf "After %d days: %d\n" 80 (List.length (simulate initial_state 80));
(* printf "After %d days: %d\n" 256 (List.length (simulate initial_state 256)) *)

