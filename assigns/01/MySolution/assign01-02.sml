use "./../assign01.sml";
use "./../MySolution/assign01-01.sml";

fun xlist_sub(xs:'a xlist, i0: int): 'a=
if i0 >= xlist_size(xs) then raise XlistSubscript
else
(
case xs of
xlist_cons(x1, xs) => (case i0 of 0 => x1 | i0 => xlist_sub(xs, i0 - 1))
|
xlist_snoc(xs, x1) => (case (i0 = xlist_size(xs)) of true => x1 | false => xlist_sub(xs, i0))
|
xlist_append(xs,ys) => (case (i0 < xlist_size(xs)) of true => xlist_sub(xs, i0) | false => xlist_sub(ys, i0 -xlist_size(xs)))
|
xlist_reverse(xs) => xlist_sub(xs, xlist_size(xs) - i0 - 1)
|
xlist_nil => raise XlistSubscript
);
