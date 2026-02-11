module Enumerable
  def my_find
    self.each do |elem|
      return elem if yield(elem)
    end

    nil
  end
end

a = [1, 2, 3]
a.my_find { |n| n == 2 }
#=> 2
