module Weighable
  # def Weighable.weight # works if called directly outside any class

  def weight # works if called directly by an instance of a class that includes the module
    "what's your weight ?"
  end
end

class Animal; end

class Person < Animal
  include Weighable

  attr_reader :name

  def initialize(name, age)
    @name = name
    @age = age
  end

  def print_name
    puts "your name is #{name}"
  end

  def print_age
    puts "your age is #{get_age}"
  end

  def instance_chk
    puts 'entering the instance method'
    self.class.chk
    puts 'exiting the instance method'
  end

  private

  def self.chk # def'ing a class method as private has no bearing on its use (it's still accessible)
    puts 'entering the class method'
    # there is no way to access bob.name w/i a class method
    puts name # => Person # outputs the ClassName
    # puts type # ???
    puts 'exiting the class method'
  end

  def get_age
    @age
  end
end


bob = Person.new('Bob', 42)
Person.chk
# bob.get_age
bob.print_age
bob.instance_chk

# p Weighable::weight # can call directly if weight def'n prefixed w/ module name
p bob.weight # doesn't work if weight def'n prefixed w/ module name
