# require 'Math'

class GuessingGame
  # RANGE = 1..100
  attr_accessor :guesses_remaining, :guess

  def initialize(low, high)
    @range = low..high
  end

  def play
    init_game
    loop do
      display_remaining
      loop do
        display_prompt
        num = gets.to_i
        if range.include?(num)
          self.guess = num
          break
        end
        print 'Invalid guess. '
      end
      display_result
      break unless continue_play?
      self.guesses_remaining -= 1
      if guesses_remaining.zero?
        puts "\nYou have no more guesses. You lost!"
        break
      end
    end
  end

  private

  attr_reader :answer, :range

  def init_game
    @guesses_remaining = Math::log2(range.size).to_i + 1
    @guess = 0
    @answer = rand(range)
  end

  def display_remaining
    puts "\nYou have #{guesses_remaining} "\
      "guess#{guesses_remaining > 1 ? 'es' : ''} remaining."
  end

  def display_prompt
    print "Enter a number between #{range.first} and #{range.last}: "
  end

  def display_result
    if guess < answer
      puts "Your guess is too low.\n"
    elsif guess > answer
      puts "Your guess is too high.\n"
    else
      puts "That's the number!\n\nYou won!"
    end
  end

  def continue_play?
    guess != answer
  end
end

# game = GuessingGame.new(1, 100)
game = GuessingGame.new(501, 1500)
game.play

# You have 10 guesses remaining.
# Enter a number between 501 and 1500: 104
# Invalid guess. Enter a number between 501 and 1500: 1000
# Your guess is too low.

game.play
