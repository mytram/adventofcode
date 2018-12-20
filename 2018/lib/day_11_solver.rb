class Day11Solver < SolverBase
  class Cell
    attr_reader :x, :y, :power_level

    def initialize(x, y, serial)
      @x, @y = x + 1, y + 1
      @serial = serial

      init_power_level
    end

    def to_s
      "cell(#{x}, #{y})"
    end

    private

    def init_power_level
      @rack_id = x + 10
      @power_level = @rack_id * y
      @power_level += @serial
      @power_level *= @rack_id

      @power_level = (@power_level / 100) % 10 - 5
    end
  end

  class Grid
    attr_reader :column, :row

    def initialize(row, column, serial)
      @row = row
      @column = column
      @serial = serial

      @grid = Array.new(@row) { [] }

      set_cells
    end

    def cell(x, y)
      @grid[x] && @grid[x][y]
    end

    private

    def set_cells
      (0...@row).each do |row|
        (0...@column).each do |column|
          @grid[row][column] = Cell.new(row, column, @serial)
        end
      end
    end
  end

  class GridPowerLevelScanner
    attr_reader :grid, :power_levels

    def initialize(grid)
      @grid = grid
      @power_levels = init_power_levels
    end

    def scan(size = nil)
      size ||= grid.row

      (2..size).each do |size|
        puts size

        even = (size % 2).zero?

        (0...grid.row).each do |x|
          break if (x + size) > grid.row

          (0...grid.column).each do |y|
            break if (y + size) > grid.column

            if even
              half = size / 2
              power_level = [
                [x, y, half],
                [x + half, y, half],
                [x, y + half, half],
                [x + half, y + half, half]
              ].map { |k| power_levels.fetch(k) }.sum

              power_levels[[x, y, size]] = power_level
            else
              other_x = x + size - 1
              other_y = y + size - 1

              cells_power_level = (0...size).map { |dy| grid.cell(other_x, y + dy).power_level }.sum
              cells_power_level += (0...size).map { |dx| grid.cell(x + dx, other_y).power_level }.sum

              cells_power_level -= power_levels.fetch([other_x, other_y, 1])

              power_levels[[x, y, size]] = cells_power_level + power_levels[[x, y, size - 1]]
            end
          end
        end
      end

      # puts power_levels[[231, 250, 12]]
    end

    private

    def init_power_levels
      power_levels = {}

      (0...grid.row).each do |x|
        (0...grid.column).each do |y|
          power_levels[[x, y, 1]] = grid.cell(x, y).power_level
        end
      end

      power_levels
    end
  end
end

class Day11Solver < SolverBase
  def call(serial)
    grid = Grid.new(300, 300, serial)
    scan(grid).max_by { |e| e.first }
  end

  def call2(serial, size = nil)
    grid = Grid.new(300, 300, serial)
    scanner = GridPowerLevelScanner.new(grid)
    scanner.scan(size)

    scanner.power_levels.max_by do |(k, v)|
      v
    end.first
  end

  def call3(serial, size = nil)
    grid = Grid.new(300, 300, serial)
    scanner = GridPowerLevelScanner.new(grid)
    scanner.scan(size)

    scanner
  end

  def call4(serial, size = nil)
    grid = Grid.new(300, 300, serial)
    scan_all_sizes(grid)
  end

  private

  def scan(grid)
    subgrids = []
    (0...grid.row).map do |x|
      (0...grid.column).map do |y|
        next if (x + 2) >= grid.row || (y + 2) >= grid.column

        cells = [0, 1, 2].map do |i|
          grid.cell(x + i, y)
        end

        cells += [0, 1, 2].map do |i|
          grid.cell(x + i, y + 1)
        end

        cells += [0, 1, 2].map do |i|
          grid.cell(x + i, y + 2)
        end

        subgrids << [cells.map(&:power_level).sum, cells.first]
      end
    end

    subgrids
  end

  def scan_all_sizes(grid, want = 12)
    subgrids = []
    (0...grid.row).each do |x|
      (0...grid.column).each do |y|
        (1..want).each do |size|
          next if (x + size) > grid.row || (y + size) > grid.column

          cells = []
          (0...size).each do |yi|
            cells += (0...size).map do |xi|
              grid.cell(x + xi, y + yi)
            end
          end

          subgrids << [cells.map(&:power_level).sum, cells.first, size]
        end
      end
    end

    subgrids.max_by { |x| x.first }
  end
end
