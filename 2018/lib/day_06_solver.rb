class Day06Solver < SolverBase
  def call
    finite_areas.map do |i, v|
      [v.size, i]
    end.max
  end

  def finite_areas
    @finite_areas ||= point_map.reject { |_, area| infinite?(area) }
  end

  def call2(size)
    (0...x_size).flat_map do |x|
      (0...y_size).map do |y|
        points.map { |point| distance_between(point, [x, y]) }.sum
      end
    end.select { |d| d < size }.count
  end

  # Get the plane the same as the example.
  # Otherwise it doesn't matter.
  def transpose
    (0...x_size).inject(create_plan) do |new_plane, x|
      (0...y_size).each { |y| new_plane[y][x] = plane[x][y] }
    end
  end

  private

  def points
    @points ||= parse_to_points(input)
  end

  def parse_to_points(lines)
    lines.map { |l| l.split(', ').map(&:to_i) }
  end

  # Calculate a bigger plane to build a margin of safety

  def plane
    @plane ||= create_plan
  end

  def create_plan
    Array.new(x_size) { Array.new(y_size) }
  end

  def x_size
    @x_size ||= points.map(&:first).max + 100
  end

  def y_size
    @y_size = points.map(&:last).max + 100
  end

  def point_map
    if @point_map.nil?
      @point_map = Hash[(0...points.size).map { |i| [i, []] }]
      map_by_distance(point_map)
    end
    @point_map
  end

  def map_by_distance(point_map)
    (0...x_size).each do |x|
      (0...y_size).each do |y|
        p = [x, y]
        distances = points.each_with_index.map do |point, i|
          [distance_between(point, p), i]
        end.sort # array sort trick

        closest = distances[0][1]
        point_map[closest] << p if distances[0][0] < distances[1][0]
      end
    end
  end

  def distance_between(p1, p2)
    (p1[0] - p2[0]).abs + (p1[1] - p2[1]).abs
  end

  def infinite?(area)
    area.any? do |(x, y)|
      x.zero? || y.zero? || (x + 1) >= x_size || (y + 1) >= y_size
    end
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
