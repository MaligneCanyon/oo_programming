class Player
  attr_accessor :move, :name

  def initialize#(player_type = :human) # no longer needed
    # @player_type = player_type # no longer needed
    # @move = nil # not needed; @move is initialized to nil by default
    set_name
  end

  # want to subclass Human and Computer from Player in orger to get rid of
  # repetitive if-then-else structure in the set_name and choose methods

  # def set_name # push code to subclasses
  #   if human?
  #     n = ''
  #     loop do
  #       puts "Please enter your name:"
  #       n = gets.chomp
  #       break unless n.empty?
  #       puts 'Sorry, must enter a value.'
  #     end
  #     self.name = n
  #   else
  #     self.name = ['Hal9000', 'R2D2', 'Chappie'].sample
  #   end
  # end

  # def choose # push code to subclasses
  #   if human?
  #     choice = nil
  #     loop do
  #       puts 'Please choose rock, paper, or scissors:'
  #       choice = gets.chomp
  #       break if ['rock', 'paper', 'scissors'].include?(choice)
  #       puts 'Sorry, invalid choice, try again.'
  #     end
  #     self.move = choice
  #   else
  #     self.move = ['rock', 'paper', 'scissors'].sample
  #   end
  # end

  # def human? # no longer needed
  #   @player_type == :human
  # end
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
      puts 'Please choose rock, paper, or scissors:'
      choice = gets.chomp
      break if ['rock', 'paper', 'scissors'].include?(choice)
      puts 'Sorry, invalid choice, try again.'
    end
    self.move = choice
  end
end

class Computer < Player
  def set_name
    self.name = ['Hal9000', 'R2D2', 'Chappie'].sample
  end

  def choose
    self.move = ['rock', 'paper', 'scissors'].sample
  end
end


# game orchestration engine
class RPSGame
  attr_accessor :human, :computer

  def initialize
    # @human = Player.new
    @human = Human.new # instantiate from subclass
    # @computer = Player.new(:computer)
    @computer = Computer.new # instantiate from subclass
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
