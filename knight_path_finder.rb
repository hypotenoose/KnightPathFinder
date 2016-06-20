require_relative 'poly_tree_node'

class KnightPathFinder
  attr_reader :root

  def initialize(pos)
    @root = PolyTreeNode.new(pos)
    @visited_positions = [@root]
  end

  def new_move_positions(pos)
    x, y = pos
    get_pos(y, x) + get_pos(x, y)
  end

  def get_pos(a, b)
    arr = []

    (a - 2).step(a + 2, 4) do |new_a|
      (b - 1).step(b + 1, 2) do |new_b|
        next unless new_b.between?(0,7) && new_a.between?(0,7)
        arr << [new_b, new_a]
      end
    end

    arr
  end

  def self.valid_moves(pos)
    @visited_positions += new_move_positions(pos).reject { |pos| @visited_positions.include?(pos) }
  end

  def build_move_tree
    # byebug
    queue = []
    visited = []
    queue << @root
    visited << @root

    until queue.empty?
      node = queue.shift

      positions = new_move_positions(node.value).reject { |pos| visited.include?(pos) }
      visited += positions

      positions.each do |pos|
        child_node = PolyTreeNode.new(pos)
        node.add_child(child_node)
        queue << child_node
      end

    end
  end

  def find_path(ending_pos)
    build_move_tree
    node = root.bfs(ending_pos)
    path = []
    until node.parent == nil
      path << node.value
      node = node.parent
    end
    path.push(@root.value)
    path.reverse
  end
end

kpf = KnightPathFinder.new([2,6])
p kpf.find_path([5,5])
