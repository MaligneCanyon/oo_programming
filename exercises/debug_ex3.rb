# On lines 37 and 38 of our code, we can see that grace and ada are located at the same coordinates. So why
# does line 39 output false? Fix the code to produce the expected output.

class Person
  attr_reader :name
  attr_accessor :location

  def initialize(name)
    @name = name
  end

  def teleport_to(latitude, longitude)
    @location = GeoLocation.new(latitude, longitude)
  end
end

class GeoLocation

  include Comparable # include the Comparable module ...

  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def to_s
    "(#{latitude}, #{longitude})"
  end

  # Note: can't re-def <=> in the Person class, because there are
  # no Person#latitude or Person#longitude methods
  def <=>(other) # ... and re-def the <=> method
    latitude <=> other.latitude && longitude <=> other.longitude
  end
end

# Example

ada = Person.new('Ada')
ada.location = GeoLocation.new(53.477, -2.236)

grace = Person.new('Grace')
grace.location = GeoLocation.new(-33.89, 151.277)

ada.teleport_to(-33.89, 151.277)

puts ada.location                   # (-33.89, 151.277)
puts grace.location                 # (-33.89, 151.277)
puts ada.location == grace.location # expected: true, actual: false
