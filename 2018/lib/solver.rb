require 'ostruct'
require 'date'
require 'benchmark'

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
    @input = input || raw_input
  end

  def raw_input
    file_path = File.join(
      File.dirname(File.absolute_path(__FILE__)),
      '../data/',
      "#{self.class.name.sub('Solver', '').downcase}.txt"
    )

    file_path = File.absolute_path(file_path)

    return nil unless File.exist?(file_path)

    File.open(file_path).readlines
  end
end

require './lib/day_03_solver'
require './lib/day_04_solver'
require './lib/day_05_solver'
require './lib/day_06_solver'
require './lib/day_07_solver'
require './lib/day_08_solver'
require './lib/day_09_solver'
require './lib/day_10_solver'
require './lib/day_11_solver'
