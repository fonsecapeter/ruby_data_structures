class Queue
  def initialize
    @q = Array.new
  end

  def enqueue(el)
    @q.push(el)
    self
  end

  def dequeue
    @q.shift
  end

  def empty?
    @q.length == 0
  end

  def length
    @q.length
  end

  # ----------------------------------------------------------------------------

  def push(el)
    enqueue(el)
  end

  def shift
    dequeue
  end

  def to_s
    output = "<"
    @q.each_with_index do |q, idx|
      output += "#{q}"
      output += ", " if idx < @q.length - 1
    end
    output += "]"
  end

  def show
    @q.dup
  end

  private
  attr_accessor :q
end
