# In the reference implementation, we use a Hand module that is mixed into Player and Dealer.

# Let the Deck class do the dealing (it's actually irrelevant who deals, other than the ordering
# of who goes first).  That way, both Player and Dealer are both generic.
require 'pry'


class Participant
  # what goes in here? all the redundant behaviors from Player and Dealer?

  attr_accessor :name, :cards, :total

  def initialize
    # what would the "data" or "states" of a Player object entail?
    # maybe cards? a name?
    @name = ''
    @cards = [] # an arr of Card objs
    @total = nil
    # @deck = deck # a CO ***
  end

  def busted?
    total > Deck::MAX_BREAK_POINT
  end

  def display_hand
    totalize(cards)
    # puts "#{name}'s cards are #{cards}; total is #{totalize(cards)}"
    puts "#{name}'s cards are #{cards.map(&:name)}; total is #{total}"
  end

  def totalize(cards)
    # definitely looks like we need to know about "cards" to produce some total
    # binding.pry
    ttl = 0
    cards.each { |card| ttl += card.value }
    cards.each { |card| ttl -= 10 if ttl > Deck::MAX_BREAK_POINT && card.name == 'A' }
    self.total = ttl
  end
end


class Player < Participant
  def set_name
    # puts "Please enter your name:"
    # choice = nil
    # loop do
    #   choice = gets.chomp
    #   break unless choice == ''
    # end
    # self.name = choice
    self.name = "Bob" # *** forced
  end

  def player_choice
    answer = ''
    loop do
      puts 'Hit or Stay ?'
      answer = gets.chomp
      if answer.downcase.start_with?('h')
        answer = 'hit'
        break
      elsif answer.downcase.start_with?('s')
        answer = 'stay'
        break
      end
      puts 'Sorry, not a valid choice'
    end
    puts "You chose to #{answer} !"
    answer
  end

  def turn(deck)
    loop do
      break if player_choice == 'stay'
      cards << deck.shuffled_cards.pop
      # p "#{deck.shuffled_cards.size} shuffled cards left in the deck"
      display_hand
      break if busted?
    end
  end
end


class Dealer < Participant
  COMPUTERS = %w(Hal9000 R2D2 Chappie DeepThought)

  # def initialize
  #   # seems like very similar to Player... do we even need this?
  # end

  # def deal
  #   # does the dealer or the deck deal?
  # end

  def turn(deck)
    loop do
      display_hand
      break if busted?
      break if total >= Deck::DEALER_BREAK_POINT
      cards << deck.shuffled_cards.pop
    end
  end

  def set_name
    self.name = COMPUTERS.sample
  end
end


class Deck
  DEALER_BREAK_POINT = 17 # usually 17
  MAX_BREAK_POINT    = 21 # usually 21

  attr_reader :suits, :player, :dealer
  attr_accessor :shuffled_cards

  def initialize(player, dealer)

    # obviously, we need some data structure to keep track of cards
    # array, hash, something else?
    @suits = [
      Suit.new('clubs'),
      Suit.new('diamonds'),
      Suit.new('hearts'),
      Suit.new('spades')
    ]
    @shuffled_cards = []
    @player = player # CO
    @dealer = dealer # CO
  end

  def deal
    # does the dealer or the deck deal?
    self.shuffled_cards = suits.map(&:suited_cards).flatten.shuffle
    # puts shuffled_cards
    # puts shuffled_cards.size # should be 52
    player.cards = shuffled_cards.pop(2)
    dealer.cards = shuffled_cards.pop(2)
  end
end


class Suit # suit is actually irrelevant in the game '21'
  attr_reader :suited_cards

  def initialize(suit)
    # obviously, we need some data structure to keep track of cards
    # array, hash, something else?
    @suited_cards = [
      Card.new('A', 11, suit),
      Card.new('K', 10, suit),
      Card.new('Q', 10, suit),
      Card.new('J', 10, suit)
    ]
    10.downto(2) { |num| @suited_cards << Card.new(num.to_s, num, suit) }
    # p @suited_cards
  end
end


class Card
  attr_reader :name, :value # suit is irrelevant

  def initialize(name, value, suit)
    # what are the "states" of a card?
    @name = name
    @value = value
    @suit = suit # just for fun !
  end
end


class Score
  RESULT = ["Dealer wins", "It's a tie", "Player wins"]

  attr_accessor :result

  def initialize
    @result = nil
  end

  def show_result
    puts "#{@result} !"
  end
end


class Game
  attr_reader :deck, :player, :dealer, :score

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new(player, dealer)
    @score = Score.new
  end

  def setup_game
    display_welcome_message
    player.set_name
    dealer.set_name
    # p player.name, dealer.name
  end

  def display_welcome_message
    puts "Welcome to #{Deck::MAX_BREAK_POINT} !"
  end

  def show_initial_cards
    player.display_hand
    dealer.display_hand
    puts "#{dealer.name} has #{prefixed_str(dealer.cards[1].name)}"
  end

  # rtn the spec'd str w/ either 'an ' or 'a ' prefixed to it, depending on the
  # 1st char of the str
  def prefixed_str(str)
    (%w(A 8).include?(str.chr) ? 'an ' : 'a ') << str
  end

  def compare_cards # this could be a Participant protected method ***
    score.result = Score::RESULT[(player.total <=> dealer.total) + 1]
  end

  def start
    # what's the sequence of steps to execute the game play?
    setup_game
    deck.deal
    show_initial_cards
    player.turn(deck)

    if player.busted?
      score.result = Score::RESULT[0] # puts "Dealer wins !"
    else
      dealer.turn(deck)
      if dealer.busted?
        score.result = Score::RESULT[2] # puts "Player wins !"
      else
        compare_cards
      end
    end
    score.show_result
  end
end


Game.new.start
