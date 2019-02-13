# SOME IMPROVEMENTS - si#

class Board # reps state of the board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diags

  def initialize
    @squares = {}
    reset
  end

  # def get_square_at(key) # rtns a Square obj # si7 del
  #   @squares[key]
  # end

  # def set_square_at(key, marker) # sets the marker attrib of a Square obj # si8 del
  #   @squares[key].marker = marker
  # end

  def []=(key, marker) # sets the marker attrib of a Square obj # si8 add
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

=begin alternate
  # def count_human_marker(squares)
  #   squares.map(&:marker).count(TTTGame::HUMAN_MARKER)
  # end

  # def count_computer_marker(squares)
  #   squares.map(&:marker).count(TTTGame::COMPUTER_MARKER)
  # end

  # # def detect_winner # rtn the winning marker or nil # si4 del
  # def winning_marker # rtn the winning marker or nil # si4 add
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
=end

  def winning_count_reached?(line, mark) # si9 add
    # @squares.values_at(*line) is an arr of Square objs
    # @squares.values_at(*line).map(&:marker) is an arr of markers
    @squares.values_at(*line).map(&:marker).count(mark) == 3
  end

  # def detect_winner # rtn the winning marker or nil # si4 del
  def winning_marker # rtn the winning marker or nil # si4 add
    WINNING_LINES.each do |line|
      # # if @squares[line[0]].marker == TTTGame::HUMAN_MARKER &&
      # #   @squares[line[1]].marker == TTTGame::HUMAN_MARKER &&
      # #   @squares[line[2]].marker == TTTGame::HUMAN_MARKER
      #   if winning_count_reached?(line, TTTGame::HUMAN_MARKER) # si9 del
      #     return TTTGame::HUMAN_MARKER # si9 del
      # # elsif @squares[line[0]].marker == TTTGame::COMPUTER_MARKER &&
      # #   @squares[line[1]].marker == TTTGame::COMPUTER_MARKER &&
      # #   @squares[line[2]].marker == TTTGame::COMPUTER_MARKER
      #   elsif winning_count_reached?(line, TTTGame::COMPUTER_MARKER) # si9 del
      #     return TTTGame::COMPUTER_MARKER # si9 del
      TTTGame::MARKERS.each do |marker| # si9 add
        # must disable the clear method to display the following debug output:
        # p "line is #{line}, marker is #{marker}, " +
        #   "count is #{@squares.values_at(*line).map(&:marker).count(marker)}"
        return marker if winning_count_reached?(line, marker) # si9 add
      end
    end
    nil
  end

  def reset
    clear # si1 add
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def clear # si1 add
    system 'clear'
  end

  def draw # si6 add
    puts "     |     |"
    # puts "  #{get_square_at(1)}  |  #{get_square_at(2)}  |  #{get_square_at(3)}" # si7 del
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}" # si7 add
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    # puts "  #{get_square_at(4)}  |  #{get_square_at(5)}  |  #{get_square_at(6)}" # si7 del
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}" # si7 add
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    # puts "  #{get_square_at(7)}  |  #{get_square_at(8)}  |  #{get_square_at(9)}" # si7 del
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}" # si7 add
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

  def ==(other) # si10 add
    marker == other.marker
  end
end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  MARKERS = [HUMAN_MARKER, COMPUTER_MARKER]
  FIRST_MOVE = HUMAN_MARKER # COMPUTER_MARKER

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_player = set_current_player # si10 add
  end

  private # si11 add

  attr_reader :board, :human, :computer
  attr_accessor :current_player # si10 add

  def display_welcome_message
    puts "Welcome to Tic Tac Toe !"
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe !  Goodbye !"
  end

  def clear_screen_and_display_board # si3 add
    board.clear
    display_board
  end

  def display_marker_message # si6 add
    puts "You are an #{HUMAN_MARKER}.  Computer is an #{COMPUTER_MARKER}."
    puts
  end

  # def display_board(clear=true) # si1 del
  #   system 'clear' if clear # si1 del
  # def display_board(clear_screen=true) # si1 add # si2 del
  # def display_board(clear_screen: true) # si2 add # si3 del
  def display_board # si3 add
    # board.clear if clear_screen # si1 add # si3 del
    # puts "You are an #{HUMAN_MARKER}.  Computer is an #{COMPUTER_MARKER}." # si6 del
    # puts "" # si6 del
    display_marker_message # si6 add

    # si6 del follows:
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
    board.draw # si6 add
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
    # board.set_square_at(square, human.marker) # si8 del
    board[square] = human.marker # si8 add
  end

  def computer_moves
    # board.set_square_at(board.unmarked_keys.sample, computer.marker) # si8 del
    board[board.unmarked_keys.sample] = computer.marker # si8 add
  end

  def display_result
    # display_board # si3 del
    clear_screen_and_display_board # si3 add
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

  def display_play_again_message # si5 add
    puts "Let's play again !"
  end

  def reset # si5 add # note: both Board and TTTGame classes have a reset method
    board.reset
    # system 'clear' # si1 del
    set_current_player # si10 add
  end

  def set_current_player # si10 add
    # set the current player at the beginning of a new game
    # otherwise, the player who won last time will be 1st player this time
    self.current_player = FIRST_MOVE == HUMAN_MARKER ? human : computer
  end

  def current_player_moves # si10 add
    human_turn? ? human_moves : computer_moves
  end

  def human_turn? # si10 add
    current_player == human # uses the Player#== method
  end

  def toggle_current_player # si10 add
    self.current_player = human_turn? ? computer : human
  end

  public # si11 add

  def play
    # system 'clear' #  si1 del
    display_welcome_message
    loop do
      # display_board(false) # si2 del
      # display_board(clear_screen: false) # si2 add # si3 del
      display_board # si3 add

      loop do
        # human_moves # si10 del
        current_player_moves # si10 add
        break if board.someone_won? || board.full?
        # computer_moves # si10 del
        # break if board.someone_won? || board.full? # si10 del
        # display_board # si3 del
        # clear_screen_and_display_board # si3 add # si10 del
        clear_screen_and_display_board unless human_turn? # si10 add # note: use 'unless', not 'if'
        toggle_current_player # si10 add
      end

      display_result
      break unless play_again?

      # board.reset # si1 del
      # # system 'clear' # si1 add # si5 del
      # puts "Let's play again !" # si5 del
      reset # si5 add
      display_play_again_message # si5 add
    end
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
