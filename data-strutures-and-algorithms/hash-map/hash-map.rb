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
    hash(key) % @capacity
  end

  def resize
    old_buckets = @buckets
    @capacity *= 2
    @buckets = Array.new(@capacity) { [] }
    @size = 0

    old_buckets.each do |bucket|
      bucket.each do |key, value|
        set(key, value)
      end
    end
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

    resize if @size > @capacity * @load_factor
  end

  def get(key)
    bucket = @buckets[index(key)]

    bucket.each do |pair|
      return pair[1] if pair[0] == key
    end

    nil
  end

  def has?(key)
    !get(key).nil?
  end

  def remove(key)
    bucket = @buckets[index(key)]

    bucket.each_with_index do |pair, i|
      if pair[0] == key
        bucket.delete_at(i)
        @size -= 1
        return true
      end
    end

    false
  end

  def length
    @size
  end

  def clear
    @buckets = Array.new(@capacity) { [] }
    @size = 0
  end

  def keys
    result = []

    @buckets.each do |bucket|
      bucket.each do |pair|
        result << pair[0]
      end
    end

    result
  end

  def values
    result = []

    @buckets.each do |bucket|
      bucket.each do |pair|
        result << pair[1]
      end
    end

    result
  end

  def entries
    result = []

    @buckets.each do |bucket|
      bucket.each do |pair|
        result << pair
      end
    end

    result
  end
end
