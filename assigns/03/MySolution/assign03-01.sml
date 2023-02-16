(* ****** ****** *)
(*
use "./../assign03.sml";
use "./../assign03-lib.sml";
*)
(* ****** ****** *)

(*
//
HX-2023-02-09: 10 points
//
The function find_root(f0)
finds the first root of [f0] in
the following sequence:
0, 1, -1, 2, -2, 3, -3, 4, -4, ...
*)
(*
fun
find_root(f0: int -> int): int = ...
*)

(* ****** ****** *)

(* end of [CS320-2023-Spring-assign03-01.sml] *)

fun
find_root(f0: int -> int): int =
let
exception ZERO of int 
    fun loop(x: int): int =
    if f0(x) = 0
    then raise ZERO(x)
    else if f0(~1 * x) = 0
    then raise ZERO(~1 * x)
    else
    loop (x+1)
in
    loop(0) handle ZERO(x) =>x
end