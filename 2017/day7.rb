#
# part 1

class ProgramTree
  attr_reader :links, :node_weights

  def initialize(links:, weights:)
    @links = links
    @node_weights = weights
  end

  def root
    return @root if @root
    no_parent = find_root_node(links)

    raise "There is only one root" if no_parent.length != 1

    @root = no_parent[0]
  end

  def node_weight(node)
    node_weights[node]
  end

  def tree
    return @tree if @tree
    link_map = Hash[links]
    @tree = build_tree_with_weights(root, link_map, node_weights)
  end

  def print
    print_tree(tree)
  end

  private

  def find_root_node(links)
    # reject leaves
    links = links.reject { |link| link[1].nil? }

    # Hash the pairs
    links = Hash[links]

    child_parent_reverse = {}

    links.each_pair do |parent, children|
      children&.each { |child| child_parent_reverse[child] = parent }
    end
    # If there are more than two, fail!
    no_parent = []
    links.each_key do |parent|
      no_parent << parent unless child_parent_reverse.key? parent
    end

    no_parent
  end

  #
  # should be only 1
  #

  def build_tree_with_weights(node, links, node_weights)
    children = links[node]

    if children.nil?
      # leaves
      { node: node, weight: node_weights[node] }
    else
      sub_trees = children.map do |child|
        build_tree_with_weights(child, links, node_weights)
      end

      sub_tree_weights = sub_trees.map { |st| st[:weight] }

      if sub_tree_weights.uniq.size != 1 # unbalanced
        puts sub_tree_weights.inspect
        puts sub_trees.map { |st| st[:node] }.inspect
        puts sub_trees.map { |st| node_weights[st[:node]] }.inspect
      end

      {
        node: node,
        weight: sub_tree_weights.reduce(&:+) + node_weights[node],
        children: sub_trees
      }
    end
  end

  # We know the root now. Build from the root
  # links = Hash[original_links]
  # build_tree_with_weights(root, links, node_weights)

  def print_tree(tree, depth = 0)
    root = tree[:node]
    indent = ' ' * depth
    puts "#{indent} (#{depth}) #{root} w: #{node_weights[root]} tw: #{tree[:weight]}"
    tree[:children]&.each do |subtree|
      print_tree(subtree, depth + 1)
    end
  end
end

def main
  links = []
  node_weights = {}

  File.open('./day7_input2.txt').readlines.each do |line|
    weight = line.gsub(/[^0-9]/, '').to_i # weight
    line = line.gsub(/\(\d+\)/, '') # remove (12)
    parent, children = line.split('->').map(&:strip)

    children = children.split(',').map(&:strip) if children

    links << [parent, children]
    node_weights[parent] = weight
  end

  pt = ProgramTree.new(links: links, weights: node_weights)

  puts pt.root
  pt.tree
  # pt.print
end

main
