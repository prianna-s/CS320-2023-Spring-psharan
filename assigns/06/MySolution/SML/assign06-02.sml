(* ****** ****** *)
use
"./../../../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)

(*
HX-2023-03-24: 10 points
Please enumerate all the pairs of natural
numbers. Given pairs (i1, j1) and (i2, j2),
(i1, j1) should be enumerated ahead of (i2, j2)
if i1+j1 < i2+j2.
*)

(* ****** ****** *)

(*
val theNatPairs: (int*int) stream = fn () => ...
*)

(* ****** ****** *)

val theNatPairs: (int*int) stream = fn () =>
	let 
	fun helper(j, k): (int * int) strcon = 
	if k = 0 then strcon_cons( (j, k), fn() => helper(0, j+1) )
	else strcon_cons( (j, k), fn() => helper(j+1, k-1) )
	
	in helper(0,0)
	end;

(* end of [CS320-2023-Spring-assign06-02.sml] *)
