function embiggen(arr, increase)
  result = falses(increase*2 .+ size(arr))
  result[[1:n for n=size(arr)]...] = arr
  return result
end 

neighbours = [(x, y, z) for x=-1:1, y=-1:1, z=-1:1 if (x,y,z) != (0,0,0)]

function neighbour_count(arr)
  return sum(map(shift -> circshift(arr, shift), neighbours))
end

function evolve(x, n)
  x = embiggen(x, n)
  for it=1:n
    cs = neighbour_count(x)
    x = (cs .== 3) .| (x .& (cs .== 2))
  end
  return x
end

input="##..#.#.\n#####.##\n#######.\n#..#..#.\n#.#...##\n..#....#\n....#..#\n..##.#.."

init = hcat([[x == '#' for x=line] for line=split(input)]...)
init = reshape(BitArray(init), size(init)..., 1)
println(sum(evolve(init, 6)))
