class Cat
  def initialize(type)
    @type = type
  end

  def to_s
    "I am a #{@type} cat"
  end
end

puts Cat.new("tabby")
p Cat.new("tabby")
p Cat.new("tabby").to_s
