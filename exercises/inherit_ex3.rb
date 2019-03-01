class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
  # be careful about the type of attr_* you use, use the most restrictive one
  # that will still provide the desired fn'ality
  attr_reader :bed_type

  def initialize(year, bed_type)
    super(year)
    @bed_type = bed_type
  end
end

class Car < Vehicle
end

truck1 = Truck.new(1994, 'Short')
puts truck1.year
puts truck1.bed_type # only need the reader method, not the setter one

# Expected output:
# 1994
# Short

car1 = Car.new(2006)
puts car1.year # 2006
car1 = Car.new(1881, 'Non-existent') # ArgumentError
