require './lib/solver'

input = ['2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2']

solver = Day08Solver.new(input)
assert solver.call.metadata_sum, 138
assert solver.call.value, 66

solver = Day08Solver.new
assert solver.call.metadata_sum, 48260
assert solver.call.value, 25981
