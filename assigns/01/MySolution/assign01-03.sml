use "./../assign01.sml";
use "./../MySolution/assign01-02.sml";

fun xlist_remove_reverse(xs: 'a xlist): 'a xlist =
  (
    case xs of
    xlist_nil => xlist_nil
    |
    xlist_cons(x1, xs) => xlist_cons(x1, xlist_remove_reverse(xs)) 
    |
    xlist_snoc(xs, x1) => xlist_snoc(xlist_remove_reverse(xs), x1)
    |
    xlist_append(xs, ys) => xlist_append(xlist_remove_reverse(xs), xlist_remove_reverse(ys))
    |
    xlist_reverse(xs) => case xs of
    xlist_nil => xlist_nil
    |
    xlist_cons(x1, xs) => xlist_snoc(xlist_remove_reverse(xs), x1)
    |
    xlist_snoc(xs, x1) => xlist_cons(x1, xlist_remove_reverse(xs))
    |
    xlist_append(xs, ys) => xlist_append(xlist_remove_reverse(ys), xlist_remove_reverse(xs))
    |
    xlist_reverse(xs) => xlist_remove_reverse(xs)
  )
