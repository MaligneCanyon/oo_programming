# Using the following code, add the appropriate accessor methods. Keep in mind that the last_name
# getter shouldn't be visible outside the class, while the first_name getter should be visible
#  outside the class.

class Person
  attr_accessor :first_name #, :last_name # this doesn't work
  attr_writer :last_name

  def first_equals_last?
    first_name == last_name
  end

  private
  # @last_name # this doesn't work; instance vars are private in R.
  attr_reader :last_name
end

person1 = Person.new
person1.first_name = 'Dave'
person1.last_name = 'Smith'
puts person1.first_equals_last?
p person1.last_name # NoMethodError

# Expected output:
# false
