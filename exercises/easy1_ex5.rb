class Person
  # attr_writer :first_name, :last_name

  def initialize(first_name, last_name)
    @first_name = first_name.capitalize
    @last_name = last_name.capitalize

    # this works too (uses the setter methods)
    # self.first_name = first_name
    # self.last_name = last_name
  end

  def first_name=(first_name)
    @first_name = first_name.capitalize
  end

  def last_name=(last_name)
    @last_name = last_name.capitalize
  end

  def to_s
    "#{@first_name} #{@last_name}"
  end
end

person = Person.new('john', 'doe')
puts person

# we could cap the first and last names here, to be consistent w/ .initialize,
# but "we should not expect the caller to do it for us"; instead, def custom
# setter methods
person.first_name = 'jane'#.capitalize
person.last_name = 'smith'#.capitalize
puts person

# it may be better to use the attr_writer methods and move the capitalization
# out of initialize and into to_s

# Expected output:
# John Doe
# Jane Smith
