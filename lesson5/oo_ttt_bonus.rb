# NEW BONUS FEATURES - nb#

# nb0
# trivial fixups of solution code

# nb1
# bonus features from the procedural TTT_bonus prog

# nb2
# player can pick any marker (a-z, A-Z, 0-9)
# computer marker is 'O' (except 'X' if player marker is 'O', 'o', or '0')

# nb3
# player enters their name
# computer name is sampled from an arr

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    # @squares.keys.select { |key| @squares[key].unmarked? }
    @squares.keys.reject { |key| @squares[key].marked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line) # an arr of 3 squares in a line
      if three_identical_markers?(squares)
        return squares.first.marker # X or O (traditionally)
      end
    end
    nil
  end

  # def identical_markers?(squares, num_markers) # bonus3 add
  #   markers = squares.select(&:marked?).collect(&:marker)
  #   # return false if markers.size != 3 # bonus3 del
  #   return false if markers.size != num_markers # bonus3 add
  #   markers.min == markers.max
  # end

  # bonus3 add
  # when there is an 'immediate threat' we, want to rtn the square number
  # (i.e. the key) of the unmarked square
  def detect_action(marker)
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if squares.count { |square| square.marker == marker } == 2
        line.each_index do |ndx|
          num = line[ndx]
          return num if @squares[num].marker == Square::INITIAL_MARKER
        end
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    marker
  end

  # def unmarked? # don't need both this and 'marked?'
  #   marker == INITIAL_MARKER
  # end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker
  attr_writer :marker # nb2 add
  attr_accessor :score # bonus2 add
  attr_accessor :name # nb3 add

  # def initialize(marker) # nb2 del
  def initialize # nb2 add
    # @marker = marker # nb2 del
    @marker = nil # nb2 add
    @score = 0 # bonus2 add
    @name = '' # nb3 add
  end
end

module Joinable # bonus1 add
  def joinor(arr, delimiter = ', ', conjunction = 'or')
    return '' if arr.empty?
    arr.map!(&:to_s)
    return arr[0] if arr.size == 1
    str = arr.size > 2 ? arr[0..-2].join(delimiter) + delimiter : arr[0] + ' '
    str << conjunction + ' ' + arr[-1]
  end
end

