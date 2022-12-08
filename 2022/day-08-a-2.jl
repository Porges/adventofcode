input = parse.(Int64, reduce(hcat, collect.(readlines())))

function visible(ix)
  range(k, from, to) = Base.setindex(ix, from, k):Base.setindex(ix, to, k)
  return any(input[ix] .>
    [maximum(input[r], init=-1) for k=eachindex(Tuple(ix))
     for r=(range(k, 1,       ix[k]-1),
            range(k, ix[k]+1, size(input, k)))])
end

println(sum([visible(ix) for ix=CartesianIndices(input)]))
