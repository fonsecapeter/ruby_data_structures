class Stack
  def initialize
    @stack = Array.new
  end

  def add(el)
    @stack.push(el)
  end

  def remove
    @stack.pop
  end

  def show
    @stack.dup
  end

  private
  
  attr_reader :stack
end
