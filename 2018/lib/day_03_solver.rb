class Day03Solver < SolverBase
  def call
    color_plane(plane, claims)

    plane
  end

  def claims
    @claims ||= parse_to_claims @input
  end

  def plane
    @plane ||= make_plane claims
  end

  def self.display_plane(plane)
    plane.each do |row|
      puts row.join('|')
    end
  end

  def self.overlapping_count(plane)
    plane.flatten.reduce(0) do |c, cell|
      c + (cell > 1 ? 1 : 0)
    end
  end

  def overlapped?(claim)
    x, y, x_length, y_length = claim.x, claim.y, claim.x_length, claim.y_length

    (0...x_length).each do |x_move|
      (0...y_length).each do |y_move|
        return true if plane[x + x_move][y + y_move] > 1
      end
    end

    false
  end

  def self.data
    DATA.each_line.map(&:strip).reject(&:empty?)
  end

  private

  def parse_to_claims(lines)
    lines.map do |line|
      captures = /#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/.match(line)
      OpenStruct.new(
        id: captures[1].to_i,
        x: captures[2].to_i,
        y: captures[3].to_i,
        x_length: captures[4].to_i,
        y_length: captures[5].to_i
      )
    end
  end

  def make_plane(claims)
    max_x = claims.map { |f| f.x + f.x_length }.max + 1
    max_y = claims.map { |f| f.y + f.y_length }.max + 1

    Array.new(max_x) { Array.new(max_y, 0) }
  end

  def color_plane(plane, claims)
    claims.each do |claim|
      x, y, x_length, y_length = claim.x, claim.y, claim.x_length, claim.y_length

      (0...x_length).each do |x_move|
        (0...y_length).each do |y_move|
          plane[x + x_move][y + y_move] += 1
        end
      end
    end
  end
end
