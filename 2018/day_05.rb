require './lib/solver'

line = 'dabAcCaCBAcCcaDA'
solver = Day05Solver.new(line)

assert solver.call, 'dabCBAcaDA'
assert solver.call.size, 10

input = Day05Solver.raw_input
assert input.chars.first, 'i'
assert input.chars.last, 'k'

solver = Day05Solver.new(input)
assert solver.call.size, 9348
assert solver.call2, 4996

__END__
