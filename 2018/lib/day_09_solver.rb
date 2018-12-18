class Day09Solver < SolverBase
  class Node
    attr_accessor :data, :left, :right

    def initialize(data, left:, right:)
      @data = data
      @left = left || self
      @right = right || self
    end
  end

  class GameCircle
    attr_reader :current_node

    def initialize
      @current_node = Node.new(0)
    end

    def move_left(n)
      n.times do
        @current_node = @current_node.left
      end

      self
    end

    def move_right(n)
      n.times do
        @current_node = @current_node.right
      end

      self
    end

    def insert(data)
      node = Node.new(data, left: @current_node, right: @current_node.right)
      @current_node.right = node

      self
    end

    def delete
      deleted = @current_node

      if @current_node.left == @current_node
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

  attr_reader :circle, :player_scores

  def call(players:, last_marble_points:)
    start_game(players: players, last_marble_points: last_marble_points)
    play
  end

  def max_score
    @player_scores.max_by do |(k, scores)|
      scores.sum
    end[1].sum
  end

  def start_game(players:, last_marble_points:)
    @circle = Array.new(1)

    @current_marble_position = 0

    @current_marble_point = 0

    @circle[0] = @current_marble_point

    @players = players

    @last_marble_points = last_marble_points
    @player_scores = Hash[players.times.map { |i| [i, []] }]
    @current_player = -1
  end

  def play
    while @current_marble_point < @last_marble_points
      play_marble
    end
  end

  def play_marble
    update_current_player

    @current_marble_point += 1
    if (@current_marble_point % 23).zero?
      @player_scores[@current_player] << @current_marble_point

      7.times do
        @current_marble_position -= 1
        if @current_marble_position.negative?
          @current_marble_position = @circle.size - 1
        end
      end

      @player_scores[@current_player] << @circle.delete_at(@current_marble_position)

      @current_marble_position = 0 if @circle[@current_marble_position].nil?
    else
      update_current_marble_position
      @circle.insert(@current_marble_position, @current_marble_point)
    end
  end

  def update_current_marble_position
    @current_marble_position += 1
    @current_marble_position = 0 if @current_marble_position == @circle.size
    @current_marble_position += 1
  end

  def update_current_player
    @current_player += 1

    @current_player = 0 if @current_player >= @players

    @current_player
  end
end
