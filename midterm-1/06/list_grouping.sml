(* ****** ****** *)
use "./../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)
(*
HX-2023-03-02: midterm-06: 20 points
//
Given a list of integers xs, list_grouping(xs)
returns a list of pairs (n, x) where n indicates
the number of times x occurs in xs; for each x in
xs, there must be a pair (n, x) for some n in the
returned list.
//
For instance,
list_grouping([1,2]) = [[1,1], [1,2]]
list_grouping([1,2,2,2,1]) = [[2,1], [3,2]]
list_grouping([1,2,1,2,3]) = [[2,1], [2,2], [1,3]]
//
In order to receive full credit, your implementation
should be able to handle a list containing 1M elements
in less than 10 seconds (mine can do it in less than
two seconds)
//
*)
(* ****** ****** *)

(*
fun
list_grouping(xs: int list): (int * int) list = ...
*)

(* ****** ****** *)

(*
Some testing code:
val N = 1000
val nxs = list_grouping(int1_map_list(N, fn i => N-i))
*)
(* ****** ****** *)

(*
Some testing code:
Your implementation needs to be efficient to pass the
following test:
val N = 1000000
val nxs = list_grouping(int1_map_list(N, fn i => N-i))
*)

(* ****** ****** *)

(* end of [CS320-2023-Spring-midterm1-list_grouping.sml] *)

fun filter p xs =
  let
    fun loop [] acc = acc
      | loop (x::xs) acc =
          if p x then loop xs (x::acc) else loop xs acc
  in
    list_reverse (loop xs [])
  end


fun list_grouping (xs: int list): (int * int) list =
  let
    fun count_elem x [] = 0
      | count_elem x (y::ys) =
          if x = y then 1 + count_elem x ys else count_elem x ys
    fun pairs [] = []
      | pairs (x::xs) =
          let
            val n = count_elem x xs + 1
          in
            (n, x) :: pairs (filter (fn y => y <> x) xs)
          end
  in
    pairs xs
  end
