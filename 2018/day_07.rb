require './lib/solver'

lines = <<-eos.lines
Step C must be finished before step A can begin.
Step C must be finished before step F can begin.
Step A must be finished before step B can begin.
Step A must be finished before step D can begin.
Step B must be finished before step E can begin.
Step D must be finished before step E can begin.
Step F must be finished before step E can begin.'
eos

solver = Day07Solver.new(lines)
assert solver.root_actions, ['C']
assert solver.call2(workers: 2, delay: 0), 15

solver = Day07Solver.new
assert solver.call2(workers: 5, delay: 60), 1020
