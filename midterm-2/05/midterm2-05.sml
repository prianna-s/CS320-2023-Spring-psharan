(* ****** ****** *)

use "./../../mysmlib/mysmlib-cls.sml";

(* ****** ****** *)

(*
//
// HX-2023-04-20: 20 points
//
A sequence xs of integers captures '231'
if there are three integers a, b, and c
appearing as a subsequence of xs satisfying
c < a < b. Note that a, b, and c do not have
to appear consecutively in xs.

For instance, [1,3,4,2] does capture '231'
For instance, [1,2,4,3] does not capture '231'
For instance, [1,2,3,4] does not capture '231'
*)

(* ****** ****** *)

(*
fun
perm_capture_231(xs: int list): bool = ...
*)

(* ****** ****** *)

(* end of [CS320-2023-Spring-midterm2-05.sml] *)

fun perm_capture_231(xs: int list): bool =
  let
    fun find_231([], []) = false
      | find_231([_], []) = false
      | find_231([], _::_::_) = false
      | find_231(x::xs, ys) =
          let
            fun check_c([], []) = find_231(xs, ys)
              | check_c([], _::_::_) = find_231(xs, ys)
              | check_c(c::_, []) = false
              | check_c(c::cs, y::ys) =
                  if y < c then check_c(c::cs, ys)
                  else if y > c then true
                  else check_c(cs, ys)
          in
            check_c(xs, ys)
          end
  in
    list_filter(xs, fn x => x > 2) (* Only keep numbers > 2 *)
    |> list_map(fn x => x - 1) (* Decrement all numbers *)
    |> list_reduce_left(false, fn (a, b) => a orelse find_231([b], a)) (* Check for '231' *)
  end
