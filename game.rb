class Game
  X = 'X'.freeze
  O = 'O'.freeze

  def initialize
    @board = Array.new(3) { Array.new(3, ' ') }
    @winner = nil
  end

  def start
    display_board

    loop do
      break unless [X, O].each do
        play_turn _1
        if won? _1
          @winner = _1 and
          break
        end
        break if all_filled?
      end
    end
    
    puts @winner.nil? ? "It's a draw" : "#{@winner} is a winner"
  end

  private

  def won?(side)
    any_row_filled_with?(side) ||
    any_col_filled_with?(side) ||
    any_diagonal_filled_with?(side)
  end

  def any_diagonal_filled_with?(side)
    [
      (0...@board.length).collect { @board[_1][_1] },
      (0...@board.length).collect { @board.reverse[_1][_1] }
    ].any? do |diagonal|
      [X, O].any? { |side| diagonal.all? { _1 == side } }
    end
  end

  def any_row_filled_with?(side)
    @board.any? { _1.all? { |ch| ch == side } }
  end

  def any_col_filled_with?(side)
    (0..@board.length).any? do |col|
      @board.all? { |row| row[col] == side }
    end
  end

  def all_filled?
    @board.flatten.none? { _1.strip.empty? }
  end

  def play_turn(side)
    puts "Player #{side}'s turn. Enter row and column like this '1, 2':"
    loop do
      row, col = gets.chomp!.split(',').map(&:to_i).map! {_1 - 1}

      unless @board[row][col].strip.empty?
        puts "Wrong input, enter again."
        next
      end

      @board[row][col] = side and break
    end

    display_board
  end

  def display_board
    delimeter = '-+-+-'

    puts "Board:"
    puts @board.first.join("|"), delimeter, @board[1].join("|"), delimeter, @board[2].join("|")
  end
end

game = Game.new
game.start
