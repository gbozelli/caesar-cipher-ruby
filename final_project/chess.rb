class Player
  attr_accessor :pieces, :name

  def initialize(name, color)
    @name = name
    @color = color
    row_pawns = color == :white ? 6 : 1
    row_back  = color == :white ? 7 : 0

    @pieces = []

    8.times do |col|
      @pieces << Pawn.new(row_pawns, col, color)
    end

    @pieces << Rook.new(row_back, 0, color)
    @pieces << Knight.new(row_back, 1, color)
    @pieces << Bishop.new(row_back, 2, color)
    @pieces << Queen.new(row_back, 3, color)
    @pieces << King.new(row_back, 4, color)
    @pieces << Bishop.new(row_back, 5, color)
    @pieces << Knight.new(row_back, 6, color)
    @pieces << Rook.new(row_back, 7, color)
  end

  def print_pieces
    puts "Peças de #{@name} (#{@color}):"

    grouped = @pieces.group_by { |piece| piece.class }

    grouped.each do |klass, pieces|
      symbols = pieces.map(&:symbol).join(" ")
      puts "#{klass}: #{symbols}"
    end
  end
end

class Board
  attr_accessor :board

  def initialize(player)
    @board = Array.new(8) { Array.new(8, nil) }
  end

  def clear
    @board = Array.new(8) { Array.new(8, nil) }
  end

  def player_to_board(player)
    player.pieces.each do |piece|
      @board[piece.x][piece.y] = piece
    end
  end

  def print_board
    puts "    1  2  3  4  5  6  7  8"
    puts "   ------------------------"

    @board.each_with_index do |row, i|
      print "#{8 - i} |"

      row.each do |cell|
        if cell.nil?
          print " . "
        else
          print " #{cell.symbol} "
        end
      end

      puts "| #{8 - i}"
    end

    puts "   ------------------------"
    puts "    1  2  3  4  5  6  7  8"
  end

  def enemy?(x, y, color)
    return false unless x.between?(0,7) && y.between?(0,7)
    piece = @board[x][y]
    piece && piece.color != color
  end

  def empty?(x, y)
    return false unless x.between?(0,7) && y.between?(0,7)
    @board[x][y].nil?
  end

end

class Piece
  attr_accessor :x, :y, :color, :symbol

  def initialize(x, y, color)
    @x = x
    @y = y
    @color = color
    @moved = false
  end

  def valid_moves(board)
    raise NotImplementedError, "Each piece must implement possible_moves"
  end
end

class Pawn < Piece
  attr_accessor :symbol

  def initialize(x, y, color)
    super(x, y, color)
    
    @symbol = color == :white ? "♙" : "♟"
  end

  def valid_moves(board)
    direction = color == :white ? -1 : 1
    moves = []

    if board.empty?(x + direction, y)
      moves << [x + direction, y]

      if !@moved && board.empty?(x + 2 * direction, y)
        moves << [x + 2 * direction, y]
      end
    end

    if board.enemy?(x + direction, y - 1, color)
      moves << [x + direction, y - 1]
    end

    if board.enemy?(x + direction, y + 1, color)
      moves << [x + direction, y + 1]
    end

    moves
  end

end

class Rook < Piece
  attr_accessor :symbol

  def initialize(x, y, color)
    super(x, y, color)
    @symbol = color == :white ? "♖" : "♜"
  end

  def valid_moves(board)
    moves = []
    directions = [[1,0], [-1,0], [0,1], [0,-1]]

    directions.each do |dx, dy|
      nx = x + dx
      ny = y + dy

      while nx.between?(0,7) && ny.between?(0,7)
        if board.empty?(nx, ny)
          moves << [nx, ny]
        elsif board.enemy?(nx, ny, color)
          moves << [nx, ny]
          break
        else
          break
        end
        nx += dx
        ny += dy
      end
    end

    moves
  end
end

class Knight < Piece
  attr_accessor :symbol

  def initialize(x, y, color)
    super(x, y, color)
    @symbol = color == :white ? "♘" : "♞"
  end

  def valid_moves(board)
    moves = []
    deltas = [[2,1],[2,-1],[-2,1],[-2,-1],[1,2],[1,-2],[-1,2],[-1,-2]]

    deltas.each do |dx, dy|
      nx = x + dx
      ny = y + dy
      next unless nx.between?(0,7) && ny.between?(0,7)

      if board.empty?(nx, ny) || board.enemy?(nx, ny, color)
        moves << [nx, ny]
      end
    end

    moves
  end
