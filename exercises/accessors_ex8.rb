class Person
  # attr_reader :name # replace w/ custom version

  def initialize(name)
    @name = name
  end

  def name # custom version
    # @alt_name = @name # doesn't work; @alt_name refs the same str obj as @name
    @name.clone
  end
end

person1 = Person.new('James')
person1.name.reverse! # person1.name rtns str obj "James", String#reverse! then mutates it
puts person1.name # semaJ

# Expected output:
# James
