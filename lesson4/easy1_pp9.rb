- when self is used in the def of a method, it indicates that we are def'ing a class method
- in this context, self refers to the class itself
- in this example, self refers to Cat class

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

