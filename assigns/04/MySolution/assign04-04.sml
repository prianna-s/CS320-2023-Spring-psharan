(* ****** ****** *)
use
"./../../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)

(*
//
HX-2023-02-16: 30 points
//
Here is an implementation of the famous 8-queen puzzle:
https://ats-lang.sourceforge.net/DOCUMENT/INT2PROGINATS/HTML/x631.html
//
Please give a NON-RECURSIVE implementation that solves the 8-queen puzzle.
//
type board_t =
int * int * int * int * int * int * int * int
//
fun
queen8_puzzle_solve(): board_t list =
(*
returns a list of boards consisting of all the solutions to the puzzle.
*)
//
*)

(* ****** ****** *)

type board_t =
int * int * int * int * int * int * int * int

val board_get = fn(bd: board_t, i:int) =>
foreach_to_get_at(board_foreach)(bd,i)

val board_foreach = fn (bd: board_t, work: int -> unit) =>
    let val (x0,x1,x2,x3,x4,x5,x6,x7) = bd
    in
	work(x0); work(x1); work(x2); work(x3); work(x4); work(x5); work(x6); work(x7); ()
    end

fun board_set
  (bd: board_t, i: int, j:int): board_t = let
  val (x0, x1, x2, x3, x4, x5, x6, x7) = bd
in
  if i = 0 then let
    val x0 = j in (x0, x1, x2, x3, x4, x5, x6, x7)
  end else if i = 1 then let
    val x1 = j in (x0, x1, x2, x3, x4, x5, x6, x7)
  end else if i = 2 then let
    val x2 = j in (x0, x1, x2, x3, x4, x5, x6, x7)
  end else if i = 3 then let
    val x3 = j in (x0, x1, x2, x3, x4, x5, x6, x7)
  end else if i = 4 then let
    val x4 = j in (x0, x1, x2, x3, x4, x5, x6, x7)
  end else if i = 5 then let
    val x5 = j in (x0, x1, x2, x3, x4, x5, x6, x7)
  end else if i = 6 then let
    val x6 = j in (x0, x1, x2, x3, x4, x5, x6, x7)
  end else if i = 7 then let
    val x7 = j in (x0, x1, x2, x3, x4, x5, x6, x7)
  end else bd
end

val safety1 = fn(i0:int, j0:int, i:int, j:int) =>
    (j0<>j) andalso abs_int(i0-i) <> abs_int(j0-j)

val safety2 = fn(i0:int, j0:int, bd: board_t, i:int) =>
    if i>= 0
    then int1_forall(i, fn(x) => safety1(i0,j0,x, board_get(bd,x)))
    else true

fun queen8_puzzle_solve(): board_t list =
    let
        val N = 8
        val start_board = board_t(0,0,0,0,0,0,0,0)
        val all_boards = list_foldleft([], start_board, fn(res, i) => list_concat(list_map(res, fn(nx) => board_set(res,nx,i))))
    in
        all_boards
    end



(* end of [CS320-2023-Spring-assign04-04.sml] *)
