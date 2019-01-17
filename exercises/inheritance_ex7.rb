class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new('Black')
p Cat.ancestors # [Cat, Animal, Object, Kernel, BasicObject]
cat1.color

# when the color method is located, R. stops searching, so only Cat and Animal
# are searched
