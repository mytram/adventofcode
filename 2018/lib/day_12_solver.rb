class Day12Solver < SolverBase
  class Plantation
    attr_reader :right_side, :left_side

    def initialize(initial_state:, recipe:)
      @initial_state = initial_state
      @right_side = @initial_state.chars
      @right_side_recipe = recipe
      @left_side_recipe = Hash[recipe.map { |k, v| [k.reverse, v] }]
      @left_side = []
    end

    def spawn
      r0, r1, = @right_side
      l0, l1, = @left_side # must use the values from the current generation

      @left_side = spawn_one_side(r0, r1, @left_side, recipe: @left_side_recipe)
      @right_side = spawn_one_side(l0, l1, @right_side, recipe: @right_side_recipe)
    end

    def plants
      (@left_side.reverse + @right_side).join
    end

    def sum_of_plant_pots
      @right_side.each_with_index.map do |plant, i|
        plant == '#' ? i : 0
      end.sum - @left_side.each_with_index.map do |plant, i|
        plant == '#' ? i + 1 : 0
      end.sum
    end

    private

    def spawn_one_side(other_side_0, other_side_1, side, recipe:)
      lab = [other_side_1, other_side_0].map { |x| x || '.' } + side + ['.'] * 4

      (2...(lab.size - 2)).map do |i|
        recipe.fetch(lab[i - 2..i + 2], '.')
      end.join.gsub(/\.+$/, '').chars
    end
  end
end

class Day12Solver < SolverBase
  def call(gen)
    plantation = Plantation.new(initial_state: initial_state, recipe: recipe)

    seen_plants = {
      plantation.plants => true,
    }

    previous = plantation.plants
    previous_relevant_pattern = previous.gsub(/\.+$/, '').gsub(/^\.+/, '')
    repeat = 0
    gen.times.map do |g|
      plantation.spawn
      relevant_pattern = plantation.plants.gsub(/\.+$/, '').gsub(/^\.+/, '')

      if relevant_pattern == previous_relevant_pattern
        total = relevant_pattern.chars.each_with_index.map do |plant, i|
          plant == '#' ? (i - 1) : 0
        end.reject(&:zero?).map do |x|
          49999999929 + x
        end.sum

        puts "total #{total}"
        puts plantation.sum_of_plant_pots

        break

        # puts "#{g} old #{previous}"
        # puts "#{g} new #{plantation.plants}"
        # puts "#{g} left  #{plantation.left_side}"
        # puts "#{g} right #{plantation.right_side}"
        puts "#{g} diff #{plantation.plants.gsub(relevant_pattern, '')}"
        # puts "results #{plantation.sum_of_plant_pots}"
        repeat += 1
        break if repeat > 10
      else
        puts "#{g} new pattern"
        previous = plantation.plants
        previous_relevant_pattern = relevant_pattern

        break if repeat.positive?
      end
    end

    plantation.sum_of_plant_pots
  end

  def initial_state
    @initial_state ||= input.first.gsub('initial state: ', '').strip
  end

  def recipe
    @recipe ||= Hash[
      input[2..-1].map do |line|
        pattern, plant = line.split(' => ')
        [pattern.strip.chars, plant.strip]
      end
    ]
  end
end
