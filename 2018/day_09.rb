require './lib/solver'

game = Day09Solver::MarbleGame.new(players: 9, last_marble_points: 25)

marbles = 25.times.map do
  game.place_marble
  game.circle.data
end

assert marbles.last, [25, 10, 21, 5, 22, 11, 1, 12, 6, 13, 3, 14, 7, 15, 0, 16, 8, 17, 4, 18, 19, 2, 24, 20]

assert game.max_score, 32

solver = Day09Solver.new

assert solver.call(players: 10, last_marble_points: 1618), 8317

assert solver.call(players: 13, last_marble_points: 7999), 146373

puts Benchmark.measure {
  assert solver.call(players: 427, last_marble_points: 70723), 399745
}

puts Benchmark.measure {
  assert solver.call(players: 427, last_marble_points: 70723 * 100), 3349098263
}
