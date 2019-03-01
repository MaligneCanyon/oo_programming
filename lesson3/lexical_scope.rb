module Inflatable
  WHEELS = 1

  def inflate
    # puts "You have inflated all #{WHEELS} wheel(s)." # => "You have inflated 1 wheel(s)."
    puts "You have inflated #{self.class::WHEELS} wheel(s)."
  end
end

class Car
  include Inflatable
  WHEELS = 4

  def wheels
    WHEELS # causes problem; refs WHEELS def in the CAR class
  end

  def real_wheels
    self.class::WHEELS # fixes problem
  end
end

class Motorcycle < Car
  WHEELS = 2
end

civic = Car.new
puts 'Car wheels:'
puts civic.wheels # => 4
puts civic.real_wheels # => 4
puts civic.inflate # => "You have inflated 4 wheel(s)."

bullet = Motorcycle.new
puts 'Motorcycle wheels:'
# since the wheels method is def'd in the Car class, R. looks in Car first for
# the WHEELS constant def
puts bullet.wheels # => 4, when you expect the out to be 2
puts bullet.real_wheels # => 2
puts bullet.inflate # => "You have inflated 2 wheel(s)."
