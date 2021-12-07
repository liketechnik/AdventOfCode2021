open Printf;;
open List;;
open String;;
open Hashtbl;;


let file_channel = open_in(Sys.argv.(1));;
let line = input_line file_channel;;
let line_split = split_on_char ',' line;;
let initial_state = List.map int_of_string line_split;;

let hashes = Hashtbl.create 9;;

let init =
    for i = 0 to 8 do
        let occurrences = List.length (List.filter (function e -> e == i) initial_state) in
        Hashtbl.replace hashes i occurrences;
    done;;

let () = init;;

(* let next_day state = *) 
(*     let babies = filter (function e -> if e == 0 then Some(8) else None) state in *)
(*     let aged = List.rev_map (function e -> if e == 0 then 6 else e - 1) state in *)
(*     List.rev_append aged babies;; *)

(* let next_day state = *) 
(*     let babies = filter baby state in *)
(*     let aged = List.rev_map next state in *)
(*     List.rev_append aged babies;; *)

(* let rec simulate state days = *) 
(*     if days <= 0 then *)
(*         state *)
(*     else *)
(*         let next_state = next_day state in *)
(*         let next_day = days - 1 in *)
(*         simulate next_state next_day;; *)

(* let res = simulate initial_state 18;; *)
(* List.iter (printf "%d ") res *)

(* printf "After %d days: %d\n" 18 (List.length (simulate initial_state 18)); *)
(* printf "After %d days: %d\n" 80 (List.length (simulate initial_state 80)); *)
(* printf "After %d days: %d\n" 256 (List.length (simulate initial_state 256)) *)

let age current = 
    for i = 1 to 8 do
        let into = i - 1 in
        Hashtbl.replace hashes into (Hashtbl.find current i);
    done;
    Hashtbl.replace hashes 6 ((Hashtbl.find hashes 6) + (Hashtbl.find current 0));
    Hashtbl.replace hashes 8 (Hashtbl.find current 0);;

let simulate days =
    for day = 1 to days do
        let current = Hashtbl.copy hashes in
        age current;
    done;;

let days = 256;;
let () = simulate days;;

let sum k v acc = printf "%d: %d\n" k v; acc + v;;
let res = Hashtbl.fold sum hashes 0;;
printf "After %d days: %d\n" days res
