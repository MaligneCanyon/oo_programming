class Base
  def show x=0, y=0
    p "x: #{x}, y: #{y}"
  end
end

class Derived < Base
  def show x, y
    super
    super x
    super x, y
    super()
  end
end

d = Derived.new
d.show 3, 3

# "x: 3, y: 3"
# "x: 3, y: 0"
# "x: 3, y: 3"
# "x: 0, y: 0"
