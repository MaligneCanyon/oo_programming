# could use a module (or a superclass)
# could also use a (str) constant GAIT in each of the classes and move the
# gait method to the module (or superclass)
module Walkable
  def walk
    puts "#{name} #{gait} forward"
  end

  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Person
  include Walkable

  private

  def gait
    "strolls"
  end
end

class Cat
  include Walkable

  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Walkable

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
