{
    L[NR] = $1
    R[NR] = $2
}

function abs(v) {
    return v < 0 ? -v : v
}

END {
    asort(L)
    asort(R)
    for (i = 1; i <= NR; i++) {
        SUM += abs(L[i] - R[i])
    }
    print SUM
}
