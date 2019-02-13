class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  # SUITS = %w(Hearts Clubs Diamonds Spades).freeze # wrong order !
  SUITS = %w(Clubs Diamonds Hearts Spades).freeze

  attr_reader :cards

  def initialize
    @cards = []
  end

  # algo:
  # - init an arr to [] <= Deck#initialize
  # - build the deck if the arr is empty
  # - for each suit
  #   - for each rank
  #     - instantiate a card obj
  #     - save the the card to the arr

  def draw # draw one card at random
    build_deck if cards.empty?
    ndx = (0...cards.size).to_a.sample
    cards.delete_at(ndx)
  end

  private

  def build_deck # unshuffled
    SUITS.each do |suit|
      RANKS.each { |rank| cards << Card.new(rank, suit) }
    end
    # could use cards.shuffle! here, then use cards.pop in #draw
    # (perhaps better than pulling a card from the middle of the deck)
  end
end

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

  def <=>(other)
    value <=> other.value
  end

  # rtn a String rep of the card, ex. "Jack of Diamonds", "4 of Clubs", etc.
  def to_s
    "#{rank} of #{suit}"
  end
end

deck = Deck.new
drawn = []
# 2.times { drawn << deck.draw }
# puts drawn
# p deck
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.
