module Day13
  class FieldControl
    attr_reader :carts

    def initialize(field, carts:, steps_per_tick: nil)
      @field = field
      @carts = carts
      @steps_per_tick = steps_per_tick || 1
    end

    def tick
      @carts = @carts.sort_by { |cart| [cart.row, cart.column] }

      @carts.each do |cart|
        cart.move(@steps_per_tick, track: track(cart.row, cart.column))
        position = collision_position

        return position if collision_position
      end

      nil
    end

    def tick_remove_but_one
      @carts = @carts.sort_by { |cart| [cart.row, cart.column] }

      @carts.each do |cart|
        next if cart.removed

        cart.move(@steps_per_tick, track: track(cart.row, cart.column))
        position = collision_position

        if position
          @carts.each do |c|
            c.removed = true if position[0] == c.column && position[1] == c.row
          end
        end
      end

      @carts = @carts.reject(&:removed?)
    end

    def track(row, column)
      @field[row][column]
    end

    def display
      field = @field.map(&:clone)

      @carts.each do |cart|
        symbol = case cart.direction
                 when :up
                   '^'
                 when :down
                   'v'
                 when :left
                   '<'
                 when :right
                   '>'
                 end
        field[cart.row][cart.column] = symbol
      end

      column, row = collision_position || []
      field[row][column] = 'X' if column

      field.map do |line|
        line.map { |c| c || ' ' }.join
      end
    end

    def collision_position
      positions = {}

      @carts.reject(&:removed?).each do |c|
        return [c.column, c.row] if positions.key? [c.row, c.column]

        positions[[c.row, c.column]] = c
      end

      nil
    end
  end
end
