class Person
  # attr_reader :first_name # must use attr_writer if using 'self' in name=
  attr_accessor :last_name, :first_name

  def initialize(f_name, l_name = '')
    @first_name = f_name
    @last_name = l_name
  end

  def name
    # @last_name.empty? ? @first_name : @first_name + ' ' + @last_name
    (@first_name + ' ' + @last_name).rstrip
  end

  def name=(name) # setter
    @name = name
    # @first_name, @last_name = @name.split(' ')
    # @last_name ||= ''
    self.first_name, self.last_name = @name.split(' ') # reqs attr_writer for :first_name
    self.last_name ||= ''
  end
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
p bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'
