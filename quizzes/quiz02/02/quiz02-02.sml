use "./../../../mysmlib/mysmlib-cls.sml"

val abs = fn(x:int) => if x >= 0 then x else ~x

fun quiz02_02 (lists: int list * int list) : bool =
    let
        fun check (x: int, ys: int list) : bool =
            case ys of
                [] => false
              | y::ys' => if abs(x-y) < 10 then true else check(x, ys')
    in
        case lists of
            ([], _) => false
          | (x::xs', ys) => if check(x, ys) then true else quiz02_02(xs', ys)
    end;