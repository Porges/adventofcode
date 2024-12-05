haystack ← ↑⊃⎕NGET 'input4' 1
needle ← 'XMAS'
rotations ← {(⍳4) ∘.{(⌽∘⍉⍣⍺) ⍵} ⊂⍵} ⋄ diag ← 1 1∘⍉
diags ← {+/ {needle ≡ diag ⍵} ¨ rotations ⍵}
diag_count ← +/, diags ⌺ (2 ⍴ ≢needle) ⊢ haystack
orth_count ← +/, ↑ {needle ⍷ ⍵} ¨ rotations haystack
'Part one: ', (diag_count + orth_count)

needle ← 'MAS'
is_cross ← {2 ≡ +/ {needle ≡ diag ⍵} ¨ rotations ⍵}
cross_count ← +/, is_cross ⌺ (2 ⍴ ≢needle) ⊢ haystack
'Part two: ', cross_count
