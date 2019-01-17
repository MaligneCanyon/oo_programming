class Pet
  @@pets = []
  attr_reader :species, :name

  def initialize(species, name)
    @species = species
    @name = name
    @@pets << self # add the Pet obj to the master list of pets
    # p @@pets
  end

  def self.pets
    @@pets
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
    @unadopted = Pet.pets # an arr
  end

  def adopt(owner, pet) # simplified adopt method using a collaborator
    owner.pets << pet
    @adoptions << owner unless @adoptions.include?(owner)
    @unadopted.delete(pet)
    # p "adoptions == #{@adoptions}"
    # p "unadopted == #{@unadopted}"
  end

  def print_adoptions
    @adoptions.each do |person|
      puts "#{person.name} has adopted the following pets:"
      # person.pets.each { |animal| puts "a #{animal.species} named #{animal.name}" }
      person.pets.each { |animal| puts animal }
      puts
    end
  end

  def print_unadopted # slightly dif output than the suggested format
    puts "The animal shelter has #{@unadopted.size} unadopted pets:"
    @unadopted.each { |animal| puts animal }
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

asta         = Pet.new('dog', 'Asta')
laddie       = Pet.new('dog', 'Laddie')
fluffy       = Pet.new('cat', 'Fluffy')
kat          = Pet.new('cat', 'Kat')
ben          = Pet.new('cat', 'Ben')
chatterbox   = Pet.new('parakeet', 'Chatterbox')
bluebell     = Pet.new('parakeet', 'Bluebell')

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

puts
shelter.print_unadopted

# The Animal Shelter has the following unadopted pets:
# a dog named Asta
# a dog named Laddie
# a cat named Fluffy
# a cat named Kat
# a cat named Ben
# a parakeet named Chatterbox
# a parakeet named Bluebell

# The Animal shelter has 7 unadopted pets.
