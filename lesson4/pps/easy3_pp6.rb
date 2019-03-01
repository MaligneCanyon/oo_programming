class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    # self.age += 1
    @age += 1 # can use the instance var directly (rather than the setter method) to chg the var's value
  end
end

kit = Cat.new("kitten")
kit.make_one_year_older
puts kit.age

# "in this case self and @ are the same thing and can be used interchangeably"
