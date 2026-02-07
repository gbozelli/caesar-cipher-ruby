# Files and Serialization in Ruby

If everything in Unix is a file, Ruby treats I/O streams, files, and sockets similarly using the `IO` class.

## Concepts
- **I/O (Input/Output)**: Communication between the computer and the outside world (keyboard, screen, files, network).
- **Streams**: Data flows in and out of the program.
- **File Descriptors**: Integers used by the OS to track open files (0 for stdin, 1 for stdout, 2 for stderr).
- **Serialization**: Converting an object (data in memory) into a format that can be stored (file) or transmitted (network) and reconstructed later.
- **Mixins**: Using modules to add serialization abilities to classes without inheritance.

## Input and Output (I/O)

### Standard Streams

- Ruby provides constants to access standard streams: `STDIN`, `STDOUT`, and `STDERR`.
- Global variables `$stdin`, `$stdout`, and `$stderr` point to these streams but can be redirected.

```ruby
puts "Hello World"      # Writes to $stdout
input = gets.chomp      # Reads from $stdin
$stderr.puts "Error!"   # Writes to standard error
```

## The IO Class

`IO` is the parent class for `File`. You can open pipes or system commands using it.

```ruby
# Opening a pipe to a system command
io = IO.popen("ls -la")
puts io.read
```

## Files

### Reading and Writing

The `File` class allows us to interact with the file system.

Always prefer using the block syntax (`File.open do |f| ... end`) because it automatically closes the file after execution, preventing memory leaks.

```ruby
# Writing to a file (creates or overwrites)
File.open("log.txt", "w") do |file|
  file.puts "Server started at #{Time.now}"
  file.write "Initialization complete.\n"
end

# Reading from a file
File.open("log.txt", "r") do |file|
  file.each_line do |line|
    puts "LOG: #{line}"
  end
end
```

For simple operations, Ruby has shortcut methods:

```ruby
content = File.read("log.txt")     # Reads entire file into string
lines   = File.readlines("log.txt") # Reads file into array of lines
```

## File Metadata and Directories

We can check if files exist, their size, or manipulate directories using `Dir`.

```ruby
File.exist?("config.rb") # => true or false
File.size("video.mp4")   # => size in bytes

Dir.mkdir("data") unless Dir.exist?("data")
Dir.glob("*.rb")         # => List of all Ruby files in current folder
```

## Serialization

When we need to save a Ruby object (like an instance of a class) to a file, we need to serialize it.

### JSON

JavaScript Object Notation. Universal, readable, and great for APIs.

Limitation: Keys are usually converted to strings.

```ruby
require "json"

data = { name: "Viking", health: 100 }
json_string = JSON.dump(data)

# Saving to file
File.open("save.json", "w") { |f| f.write(json_string) }

# Loading
loaded_data = JSON.parse(File.read("save.json"))
```

### YAML

YAML Ain't Markup Language. Very human-readable, standard for Ruby configurations.

Handles Ruby-specific objects better than JSON in some cases.

```ruby
require "yaml"

config = { "adapter" => "postgres", "pool" => 5 }
yaml_string = YAML.dump(config)

File.open("database.yml", "w") { |f| f.write(yaml_string) }
```

### MessagePack

A binary format. It's like JSON but faster and smaller.

Requires the `msgpack` gem.

```ruby
require "msgpack"

msg = { width: 1920, height: 1080 }.to_msgpack
```

## Modular Serialization Strategy

Instead of writing save/load logic in every class, we can create a module to share this behavior.

```ruby
require "json"

module BasicSerializable
  def serialize
    obj = {}
    instance_variables.map do |var|
      obj[var] = instance_variable_get(var)
    end

    JSON.dump(obj)
  end

  def unserialize(string)
    obj = JSON.parse(string)
    obj.keys.each do |key|
      instance_variable_set(key, obj[key])
    end
  end
end
```

Now we can include this in our classes:

```ruby
class Viking
  include BasicSerializable
  attr_accessor :name, :health

  def initialize(name, health)
    @name = name
    @health = health
  end
end

oleg = Viking.new("Oleg", 100)
saved_game = oleg.serialize
# => "{\"@name\":\"Oleg\",\"@health\":100}"
```

## Summary

- Use `File.open` with blocks to manage resources safely.
- Use JSON for interoperability, YAML for configuration, and MessagePack for speed.
- Use modules to DRY up your serialization code via mixins and polymorphism.
