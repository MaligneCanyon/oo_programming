class Pet
  attr_reader :species, :name

  def initialize(species, name)
    @species = species
    @name = name
  end

  def to_s
    "a #{species} named #{name}"
  end
end

class Owner
  attr_reader :name
  attr_reader :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def number_of_pets
    pets.size
  end
end

class Shelter
  def initialize
    @adoptions = []
  end

  def adopt(owner, pet)
    owner.pets << pet
    @adoptions << Adoption.new(owner.name, pet)
  end

  def print_adoptions
    adoptions_by_owner = {}
    @adoptions.each do |adoption|
      if adoptions_by_owner.key?(adoption.owner_name)
        adoptions_by_owner[adoption.owner_name] << adoption.pet
      else
        adoptions_by_owner[adoption.owner_name] = [adoption.pet]
      end
    end

    adoptions_by_owner.each do |person, pets|
      puts "#{person} has adopted the following pets:"
      pets.each { |pet| puts pet }
      puts
    end
  end
end

class Adoption
  attr_reader :owner_name, :pet

  def initialize(owner_name, pet)
    @owner_name = owner_name
    @pet = pet
    @date = Time.now
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
