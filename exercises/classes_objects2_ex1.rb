class Cat
  def self.generic_greeting
    # puts "Hello! I'm a cat!"
    # puts "Hello! I'm a #{self}!" # 'Cat' is capitalized
    puts "Hello! I'm a #{self.name.downcase}!"
  end
end

Cat.generic_greeting
kitty = Cat.new

# kitty.generic_greeting # => NoMethodError
p kitty.class # => Cat
kitty.class.generic_greeting # equiv to calling 'Cat.generic_greeting'
