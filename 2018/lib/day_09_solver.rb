class Day09Solver < SolverBase
  class Node
    attr_accessor :data, :left, :right

    def initialize(data, left: nil, right: nil)
      @data = data
      @left = left || self
      @right = right || self
    end

    def to_s
      "[#{@left.data} #{data} #{@right.data}]"
    end
  end

  class GameCircle
    attr_reader :current_node

    def initialize
      @current_node = Node.new(0)
    end

    def data
      data = [@current_node.data]
      node = @current_node.right

      while node != @current_node
        data << node.data
        node = node.right
      end

      data
    end

    def to_s
      nodes = [@current_node]
      node = @current_node.right

      while node != @current_node
        nodes << node
        node = node.right
      end

      nodes.map(&:to_s).join(' ')
    end

    def move_left(n = 1)
      n.times do
        @current_node = @current_node.left
      end

      self
    end

    def move_right(n = 1)
      n.times do
        @current_node = @current_node.right
      end

      self
    end

    def single_node?
      @current_node.left == @current_node
    end

    def insert(data)
      node = Node.new(data, left: @current_node, right: @current_node.right)

      @current_node.left = node  if single_node?

      @current_node.right.left = node
      @current_node.right = node

      @current_node = node

      self
    end

    def delete
      deleted = @current_node

      if single_node?
        @current_node = nil
      else
        previous_node = @current_node.left
        next_node = @current_node.right

        previous_node.right = @current_node.right
        next_node.left = @current_node.left

        @current_node = @current_node.right
      end

      deleted
    end
  end

  class MarbleGame
    attr_reader :circle, :current_player, :play_scores

    def initialize(players:, last_marble_points:)
      @players = players
      @last_marble_points = last_marble_points

      @current_marble_point = 0
      @circle = GameCircle.new

      @player_scores = Hash[players.times.map { |i| [i, 0]}]
      @current_player = -1
    end

    def play
      place_marble while @current_marble_point < @last_marble_points
    end

    def max_score
      @player_scores.values.max
    end

    def place_marble
      @current_player = (@current_player + 1) % @players
      @current_marble_point += 1

      if (@current_marble_point % 23).zero?
        @player_scores[@current_player] += @current_marble_point +
                                           @circle.move_left(7).delete.data
      else
        @circle.move_right.insert(@current_marble_point)
      end
    end
  end

  def call(players:, last_marble_points:)
    game = MarbleGame.new(players: players,
                          last_marble_points: last_marble_points)
    game.play
    game.max_score
  end
end
