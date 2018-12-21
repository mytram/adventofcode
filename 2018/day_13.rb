require './lib/solver'

input = <<'eos'.lines
/->-\
|   |  /----\
| /-+--+-\  |
| | |  | v  |
\-+-/  \-+--/
  \------/
eos

solver = Day13Solver.new(input)

reinput = solver.field.map { |line| line.map { |c| c || ' ' }.join }

assert reinput, input.map(&:chomp)

carts = solver.carts

assert carts.count, 2

control = solver.control

collision_position = control.collision_position

collision_position = control.tick while collision_position.nil?

assert collision_position, [7, 3]

solver = Day13Solver.new

control = solver.control

collision_position = control.collision_position

collision_position = control.tick while collision_position.nil?

assert collision_position, [8, 9]

solver = Day13Solver.new

control = solver.control

loop do
  control.tick_remove_but_one
  puts control.carts.count
  break if control.carts.count == 1
end

puts "#{control.carts.first}"
