module Enumerable
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    each do |elem|
      yield(elem, i)
      i += 1
    end

    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    result = []
    each do |elem|
      result << elem if yield(elem)
    end

    self
  end


  def my_all?
    return to_enum(:my_all?) unless block_given?

    each do |elem|
      return false unless yield(elem)
    end

  end

  def my_none?
    return to_enum(:my_each_with_index) unless block_given?

    each do |elem|
      retyrn false if yield(elem)
    end
      
  end 

  def my_count
    count = 0

    if block_given?
      each { |element| count += 1 if yield(element) }
    else
      each { count += 1 }
    end

    count
  end


  def my_map
    return to_enum(:my_map) unless block_given?

    result = []

    each do |element|
      result << yield(element)
    end

    result
  end


  def my_inject(initial = nil)
    accumulator = initial

    each do |element|
      if accumulator.nil?
        accumulator = element
      else
        accumulator = yield(accumulator, element)
      end
    end

    accumulator
  end


end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_each
    for i in (0...self.size) 
      yield(self[i])
    end
    self
  end
end
