class Box
  attr_reader :width, :height

  def initialize(w, h)
    @width = w
    @height = h
  end

  def bigger_box(other) # there's nothing special about the term 'other'
    Box.new(@width + other.width, @height + other.height)
  end

  def to_s
    "width = #{width}, height = #{height}"
  end
end

box1 = Box.new(10, 5)
box2 = Box.new(20, 10)
puts "box1: #{box1}"
puts "box2: #{box2}"
box3 = box1.bigger_box(box2) # pass an 'other' object (box2) to bigger_box
puts "box3: #{box3}"
