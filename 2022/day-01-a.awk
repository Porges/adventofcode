/^$/ {
    if (sum > max) {
        max = sum
    }

    sum = 0
}

{ sum += $1 }

END { print "MAX: " max }
