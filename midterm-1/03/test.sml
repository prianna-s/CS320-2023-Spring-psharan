use "./list_nchoose2.sml";

local

exception ERROR_midterm1_02

(* ****** ****** *)

in (*local*)

val test1 = list_nchoose2([1, 3, 2])
val test2 = list_nchoose2([3, 2, 1]) 
val test3 = list_nchoose2([3, 2, 1, 4])

val () =
print("midterm1-02-test: no failure detected!\n")

(* ****** ****** *)

end(*end-of-local*)

(* ****** ****** *)

(* end of [CS320-2023-Spring-quizzes-midterm1-06-test.sml] *)