require './lib/solver'

solver = Day09Solver.new

solver.start_game(players: 9, last_marble_points: 25)
assert solver.circle, [0]

solver.play_marble
assert solver.circle, [0, 1]

solver.play_marble
assert solver.circle, [0, 2, 1]

solver.play_marble
solver.circle.inspect

solver.play_marble
solver.circle.inspect

solver.play_marble
assert solver.circle, [0, 4, 2, 5, 1, 3]

solver.play_marble
assert solver.circle, [0, 4, 2, 5, 1, 6, 3]

solver = Day09Solver.new

solver.call(players: 9, last_marble_points: 25)
puts solver.player_scores
puts solver.max_score.inspect

solver.call(players: 10, last_marble_points: 1618)

assert solver.max_score, 8317

# 13 players; last marble is worth 7999 points: high score is  8317
solver.call(players: 13, last_marble_points: 7999)
assert solver.max_score, 146373

solver.call(players: 427, last_marble_points: 70723)
puts solver.max_score

solver.call(players: 427, last_marble_points: 70723 * 100)
puts solver.max_score
