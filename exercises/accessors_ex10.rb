# class Person
#   attr_accessor :name
# end

class Person
  def name= (name)
    @first, @second = name.split(' ') # split the fullname into 2 instance vars
  end

  def name
    "#{@first} #{@second}" # rejoin the instance vars
  end

  def first_name # just for fun
    @first
  end

  def missing_name # just for fun
    @name
  end
end


person1 = Person.new
person1.name = 'John Doe'
puts person1.name
puts person1.first_name # 'John'
p person1.missing_name # nil # instance var @name was never created

# Expected output:
# John Doe
