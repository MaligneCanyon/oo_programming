class Person
  CALL_PRIVATE_METHOD = false
  attr_reader :privately_defined_var

  def public_method
    private_method if CALL_PRIVATE_METHOD
  end

  private
  def private_method
    @privately_defined_var = "abc"
  end
end

person = Person.new


# the value of the privately-defined instance var is only available if the
# private_method has been called in the public_method

# CALL_PRIVATE_METHOD == false
p person # => #<Person:0x0000000137fa90> # @privately_defined_var does not exist
p person.privately_defined_var # => nil
p person.public_method # => nil
p person # => #<Person:0x0000000137fa90>
p person.privately_defined_var # => nil

# CALL_PRIVATE_METHOD == true
p person # => #<Person:0x0000000133b9a8>
p person.privately_defined_var # => nil
p person.public_method # => "abc"
p person # => #<Person:0x0000000133b9a8 @privately_defined_var="abc">
p person.privately_defined_var # => "abc"
