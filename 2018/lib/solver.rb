require 'ostruct'

def assert(actual, expected)
  return if actual == expected
  raise "assertion failure: expected: #{expected.inspect}\nactual: #{actual.inspect}"
end

class SolverBase
  attr_reader :input

  def initialize(input = nil)
    @input = input
  end
end

require './lib/day_03_solver'
