#

class Day05
  ADD = { code: 1, length: 4, num_of_params: 2 }
  MUL = { code: 2, length: 4, num_of_params: 2 }
  IN  = { code: 3, length: 2, num_of_params: 1 }
  OUT = { code: 4, length: 2, num_of_params: 1 }
  JIT = { code: 5, length: 3, num_of_params: 2 }
  JIF = { code: 6, length: 3, num_of_params: 2 }
  LT  = { code: 7, length: 4, num_of_params: 2 }
  EQ  = { code: 8, length: 4, num_of_params: 2 }

  HALT = 99

  MODE_POSITION  = 0
  MODE_IMMEDIATE = 1

  def solve_a(codes)
    # 13818007
    start(codes, 1).last
  end

  def solve_b(codes)
    # 3176266
    start(codes, 5).last
  end

  private

  def start(codes, input)
    ic = 0
    output = []

    loop do
      ic = execute(ic, codes, input: input, output: output)
      break if ic.nil?
    end

    output
  end

  def execute(ic, codes, input:, output:)
    digits = codes[ic].to_s.chars

    opcode = (digits.size > 2 ? digits[-2..-1] : digits).join.to_i

    param_modes = digits[0...-2].reverse.map(&:to_i)

    case opcode
    when ADD[:code]
      a, b = get_params(ic, codes, param_modes, 2)
      codes[codes[ic + 3]] = a + b

      ic + ADD[:length]
    when MUL[:code]
      a, b = get_params(ic, codes, param_modes, 2)
      codes[codes[ic + 3]] = a * b

      ic + MUL[:length]
    when IN[:code]
      codes[codes[ic + 1]] = input

      ic + IN[:length]
    when OUT[:code]
      output << get_value(ic + 1, codes, param_modes[0])

      ic + OUT[:length]
    when JIT[:code]
      a, b = get_params(ic, codes, param_modes, 2)

      !a.zero? ? b : ic + JIT[:length]
    when JIF[:code]
      a, b = get_params(ic, codes, param_modes, 2)

      a.zero? ? b : ic + JIT[:length]
    when LT[:code]
      a, b = get_params(ic, codes, param_modes, 2)
      codes[codes[ic + 3]] = a < b ? 1 : 0

      ic + LT[:length]
    when EQ[:code]
      a, b = get_params(ic, codes, param_modes, 2)
      codes[codes[ic + 3]] = a == b ? 1 : 0

      ic + EQ[:length]
    when HALT
      nil
    else
      nil
    end
  end

  def get_value(position, codes, param_mode)
    if param_mode == MODE_IMMEDIATE
      codes[position]
    else
      codes[codes[position]]
    end
  end

  def get_params(ic, codes, param_modes, n)
    n.times.map do |i|
      get_value(ic + i + 1, codes, param_modes[i])
    end
  end
end

def main
  codes = File.open('data/day05.txt').readlines
            .first
            .split(',')
            .reject { |item| item.strip.empty? }
            .map(&:to_i)

  solver = Day05.new
  puts solver.solve_a(codes.clone)
  puts solver.solve_b(codes.clone)
end

main
