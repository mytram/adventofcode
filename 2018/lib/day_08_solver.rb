class Day08Solver < SolverBase
  class Tree
    attr_reader :metadata, :children

    def initialize(metadata:, children:)
      @children = children || []
      @metadata = metadata || []
    end

    def metadata_sum
      metadata.sum + children.map do |child|
        child.metadata_sum
      end.sum
    end

    def value
      if children.empty?
        metadata.sum
      else
        metadata.map do |id|
          children[id - 1]
        end.reject(&:nil?).map(&:value).sum
      end
    end

    def display(level = 0)
      puts "#{' ' * level} meta: #{metadata}"
      children.each_with_index do |c, i|
        puts " #{' ' * level} child: #{i}"
        c.display(level + 1)
      end
    end
  end

  def call
    tree, = build_tree(numbers)
    tree
  end

  private

  def numbers
    @numbers ||= input.first.strip.split(' ').map(&:to_i)
  end

  def build_tree(list)
    number_of_children, number_of_metadata, *rest = list

    children = []

    number_of_children.times do
      child, rest = build_tree(rest)
      children << child
    end

    [
      Tree.new(metadata: rest[0...number_of_metadata],
               children: children),
      rest[number_of_metadata..-1]
    ]
  end
end
