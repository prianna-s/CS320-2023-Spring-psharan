use "./magic_triangle.sml";


(* testing *)
val test_cases = [
    ([[]], 0),
    ([[1]], 1),
    ([[1], [1, 1]], 2),
    ([[1], [1, 1], [1, 2, 1]], 3),
    ([[1], [1, 1], [1, 2, 1], [1, 3, 3, 1]], 4),
    ([[1], [1, 1], [1, 2, 1], [1, 3, 3, 1], [1, 4, 6, 4, 1]], 5)
]

fun test () =
    let
        fun test_case (expected, n) =
            let
                val result = magic_triangle n
            in
                if List.length expected = List.length result 
                then "Pass"
                else "Fail"
            end
    in
        List.map test_case test_cases
    end



