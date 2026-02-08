# Algorithms & Data Structures in Ruby

## Recursion

Recursion is a technique where a method calls itself to solve a problem by breaking it down into smaller subproblems.

This approach follows the Divide and Conquer paradigm:
- Split a large problem into smaller ones
- Solve the simplest case directly
- Combine results as the call stack unwinds

### When to Use Recursion

Recursion is useful when:
- A problem naturally breaks into subproblems of the same shape
- The solution can be defined in terms of itself
- Tree-like or nested structures are involved

It is not always the best choice. Many recursive problems are easier, safer, and more efficient with loops.

### The Two Essential Parts

Every recursive method must have:
1. A base case — stops the recursion
2. A recursive case — reduces the problem size

Without a base case, recursion leads to infinite calls.

### Stack Overflow

Each recursive call is placed on the call stack.
If recursion goes too deep, the stack runs out of memory, causing a stack overflow.

This is why recursion must be:
- Carefully bounded
- Used only when appropriate

Debuggers are strongly recommended when working with recursion.



## Time Complexity

### Why Time Complexity Matters

Code correctness is only the first step. As input sizes grow, inefficient algorithms can become unusable.

Time complexity answers the question:
> How does execution time grow as input size grows?

Execution time is not measured in seconds, but in number of steps.



## Big O Notation

Big O describes the worst-case performance of an algorithm.

Common complexities (fastest → slowest):

- O(1) — Constant
- O(log N) — Logarithmic
- O(N) — Linear
- O(N log N)
- O(N²) — Quadratic
- O(N³) — Cubic
- O(2ⁿ) — Exponential
- O(N!) — Factorial

Constants and lower-order terms are ignored because Big O focuses on growth, not exact counts.

## Examples

### Constant Time — O(1)

```ruby
arr = [1, 2, 3, 4, 5]
arr[2]
```

Access time does not change as the array grows.



### Linear Time — O(N)

```ruby
arr.each { |n| puts n }
```

Steps grow directly with input size.



### Logarithmic Time — O(log N)

Binary search halves the problem space at each step.
This makes it extremely scalable for large datasets.



## Alternatives to Big O

- Ω (Omega) — Best-case complexity
- Θ (Theta) — Tight bound (average-case)

Big O is preferred because systems must handle worst-case scenarios safely.



## Space Complexity

Space complexity measures how memory usage grows as input size grows.

It includes:
- Input data
- Temporary variables
- Auxiliary data structures
- Recursive call stack usage


## Common Space Complexities

### Constant Space — O(1)

```ruby
def multiply(a, b)
  a * b
end
```

Memory usage does not grow with input size.


### Linear Space — O(N)

```ruby
def sum_array(arr)
  copy = arr.dup
  copy.sum
end
```

Memory usage grows proportionally with input size.

## Trade-offs

Often, improving time complexity increases space usage (memoization, caching).
Good engineering balances:
- Performance
- Memory
- Readability

Readable code comes first unless performance is clearly an issue.



## Common Data Structures & Algorithms

## Stacks and Queues

- Stack: Last In, First Out (LIFO)
- Queue: First In, First Out (FIFO)

These structures are essential for:
- Depth-First Search (DFS)
- Breadth-First Search (BFS)

## Search Algorithms

### Breadth-First Search (BFS)

- Explores level by level
- Uses a queue
- Finds shortest paths
- Can consume large amounts of memory

### Depth-First Search (DFS)

- Explores deeply before backtracking
- Uses a stack or recursion
- Uses less memory
- May not find shortest paths

## Hash Maps (Hash Tables)

### What Is a Hash Map?

A hash map stores key–value pairs using a hash function to determine storage location.

Ruby’s `Hash` is built on this structure.

## Hashing

Hashing converts a key into a numeric hash code.

Properties:
- Deterministic
- One-way
- Fast

```ruby
def hash_string(str)
  hash = 0
  prime = 31
  str.each_char { |c| hash = hash * prime + c.ord }
  hash
end
```

Prime numbers help reduce collisions.

## Buckets & Collisions

- Buckets are array slots
- Collisions happen when multiple keys map to the same bucket
- Collisions are handled using linked lists

Good hash functions minimize collisions but can never eliminate them.



## Load Factor and Growth

A hash map grows when:
entries > capacity × load_factor

Typical values:
- Initial capacity: 16
- Load factor: 0.75–0.8

Growing requires rehashing all keys.



## Hash Map Complexity

Average case:
- Insert: O(1)
- Lookup: O(1)
- Delete: O(1)

Worst case (heavy collisions):
- O(N)

Growth operations are always O(N).


