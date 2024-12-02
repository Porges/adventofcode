{
    L[NR] = $1
    R[NR] = $2
}

function abs(x) { return x < 0 ? -x : x }

END {
    asort(L)
    asort(R)
    for (ix in L) {
        SUM += abs(L[ix] - R[ix])
    }
    print SUM
}
