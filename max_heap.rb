require "byebug"

# nearly complete binary tree in which all child nodes <= their parent nodes
# swap >= for MinHeap
class MaxHeap
  def initialize(arr)
    @store = arr || DynamicArray.new
    # O(nlog(n)) where n is lenght of store
    build_heap!
  end

  # O(1)
  def find_max
    @store[0]
  end

  # O(h) where h = height of tree
  def insert(val)
    @store.push(val)
    sift_up!((@store.length - 1) / 2)
  end

  def extract
    max = find_max
    @store[0] = @store.pop
    heapify!(0)
    max
  end

  # O(1)
  def length
    @store.length
  end

  # O(1)
  def count
    length
  end

  # O(1)
  def empty?
    length == 0
  end

  private

  # O(nlog(n)) where n is length of store
  def build_heap!
    head = (@store.length - 1) / 2
    while head >= 0 do   # n / 2 => O(n)
      heapify!(head)     # O(log(n))
      head -= 1
    end
    self
  end

  # O(h) where h is height of tree
  def sift_up!(head)
    head = get_parent_idx(@store.length - 1)
    while head do
      children = get_children(head)

      higher = children[:higher]
      # swap higher child with head if needed
      root_val = @store[head]
      if root_val < higher[:val]
        @store[head], @store[higher[:idx]] = higher[:val], root_val
        head = get_parent_idx(head)
      else
        return self
      end
    end
    self
  end

  # rearrange subtree of node at node_index
  # O(log(n)) where n is length of store
  def heapify!(head)
    children = get_children(head)

    return unless children

    higher = children[:higher]
    # swap higher head with root if needed
    root_val = @store[head]
    if root_val < higher[:val]
      @store[head], @store[higher[:idx]] = higher[:val], root_val
      # fix subtree if it broke during the swap (if there is a subtree)
      heapify!(higher[:idx])
    end
  end

  def get_children(node_idx)
    # moving from root to leaves in binary, top>bottom, left>right manner
    left = node_idx == 0 ? 1 : (node_idx * 2) + 1
    right = left + 1

    children = {}
    children[:l] = { idx: left, val: @store[left] } if @store[left]
    children[:r] = { idx: right, val: @store[right] } if @store[right]

    children = children.length == 0 ? nil : children

    # grab higher of the one/two children, if there are any
    if children
      if (children[:l] &&
          (!children[:r] ||
           children[:l][:val] > children[:r][:val]))
        children[:higher] = children[:l]
      else
        children[:higher] = children[:r]
      end
    end

    return children
  end

  def get_parent_idx(node_idx)
    candidate = node_idx % 2 == 0 ? (node_idx - 1) / 2 : node_idx / 2
    return candidate >= 0 ? candidate : nil
  end
end
