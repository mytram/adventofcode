#

class Day02
  ADD = 1
  MUL = 2
  HALT = 99

  def solve_a(codes)
    # replace position 1 with the value 12 and replace position 2 with
    # the value 2.
    attempt(codes, 12, 2)
  end

  def solve_b(codes)
    (0..99).each do |noun|
      (0..99).each do |verb|
        result = attempt(codes, noun, verb)

        return 100 * noun + verb if result == 19690720
      end
    end
  end

  private

  def execute(ic, codes)
    case codes[ic]
    when ADD
      a, b = codes[codes[ic + 1]], codes[codes[ic + 2]]
      codes[codes[ic + 3]] = a + b

      ic + 4
    when MUL
      a, b = codes[codes[ic + 1]], codes[codes[ic + 2]]
      codes[codes[ic + 3]] = a * b

      ic + 4
    when HALT
      nil
    else
      nil
    end
  end

  def attempt(codes, noun, verb)
    codes = codes.clone
    codes[1], codes[2] = noun, verb

    ic = 0

    loop do
      ic = execute(ic, codes)
      break if ic.nil?
    end

    codes.first
  end
end

def main
  codes = File.open('data/day02.txt').readlines
            .first
            .split(',')
            .reject { |item| item.strip.empty? }
            .map(&:to_i)

  solver = Day02.new
  puts solver.solve_a(codes)

  puts solver.solve_b(codes)
end

main
