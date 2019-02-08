class Person
  # attr_accessor :name

  def name=(name)
    @first, @last = name.split
  end

  def name
    @first + ' ' + @last
    # "#{@first} #{@last}"
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
