(* ****** ****** *)
(*
use "./../assign03.sml";
use "./../assign03-lib.sml";
*)
(* ****** ****** *)

(*
//
HX-2023-02-10: 10 points
The function list_tabulate takes an integer
[n] and a function [f] and returns a list that
equals [f(0), f(1), ..., f(n-1)]
//
list_tabulate(n: int, f: int -> 'a): 'a list
//
*)

(* ****** ****** *)

(* end of [CS320-2023-Spring-assign03-03.sml] *)

fun loop( f: int -> 'a, finish: int): 'a list = 
	if finish = 0 then [] 
	else loop(f, finish - 1) :: f(finish) 