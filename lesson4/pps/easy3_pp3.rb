# - create instances of the class by calling the new class method on the class, passing in two args

class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

AngryCat.new(3, 'Cuddles')
AngryCat.new(14, 'Old Scratcher')
