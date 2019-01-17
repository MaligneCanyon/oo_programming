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
# add a Rock (etc) class
# Noun: rock; Verbs: ?
# Adds alot of extra classes, w/ little improvement in the code.
# There would only ever be one instance of each class.
# Each class must be def'd w/ a commonly-named (@value) instance var.

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
    n = ''
    loop do
      puts "Please enter your name:"
      n = gets.chomp
      break unless n.empty?
      puts 'Sorry, must enter a value.'
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      # puts 'Please choose rock, paper, or scissors:'
      puts "Please choose one of: #{Move::VALUES.keys.join(', ')}" # bonus2
      choice = gets.chomp
      # break if Move::VALUES.include?(choice)
      break if Move::VALUES.include?(choice)
      puts 'Sorry, invalid choice, try again.'
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  COMPUTERS = %w(Hal9000 R2D2 Chappie) # bonus0

  def set_name
    # self.name = ['Hal9000', 'R2D2', 'Chappie'].sample
    self.name = COMPUTERS.sample # bonus0
  end

  def choose
    # self.move = Move.new(Move::VALUES.sample)
    self.move = Move.new(Move::VALUES.keys.sample) # bonus2
  end
end

class RPSGame
  GAME = 'rpslS' # 'RPS' # bonus2
  MATCH_POINTS = 10 # bonus1
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    # puts "Welcome to RPS #{human.name} !"
    puts "Welcome to #{GAME} #{human.name} !" # bonus2
  end

  def display_goodbye_message
    # puts "Thanks for playing RPS.  Good-bye #{human.name} !"
    puts "Thanks for playing #{GAME}.  Good-bye #{human.name} !" # bonus 2
  end

  # def display_moves # now Player#display_move # bonus0
  #   puts "#{human.name} chose #{human.move}."
  #   puts "#{computer.name} chose #{computer.move}."
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
      human.score += 5
    elsif computer.move > human.move
      computer.score += 1
    end
  end

  def display_score
    puts "Your score is #{human.score}; "\
      "the computer's score is #{computer.score}"
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
      puts "Sorry, must enter y or n"
    end
  end

  def play
    display_welcome_message
    loop do
      loop do # bonus1
        human.choose
        computer.choose
        # display_moves
        human.display_move # bonus0
        computer.display_move # bonus0
        display_winner
        count_score # bonus1
        display_score # bonus1
        if match_over? # bonus1
          display_match_result # bonus1
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
