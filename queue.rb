class Queue
  def initialize
    @q = Array.new
  end

  def enqueue(el)
    @q.push(el)
  end

  def dequeue
    @q.shift
  end

  def show
    @q.dup
  end
  private
  attr_accessor :q
end
