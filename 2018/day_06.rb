require './lib/solver'

lines = [
  '1, 1',
  '1, 6',
  '8, 3',
  '3, 4',
  '5, 5',
  '8, 9'
]

solver = Day06Solver.new(lines)

assert solver.call, [17, 4]
assert solver.finite_areas.keys.sort, [3, 4]

# solver.transpose.each { |row| puts row.map { |i| i == -1 ? '.' : i.to_s }.join }

lines = Day06Solver.raw_input
solver = Day06Solver.new(lines)
assert solver.call, [5429, 49]
