class Move
  VALUES = ['rock', 'paper', 'scissors']

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

  def >(other_move)
    rock? && other_move.scissors? || paper? && other_move.rock? ||
      scissors? && other_move.paper?
  end
  # def >(other_move)
  #   if rock? # a boolean
  #     # return true if other_move.scissors?
  #     # return false
  #     other_move.scissors? # another boolean
  #   elsif paper?
  #     other_move.rock?
  #   else # scissors?
  #     other_move.paper?
  #   end
  # end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name

  def initialize
    set_name # can call a derived class method in the parent class
  end
end

class Human < Player
  def set_name # template for how to initialize from user input
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
      break if Move::VALUES.include?(choice)
      puts 'Sorry, invalid choice, try again.'
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['Hal9000', 'R2D2', 'Chappie'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

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

  def display_moves # added to appease rubocop
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    # puts "#{human.name} chose #{human.move}." # moved to display_moves
    # puts "#{computer.name} chose #{computer.move}." # moved to display_moves

    if human.move > computer.move
      puts "#{human.name} won !"
    elsif computer.move > human.move
      puts "#{computer.name} won !"
    else
      puts "It's a tie."
    end
  end

  def play_again?
    loop do
      puts "Would you like to play again #{human.name} ? (y/n)"
      answer = gets.chomp.downcase
      return answer == 'y' if ['y', 'n'].include?(answer)
      puts "Sorry, must enter y or n"
    end
    # answer = nil
    # loop do
    #   puts 'Would you like to play again ? (y/n)'
    #   answer = gets.chomp.downcase
    #   break if ['y', 'n'].include?(answer)
    #   puts 'Sorry, must enter y or n'
    # end
    # answer == 'y'
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_moves # added to appease rubocop
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
