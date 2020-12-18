require 'set'

sets = []

set = []
$stdin.each_line(chomp: true) do |line| 
  if line.empty? then
    sets.push(set)
    set = []
  else 
    set.push Set.new line.split //
  end
end

sets.push set # handle EOF leftovers

puts sets.map {|g| g.reduce(:|).length }.sum
puts sets.map {|g| g.reduce(:&).length }.sum
