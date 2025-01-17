module Moveable
  attr_accessor :speed, :heading

  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

# the Moveable module contains all common behaviours, and Vehicle adds nothing
# else, so don't really need the Vehicle superclass
class Vehicle
  include Moveable
  # no initialize method here, so look in the Moveable module
end

class WheeledVehicle < Vehicle
  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    super(km_traveled_per_liter, liters_of_fuel_capacity) # look for the initialize method in Vehicle
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
  def initialize(num_propellers=1, num_hulls=1, km_traveled_per_liter, liters_of_fuel_capacity)
    @props = num_propellers
    @hulls = num_hulls
    super(km_traveled_per_liter, liters_of_fuel_capacity) # look for the initialize method in Vehicle
  end

  def range # override the Moveable#range method
    super + 10 # adds 10 to the rtn value of Moveable#range
  end
end

class Catamaran < Boat
end

class Motorboat < Boat
end

p car = Auto.new
p bike = Motorcycle.new
p boat1 = Catamaran.new(2,2,10.0,100.0)
p boat2 = Motorboat.new(7.0,50.0)

p car.range
p bike.range
p boat1.range
p boat2.range
