# - in make_one_year_older (or any other instance) method self refers to the calling obj
# - in this case self refers to an instance of the Cat class

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end
