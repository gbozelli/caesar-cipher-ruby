class Node
  attr_accessor :value, :next_node

  def initialize(value)
    @value = value
    @next_node = nil
  end
end

class LinkedList
  def initialize
    @head = nil
  end

  def append(value)
    new_node = Node.new(value)

    if @head.nil?
      @head = new_node
    else
      current = @head
      while current.next_node
        current = current.next_node
      end
      current.next_node = new_node
    end
  end

  def prepend(value)
    new_node = Node.new(value)
    new_node.next_node = @head
    @head = new_node
  end

  def size
    count = 0
    current = @head

    while current
      count += 1
      current = current.next_node
    end

    count
  end

  def head
    @head&.value
  end

  def at(index)
    current = @head
    i = 0

    while current && i < index
      current = current.next_node
      i += 1
    end

    current&.value
  end

  def pop
    return nil if @head.nil?

    if @head.next_node.nil?
      value = @head.value
      @head = nil
      return value
    end

    current = @head
    while current.next_node.next_node
      current = current.next_node
    end

    value = current.next_node.value
    current.next_node = nil
    value
  end

  def contains?(value)
    current = @head

    while current
      return true if current.value == value
      current = current.next_node
    end

    false
  end

  def to_s
    current = @head
    result = ""

    while current
      result += "( #{current.value} ) -> "
      current = current.next_node
    end

    result += "nil"
    result
  end
end
