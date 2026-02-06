# object-oriented-programming

If everything in Ruby is a object, these objects are instance of some type of class 

## Concepts
- Programmers needed a way to create containers for data that could be changed and manipulated without affecting the entire program
- Encapsulation: hides functionality to make it unavailable to the rest of the code base
- Polymorphism: ability for different types of data to respond to a common interface
- Inheritance: a class inherits the behaviors of another class (superclass). Used to define basic classes with large reusability and smaller subclasses detailed behaviors.
- Objects: Objects are created from classes. Think of classes as molds and objects as the things you produce out of those molds
- Module: don't create objects. It´s more viable to use to share behavior, multiple inheritance, and add methods to classes.

## Classes

### Creating class and his attributes

- To create a class, we use the `initialize` function inside the class, and pass the arguments. To et the argument as a variable from the object, we use the `@` operator. 
- To call the class, we use the method `new`. Example

```ruby
class Viking
    def initialize(name, age, health, strength)
        @name = name
        @age = age
        @health = health
        @strength = strength
    end
end

> oleg = Viking.new("Oleg", 19, 100, 8)
=> #<Viking:0x007ffc0597bae0>
```

- If we want to access the variable `health`, we need to create a getter method that returns it. We can´t access it, for example, by directly calling in the object.

```ruby
class Viking
  .
  .
  .
    def health
        @health
    end
end

> oleg.health
=> 87
```

- If we want to set a new value for health, we need to create a setter method

```ruby
class Viking
  .
  .
  .
    def health=(new_health)
        @health = new_health
    end
end

> oleg.health
=> 87
```

- Ruby gives us a helper method called `attr_accessor`, which will create those getters and setters for us. We just need to pass it to the symbols and those methods will now exist for use:

```ruby
class Viking
    attr_accessor :name, :age, :health, :strength

end
```

### Class variables and methods

- Class variables, denoted by ``@@``, are owned by the class itself so there is only one of them overall instead of one per instance. 

```ruby
class Viking
    @@starting_health = 100
    def initialize(name, age, strength)
        @health = @@starting_health
        # ...other stuff
    end
end
```

- Class methods are useful to change the attributes of a class in a diferent way than getters and setters. 

```ruby
class Viking
    ...
    def self.random_name      # useful for making new warriors!
        ["Erik","Lars","Leif"].sample
    end
    def self.silver_to_gold(silver_pieces)
        silver_pieces / 10
    end
    class << self           # The less common way
        def gold_to_silver(gold_pieces)
            gold_pieces * 10
        end
    end
end

> warrior1 = Viking.create_warrior(Viking.random_name)
=> #<Viking:0x007ffc05a745c8 @age=22.369775138257097, @name="Lars", @health=111.84887569128549, @strength=10>
```

### Inheritance

- Ability of a child inherit all charactheristics of a parent class

```ruby
class Person
    MAX_HEALTH = 120
    ...
    def heal
        self.health += 1 unless self.health + 1 > MAX_HEALTH
    end
end

class Viking < Person
    ...
    def heal
        self.health = [self.health + 2, MAX_HEALTH].min
        puts "Ready for battle!"
    end
end
```
- We can also use `super` method.

```ruby
class Viking < Person
    ...
    def heal
        2.times { super }
        puts "Ready for battle!"
    end
end
```
```ruby
class Viking < Person
    def initialize(name, health, age, strength, weapon)
        super(name, health, age, strength)
        @weapon = weapon
    end
end
```
## Project Structure, Files, and Dependencies in Ruby

As Ruby projects grow, organizing code into multiple files becomes essential for maintainability, readability, and collaboration. Ruby provides clear conventions and tools to manage code structure and dependencies effectively.

### Why split code into multiple files?

Splitting code into separate files allows you to:
- Improve modularity and readability
- Isolate responsibilities (one class per file)
- Reuse code across different parts of the project
- Avoid large, hard-to-maintain files

A common convention in Ruby projects is:
- One class per file
- All Ruby source files placed inside a `lib/` directory

Example project structure:

project_name
├── lib
│   ├── airport.rb
│   ├── flight.rb
│   └── hotel.rb
└── main.rb

### Loading code from other files

Ruby provides two main ways to load external files: `require_relative` and `require`.

#### require_relative

`require_relative` loads files relative to the file where it is called, making it ideal for loading your own project files.

```ruby
require_relative 'lib/airport'
require_relative 'lib/flight'
require_relative 'lib/hotel'
```

Convention: use `require_relative` for internal project files.

#### require

`require` searches for files in Ruby’s `$LOAD_PATH` and installed gems.

```ruby
require 'csv'
require 'colorize'
```

Convention: use `require` for standard libraries and gems.

### Namespaces and modules

All required files share the same global namespace. To avoid name collisions, wrap code inside modules.

```ruby
module Payments
  class Pix
    def pay
      puts "Paying with Pix"
    end
  end
end
```