class TTTGame
  include Joinable # bonus1 add

  # HUMAN_MARKER = "X" # nb2 del
  # COMPUTER_MARKER = "O" # nb2 del
  # FIRST_TO_MOVE = HUMAN_MARKER # nb2 del
  FIRST_TO_MOVE = 'choose' # 'player', 'computer', or 'choose' # bonus5c add
  MATCH_POINTS = 3 # bonus2 add
  MARKERS = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a # nb2 add
  COMPUTERS = %w(Hal9000 R2D2 Chappie DeepThought) # nb3 add

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    # @human = Player.new(HUMAN_MARKER) # nb2 del
    # @computer = Player.new(COMPUTER_MARKER) # nb2 del
    # @current_marker = FIRST_TO_MOVE # nb2 del

    # nb2 add
    @human = Player.new
    @computer = Player.new
    @current_marker = nil
    @first_to_move = nil
  end

  def set_names # nb3 add
    puts "Please enter your name:"
    choice = nil
    loop do
      choice = gets.chomp
      break unless choice == ''
    end
    human.name = choice
    computer.name = COMPUTERS.sample
  end

  def set_first_mover # bonus5c add
    if FIRST_TO_MOVE == 'player'
      @first_to_move = human.marker
    elsif FIRST_TO_MOVE == 'computer'
      @first_to_move = computer.marker
    else # FIRST_TO_MOVE == 'choose'
      puts "Who goes first ? You or #{computer.name} ? (y or c)"
      answer = gets.chomp.downcase
      @first_to_move = answer.start_with?('c') ? computer.marker : human.marker
    end
  end

  def set_markers # nb2 add
    puts "Please choose a marker: "
    choice = nil
    loop do
      choice = gets.chomp
      break if MARKERS.include?(choice)
      puts "Sorry, that's not a valid choice."
    end
    human.marker = choice
    # computer marker will be 'O' unless the human marker is one of the listed
    # choices
    computer.marker = ['O', 'o', 'Q', '0'].include?(choice) ? 'X' : 'O'
    set_first_mover # bonus5c add
    @current_marker = @first_to_move
    # p "human:#{human.marker}, computer:#{computer.marker}, " \
    #   "first:#{@first_to_move}, current:#{@current_marker}"
  end

  def analyze_scoring # bonus2 add
    # Ambiguous as to how to implement:
    # - do we play to 5 games then ask whether to play again at the end of
    #   the match ?
    #   - how do we pause before clearing the screen between games ?
    #     - wait for any key press ?
    #   - what if we want to quit half way thru the match ? use ctrl-c ?
    # - do we ask whether to play again after each game and then exit the
    #   prog at the end of the match ? (used by procedural TTT_bonus prog)
    # - or do we use the existing looping structure and just count to 5,
    #   reseting the counter at the end of the match ?
    #   - allows us to exit after any game (mid or end of match)
    # Implemented using the third option:
    count_score
    display_score

    # for rubocop
    # if match_over?
    #   display_match_result
    #   reset_scores
    # end
    display_match_result if match_over?
    reset_scores if match_over?
  end

  def setup_game # for rubocop
    clear
    display_welcome_message
    set_names # nb3 add
    set_markers # nb2 add
  end

  def play
    setup_game
    loop do
      display_board
      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board
      end
      display_result
      analyze_scoring # bonus2 add
      break unless play_again?
      reset
      display_play_again_message
    end
    display_goodbye_message
  end

  private

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    # puts "Thanks for playing Tic Tac Toe! Goodbye!" # nb3 del
    puts "Thanks for playing Tic Tac Toe! Goodbye #{human.name}!" # nb3 add
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def marker_text(marker) # nb0 add
    "#{(%w(a e f h i l m n o r s x).include?(marker.downcase) ? 'an' : 'a')} "\
    "'#{marker}'"
  end

  def display_board
    # puts "You're a #{human.marker}. "\
    #      "Computer is a #{computer.marker}." # nb0 del
    # puts "You're #{marker_text(human.marker)}. "\
    #      "Computer is #{marker_text(computer.marker)}." # nb0 add # nb3 del
    puts "You're #{marker_text(human.marker)}. "\
         "#{computer.name} is #{marker_text(computer.marker)}." # nb3 add
    puts ""
    board.draw
    puts ""
  end

  def human_moves
    # puts "Choose a square (#{board.unmarked_keys.join(', ')}): " # bonus1 del
    puts "Choose a square (#{joinor(board.unmarked_keys)}): " # bonus1 add
    square = nil
    loop do
      # square = gets.chomp.to_i # nb0 del
      square = gets.to_i # nb0 add

      # nb0 add (press Enter or any other key if there is only one square left)
      if board.unmarked_keys.size == 1
        square = board.unmarked_keys[0]
        break
      end

      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    # board[board.unmarked_keys.sample] = computer.marker # bonus3 del
    key = board.detect_action(computer.marker) # bonus4, bonus5a add
    key ||= board.detect_action(human.marker) # bonus4 add
    # key = board.detect_action(human.marker) # bonus3 add # bonus4 del
    ukeys = board.unmarked_keys # bonus5b add (just for rubocop)
    key ||= 5 if ukeys.include?(5) # bonus5b add
    key ||= ukeys.sample # bonus3 add
    board[key] = computer.marker # bonus3 add
  end

  def current_player_moves
    # if @current_marker == HUMAN_MARKER # nb2 del
    if @current_marker == human.marker # nb2 add
      human_moves
      # @current_marker = COMPUTER_MARKER # nb2 del
      @current_marker = computer.marker # nb2 add
    else
      computer_moves
      # @current_marker = HUMAN_MARKER # nb2 del
      @current_marker = human.marker # nb2 add
    end
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      # puts "You won!" # nb3 del
      puts "You won!"
    when computer.marker
      # puts "Computer won!" # nb3 del
      puts "#{computer.name} won!" # nb3 add
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end
    answer == 'y'
  end

  def clear
    system "clear"
  end

  def reset
    board.reset
    # @current_marker = FIRST_TO_MOVE # nb2 del
    @current_marker = @first_to_move # nb2 add
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  # begin bonus2 add
  # note: a Score class would likely need human, computer and board COs
  def count_score
    if board.winning_marker == human.marker
      human.score += 1
    elsif board.winning_marker == computer.marker
      computer.score += 1
    end
  end

  def display_score
    # puts "Your score is #{human.score}; "\
    #   "the computer's score is #{computer.score}." # nb3 del
    puts "Your score is #{human.score}; "\
      "#{computer.name}'s score is #{computer.score}." # nb3 add
    puts
  end

  def match_over?
    human.score == MATCH_POINTS || computer.score == MATCH_POINTS
  end

  def display_match_result
    # puts "Match is over; "\
    #   "#{human.score == MATCH_POINTS ? 'you are' : 'the computer is'}" \
    #   " the grand winner !" # nb3 del
    puts "Match is over; "\
      "#{human.score == MATCH_POINTS ? 'you are' : computer.name + ' is'}" \
      " the grand winner !" # nb3 add
  end

  def reset_scores
    human.score = 0
    computer.score = 0
  end
  # end bonus2 add
end

game = TTTGame.new
game.play
