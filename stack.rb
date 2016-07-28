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

  def to_s
    output = "┌----\n|"
    @stack.each_with_index do |el, idx|
      output += "#{el}"
      output += ", " if idx < @stack.length - 1
    end
    output += "\n└----"
  end

  def show
    @stack.dup
  end

  private

  attr_reader :stack
end
