class Person
  attr_reader :first_name
  attr_accessor :last_name

  def initialize(f_name, l_name = '')
    @first_name = f_name
    @last_name = l_name
  end

  def name
    # @last_name.empty? ? @first_name : @first_name + ' ' + @last_name
    (@first_name + ' ' + @last_name).rstrip
  end
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'