### Gems and dependencies

A gem is a packaged Ruby library. When your project relies on a gem, that gem becomes a dependency.

Install gems using RubyGems:
```bash
gem install colorize
```

### Bundler and the Gemfile

Bundler is the standard tool for managing dependencies in Ruby projects.

Initialize Bundler:
```bash
bundle init
```

Add a dependency:
```bash
bundle add colorize
```

This creates:
- Gemfile
- Gemfile.lock

Example Gemfile:
```ruby
source "https://rubygems.org"
gem "colorize", "~> 1.1"
```

### Running code with Bundler

```bash
bundle exec ruby main.rb
```

### Ruby version management

Use rbenv to define the Ruby version:
```bash
rbenv local 3.2.2
```

This creates a `.ruby-version` file.

### Summary

- One class per file
- Use `lib/` for source files
- Use `require_relative` for internal code
- Use `require` for gems
- Use modules for namespacing
- Manage dependencies with Bundler

## Linting, Formatting, and RuboCop in Ruby

Code is written for machines to execute, but more importantly, it is written for humans to read, understand, and maintain. As Ruby projects grow, maintaining readability, consistency, and predictability becomes critical. This is where style guides, linters, and formatters come into play.

### Style guides, formatting, and linting

A **style guide** is a collection of conventions and best practices that aim to make code consistent and readable across teams and projects.

- **Formatting** focuses on how code looks, such as indentation, spacing, and line breaks, without changing behavior.
- **Linting** focuses on detecting potential errors, ambiguities, and bad practices, sometimes suggesting alternative implementations.

In Ruby, the primary tool that combines both is **RuboCop**.

---

### What is RuboCop?

RuboCop is a Ruby gem that enforces code quality through a large collection of rules called *Cops*. These rules are grouped into departments, the most common being:

- **Style**: Enforces stylistic consistency based largely on the Ruby Style Guide.
- **Lint**: Detects possible bugs and ambiguous code.
- **Metrics**: Measures code complexity and size (method length, class length, ABC size, etc.).

RuboCop provides actionable feedback and, in many cases, automatic corrections.

---

### Installing and running RuboCop

RuboCop should be installed locally using Bundler to ensure consistent versions across environments.

```bash
bundle add rubocop --group development
```

Run RuboCop on the project:

```bash
bundle exec rubocop
```

This command inspects all Ruby files in the project directory and subdirectories.

---

### Understanding RuboCop output

RuboCop reports:
- The file, line, and column of the offense
- Severity level
- Whether the issue is auto-correctable
- The Cop responsible for the offense

Example:
```text
Style/StringLiterals: Prefer single-quoted strings when you don't need interpolation.
```

Use the `-S` flag to get a direct link to the relevant style guide rule:

```bash
bundle exec rubocop -S
```

---

### Auto-correction

RuboCop supports automatic fixes:

- **Safe auto-correction**:
```bash
bundle exec rubocop -a
```

- **Unsafe auto-correction** (may change semantics):
```bash
bundle exec rubocop -A
```

Safe Cops guarantee behavior preservation, while unsafe Cops may introduce subtle changes.

---

### Configuring RuboCop

RuboCop is highly configurable through a `.rubocop.yml` file located at the project root.

Generate a default configuration file:
```bash
bundle exec rubocop --init
```

Example configuration:
```yaml
AllCops:
  NewCops: enable

Style/StringLiterals:
  EnforcedStyle: single_quotes

Style/FrozenStringLiteralComment:
  EnforcedStyle: always
```

Configurations can be inherited from global or parent configuration files using `inherit_from`.

---

### Disabling Cops selectively

You can disable specific Cops inline when necessary:

```ruby
# rubocop:disable Metrics/AbcSize
def complex_method(a, b, c)
  # complex logic
end
# rubocop:enable Metrics/AbcSize
```

This should be used sparingly and only when complexity is justified.

---

### Metrics: understanding complexity

The **Metrics** department helps developers identify overly complex code.

- **ABC Metric**: Measures Assignments, Branches (method calls), and Conditionals.
- **Cyclomatic Complexity**: Measures the number of possible execution paths.
- **Perceived Complexity**: Estimates how difficult code is to read for humans.

High metric values often indicate opportunities to refactor code into smaller, clearer methods.

---

### RuboCop and VSCode (Ruby LSP)

When RuboCop is included in the project Gemfile, it integrates seamlessly with **Ruby LSP** in VSCode:

- Real-time linting while typing
- Inline error highlighting
- Quickfix actions for auto-corrections
- Direct links to RuboCop documentation

This tight feedback loop significantly improves development productivity.

---

### Best practices

- Prefer RuboCop defaults when learning
- Do not disable Metrics prematurely
- Treat offenses as learning opportunities, not failures
- Focus on readability and maintainability over perfection

RuboCop is a guide, not a dictator. Over time, you will learn when to follow the rules strictly and when breaking them is justified.