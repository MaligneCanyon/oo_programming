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
# bob.name = 'Bob' # @name does not exist unless the setter is called
p bob
bob.print_name
