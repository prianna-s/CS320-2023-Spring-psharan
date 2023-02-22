use "./../../../mysmlib/mysmlib-cls.sml";


fun quiz02_01 (word: string) : int =
  let
    fun count c =
      let
        val chars = explode word
        fun countHelper ([], acc) = acc
          | countHelper (x::xs, acc) =
            if x = c then countHelper (xs, acc + 1)
            else countHelper (xs, acc)
      in
        countHelper (chars, 0)
      end
  in
    count #"a"
  end;