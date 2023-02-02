use "./../assign01.sml";
use "./../MySolution/assign01-03.sml";
use "./../../../mysmlib/mysmlib-cls.sml";
use "./../assign01-lib.sml";

fun exp(i: int, extra: int, n: int): int=
    if n=1 then i
    else if n=0
    then 1
    else exp((i* extra), extra, n-1)

fun str2intHelper (cs: string, n: int): int=
    if String.size(cs)-1 = n
    then (Char.ord(String.sub(cs,n))-48)
    else (str2intHelper(cs, n+1) + ((Char.ord(String.sub(cs,n))-48) * exp(10,10,String.size(cs)-n-1)))

fun str2int(cs :string): int=
    str2intHelper(cs,0)

fun char2int(cs: string, index: int): int =
    Char.ord(String.sub(cs,index))-48;

fun check (cs: string, index: int): bool =
    if char2int(cs, index) >= 0 andalso char2int(cs,index) <= 9
    then true
    else false

fun doStr(cs: string, index: int): bool =
    if String.size(cs) = 0
    then false
    else if (String.size(cs) - 1) = index
    then check(cs, index)
    else if check(cs, index)
    then doStr(cs, index+1)
    else false

fun helperDoStr (cs: string): int option=
    if doStr(cs, 0) = true
    then SOME(str2int(cs))
    else NONE

fun str2int_opt(cs: string): int option =
    helperDoStr(cs)
