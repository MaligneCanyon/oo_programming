# bonus0
# Minor adjustments to the rps_rubocop game

# bonus1
# the score is computed and displayed; the first player to reach a fixed setpt
# is the champion

# Noun: score; Verbs: compute, display
# class Score
#   def initialize
#     @score = 0
#   end
# end

# The score would be useful as a collaborator to the Player class; it's easy
# to simply make it a Player class state.  Creating a Score class may allow
# removal of the related methods from the burgeoning RPSGame class
# (implementation proved to be difficult, see file ...bonus1x.rb).

# bonus2
# game chg'd to rpslS
# - '>' method simplified; rock?, paper?, scissors? methods discarded

# bonus3
# Add a Rock (etc) class.
# Noun: rock; Verbs: ?
# Adds alot of extra classes, w/ little improvement in the code.
# There would only ever be one instance of each class.
# Each class must be def'd w/ a commonly-named (@value) instance var that reps
# the moves that it can defeat.

# bonus4
# Add a Stats class.
# Move history items are stored as a fifo arr of hshs.
# History items are displayed in a table at the end of a match.

# bonus5
# Winning moves in the move history are added to an arr from which the next
# move is chosen. This effectively biases the next move towards (recent) prior
# winning moves.

# bonus6
# Personality is unique to each Computer; generally, it only needs to be
# set once (when the Computer obj is instantiated). However, personalities
# that depend on move history need to be updated dynamically.
# Personality can be represented by an arr of potential moves, from which
# the Computer's move is chosen.

# begin bonus3
class Rock
  attr_reader :value

  def initialize
    @value = ['scissors', 'lizard']
  end
end
class Paper
  attr_reader :value

  def initialize
    @value = ['rock', 'Spock']
  end
end
class Scissors
  attr_reader :value

  def initialize
    @value = ['paper', 'lizard']
  end
end
class Lizard
  attr_reader :value

  def initialize
    @value = ['paper', 'Spock']
  end
end
class Spock
  attr_reader :value

  def initialize
    @value = ['rock', 'scissors']
  end
end
# end bonus3

class Move
  # begin bonus2
  # VALUES = ['rock', 'paper', 'scissors']
  # VALUES = {
  #   'rock'     => ['scissors', 'lizard'],
  #   'paper'    => ['rock', 'Spock'],
  #   'scissors' => ['paper', 'lizard'],
  #   'lizard'   => ['paper', 'Spock'],
  #   'Spock'    => ['rock', 'scissors']
  # }
  VALUES = {
    'rock'     => Rock.new.value,
    'paper'    => Paper.new.value,
    'scissors' => Scissors.new.value,
    'lizard'   => Lizard.new.value,
    'Spock'    => Spock.new.value
  } # bonus3
  attr_reader :value

  # def rock?
  #   @value == 'rock'
  # end

  # def paper?
  #   @value == 'paper'
  # end

  # def scissors?
  #   @value == 'scissors'
  # end
  # end bonus2

  def initialize(value)
    @value = value
  end

  def >(other_move)
    # bonus2
    # rock? && other_move.scissors? || paper? && other_move.rock? ||
    #   scissors? && other_move.paper?
    # ... expands to
    # rock? && (other_move.scissors? || other_move.lizard?) ||
    #   paper? && (other_move.rock? || other_move.Spock) ||
    #   scissors? && (other_move.paper? || other_move.lizard) ||
    #   lizard? && (other_move.Spock? || other_move.paper) ||
    #   Spock? && (other_move.scissors? || other_move.rock)
    # ... which simplifies to
    VALUES[value].include?(other_move.value)
  end

  def to_s
    # @value
    value # fallout from bonus2
  end
end

class Player
  MOVES = Move::VALUES.keys # bonus6
  # ['rock', 'paper', 'scissors', 'lizard', 'Spock']

  attr_accessor :move, :name
  attr_accessor :score # bonus1

  def initialize
    set_name
    @score = 0 # bonus1
  end

  def display_move # bonus0
    puts "#{name} chose #{move}."
  end
end

