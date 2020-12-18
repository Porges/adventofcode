' input values in an easy-to-edit manner
DIM Nums(1 TO 7) AS LONG
Nums(1) = 0
Nums(2) = 1
Nums(3) = 4
Nums(4) = 13
Nums(5) = 15
Nums(6) = 12
Nums(7) = 16

' set Target to 2020 for PART 1
Target& = 30000000

' store last 2 occurences of the numbers
DIM Prev(100000000) AS LONG, Last(100000000) AS LONG
FOR ix = LBOUND(Nums) TO UBOUND(Nums)
    Last(Nums(ix)) = ix
NEXT ix

' important to dimension these properly for it to work
DIM last AS LONG, ix AS LONG

last = Nums(UBOUND(Nums))
FOR ix = UBOUND(Nums) + 1 TO Target&
    IF Prev(last) = 0 THEN
        last = 0
    ELSE
        last = Last(last) - Prev(last)
    END IF

    Prev(last) = Last(last)
    Last(last) = ix
NEXT ix

PRINT last
