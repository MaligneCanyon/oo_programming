class Move # create a new class to allow for Move objs
  VALUES = ['rock', 'paper', 'scissors']

  # attr_reader :value # *** could use this instead of redef'ing to_s ...

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  # define a custom .>() method that allows direct comparison of Move objs
  def >(other_move)
    # puts "@value == #{@value}, self.value == #{self.value}, other_move.value == #{other_move.value}" # ***
    if rock? # a boolean
      # return true if other_move.scissors?
      # return false
      other_move.scissors? # another boolean
    elsif paper?
      other_move.rock?
    else scissors?
      other_move.paper?
    end
  end

  def to_s # redef to_s to allow puts obj.move to display the @value instance var
    @value
  end
end

class Player
  attr_accessor :move, :name

  def initialize
    set_name
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
      puts 'Please choose rock, paper, or scissors:'
      choice = gets.chomp
      # break if ['rock', 'paper', 'scissors'].include?(choice)
      break if Move::VALUES.include?(choice)
      puts 'Sorry, invalid choice, try again.'
    end
    # self.move = choice
    self.move = Move.new(choice) # move must be a Move obj, not a String obj
  end
end

class Computer < Player
  def set_name
    self.name = ['Hal9000', 'R2D2', 'Chappie'].sample
  end

  def choose
    # self.move = ['rock', 'paper', 'scissors'].sample # move must be a Move obj, not a String obj
    self.move = Move.new(Move::VALUES.sample)
  end
end


# game orchestration engine
class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to RPS #{human.name} !"
  end

  def display_goodbye_message
    puts "Thanks for playing RPS.  Good-bye #{human.name} !"
  end

  # want to simplify logic in display_winner method
  # - move away from nested 'if' clause w/i a 'case' statement
  # would be better if we could directly compare human.move to computer.move
  # - these are currently String objs
  # - display_winner has no way of comparing the value of the strs to determine
  #   the winner
  # - need to redefine the @move instance var so that it's a custom obj (a
  #   collaborator obj, an obj of a custom class), rather than a String
  # - need to def another class (Move)
  # - Move obj will be a collaborator for the Human and Computer objs

  def display_winner
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."

    # this reads better and is easier to nav than the complex case statement
    # - in order to use this syntax, must def a .>() method that accepts a
    #   Move obj arg
    if human.move > computer.move
      puts "#{human.name} won !"
    # elsif human.move < computer.move # don't need to redef '<', just use '>'
    elsif computer.move > human.move
      puts "#{computer.name} won !"
    else
      puts "It's a tie."
    end

    # case human.move
    # when 'rock'
    #   puts "It's a tie." if computer.move == 'rock'
    #   puts "#{human.name} won !" if computer.move == 'scissors'
    #   puts "#{computer.name} won !" if computer.move == 'paper'
    # when 'paper'
    #   puts "It's a tie." if computer.move == 'paper'
    #   puts "#{human.name} won !" if computer.move == 'rock'
    #   puts "#{computer.name} won !" if computer.move == 'scissors'
    # when 'scissors'
    #   puts "It's a tie." if computer.move == 'scissors'
    #   puts "#{human.name} won !" if computer.move == 'paper'
    #   puts "#{computer.name} won !" if computer.move == 'rock'
    # end
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
