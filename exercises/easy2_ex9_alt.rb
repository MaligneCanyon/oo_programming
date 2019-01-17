# arguably,
#   Person is-a type of Animal
#   Cat is-a type of Animal
#   Cheetah is-a type of Cat
# so using inheritance is more appropriate than using a module

class Animal
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def walk
    puts "#{name} #{gait} forward"
  end
end

class Person < Animal
  private

  def gait
    "strolls"
  end
end

class Cat < Animal
  private

  def gait
    "saunters"
  end
end

class Cheetah < Cat
  private

  def gait
    "runs"
  end
end

mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk
# => "Flash runs forward"
