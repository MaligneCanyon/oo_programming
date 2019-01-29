require 'pry'

class Board # reps state of the board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diags

  def initialize
    @squares = {}
    reset
  end

  # def get_square_at(key) # rtns a Square obj # improvement 7
  #   @squares[key]
  # end

  # improvement 8
  # def set_square_at(key, marker) # sets the marker attrib of a Square obj
  #   @squares[key].marker = marker
  # end
  def []=(key, marker) # sets the marker attrib of a Square obj
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  # def count_human_marker(squares)
  #   squares.map(&:marker).count(TTTGame::HUMAN_MARKER)
  # end

  # def count_computer_marker(squares)
  #   squares.map(&:marker).count(TTTGame::COMPUTER_MARKER)
  # end

  # # def detect_winner # rtn the winning marker or nil
  # def winning_marker # rtn the winning marker or nil # improvement 4
  #   WINNING_LINES.each do |line|
  #     # if @squares[line[0]].marker == TTTGame::HUMAN_MARKER &&
  #     #   @squares[line[1]].marker == TTTGame::HUMAN_MARKER &&
  #     #   @squares[line[2]].marker == TTTGame::HUMAN_MARKER
  #     if count_human_marker(@squares.values_at(*line)) == 3
  #       return TTTGame::HUMAN_MARKER
  #     # elsif @squares[line[0]].marker == TTTGame::COMPUTER_MARKER &&
  #     #   @squares[line[1]].marker == TTTGame::COMPUTER_MARKER &&
  #     #   @squares[line[2]].marker == TTTGame::COMPUTER_MARKER
  #     elsif count_computer_marker(@squares.values_at(*line)) == 3
  #       return TTTGame::COMPUTER_MARKER
  #     end
  #   end
  #   nil
  # end

  def winning_count_reached?(line, mark) # improvement 9
    # @squares.values_at(*line) is an arr of Square objs
    # @squares.values_at(*line).map(&:marker) is an arr of markers
    @squares.values_at(*line).map(&:marker).count(mark) == 3
  end

  def winning_marker # rtn the winning marker or nil # improvement 4
    WINNING_LINES.each do |line|
      # # if @squares[line[0]].marker == TTTGame::HUMAN_MARKER &&
      # #   @squares[line[1]].marker == TTTGame::HUMAN_MARKER &&
      # #   @squares[line[2]].marker == TTTGame::HUMAN_MARKER
        # if winning_count_reached?(line, TTTGame::HUMAN_MARKER)
        #   return TTTGame::HUMAN_MARKER
      # # elsif @squares[line[0]].marker == TTTGame::COMPUTER_MARKER &&
      # #   @squares[line[1]].marker == TTTGame::COMPUTER_MARKER &&
      # #   @squares[line[2]].marker == TTTGame::COMPUTER_MARKER
        # elsif winning_count_reached?(line, TTTGame::COMPUTER_MARKER)
        #   return TTTGame::COMPUTER_MARKER
      TTTGame::MARKERS.each do |marker| # improvement 9
        # must disable the clear method to display the following debug output ...
        # p "line is #{line}, marker is #{marker}, " +
        #   "count is #{@squares.values_at(*line).map(&:marker).count(marker)}"
        return marker if winning_count_reached?(line, marker) # improvement 9
      end
    end
    nil
  end

  def reset
    clear # improvement 1
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def clear # improvement 1
    system 'clear'
  end

  def draw # improvement 6
    puts "     |     |"
    # puts "  #{get_square_at(1)}  |  #{get_square_at(2)}  |  #{get_square_at(3)}"
    # improvement 7 # little improvement; better to use the getter method ?
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}" # improvement 7
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    # puts "  #{get_square_at(4)}  |  #{get_square_at(5)}  |  #{get_square_at(6)}"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}" # improvement 7
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    # puts "  #{get_square_at(7)}  |  #{get_square_at(8)}  |  #{get_square_at(9)}"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}" # improvement 7
    puts "     |     |"
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  MARKERS = [HUMAN_MARKER, COMPUTER_MARKER]

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe !"
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe !  Goodbye !"
  end

  # improvement 3
  def clear_screen_and_display_board
    board.clear
    display_board
  end

  def display_marker_message # improvement 6
    puts "You are an #{HUMAN_MARKER}.  Computer is an #{COMPUTER_MARKER}."
    puts
  end

  # def display_board(clear=true)
  #   system 'clear' if clear
  # def display_board(clear_screen=true) # improvement 1
  #   board.clear if clear_screen # improvement 1
  # def display_board(clear_screen: true) # improvement 2
  def display_board # improvement 3
    # board.clear if clear_screen # improvement 3
    # puts "You are an #{HUMAN_MARKER}.  Computer is an #{COMPUTER_MARKER}."
    # puts ""
    display_marker_message # improvement 6
    # puts "     |     |"
    # puts "  #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  |  #{board.get_square_at(3)}"
    # puts "     |     |"
    # puts "-----+-----+-----"
    # puts "     |     |"
    # puts "  #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  |  #{board.get_square_at(6)}"
    # puts "     |     |"
    # puts "-----+-----+-----"
    # puts "     |     |"
    # puts "  #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  |  #{board.get_square_at(9)}"
    # puts "     |     |"
    board.draw # improvement 6
    puts
  end

  def human_moves
    puts "Choose a square (#{board.unmarked_keys.join(', ')}):"
    square = nil
    loop do
      square = gets.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    # board.set_square_at(square, human.marker)
    board[square] = human.marker # improvement 8
  end

  def computer_moves
    # board.set_square_at(board.unmarked_keys.sample, computer.marker)
    board[board.unmarked_keys.sample] = computer.marker # improvement 8
  end

  def display_result
    # display_board
    clear_screen_and_display_board # improvement 3
    case board.winning_marker
    when human.marker # HUMAN_MARKER
      puts "You won !"
    when computer.marker # COMPUTER_MARKER
      puts "The computer won !"
    else
      puts "It's a tie !"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again ? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, that's not a valid choice."
    end
    answer == 'y'
  end

  def display_play_again_message # improvement 5
    puts "Let's play again !"
  end

  def reset # improvement 5
    board.reset
    # system 'clear' # improvement 1
  end

  def play
    # system 'clear' # improvement 1
    display_welcome_message
    loop do
      # display_board(false)
      # display_board(clear_screen: false) # improvement 2
      display_board # improvement 3
      loop do
        # first_player_moves
        human_moves
        break if board.someone_won? || board.full?
        computer_moves
        break if board.someone_won? || board.full?
        # display_board
        clear_screen_and_display_board # improvement 3
      end
      display_result
      break unless play_again?

      # board.reset
      # # system 'clear' # improvement 1
      # puts "Let's play again !"
      reset # improvement 5
      display_play_again_message # improvement 5
    end
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
