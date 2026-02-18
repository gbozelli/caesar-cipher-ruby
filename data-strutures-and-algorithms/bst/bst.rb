class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  attr_accessor :root

  def initialize(array)
    array = array.uniq.sort
    @root = build_tree(array)
  end

  def include?(value, node = @root)
    return false if node.nil?
    return true if value == node.data

    if value < node.data
      include?(value, node.left)
    else
      include?(value, node.right)
    end
  end

  def insert(value, node = @root)
    return if include?(value)

    if value < node.data
      if node.left.nil?
        node.left = Node.new(value)
      else
        insert(value, node.left)
      end
    else
      if node.right.nil?
        node.right = Node.new(value)
      else
        insert(value, node.right)
      end
    end
  end

  def delete(value, node = @root)
    return nil if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      successor = min_value(node.right)
      node.data = successor
      node.right = delete(successor, node.right)
    end

    node
  end

  def level_order
    return enum_for(:level_order) unless block_given?

    queue = [@root]

    until queue.empty?
      node = queue.shift
      yield node.data
      queue << node.left if node.left
      queue << node.right if node.right
    end

    self
  end

  def inorder(node = @root, &block)
    return enum_for(:inorder) unless block_given?
    return if node.nil?

    inorder(node.left, &block)
    yield node.data
    inorder(node.right, &block)

    self
  end

  def preorder(node = @root, &block)
    return enum_for(:preorder) unless block_given?
    return if node.nil?

    yield node.data
    preorder(node.left, &block)
    preorder(node.right, &block)

    self
  end

  def postorder(node = @root, &block)
    return enum_for(:postorder) unless block_given?
    return if node.nil?

    postorder(node.left, &block)
    postorder(node.right, &block)
    yield node.data

    self
  end

  def height(value)
    node = find_node(value, @root)
    return nil if node.nil?
    calculate_height(node)
  end

  def depth(value, node = @root, depth = 0)
    return nil if node.nil?
    return depth if value == node.data

    if value < node.data
      depth(value, node.left, depth + 1)
    else
      depth(value, node.right, depth + 1)
    end
  end

  def balanced?(node = @root)
    return true if node.nil?

    left_height = calculate_height(node.left)
    right_height = calculate_height(node.right)

    return false if (left_height - right_height).abs > 1

    balanced?(node.left) && balanced?(node.right)
  end

  def rebalance
    values = []
    inorder { |v| values << v }
    @root = build_tree(values)
  end

  private

  def build_tree(array)
    return nil if array.empty?

    mid = array.length / 2
    root = Node.new(array[mid])

    root.left = build_tree(array[0...mid])
    root.right = build_tree(array[mid+1..-1])

    root
  end

  def min_value(node)
    current = node
    current = current.left while current.left
    current.data
  end

  def calculate_height(node)
    return -1 if node.nil?

    left_height = calculate_height(node.left)
    right_height = calculate_height(node.right)

    [left_height, right_height].max + 1
  end

  def find_node(value, node)
    return nil if node.nil?
    return node if value == node.data

    if value < node.data
      find_node(value, node.left)
    else
      find_node(value, node.right)
    end
  end
end
