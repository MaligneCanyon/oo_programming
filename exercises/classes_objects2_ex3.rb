class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def identify
    self
  end
end

kitty = Cat.new('Sophie')
p    kitty          #<Cat:0x007ffcea0661b8 @name="Sophie">
p    kitty.identify #<Cat:0x007ffcea0661b8 @name="Sophie">
puts kitty.identify #<Cat:0x007ffcea0661b8>
