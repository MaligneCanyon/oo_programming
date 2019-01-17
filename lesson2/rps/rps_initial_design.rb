# Rock, Paper, Scissors is a two-player game where each player chooses
# one of three possible moves: rock, paper, or scissors. The chosen moves
# will then be compared to see who wins, according to the following rules:

# - rock beats scissors
# - scissors beats paper
# - paper beats rock

# If the players chose the same move, then its a tie.

# Nouns: player, move, rule
# Verbs: choose, compare

# Player - choose
# Move
# Rule
# ? - compare


# class Move
#   def initialize
#     # seems like we need something to keep track
#     # of the choice... a move object can be "paper", "rock" or "scissors"
#   end
# end

# class Rule
#   def initialize
#     # not sure what the "state" of a rule object should be
#   end
# end

# # not sure where "compare" goes yet
# def compare(move1, move2)

# end


class Player
  attr_accessor :move, :name

  def initialize(player_type = :human)
    # maybe a "name"? what about a "move"?
    @player_type = player_type
    @move = nil
    set_name
  end

  def set_name
    if human?
      n = ''
      loop do
        puts "Please enter your name:"
        n = gets.chomp
        break unless n.empty?
        puts 'Sorry, must enter a value.'
      end
      self.name = n
    else
      self.name = ['Hal9000', 'R2D2', 'Chappie'].sample
    end
  end

  def choose
    if human?
      choice = nil
      loop do
        puts 'Please choose rock, paper, or scissors:'
        choice = gets.chomp
        break if ['rock', 'paper', 'scissors'].include?(choice)
        puts 'Sorry, invalid choice, try again.'
      end
      self.move = choice
    else
      self.move = ['rock', 'paper', 'scissors'].sample
    end
  end

  def human?
    @player_type == :human
  end
end

# game orchestration engine
class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new #(:human) default
    @computer = Player.new(:computer)
  end

  def display_welcome_message
    puts "Welcome to RPS #{human.name} !"
  end

  def display_goodbye_message
    puts "Thanks for playing RPS.  Good-bye #{human.name} !"
  end

  def display_winner
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."

    case human.move
    when 'rock'
      puts "It's a tie." if computer.move == 'rock'
      puts "#{human.name} won !" if computer.move == 'scissors'
      puts "#{computer.name} won !" if computer.move == 'paper'
    when 'paper'
      puts "It's a tie." if computer.move == 'paper'
      puts "#{human.name} won !" if computer.move == 'rock'
      puts "#{computer.name} won !" if computer.move == 'scissors'
    when 'scissors'
      puts "It's a tie." if computer.move == 'scissors'
      puts "#{human.name} won !" if computer.move == 'paper'
      puts "#{computer.name} won !" if computer.move == 'rock'
    end
  end

  def play_again?
    # answer = nil
    # puts 'Would you like to play again ? (y/n)'
    # loop do
    #   answer = gets.chomp.downcase
    #   break if ['y', 'n'].include?(answer)
    #   puts 'Sorry, must enter y or n'
    # end
    # answer == 'y'

    puts "Would you like to play again #{human.name} ? (y/n)"
    loop do
      answer = gets.chomp.downcase
      return answer == 'y' if ['y', 'n'].include?(answer)
      puts "Sorry, must enter y or n"
    end
  end

  def play # procedural code goes here
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
