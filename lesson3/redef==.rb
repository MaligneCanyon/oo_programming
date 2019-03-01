# "By defining a == method in our Person class, we're overriding the default
# BasicObject#== behavior, and providing a much more meaningful way to compare
# two Person objects"; can override > and < as well.

class Person
  attr_accessor :name

  def ==(other)
    name == other.name # uses String#== for comparison
  end
end

bob = Person.new
bob.name = "bob"

bob2 = Person.new
bob2.name = "bob"

bob == bob2 # => true
