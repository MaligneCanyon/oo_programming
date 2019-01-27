module Fuelable
  # attr_writers for fuel capacity and efficiency are not req'd

  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    # def common instance vars for each of the encompassing classes
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class Vehicle
  include Fuelable
  # no initialize method here, so look in the Fuelable module
end

class WheeledVehicle < Vehicle
  attr_accessor :speed, :heading # could move this to the module too

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    super(km_traveled_per_liter, liters_of_fuel_capacity) # look for the initialize method in Vehicle
    @tires = tire_array
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

class Boat < Vehicle
  attr_accessor :speed, :heading # could move this to the module too
  attr_reader :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    super(km_traveled_per_liter, liters_of_fuel_capacity) # look for the initialize method in Vehicle
    @propeller_count = num_propellers
    @hull_count = num_hulls
  end
end

class Catamaran < Boat
end

class Motorboat < Boat
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

car = Auto.new
p car
p car.range

bike = Motorcycle.new
p bike
p bike.range

cataboat = Catamaran.new(2, 2, 10.0, 50.0)
p cataboat
p cataboat.range

motorboat = Motorboat.new(6.0, 20.0)
p motorboat
p motorboat.range
