class MyClass
  def initialize(name, age)
    @name = name
    @age = age
  end
end

my = MyClass.new('Bob', 42)
p my.instance_variables
p my.instance_variable_get(:@name)
p my.instance_variable_set(:@name, 'Bobby')
