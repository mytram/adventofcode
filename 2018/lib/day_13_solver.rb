require './lib/day_13/intersection_conductor'
require './lib/day_13/cart'
require './lib/day_13/field_control'

class Day13Solver < SolverBase
  def call
    Day13::FieldControl.new(field, carts: carts)
  end

  def control
    @control ||= Day13::FieldControl.new(field, carts: carts)
  end

  def field
    @field ||= parse_for_field
  end

  def carts
    @carts ||= find_carts
  end

  private

  CART_TRACK_MAP = {
    '^' => '|',
    'v' => '|',
    '>' => '-',
    '<' => '-'
  }.freeze

  CART_DIRECTION_MAP = {
    '^' => :up,
    'v' => :down,
    '>' => :right,
    '<' => :left
  }.freeze

  def find_carts
    id = 0
    field.each_with_index.flat_map do |row, r|
      row.each_with_index.map do |cell, c|
        if CART_TRACK_MAP[cell]
          field[r][c] = CART_TRACK_MAP[cell]
          id += 1
          Day13::Cart.new(
            row: r, column: c, direction: CART_DIRECTION_MAP[cell],
            cart_id: id - 1,
          )
        end
      end
    end.reject(&:nil?)
  end

  def parse_for_field
    input.reject(&:empty?).map(&:chomp).map(&:chars)
  end
end
