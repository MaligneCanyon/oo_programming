class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
    # the following would work too (but would effect any derived class, not
    # just Truck)
    # self.start_engine
  end
end

class Truck < Vehicle
  def initialize(year)
    start_engine
    super
  end

  def start_engine
    puts 'Ready to go!'
  end
end

truck1 = Truck.new(1994)
puts truck1.year

# Expected output:
# Ready to go!
# 1994
