class GuessingGame
  attr_accessor :guess

  def initialize(min, max)
    @range = (min..max).to_a
    @num = range.sample
    @guess = nil
  end

  def play
    (Math.log2(range.size).to_i + 1).downto(1) do |x|
      display_remaining(x)
      get_guess
      display_result
      break if you_won?
    end
    display_exit_msg
  end

  def get_guess
    loop do
      print "Enter a number between #{range[0]} and #{range[-1]}: "
      self.guess = gets.to_i
      break if range.include?(guess)
      print "Invalid guess. "
    end
  end

  private
  attr_reader :num, :range

  def display_remaining(x)
    puts "You have #{x} guess#{x > 1 ? "es " : " "}remaining."
  end

  def display_result
    if guess < num
      puts "Your guess is too low."
    elsif guess > num
      puts "Your guess is too high."
    else
      puts "That's the number!"
    end
    puts
  end

  def you_won?
    guess == num
  end

  def display_exit_msg
    puts you_won? ? "You won!" : "You have no more guesses! You lost!"
  end
end

game = GuessingGame.new(501, 1500)
game.play
