class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

# instances of Pizza will have a '@name' instance var (designated by the @ symbol)

p Fruit.new('apple').instance_variables
p Pizza.new('pepperoni').instance_variables
