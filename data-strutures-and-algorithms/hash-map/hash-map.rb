class HashMap
  def initialize
    @load_factor = 0.75
    @capacity = 16
    @size = 0
    @buckets = Array.new(@capacity) { [] }
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
        
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
        
    hash_code
  end

  def index(key)
    hash(key) % self.capacity
  end

  def set(key, value)
    bucket = @buckets[index(key)]

    bucket.each do |pair|
      if pair[0] == key
        pair[1] = value
        return
      end
    end

    bucket << [key, value]
    @size += 1  
  end

  def get(key)
  end

  def has?(key)

  end

  def remove(key)
  end

  def length
  end

  def clear
  end

  def keys

  end

  def values
  end

  def entries
  end
end