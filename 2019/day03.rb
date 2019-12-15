#

class Solver
  UP    = 'U'
  DOWN  = 'D'
  RIGHT = 'R'
  LEFT  = 'L'

  def solve_a(wires)
    map = {}
    wires.each_with_index do |wire, index|
      lay_wire(wire: wire, label: index, map: map)
    end

    position, _ = find_closet_crossing(map: map)

    position.map(&:abs).sum
  end

  def solve_b(wires)
    map = {}
    wires.each_with_index do |wire, index|
      lay_wire(wire: wire, label: index, map: map)
    end

    map.reject { |_, labels| labels.size < 2 }
      .map { |_, labels| labels.values.sum }
      .min
  end

  private

  def lay_wire(wire:, label:, map:)
    x, y = 0, 0 # central port

    wire.each do |position|
      direction = position[0]
      steps = position[1..].to_i

      case direction
      when UP
        (y + 1..y + steps).each do |ny|
          mark_map(map, x: x, y: ny, label: label, from: [x, ny - 1])
        end

        y += steps
      when DOWN
        (y - steps..y - 1).reverse_each do |ny|
          mark_map(map, x: x, y: ny, label: label, from: [x, ny + 1])
        end
        y -= steps
      when RIGHT
        (x + 1..x + steps).each do |nx|
          mark_map(map, x: nx, y: y, label: label, from: [nx - 1, y])
        end
        x += steps
      when LEFT
        (x - steps..x - 1).reverse_each do |nx|
          mark_map(map, x: nx, y: y, label: label, from: [nx + 1, y])
        end
        x -= steps
      else
        raise "Not recoganised #{direction}"
      end
    end

    map
  end

  def find_closet_crossing(map:)
    map.reject do |_, labels|
      labels.size < 2
    end.min_by do |position, _|
      position[0].abs + position[1].abs
    end
  end

  def mark_map(map, x:, y:, label:, from:)
    steps = if from == [0, 0]
              0
            else
                map[from][label]
            end

    key = [x, y]

    map[key] ||= {}

    return if map[key][label]

    map[key][label] = steps + 1
  end
end

# ['R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51',
# 'U98,R91,D20,R16,D67,R40,U7,R15,U6,R7']
# [['R75', 'D30', 'R83', 'U83', 'L12', 'D49', 'R71', 'U7', 'L72'], ['U62', 'R66', 'U55', 'R34', 'D71', 'R55', 'D58', 'R83']]

wires = File.open('data/day03.txt')
          .readlines
          .reject { |item| item.strip.empty? }
          .map { |line| line.split(',').reject(&:empty?) }

# wires = [
#   ['R75', 'D30', 'R83', 'U83', 'L12', 'D49', 'R71', 'U7', 'L72'],
#   ['U62', 'R66', 'U55', 'R34', 'D71', 'R55', 'D58', 'R83']
# ]

# wires = [
#   'R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51',
#   'U98,R91,D20,R16,D67,R40,U7,R15,U6,R7',
# ].map { |line| line.split(',').reject(&:empty?) }

# wires = [
#   'R8,U5,L5,D3',
#   'U7,R6,D4,L4'].map { |line| line.split(',').reject(&:empty?) }

solver = Solver.new

# puts solver.solve_a(wires)
puts solver.solve_b(wires)
