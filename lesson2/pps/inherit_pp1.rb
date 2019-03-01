class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

teddy = Dog.new
puts teddy.speak  # => "bark!"
puts teddy.swim   # => "swimming!"

freddy = Bulldog.new
puts freddy.speak # => "bark!"
puts freddy.swim  # => "can't swim!"
