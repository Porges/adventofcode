{
    L[NR] = $1
    R[$2] += 1
}

END {
    for (i = 1; i <= NR; i++) {
        RESULT += L[i] * R[L[i]]
    }
    print RESULT
}
