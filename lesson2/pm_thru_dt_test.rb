class Bird
  def flying_noise
    flaps
  end

  def flaps
    "flap, flap, flap"
  end
end

class Mosquito
  def flying_noise
    buzzes
  end

  def buzzes
    "buzzzzzzzzzz ..."
  end
end

class Pig
  def flying_noise
    oinks
  end

  def oinks
    "oink, oink, oink"
  end
end

animals = [Bird.new, Mosquito.new, Pig.new]
animals.each do |animal|
  puts "#{animal.flying_noise}"
end
