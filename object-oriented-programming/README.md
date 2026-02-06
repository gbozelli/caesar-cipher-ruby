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
