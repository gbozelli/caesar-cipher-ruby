def fibonacci(n)
  if n == 1
    return 1
  elsif n == 0
    return 0
  else
    return fibonacci(n-1) + fibonacci(n-2)
  end
end

puts fibonacci(0)
puts fibonacci(1)
puts fibonacci(2)
puts fibonacci(3)
puts fibonacci(4)