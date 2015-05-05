class Game
  attr_accessor :board, :turn, :player1, :player2

  def initialize
  	@board = []
  	6.times { @board << ['_','_','_','_','_','_','_'] }
  	@turn = 1
  	puts "Hello! What is player 1's name?"
    @player1 = STDIN.gets.chomp
   	puts "And what is player 2's name?"
    @player2 = STDIN.gets.chomp
  	puts "\nWelcome #{player1} and #{player2}!"
  	puts "#{player1.capitalize} will be BLACK and play first.  Good luck players!"
  	puts "Press enter to continue"
  	trash = STDIN.gets.chomp
  	start_game
  end

  def start_game
  	loop do
  	  display_board
  	  place_mark
  	  break if game_over?
      @turn += 1
  	end	
    end_game
  end

  def end_game
    display_board
    puts turn.odd? ? "#{player1} wins!" : "#{player2} wins!"
  end

  def game_over?
    #check rows
  	board.each { |row| return true if four_in_a_row?(row) }
    #check columns
    7.times do |i|
      column = []
      board.length.times { |j| column << board[j][i] }
      return true if four_in_a_row?(column)
    end
    #check diagonals in a super messy horrible way, dont try and make sense of this nightmare
    6.times do |i|
      diag1, diag2, diag3, diag4 = [], [], [], []
      i_max = 5; j_max = 6-i; j3 = i; j4 = 6
      (i+1).times do |j|
        diag1 << board[i][j]
        diag2 << board[i_max][j_max]
        diag3 << board[i_max][j3]
        diag4 << board[i][j4]
        i -= 1; j += 1
        i_max -= 1; j_max += 1; j3 -= 1; j4 -= 1
      end
      return true if (four_in_a_row?(diag1) || four_in_a_row?(diag2)) || (four_in_a_row?(diag3) || four_in_a_row?(diag4))
    end
    false
  end

  def place_mark
    mark = @turn.odd? ? 'X' : 'O'
  	puts "#{mark}'s turn, enter a column number: "
  	j = STDIN.gets.chomp.to_i - 1
    until board[0][j] == '_'
      puts "That column is already filled, please select another"
      j = STDIN.gets.chomp.to_i - 1
    end
  	i = 5
  	i -= 1 until board[i][j] == '_'
  	board[i][j] = "\u26AB" if mark == 'X'
    board[i][j] = "\u26AA" if mark == 'O'
  end

  def four_in_a_row?(ary)
    mark = @turn.odd? ? "\u26AB" : "\u26AA"
    count = 0
    ary.each do |slot|
      count = slot == mark ? count + 1 : 0
      return true if count == 4
    end
    false
  end

  def display_board
  	board.each do |row|
  	  row.each { |cell| print "  #{cell} " }
  	  puts "\n\n"
  	end
  	puts "  1   2   3   4   5   6   7\n"
  end


end
g = Game.new
