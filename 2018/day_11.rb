require './lib/solver'

cell = Day11Solver::Cell.new(3 - 1, 5 - 1, 8)
assert cell.power_level, 4

cell = Day11Solver::Cell.new(122 - 1, 79 - 1, 57)
assert cell.power_level, -5

cell = Day11Solver::Cell.new(217 - 1, 196 - 1, 39)
assert cell.power_level, 0

cell = Day11Solver::Cell.new(101 - 1, 153 - 1, 71)
assert cell.power_level, 4

# grid = Day11Solver::Grid.new(300, 300, 18)

solver = Day11Solver.new

power, cell = solver.call(18)
assert "#{power} #{cell}", '29 cell(33, 45)'

power, cell = solver.call(42)
assert "#{power} #{cell}", '30 cell(21, 61)'

power, cell = solver.call(1718)
assert "#{power} #{cell}", '31 cell(243, 34)'

# power, cell, size = solver.call2(18)
# assert "#{power} #{cell} #{size}", '113 cell(90, 269) 16'
