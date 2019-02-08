class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  # def self.light_information
  def self.info
    "I want to turn on the light with a brightness level of super high and a colour of green"
  end
end

# Light.light_information # awkward
p Light.info # better
