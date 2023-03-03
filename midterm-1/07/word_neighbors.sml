(* ****** ****** *)
use "./../../mysmlib/mysmlib-cls.sml";
(* ****** ****** *)
(*
HX-2023-03-01: midterm1-07: 20 points
*)
(* ****** ****** *)
(*
Note that you are not allowed to define
recursive functions for solving this one.
*)
(* ****** ****** *)
(*
Here are some functions that you
can use in your solution to this one.
*)
val
strsub = String.sub
val
string_length = String.size
val
string_implode = String.implode
val
string_filter =
foreach_to_filter_list(string_foreach)
val
string_tabulate =
fn(len, fopr) =>
string_implode(list_tabulate(len, fopr))

(* ****** ****** *)

(*
A word here is defined to be a (possibly empty)
sequence of lowcase letters in the English alphabet.
Two words w1 and w2 are neighbors if they are of the
same length and differ by exactly one letter.
//
For instance, [water] and [later] are neighbors.
For instance, [abcde] and [abxde] are neighbors.
For instance, [abcde] and [abcde] are not neighbors.
//
Given a word, the function [word_neighbors] returns
a list consisting of *all* the neighbors of the word.
//
fun word_neighbors(word: string): string list = ...
//
Please give an implementation of word_neighbors.
Note that you are NOT allowed to define recursive functions
in your implementation
//
*)

(* ****** ****** *)

val AB =
"abcdefghijklmnopqrstuvwxyz"

(* ****** ****** *)

val
string_iforeach =
foreach_to_iforeach(string_foreach)
val
string_imap_list =
fn(cs, ifopr) =>
foreach_to_map_list(string_iforeach)(cs, ifopr)

(* ****** ****** *)

(* end of [CS320-2023-Spring-midterm1-word_neighbors.sml] *)

fun word_neighbors(word: string): string list =
  let
    val alphabet = "abcdefghijklmnopqrstuvwxyz"
    val len = size word
    fun neighbors acc i =
      if i >= len then acc
      else
        let
          val c = String.sub(word, i)
          fun replace c j =
            if j >= len then []
            else
              let
                val d = String.sub(word, j)
                val new_word = String.substring(word, 0, i) ^ c ^ String.substring(word, i+1, j-i-1) ^ d ^ String.substring(word, j+1, len-j-1)
              in
                if new_word <> word then new_word :: replace c (j+1)
                else replace c (j+1)
              end
        in
          neighbors (acc @ List.concat (List.map (fn x => replace x (i+1)) (filter (fn x => x <> c) (String.explode alphabet)))) (i+1)
        end
  in
    neighbors [] 0
  end
