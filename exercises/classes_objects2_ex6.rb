class Cat
  # can def COLOR inside or outside 'Cat'; inside provides better namespacing
  COLOUR = %w(orange blue purple calico)

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{@name} and I'm a #{COLOUR.sample} cat!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
