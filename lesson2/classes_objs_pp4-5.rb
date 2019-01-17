# class def'n from ex3, Possible Solution
class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    @first_name, @last_name = parse_name(full_name)
  end

  def name
    "#{first_name} #{last_name}".rstrip
  end

  def name=(full_name)
    self.first_name, self.last_name = parse_name(full_name)
  end

  def compare_name(other) # pp4
    self.name == other.name
  end


  private


  def parse_name(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ''
    return first_name, last_name
  end
end

# bob = Person.new('Robert')
# p bob.name                  # => 'Robert'
# p bob.first_name            # => 'Robert'
# p bob.last_name             # => ''
# p bob.last_name = 'Smith'
# p bob.name                  # => 'Robert Smith'

# bob.name = "John Adams"
# p bob.first_name            # => 'John'
# p bob.last_name             # => 'Adams'

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

# If we're trying to determine whether two objects contain the same name, we can compare them using
p bob.name == rob.name
# Alternately, could create an instance method to compare them
p bob.compare_name(rob)
# We can't compare user-defined objs directly
p bob == rob # => false

# The following outputs the class name and a representation of the object_id (memory addr)
puts "The person's name is: #{bob}"
# The following outputs the expected name 'Robert Smith'; no annoying to_s re-def'n req'd !
puts "The person's name is: #{bob.name}"
# With to_s re-def'd, the following outputs the expected name 'Robert Smith'
def bob.to_s # pp5 # note: to_s is an instance method
  name
end
puts "The person's name is: #{bob}"
