class Card
  include Comparable

  CARD_VALUES = {
    'Ace'   => 14,
    'King'  => 13,
    'Queen' => 12,
    'Jack'  => 11
  }.freeze

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    CARD_VALUES.fetch(rank, rank)
  end

  protected

  def <=>(other)
    value <=> other.value
  end

  private

  # rtn a str rep of the card, ex. "Jack of Diamonds", "4 of Clubs", etc.
  def to_s
    "#{rank} of #{suit}"
  end
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Clubs Diamonds Hearts Spades).freeze

  attr_reader :cards

  def initialize
    @cards = []
  end

  def draw # draw one card from the top of the shuffled deck
    build_deck if cards.empty?
    cards.pop
  end

  private

  def build_deck # shuffled
    SUITS.each do |suit|
      RANKS.each { |rank| cards << Card.new(rank, suit) }
    end
    cards.shuffle!
  end
end

class PokerHand
  attr_reader :hand

  def initialize(deck)
    @hand = []
    5.times { hand << deck.draw }
    @card_counts = []
  end

  def print
    # hand.each { |card| puts card }
    puts hand # puts calls puts on each of the card_counts elems
  end

  def evaluate
    sort_cards

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

  attr_accessor :card_counts

  def sort_cards
    hand.sort_by! { |card| card.value }
    hsh = {}
    hand.each do |card| # count the num of cards having the same value
      if hsh.key?(card.value)
        hsh[card.value] += 1
      else
        hsh[card.value] = 1
      end
    end
    # card_counts is an arr where the elems are the num of cards having the
    # same particular value
    # ex. [1, 2, 2]    # two pair
    #     [1, 3, 1]    # three of a kind
    #     [1, 1, 2, 1] # one pair
    self.card_counts = hsh.values
  end

  def royal_flush?
    straight_flush? && hand.max.rank == 'Ace'
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    card_counts.any? { |elem| elem == 4 }
  end

  def full_house?
    card_counts.any? { |elem| elem == 3 } &&
      card_counts.any? { |elem| elem == 2 }
  end

  def flush?
    # hand.all? { |card| card.suit == 'Clubs' } ||
    #   hand.all? { |card| card.suit == 'Diamonds' } ||
    #   hand.all? { |card| card.suit == 'Hearts' } ||
    #   hand.all? { |card| card.suit == 'Spades' }

    soot = hand.first.suit
    # Deck::SUITS.any? do |soot|
      hand.all? { |card| card.suit == soot }
    # end
  end

  def straight?
    card_counts.all? { |elem| elem == 1 } &&
      # (hand[4].value - hand[0].value == 4)
      (hand.max.value - hand.min.value == 4)
  end

  def three_of_a_kind?
    card_counts.any? { |elem| elem == 3 } &&
      card_counts.none? { |elem| elem == 2 }
  end

  def two_pair?
    card_counts.count { |elem| elem == 2 } == 2
  end

  def pair?
    card_counts.count { |elem| elem == 2 } == 1
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
  puts
end
poker_test


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
