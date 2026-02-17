def mergeSort(array, start, final)
  mid = (start+final)/2
  if start >= final
    return
  else
    mergeSort(array, start, mid)
    mergeSort(array, mid+1, final)
    merge(array, start, mid, final)
  end 
end

def merge(array, start, mid, final)
  i = start
  j = mid + 1
  aux = []
  while i <= mid and j <= final
    if array[i] < array[j]
      aux << array[i]
      i += 1
    else 
      aux << array[j]
      j += 1
    end
  end
  while i <= mid
    aux << array[i]
    i += 1
  end

  while j <= final
    aux << array[j]
    j += 1
  end


  aux.each_with_index do |value, index|
    array[start + index] = value
  end
end

array = [1,8,2,5,9,3,4]
mergeSort(array, 0, 6)
puts array