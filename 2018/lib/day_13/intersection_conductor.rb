module Day13
  class IntersectionConductor
    class CircularNode
      attr_accessor :next_node, :value

      def initialize(value, next_node: nil)
        @value = value
        @next_node ||= self # root node
      end

      def next
        @next_node
      end
    end

    def initialize(instructions = [:left, nil, :right].freeze)
      @turn_instruction_link = load_turn_instruction_link(instructions)
    end

    def next_direction(current)
      direction = @turn_instruction_link.value
      @turn_instruction_link = @turn_instruction_link.next

      return current if direction.nil?

      case current
      when :up
        direction
      when :down
        if direction == :left
          :right
        else
          :left
        end
      when :left
        if direction == :left
          :down
        else
          :up
        end
      when :right
        if direction == :left
          :up
        else
          :down
        end
      end
    end

    private

    def load_turn_instruction_link(instructions)
      nodes = instructions.map { |v| CircularNode.new(v) }

      (0...(nodes.size - 1)).each { |i| nodes[i].next_node = nodes[i + 1] }

      nodes.last.next_node = nodes.first
    end
  end
end
