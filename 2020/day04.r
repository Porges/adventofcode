REBOL [
       Title: "Day 4"
       Author: "George Pollard"
]

digits: charset [#"0" - #"9"]
letters: charset [#"a" - #"z"]
hexDigits: charset [#"0" - #"9" #"a" - #"f"]

numInRange: func [minValue maxValue] [
        func [x] compose [
                x: to-integer x
                okMin: x >= (minValue)
                okMax: x <= (maxValue)
                okMin and okMax
        ]
]

BirthYear: make object! [ field: "byr" validation: numInRange 1920 2002 ]
IssueYear: make object! [ field: "iyr" validation: numInRange 2010 2020 ]
ExpirationYear: make object! [ field: "eyr" validation: numInRange 2020 2030 ]
HairColor: make object! [ field: "hcl" validation: func [x]  [ parse/all x ["#" 6 hexDigits] ] ]
EyeColor: make object! [ field: "ecl" validation: func [x] [ parse/all x ["amb" | "blu" | "brn" | "gry" | "grn" | "hzl" | "oth"] ] ]
PassportID: make object! [ field: "pid" validation: func [x]  [ parse/all x [9 digits] ] ]

Height: make object! [
        field: "hgt"
        validation: function [x] [valid parseCM parseIN parsed] [
                valid: false
                parseCM: func [x] [ x: to-integer x valid: (x >= 150) and (x <= 193) ]
                parseIN: func [x] [ x: to-integer x valid: (x >= 59) and (x <= 76) ]
                parse/all x [copy v some digits [ "in" (parseIN v) | "cm" (parseCM v) ] ]
                valid
        ]
]

Required: reduce [BirthYear IssueYear ExpirationYear Height HairColor EyeColor PassportID]

spacer: charset reduce [newline #" "]
non-space: complement spacer
value: [copy k [some letters] ":" copy v [some non-space] (append current-record reduce [k v]) skip]
record: [(current-record: make hash! []) some value (append/only records current-record)]
file: [record any ["^/" record] end]

records: make block! 0
data: %/home/george/day4.txt
either parse/all read data file [
        print [length? records "records"]
] [
        throw "unable to parse input"
]


valid: 0
foreach record records [
        isValid: foreach x Required [
                either find record x/field [
                        either x/validation record/(x/field) [
                                true
                        ] [
                                print ["invalid" x/field record/(x/field)]
                                break/return false
                        ]
                ] [
                        print ["missing" x/field]
                        break/return false
                ]
        ]

        if isValid [
                valid: valid + 1
        ]
]

print [valid "valid"]
