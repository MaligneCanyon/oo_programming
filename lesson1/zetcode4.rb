class MyClass
  attr_reader :a, :b

  def initialize(aa, bb)
    @a = aa
    @b = bb
  end

  def adding_method
    a + b
  end

  def an_other_method(other)
    self.adding_method + other.adding_method
  end
end

my_obj = MyClass.new(1, 2)
my_other_obj = MyClass.new(5, 6)
p my_obj.adding_method # => 3
p my_obj.an_other_method(my_other_obj) # => 14