class Human < Player
  def set_name
    loop do
      puts "Please enter your name:"
      self.name = gets.chomp
      break unless name.empty?
      puts 'Sorry, must enter a value.'
    end
    puts
  end

  def choose
    choice = nil
    loop do
      # puts 'Please choose rock, paper, or scissors:'
      # puts "Please choose one of: #{Move::VALUES.keys.join(', ')}." # bonus2
      puts "Please choose one of: #{MOVES.join(', ')}." # bonus6
      choice = gets.chomp
      # break if Move::VALUES.include?(choice)
      # break if Move::VALUES.keys.include?(choice) # bonus2
      break if MOVES.include?(choice) # bonus6
      puts 'Sorry, invalid choice, try again.'
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  COMPUTERS = %w(Hal9000 R2D2 Chappie DeepThought) # bonus0

  attr_reader :stats # bonus5
  attr_accessor :personality # bonus6

  def initialize(stats) # bonus5
    @stats = stats
    super()

    @personality = set_personality # bonus6
    # Alternatively, could change
    #   attr_accessor :personality
    # to
    #   attr_reader :personality
    # and def a 'personality=' setter method (which calls the
    # 'set_personality' method from the 'choose' method)
  end

  def set_name
    # self.name = ['Hal9000', 'R2D2', 'Chappie', 'DeepThought'].sample
    self.name = COMPUTERS.sample # bonus0
  end

  # bonus6
  # set_personality method
  # - rtn an arr from which the given computer's move is chosen
  # - duplicate elements indicate a higher probability of choosing that elem
  def set_personality
    case name
    when 'Hal9000'
      ['rock'] + ['scissors'] * 10 + ['lizard'] * 3 + ['Spock'] * 3
    when 'R2D2'
      ['rock']
    else
      MOVES
    end
  end

  def choose
    # self.move = Move.new(Move::VALUES.sample)
    # self.move = Move.new(Move::VALUES.keys.sample) # bonus2

    # bonus5
    # sample_arr = Move::VALUES.keys + stats.bias
    # puts "#{name} sampled #{sample_arr}"
    # self.move = Move.new(sample_arr.sample)

    # bonus6
    # Note: bias will not include old items that have rolled off of the (fifo)
    # history
    if name == 'Chappie' # list computers here that have a move history bias
      self.personality = MOVES + stats.bias # bonus5
    end
    puts "#{name} sampled #{personality}."
    self.move = Move.new(personality.sample)
  end
end

class Stats # bonus4
  MAX_HISTORY = 10

  attr_reader :winner
  attr_accessor :history

  def initialize
    @history = []
    @winner = nil
  end

  # build_history method
  # inputs:
  # - human and computer objs
  # outputs:
  # - arr (of hshs)
  # reqs:
  # - take 2 strs (human move and computer move) and a 3rd str (winner)
  # - create a hsh from the strs
  # - store the hsh in an arr
  # - save the arr
  # rules:
  # - winner can be 'human', 'computer' or 'tie'
  # struct:
  # - arr
  # algo:
  # - determine the winner str from the human and computer @move instance vars
  # - create a hsh w/ the following k:v pairs
  #   - 'h' : str value of the human move
  #   - 'c' : str value of the comuter move
  #   - 'w' : str representing the winner
  # - store the hsh in an arr
  # - if the arr.size > MAX_HISTORY
  #   - delete the 1st arr elem
  def build_history(human_move, computer_move) # bonus4
    winner =  if human_move > computer_move
                'human'
              elsif computer_move > human_move
                'computer'
              else
                'tie'
              end
    hsh = {
      'h' => human_move.value,
      'c' => computer_move.value,
      'w' => winner
    }
    # self.history << hsh # isn't history a setter method here ? ***
    # self.history.shift if history.size > MAX_HISTORY # and here ? ***
    history << hsh
    history.shift if history.size > MAX_HISTORY
    # p history.size
    # p history
  end

  # display_history method
  # - build and output a table of recent moves # bonus4
  def display_history(human_name, computer_name)
    line = '-' * 51
    puts line
    puts format("|  # | %12s | %12s |    winner    |",
                human_name[0, 12].center(12), computer_name[0, 12].center(12))
    puts line
    history.each_with_index do |elem, ndx|
      puts format("| %2d | %12s | %12s | %12s |", ndx + 1, elem['h'].center(12),
                  elem['c'].center(12), elem['w'].center(12))
    end
    puts line
  end

  # bias method; see file bias.rb # bonus5
  def bias
    # counter_hsh = {
    #   'rock' => 0,
    #   'paper' => 0,
    #   'scissors' => 0,
    #   'lizard' => 0,
    #   'Spock' => 0
    # }
    counter_hsh = Move::VALUES.transform_values { 0 }
    history.each do |elem|
      counter_hsh[elem['c']] += 1 if elem['w'] == 'computer'
    end
    counter_hsh.map { |k, v| Array.new(v) { k } }.flatten
  end
