require_relative 'hash_map'
require_relative 'linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map[key]
      link = @map[key]
      update_link!(link)
      link.val
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    val = @prc.call(key)
    new_link = @store.insert(key, val)
    @map[key] = new_link
    eject! if count > @max
    val
  end

  def update_link!(link)
    link.prev.next = link.next
    link.next.prev = link.prev

    link.prev = @store.last
    link.next = @store.last.next
    @store.last.next = link
  end

  def eject!
    removed = @store.first
    removed.prev.next = removed.next
    removed.next.prev = removed.prev
    @map.delete(removed.key)
  end
end
