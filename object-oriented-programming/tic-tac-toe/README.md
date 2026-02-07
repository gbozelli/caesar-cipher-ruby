# Tic-Tac-Toe (Ruby)

A two-player terminal-based **Tic-Tac-Toe** game implemented in Ruby.  
This project emphasizes grid-based logic, turn handling, and win condition checking.

## Concepts Practiced
- 2D arrays
- Game loops and turn alternation
- Input validation
- Condition checking (rows, columns, diagonals)
- Basic procedural + OOP mix

## Project Structure

- **Board**: Manages the game grid, printing, and win logic
- **Human**: Represents a player
- **Main loop**: Alternates turns and handles user interaction

## How the Game Works

- Two players enter their names
- Players alternate turns entering `(x, y)` coordinates
- The board updates after each valid move
- The game ends when a player wins or the board is full

## Code Overview

### Board

Handles board state, printing, and win detection.

joojruby
class Board
  attr_accessor :board
  
  def initialize
    @board = Array.new(3) { Array.new(3, 0) }
  end

  def print_board
    puts

    @board.each do |row|
      row_str = row.map do |cell|
        case cell
        when 0 then " "
        when 1 then "X"
        when 2 then "O"
        else cell.to_s
        end
      end.join(" | ")

      puts " #{row_str} "
      puts "---+---+---"
    end
  end
jooj

### Win Checking

Explicit checks for rows, columns, diagonals, and draw conditions.

joojruby
  def check_win
    # Rows, columns, and diagonals checks
    # Returns player marker, true (draw), or false
  end
end
jooj

### Player

Represents a human player and validates moves.

joojruby
class Human
  attr_accessor :name, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
  end

  def play(x, y, board)
    if x < 3 and y < 3 and board[x][y] == 0
      board[x][y] = @marker
    else
      false
    end
  end
end
jooj

### Game Loop

Alternates turns until a win or draw occurs.

jooj
while board.check_win == false
  puts "#{player[i % 2].name}: Write the x and y coordinator"
  x = gets.chomp.to_i
  y = gets.chomp.to_i
  ...
end
jooj

## How to Run

From the project directory:

jooj
ruby tic_tac_toe.rb
jooj

## Possible Improvements
- Refactor win checking using loops instead of repetition
- Add coordinate bounds error messages
- Implement AI opponent
- Improve board rendering
- Normalize markers (`X` and `O`) consistently

---

## Notes

Both projects are ideal early Ruby exercises and demonstrate:
- Core Ruby syntax
- Game-loop logic
- Clean separation of responsibilities
- Progressive complexity from simple rules to full gameplay
