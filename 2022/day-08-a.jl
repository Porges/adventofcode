input = parse.(Int64, reduce(hcat, collect.(readlines())))

function visible(i, j)
    return any(input[i, j] .>
        [ maximum(input[begin:i-1, j], init=-1) 
          maximum(input[i+1:end,   j], init=-1) 
          maximum(input[i, begin:j-1], init=-1) 
          maximum(input[i, j+1:end  ], init=-1) ])
end

println(sum([visible(i, j) for i=axes(input, 1) for j=axes(input, 2)]))
