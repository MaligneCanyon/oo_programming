class Pet
  attr_reader :species, :name

  def initialize(species, name)
    @species = species
    @name = name
  end
end

class Owner
  attr_accessor :number_of_pets
  attr_reader :name

  def initialize(name)
    @name = name
    @number_of_pets = 0
  end
end

class Shelter
  # @@adoptions = {} # better to use an instance var (could have > 1 shelter)

  def initialize
    @adoptions = {}
  end

  # adopt method
  # inputs:
  # - obj x2
  # outputs:
  # - none
  # reqs:
  # - save an adoption to a hsh {owner:[pets]}
  #   - hsh has owner name as a key, w/ an arr of pets for the value
  # rules:
  # - none
  # struct:
  # - arr
  # algo:
  # - if the owner.name key exists
  #   - copy the pet obj to the value arr
  # - else
  #   - create a key:value pair

  def adopt(owner, pet)
    if @adoptions.key?(owner.name)
      @adoptions[owner.name] << pet
    else
      @adoptions[owner.name] = [pet]
    end
    # p @adoptions
    owner.number_of_pets += 1
  end

  def print_adoptions
    @adoptions.each do |person, animals|
      puts "#{person} has adopted the following pets:"
      animals.each { |animal| puts "a #{animal.species} named #{animal.name}" }
      puts
    end
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

# P Hanson has adopted the following pets:
# a cat named Butterscotch
# a cat named Pudding
# a bearded dragon named Darwin

# B Holmes has adopted the following pets:
# a dog named Molly
# a parakeet named Sweetie Pie
# a dog named Kennedy
# a fish named Chester

# P Hanson has 3 adopted pets.
# B Holmes has 4 adopted pets.
