module Drivable
  # def self.drive # don't want a class-level method
  def drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive
