class GuessingGame
  RANGE = 1..100
  attr_accessor :guesses_remaining, :guess

  def play
    init_game
    loop do
      display_remaining
      loop do
        display_prompt
        num = gets.to_i
        if RANGE.include?(num)
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

  attr_reader :answer

  def init_game
    @guesses_remaining = 7
    @guess = 0
    @answer = rand(RANGE)
  end

  def display_remaining
    puts "\nYou have #{guesses_remaining} "\
      "guess#{guesses_remaining > 1 ? 'es' : ''} remaining."
  end

  def display_prompt
    print "Enter a number between #{RANGE.first} and #{RANGE.last}: "
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

game = GuessingGame.new
game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 104
# Invalid guess. Enter a number between 1 and 100: 50
# Your guess is too low.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 75
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 85
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 0
# Invalid guess. Enter a number between 1 and 100: 80

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 81
# That's the number!

# You won!

game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 50
# Your guess is too high.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 25
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 37
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 31
# Your guess is too low.

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 34
# Your guess is too high.

# You have 2 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have 1 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have no more guesses. You lost!
