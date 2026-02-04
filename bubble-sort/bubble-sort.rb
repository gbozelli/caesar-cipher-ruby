def bubble_sort(array)
  i = 0
  j = 1
  n_swaps = 1
  n = array.length
  while n_swaps > 0
    n_swaps = 0
    while j < n
      if array[i] > array[j]
        cur = array[j]
        array[j] = array[i]
        array[i] = cur
        n_swaps += 1
      end
      i += 1
      j += 1
    end
    i = 0
    j = 1
  end
  array
end 

array = [4,3,78,2,0,2]
puts bubble_sort(array)