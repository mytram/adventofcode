module Day13
  class Cart
    attr_accessor :row, :column, :removed
    attr_reader :direction, :turn_conductor

    def initialize(row:, column:, direction:, cart_id: nil)
      @cart_id = cart_id
      @row, @column = row, column
      @direction = direction
      @turn_conductor = IntersectionConductor.new
      @removed = false
    end

    def to_s
      "#{@cart_id} (#{column}, #{row}) #{direction}"
    end

    def removed?
      @removed
    end

    def move(steps = 1, track:)
      orient(track)
      move_by steps, direction: @direction
    end

    private

    def orient(track)
      illegal_move = "illegal move: cart=#{self} track=#{track}"

      @direction = if track == '+'
                     turn_conductor.next_direction(@direction)
                   else
                     orient_map[track][@direction]
                   end

      raise illegal_move if @direction.nil?
    end

    ORIENT_MAP = {
      '|' => {
        up: :up,
        down: :down
      }.freeze,
      '-' => {
        left: :left,
        right: :right
      }.freeze,
      '/' => {
        up: :right,
        down: :left,
        left: :down,
        right: :up
      }.freeze,
      '\\' => {
        up: :left,
        down: :right,
        left: :up,
        right: :down
      }.freeze
    }.freeze

    def orient_map
      ORIENT_MAP
    end

    def move_by(steps, direction:)
      case direction
      when :up
        @row -= steps
      when :down
        @row += steps
      when :left
        @column -= steps
      when :right
        @column += steps
      end
    end
  end
end
