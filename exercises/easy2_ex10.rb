module Walkable
  def walk
    puts "#{name} #{gait} forward"
  end
end

class Person
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Noble < Person
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
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end

mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

byron = Noble.new("Byron", "Lord")
byron.walk # note: this does not use 'p byron.walk' ... why change the implementation here ???
# => "Lord Byron struts forward"

p byron.name
# => "Byron"
p byron.title
# => "Lord"
