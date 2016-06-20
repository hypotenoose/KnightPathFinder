require 'byebug'
class PolyTreeNode
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def parent=(node)
    if @parent != node && !@parent.nil?
      @parent.children.delete(self)
    end
    @parent = node
    return if node == nil
    @parent.children << self unless @parent.children.include?(self)
  end

  def children
    @children
  end

  def value
    @value
  end

  def add_child(node)
    node.parent = self
  end

  def remove_child(node)
    raise "Not a child" unless self.children.include?(node)
    node.parent = nil
  end

  def to_s
    @value
  end

  def dfs(target)
    return self if target == self.value

    self.children.each do |child|
      node = child.dfs(target)
      return node unless node.nil?
    end
    nil
  end

  def bfs(target)
    queue = []
    queue << self

    until queue.empty?
      candidate = queue.shift
      return candidate if candidate.value == target
      candidate.children.each { |child| queue << child }
    end
    nil
  end
end

# p1 = PolyTreeNode.new(1)
# p2 = PolyTreeNode.new(2)
#
# p1.add_child(p2)
