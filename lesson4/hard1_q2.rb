module Fuelable
  # attr_writers for fuel capacity and efficiency are not req'd

  def range
    @fuel_capacity * @fuel_efficiency # can use the instance vars from the classes here
  end
end

class WheeledVehicle
  include Fuelable
  attr_accessor :speed, :heading # could move this to the module too

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

class Catamaran
  include Fuelable

  attr_reader :propeller_count, :hull_count
  attr_accessor :speed, :heading # could move this to the module too

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
    # ... remaining code omitted ...
  end
end

bike = Motorcycle.new
p bike
p bike.range

boat = Catamaran.new(2, 2, 10.0, 50.0)
p boat
p boat.range
