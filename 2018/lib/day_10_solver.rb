class Day10Solver < SolverBase
  class Dot
    attr_accessor :x, :y
    def initialize(position:, velocity:)
      @original_position = position.clone
      @x, @y = position
      @vx, @vy = velocity
    end

    def tick(times = 1)
      @x += @vx * times
      @y += @vy * times
      position
    end

    def position
      [@x, @y]
    end

    def velocity
      [@vx, @vy]
    end

    def adjacent_positions
      [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]]
    end

    def manhattan_distance(other_dot)
      (x - other_dot.x).abs + (y - other_dot.y).abs
    end
  end

  class Sky
    #
    def initialize(dots)
      @dots = dots
      @tick = 0
    end

    def simulate(tick_step = 1_000)
      distance = dot_distance
      @ticks = 0

      while dangling_dots?
        move_dots tick_step
        new_distance = dot_distance

        if new_distance > distance && tick_step == 1
          move_dots(-tick_step)
          break
        end

        if new_distance >= distance && tick_step > 1
          tick_step /= 2
          tick_step = 1 if tick_step.zero?
          move_dots(-tick_step) while new_distance >= dot_distance
        end

        distance = dot_distance
      end

      @ticks
    end

    def move_dots(tick_step)
      @ticks += tick_step
      @dots.each { |dot| dot.tick tick_step }
    end

    # Converging function
    #
    # Minimise the Manhattan distance of all the dots
    #
    def dot_distance
      @dots.map do |dot|
        @dots.map do |other_dot|
          dot.manhattan_distance(other_dot)
        end.sum
      end.sum
    end

    def message
      @dots = shift_message

      plane = Array.new(@dots.map(&:y).max + 1) { [] }

      @dots.each { |d| plane[d.y][d.x] = '#' }

      plane.each_with_index.map do |row, y|
        row.each_with_index.map do |cell, x|
          if x == @you_x && y == @you_y
            'O'
          else
            cell.nil? ? '.' : cell
          end
        end.join
      end.join("\n")
    end

    private

    def dangling_dots?
      coordinates = @dots.map { |dot| [dot.x, dot.y] }

      @dots.any? do |dot|
        # If none of its side has other dot, it is a dangling dot.
        dot.adjacent_positions.none? do |position|
          coordinates.include? position
        end
      end
    end

    def shift_message
      @you_x = -@dots.map(&:x).min
      @you_y = -@dots.map(&:y).min

      translate_dots_by(
        @dots, shift_x: @you_x, shift_y: @you_y
      )
    end

    def translate_dots_by(dots, shift_x:, shift_y:)
      dots.map do |dot|
        Dot.new(position: [dot.x + shift_x, dot.y + shift_y],
                velocity: dot.velocity)
      end
    end
  end
end

class Day10Solver < SolverBase
  def call
    sky.simulate
  end

  def sky
    @sky ||= Sky.new(dots)
  end

  def dots
    @dots ||= parse_for_dots
  end

  private

  def parse_for_dots
    input.map do |line|
      x, y, vx, vy = LINE_REGEX.match(line).captures.map(&:strip).map(&:to_i)
      Dot.new(position: [x, y], velocity: [vx, vy])
    end
  end

  LINE_REGEX = /position=<([- +]?\d+), ([- +]?\d+)> velocity=<([- +]?\d+), ([- +]?\d+)>/
end
