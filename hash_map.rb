require_relative 'hashing'
require_relative 'linked_list'

class HashMap
  attr_reader :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    resize! if @count >= num_buckets
    @count += 1 unless include?(key)
    bucket(key).insert(key, val)
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    removed = bucket(key).remove(key)
    @count -= 1 if removed
    removed
  end

  def each(&prc)
    @store.each do |bucket|
      bucket.each do |link|
        prc.call([link.key, link.val])
      end
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @count = 0
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    old_store.each do |bucket|
      bucket.each do |link|
        self.set(link.key, link.val)
      end
    end
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
