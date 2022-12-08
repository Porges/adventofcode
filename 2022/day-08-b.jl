input = parse.(Int64, reduce(hcat, collect.(readlines())))

function score(x, v)
    return something(findfirst(x .<= v), size(v, 1))
end

function scenic_score(i, j)
    x = input[i, j]
    return score(x, vec(input[i-1:-1:begin, j])) *
           score(x, vec(input[i+1: 1:end,   j])) *
           score(x, vec(input[i, j-1:-1:begin])) *
           score(x, vec(input[i, j+1: 1:end  ]))
end

println(maximum([scenic_score(i, j) for i=axes(input, 1) for j=axes(input, 2)]))
