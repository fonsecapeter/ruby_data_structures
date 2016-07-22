require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @length = 0
    @start_idx = 0
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index.abs >= @length.abs
    @store[
      (@start_idx + index) % @capacity
    ]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @store[
      (@start_idx + index) % @capacity
    ] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length < 1
    popped = self[@length - 1]
    @length -= 1
    popped
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize_if_needed!
    self[@length] = val
    @length += 1
    self
  end

  # O(1) due to ring-buffer style wrap
  def shift
    raise "index out of bounds" if @length < 1
    shifted = self[0]
    @start_idx += 1
    @length -= 1
    shifted
  end

  # O(1) ammortized due to ring-buffer style wrap
  def unshift(val)
    resize_if_needed!
    @start_idx = (@start_idx - 1) % @capacity
    self[0] = val
    @length += 1
    self
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index.abs >= @capacity.abs
  end

  def resize_if_needed!
    resize! if @length + 1 > @capacity
  end

  # O(n) where n is the length of store
  def resize!
    @capacity = @capacity * 2
    new_arr = StaticArray.new(@capacity)
    (@length).times { |i| new_arr[i] = self[i] }
    @store = new_arr
  end
end
