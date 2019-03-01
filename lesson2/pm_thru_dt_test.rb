class Bird
  def flies_by_flapping
    puts "flap, flap, flap"
  end

  def flying_noise
    flies_by_flapping
  end
end

class Mosquito
  def buzzes_your_ear
    puts "buzzzzzz ..."
  end

  def flying_noise
    buzzes_your_ear
  end
end

flying_animal = [Bird.new, Mosquito.new]
flying_animal.each do |animal|
  animal.flying_noise
end
