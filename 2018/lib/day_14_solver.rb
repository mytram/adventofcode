class Day14Solver
  class Recipe
    attr_accessor :value, :next_recipe

    def initialize(value, next_recipe: nil)
      @value = value
      @next_recipe = next_recipe || nil
    end
  end

  class RecipeMaker
    attr_reader :number_of_recipes

    def initialize
      @elf_1_recipe = @root_recipe = Recipe.new(3)
      @elf_2_recipe = @end_recipe = Recipe.new(7)

      @root_recipe.next_recipe = @end_recipe

      @end_recipe.next_recipe = @root_recipe

      @number_of_recipes = 2
    end

    def generate
      new_recipes = (@elf_1_recipe.value + @elf_2_recipe.value).to_s.chars.map(&:to_i)

      @number_of_recipes += new_recipes.count

      new_recipes.each do |value|
        append_recipe(value)
      end

      moves = @elf_1_recipe.value + 1
      moves.times do
        @elf_1_recipe = @elf_1_recipe.next_recipe
      end

      moves = @elf_2_recipe.value + 1
      moves.times do
        @elf_2_recipe = @elf_2_recipe.next_recipe
      end

      new_recipes
    end

    def recipes
      display
    end

    def display
      recipe = @root_recipe

      values = []

      while recipe != @end_recipe
        values << recipe.value
        recipe = recipe.next_recipe
      end

      values << recipe.value
    end

    private

    def append_recipe(value)
      recipe = Recipe.new(value, next_recipe: @root_recipe)
      @end_recipe.next_recipe = recipe
      @end_recipe = recipe
    end
  end
end
