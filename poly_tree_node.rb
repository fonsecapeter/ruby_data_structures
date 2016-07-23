class PolyTreeNode
  def initialize(value)
    @value  = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(parent)
    unless @parent.nil?
      @parent.children.delete(self)
    end

    @parent = parent
    unless parent.nil?
      parent.children << self unless parent.children.include?(self)
    end
  end

  # child modifiers
  # --------------------------------------------------------------------
  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Error, not a child" unless @children.include?(child_node)
    child_node.parent = nil
  end

  # --------------------------------------------------------------------
  def dfs(target_value)
    return self if self.value == target_value

    self.children.each do |child|
      result = child.dfs(target_value)
      unless result.nil?
        return result if result.value == target_value
      end
    end
    nil
  end

  def bfs(target_value)
    queue = [self]

    until queue.empty?
      test_node = queue.shift
      return test_node if test_node.value == target_value
      queue += test_node.children
    end
    nil
  end



end
