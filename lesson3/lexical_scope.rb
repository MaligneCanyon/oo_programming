class Car
  WHEELS = 4

  def wheels
    WHEELS # causes problem
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

bullet = Motorcycle.new
puts 'Motorcycle wheels:'
puts bullet.wheels # => 4, when you expect the out to be 2
puts bullet.real_wheels # => 2
