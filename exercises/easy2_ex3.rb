class House
  include Comparable # include the Comparable module ...
  attr_reader :price

  def initialize(price)
    @price = price
  end

  # protected  # <= this works, but is not req'd
  def <=>(other) # ... and re-def the <=> method
    price <=> other.price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1

# Home 1 is cheaper
# Home 2 is more expensive
