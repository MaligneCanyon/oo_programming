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

class Noble
  include Walkable

  attr_reader :title

  def initialize(name, title)
    super(name)
    @title = title
  end

  def walk
    print "#{title} "
    super
  end

  private

  def gait
    "struts"
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

byron = Noble.new("Byron", "Lord")
byron.walk # note: this does not use 'p byron.walk'
# => "Lord Byron struts forward"

p byron.name
# => "Byron"
p byron.title
# => "Lord"
