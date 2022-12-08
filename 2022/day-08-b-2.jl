input = parse.(Int64, reduce(hcat, collect.(readlines())))

function scenic_score(ix)
  score(x, v) = something(findfirst(x .<= v), size(v, 1))
  range(k, from, to) = Base.setindex(ix, from, k):Base.setindex(ix, to, k)
  return prod(
    [score(input[ix], vec(input[r])) for k=eachindex(Tuple(ix))
     for r=(reverse(range(k, 1,       ix[k]-1)),
                    range(k, ix[k]+1, size(input, k)))])
end

println(maximum([scenic_score(ix) for ix=CartesianIndices(input)]))
