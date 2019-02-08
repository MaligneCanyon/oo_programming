# - to create an instance of the Bag class, need to call the .new class method
#   and pass it two args

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

p Bag.new('blue', :cotton)
