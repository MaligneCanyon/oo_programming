class Card
  include Comparable
  attr_reader :rank, :suit

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    VALUES.fetch(@rank, @rank)
  end

  def <=>(other_card)
    value <=> other_card.value
  end
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  # SUITS = %w(Hearts Clubs Diamonds Spades).freeze
  SUITS = %w(Clubs Diamonds Hearts Spades).freeze

  def initialize
    reset
  end

  def draw
    reset if @deck.empty?
    @deck.pop
  end

  private

  def reset
    @deck = RANKS.product(SUITS).map do |rank, suit|
      Card.new(rank, suit)
    end
    @deck.shuffle!
  end
end

class PokerHand
  attr_reader :my_hand

  def initialize(deck)
    @my_hand = []
    5.times { @my_hand << deck.draw }
  end

  def print
    # my_hand.each { |card| puts card }
    puts my_hand
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def sort_cards
    my_hand.sort_by! { |card| card.value }
    hsh = {}
    my_hand.each do |card|
      if hsh.key?(card.value)
        hsh[card.value] << card
      else
        # hsh[Card::VALUES.fetch(card.rank, card.rank)] = [card]
        hsh[card.value] = [card]
      end
    end
    # p hsh
    hsh
  end

  def royal_flush?
    straight_flush? && my_hand[4].rank == 'Ace'
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    sort_cards.any? { |rnk, crds| crds.size == 4 }
  end

  def full_house?
    sort_cards.any? { |rnk, crds| crds.size == 3 } &&
      sort_cards.any? { |rnk, crds| crds.size == 2 }
  end

  def flush?
    # my_hand.all? { |card| card.suit == 'Clubs' } ||
    #   my_hand.all? { |card| card.suit == 'Diamonds' } ||
    #   my_hand.all? { |card| card.suit == 'Hearts' } ||
    #   my_hand.all? { |card| card.suit == 'Spades' }

    soot = my_hand.first.suit
    # Deck::SUITS.any? do |soot|
      my_hand.all? { |card| card.suit == soot }
    # end
  end

  def straight?
    sort_cards.all? { |rnk, crds| crds.size == 1 } &&
      # (my_hand[4].value - my_hand[0].value == 4)
      (my_hand.max.value - my_hand.min.value == 4)
  end

  def three_of_a_kind?
    sort_cards.any? { |rnk, crds| crds.size == 3 } &&
      sort_cards.none? { |rnk, crds| crds.size == 2 }
  end

  def two_pair?
    sort_cards.count { |rnk, crds| crds.size == 2 } == 2
  end

  def pair?
    sort_cards.count { |rnk, crds| crds.size == 2 } == 1
  end
end


def poker_test
  arr = [
    'Royal flush',
    'Straight flush',
    'Four of a kind',
    'Full house',
    'Flush',
    'Straight',
    'Three of a kind',
    'Two pair',
    'Pair',
    'High card'
  ]

  arr.reverse.each do |str|
    counter = 0
    loop do
      counter += 1
      hand = PokerHand.new(Deck.new)
      if hand.evaluate == str
        puts "\n#{str} generated in #{counter} tries:"
        hand.print
        break
      end
    end
  end
end
# poker_test


# Testing your class:
hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'

# Output:
# 5 of Clubs
# 7 of Diamonds
# Ace of Hearts
# 7 of Clubs
# 5 of Spades
# Two pair
# true
# true
# true
# true
# true
# true
# true
# true
# true
# true
# true
# only 11 T/F tests
