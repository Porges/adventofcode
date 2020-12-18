#!/bin/sh

# done in AWK

# part 1
# (field separators)   count number of times field 3 appears in field 4; if it is correct, increment COUNT. at EOF print COUNT
# (need +0 to coerce to numbers or we will get a string ordering comparison)
awk -F '[: -]+' '{ c = gsub($3, ".", $4); if (c >= ($1+0) && c <= ($2+0)) { COUNT++ } } END { print COUNT }' < day2.txt

# part 2
#      x = check char in field 4 at field 1, y = check char in field 4 at field 2, increment COUNT if either but not both are correct
awk -F '[: -]+' '{ x = substr($4, $1, 1) == $3; y = substr($4, $2, 1) == $3; COUNT += (x || y) && !(x && y) } END { print COUNT }' < day2.txt
