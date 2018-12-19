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
end

class Day11Solver < SolverBase
  def call(serial)
    grid = Day11Solver::Grid.new(300, 300, serial)
    scan(grid).max_by { |e| e.first }
  end

  def call2(serial)
    grid = Day11Solver::Grid.new(300, 300, serial)
    scan_all_sizes(grid).max_by { |e| e.first }
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

  def scan_all_sizes(grid)
    subgrids = []
    (0...grid.row).each do |x|
      (0...grid.column).each do |y|
        (1...grid.row).each do |size|
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

    subgrids
  end
end
