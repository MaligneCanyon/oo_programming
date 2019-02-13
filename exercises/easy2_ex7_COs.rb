class Pet
  attr_reader :species, :name

  def initialize(species, name)
    @species = species
    @name = name
  end

  def to_s
    "a #{species} named #{name}" # extracted from print_adoptions
  end
end

class Owner
  attr_accessor :pets
  attr_reader :name

  def initialize(name)
    @name = name
    @pets = [] # a collaborator obj (collaborators are the arr elems)
  end

  # don't need the number_of_pets setter method and instance var
  def number_of_pets
    pets.size
  end
end

class Shelter
  def initialize
    @adoptions = []
  end

  def adopt(owner, pet) # simplified adopt method using a collaborator
    owner.pets << pet
    # the following is not really a list of adoptions ...
    # ... could use an Adoption class and have a specific adoption record for
    # each adoption
    @adoptions << owner unless @adoptions.include?(owner)
  end

  def print_adoptions
    @adoptions.each do |person|
      puts "#{person.name} has adopted the following pets:"
      # person.pets.each { |pet| puts "a #{pet.species} named #{pet.name}" }
      person.pets.each { |pet| puts pet }
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
