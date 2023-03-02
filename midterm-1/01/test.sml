use "./list_averages.sml";

local

exception ERROR_midterm1_02

(* ****** ****** *)

in
val result1 = list_averages([]) (* expected result: [] *)
val result2 = list_averages([1.0, 2.0, 3.0]) (* expected result: [1.0, 1.5, 2.0] *)
val result3 = list_averages([1.0, 2.0, 3.0, 4.0]) (* expected result: [1.0, 1.5, 2.0, 2.5] *)

val () =
print("no errors detected")

(* ****** ****** *)

end(*end-of-local*)

(* ****** ****** *)

(* end of [CS320-2023-Spring-quizzes-midterm1-06-test.sml] *)