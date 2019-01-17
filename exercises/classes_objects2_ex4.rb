class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.generic_greeting # 'self' refers to the calling obj (the class itself w/i a class method)
    puts "Hello! I'm a cat!"
    puts "Hello #{self}."
  end

  def personal_greeting # 'name' is a reader method here, so using 'self' is optional
    puts "Hello! My name is #{name}!"
    puts "Hi #{self.name}."
  end
end

kitty = Cat.new('Sophie')

Cat.generic_greeting
kitty.personal_greeting
