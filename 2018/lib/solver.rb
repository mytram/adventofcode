def assert(actual, expected)
  return if actual == expected
  raise "assertion failure: expected: #{expected.inspect}\nactual: #{actual.inspect}"
end

class Solver
  attr_reader :input

  def initialize(input = nil)
    @input = input
  end
end
