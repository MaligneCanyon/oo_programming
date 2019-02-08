class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def wheels
    self.class::WHEELS
  end

  def to_s
    "#{make} #{model} #{wheels}"
  end
end

class Car < Vehicle
  WHEELS = 4
end

class Motorcycle < Vehicle
  WHEELS = 2
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  WHEELS = 6

  def to_s
    super + " #{payload}"
  end
end

car = Car.new('Ford', 'Mustang')
puts car
motorcycle = Motorcycle.new('Ducati', 'X5000')
puts motorcycle
truck = Truck.new('Nissan', 'Carrier', 2000)
puts truck
