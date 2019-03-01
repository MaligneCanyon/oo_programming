class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

module Towable
  def tow
    'I can tow a trailer!'
  end
end

class Truck < Vehicle
  include Towable
  # although the following works, it's not req'd; Vehicle#initialize is used
  # directly if Truck#initialize is not present
  # def initialize(year)
  #   super
  # end
end

class Car < Vehicle
end

truck1 = Truck.new(1994)
puts truck1.year
puts truck1.tow

car1 = Car.new(2006)
puts car1.year

# Expected output:
# 1994
# I can tow a trailer!
# 2006
