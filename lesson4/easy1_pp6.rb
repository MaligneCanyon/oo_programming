# - instance vars are accessed thru methods
# - add a public method that print the value of @volume

class Cube
  def initialize(volume)
    @volume = volume
  end

  def print_vol
    puts @volume
  end
end

cubit = Cube.new(10)
cubit.print_vol

# alt:
p cubit.instance_variable_get('@volume')
