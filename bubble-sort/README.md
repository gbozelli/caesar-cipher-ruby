# bubble-sort
Lesson from Odin Project

The `bubble_sort` method implements the bubble sort algorithm: repeatedly traverse an array, swapping adjacent elements when they are in the wrong order, until the array is sorted.

# What You Will Learn

- Array manipulation: indexing, swapping and iterating
- Looping constructs: `while` loops and nested iteration
- Algorithmic thinking: understanding time complexity and optimizations
- In-place sorting vs. returning a new array

# How It Works

`bubble_sort(array)` repeatedly walks through the array, comparing adjacent pairs and swapping them when necessary. Each full pass guarantees that the largest unsorted element "bubbles" to its correct position at the end of the array. The process repeats until a complete pass performs no swaps (the array is sorted).

# Code Walkthrough

```ruby
def bubble_sort(array)
  n = array.length
  loop do
    swapped = false
    (0...(n-1)).each do |i|
      if array[i] > array[i+1]
        array[i], array[i+1] = array[i+1], array[i]
        swapped = true
      end
    end
    break unless swapped
  end
  array
end
```

- `n = array.length` gets the number of elements
- The `loop do` together with the `swapped` flag repeats passes until no swaps occur
- `(0...(n-1)).each` iterates over adjacent pairs
- `array[i], array[i+1] = array[i+1], array[i]` swaps elements in place
- The method returns the sorted `array` (implicit return of the last expression)

# Important Methods

**Array methods used:**
- `.length` - returns number of elements
- Array indexing with `[index]` - reads/writes elements

**Loop constructs used:**
- `loop do` with a `break` condition
- Ranges `(start...end)` for exclusive end values

**Operators used:**
- `>` (greater than) - compares elements
- Parallel assignment for swapping: `a, b = b, a`

# How to Run

From the repository root, run the example file:

```bash
ruby bubble-sort/bubble-sort.rb
```

# Example

Given `array = [4, 3, 78, 2, 0, 2]`, calling `bubble_sort(array)` will return the array sorted in ascending order:

```
bubble_sort([4, 3, 78, 2, 0, 2])
#=> [0, 2, 2, 3, 4, 78]
```

# Challenges to Try

- Implement a non-destructive `bubble_sort` that returns a new sorted array
- Optimize by reducing the range on each pass since the end portion becomes sorted
- Compare performance with `Array#sort` and discuss complexity
- Add tests with Minitest or RSpec
- Implement variations (descending order, custom comparator block)

# Notes

This README follows the concise, lesson-style structure used in the `caesar-cipher` exercise and the project root README: explanation, code walkthrough, key methods, running instructions and suggested challenges.
