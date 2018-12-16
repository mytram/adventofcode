require 'ostruct'
require 'date'

def assert_truthy(value)
  return if value
  raise "assertion failure: #{value} is not truthy"
end

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
require './lib/day_04_solver'
require './lib/day_05_solver'
