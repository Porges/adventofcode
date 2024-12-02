{
    L[$1] += 1
    R[$2] += 1
}

END {
    for (n in L) {
        RESULT += n * L[n] * R[n]
    }

    print RESULT
}
