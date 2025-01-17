class Cat
  # attr_reader :name
  # attr_writer :name
  attr_accessor :name

  def initialize(n)
    @name = n
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
puts kitty.name

kitty.name = 'Luna'
kitty.greet
puts kitty.name