end

class Bishop < Piece
  attr_accessor :symbol

  def initialize(x, y, color)
    super(x, y, color)
    @symbol = color == :white ? "♗" : "♝"
  end

  def valid_moves(board)
    moves = []
    directions = [[1,1],[1,-1],[-1,1],[-1,-1]]

    directions.each do |dx, dy|
      nx = x + dx
      ny = y + dy

      while nx.between?(0,7) && ny.between?(0,7)
        if board.empty?(nx, ny)
          moves << [nx, ny]
        elsif board.enemy?(nx, ny, color)
          moves << [nx, ny]
          break
        else
          break
        end
        nx += dx
        ny += dy
      end
    end

    moves
  end
end

class Queen < Piece
  attr_accessor :symbol

  def initialize(x, y, color)
    super(x, y, color)
    @symbol = color == :white ? "♕" : "♛"
  end

  def valid_moves(board)
    moves = []
    directions = [
      [1,0], [-1,0], [0,1], [0,-1],
      [1,1], [1,-1], [-1,1], [-1,-1]
    ]

    directions.each do |dx, dy|
      nx = x + dx
      ny = y + dy

      while nx.between?(0,7) && ny.between?(0,7)
        if board.empty?(nx, ny)
          moves << [nx, ny]
        elsif board.enemy?(nx, ny, color)
          moves << [nx, ny]
          break
        else
          break
        end
        nx += dx
        ny += dy
      end
    end

    moves
  end
end

class King < Piece
  attr_accessor :symbol

  def initialize(x, y, color)
    super(x, y, color)
    @symbol = color == :white ? "♔" : "♚"
  end

  def valid_moves(board)
    moves = []
    deltas = [
      [1,0], [-1,0], [0,1], [0,-1],
      [1,1], [1,-1], [-1,1], [-1,-1]
    ]

    deltas.each do |dx, dy|
      nx = x + dx
      ny = y + dy
      next unless nx.between?(0,7) && ny.between?(0,7)

      if board.empty?(nx, ny) || board.enemy?(nx, ny, color)
        moves << [nx, ny]
      end
    end

    moves
  end
end

class Game
  def initialize
    @player_1 = Player.new("celta", :white)
    @player_2 = Player.new("uno", :black)
    @board = Board.new

  end

  def win?
    king_white_alive = @player_1.pieces.any? { |p| p.is_a?(King) }
    king_black_alive = @player_2.pieces.any? { |p| p.is_a?(King) }

    unless king_white_alive
      puts "#{@player_2.name} venceu!"
      return true
    end

    unless king_black_alive
      puts "#{@player_1.name} venceu!"
      return true
    end

    false
  end


  def play
    win = false
    until win
      @board.clear
      @board.player_to_board(@player_1)
      @board.player_to_board(@player_2)
      @board.print_board
      round(@player_1)
      win = win?
      break if win

      @board.clear
      @board.player_to_board(@player_1)
      @board.player_to_board(@player_2)
      @board.print_board
      round(@player_2)
      win = win?

      @player_1.print_pieces
      @player_2.print_pieces
    end
  end

  def round(player)
    puts "#{player.name}, jogue agora"
    piece_choose = nil

    until piece_choose
      puts "Escolha a peça pela coordenada x: "
      x = 8 - gets.chomp.to_i

      puts "Escolha a peça pela coordenada y: "
      y = gets.chomp.to_i - 1

      piece_choose = player.pieces.find { |piece| piece.x == x && piece.y == y }

      puts "Escolha inválida" unless piece_choose
    end
    puts piece_choose.symbol
    valid_move = nil
    until valid_move
      puts "Diga o movimento pela coordenada x: "
      x = 8 - gets.chomp.to_i

      puts "Diga o movimento pela coordenada y: "
      y = gets.chomp.to_i - 1

      move_list = piece_choose.valid_moves(@board)
      valid_move = move_list.include?([x, y])
      puts "Escolha inválida" unless valid_move
    end
    target = @board.board[x][y]
    if target
      opponent = player == @player_1 ? @player_2 : @player_1
      opponent.pieces.delete(target)
    end
    piece_choose.x = x
    piece_choose.y = y
    piece_choose.instance_variable_set(:@moved, true)
  end
end

game = Game.new
puts game.play