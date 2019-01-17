class Pets
  def jump
    puts 'jumping'
  end
end

class Cat < Pets; end
class Bulldog < Pets; end

class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = [] # the arr is a CO ...
  end
end

bob = Person.new("Robert")

kitty = Cat.new
bud = Bulldog.new

bob.pets << kitty
bob.pets << bud

bob.pets # => [#<Cat:0x007fd839999620>, #<Bulldog:0x007fd839994ff8>]

# ... but to utilize the relevant collaborating objs, we need to access the arr elems
bob.pets.each do |pet|
  pet.jump
end
