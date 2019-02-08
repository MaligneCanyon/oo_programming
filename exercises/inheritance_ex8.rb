class Animal
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new
p Cat.ancestors # [Cat, Animal, Object, Kernel, BasicObject]
cat1.color

# the color method is never located
# all of the classes and modules listed by the ::ancestors method are searched
