# An instance var is created only when
# - it's def'd in initialize OR
# - when attr_writer (or an explicit setter method) is called
# Otherwise, the instance var does not exist

class MyClass
  # attr_writer :name
  def name=(name)
    @name = name
  end
  # attr_reader :name

  def print_name
    p @name
  end
end

bob = MyClass.new
p bob # => #<MyClass:0x0000000002122378>
bob.print_name # => nil
bob.name = 'Bob' # @name does not exist unless the setter is called
p bob # => #<MyClass:0x0000000002122378 @name="Bob">
bob.print_name # => "Bob"
