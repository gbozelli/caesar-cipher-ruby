# Ruby Testing 

## What Is Test-Driven Development?

Test-Driven Development is a workflow where:

- You write a test first
- You write the minimum code to pass the test
- You refactor safely with tests as a safety net

## Introduction to RSpec

RSpec is a testing lib written in Ruby.

It ships as a suite of gems:

- `rspec-core`
- `rspec-expectations`
- `rspec-mocks`
- `rspec-support`

RSpec is especially popular in the Ruby and Rails ecosystem.

## Installing and Initializing RSpec

```
gem install rspec
rspec --init
```

Project structure after initialization:

```
project/
├── lib/
│   └── calculator.rb
├── spec/
│   └── calculator_spec.rb
└── .rspec
```

## Basic RSpec Syntax

RSpec tests are built from example groups and examples.

```ruby
describe Calculator do
  describe "#add" do
    it "returns the sum of two numbers" do
      calculator = Calculator.new
      expect(calculator.add(5, 2)).to eql(7)
    end
  end
end
```

- `describe` groups related tests
- `it` defines a single test case
- `expect(...).to` expresses behavior
- One expectation per test is best practice

```ruby
class Calculator
  def add(a, b)
    a + b
  end
end
```

## Running the Test Suite

```
rspec
rspec --format documentation
```