class Solver
  attr_reader :input

  def initialize(input)
    @input = input
  end

  private

  def asset(actual, expected)
    raise "assertion failure: expected: #{expected.inspect}\nactual: #{actual.inspect}"
  end
end
