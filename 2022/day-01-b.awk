/^$/ { ix += 1 }
{ sums[ix] += $1 }

END { 
    top = 3
    n = asort(sums)
    for (i = 0; i < top; ++i) {
        result += sums[n-i]
    }

    print "TOP " top ": " result
}
