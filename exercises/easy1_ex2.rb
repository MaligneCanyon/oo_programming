class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s # to_s not req'd here unless input is not always a String
  end

  def to_s
    # @name.upcase!
    # "My name is #{@name}."
    "My name is #{@name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)

# original
# puts fluffy.name # => "Fluffy" # calls normal to_s on attr_reader :name (getter method)
# puts fluffy # "My name is FLUFFY" # => calls the re-def'd to_s on the class instance; mutates @name
# puts fluffy.name # => "FLUFFY" # calls normal to_s on attr_reader :name (getter method)
# puts name # => "FLUFFY" # calls normal to_s on (mutated) local var 'name'

# corrected
# puts fluffy.name # => "Fluffy"
# puts fluffy # "My name is FLUFFY" # => calls the re-def'd to_s on the class instance; doesn't mutate @name
# puts fluffy.name # => "Fluffy"
# puts name # => "Fluffy"

name = 42
fluffy = Pet.new(name)
name += 1 # re-assigns local var 'name' to point to numeric obj '43'
puts fluffy.name # => 42
puts fluffy # => My name is 42.
puts fluffy.name # => 42
puts name # => 43 # outside the class, 'name' is simply a local var
