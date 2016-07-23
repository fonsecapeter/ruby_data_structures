class Map
  def initialize
    @map = Array.new
  end

  def assign(key, value)
    location = self.lookup(key)
    location ? @map[location] = [key, value] : @map << [key, value]
  end

  def lookup(key)
    @map.each_with_index do |pair, index|
      return index if pair.first == key
    end
    nil
  end

  def remove(key)
    @map.delete_at(self.lookup(key))
  end

  def show
    @map.each do |pair|
      puts "#{pair.first} => #{pair.last}"
    end
    @map.dup
  end

end
