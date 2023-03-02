(* ****** ****** *)
use "./../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)
(*
HX-2023-03-01: midterm1-01: 10 points
*)
(* ****** ****** *)
(*
Given a list xs, list_pairing(xs) returns
a list of pairs and an option; the 1st pair
consists of the first and last elements in xs,
and the 2nd pair consists of the second and the
second last elements in xs, and so on and so forth;
and the option is NONE if |xs| is even, and it is
SOME(xm) if |xs| is odd and xm is the middle element
in xs.
//
For instance, we have:
//
list_pairing([]) = ([], NONE)
list_pairing([1]) = ([], SOME(1))
list_pairing([1,2]) = ([(1,2)], NONE)
list_pairing([1,2,3]) = ([(1,3)], SOME(2))
list_pairing([1,2,3,4]) = ([(1,4),(2,3)], NONE)
//
*)
(* ****** ****** *)
(*
fun
list_pairing
(xs: 'a list): ('a * 'a) list * 'a option = ...
*)
(* ****** ****** *)

(* end of [CS320-2023-Spring-midterm1-list_pairing.sml] *)

fun splitAt(n, xs) =
  let
    fun helper(n, xs, left, right) =
      case xs of
        [] => (rev left, right)
      | x::xs' =>
          if n = 0
          then (rev left, xs)
          else helper(n-1, xs', x::left, right)
  in
    helper(n, xs, [], [])
  end


fun list_pairing(xs: 'a list): ('a * 'a) list * 'a option =
  let
    val len = length xs
    val mid = len div 2
    fun pairs([], _) = []
      | pairs(_ , []) = []
      | pairs(x::xs', y::ys') = (x, y)::pairs(xs', ys')
    in
      if len = 0 then
        ([], NONE)
      else if len mod 2 = 0 then
        (pairs(xs, rev xs), NONE)
      else
        let
          val (prefix, suffix) = splitAt((mid+1), xs)
        in
          (pairs(prefix, rev suffix), SOME (List.nth(xs, mid)))
        end
    end
