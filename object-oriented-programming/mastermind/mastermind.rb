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
