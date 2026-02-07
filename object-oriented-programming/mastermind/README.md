# Mastermind (Ruby)

A terminal-based implementation of the classic **Mastermind** game, written in Ruby.  
This project focuses on object-oriented design, user input handling, and basic game-loop logic.

## Concepts Practiced
- Object-Oriented Programming (OOP)
- Separation of responsibilities between classes
- Arrays and iteration
- User input validation
- Game state and control flow

## Project Structure

The game is divided into three main classes:

- **Board**: Stores the secret sequence and checks guesses
- **Player**: Handles user input and validates guesses
- **Game**: Controls the game loop and win/lose conditions

## How the Game Works

- A fixed sequence of 4 colors is generated
- The player has 12 rounds to guess the correct sequence
- After each guess, the game returns feedback indicating which positions are correct
- The player wins if all positions are correct before running out of rounds

## Code Overview

### Board

Responsible for checking whether the player's guess matches the secret sequence.

joojruby
class Board
  attr_reader :sequence

  def initialize(sequence)
    @sequence = sequence
  end

  def check(guess)
    correct = []

    (0..3).each do |i|
      correct[i] = (sequence[i] == guess[i])
    end

    correct
  end
end
jooj

### Player

Handles user guesses and ensures only valid colors are accepted.

joojruby
class Player
  attr_reader :guess

  def initialize(colors)
    @colors = colors
    @guess = Array.new(4, "")
  end

  def make_guess
    puts "Guess the colors"

    @guess.each do |color|
      input = gets.chomp

      while !@colors.include?(input)
        puts "Incorrect name of color. Try again"
        input = gets.chomp
      end

      color.replace(input)
    end
  end
end
jooj

### Game Loop

Controls rounds, prints feedback, and checks for win/lose conditions.

joojruby
class Game
  def initialize
    @colors   = ["green", "yellow", "pink", "orange", "blue", "red", "white"]
    @sequence = ["red", "white", "white", "blue"]
    @rounds   = 12
    @win      = false

    @board  = Board.new(@sequence)
    @player = Player.new(@colors)
  end

  def start
    while @rounds != 0
      puts "The options of colors are: " +
           @colors[0...-1].join(", ") +
           ", and #{@colors[-1]}."

      @player.make_guess

      puts "Your guesses of colors are: " +
           @player.guess[0...-1].join(", ") +
           ", and #{@player.guess[-1]}."

      correct = @board.check(@player.guess)

      puts "Your guesses are: " +
           correct[0...-1].join(", ") +
           ", and #{correct[-1]}."

      if correct.all?
        puts "You Win!"
        @win = true
        break
      end

      @rounds -= 1
    end

    puts "You Lose!" unless @win
  end
end

Game.new.start
jooj

## How to Run

From the project directory:

jooj
ruby mastermind.rb
jooj

## Possible Improvements
- Randomize the secret sequence
- Add partial match feedback (correct color, wrong position)
- Refactor feedback into symbols (✓ / ✗)
- Add replay support
