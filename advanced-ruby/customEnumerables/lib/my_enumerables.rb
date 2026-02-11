module Enumerable
  def my_each_with_index
  
  end

  def my_select

  end

  def my_all?
  
  end

  def my_none?
  
  end 

  def my_count
  
  end

  def my_map
  
  end

  def my_inject
  
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
