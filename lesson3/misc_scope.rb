module Weighable
  def Weighable.weight # works if called directly outside any class
    "what's your class weight ?"
  end

  def weight # works if called directly by an instance of a class that includes the module
    "what's your instance weight ?"
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
    puts "your age is #{age}"
  end

  def instance_chk
    puts 'entering the instance method'
    self.class.chk
    puts 'exiting the instance method'
  end

  private

  attr_reader :age

  def self.chk # def'ing a class method as private has no bearing on its use (it's still accessible)
    puts 'entering the class method'
    # there is no way to access bob.name w/i a class method
    puts name # => Person # outputs the ClassName
    # puts type # ???
    puts 'exiting the class method'
  end
end


bob = Person.new('Bob', 42)
p bob.weight
p Weighable::weight # can call directly if weight def'n prefixed w/ module name
p Weighable.weight # don't need to use ::

Person.chk
bob.instance_chk
bob.print_age
bob.age # NoMethodError (the age getter is private)
