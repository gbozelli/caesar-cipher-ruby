# Advanced Ruby

## Blocks

Blocks are anonymous chunks of code passed to methods.

```ruby
[1, 2, 3].each { |n| puts n }

[1, 2, 3].each do |n|
  puts n
end
```

Blocks allow callers to define behavior, not just data.


## Yielding Control

`yield` transfers execution from a method to a block.

```ruby
def logger
  yield
end

logger { puts "hello from the block" }
```

Blocks can be yielded multiple times and can receive arguments.

```ruby
def love_language
  yield("Ruby")
  yield("Rails")
end
```

## Block Safety: `block_given?`

```ruby
def maybe_block
  puts "block party" if block_given?
  puts "always runs"
end
```

## Procs and Lambdas

Both store blocks as objects, but behave differently.

### Lambdas
- Strict arity
- `return` returns from the lambda

```ruby
adder = ->(a, b) { a + b }
adder.call(2, 3)
```

### Procs
- Loose arity
- `return` exits the surrounding method

```ruby
Proc.new { |a, b| a + b }
```


## Capturing Blocks with `&`

```ruby
def run(&block)
  block.call
end
```

Symbols can also be converted via `to_proc`.

```ruby
["1", "2", "3"].map(&:to_i)
```

## Pattern Matching Basics

Pattern matching deconstructs data structures declaratively.

```ruby
case grade
in "A" then "Excellent"
in "B" then "Good"
else "Try again"
end
```


## Variable Binding and Pin Operator

```ruby
a = 5

case 1
in ^a
  :match
end
```

## Array Pattern Matching

```ruby
case [1, 2, 3, 4]
in [1, 2, *tail]
  p tail
end
```

Supports:
- Wildcards `_`
- Nested arrays
- Guards
- Splat capture



## Hash Pattern Matching

```ruby
case { a: "apple", b: "banana" }
in { a:, b: }
  puts a
  puts b
end
```

Supports:
- Partial matches
- `rest`
- Exact matching via `nil`



## Find Pattern (Ruby 3)

Matches subsequences anywhere in an array.

```ruby
case [1, 2, "a", "b", 3]
in [*, String => x, String => y, *]
  puts x, y
end
```

