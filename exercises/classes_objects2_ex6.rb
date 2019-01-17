
class Cat
  # can def COLOR inside or outside 'Cat'; inside provides better namespacing
  COLOR = %w(orange blue purple calico)

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name} and I'm a #{COLOR.sample} cat!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
