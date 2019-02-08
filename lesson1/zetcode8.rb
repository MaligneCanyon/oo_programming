class Feline; end

class Cat < Feline
  def self.home
    "Home cat"
  end

  def house
    "House cat"
  end
end

p Cat.home
cat = Cat.new
p cat.house

# p Feline.home # NoMethodError # superclass can't access subclass class methods ?
feline = Feline.new
p feline.house # NoMethodError # superclass can't access subclass instance methods ?