end

class RPSGame
  GAME = 'rpslS' # 'RPS' # bonus2
  MATCH_POINTS = 10 # bonus1
  attr_accessor :human, :computer
  attr_accessor :stats # bonus4

  def initialize
    @stats = Stats.new # bonus4
    @human = Human.new
    # @computer = Computer.new
    @computer = Computer.new(stats) # bonus5
  end

  def display_welcome_message
    # puts "Welcome to RPS #{human.name} !"
    puts "Welcome to #{GAME} #{human.name} !" # bonus2
  end

  def display_goodbye_message
    # puts "Thanks for playing RPS.  Good-bye #{human.name} !"
    puts "Thanks for playing #{GAME}.  Good-bye #{human.name} !" # bonus2
  end

  # def display_moves # now Player#display_move # bonus0
  #   puts "#{human.name} chose #{human.move}."
  #   puts "#{computer.name} chose #{computer.move}."
  # end

  # display_history method
  # - build and output a table of recent moves # bonus4
  # How to move this to the Stats class ?
  # - need access to the human and computer objs w/i Stats
  #   - could take human, computer objs as args in Stats#initialize
  #   - could instantiate Stats class w/i Computer ?
  #     - still can't access the human obj then
  #   - could pass human and computer objs directly to this method
  # def display_history
  #   line = '-' * 51
  #   puts line
  #   puts format("|  # | %12s | %12s |    winner    |", human.name.center(12),
  #     computer.name.center(12))
  #   puts line
  #   stats.history.each_with_index do |elem, ndx|
  #     puts format("| %2d | %12s | %12s | %12s |", ndx + 1,
  #       elem['h'].center(12), elem['c'].center(12), elem['w'].center(12))
  #   end
  #   puts line
  # end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won !"
    elsif computer.move > human.move
      puts "#{computer.name} won !"
    else
      puts "It's a tie."
    end
  end

  # begin bonus1
  def count_score
    if human.move > computer.move
      human.score += 5 # +5 is intentional
    elsif computer.move > human.move
      computer.score += 1
    end
  end

  def display_score
    puts "Your score is #{human.score}; "\
      "the computer's score is #{computer.score}."
    puts
  end

  def match_over?
    human.score == MATCH_POINTS || computer.score == MATCH_POINTS
  end

  def display_match_result
    puts "Match is over; "\
      "#{human.score == MATCH_POINTS ? 'you are' : 'the computer is'}" \
      " the grand winner !"
  end

  def reset_scores
    human.score = 0
    computer.score = 0
  end
  # end bonus1

  def play_again?
    loop do
      puts "Would you like to play again #{human.name} ? (y/n)"
      answer = gets.chomp.downcase
      return answer == 'y' if ['y', 'n'].include?(answer)
      puts "Sorry, you must enter y or n"
    end
  end

  def play
    display_welcome_message
    loop do
      loop do # bonus1
        human.choose
        human.display_move # bonus0
        computer.choose
        computer.display_move # bonus0
        # display_moves
        display_winner
        count_score # bonus1
        display_score # bonus1
        stats.build_history(human.move, computer.move) # bonus4
        if match_over? # bonus1
          display_match_result # bonus1
          stats.display_history(human.name, computer.name) # bonus4
          break
        end
      end
      break unless play_again?
      reset_scores # bonus1
    end
    display_goodbye_message
  end
end

RPSGame.new.play
