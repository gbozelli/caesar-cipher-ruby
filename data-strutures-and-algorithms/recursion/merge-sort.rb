def mergeSort(array, start, final)
  mid = (start+final)/2
  if start >= final
    return
  else
    mergeSort(array, start, mid)
    mergeSort(array, mid+1, final)
  end 
end

def mergeSort(array, start, final)

end