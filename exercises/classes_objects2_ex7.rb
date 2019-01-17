class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s # redefine to_s
    "I'm #{name}!"
  end
end

kitty = Cat.new('Sophie')
puts kitty # works if to_s is redefined

puts "I'm #{kitty.name}!" # this works too, w/ or w/o redefining to_s
