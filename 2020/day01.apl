data ← 1721 979 366 299 675 1456
N ← 2 ⍝ or 3, this is “number of items”

⍝ N combinations X = all combinations of length N+1 from X
combinations←{data←⍵ ⋄ ({, data∘.,⍵}⍣⍺) data}

⍝ product of first combination whose sum equals 2020
×/ ⊃ {(2020=+/¨⍵)/⍵} N combinations data

⍝ output: 241861950
