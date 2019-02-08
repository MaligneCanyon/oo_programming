# polymorphism: each derived class implements the make_noise method differently

class Animal
  def make_noise
    "Some #{self.class.name.downcase} noise."
  end

  def sleep
    puts "#{self.class.name} is sleeping."
  end
end

class Dog < Animal
  def make_noise # overrides the Animal#make_noise method
    'Woof!'
  end
end

class Cat < Animal
  def make_noise
    'Meow!'
  end
end

[Animal.new, Dog.new, Cat.new].each do |animal|
  puts animal.make_noise
  animal.sleep
end

p Math::PI # => 3.14...
# p PI # => NameError
include Math
p PI # => 3.14...
