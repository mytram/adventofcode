# Fuel required to launch a given module is based on its
# mass. Specifically, to find the fuel required for a module, take its
# mass, divide by three, round down, and subtract 2.

class Day01
  def solve_a(lines)
    lines.map { |mass| cal_fuel mass }
      .sum
  end

  def solve_b(lines)
    lines.map { |mass| cal_compounded_fuel mass }
      .sum
  end

  private

  def cal_fuel(mass)
    (mass / 3.0).to_i - 2
  end

  def cal_compounded_fuel(mass)
    Enumerator.new do |y|
      loop do
        fuel = cal_fuel(mass)

        break unless fuel.positive?

        y << fuel
        mass = fuel
      end
    end.sum
  end
end

lines = File.open('./data/day01.txt').readlines
          .reject { |line| line.strip.empty? }
          .map(&:to_i)

solver = Day01.new
result = solver.solve_a(lines)

puts result # 3375962

result = solver.solve_b(lines)

puts result
