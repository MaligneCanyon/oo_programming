class Card
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def ==(other)
    rank == other.rank && suit == other.suit
  end

  # rtn a String rep of the card, ex. "Jack of Diamonds", "4 of Clubs", etc.
  def to_s
    "#{rank} of #{suit}"
  end
end

class Array # MonkeyPatch
  CARD_VALUES = {
    'Ace'   => 14,
    'King'  => 13,
    'Queen' => 12,
    'Jack'  => 11
  }

  def min
    # self.min_by { |card| CARD_VALUES[card.rank] }
    self.min_by { |card| CARD_VALUES.fetch(card.rank, card.rank) }
  end

  def max
    self.max_by { |card| CARD_VALUES.fetch(card.rank, card.rank) }
  end
end

cards = [Card.new(2, 'Hearts'),
         Card.new(10, 'Diamonds'),
         Card.new('Ace', 'Clubs')]
puts cards
puts cards.min == Card.new(2, 'Hearts')
puts cards.max == Card.new('Ace', 'Clubs')

cards = [Card.new(5, 'Hearts')]
puts cards.min == Card.new(5, 'Hearts')
puts cards.max == Card.new(5, 'Hearts')

cards = [Card.new(4, 'Hearts'),
         Card.new(4, 'Diamonds'),
         Card.new(10, 'Clubs')]
puts cards.min.rank == 4
puts cards.max == Card.new(10, 'Clubs')

cards = [Card.new(7, 'Diamonds'),
         Card.new('Jack', 'Diamonds'),
         Card.new('Jack', 'Spades')]
puts cards.min == Card.new(7, 'Diamonds')
puts cards.max.rank == 'Jack'

cards = [Card.new(8, 'Diamonds'),
         Card.new(8, 'Clubs'),
         Card.new(8, 'Spades')]
puts cards.min.rank == 8
puts cards.max.rank == 8
