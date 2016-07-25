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
    output = "{"
    @q.each_with_index do |q, idx|
      output += "#{q}"
      output += ", " if idx < @q.length - 1
    end
    output += "]"
  end

  def show
    @stack.dup
  end

  private

  attr_reader :stack
end
