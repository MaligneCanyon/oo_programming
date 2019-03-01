class Person
  # attr_reader :name # replace w/ custom getter

  def initialize(name)
    @name = name
  end

  def name # custom getter
    # @name # gets mutated !
    # @alt_name = @name # doesn't work; @alt_name refs the same str obj as @name
    @name.clone # @name is not affected
  end
end

person1 = Person.new('James')
# person1.name rtns str obj "James", String#reverse! then mutates it;
# this effectively mutates the @name ivar (from outside the class), even though
# there is no setter method
puts person1.name.reverse! # semaJ
puts person1.name

# Expected output:
# James
