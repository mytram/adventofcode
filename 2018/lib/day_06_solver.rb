class Day06Solver < SolverBase
  class Point
    attr_reader :x, :y

    def initialize(x, y)
      @x = x
      @y = y
    end

    def to_s
      "(#{x},#{y})"
    end
  end

  def call
    finite_areas.map do |i, v|
      [v.size, i]
    end.max
  end

  def call2
  end

  def plane
    # Calculate a bigger plane to build margin of safety
    @plane ||= Array.new(points.map(&:x).max + 4) do
      Array.new(points.map(&:y).max + 4)
    end
  end

  def finite_areas
    point_map.reject { |_, area| infinite?(area) }
  end

  # Get the plane the same as the example.
  # Otherwise it doesn't matter.
  def transpose
    rows = plane.size
    columns = plane.first.size

    new_plane = Array.new(columns) { Array.new(rows) }

    (0...rows).each do |x|
      (0...columns).each do |y|
        new_plane[y][x] = plane[x][y]
      end
    end

    new_plane
  end

  private

  def parse_to_points(lines)
    lines.map do |line|
      x, y = line.split(', ')
      Point.new(x.to_i, y.to_i)
    end
  end

  def distance(p1, p2)
    (p1.x - p2.x).abs + (p1.y - p2.y).abs
  end

  def points
    @points ||= parse_to_points(input)
  end

  def point_map
    if @point_map.nil?
      @point_map = Hash[(0...points.size).map { |i| [i, []] }]
      map_by_distance(point_map)
    end
    @point_map
  end

  def map_by_distance(point_map)
    plane.each_with_index do |row, x|
      row.each_with_index do |_, y|
        p = Point.new(x, y)
        distances = points.each_with_index.map do |point, i|
          [distance(point, p), i]
        end.sort

        i = distances[0][1]
        if distances[0][0] < distances[1][0]
          plane[x][y] = i
          point_map[i] << p
        else
          plane[x][y] = -1
        end
      end
    end
  end

  def infinite?(area)
    area.each do |p|
      return true if p.x.zero? || p.y.zero?

      [p.x - 1, p.x + 1].each do |new_x|
        return true if plane[new_x].nil? || plane[new_x][p.y].nil?
      end

      [p.y - 1, p.y + 1].each do |new_y|
        return true if plane[p.x][new_y].nil?
      end
    end

    false
  end

  public

  def self.raw_input
    <<-eos.lines.map(&:strip).reject(&:empty?)
63, 142
190, 296
132, 194
135, 197
327, 292
144, 174
103, 173
141, 317
265, 58
344, 50
184, 238
119, 61
329, 106
70, 242
272, 346
312, 166
283, 351
286, 206
57, 225
347, 125
152, 186
131, 162
45, 299
142, 102
61, 100
111, 218
73, 266
350, 173
306, 221
42, 284
150, 122
322, 286
346, 273
75, 354
68, 124
194, 52
92, 44
77, 98
77, 107
141, 283
87, 306
184, 110
318, 343
330, 196
303, 353
268, 245
180, 220
342, 337
127, 107
203, 127
eos
  end
end
